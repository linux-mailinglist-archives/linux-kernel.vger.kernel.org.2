Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74250372D28
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 17:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbhEDPmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 11:42:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:37288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231357AbhEDPmS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 11:42:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B6093611AB;
        Tue,  4 May 2021 15:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620142883;
        bh=/AslvWxxJL6oX+kpSE1utdE9ZH2fdXaU6WVdssGLtQo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R0TJA+wWYSo+H8o1tUNNVXCWICmX6XFJFf/wFPg5Qt3CX+Zs9/QC/nB82bUiLzspU
         An4XbLZamCo76HAVNDgHJBHwpnJWBVUk29ft1FPS6ln7j9Qkvee4WsO6xh2KnUfq+B
         CapqNF3bUZmHajGjGUVQ2ZbO3pqRfu3XoS+r/3nglyC3u87V55I/aHK+b8QEw8ELEk
         njL4MG1pLmrS0kQmUpSxuhQEmuKoxv80RqmE/9KTWO9CG8JGqSpzlX5oXS38ar+LCY
         UaOmb1TClq7I27C0g3Dxgtngo6KJX1FlU39NuoU/43pHEzGrmmDUbNvaAkwNm5Nn2A
         +tEh+Y49A70Rw==
Date:   Tue, 4 May 2021 08:41:21 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Daejun Park <daejun7.park@samsung.com>
Cc:     "chao@kernel.org" <chao@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: refactoring nat and sit functions
Message-ID: <YJFrIVkghu4Nw87l@google.com>
References: <CGME20210429065038epcms2p538390e44af97feae43437fb97aa0759e@epcms2p5>
 <20210429065038epcms2p538390e44af97feae43437fb97aa0759e@epcms2p5>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210429065038epcms2p538390e44af97feae43437fb97aa0759e@epcms2p5>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/29, Daejun Park wrote:
> This patch separates the APIs for nat and sit.
> 
> f2fs_lookup_journal_in_cursum -> f2fs_lookup_journal_{nats|sits}_in_cursum
> __has_cursum_space -> __has_{nats|sits}_in_cursum_space

I don't get why we need this?

