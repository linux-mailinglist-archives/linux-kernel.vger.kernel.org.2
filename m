Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 997A140B219
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 16:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233908AbhINOx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 10:53:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:43358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233309AbhINOx1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 10:53:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 44F4760FD7;
        Tue, 14 Sep 2021 14:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1631631129;
        bh=Y+WZnwZuFQFsEIab6A5HpdFBYcNOEYbJDOHV6UOEYcc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TRSjj/o38HtRm4I3MwadxstUKa903ijAhzeepfzozjzA/mXS8+JgMXp3XHPoUicpS
         8hx0Wv5LlKQpOBhIzI5eegcAyTb7dxxkWMkGHBzfb5eenN9ycGpDbo0OZuALc9HJp4
         58pkQVfmzstZwbcC6M6aCtt92B6fQqpHrgo5y1UM=
Date:   Tue, 14 Sep 2021 16:52:07 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jackie Liu <liu.yun@linux.dev>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mdacon: fix redefinition of 'scr_memsetw'
Message-ID: <YUC3F5V6JjIb71VS@kroah.com>
References: <20210907020326.2329486-1-liu.yun@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210907020326.2329486-1-liu.yun@linux.dev>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 07, 2021 at 10:03:26AM +0800, Jackie Liu wrote:
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
> Fixes: ac036f9570a2 ("vga: optimise console scrolling")
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
> index 848db1b1569f..3a79cc27a33b 100644
> --- a/include/linux/vt_buffer.h
> +++ b/include/linux/vt_buffer.h
> @@ -16,7 +16,7 @@
>  
>  #include <linux/string.h>
>  
> -#if defined(CONFIG_VGA_CONSOLE) || defined(CONFIG_MDA_CONSOLE)
> +#if defined(CONFIG_VGA_CONSOLE) || IS_ENABLED(CONFIG_MDA_CONSOLE)
>  #include <asm/vga.h>
>  #endif
>  
> -- 
> 2.25.1
> 

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

This needs to go through the dri-devel mailing list, please resubmit it
with my reviewed-by on it.

thanks,

greg k-h
