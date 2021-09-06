Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF2C2401A1E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 12:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241231AbhIFKrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 06:47:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:52080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241194AbhIFKrJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 06:47:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 23BEE6056C;
        Mon,  6 Sep 2021 10:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1630925164;
        bh=nkt6YdC2fvjv2R61BatWeT1Biq4yHRYc7LagT+ARMgY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qMxoo9QvpiVDf2qd3DNblfRozyaZHbZ2xc4bBS9SPvuUFmHJqRlhae9XovPqG7a0A
         yt9X3SF+6981uzRFt7IYDFuXkcU4zOO5aAQDKExBrnk3l3Qf7ZnmKV3F36JAWjpRAu
         RydBst1cjzHKhXljImxJpVGoDhYGVYjqucgsQLwI=
Date:   Mon, 6 Sep 2021 12:46:01 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jackie Liu <liu.yun@linux.dev>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mdacon: fix redefinition of 'scr_memsetw'
Message-ID: <YTXxaU+w0mTgeL2K@kroah.com>
References: <20210906102030.1659910-1-liu.yun@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210906102030.1659910-1-liu.yun@linux.dev>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 06, 2021 at 06:20:30PM +0800, Jackie Liu wrote:
> From: Jackie Liu <liuyun01@kylinos.cn>
> 
> CONFIG_VGA_CONSOLE=n and CONFIG_MDA_CONSOLE=n will cause vt_buffer.h not
> include <asm/vga.h>.
> 
> But if we set CONFIG_MDA_CONSOLE=m, mdacon.c include <linux/vt_buffer.h>
> is in front of include <asm/vga.h>. VT_BUF_HAVE_MEMSETW is not defined,
> so vt_buffer.h will define a scr_memsetw, after that, vga.h also define
> a scr_memsetw, so the repeated definition of scr_memsetw appears, builds
> error.
> 
> We only need to make vt_buffer.h also contain vga.h when
> CONFIG_MDA_CONSOLE=m. This problem can be fixed.
> 
> BTW, mdacon.c no need to include vga.h forcibly, let vt_buffer.h do it.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

As this has always been an issue, how is this really a "fix"?

How can the above config options be set in this manner, do you have to
do it manually or does a system really need that configuration?


> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-fbdev@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
> ---
>  drivers/video/console/mdacon.c | 1 -
>  include/linux/vt_buffer.h      | 2 +-
>  2 files changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/video/console/mdacon.c b/drivers/video/console/mdacon.c
> index ef29b321967f..5898d01bc492 100644
> --- a/drivers/video/console/mdacon.c
> +++ b/drivers/video/console/mdacon.c
> @@ -42,7 +42,6 @@
>  #include <linux/init.h>
>  
>  #include <asm/io.h>
> -#include <asm/vga.h>
>  
>  static DEFINE_SPINLOCK(mda_lock);
>  
> diff --git a/include/linux/vt_buffer.h b/include/linux/vt_buffer.h
> index 848db1b1569f..3e71f879e7c0 100644
> --- a/include/linux/vt_buffer.h
> +++ b/include/linux/vt_buffer.h
> @@ -16,7 +16,7 @@
>  
>  #include <linux/string.h>
>  
> -#if defined(CONFIG_VGA_CONSOLE) || defined(CONFIG_MDA_CONSOLE)
> +#if defined(CONFIG_VGA_CONSOLE) || defined(CONFIG_MDA_CONSOLE) || defined(CONFIG_MDA_CONSOLE_MODULE)

If this really is needed, please use the correct define macro that
catches both of these options.

thanks,

greg k-h