> 
> Signed-off-by: Daejun Park <daejun7.park@samsung.com>
> ---
>  fs/f2fs/f2fs.h    | 16 +++++++++++-----
>  fs/f2fs/node.c    | 11 +++++------
>  fs/f2fs/segment.c | 46 +++++++++++++++++++++++++++-------------------
>  3 files changed, 43 insertions(+), 30 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index b9d5317db0a7..e264fedacc9e 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -416,11 +416,15 @@ static inline int update_sits_in_cursum(struct f2fs_journal *journal, int i)
>  	return before;
>  }
>  
> -static inline bool __has_cursum_space(struct f2fs_journal *journal,
> -							int size, int type)
> +static inline bool __has_nats_in_cursum_space(struct f2fs_journal *journal,
> +					      int size)
> +{
> +	return size <= MAX_NAT_JENTRIES(journal);
> +}
> +
> +static inline bool __has_sits_in_cursum_space(struct f2fs_journal *journal,
> +					      int size)
>  {
> -	if (type == NAT_JOURNAL)
> -		return size <= MAX_NAT_JENTRIES(journal);
>  	return size <= MAX_SIT_JENTRIES(journal);
>  }
>  
> @@ -3420,7 +3424,9 @@ void f2fs_wait_on_block_writeback_range(struct inode *inode, block_t blkaddr,
>  								block_t len);
>  void f2fs_write_data_summaries(struct f2fs_sb_info *sbi, block_t start_blk);
>  void f2fs_write_node_summaries(struct f2fs_sb_info *sbi, block_t start_blk);
> -int f2fs_lookup_journal_in_cursum(struct f2fs_journal *journal, int type,
> +int f2fs_lookup_journal_sits_in_cursum(struct f2fs_journal *journal,
> +			unsigned int val, int alloc);
> +int f2fs_lookup_journal_nats_in_cursum(struct f2fs_journal *journal,
>  			unsigned int val, int alloc);
>  void f2fs_flush_sit_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc);
>  int f2fs_fix_curseg_write_pointer(struct f2fs_sb_info *sbi);
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index e67ce5f13b98..cb295eb8ed91 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -554,7 +554,7 @@ int f2fs_get_node_info(struct f2fs_sb_info *sbi, nid_t nid,
>  
>  	/* Check current segment summary */
>  	down_read(&curseg->journal_rwsem);
> -	i = f2fs_lookup_journal_in_cursum(journal, NAT_JOURNAL, nid, 0);
> +	i = f2fs_lookup_journal_nats_in_cursum(journal, nid, 0);
>  	if (i >= 0) {
>  		ne = nat_in_journal(journal, i);
>  		node_info_from_raw_nat(ni, &ne);
> @@ -2891,7 +2891,7 @@ static int __flush_nat_entry_set(struct f2fs_sb_info *sbi,
>  	 * #2, flush nat entries to nat page.
>  	 */
>  	if (enabled_nat_bits(sbi, cpc) ||
> -		!__has_cursum_space(journal, set->entry_cnt, NAT_JOURNAL))
> +		!__has_nats_in_cursum_space(journal, set->entry_cnt))
>  		to_journal = false;
>  
>  	if (to_journal) {
> @@ -2914,8 +2914,8 @@ static int __flush_nat_entry_set(struct f2fs_sb_info *sbi,
>  		f2fs_bug_on(sbi, nat_get_blkaddr(ne) == NEW_ADDR);
>  
>  		if (to_journal) {
> -			offset = f2fs_lookup_journal_in_cursum(journal,
> -							NAT_JOURNAL, nid, 1);
> +			offset = f2fs_lookup_journal_nats_in_cursum(journal,
> +							nid, 1);
>  			f2fs_bug_on(sbi, offset < 0);
>  			raw_ne = &nat_in_journal(journal, offset);
>  			nid_in_journal(journal, offset) = cpu_to_le32(nid);
> @@ -2985,8 +2985,7 @@ int f2fs_flush_nat_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>  	 * into nat entry set.
>  	 */
>  	if (enabled_nat_bits(sbi, cpc) ||
> -		!__has_cursum_space(journal,
> -			nm_i->nat_cnt[DIRTY_NAT], NAT_JOURNAL))
> +		!__has_nats_in_cursum_space(journal, nm_i->nat_cnt[DIRTY_NAT]))
>  		remove_nats_in_journal(sbi);
>  
>  	while ((found = __gang_lookup_nat_set(nm_i,
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index efac388d2468..63bfbc2603ae 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -4013,25 +4013,33 @@ void f2fs_write_node_summaries(struct f2fs_sb_info *sbi, block_t start_blk)
>  	write_normal_summaries(sbi, start_blk, CURSEG_HOT_NODE);
>  }
>  
> -int f2fs_lookup_journal_in_cursum(struct f2fs_journal *journal, int type,
> +int f2fs_lookup_journal_nats_in_cursum(struct f2fs_journal *journal,
>  					unsigned int val, int alloc)
>  {
>  	int i;
>  
> -	if (type == NAT_JOURNAL) {
> -		for (i = 0; i < nats_in_cursum(journal); i++) {
> -			if (le32_to_cpu(nid_in_journal(journal, i)) == val)
> -				return i;
> -		}
> -		if (alloc && __has_cursum_space(journal, 1, NAT_JOURNAL))
> -			return update_nats_in_cursum(journal, 1);
> -	} else if (type == SIT_JOURNAL) {
> -		for (i = 0; i < sits_in_cursum(journal); i++)
> -			if (le32_to_cpu(segno_in_journal(journal, i)) == val)
> -				return i;
> -		if (alloc && __has_cursum_space(journal, 1, SIT_JOURNAL))
> -			return update_sits_in_cursum(journal, 1);
> -	}
> +	for (i = 0; i < nats_in_cursum(journal); i++)
> +		if (le32_to_cpu(nid_in_journal(journal, i)) == val)
> +			return i;
> +
> +	if (alloc && __has_nats_in_cursum_space(journal, 1))
> +		return update_nats_in_cursum(journal, 1);
> +
> +	return -1;
> +}
> +
> +int f2fs_lookup_journal_sits_in_cursum(struct f2fs_journal *journal,
> +					unsigned int val, int alloc)
> +{
> +	int i;
> +
> +	for (i = 0; i < sits_in_cursum(journal); i++)
> +		if (le32_to_cpu(segno_in_journal(journal, i)) == val)
> +			return i;
> +
> +	if (alloc && __has_sits_in_cursum_space(journal, 1))
> +		return update_sits_in_cursum(journal, 1);
> +
>  	return -1;
>  }
>  
> @@ -4174,7 +4182,7 @@ void f2fs_flush_sit_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>  	 * entries, remove all entries from journal and add and account
>  	 * them in sit entry set.
>  	 */
> -	if (!__has_cursum_space(journal, sit_i->dirty_sentries, SIT_JOURNAL) ||
> +	if (!__has_sits_in_cursum_space(journal, sit_i->dirty_sentries) ||
>  								!to_journal)
>  		remove_sits_in_journal(sbi);
>  
> @@ -4192,7 +4200,7 @@ void f2fs_flush_sit_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>  		unsigned int segno = start_segno;
>  
>  		if (to_journal &&
> -			!__has_cursum_space(journal, ses->entry_cnt, SIT_JOURNAL))
> +			!__has_sits_in_cursum_space(journal, ses->entry_cnt))
>  			to_journal = false;
>  
>  		if (to_journal) {
> @@ -4220,8 +4228,8 @@ void f2fs_flush_sit_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>  			}
>  
>  			if (to_journal) {
> -				offset = f2fs_lookup_journal_in_cursum(journal,
> -							SIT_JOURNAL, segno, 1);
> +				offset = f2fs_lookup_journal_sits_in_cursum(
> +						journal, segno, 1);
>  				f2fs_bug_on(sbi, offset < 0);
>  				segno_in_journal(journal, offset) =
>  							cpu_to_le32(segno);
> -- 
> 2.25.1
