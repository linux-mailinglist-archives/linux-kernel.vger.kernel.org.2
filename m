Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1F644A542
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 04:16:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236734AbhKIDTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 22:19:38 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:57300 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231910AbhKIDTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 22:19:36 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Uvj108s_1636427808;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Uvj108s_1636427808)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 09 Nov 2021 11:16:49 +0800
Date:   Tue, 9 Nov 2021 11:16:47 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Huang Jianan <huangjianan@oppo.com>
Cc:     linux-erofs@lists.ozlabs.org, zhangshiming@oppo.com,
        linux-kernel@vger.kernel.org, yh@oppo.com, guanyuwei@oppo.com,
        guoweichao@oppo.com
Subject: Re: [PATCH 2/2] erofs: add sysfs node to control sync decompression
 strategy
Message-ID: <YYnoHw+boVFtcyfv@B-P7TQMD6M-0146.local>
References: <20211109025445.12427-1-huangjianan@oppo.com>
 <20211109025445.12427-2-huangjianan@oppo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211109025445.12427-2-huangjianan@oppo.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 09, 2021 at 10:54:45AM +0800, Huang Jianan via Linux-erofs wrote:
> Although readpage is a synchronous path, there will be no additional
> kworker scheduling overhead in non-atomic contexts. So we can add a
> sysfs node to allow disable sync decompression.
> 
> Signed-off-by: Huang Jianan <huangjianan@oppo.com>
> ---
>  fs/erofs/internal.h | 2 +-
>  fs/erofs/super.c    | 2 +-
>  fs/erofs/sysfs.c    | 6 ++++++
>  fs/erofs/zdata.c    | 9 ++++-----
>  4 files changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index d0cd712dc222..1ab96878009d 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -60,7 +60,7 @@ struct erofs_mount_opts {
>  #ifdef CONFIG_EROFS_FS_ZIP
>  	/* current strategy of how to use managed cache */
>  	unsigned char cache_strategy;
> -	/* strategy of sync decompression (false - auto, true - force on) */
> +	/* strategy of sync decompression (false - disable, true - force on) */

Please leave false - auto.

>  	bool readahead_sync_decompress;
>  
>  	/* threshold for decompression synchronously */
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index abc1da5d1719..26585d865503 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -423,7 +423,7 @@ static void erofs_default_options(struct erofs_fs_context *ctx)
>  #ifdef CONFIG_EROFS_FS_ZIP
>  	ctx->opt.cache_strategy = EROFS_ZIP_CACHE_READAROUND;
>  	ctx->opt.max_sync_decompress_pages = 3;
> -	ctx->opt.readahead_sync_decompress = false;
> +	ctx->opt.readahead_sync_decompress = true;

Please leave readahead_sync_decompress = false 'auto' by default.

I don't like .readpage() applies async decompression since it's
actually a sync way, otherwise, it will cause more scheduling
overhead, see:
https://lore.kernel.org/r/20201016160443.18685-1-willy@infradead.org
https://lore.kernel.org/r/20201102184312.25926-16-willy@infradead.org

Thanks,
Gao Xiang
