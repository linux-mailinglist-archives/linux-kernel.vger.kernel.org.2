Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC8645943F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 18:50:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234298AbhKVRxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 12:53:30 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:49406 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233052AbhKVRxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 12:53:25 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id A538C1FD39;
        Mon, 22 Nov 2021 17:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637603417; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=x33p6NH9ourj6tJW77qYYA8wpbpXO//2S5pXaQ+9glc=;
        b=vW/NleCIV3ISDcQP4C9VknD4l2CD5Rzjr6i4etioikPxkBuRJX1qrT82pnoLywatwg1qH/
        7m6vQaVgBw1WSw7AhHv6IXb2SiFgXnJYADf1lO7UQ2xMY34aFz8Fo643a77jIkjKQfQhfO
        yq1evjwczjhKm7Tw0DUkfBpBbpf8/e8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637603417;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=x33p6NH9ourj6tJW77qYYA8wpbpXO//2S5pXaQ+9glc=;
        b=CRWB1hgl256eYz6rMwLRu/+BeY8ouJ6HfiFsG8HNaZ4HQFYXcYWNgc0nwFjTf3Jvfi8Z2V
        7PvTEVEv1VFPRzAg==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 97330A3B81;
        Mon, 22 Nov 2021 17:50:17 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 583DC1E3C6D; Mon, 22 Nov 2021 18:50:17 +0100 (CET)
Date:   Mon, 22 Nov 2021 18:50:17 +0100
From:   Jan Kara <jack@suse.cz>
To:     brookxu <brookxu.cn@gmail.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: Re: [PATCH v2] ext4: fix a possible ABBA deadlock dued to busy PA
Message-ID: <20211122175017.GB32119@quack2.suse.cz>
References: <1632877945-18526-1-git-send-email-brookxu.cn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1632877945-18526-1-git-send-email-brookxu.cn@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

it seems this patch has fallen through the cracks.

On Wed 29-09-21 09:12:25, brookxu wrote:
> From: Chunguang Xu <brookxu@tencent.com>
> 
> We found on older kernel (3.10) that in the scenario of insufficient
> disk space, system may trigger an ABBA deadlock problem, it seems that
> this problem still exists in latest kernel, try to fix it here. The
> main process triggered by this problem is that task A occupies the PA
> and waits for the jbd2 transaction finish, the jbd2 transaction waits
> for the completion of task B's IO (plug_list), but task B waits for
> the release of PA by task A to finish discard, which indirectly forms
> an ABBA deadlock. The related calltrace is as follows:
> 
>     Task A
>     vfs_write
>     ext4_mb_new_blocks()
>     ext4_mb_mark_diskspace_used()       JBD2
>     jbd2_journal_get_write_access()  -> jbd2_journal_commit_transaction()
>   ->schedule()                          filemap_fdatawait()
>  |                                              |
>  | Task B                                       |
>  | do_unlinkat()                                |
>  | ext4_evict_inode()                           |
>  | jbd2_journal_begin_ordered_truncate()        |
>  | filemap_fdatawrite_range()                   |
>  | ext4_mb_new_blocks()                         |
>   -ext4_mb_discard_group_preallocations() <-----
> 
> Here, try to cancel ext4_mb_discard_group_preallocations() internal
> retry due to PA busy, and do a limited number of retries inside
> ext4_mb_discard_preallocations(), which can circumvent the above
> problems, but also has some advantages:
> 
> 1. Since the PA is in a busy state, if other groups have free PAs,
>    keeping the current PA may help to reduce fragmentation.
> 2. Continue to traverse forward instead of waiting for the current
>    group PA to be released. In most scenarios, the PA discard time
>    can be reduced.
> 
> However, in the case of smaller free space, if only a few groups have
> space, then due to multiple traversals of the group, it may increase
> CPU overhead. But in contrast, I feel that the overall benefit is
> better than the cost.
> 
> Signed-off-by: Chunguang Xu <brookxu@tencent.com>

Thanks for the patch! I guess this is a reasonable middle-ground so feel
free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

