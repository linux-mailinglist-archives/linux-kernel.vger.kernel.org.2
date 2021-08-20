Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1E53F2A6B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 12:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238127AbhHTK5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 06:57:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:37622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237262AbhHTK5a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 06:57:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8159760FE8;
        Fri, 20 Aug 2021 10:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629457013;
        bh=tnUmwMltPe76cnpXJs1vDwlS3q+06ae8aUx6mQce/hM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=pQZzy2u3CwuIRLosI8sJkJL3l1HKpF4kyLfHTeG/RnIA4T27G/j+mEXGnkm0Ww4vf
         4KL5w3WYLP9iz7LrHNaTM1yCBc0aY/f9+bdkRDVWLs/bJ+k7+HwmWAQbxkHYM/3VxB
         hK2HG/9LLG+7xagzozQbpUtXsxAV/IguYRimcyKs4K9DKu/W8L/fcK48OYPhZ7907r
         awYRJoUUzUh8+h2Au+hu40bVWGAV+a3m3zujJx2dqwJUeNbL7c9atfd2je0xPYC3Uy
         SqYz44zHJjnJY7Twell8qC5c/+iprQxQsIeeOLsPiwzZbN3Wj/n9tUeOZM9/BJYSgw
         RDvki3hD2NgtA==
Subject: Re: [PATCH v3] f2fs: rebuild nat_bits during umount
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20190216222645.18341-1-chao@kernel.org>
 <4c826d7c-0bd3-a63f-23f6-f15f8767719d@huawei.com>
 <20190301175502.GA8246@jaegeuk-macbookpro.roam.corp.google.com>
 <5421e7f9-1d56-dccb-3d97-cf3b570bc441@huawei.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <ed1fd5ad-76e5-727c-eca8-09c7916732f7@kernel.org>
Date:   Fri, 20 Aug 2021 18:56:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <5421e7f9-1d56-dccb-3d97-cf3b570bc441@huawei.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/3/4 14:27, Chao Yu wrote:
> On 2019/3/2 1:55, Jaegeuk Kim wrote:
>> On 02/28, Chao Yu wrote:
>>> Ping,
>>>
>>> Could you please try this new version?
>>
>> It's in the queue, and I'll test this after the next pull request.
> 
> Okay. :)

I picked up this ancient patch from forgotten corner of my dev tree. :)

Thanks,

