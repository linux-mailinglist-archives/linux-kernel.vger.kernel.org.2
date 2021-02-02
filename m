Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD2A30B721
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 06:35:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231687AbhBBFeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 00:34:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:41056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230221AbhBBFeg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 00:34:36 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2826864ED9;
        Tue,  2 Feb 2021 05:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612244034;
        bh=22yQx72jEhx+zDhE8nGIasOHVbmdEQ2q4aXtGLy/VdU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AOAJRMXI1g4YJeZHC191tCSeoup/2SCffjPUvk3Nds1JZ6xus7GUVWS8GaN/j+bsu
         gaNmBd+4U3nXbJbZQ8XD48Ak92bzzxT8c8eCMNzhMoUVuxhMb+MpklKBxcKn9gCEiR
         zlGKqt30Zrs5AUP54OjN+ZEPNr9Q5ZwL30rrrMMg4vRh665GgvWe6BySEl5WZAGbmm
         aNnRn5uCyfSVd4vH9Q5AVsVbiCbeQoJXA0oKFjwIQgN0wSa722CA3MnLAVsT41LqWQ
         amMvUBR+oW+I3LqjVqc8AEOgceuq23uoEan/aBZDngOiRz4CiMD7JfOjTt4aSHxI0r
         F8KXrJNy5ec9Q==
Date:   Mon, 1 Feb 2021 21:33:52 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Daeho Jeong <daeho43@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: rename checkpoint=merge mount option
 to checkpoint_merge
Message-ID: <YBjkQBdqwoAXDTDa@google.com>
References: <20210202051829.2127214-1-daeho43@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210202051829.2127214-1-daeho43@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/02, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> As checkpoint=merge comes in, mount option setting related to checkpoint
> had been mixed up and it became hard to understand. So, I separated
> this option from "checkpoint=" and made another mount option
> "checkpoint_merge" for this.

Thanks, merged to the original patch.

> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> ---
> v2: renamed "checkpoint=merge" to "checkpoint_merge"
> ---
>  Documentation/filesystems/f2fs.rst |  6 +++---
>  fs/f2fs/super.c                    | 26 ++++++++++++++------------
>  2 files changed, 17 insertions(+), 15 deletions(-)
> 
> diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
> index d0ead45dc706..475994ed8b15 100644
> --- a/Documentation/filesystems/f2fs.rst
> +++ b/Documentation/filesystems/f2fs.rst
> @@ -247,9 +247,9 @@ checkpoint=%s[:%u[%]]	 Set to "disable" to turn off checkpointing. Set to "enabl
>  			 hide up to all remaining free space. The actual space that
>  			 would be unusable can be viewed at /sys/fs/f2fs/<disk>/unusable
>  			 This space is reclaimed once checkpoint=enable.
> -			 Here is another option "merge", which creates a kernel daemon
> -			 and makes it to merge concurrent checkpoint requests as much
> -			 as possible to eliminate redundant checkpoint issues. Plus,
> +checkpoint_merge	 When checkpoint is enabled, this can be used to create a kernel
> +			 daemon and make it to merge concurrent checkpoint requests as
> +			 much as possible to eliminate redundant checkpoint issues. Plus,
>  			 we can eliminate the sluggish issue caused by slow checkpoint
>  			 operation when the checkpoint is done in a process context in
>  			 a cgroup having low i/o budget and cpu shares. To make this
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 56696f6cfa86..d8603e6c4916 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -145,6 +145,7 @@ enum {
>  	Opt_checkpoint_disable_cap_perc,
>  	Opt_checkpoint_enable,
>  	Opt_checkpoint_merge,
> +	Opt_nocheckpoint_merge,
>  	Opt_compress_algorithm,
>  	Opt_compress_log_size,
>  	Opt_compress_extension,
> @@ -215,7 +216,8 @@ static match_table_t f2fs_tokens = {
>  	{Opt_checkpoint_disable_cap, "checkpoint=disable:%u"},
>  	{Opt_checkpoint_disable_cap_perc, "checkpoint=disable:%u%%"},
>  	{Opt_checkpoint_enable, "checkpoint=enable"},
> -	{Opt_checkpoint_merge, "checkpoint=merge"},
> +	{Opt_checkpoint_merge, "checkpoint_merge"},
> +	{Opt_nocheckpoint_merge, "nocheckpoint_merge"},
>  	{Opt_compress_algorithm, "compress_algorithm=%s"},
>  	{Opt_compress_log_size, "compress_log_size=%u"},
>  	{Opt_compress_extension, "compress_extension=%s"},
> @@ -946,6 +948,9 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
>  		case Opt_checkpoint_merge:
>  			set_opt(sbi, MERGE_CHECKPOINT);
>  			break;
> +		case Opt_nocheckpoint_merge:
> +			clear_opt(sbi, MERGE_CHECKPOINT);
> +			break;
>  #ifdef CONFIG_F2FS_FS_COMPRESSION
>  		case Opt_compress_algorithm:
>  			if (!f2fs_sb_has_compression(sbi)) {
> @@ -1142,12 +1147,6 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
>  		return -EINVAL;
>  	}
>  
> -	if (test_opt(sbi, DISABLE_CHECKPOINT) &&
> -			test_opt(sbi, MERGE_CHECKPOINT)) {
> -		f2fs_err(sbi, "checkpoint=merge cannot be used with checkpoint=disable\n");
> -		return -EINVAL;
> -	}
> -
>  	/* Not pass down write hints if the number of active logs is lesser
>  	 * than NR_CURSEG_PERSIST_TYPE.
>  	 */
> @@ -1782,7 +1781,7 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
>  		seq_printf(seq, ",checkpoint=disable:%u",
>  				F2FS_OPTION(sbi).unusable_cap);
>  	if (test_opt(sbi, MERGE_CHECKPOINT))
> -		seq_puts(seq, ",checkpoint=merge");
> +		seq_puts(seq, ",checkpoint_merge");
>  	if (F2FS_OPTION(sbi).fsync_mode == FSYNC_MODE_POSIX)
>  		seq_printf(seq, ",fsync_mode=%s", "posix");
>  	else if (F2FS_OPTION(sbi).fsync_mode == FSYNC_MODE_STRICT)
> @@ -1827,6 +1826,7 @@ static void default_options(struct f2fs_sb_info *sbi)
>  	sbi->sb->s_flags |= SB_LAZYTIME;
>  	set_opt(sbi, FLUSH_MERGE);
>  	set_opt(sbi, DISCARD);
> +	clear_opt(sbi, MERGE_CHECKPOINT);
>  	if (f2fs_sb_has_blkzoned(sbi))
>  		F2FS_OPTION(sbi).fs_mode = FS_MODE_LFS;
>  	else
> @@ -2066,9 +2066,8 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
>  		}
>  	}
>  
> -	if (!test_opt(sbi, MERGE_CHECKPOINT)) {
> -		f2fs_stop_ckpt_thread(sbi);
> -	} else {
> +	if (!test_opt(sbi, DISABLE_CHECKPOINT) &&
> +			test_opt(sbi, MERGE_CHECKPOINT)) {
>  		err = f2fs_start_ckpt_thread(sbi);
>  		if (err) {
>  			f2fs_err(sbi,
> @@ -2076,6 +2075,8 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
>  			    err);
>  			goto restore_gc;
>  		}
> +	} else {
> +		f2fs_stop_ckpt_thread(sbi);
>  	}
>  
>  	/*
> @@ -3831,7 +3832,8 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
>  
>  	/* setup checkpoint request control and start checkpoint issue thread */
>  	f2fs_init_ckpt_req_control(sbi);
> -	if (test_opt(sbi, MERGE_CHECKPOINT)) {
> +	if (!test_opt(sbi, DISABLE_CHECKPOINT) &&
> +			test_opt(sbi, MERGE_CHECKPOINT)) {
>  		err = f2fs_start_ckpt_thread(sbi);
>  		if (err) {
>  			f2fs_err(sbi,
> -- 
> 2.30.0.365.g02bc693789-goog
> 
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
