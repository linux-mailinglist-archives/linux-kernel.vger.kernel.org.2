Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC6938F76D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 03:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbhEYBQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 21:16:38 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:3933 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbhEYBQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 21:16:37 -0400
Received: from dggems703-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FpwzM13ZQzBw2R;
        Tue, 25 May 2021 09:12:15 +0800 (CST)
Received: from dggemx753-chm.china.huawei.com (10.0.44.37) by
 dggems703-chm.china.huawei.com (10.3.19.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Tue, 25 May 2021 09:15:06 +0800
Received: from [10.136.110.154] (10.136.110.154) by
 dggemx753-chm.china.huawei.com (10.0.44.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Tue, 25 May 2021 09:15:05 +0800
Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: support RO feature
To:     Jaegeuk Kim <jaegeuk@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20210521190217.2484099-1-jaegeuk@kernel.org>
 <20210521190217.2484099-2-jaegeuk@kernel.org>
 <b1647bd1-f719-5796-4f99-766f0bc66d49@huawei.com>
 <YKvdQbA1+kdD3jQC@google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <52bf2f86-58c3-c012-9f73-d34fcd7dd3a8@huawei.com>
Date:   Tue, 25 May 2021 09:15:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <YKvdQbA1+kdD3jQC@google.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.110.154]
X-ClientProxiedBy: dggemx702-chm.china.huawei.com (10.1.199.49) To
 dggemx753-chm.china.huawei.com (10.0.44.37)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/5/25 1:07, Jaegeuk Kim wrote:
> On 05/24, Chao Yu wrote:
>> On 2021/5/22 3:02, Jaegeuk Kim wrote:
>>> Given RO feature in superblock, we don't need to check provisioning/reserve
>>> spaces and SSA area.
>>
>> Cool, any solution to update files of ro f2fs image if there is such
>> scenario?
> 
> Hmm, overlayfs?

I mean using f2fs-tools, maybe...

Thanks,

> 
>>
>>>
>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>>> ---
>>>    fs/f2fs/f2fs.h    |  2 ++
>>>    fs/f2fs/segment.c |  3 +++
>>>    fs/f2fs/super.c   | 35 +++++++++++++++++++++++++++++++----
>>>    3 files changed, 36 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>>> index c0bead0df66a..2c6913261586 100644
>>> --- a/fs/f2fs/f2fs.h
>>> +++ b/fs/f2fs/f2fs.h
>>> @@ -168,6 +168,7 @@ struct f2fs_mount_info {
>>>    #define F2FS_FEATURE_SB_CHKSUM		0x0800
>>>    #define F2FS_FEATURE_CASEFOLD		0x1000
>>>    #define F2FS_FEATURE_COMPRESSION	0x2000
>>> +#define F2FS_FEATURE_RO			0x4000
>>>    #define __F2FS_HAS_FEATURE(raw_super, mask)				\
>>>    	((raw_super->feature & cpu_to_le32(mask)) != 0)
>>> @@ -939,6 +940,7 @@ static inline void set_new_dnode(struct dnode_of_data *dn, struct inode *inode,
>>>    #define	NR_CURSEG_DATA_TYPE	(3)
>>>    #define NR_CURSEG_NODE_TYPE	(3)
>>>    #define NR_CURSEG_INMEM_TYPE	(2)
>>> +#define NR_CURSEG_RO_TYPE	(2)
>>>    #define NR_CURSEG_PERSIST_TYPE	(NR_CURSEG_DATA_TYPE + NR_CURSEG_NODE_TYPE)
>>>    #define NR_CURSEG_TYPE		(NR_CURSEG_INMEM_TYPE + NR_CURSEG_PERSIST_TYPE)
>>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>>> index 8668df7870d0..67cec8f858a2 100644
>>> --- a/fs/f2fs/segment.c
>>> +++ b/fs/f2fs/segment.c
>>> @@ -4674,6 +4674,9 @@ static int sanity_check_curseg(struct f2fs_sb_info *sbi)
>>>    {
>>>    	int i;
>>> +	if (__F2FS_HAS_FEATURE(sbi->raw_super, F2FS_FEATURE_RO))
>>
>> Why not using F2FS_HAS_FEATURE(sbi, F2FS_FEATURE_RO))?
> 
> Oh, updated.
> 
>>
>> Ditto for all below __F2FS_HAS_FEATURE().
>>
>> Thanks,
>>
>>> +		return 0;
>>> +
>>>    	/*
>>>    	 * In LFS/SSR curseg, .next_blkoff should point to an unused blkaddr;
>>>    	 * In LFS curseg, all blkaddr after .next_blkoff should be unused.
>>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>>> index b29de80ab60e..312bfab54693 100644
>>> --- a/fs/f2fs/super.c
>>> +++ b/fs/f2fs/super.c
>>> @@ -1819,7 +1819,11 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
>>>    static void default_options(struct f2fs_sb_info *sbi)
>>>    {
>>>    	/* init some FS parameters */
>>> -	F2FS_OPTION(sbi).active_logs = NR_CURSEG_PERSIST_TYPE;
>>> +	if (__F2FS_HAS_FEATURE(sbi->raw_super, F2FS_FEATURE_RO))
>>> +		F2FS_OPTION(sbi).active_logs = NR_CURSEG_RO_TYPE;
>>> +	else
>>> +		F2FS_OPTION(sbi).active_logs = NR_CURSEG_PERSIST_TYPE;
>>> +
>>>    	F2FS_OPTION(sbi).inline_xattr_size = DEFAULT_INLINE_XATTR_ADDRS;
>>>    	F2FS_OPTION(sbi).whint_mode = WHINT_MODE_OFF;
>>>    	F2FS_OPTION(sbi).alloc_mode = ALLOC_MODE_DEFAULT;
>>> @@ -1994,6 +1998,11 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
>>>    	err = parse_options(sb, data, true);
>>>    	if (err)
>>>    		goto restore_opts;
>>> +
>>> +	if (__F2FS_HAS_FEATURE(sbi->raw_super, F2FS_FEATURE_RO) &&
>>> +					!(*flags & SB_RDONLY))
>>> +		goto restore_opts;
>>> +
>>>    	checkpoint_changed =
>>>    			disable_checkpoint != test_opt(sbi, DISABLE_CHECKPOINT);
>>> @@ -3137,16 +3146,18 @@ int f2fs_sanity_check_ckpt(struct f2fs_sb_info *sbi)
>>>    	ovp_segments = le32_to_cpu(ckpt->overprov_segment_count);
>>>    	reserved_segments = le32_to_cpu(ckpt->rsvd_segment_count);
>>> +	if (__F2FS_HAS_FEATURE(sbi->raw_super, F2FS_FEATURE_RO))
>>> +		goto no_reserved;
>>>    	if (unlikely(fsmeta < F2FS_MIN_META_SEGMENTS ||
>>>    			ovp_segments == 0 || reserved_segments == 0)) {
>>>    		f2fs_err(sbi, "Wrong layout: check mkfs.f2fs version");
>>>    		return 1;
>>>    	}
>>> -
>>> +no_reserved:
>>>    	user_block_count = le64_to_cpu(ckpt->user_block_count);
>>>    	segment_count_main = le32_to_cpu(raw_super->segment_count_main);
>>>    	log_blocks_per_seg = le32_to_cpu(raw_super->log_blocks_per_seg);
>>> -	if (!user_block_count || user_block_count >=
>>> +	if (!user_block_count || user_block_count >
>>>    			segment_count_main << log_blocks_per_seg) {
>>>    		f2fs_err(sbi, "Wrong user_block_count: %u",
>>>    			 user_block_count);
>>> @@ -3175,6 +3186,10 @@ int f2fs_sanity_check_ckpt(struct f2fs_sb_info *sbi)
>>>    		if (le32_to_cpu(ckpt->cur_node_segno[i]) >= main_segs ||
>>>    			le16_to_cpu(ckpt->cur_node_blkoff[i]) >= blocks_per_seg)
>>>    			return 1;
>>> +
>>> +		if (__F2FS_HAS_FEATURE(sbi->raw_super, F2FS_FEATURE_RO))
>>> +			goto check_data;
>>> +
>>>    		for (j = i + 1; j < NR_CURSEG_NODE_TYPE; j++) {
>>>    			if (le32_to_cpu(ckpt->cur_node_segno[i]) ==
>>>    				le32_to_cpu(ckpt->cur_node_segno[j])) {
>>> @@ -3185,10 +3200,15 @@ int f2fs_sanity_check_ckpt(struct f2fs_sb_info *sbi)
>>>    			}
>>>    		}
>>>    	}
>>> +check_data:
>>>    	for (i = 0; i < NR_CURSEG_DATA_TYPE; i++) {
>>>    		if (le32_to_cpu(ckpt->cur_data_segno[i]) >= main_segs ||
>>>    			le16_to_cpu(ckpt->cur_data_blkoff[i]) >= blocks_per_seg)
>>>    			return 1;
>>> +
>>> +		if (__F2FS_HAS_FEATURE(sbi->raw_super, F2FS_FEATURE_RO))
>>> +			goto skip_cross;
>>> +
>>>    		for (j = i + 1; j < NR_CURSEG_DATA_TYPE; j++) {
>>>    			if (le32_to_cpu(ckpt->cur_data_segno[i]) ==
>>>    				le32_to_cpu(ckpt->cur_data_segno[j])) {
>>> @@ -3210,7 +3230,7 @@ int f2fs_sanity_check_ckpt(struct f2fs_sb_info *sbi)
>>>    			}
>>>    		}
>>>    	}
>>> -
>>> +skip_cross:
>>>    	sit_bitmap_size = le32_to_cpu(ckpt->sit_ver_bitmap_bytesize);
>>>    	nat_bitmap_size = le32_to_cpu(ckpt->nat_ver_bitmap_bytesize);
>>> @@ -3703,6 +3723,13 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
>>>    	if (err)
>>>    		goto free_options;
>>> +	if (__F2FS_HAS_FEATURE(sbi->raw_super, F2FS_FEATURE_RO) &&
>>> +					!f2fs_readonly(sbi->sb)) {
>>> +		f2fs_info(sbi, "Allow to mount readonly mode only");
>>> +		err = -EINVAL;
>>> +		goto free_options;
>>> +	}
>>> +
>>>    	sb->s_maxbytes = max_file_blocks(NULL) <<
>>>    				le32_to_cpu(raw_super->log_blocksize);
>>>    	sb->s_max_links = F2FS_LINK_MAX;
>>>
> .
> 
