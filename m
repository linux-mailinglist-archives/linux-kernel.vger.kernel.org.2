Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6963E34B5FF
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 11:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbhC0KO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Mar 2021 06:14:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35327 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231578AbhC0KOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Mar 2021 06:14:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616840060;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Fsa8VU2xZ1P0wybVp4CSJVy1CTBmO1YYJLwtPPDO5xw=;
        b=VEzQ8Yg7Kh2PnU3XA+IxNW8bVwNuwf4fMfkHu9kZhlxG3xKfe0POeBNf1V4TQgsfWBiUIN
        nRq/jQTUb+tGeGgsDdexHpPd1UVgDxWELtp7dHTXYwSPHRi99mTwTjv3EJxTZEruOU5SAO
        BACZn6hrjelI/7iibSuBcXVf7Gatv3M=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-aVsIWi7oNeqioAs05waxfQ-1; Sat, 27 Mar 2021 06:14:18 -0400
X-MC-Unique: aVsIWi7oNeqioAs05waxfQ-1
Received: by mail-pl1-f199.google.com with SMTP id q11so3966922plx.22
        for <linux-kernel@vger.kernel.org>; Sat, 27 Mar 2021 03:14:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Fsa8VU2xZ1P0wybVp4CSJVy1CTBmO1YYJLwtPPDO5xw=;
        b=cW/ewsGkGcqA+/6EznWvPclGsDGU3fTGWwZ7vh6zL4YRTT3Ahlmk6oTLe1+0Hlmg5d
         x7AP7CmYFDoyeFn2wKscDiHB5wTgmNS5PmKeMI+sHR1Lr2rCesICuwN38e7CViXAZ23p
         kJ3HdMs7cTFuOvZWBarEvEr3V9v7xPonvXdouliI+pFSL2vmuL2fR9vXV/gx7djeQlRF
         /H55W69egWXc9xVGQ0yMt6YN09Lzq76vSgEizwCDZeUF6e4wMjlSP5jSy2oqaDlGmsjW
         5DLrtEp5zE4gz7FnMcX2UARuKFy0qw/tqdpzYcQUty2wNRSEwZ/yG4+zybi7k4USb2L8
         5jgA==
X-Gm-Message-State: AOAM5333b4yehaOmhOSghcqSHWAPILbDLork2TG2J6ATVHfZK62+AfLZ
        L7xiLTbWJkIBFBdAOh86jNiv081Z+npWK1X9zrYEtm2ru5lqeoazwbI2Sv0V+J2XB5WOAyG1gKR
        RR4bp7Trx3Pe3xEOtxHSgUnW3
X-Received: by 2002:a62:cfc1:0:b029:200:1eed:462 with SMTP id b184-20020a62cfc10000b02902001eed0462mr16788976pfg.55.1616840057130;
        Sat, 27 Mar 2021 03:14:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw8Q8Jj9Fg+lnufsohqsWNXtIw2Vt12+SuuBS4bdCo34TGoa9RmUevk5q8GVCimulIX8SJEdA==
X-Received: by 2002:a62:cfc1:0:b029:200:1eed:462 with SMTP id b184-20020a62cfc10000b02902001eed0462mr16788956pfg.55.1616840056806;
        Sat, 27 Mar 2021 03:14:16 -0700 (PDT)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id y9sm10640279pja.50.2021.03.27.03.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 03:14:16 -0700 (PDT)
Date:   Sat, 27 Mar 2021 18:14:05 +0800
From:   Gao Xiang <hsiangkao@redhat.com>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, chao@kernel.org,
        Gao Xiang <xiang@kernel.org>
Subject: Re: [PATCH] f2fs: introduce gc_merge mount option
Message-ID: <20210327101405.GA2995728@xiangao.remote.csb>
References: <20210327095706.63583-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210327095706.63583-1-yuchao0@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 27, 2021 at 05:57:06PM +0800, Chao Yu wrote:
> In this patch, we will add two new mount options: "gc_merge" and
> "nogc_merge", when background_gc is on, "gc_merge" option can be
> set to let background GC thread to handle foreground GC requests,
> it can eliminate the sluggish issue caused by slow foreground GC
> operation when GC is triggered from a process with limited I/O
> and CPU resources.
> 
> Original idea is from Xiang.
> 
> Signed-off-by: Gao Xiang <xiang@kernel.org>
> Signed-off-by: Chao Yu <yuchao0@huawei.com>

Ah, that was a quite old commit many years ago due to priority inversion
issue ;-) I vaguely remembered some potential wakeup race condition which
was addressed in the internal branch...Yet I have no idea about those now
LOL.

Thanks for redoing this and sending it out to the upstream... :-)

Thanks,
Gao Xiang

