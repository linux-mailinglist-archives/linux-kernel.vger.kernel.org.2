Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A23E36808C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 14:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236276AbhDVMfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 08:35:47 -0400
Received: from zg8tmty1ljiyny4xntqumjca.icoremail.net ([165.227.154.27]:55352
        "HELO zg8tmty1ljiyny4xntqumjca.icoremail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S230510AbhDVMfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 08:35:45 -0400
Received: from [10.115.17.59] (unknown [198.19.131.33])
        by front-2 (Coremail) with SMTP id DAGowAB3Ndx5bYFgNDYXAA--.6050S3;
        Thu, 22 Apr 2021 20:35:05 +0800 (CST)
Subject: Re: [RFC PATCH] f2fs: reduce expensive checkpoint trigger frequency
To:     Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, chao@kernel.org
References: <20210416095838.29568-1-yuchao0@huawei.com>
 <YID2TOCsgKdi0aLf@google.com>
 <733ba2da-4047-045b-5223-05012b980603@huawei.com>
From:   heyunlei 00015531 <heyunlei@hihonor.com>
Message-ID: <a58dc4a1-b2b7-8446-d2de-14fffee36852@hihonor.com>
Date:   Thu, 22 Apr 2021 20:35:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <733ba2da-4047-045b-5223-05012b980603@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DAGowAB3Ndx5bYFgNDYXAA--.6050S3
X-Coremail-Antispam: 1UD129KBjvJXoWxKry7Zr43XFyUtr4UZFy7KFg_yoWxGw1rpr
        n5JFyUGrW5Cr1kWr10qF1UXryUtryUGw1UJr1UJF18Jw47Jr10gr1jqr1q9F1UJr48Jw1U
        Xr1jqry7ZrnxJF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvvb7Iv0xC_tr1lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
        cIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2
        AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v2
        6rxl6s0DM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
        xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
        6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv67AKxVW0oVWYowAm72CE4IkC6x0Yz7v_Jr
        0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCY02Avz4vE-syl42xK82IY
        c2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW5ur1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
        1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
        14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
        IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E
        87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73Uj
        IFyTuYvjxU25EfUUUUU
X-CM-SenderInfo: pkh130hohlqxxlkr003uof0z/1tbiAQMBEV3ki9KwEwABsQ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/4/22 15:14, Chao Yu 写道:
> On 2021/4/22 12:06, Jaegeuk Kim wrote:
>> On 04/16, Chao Yu wrote:
>>> We may trigger high frequent checkpoint for below case:
>>> 1. mkdir /mnt/dir1; set dir1 encrypted
>>> 2. touch /mnt/file1; fsync /mnt/file1
>>> 3. mkdir /mnt/dir2; set dir2 encrypted
>>> 4. touch /mnt/file2; fsync /mnt/file2
>>> ...
>>>
>>> Although, newly created dir and file are not related, due to
>>> commit bbf156f7afa7 ("f2fs: fix lost xattrs of directories"), we will
>>> trigger checkpoint whenever fsync() comes after a new encrypted dir
>>> created.
>>
>> It'll happen once? How much impact will we hit due to this?
>
> Yunlei reports me this issue, the problems here in Honer device's 
> specified
> environment, most fsync() on regular file triggers a checkpoint() when 
> mkdir()
> happened concurrently, result in causing the performance issue.
>
> Yunlei could explain more about details of this issue. @Yunlei

Hi all，

     Many apps launch will create new directories，which will set need 
checkpoint flag because

inherited  crypto info from their parent. During this time,  any 
fsynced  will write a new cp.

For the worst case:

     new dir1

                     fsync file a  (with no relations with dir1), and 
write cp  n

     new dir 2

                     fsync file b (with no relations with dir2), and 
write cp n + 1

     ... ...


Thanks.

>
>>
>>>
>>> In order to avoid such condition, let's record an entry including
>>> directory's ino into global cache when we initialize encryption policy
>>> in a checkpointed directory, and then only trigger checkpoint() when
>>> target file's parent has non-persisted encryption policy, for the case
>>> its parent is not checkpointed, need_do_checkpoint() has cover that
>>> by verifying it with f2fs_is_checkpointed_node().
>>>
>>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>>> ---
>>>   fs/f2fs/f2fs.h              | 2 ++
>>>   fs/f2fs/file.c              | 3 +++
>>>   fs/f2fs/xattr.c             | 6 ++++--
>>>   include/trace/events/f2fs.h | 3 ++-
>>>   4 files changed, 11 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>>> index 87d734f5589d..34487e527d12 100644
>>> --- a/fs/f2fs/f2fs.h
>>> +++ b/fs/f2fs/f2fs.h
>>> @@ -246,6 +246,7 @@ enum {
>>>       APPEND_INO,        /* for append ino list */
>>>       UPDATE_INO,        /* for update ino list */
>>>       TRANS_DIR_INO,        /* for trasactions dir ino list */
>>> +    ENC_DIR_INO,        /* for encrypted dir ino list */
>>>       FLUSH_INO,        /* for multiple device flushing */
>>>       MAX_INO_ENTRY,        /* max. list */
>>>   };
>>> @@ -1090,6 +1091,7 @@ enum cp_reason_type {
>>>       CP_FASTBOOT_MODE,
>>>       CP_SPEC_LOG_NUM,
>>>       CP_RECOVER_DIR,
>>> +    CP_ENC_DIR,
>>>   };
>>>     enum iostat_type {
>>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>>> index 6284b2f4a60b..a6c38d8b1ec3 100644
>>> --- a/fs/f2fs/file.c
>>> +++ b/fs/f2fs/file.c
>>> @@ -218,6 +218,9 @@ static inline enum cp_reason_type 
>>> need_do_checkpoint(struct inode *inode)
>>>           f2fs_exist_written_data(sbi, F2FS_I(inode)->i_pino,
>>>                               TRANS_DIR_INO))
>>>           cp_reason = CP_RECOVER_DIR;
>>> +    else if (f2fs_exist_written_data(sbi, F2FS_I(inode)->i_pino,
>>> +                            ENC_DIR_INO))
>>> +        cp_reason = CP_ENC_DIR;
>>>         return cp_reason;
>>>   }
>>> diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
>>> index c8f34decbf8e..38796d488d15 100644
>>> --- a/fs/f2fs/xattr.c
>>> +++ b/fs/f2fs/xattr.c
>>> @@ -630,6 +630,7 @@ static int __f2fs_setxattr(struct inode *inode, 
>>> int index,
>>>               const char *name, const void *value, size_t size,
>>>               struct page *ipage, int flags)
>>>   {
>>> +    struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>>>       struct f2fs_xattr_entry *here, *last;
>>>       void *base_addr, *last_base_addr;
>>>       int found, newsize;
>>> @@ -745,8 +746,9 @@ static int __f2fs_setxattr(struct inode *inode, 
>>> int index,
>>>               !strcmp(name, F2FS_XATTR_NAME_ENCRYPTION_CONTEXT))
>>>           f2fs_set_encrypted_inode(inode);
>>>       f2fs_mark_inode_dirty_sync(inode, true);
>>> -    if (!error && S_ISDIR(inode->i_mode))
>>> -        set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_CP);
>>> +    if (!error && S_ISDIR(inode->i_mode) &&
>>> +            f2fs_is_checkpointed_node(sbi, inode->i_ino))
>>> +        f2fs_add_ino_entry(sbi, inode->i_ino, ENC_DIR_INO);
>>
>> Is it right to say ENC_DIR_INO in this case?
>
> Sorry, I didn't get it.
>
> Thanks,
>
>>
>>>     same:
>>>       if (is_inode_flag_set(inode, FI_ACL_MODE)) {
>>> diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
>>> index 56b113e3cd6a..ca0cf12226e9 100644
>>> --- a/include/trace/events/f2fs.h
>>> +++ b/include/trace/events/f2fs.h
>>> @@ -145,7 +145,8 @@ TRACE_DEFINE_ENUM(CP_RESIZE);
>>>           { CP_NODE_NEED_CP,    "node needs cp" },        \
>>>           { CP_FASTBOOT_MODE,    "fastboot mode" },        \
>>>           { CP_SPEC_LOG_NUM,    "log type is 2" },        \
>>> -        { CP_RECOVER_DIR,    "dir needs recovery" })
>>> +        { CP_RECOVER_DIR,    "dir needs recovery" },        \
>>> +        { CP_ENC_DIR,        "persist encryption policy" })
>>>     #define show_shutdown_mode(type)                    \
>>>       __print_symbolic(type,                        \
>>> -- 
>>> 2.29.2
>> .
>>

