Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6E23D24C5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 15:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbhGVNCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 09:02:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:47768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232145AbhGVNBR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 09:01:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3092B6135B;
        Thu, 22 Jul 2021 13:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626961276;
        bh=qlvBJjMXUIlOmf6gGUnZF5/zHM7wmZtptb55cUuKzK8=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=USgBTU/6SfzAnUHlEQbye5k4IWwSN+9eZYhVDqU5eJMmceI8ppi9GMARyaHlyOqy9
         UbIWnW3pjlsXZsPibsXkWcPj6Pmyi7Cb0i1Ah0ZWib7n9i455q5tSAd8r282p1piTa
         QM4mQTrUAqsNWM3zUgOwX/9XdV/yR4P2b2hOfSNP7gFsM59VIs3L42ZXyGYraOs4Pm
         Vkrq0VXJ60GU4bGj0u5p97qOTUpL+RtkE6IywZ4m5/UTvL+05YV0ZBV0Xjbo9hRKfu
         vUwuR/amAzwBHT/Fj/ajqz1NRtCb8b/B5NSwjtwR2JsLlPN9buCX0WgS38sfyivj+z
         X6I5Go7m8qbnw==
Subject: Re: [f2fs-dev] [PATCH] f2fs: use rwlock instead of rwsem for journal
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20210722014149.525166-1-jaegeuk@kernel.org>
From:   Chao Yu <chao@kernel.org>
Message-ID: <732f3478-b69f-8d95-b472-e66b1fc4fef3@kernel.org>
Date:   Thu, 22 Jul 2021 21:41:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210722014149.525166-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/7/22 9:41, Jaegeuk Kim wrote:
> This tries to fix priority inversion in the below condition resulting in
> long checkpoint delay.
> 
> f2fs_get_node_info()
>   - nat_tree_lock
>    -> sleep in journal_rwsem
>                                       checkpoint
>                                       - waiting for nat_tree_lock
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>   fs/f2fs/node.c    | 16 ++++++++--------
>   fs/f2fs/segment.c | 22 +++++++++++-----------
>   fs/f2fs/segment.h |  2 +-
>   3 files changed, 20 insertions(+), 20 deletions(-)
> 
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index 0be9e2d7120e..821a40e02fb4 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -567,13 +567,13 @@ int f2fs_get_node_info(struct f2fs_sb_info *sbi, nid_t nid,
>   	memset(&ne, 0, sizeof(struct f2fs_nat_entry));
>   
>   	/* Check current segment summary */
> -	down_read(&curseg->journal_rwsem);
> +	read_lock(&curseg->journal_rwlock);

It seem journal_rwsem covers too many operations, e.g.

- scan_curseg_cache
  - add_free_nid
   - f2fs_kmem_cache_alloc
    - kmem_cache_alloc(__GFP_NOFAIL)

Thanks,

>   	i = f2fs_lookup_journal_in_cursum(journal, NAT_JOURNAL, nid, 0);
>   	if (i >= 0) {
>   		ne = nat_in_journal(journal, i);
>   		node_info_from_raw_nat(ni, &ne);
>   	}
> -	up_read(&curseg->journal_rwsem);
> +	read_unlock(&curseg->journal_rwlock);
>   	if (i >= 0) {
>   		up_read(&nm_i->nat_tree_lock);
>   		goto cache;
> @@ -2338,7 +2338,7 @@ static void scan_curseg_cache(struct f2fs_sb_info *sbi)
>   	struct f2fs_journal *journal = curseg->journal;
>   	int i;
>   
> -	down_read(&curseg->journal_rwsem);
> +	read_lock(&curseg->journal_rwlock);
>   	for (i = 0; i < nats_in_cursum(journal); i++) {
>   		block_t addr;
>   		nid_t nid;
> @@ -2350,7 +2350,7 @@ static void scan_curseg_cache(struct f2fs_sb_info *sbi)
>   		else
>   			remove_free_nid(sbi, nid);
>   	}
> -	up_read(&curseg->journal_rwsem);
> +	read_unlock(&curseg->journal_rwlock);
>   }
>   
>   static void scan_free_nid_bits(struct f2fs_sb_info *sbi)
> @@ -2799,7 +2799,7 @@ static void remove_nats_in_journal(struct f2fs_sb_info *sbi)
>   	struct f2fs_journal *journal = curseg->journal;
>   	int i;
>   
> -	down_write(&curseg->journal_rwsem);
> +	write_lock(&curseg->journal_rwlock);
>   	for (i = 0; i < nats_in_cursum(journal); i++) {
>   		struct nat_entry *ne;
>   		struct f2fs_nat_entry raw_ne;
> @@ -2831,7 +2831,7 @@ static void remove_nats_in_journal(struct f2fs_sb_info *sbi)
>   		__set_nat_cache_dirty(nm_i, ne);
>   	}
>   	update_nats_in_cursum(journal, -i);
> -	up_write(&curseg->journal_rwsem);
> +	write_unlock(&curseg->journal_rwlock);
>   }
>   
>   static void __adjust_nat_entry_set(struct nat_entry_set *nes,
> @@ -2906,7 +2906,7 @@ static int __flush_nat_entry_set(struct f2fs_sb_info *sbi,
>   		to_journal = false;
>   
>   	if (to_journal) {
> -		down_write(&curseg->journal_rwsem);
> +		write_lock(&curseg->journal_rwlock);
>   	} else {
>   		page = get_next_nat_page(sbi, start_nid);
>   		if (IS_ERR(page))
> @@ -2946,7 +2946,7 @@ static int __flush_nat_entry_set(struct f2fs_sb_info *sbi,
>   	}
>   
>   	if (to_journal) {
> -		up_write(&curseg->journal_rwsem);
> +		write_unlock(&curseg->journal_rwlock);
>   	} else {
>   		__update_nat_bits(sbi, start_nid, page);
>   		f2fs_put_page(page, 1);
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index f9b7fb785e1d..c397c1c271ec 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -2442,9 +2442,9 @@ static void write_current_sum_page(struct f2fs_sb_info *sbi,
>   
>   	mutex_lock(&curseg->curseg_mutex);
>   
> -	down_read(&curseg->journal_rwsem);
> +	read_lock(&curseg->journal_rwlock);
>   	memcpy(&dst->journal, curseg->journal, SUM_JOURNAL_SIZE);
> -	up_read(&curseg->journal_rwsem);
> +	read_unlock(&curseg->journal_rwlock);
>   
>   	memcpy(dst->entries, src->entries, SUM_ENTRY_SIZE);
>   	memcpy(&dst->footer, &src->footer, SUM_FOOTER_SIZE);
> @@ -3876,9 +3876,9 @@ static int read_normal_summaries(struct f2fs_sb_info *sbi, int type)
>   	mutex_lock(&curseg->curseg_mutex);
>   
>   	/* update journal info */
> -	down_write(&curseg->journal_rwsem);
> +	write_lock(&curseg->journal_rwlock);
>   	memcpy(curseg->journal, &sum->journal, SUM_JOURNAL_SIZE);
> -	up_write(&curseg->journal_rwsem);
> +	write_unlock(&curseg->journal_rwlock);
>   
>   	memcpy(curseg->sum_blk->entries, sum->entries, SUM_ENTRY_SIZE);
>   	memcpy(&curseg->sum_blk->footer, &sum->footer, SUM_FOOTER_SIZE);
> @@ -4136,7 +4136,7 @@ static void remove_sits_in_journal(struct f2fs_sb_info *sbi)
>   	struct f2fs_journal *journal = curseg->journal;
>   	int i;
>   
> -	down_write(&curseg->journal_rwsem);
> +	write_lock(&curseg->journal_rwlock);
>   	for (i = 0; i < sits_in_cursum(journal); i++) {
>   		unsigned int segno;
>   		bool dirtied;
> @@ -4148,7 +4148,7 @@ static void remove_sits_in_journal(struct f2fs_sb_info *sbi)
>   			add_sit_entry(segno, &SM_I(sbi)->sit_entry_set);
>   	}
>   	update_sits_in_cursum(journal, -i);
> -	up_write(&curseg->journal_rwsem);
> +	write_unlock(&curseg->journal_rwlock);
>   }
>   
>   /*
> @@ -4204,7 +4204,7 @@ void f2fs_flush_sit_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>   			to_journal = false;
>   
>   		if (to_journal) {
> -			down_write(&curseg->journal_rwsem);
> +			write_lock(&curseg->journal_rwlock);
>   		} else {
>   			page = get_next_sit_page(sbi, start_segno);
>   			raw_sit = page_address(page);
> @@ -4251,7 +4251,7 @@ void f2fs_flush_sit_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>   		}
>   
>   		if (to_journal)
> -			up_write(&curseg->journal_rwsem);
> +			write_unlock(&curseg->journal_rwlock);
>   		else
>   			f2fs_put_page(page, 1);
>   
> @@ -4432,7 +4432,7 @@ static int build_curseg(struct f2fs_sb_info *sbi)
>   		array[i].sum_blk = f2fs_kzalloc(sbi, PAGE_SIZE, GFP_KERNEL);
>   		if (!array[i].sum_blk)
>   			return -ENOMEM;
> -		init_rwsem(&array[i].journal_rwsem);
> +		rwlock_init(&array[i].journal_rwlock);
>   		array[i].journal = f2fs_kzalloc(sbi,
>   				sizeof(struct f2fs_journal), GFP_KERNEL);
>   		if (!array[i].journal)
> @@ -4509,7 +4509,7 @@ static int build_sit_entries(struct f2fs_sb_info *sbi)
>   		start_blk += readed;
>   	} while (start_blk < sit_blk_cnt);
>   
> -	down_read(&curseg->journal_rwsem);
> +	read_lock(&curseg->journal_rwlock);
>   	for (i = 0; i < sits_in_cursum(journal); i++) {
>   		unsigned int old_valid_blocks;
>   
> @@ -4551,7 +4551,7 @@ static int build_sit_entries(struct f2fs_sb_info *sbi)
>   							old_valid_blocks;
>   		}
>   	}
> -	up_read(&curseg->journal_rwsem);
> +	read_unlock(&curseg->journal_rwlock);
>   
>   	if (!err && total_node_blocks != valid_node_count(sbi)) {
>   		f2fs_err(sbi, "SIT is corrupted node# %u vs %u",
> diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
> index 050230c70a53..afb9041dc2e6 100644
> --- a/fs/f2fs/segment.h
> +++ b/fs/f2fs/segment.h
> @@ -306,7 +306,7 @@ struct victim_selection {
>   struct curseg_info {
>   	struct mutex curseg_mutex;		/* lock for consistency */
>   	struct f2fs_summary_block *sum_blk;	/* cached summary block */
> -	struct rw_semaphore journal_rwsem;	/* protect journal area */
> +	rwlock_t journal_rwlock;		/* protect journal area */
>   	struct f2fs_journal *journal;		/* cached journal info */
>   	unsigned char alloc_type;		/* current allocation type */
>   	unsigned short seg_type;		/* segment type like CURSEG_XXX_TYPE */
> 
