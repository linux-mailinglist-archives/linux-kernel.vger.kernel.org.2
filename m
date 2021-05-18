Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 281E5387498
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 11:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347695AbhERJGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 05:06:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:36012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347688AbhERJGA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 05:06:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B5B7160720;
        Tue, 18 May 2021 09:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1621328683;
        bh=nb4BuGb/+is5eMdI1zcg2hwUDGXDghWOPkp+2GA/Oog=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pu/INOpRPuIyDr9Xfol25gKEvgbNe894H7CHu0LJfyfDmg6nMCXP7Q1rtmiBUNZWk
         zitNM9DlTjjq7WLA7RRFiUlhxfOBwXZaYlsI6Rd//3NX80tcEVXXfdzx3XZaPnbfcM
         Mzs90HhnG91axR2w/innWyseA0oCSmC+TUELaCGE=
Date:   Tue, 18 May 2021 11:04:40 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nianfu Bai <bnf20061983@gmail.com>
Cc:     daniel.lezcano@linaro.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, nianfu.bai@unisoc.com,
        ruifeng.zhang1@unisoc.com
Subject: Re: [PATCH] clocksource/drivers/sprd: Remove the dependency between
 sprd timer and SPRD arch
Message-ID: <YKODKHkIAi4mMh6B@kroah.com>
References: <1620716925-4329-1-git-send-email-bnf20061983@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1620716925-4329-1-git-send-email-bnf20061983@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2021 at 03:08:45PM +0800, Nianfu Bai wrote:
> From: Nianfu Bai <nianfu.bai@unisoc.com>
> 
> Tick broadcast installed by insmod cannot switch to oneshot mode correctly
> caused by linux timer framework, need to build in kernel image. SPRD_TIMER
> has been selected by SPRD arch, we have to enable SPRD arch when we build
> sprd timer in kernel image, this action conflicts with general kernel image,
> so we need to remove the dependency between sprd timer and SPRD arch.

This wording is a bit rough to parse.

All you really want to do is take away the fact that ARCH_SPRD is
required here to turn this off, right?

> 
> Signed-off-by: Nianfu Bai <nianfu.bai@unisoc.com>
> Signed-off-by: Ruifeng Zhang <ruifeng.zhang1@unisoc.com>
> ---
>  drivers/clocksource/Kconfig | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> index 39aa21d..04b333c 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -447,10 +447,8 @@ config MTK_TIMER
>  	  Support for Mediatek timer driver.
>  
>  config SPRD_TIMER
> -	bool "Spreadtrum timer driver" if EXPERT
> +	bool "Spreadtrum timer driver" if COMPILE_TEST

No need for "if COMPILE_TEST" on this line.

>  	depends on HAS_IOMEM
> -	depends on (ARCH_SPRD || COMPILE_TEST)
> -	default ARCH_SPRD

Just drop the ARCH_SPRD portion here and maybe make it depend on ARM64
instead like:
	depends on (ARM64 || COMPILE_TEST)

and drop the EXPERT check above?

What is the goal of what you want to do here?  Just allow this to be
enabled on what type of systems?

thanks,

greg k-h
