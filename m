Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAD6130BF1C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 14:15:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbhBBNNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 08:13:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:55730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231497AbhBBNNL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 08:13:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 073FD64ECF;
        Tue,  2 Feb 2021 13:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612271550;
        bh=/lfW9msPfiMljbI90SDPeL/MkjF+o+FXXXbZ8mJePIc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=H8nyk40jeHd1WQnsW9m3IaAukirTJqdZP7pQhgWv58ukaI8GsjgzqTMQlmZcxguE6
         DX5KACFmDXN3q35DO5tujhOYRPOrDbOoMmya8YDsCs6CKzs0+wNtepgSPFKPpi+hcU
         89GHQxBEhT4QUUg5QSXc3PvZZdDxqKMnyoJ2J+Uk4uyTsS8yc0r+Z/MaCFzhq9YDDI
         IRY5/lHqgXJDPriwljC2fqyPs7N32E577Y+HLIyi6ZuY5dQRL3bPPNjrOeXwIKZhB5
         yMrI7ErzyU9smfIqsIIyFy9wYnSljOe0GmOs98ww5xCzvgfhz7csRdme2z+uuDPXzL
         I3QKwMhRQ9byg==
Subject: Re: [f2fs-dev] [PATCH v4] f2fs: rename checkpoint=merge mount option
 to checkpoint_merge
To:     Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
References: <20210202125716.2635406-1-daeho43@gmail.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <56d08bfe-28e3-e672-f83a-1f3da79c297b@kernel.org>
Date:   Tue, 2 Feb 2021 21:12:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210202125716.2635406-1-daeho43@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/2/2 20:57, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> As checkpoint=merge comes in, mount option setting related to checkpoint
> had been mixed up and it became hard to understand. So, I separated
> this option from "checkpoint=" and made another mount option
> "checkpoint_merge" for this.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> ---
> v2: renamed "checkpoint=merge" to "checkpoint_merge"
> v3: removed "nocheckpoint_merge" option
> v4: re-added "nocheckpoint_merge" option to make it possible to disable
>      just only "checkpoint_merge" when remount
> ---
>   Documentation/filesystems/f2fs.rst |  6 +++---
>   fs/f2fs/super.c                    | 25 +++++++++++++------------
>   2 files changed, 16 insertions(+), 15 deletions(-)
> 
> diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
> index d0ead45dc706..475994ed8b15 100644
> --- a/Documentation/filesystems/f2fs.rst
> +++ b/Documentation/filesystems/f2fs.rst
> @@ -247,9 +247,9 @@ checkpoint=%s[:%u[%]]	 Set to "disable" to turn off checkpointing. Set to "enabl
>   			 hide up to all remaining free space. The actual space that
>   			 would be unusable can be viewed at /sys/fs/f2fs/<disk>/unusable
>   			 This space is reclaimed once checkpoint=enable.
> -			 Here is another option "merge", which creates a kernel daemon
> -			 and makes it to merge concurrent checkpoint requests as much
> -			 as possible to eliminate redundant checkpoint issues. Plus,
> +checkpoint_merge	 When checkpoint is enabled, this can be used to create a kernel
> +			 daemon and make it to merge concurrent checkpoint requests as
> +			 much as possible to eliminate redundant checkpoint issues. Plus,
>   			 we can eliminate the sluggish issue caused by slow checkpoint
>   			 operation when the checkpoint is done in a process context in
>   			 a cgroup having low i/o budget and cpu shares. To make this

nocheckpoint_merge?



> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 56696f6cfa86..f1791b9c1eac 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -145,6 +145,7 @@ enum {
>   	Opt_checkpoint_disable_cap_perc,
>   	Opt_checkpoint_enable,
>   	Opt_checkpoint_merge,
> +	Opt_nocheckpoint_merge,
>   	Opt_compress_algorithm,
>   	Opt_compress_log_size,
>   	Opt_compress_extension,
> @@ -215,7 +216,8 @@ static match_table_t f2fs_tokens = {
>   	{Opt_checkpoint_disable_cap, "checkpoint=disable:%u"},
>   	{Opt_checkpoint_disable_cap_perc, "checkpoint=disable:%u%%"},
>   	{Opt_checkpoint_enable, "checkpoint=enable"},
> -	{Opt_checkpoint_merge, "checkpoint=merge"},
> +	{Opt_checkpoint_merge, "checkpoint_merge"},
> +	{Opt_nocheckpoint_merge, "nocheckpoint_merge"},
>   	{Opt_compress_algorithm, "compress_algorithm=%s"},
>   	{Opt_compress_log_size, "compress_log_size=%u"},
>   	{Opt_compress_extension, "compress_extension=%s"},
> @@ -946,6 +948,9 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
>   		case Opt_checkpoint_merge:
>   			set_opt(sbi, MERGE_CHECKPOINT);
>   			break;
> +		case Opt_nocheckpoint_merge:
> +			clear_opt(sbi, MERGE_CHECKPOINT);
> +			break;
>   #ifdef CONFIG_F2FS_FS_COMPRESSION
>   		case Opt_compress_algorithm:
>   			if (!f2fs_sb_has_compression(sbi)) {
> @@ -1142,12 +1147,6 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
>   		return -EINVAL;
>   	}
>   
> -	if (test_opt(sbi, DISABLE_CHECKPOINT) &&
> -			test_opt(sbi, MERGE_CHECKPOINT)) {
> -		f2fs_err(sbi, "checkpoint=merge cannot be used with checkpoint=disable\n");
> -		return -EINVAL;
> -	}
> -
>   	/* Not pass down write hints if the number of active logs is lesser
>   	 * than NR_CURSEG_PERSIST_TYPE.
>   	 */
> @@ -1782,7 +1781,7 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
>   		seq_printf(seq, ",checkpoint=disable:%u",
>   				F2FS_OPTION(sbi).unusable_cap);
>   	if (test_opt(sbi, MERGE_CHECKPOINT))
> -		seq_puts(seq, ",checkpoint=merge");
> +		seq_puts(seq, ",checkpoint_merge");

else
	seq_puts(seq, ",nocheckpoint_merge");

Thanks,

>   	if (F2FS_OPTION(sbi).fsync_mode == FSYNC_MODE_POSIX)
>   		seq_printf(seq, ",fsync_mode=%s", "posix");
>   	else if (F2FS_OPTION(sbi).fsync_mode == FSYNC_MODE_STRICT)
> @@ -2066,9 +2065,8 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
>   		}
>   	}
>   
> -	if (!test_opt(sbi, MERGE_CHECKPOINT)) {
> -		f2fs_stop_ckpt_thread(sbi);
> -	} else {
> +	if (!test_opt(sbi, DISABLE_CHECKPOINT) &&
> +			test_opt(sbi, MERGE_CHECKPOINT)) {
>   		err = f2fs_start_ckpt_thread(sbi);
>   		if (err) {
>   			f2fs_err(sbi,
> @@ -2076,6 +2074,8 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
>   			    err);
>   			goto restore_gc;
>   		}
> +	} else {
> +		f2fs_stop_ckpt_thread(sbi);
>   	}
>   
>   	/*
> @@ -3831,7 +3831,8 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
>   
>   	/* setup checkpoint request control and start checkpoint issue thread */
>   	f2fs_init_ckpt_req_control(sbi);
> -	if (test_opt(sbi, MERGE_CHECKPOINT)) {
> +	if (!test_opt(sbi, DISABLE_CHECKPOINT) &&
> +			test_opt(sbi, MERGE_CHECKPOINT)) {
>   		err = f2fs_start_ckpt_thread(sbi);
>   		if (err) {
>   			f2fs_err(sbi,
> 
