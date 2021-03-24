Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06175346F63
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 03:20:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234832AbhCXCUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 22:20:23 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14454 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbhCXCTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 22:19:48 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F4sMZ1xSszwPL7;
        Wed, 24 Mar 2021 10:17:46 +0800 (CST)
Received: from [10.136.110.154] (10.136.110.154) by smtp.huawei.com
 (10.3.19.214) with Microsoft SMTP Server (TLS) id 14.3.498.0; Wed, 24 Mar
 2021 10:19:42 +0800
Subject: Re: [PATCH 2/2] f2fs: fix error path of f2fs_remount()
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>
References: <20210317095604.125820-1-yuchao0@huawei.com>
 <20210317095604.125820-2-yuchao0@huawei.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <b3538de1-2bc2-9f58-a586-2571e9891987@huawei.com>
Date:   Wed, 24 Mar 2021 10:19:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20210317095604.125820-2-yuchao0@huawei.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.110.154]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping,

On 2021/3/17 17:56, Chao Yu wrote:
> In error path of f2fs_remount(), it missed to restart/stop kernel thread
> or enable/disable checkpoint, then mount option status may not be
> consistent with real condition of filesystem, so let's reorder remount
> flow a bit as below and do recovery correctly in error path:
> 
> 1) handle gc thread
> 2) handle ckpt thread
> 3) handle flush thread
> 4) handle checkpoint disabling
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>   fs/f2fs/super.c | 47 ++++++++++++++++++++++++++++++++++-------------
>   1 file changed, 34 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 6716af216dca..fa60f08c30bb 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -1942,8 +1942,9 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
>   	struct f2fs_mount_info org_mount_opt;
>   	unsigned long old_sb_flags;
>   	int err;
> -	bool need_restart_gc = false;
> -	bool need_stop_gc = false;
> +	bool need_restart_gc = false, need_stop_gc = false;
> +	bool need_restart_ckpt = false, need_stop_ckpt = false;
> +	bool need_restart_flush = false, need_stop_flush = false;
>   	bool no_extent_cache = !test_opt(sbi, EXTENT_CACHE);
>   	bool disable_checkpoint = test_opt(sbi, DISABLE_CHECKPOINT);
>   	bool no_io_align = !F2FS_IO_ALIGNED(sbi);
> @@ -2081,19 +2082,10 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
>   		clear_sbi_flag(sbi, SBI_IS_CLOSE);
>   	}
>   
> -	if (checkpoint_changed) {
> -		if (test_opt(sbi, DISABLE_CHECKPOINT)) {
> -			err = f2fs_disable_checkpoint(sbi);
> -			if (err)
> -				goto restore_gc;
> -		} else {
> -			f2fs_enable_checkpoint(sbi);
> -		}
> -	}
> -
>   	if ((*flags & SB_RDONLY) || test_opt(sbi, DISABLE_CHECKPOINT) ||
>   			!test_opt(sbi, MERGE_CHECKPOINT)) {
>   		f2fs_stop_ckpt_thread(sbi);
> +		need_restart_ckpt = true;
>   	} else {
>   		err = f2fs_start_ckpt_thread(sbi);
>   		if (err) {
> @@ -2102,6 +2094,7 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
>   			    err);
>   			goto restore_gc;
>   		}
> +		need_stop_ckpt = true;
>   	}
>   
>   	/*
> @@ -2111,11 +2104,24 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
>   	if ((*flags & SB_RDONLY) || !test_opt(sbi, FLUSH_MERGE)) {
>   		clear_opt(sbi, FLUSH_MERGE);
>   		f2fs_destroy_flush_cmd_control(sbi, false);
> +		need_restart_flush = true;
>   	} else {
>   		err = f2fs_create_flush_cmd_control(sbi);
>   		if (err)
> -			goto restore_gc;
> +			goto restore_ckpt;
> +		need_stop_flush = true;
>   	}
> +
> +	if (checkpoint_changed) {
> +		if (test_opt(sbi, DISABLE_CHECKPOINT)) {
> +			err = f2fs_disable_checkpoint(sbi);
> +			if (err)
> +				goto restore_flush;
> +		} else {
> +			f2fs_enable_checkpoint(sbi);
> +		}
> +	}
> +
>   skip:
>   #ifdef CONFIG_QUOTA
>   	/* Release old quota file names */
> @@ -2130,6 +2136,21 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
>   	adjust_unusable_cap_perc(sbi);
>   	*flags = (*flags & ~SB_LAZYTIME) | (sb->s_flags & SB_LAZYTIME);
>   	return 0;
> +restore_flush:
> +	if (need_restart_flush) {
> +		if (f2fs_create_flush_cmd_control(sbi))
> +			f2fs_warn(sbi, "background flush thread has stopped");
> +	} else if (need_stop_flush) {
> +		clear_opt(sbi, FLUSH_MERGE);
> +		f2fs_destroy_flush_cmd_control(sbi, false);
> +	}
> +restore_ckpt:
> +	if (need_restart_ckpt) {
> +		if (f2fs_start_ckpt_thread(sbi))
> +			f2fs_warn(sbi, "background ckpt thread has stopped");
> +	} else if (need_stop_ckpt) {
> +		f2fs_stop_ckpt_thread(sbi);
> +	}
>   restore_gc:
>   	if (need_restart_gc) {
>   		if (f2fs_start_gc_thread(sbi))
> 