> 
> Thanks,
> 
>>
>>>
>>> On 2019/2/17 6:26, Chao Yu wrote:
>>>> From: Chao Yu <yuchao0@huawei.com>
>>>>
>>>> If all free_nat_bitmap are available, we can rebuild nat_bits from
>>>> free_nat_bitmap entirely during umount, let's make another chance
>>>> to reenable nat_bits for image.
>>>>
>>>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>>>> ---
>>>> v3:
>>>> - fix to remove nat journal during umount.
>>>>   fs/f2fs/checkpoint.c | 23 +++++++++----
>>>>   fs/f2fs/f2fs.h       | 29 ++--------------
>>>>   fs/f2fs/node.c       | 82 +++++++++++++++++++++++++++++++++++++-------
>>>>   3 files changed, 89 insertions(+), 45 deletions(-)
>>>>
>>>> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
>>>> index 10a3ada28715..b4c9de4e6eb0 100644
>>>> --- a/fs/f2fs/checkpoint.c
>>>> +++ b/fs/f2fs/checkpoint.c
>>>> @@ -1225,12 +1225,22 @@ static void update_ckpt_flags(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>>>>   	struct f2fs_checkpoint *ckpt = F2FS_CKPT(sbi);
>>>>   	unsigned long flags;
>>>>   
>>>> -	spin_lock_irqsave(&sbi->cp_lock, flags);
>>>> +	if (cpc->reason & CP_UMOUNT) {
>>>> +		if (le32_to_cpu(ckpt->cp_pack_total_block_count) >
>>>> +			sbi->blocks_per_seg - NM_I(sbi)->nat_bits_blocks) {
>>>> +			clear_ckpt_flags(sbi, CP_NAT_BITS_FLAG);
>>>> +			f2fs_msg(sbi->sb, KERN_NOTICE,
>>>> +				"Disable nat_bits due to no space");
>>>> +		} else if (!is_set_ckpt_flags(sbi, CP_NAT_BITS_FLAG) &&
>>>> +						f2fs_nat_bitmap_enabled(sbi)) {
>>>> +			f2fs_enable_nat_bits(sbi);
>>>> +			set_ckpt_flags(sbi, CP_NAT_BITS_FLAG);
>>>> +			f2fs_msg(sbi->sb, KERN_NOTICE,
>>>> +				"Rebuild and enable nat_bits");
>>>> +		}
>>>> +	}
>>>>   
>>>> -	if ((cpc->reason & CP_UMOUNT) &&
>>>> -			le32_to_cpu(ckpt->cp_pack_total_block_count) >
>>>> -			sbi->blocks_per_seg - NM_I(sbi)->nat_bits_blocks)
>>>> -		disable_nat_bits(sbi, false);
>>>> +	spin_lock_irqsave(&sbi->cp_lock, flags);
>>>>   
>>>>   	if (cpc->reason & CP_TRIMMED)
>>>>   		__set_ckpt_flags(ckpt, CP_TRIMMED_FLAG);
>>>> @@ -1395,7 +1405,8 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>>>>   	start_blk = __start_cp_next_addr(sbi);
>>>>   
>>>>   	/* write nat bits */
>>>> -	if (enabled_nat_bits(sbi, cpc)) {
>>>> +	if ((cpc->reason & CP_UMOUNT) &&
>>>> +			is_set_ckpt_flags(sbi, CP_NAT_BITS_FLAG)) {
>>>>   		__u64 cp_ver = cur_cp_version(ckpt);
>>>>   		block_t blk;
>>>>   
>>>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>>>> index c0d30810ef8a..a543354fc6bf 100644
>>>> --- a/fs/f2fs/f2fs.h
>>>> +++ b/fs/f2fs/f2fs.h
>>>> @@ -1615,33 +1615,6 @@ static inline void clear_ckpt_flags(struct f2fs_sb_info *sbi, unsigned int f)
>>>>   	spin_unlock_irqrestore(&sbi->cp_lock, flags);
>>>>   }
>>>>   
>>>> -static inline void disable_nat_bits(struct f2fs_sb_info *sbi, bool lock)
>>>> -{
>>>> -	unsigned long flags;
>>>> -
>>>> -	/*
>>>> -	 * In order to re-enable nat_bits we need to call fsck.f2fs by
>>>> -	 * set_sbi_flag(sbi, SBI_NEED_FSCK). But it may give huge cost,
>>>> -	 * so let's rely on regular fsck or unclean shutdown.
>>>> -	 */
>>>> -
>>>> -	if (lock)
>>>> -		spin_lock_irqsave(&sbi->cp_lock, flags);
>>>> -	__clear_ckpt_flags(F2FS_CKPT(sbi), CP_NAT_BITS_FLAG);
>>>> -	kvfree(NM_I(sbi)->nat_bits);
>>>> -	NM_I(sbi)->nat_bits = NULL;
>>>> -	if (lock)
>>>> -		spin_unlock_irqrestore(&sbi->cp_lock, flags);
>>>> -}
>>>> -
>>>> -static inline bool enabled_nat_bits(struct f2fs_sb_info *sbi,
>>>> -					struct cp_control *cpc)
>>>> -{
>>>> -	bool set = is_set_ckpt_flags(sbi, CP_NAT_BITS_FLAG);
>>>> -
>>>> -	return (cpc) ? (cpc->reason & CP_UMOUNT) && set : set;
>>>> -}
>>>> -
>>>>   static inline void f2fs_lock_op(struct f2fs_sb_info *sbi)
>>>>   {
>>>>   	down_read(&sbi->cp_rwsem);
>>>> @@ -2970,6 +2943,7 @@ int f2fs_truncate_inode_blocks(struct inode *inode, pgoff_t from);
>>>>   int f2fs_truncate_xattr_node(struct inode *inode);
>>>>   int f2fs_wait_on_node_pages_writeback(struct f2fs_sb_info *sbi,
>>>>   					unsigned int seq_id);
>>>> +bool f2fs_nat_bitmap_enabled(struct f2fs_sb_info *sbi);
>>>>   int f2fs_remove_inode_page(struct inode *inode);
>>>>   struct page *f2fs_new_inode_page(struct inode *inode);
>>>>   struct page *f2fs_new_node_page(struct dnode_of_data *dn, unsigned int ofs);
>>>> @@ -2993,6 +2967,7 @@ int f2fs_recover_xattr_data(struct inode *inode, struct page *page);
>>>>   int f2fs_recover_inode_page(struct f2fs_sb_info *sbi, struct page *page);
>>>>   int f2fs_restore_node_summary(struct f2fs_sb_info *sbi,
>>>>   			unsigned int segno, struct f2fs_summary_block *sum);
>>>> +void f2fs_enable_nat_bits(struct f2fs_sb_info *sbi);
>>>>   int f2fs_flush_nat_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc);
>>>>   int f2fs_build_node_manager(struct f2fs_sb_info *sbi);
>>>>   void f2fs_destroy_node_manager(struct f2fs_sb_info *sbi);
>>>> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
>>>> index f6ff84e29749..e364c6a84f3c 100644
>>>> --- a/fs/f2fs/node.c
>>>> +++ b/fs/f2fs/node.c
>>>> @@ -2038,6 +2038,24 @@ static void __move_free_nid(struct f2fs_sb_info *sbi, struct free_nid *i,
>>>>   	}
>>>>   }
>>>>   
>>>> +bool f2fs_nat_bitmap_enabled(struct f2fs_sb_info *sbi)
>>>> +{
>>>> +	struct f2fs_nm_info *nm_i = NM_I(sbi);
>>>> +	unsigned int i;
>>>> +	bool ret = true;
>>>> +
>>>> +	down_read(&nm_i->nat_tree_lock);
>>>> +	for (i = 0; i < nm_i->nat_blocks; i++) {
>>>> +		if (!test_bit_le(i, nm_i->nat_block_bitmap)) {
>>>> +			ret = false;
>>>> +			break;
>>>> +		}
>>>> +	}
>>>> +	up_read(&nm_i->nat_tree_lock);
>>>> +
>>>> +	return ret;
>>>> +}
>>>> +
>>>>   static void update_free_nid_bitmap(struct f2fs_sb_info *sbi, nid_t nid,
>>>>   							bool set, bool build)
>>>>   {
>>>> @@ -2698,7 +2716,7 @@ static void __update_nat_bits(struct f2fs_sb_info *sbi, nid_t start_nid,
>>>>   	int valid = 0;
>>>>   	int i = 0;
>>>>   
>>>> -	if (!enabled_nat_bits(sbi, NULL))
>>>> +	if (!is_set_ckpt_flags(sbi, CP_NAT_BITS_FLAG))
>>>>   		return;
>>>>   
>>>>   	if (nat_index == 0) {
>>>> @@ -2722,6 +2740,43 @@ static void __update_nat_bits(struct f2fs_sb_info *sbi, nid_t start_nid,
>>>>   		__clear_bit_le(nat_index, nm_i->full_nat_bits);
>>>>   }
>>>>   
>>>> +void f2fs_enable_nat_bits(struct f2fs_sb_info *sbi)
>>>> +{
>>>> +	struct f2fs_nm_info *nm_i = NM_I(sbi);
>>>> +	int nat_ofs;
>>>> +
>>>> +	down_read(&nm_i->nat_tree_lock);
>>>> +
>>>> +	for (nat_ofs = 0; nat_ofs < nm_i->nat_blocks; nat_ofs++) {
>>>> +		int valid = 0, nid_ofs = 0;
>>>> +
>>>> +		if (nat_ofs == 0) {
>>>> +			valid = 1;
>>>> +			nid_ofs = 1;
>>>> +		}
>>>> +
>>>> +		for (; nid_ofs < NAT_ENTRY_PER_BLOCK; nid_ofs++) {
>>>> +			if (!test_bit_le(nid_ofs,
>>>> +					nm_i->free_nid_bitmap[nat_ofs]))
>>>> +				valid++;
>>>> +		}
>>>> +
>>>> +		if (valid == 0) {
>>>> +			__set_bit_le(nat_ofs, nm_i->empty_nat_bits);
>>>> +			__clear_bit_le(nat_ofs, nm_i->full_nat_bits);
>>>> +			continue;
>>>> +		}
>>>> +
>>>> +		__clear_bit_le(nat_ofs, nm_i->empty_nat_bits);
>>>> +		if (valid == NAT_ENTRY_PER_BLOCK)
>>>> +			__set_bit_le(nat_ofs, nm_i->full_nat_bits);
>>>> +		else
>>>> +			__clear_bit_le(nat_ofs, nm_i->full_nat_bits);
>>>> +	}
>>>> +
>>>> +	up_read(&nm_i->nat_tree_lock);
>>>> +}
>>>> +
>>>>   static int __flush_nat_entry_set(struct f2fs_sb_info *sbi,
>>>>   		struct nat_entry_set *set, struct cp_control *cpc)
>>>>   {
>>>> @@ -2738,7 +2793,7 @@ static int __flush_nat_entry_set(struct f2fs_sb_info *sbi,
>>>>   	 * #1, flush nat entries to journal in current hot data summary block.
>>>>   	 * #2, flush nat entries to nat page.
>>>>   	 */
>>>> -	if (enabled_nat_bits(sbi, cpc) ||
>>>> +	if ((cpc->reason & CP_UMOUNT) ||
>>>>   		!__has_cursum_space(journal, set->entry_cnt, NAT_JOURNAL))
>>>>   		to_journal = false;
>>>>   
>>>> @@ -2813,7 +2868,7 @@ int f2fs_flush_nat_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>>>>   	int err = 0;
>>>>   
>>>>   	/* during unmount, let's flush nat_bits before checking dirty_nat_cnt */
>>>> -	if (enabled_nat_bits(sbi, cpc)) {
>>>> +	if (cpc->reason & CP_UMOUNT) {
>>>>   		down_write(&nm_i->nat_tree_lock);
>>>>   		remove_nats_in_journal(sbi);
>>>>   		up_write(&nm_i->nat_tree_lock);
>>>> @@ -2829,7 +2884,7 @@ int f2fs_flush_nat_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>>>>   	 * entries, remove all entries from journal and merge them
>>>>   	 * into nat entry set.
>>>>   	 */
>>>> -	if (enabled_nat_bits(sbi, cpc) ||
>>>> +	if ((cpc->reason & CP_UMOUNT) ||
>>>>   		!__has_cursum_space(journal, nm_i->dirty_nat_cnt, NAT_JOURNAL))
>>>>   		remove_nats_in_journal(sbi);
>>>>   
>>>> @@ -2864,15 +2919,18 @@ static int __get_nat_bitmaps(struct f2fs_sb_info *sbi)
>>>>   	__u64 cp_ver = cur_cp_version(ckpt);
>>>>   	block_t nat_bits_addr;
>>>>   
>>>> -	if (!enabled_nat_bits(sbi, NULL))
>>>> -		return 0;
>>>> -
>>>>   	nm_i->nat_bits_blocks = F2FS_BLK_ALIGN((nat_bits_bytes << 1) + 8);
>>>>   	nm_i->nat_bits = f2fs_kzalloc(sbi,
>>>>   			nm_i->nat_bits_blocks << F2FS_BLKSIZE_BITS, GFP_KERNEL);
>>>>   	if (!nm_i->nat_bits)
>>>>   		return -ENOMEM;
>>>>   
>>>> +	nm_i->full_nat_bits = nm_i->nat_bits + 8;
>>>> +	nm_i->empty_nat_bits = nm_i->full_nat_bits + nat_bits_bytes;
>>>> +
>>>> +	if (!is_set_ckpt_flags(sbi, CP_NAT_BITS_FLAG))
>>>> +		return 0;
>>>> +
>>>>   	nat_bits_addr = __start_cp_addr(sbi) + sbi->blocks_per_seg -
>>>>   						nm_i->nat_bits_blocks;
>>>>   	for (i = 0; i < nm_i->nat_bits_blocks; i++) {
>>>> @@ -2889,13 +2947,13 @@ static int __get_nat_bitmaps(struct f2fs_sb_info *sbi)
>>>>   
>>>>   	cp_ver |= (cur_cp_crc(ckpt) << 32);
>>>>   	if (cpu_to_le64(cp_ver) != *(__le64 *)nm_i->nat_bits) {
>>>> -		disable_nat_bits(sbi, true);
>>>> +		clear_ckpt_flags(sbi, CP_NAT_BITS_FLAG);
>>>> +		f2fs_msg(sbi->sb, KERN_NOTICE,
>>>> +			"Disable nat_bits due to incorrect cp_ver (%llu, %llu)",
>>>> +			cp_ver, le64_to_cpu(*(__le64 *)nm_i->nat_bits));
>>>>   		return 0;
>>>>   	}
>>>>   
>>>> -	nm_i->full_nat_bits = nm_i->nat_bits + 8;
>>>> -	nm_i->empty_nat_bits = nm_i->full_nat_bits + nat_bits_bytes;
>>>> -
>>>>   	f2fs_msg(sbi->sb, KERN_NOTICE, "Found nat_bits in checkpoint");
>>>>   	return 0;
>>>>   }
>>>> @@ -2906,7 +2964,7 @@ static inline void load_free_nid_bitmap(struct f2fs_sb_info *sbi)
>>>>   	unsigned int i = 0;
>>>>   	nid_t nid, last_nid;
>>>>   
>>>> -	if (!enabled_nat_bits(sbi, NULL))
>>>> +	if (!is_set_ckpt_flags(sbi, CP_NAT_BITS_FLAG))
>>>>   		return;
>>>>   
>>>>   	for (i = 0; i < nm_i->nat_blocks; i++) {
>>>>
>>
>> .
>>
> 
