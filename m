Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45D113EB62D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 15:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240673AbhHMNp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 09:45:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:44962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240645AbhHMNms (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 09:42:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EDE3960F11;
        Fri, 13 Aug 2021 13:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628862141;
        bh=Radl4pPmym29zKnvSluX6pjnKXnMALkTFS4XBhELDe0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Ovxa1ucL3c7DZ6Dbvwem0ix7QmgczSXzEQeDcG/qdzEEkDZvcKJQQolAhTTOjkBk5
         ngR+o65v4bb8E/DMkLU6CtUKa5GZTCe2bq75AFw/LagEpAewVlrYayLF6u6Dais0lk
         k1yGDwlOzEbaOREoNaDx4zPTkCGld3MC/ZErM9lmhy/eIpgQnL1OJljKiIAthCRmtp
         GjWcdosb1ciYUaYMfiIChgmK9g9huWfPUGbr+BhuHt15rWCUA6C+rw8azZOsLbNZUh
         yWlH3QZVklvo/cFWcPEcDnLZNSu6YtMvTJ8yorMWCBv3jGLtG6lG9/hFrKZGAm96bb
         GfQAPHGFfryUg==
Subject: Re: [PATCH v2] f2fs: Don't create discard thread when device not
 support realtime discard
To:     Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Fengnan Chang <changfengnan@vivo.com>
References: <20210813101132.441389-1-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <746edfbc-ae29-b84b-f83f-4093a398804b@kernel.org>
Date:   Fri, 13 Aug 2021 21:42:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210813101132.441389-1-frank.li@vivo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/8/13 18:11, Yangtao Li wrote:
> From: Fengnan Chang <changfengnan@vivo.com>
> 
> Don't create discard thread when device not support realtime discard.
> 
> Signed-off-by: Fengnan Chang <changfengnan@vivo.com>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>   fs/f2fs/f2fs.h    |  1 +
>   fs/f2fs/segment.c | 29 +++++++++++++++++++++--------
>   fs/f2fs/super.c   | 34 ++++++++++++++++++++++++++++++++--
>   3 files changed, 54 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index d24fd5045712..60a408af53a3 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -3483,6 +3483,7 @@ int f2fs_flush_device_cache(struct f2fs_sb_info *sbi);
>   void f2fs_destroy_flush_cmd_control(struct f2fs_sb_info *sbi, bool free);
>   void f2fs_invalidate_blocks(struct f2fs_sb_info *sbi, block_t addr);
>   bool f2fs_is_checkpointed_data(struct f2fs_sb_info *sbi, block_t blkaddr);
> +int f2fs_start_discard_thread(struct f2fs_sb_info *sbi);
>   void f2fs_drop_discard_cmd(struct f2fs_sb_info *sbi);
>   void f2fs_stop_discard_thread(struct f2fs_sb_info *sbi);
>   bool f2fs_issue_discard_timeout(struct f2fs_sb_info *sbi);
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index ca9876a6d396..b83a4a1e5023 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -2112,7 +2112,27 @@ void f2fs_clear_prefree_segments(struct f2fs_sb_info *sbi,
>   wakeup:
>   	wake_up_discard_thread(sbi, false);
>   }

Need a blank line here.

> +int f2fs_start_discard_thread(struct f2fs_sb_info *sbi)
> +{
> +	dev_t dev = sbi->sb->s_bdev->bd_dev;
> +	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
> +	int err = 0;
>   
> +	if (!dcc)
> +		return -EINVAL;
> +	if (!f2fs_realtime_discard_enable(sbi))
> +		return 0;
> +
> +	dcc->f2fs_issue_discard = kthread_run(issue_discard_thread, sbi,
> +				"f2fs_discard-%u:%u", MAJOR(dev), MINOR(dev));
> +	if (IS_ERR(dcc->f2fs_issue_discard)) {
> +		err = PTR_ERR(dcc->f2fs_issue_discard);
> +		kfree(dcc);
> +		SM_I(sbi)->dcc_info = NULL;
> +		return err;
> +	}
> +	return err;
> +}

Ditto,

>   static int create_discard_cmd_control(struct f2fs_sb_info *sbi)
>   {
>   	dev_t dev = sbi->sb->s_bdev->bd_dev;

Need to remove unused dev.

> @@ -2153,14 +2173,7 @@ static int create_discard_cmd_control(struct f2fs_sb_info *sbi)
>   	init_waitqueue_head(&dcc->discard_wait_queue);
>   	SM_I(sbi)->dcc_info = dcc;
>   init_thread:
> -	dcc->f2fs_issue_discard = kthread_run(issue_discard_thread, sbi,
> -				"f2fs_discard-%u:%u", MAJOR(dev), MINOR(dev));
> -	if (IS_ERR(dcc->f2fs_issue_discard)) {
> -		err = PTR_ERR(dcc->f2fs_issue_discard);
> -		kfree(dcc);
> -		SM_I(sbi)->dcc_info = NULL;
> -		return err;
> -	}
> +	err = f2fs_start_discard_thread(sbi);
>   
>   	return err;

return f2fs_start_discard_thread(sbi);

err becomes unused.

>   }
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 84cd085020cd..ff19c30cd6a1 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -2101,12 +2101,15 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
>   	bool need_restart_gc = false, need_stop_gc = false;
>   	bool need_restart_ckpt = false, need_stop_ckpt = false;
>   	bool need_restart_flush = false, need_stop_flush = false;
> +	bool need_enable_ckpt = false, need_disable_ckpt = false;
>   	bool no_extent_cache = !test_opt(sbi, EXTENT_CACHE);
>   	bool enable_checkpoint = !test_opt(sbi, DISABLE_CHECKPOINT);
>   	bool no_io_align = !F2FS_IO_ALIGNED(sbi);
>   	bool no_atgc = !test_opt(sbi, ATGC);
> +	bool no_discard = !test_opt(sbi, DISCARD);
>   	bool no_compress_cache = !test_opt(sbi, COMPRESS_CACHE);
>   	bool block_unit_discard = f2fs_block_unit_discard(sbi);
> +	struct discard_cmd_control *dcc;
>   #ifdef CONFIG_QUOTA
>   	int i, j;
>   #endif
> @@ -2274,7 +2277,7 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
>   	} else {
>   		err = f2fs_create_flush_cmd_control(sbi);
>   		if (err)
> -			goto restore_ckpt;
> +			goto restore_ckpt_thread;
>   		need_stop_flush = true;
>   	}
>   
> @@ -2283,8 +2286,28 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
>   			err = f2fs_disable_checkpoint(sbi);
>   			if (err)
>   				goto restore_flush;
> +			need_enable_ckpt = true;
>   		} else {
>   			f2fs_enable_checkpoint(sbi);
> +			need_disable_ckpt = true;
> +		}
> +	}
> +
> +	if (no_discard == !!test_opt(sbi, DISCARD)) {
> +		if (test_opt(sbi, DISCARD)) {
> +			err = f2fs_start_discard_thread(sbi);
> +			if (err)
> +				goto restore_ckpt;
> +

Unneeded blank line.

> +		} else {
> +			dcc = SM_I(sbi)->dcc_info;
> +			if (!dcc) {
> +				err = -EINVAL;
> +				goto restore_ckpt;
> +			}
> +			f2fs_stop_discard_thread(sbi);
> +			if (unlikely(atomic_read(&dcc->discard_cmd_cnt)))

I don't think this is an unlikely case.

> +				f2fs_issue_discard_timeout(sbi);

How about starting/stopping discard thread after flush thread status update,
leaving complicated checkpoint disabling status change in the last stage of
remount().

Thanks,

>   		}
>   	}
>   
> @@ -2302,6 +2325,13 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
>   	adjust_unusable_cap_perc(sbi);
>   	*flags = (*flags & ~SB_LAZYTIME) | (sb->s_flags & SB_LAZYTIME);
>   	return 0;
> +restore_ckpt:
> +	if (need_enable_ckpt) {
> +		f2fs_enable_checkpoint(sbi);
> +	} else if (need_disable_ckpt) {
> +		if (f2fs_disable_checkpoint(sbi))
> +			f2fs_warn(sbi, "checkpoint has been enable");
> +	}
>   restore_flush:
>   	if (need_restart_flush) {
>   		if (f2fs_create_flush_cmd_control(sbi))
> @@ -2310,7 +2340,7 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
>   		clear_opt(sbi, FLUSH_MERGE);
>   		f2fs_destroy_flush_cmd_control(sbi, false);
>   	}
> -restore_ckpt:
> +restore_ckpt_thread:
>   	if (need_restart_ckpt) {
>   		if (f2fs_start_ckpt_thread(sbi))
>   			f2fs_warn(sbi, "background ckpt thread has stopped");
> 