> ---
>  Documentation/filesystems/f2fs.rst |  6 ++++++
>  fs/f2fs/f2fs.h                     |  1 +
>  fs/f2fs/gc.c                       | 26 ++++++++++++++++++++++----
>  fs/f2fs/gc.h                       |  6 ++++++
>  fs/f2fs/segment.c                  | 15 +++++++++++++--
>  fs/f2fs/super.c                    | 19 +++++++++++++++++--
>  6 files changed, 65 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
> index 35ed01a5fbc9..63c0c49b726d 100644
> --- a/Documentation/filesystems/f2fs.rst
> +++ b/Documentation/filesystems/f2fs.rst
> @@ -110,6 +110,12 @@ background_gc=%s	 Turn on/off cleaning operations, namely garbage
>  			 on synchronous garbage collection running in background.
>  			 Default value for this option is on. So garbage
>  			 collection is on by default.
> +gc_merge		 When background_gc is on, this option can be enabled to
> +			 let background GC thread to handle foreground GC requests,
> +			 it can eliminate the sluggish issue caused by slow foreground
> +			 GC operation when GC is triggered from a process with limited
> +			 I/O and CPU resources.
> +nogc_merge		 Disable GC merge feature.
>  disable_roll_forward	 Disable the roll-forward recovery routine
>  norecovery		 Disable the roll-forward recovery routine, mounted read-
>  			 only (i.e., -o ro,disable_roll_forward)
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index fe380bcf8d4d..87d734f5589d 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -97,6 +97,7 @@ extern const char *f2fs_fault_name[FAULT_MAX];
>  #define F2FS_MOUNT_NORECOVERY		0x04000000
>  #define F2FS_MOUNT_ATGC			0x08000000
>  #define F2FS_MOUNT_MERGE_CHECKPOINT	0x10000000
> +#define	F2FS_MOUNT_GC_MERGE		0x20000000
>  
>  #define F2FS_OPTION(sbi)	((sbi)->mount_opt)
>  #define clear_opt(sbi, option)	(F2FS_OPTION(sbi).opt &= ~F2FS_MOUNT_##option)
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index a2ca483f9855..5c48825fd12d 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -31,19 +31,24 @@ static int gc_thread_func(void *data)
>  	struct f2fs_sb_info *sbi = data;
>  	struct f2fs_gc_kthread *gc_th = sbi->gc_thread;
>  	wait_queue_head_t *wq = &sbi->gc_thread->gc_wait_queue_head;
> +	wait_queue_head_t *fggc_wq = &sbi->gc_thread->fggc_wq;
>  	unsigned int wait_ms;
>  
>  	wait_ms = gc_th->min_sleep_time;
>  
>  	set_freezable();
>  	do {
> -		bool sync_mode;
> +		bool sync_mode, foreground = false;
>  
>  		wait_event_interruptible_timeout(*wq,
>  				kthread_should_stop() || freezing(current) ||
> +				waitqueue_active(fggc_wq) ||
>  				gc_th->gc_wake,
>  				msecs_to_jiffies(wait_ms));
>  
> +		if (test_opt(sbi, GC_MERGE) && waitqueue_active(fggc_wq))
> +			foreground = true;
> +
>  		/* give it a try one time */
>  		if (gc_th->gc_wake)
>  			gc_th->gc_wake = 0;
> @@ -90,7 +95,10 @@ static int gc_thread_func(void *data)
>  			goto do_gc;
>  		}
>  
> -		if (!down_write_trylock(&sbi->gc_lock)) {
> +		if (foreground) {
> +			down_write(&sbi->gc_lock);
> +			goto do_gc;
> +		} else if (!down_write_trylock(&sbi->gc_lock)) {
>  			stat_other_skip_bggc_count(sbi);
>  			goto next;
>  		}
> @@ -107,14 +115,22 @@ static int gc_thread_func(void *data)
>  		else
>  			increase_sleep_time(gc_th, &wait_ms);
>  do_gc:
> -		stat_inc_bggc_count(sbi->stat_info);
> +		if (!foreground)
> +			stat_inc_bggc_count(sbi->stat_info);
>  
>  		sync_mode = F2FS_OPTION(sbi).bggc_mode == BGGC_MODE_SYNC;
>  
> +		/* foreground GC was been triggered via f2fs_balance_fs() */
> +		if (foreground)
> +			sync_mode = false;
> +
>  		/* if return value is not zero, no victim was selected */
> -		if (f2fs_gc(sbi, sync_mode, true, false, NULL_SEGNO))
> +		if (f2fs_gc(sbi, sync_mode, !foreground, false, NULL_SEGNO))
>  			wait_ms = gc_th->no_gc_sleep_time;
>  
> +		if (foreground)
> +			wake_up_all(&gc_th->fggc_wq);
> +
>  		trace_f2fs_background_gc(sbi->sb, wait_ms,
>  				prefree_segments(sbi), free_segments(sbi));
>  
> @@ -148,6 +164,7 @@ int f2fs_start_gc_thread(struct f2fs_sb_info *sbi)
>  
>  	sbi->gc_thread = gc_th;
>  	init_waitqueue_head(&sbi->gc_thread->gc_wait_queue_head);
> +	init_waitqueue_head(&sbi->gc_thread->fggc_wq);
>  	sbi->gc_thread->f2fs_gc_task = kthread_run(gc_thread_func, sbi,
>  			"f2fs_gc-%u:%u", MAJOR(dev), MINOR(dev));
>  	if (IS_ERR(gc_th->f2fs_gc_task)) {
> @@ -165,6 +182,7 @@ void f2fs_stop_gc_thread(struct f2fs_sb_info *sbi)
>  	if (!gc_th)
>  		return;
>  	kthread_stop(gc_th->f2fs_gc_task);
> +	wake_up_all(&gc_th->fggc_wq);
>  	kfree(gc_th);
>  	sbi->gc_thread = NULL;
>  }
> diff --git a/fs/f2fs/gc.h b/fs/f2fs/gc.h
> index 0c8dae12dc51..3fe145e8e594 100644
> --- a/fs/f2fs/gc.h
> +++ b/fs/f2fs/gc.h
> @@ -42,6 +42,12 @@ struct f2fs_gc_kthread {
>  
>  	/* for changing gc mode */
>  	unsigned int gc_wake;
> +
> +	/* for GC_MERGE mount option */
> +	wait_queue_head_t fggc_wq;		/*
> +						 * caller of f2fs_balance_fs()
> +						 * will wait on this wait queue.
> +						 */
>  };
>  
>  struct gc_inode_list {
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 24ad45f5e335..31ccea1378fa 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -503,8 +503,19 @@ void f2fs_balance_fs(struct f2fs_sb_info *sbi, bool need)
>  	 * dir/node pages without enough free segments.
>  	 */
>  	if (has_not_enough_free_secs(sbi, 0, 0)) {
> -		down_write(&sbi->gc_lock);
> -		f2fs_gc(sbi, false, false, false, NULL_SEGNO);
> +		if (test_opt(sbi, GC_MERGE) && sbi->gc_thread &&
> +					sbi->gc_thread->f2fs_gc_task) {
> +			DEFINE_WAIT(wait);
> +
> +			prepare_to_wait(&sbi->gc_thread->fggc_wq, &wait,
> +						TASK_UNINTERRUPTIBLE);
> +			wake_up(&sbi->gc_thread->gc_wait_queue_head);
> +			io_schedule();
> +			finish_wait(&sbi->gc_thread->fggc_wq, &wait);
> +		} else {
> +			down_write(&sbi->gc_lock);
> +			f2fs_gc(sbi, false, false, false, NULL_SEGNO);
> +		}
>  	}
>  }
>  
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index b48281642e98..954b1fe97d67 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -151,6 +151,8 @@ enum {
>  	Opt_compress_chksum,
>  	Opt_compress_mode,
>  	Opt_atgc,
> +	Opt_gc_merge,
> +	Opt_nogc_merge,
>  	Opt_err,
>  };
>  
> @@ -223,6 +225,8 @@ static match_table_t f2fs_tokens = {
>  	{Opt_compress_chksum, "compress_chksum"},
>  	{Opt_compress_mode, "compress_mode=%s"},
>  	{Opt_atgc, "atgc"},
> +	{Opt_gc_merge, "gc_merge"},
> +	{Opt_nogc_merge, "nogc_merge"},
>  	{Opt_err, NULL},
>  };
>  
> @@ -1073,6 +1077,12 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
>  		case Opt_atgc:
>  			set_opt(sbi, ATGC);
>  			break;
> +		case Opt_gc_merge:
> +			set_opt(sbi, GC_MERGE);
> +			break;
> +		case Opt_nogc_merge:
> +			clear_opt(sbi, GC_MERGE);
> +			break;
>  		default:
>  			f2fs_err(sbi, "Unrecognized mount option \"%s\" or missing value",
>  				 p);
> @@ -1675,6 +1685,9 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
>  	else if (F2FS_OPTION(sbi).bggc_mode == BGGC_MODE_OFF)
>  		seq_printf(seq, ",background_gc=%s", "off");
>  
> +	if (test_opt(sbi, GC_MERGE))
> +		seq_puts(seq, ",gc_merge");
> +
>  	if (test_opt(sbi, DISABLE_ROLL_FORWARD))
>  		seq_puts(seq, ",disable_roll_forward");
>  	if (test_opt(sbi, NORECOVERY))
> @@ -2038,7 +2051,8 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
>  	 * option. Also sync the filesystem.
>  	 */
>  	if ((*flags & SB_RDONLY) ||
> -			F2FS_OPTION(sbi).bggc_mode == BGGC_MODE_OFF) {
> +			(F2FS_OPTION(sbi).bggc_mode == BGGC_MODE_OFF &&
> +			!test_opt(sbi, GC_MERGE))) {
>  		if (sbi->gc_thread) {
>  			f2fs_stop_gc_thread(sbi);
>  			need_restart_gc = true;
> @@ -4012,7 +4026,8 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
>  	 * If filesystem is not mounted as read-only then
>  	 * do start the gc_thread.
>  	 */
> -	if (F2FS_OPTION(sbi).bggc_mode != BGGC_MODE_OFF && !f2fs_readonly(sb)) {
> +	if ((F2FS_OPTION(sbi).bggc_mode != BGGC_MODE_OFF ||
> +		test_opt(sbi, GC_MERGE)) && !f2fs_readonly(sb)) {
>  		/* After POR, we can run background GC thread.*/
>  		err = f2fs_start_gc_thread(sbi);
>  		if (err)
> -- 
> 2.29.2
> 

