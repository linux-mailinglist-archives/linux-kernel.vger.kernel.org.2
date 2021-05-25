Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 241D63902A9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 15:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233273AbhEYNnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 09:43:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:33142 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233155AbhEYNnu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 09:43:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1621950140; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/Z36aQZqwaBYtQ3VW7FWlGBe3yKaHUC3moF1TjtA7GY=;
        b=hlOrsPO9xQfFvIjxg8Vj0wT+685SXdP6jeSD8DcDK2iuqDseCMxTZ5dLs+NwWZ31DeStkj
        JmLBAFSdwFcvHmPGN8Nwy9rWbSm+1R+PC9JpcIXHz13ZUXmP12I+6Kux6t4XB4n4xylkLe
        HHJGiooUDlEHSbW5uZPg4JEn5dz5zcs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1621950140;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/Z36aQZqwaBYtQ3VW7FWlGBe3yKaHUC3moF1TjtA7GY=;
        b=m9n6zPeY6xxEwd45SOni6kDSQo8meP40FpOMy7N3GefhjmXSVQ2vOjeBFKYNUhcHUTrFVf
        acinA4a1ywwp8qDA==
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4D04CAB71;
        Tue, 25 May 2021 13:42:20 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 13DF71F2C98; Tue, 25 May 2021 15:42:20 +0200 (CEST)
Date:   Tue, 25 May 2021 15:42:20 +0200
From:   Jan Kara <jack@suse.cz>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, chao@kernel.org,
        Zhang Yi <yi.zhang@huawei.com>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] f2fs: avoid attaching SB_ACTIVE flag during mount/remount
Message-ID: <20210525134220.GE4112@quack2.suse.cz>
References: <20210525113909.113486-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210525113909.113486-1-yuchao0@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 25-05-21 19:39:09, Chao Yu wrote:
> Quoted from [1]
> 
> "I do remember that I've added this code back then because otherwise
> orphan cleanup was losing updates to quota files. But you're right
> that now I don't see how that could be happening and it would be nice
> if we could get rid of this hack"
> 
> [1] https://lore.kernel.org/linux-ext4/99cce8ca-e4a0-7301-840f-2ace67c551f3@huawei.com/T/#m04990cfbc4f44592421736b504afcc346b2a7c00
> 
> Related fix in ext4 by
> commit 72ffb49a7b62 ("ext4: do not set SB_ACTIVE in ext4_orphan_cleanup()").
> 
> f2fs has the same hack implementation in
> - f2fs_recover_orphan_inodes()
> - f2fs_recover_fsync_data()
> - f2fs_disable_checkpoint()
> 
> Let's get rid of this hack as well in f2fs.
> 
> Cc: Zhang Yi <yi.zhang@huawei.com>
> Cc: Jan Kara <jack@suse.cz>
> Signed-off-by: Chao Yu <yuchao0@huawei.com>

Makes sense to me. You can add:

Acked-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/f2fs/checkpoint.c |  3 ---
>  fs/f2fs/recovery.c   |  8 ++------
>  fs/f2fs/super.c      | 11 ++++-------
>  3 files changed, 6 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index 6c208108d69c..a578c7d13d81 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -691,9 +691,6 @@ int f2fs_recover_orphan_inodes(struct f2fs_sb_info *sbi)
>  	}
>  
>  #ifdef CONFIG_QUOTA
> -	/* Needed for iput() to work correctly and not trash data */
> -	sbi->sb->s_flags |= SB_ACTIVE;
> -
>  	/*
>  	 * Turn on quotas which were not enabled for read-only mounts if
>  	 * filesystem has quota feature, so that they are updated correctly.
> diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
> index 4b2f7d1d5bf4..4cfe36fa41be 100644
> --- a/fs/f2fs/recovery.c
> +++ b/fs/f2fs/recovery.c
> @@ -782,8 +782,6 @@ int f2fs_recover_fsync_data(struct f2fs_sb_info *sbi, bool check_only)
>  	}
>  
>  #ifdef CONFIG_QUOTA
> -	/* Needed for iput() to work correctly and not trash data */
> -	sbi->sb->s_flags |= SB_ACTIVE;
>  	/* Turn on quotas so that they are updated correctly */
>  	quota_enabled = f2fs_enable_quota_files(sbi, s_flags & SB_RDONLY);
>  #endif
> @@ -811,10 +809,8 @@ int f2fs_recover_fsync_data(struct f2fs_sb_info *sbi, bool check_only)
>  	err = recover_data(sbi, &inode_list, &tmp_inode_list, &dir_list);
>  	if (!err)
>  		f2fs_bug_on(sbi, !list_empty(&inode_list));
> -	else {
> -		/* restore s_flags to let iput() trash data */
> -		sbi->sb->s_flags = s_flags;
> -	}
> +	else
> +		f2fs_bug_on(sbi, sbi->sb->s_flags & SB_ACTIVE);
>  skip:
>  	fix_curseg_write_pointer = !check_only || list_empty(&inode_list);
>  
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 0a77808ebb8f..e7bd983fbddc 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -1881,17 +1881,15 @@ static int f2fs_enable_quotas(struct super_block *sb);
>  
>  static int f2fs_disable_checkpoint(struct f2fs_sb_info *sbi)
>  {
> -	unsigned int s_flags = sbi->sb->s_flags;
>  	struct cp_control cpc;
>  	int err = 0;
>  	int ret;
>  	block_t unusable;
>  
> -	if (s_flags & SB_RDONLY) {
> +	if (sbi->sb->s_flags & SB_RDONLY) {
>  		f2fs_err(sbi, "checkpoint=disable on readonly fs");
>  		return -EINVAL;
>  	}
> -	sbi->sb->s_flags |= SB_ACTIVE;
>  
>  	f2fs_update_time(sbi, DISABLE_TIME);
>  
> @@ -1909,13 +1907,13 @@ static int f2fs_disable_checkpoint(struct f2fs_sb_info *sbi)
>  	ret = sync_filesystem(sbi->sb);
>  	if (ret || err) {
>  		err = ret ? ret : err;
> -		goto restore_flag;
> +		goto out;
>  	}
>  
>  	unusable = f2fs_get_unusable_blocks(sbi);
>  	if (f2fs_disable_cp_again(sbi, unusable)) {
>  		err = -EAGAIN;
> -		goto restore_flag;
> +		goto out;
>  	}
>  
>  	down_write(&sbi->gc_lock);
> @@ -1931,8 +1929,7 @@ static int f2fs_disable_checkpoint(struct f2fs_sb_info *sbi)
>  
>  out_unlock:
>  	up_write(&sbi->gc_lock);
> -restore_flag:
> -	sbi->sb->s_flags = s_flags;	/* Restore SB_RDONLY status */
> +out:
>  	return err;
>  }
>  
> -- 
> 2.29.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
