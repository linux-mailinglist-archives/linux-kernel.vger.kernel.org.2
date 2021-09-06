Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ADE2401C9F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 15:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242954AbhIFNuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 09:50:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:35012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242923AbhIFNuE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 09:50:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F116A60F45;
        Mon,  6 Sep 2021 13:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1630936137;
        bh=O2u3dRz1I/k4SIKfGPpnxsEOUFKz5BU7o5DGdl2zzZo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iL9xGU9pn6KUihej648lzeqyPd1LULPsSpyG26GwDqC0aKuf958MIhnI2lTmaljGw
         wtpVJwOBQ6M0bZnGBndFO6Tt3QbwFBixigq2ayK+M4CgQ3FQdsbxo5unTkArfKVeid
         yn+r6xcs9xm5OAoEDFR7IBC4gDpwkG4uVD15LZJw=
Date:   Mon, 6 Sep 2021 15:48:55 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jackie Liu <liu.yun@linux.dev>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mdacon: fix redefinition of 'scr_memsetw'
Message-ID: <YTYcRwUewqvpsJGY@kroah.com>
References: <YTXxaU+w0mTgeL2K@kroah.com>
 <20210906102030.1659910-1-liu.yun@linux.dev>
 <f5092b702487f29a245ec2b2725fe9e3@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f5092b702487f29a245ec2b2725fe9e3@linux.dev>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 06, 2021 at 01:44:21PM +0000, Jackie Liu wrote:
> Hi, Greg.
> 
> 
> September 6, 2021 6:46 PM, "Greg KH" <gregkh@linuxfoundation.org> 写到:
> 
> > On Mon, Sep 06, 2021 at 06:20:30PM +0800, Jackie Liu wrote:
> > 
> >> From: Jackie Liu <liuyun01@kylinos.cn>
> >> 
> >> CONFIG_VGA_CONSOLE=n and CONFIG_MDA_CONSOLE=n will cause vt_buffer.h not
> >> include <asm/vga.h>.
> >> 
> >> But if we set CONFIG_MDA_CONSOLE=m, mdacon.c include <linux/vt_buffer.h>
> >> is in front of include <asm/vga.h>. VT_BUF_HAVE_MEMSETW is not defined,
> >> so vt_buffer.h will define a scr_memsetw, after that, vga.h also define
> >> a scr_memsetw, so the repeated definition of scr_memsetw appears, builds
> >> error.
> >> 
> >> We only need to make vt_buffer.h also contain vga.h when
> >> CONFIG_MDA_CONSOLE=m. This problem can be fixed.
> >> 
> >> BTW, mdacon.c no need to include vga.h forcibly, let vt_buffer.h do it.
> >> 
> >> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > 
> > As this has always been an issue, how is this really a "fix"?
> 
> The problem has always existed, but there will be no compilation errors.
> The driver needs to include <asm/vga.h> at the beginning if we want build
> CONFIG_MDA_CONSOLE=m
> 
> After ac036f9570a2, redefined 'scr_memsetw'. but they are not arm and x86 architectures,
> so it's not very important. It can also be Fixes: ac036f9570a2 ("vga: optimise console scrolling")

That might make more sense to put here, instead of the "beginning of
history".

> > How can the above config options be set in this manner, do you have to
> > do it manually or does a system really need that configuration?
> 
> This is a problem reported by my CI, when doing make randomconfigs. Of course,
> this is a very tiny fix.
> 
> > 
> >> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >> Cc: linux-fbdev@vger.kernel.org
> >> Cc: linux-kernel@vger.kernel.org
> >> Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
> >> ---
> >> drivers/video/console/mdacon.c | 1 -
> >> include/linux/vt_buffer.h | 2 +-
> >> 2 files changed, 1 insertion(+), 2 deletions(-)
> >> 
> >> diff --git a/drivers/video/console/mdacon.c b/drivers/video/console/mdacon.c
> >> index ef29b321967f..5898d01bc492 100644
> >> --- a/drivers/video/console/mdacon.c
> >> +++ b/drivers/video/console/mdacon.c
> >> @@ -42,7 +42,6 @@
> >> #include <linux/init.h>
> >> 
> >> #include <asm/io.h>
> >> -#include <asm/vga.h>
> >> 
> >> static DEFINE_SPINLOCK(mda_lock);
> >> 
> >> diff --git a/include/linux/vt_buffer.h b/include/linux/vt_buffer.h
> >> index 848db1b1569f..3e71f879e7c0 100644
> >> --- a/include/linux/vt_buffer.h
> >> +++ b/include/linux/vt_buffer.h
> >> @@ -16,7 +16,7 @@
> >> 
> >> #include <linux/string.h>
> >> 
> >> -#if defined(CONFIG_VGA_CONSOLE) || defined(CONFIG_MDA_CONSOLE)
> >> +#if defined(CONFIG_VGA_CONSOLE) || defined(CONFIG_MDA_CONSOLE) ||
> >> defined(CONFIG_MDA_CONSOLE_MODULE)
> > 
> > If this really is needed, please use the correct define macro that
> > catches both of these options.
> 
> Do you have any suggestions? 
> 
> I saw that this file is also written like this：
> ./arch/arm/mach-pxa/spitz.c:455:#if defined(CONFIG_LEDS_GPIO) || defined(CONFIG_LEDS_GPIO_MODULE)

Look at the IS_ENABLED() macro.

thanks,

greg k-h
