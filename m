Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94A6E36BD90
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 04:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234182AbhD0C5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 22:57:19 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3533 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbhD0C5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 22:57:18 -0400
Received: from dggemx753-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4FTmZ04RN7zYdr7;
        Tue, 27 Apr 2021 10:54:16 +0800 (CST)
Received: from [10.136.110.154] (10.136.110.154) by
 dggemx753-chm.china.huawei.com (10.0.44.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Tue, 27 Apr 2021 10:56:32 +0800
Subject: Re: [PATCH v2] f2fs: reduce expensive checkpoint trigger frequency
To:     Jaegeuk Kim <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Yunlei He <heyunlei@hihonor.com>
References: <20210425011053.44436-1-yuchao0@huawei.com>
 <YIbzwPGOJoKZvFnv@google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <3338f2bc-6985-c1a4-9f3d-e59a474027f9@huawei.com>
Date:   Tue, 27 Apr 2021 10:56:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <YIbzwPGOJoKZvFnv@google.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.110.154]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggemx753-chm.china.huawei.com (10.0.44.37)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/4/27 1:09, Jaegeuk Kim wrote:
> On 04/25, Chao Yu wrote:
>> We may trigger high frequent checkpoint for below case:
>> 1. mkdir /mnt/dir1; set dir1 encrypted
>> 2. touch /mnt/file1; fsync /mnt/file1
>> 3. mkdir /mnt/dir2; set dir2 encrypted
>> 4. touch /mnt/file2; fsync /mnt/file2
>> ...
>>
>> Although, newly created dir and file are not related, due to
>> commit bbf156f7afa7 ("f2fs: fix lost xattrs of directories"), we will
>> trigger checkpoint whenever fsync() comes after a new encrypted dir
>> created.
>>
>> In order to avoid such condition, let's record an entry including
>> directory's ino into global cache when we initialize encryption policy
>> in a checkpointed directory, and then only trigger checkpoint() when
>> target file's parent has non-persisted encryption policy, for the case
>> its parent is not checkpointed, need_do_checkpoint() has cover that
>> by verifying it with f2fs_is_checkpointed_node().
>>
>> Reported-by: Yunlei He <heyunlei@hihonor.com>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>> v2:
>> - fix to set ENC_DIR_INO only for encrypted directory
>>   fs/f2fs/f2fs.h              | 2 ++
>>   fs/f2fs/file.c              | 3 +++
>>   fs/f2fs/xattr.c             | 6 ++++--
>>   include/trace/events/f2fs.h | 3 ++-
>>   4 files changed, 11 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>> index b9d5317db0a7..0fe881309a20 100644
>> --- a/fs/f2fs/f2fs.h
>> +++ b/fs/f2fs/f2fs.h
>> @@ -246,6 +246,7 @@ enum {
>>   	APPEND_INO,		/* for append ino list */
>>   	UPDATE_INO,		/* for update ino list */
>>   	TRANS_DIR_INO,		/* for trasactions dir ino list */
>> +	ENC_DIR_INO,		/* for encrypted dir ino list */
>>   	FLUSH_INO,		/* for multiple device flushing */
>>   	MAX_INO_ENTRY,		/* max. list */
>>   };
>> @@ -1090,6 +1091,7 @@ enum cp_reason_type {
>>   	CP_FASTBOOT_MODE,
>>   	CP_SPEC_LOG_NUM,
>>   	CP_RECOVER_DIR,
>> +	CP_ENC_DIR,
>>   };
>>   
>>   enum iostat_type {
>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>> index a595050c56d3..62af29ec0879 100644
>> --- a/fs/f2fs/file.c
>> +++ b/fs/f2fs/file.c
>> @@ -218,6 +218,9 @@ static inline enum cp_reason_type need_do_checkpoint(struct inode *inode)
>>   		f2fs_exist_written_data(sbi, F2FS_I(inode)->i_pino,
>>   							TRANS_DIR_INO))
>>   		cp_reason = CP_RECOVER_DIR;
>> +	else if (f2fs_exist_written_data(sbi, F2FS_I(inode)->i_pino,
>> +							ENC_DIR_INO))
>> +		cp_reason = CP_ENC_DIR;
>>   
>>   	return cp_reason;
>>   }
>> diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
>> index c8f34decbf8e..70615d504f7e 100644
>> --- a/fs/f2fs/xattr.c
>> +++ b/fs/f2fs/xattr.c
>> @@ -630,6 +630,7 @@ static int __f2fs_setxattr(struct inode *inode, int index,
>>   			const char *name, const void *value, size_t size,
>>   			struct page *ipage, int flags)
>>   {
>> +	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>>   	struct f2fs_xattr_entry *here, *last;
>>   	void *base_addr, *last_base_addr;
>>   	int found, newsize;
>> @@ -745,8 +746,9 @@ static int __f2fs_setxattr(struct inode *inode, int index,
>>   			!strcmp(name, F2FS_XATTR_NAME_ENCRYPTION_CONTEXT))
>>   		f2fs_set_encrypted_inode(inode);
>>   	f2fs_mark_inode_dirty_sync(inode, true);
>> -	if (!error && S_ISDIR(inode->i_mode))
>> -		set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_CP);
>> +	if (!error && S_ISDIR(inode->i_mode) && f2fs_encrypted_file(inode) &&
>> +			f2fs_is_checkpointed_node(sbi, inode->i_ino))
>> +		f2fs_add_ino_entry(sbi, inode->i_ino, ENC_DIR_INO);
> 
> What will happen, if we need to checkpoint xattr_nid on this directory?

need_do_checkpoint()

a)	else if (!f2fs_is_checkpointed_node(sbi, F2FS_I(inode)->i_pino))
		cp_reason = CP_NODE_NEED_CP;

b)	else if (f2fs_exist_written_data(sbi, F2FS_I(inode)->i_pino,
							ENC_DIR_INO))
		cp_reason = CP_ENC_DIR;

If parent is not checkpointed, after converting parent to encrypted directory
and create the file in parent, fsync this file will trigger checkpoint() due
to a)

If parent is checkpointed, after converting parent to encrypted directory
and create the file in parent, fsync this file will trigger checkpoint() due
to b)

Am I missing any cases?

Thanks,

> 
>>   
>>   same:
>>   	if (is_inode_flag_set(inode, FI_ACL_MODE)) {
>> diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
>> index 56b113e3cd6a..ca0cf12226e9 100644
>> --- a/include/trace/events/f2fs.h
>> +++ b/include/trace/events/f2fs.h
>> @@ -145,7 +145,8 @@ TRACE_DEFINE_ENUM(CP_RESIZE);
>>   		{ CP_NODE_NEED_CP,	"node needs cp" },		\
>>   		{ CP_FASTBOOT_MODE,	"fastboot mode" },		\
>>   		{ CP_SPEC_LOG_NUM,	"log type is 2" },		\
>> -		{ CP_RECOVER_DIR,	"dir needs recovery" })
>> +		{ CP_RECOVER_DIR,	"dir needs recovery" },		\
>> +		{ CP_ENC_DIR,		"persist encryption policy" })
>>   
>>   #define show_shutdown_mode(type)					\
>>   	__print_symbolic(type,						\
>> -- 
>> 2.29.2
> .
> 