I think Ritesh was last touching this logic so let's check he doesn't see
anything wrong with this change. Ritesh?

								Honza


> ---
> v2: reset busy to zero before goto repeat.
> 
>  fs/ext4/mballoc.c | 35 ++++++++++++++++-------------------
>  1 file changed, 16 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 72bfac2..72de6c1 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -4814,7 +4814,7 @@ static void ext4_mb_new_preallocation(struct ext4_allocation_context *ac)
>   */
>  static noinline_for_stack int
>  ext4_mb_discard_group_preallocations(struct super_block *sb,
> -					ext4_group_t group, int needed)
> +				     ext4_group_t group, int needed, int *busy)
>  {
>  	struct ext4_group_info *grp = ext4_get_group_info(sb, group);
>  	struct buffer_head *bitmap_bh = NULL;
> @@ -4822,8 +4822,7 @@ static void ext4_mb_new_preallocation(struct ext4_allocation_context *ac)
>  	struct list_head list;
>  	struct ext4_buddy e4b;
>  	int err;
> -	int busy = 0;
> -	int free, free_total = 0;
> +	int free = 0;
>  
>  	mb_debug(sb, "discard preallocation for group %u\n", group);
>  	if (list_empty(&grp->bb_prealloc_list))
> @@ -4850,15 +4849,13 @@ static void ext4_mb_new_preallocation(struct ext4_allocation_context *ac)
>  		needed = EXT4_CLUSTERS_PER_GROUP(sb) + 1;
>  
>  	INIT_LIST_HEAD(&list);
> -repeat:
> -	free = 0;
>  	ext4_lock_group(sb, group);
>  	list_for_each_entry_safe(pa, tmp,
>  				&grp->bb_prealloc_list, pa_group_list) {
>  		spin_lock(&pa->pa_lock);
>  		if (atomic_read(&pa->pa_count)) {
>  			spin_unlock(&pa->pa_lock);
> -			busy = 1;
> +			*busy = 1;
>  			continue;
>  		}
>  		if (pa->pa_deleted) {
> @@ -4898,22 +4895,13 @@ static void ext4_mb_new_preallocation(struct ext4_allocation_context *ac)
>  		call_rcu(&(pa)->u.pa_rcu, ext4_mb_pa_callback);
>  	}
>  
> -	free_total += free;
> -
> -	/* if we still need more blocks and some PAs were used, try again */
> -	if (free_total < needed && busy) {
> -		ext4_unlock_group(sb, group);
> -		cond_resched();
> -		busy = 0;
> -		goto repeat;
> -	}
>  	ext4_unlock_group(sb, group);
>  	ext4_mb_unload_buddy(&e4b);
>  	put_bh(bitmap_bh);
>  out_dbg:
>  	mb_debug(sb, "discarded (%d) blocks preallocated for group %u bb_free (%d)\n",
> -		 free_total, group, grp->bb_free);
> -	return free_total;
> +		 free, group, grp->bb_free);
> +	return free;
>  }
>  
>  /*
> @@ -5455,13 +5443,22 @@ static int ext4_mb_discard_preallocations(struct super_block *sb, int needed)
>  {
>  	ext4_group_t i, ngroups = ext4_get_groups_count(sb);
>  	int ret;
> -	int freed = 0;
> +	int freed = 0, busy = 0;
> +	int retry = 0;
>  
>  	trace_ext4_mb_discard_preallocations(sb, needed);
> + repeat:
> +	retry++;
>  	for (i = 0; i < ngroups && needed > 0; i++) {
> -		ret = ext4_mb_discard_group_preallocations(sb, i, needed);
> +		ret = ext4_mb_discard_group_preallocations(sb, i, needed, &busy);
>  		freed += ret;
>  		needed -= ret;
> +		cond_resched();
> +	}
> +
> +	if (needed > 0 && busy && retry < 3) {
> +		busy = 0;
> +		goto repeat;
>  	}
>  
>  	return freed;
> -- 
> 1.8.3.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
