Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAFC044544C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 14:53:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbhKDN43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 09:56:29 -0400
Received: from linux.microsoft.com ([13.77.154.182]:32782 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbhKDN42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 09:56:28 -0400
Received: from sequoia (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id AFA0C20B9CE9;
        Thu,  4 Nov 2021 06:53:49 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AFA0C20B9CE9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1636034030;
        bh=uU7nP/CbWFKVSXnLqHOdZf2wTavbQiyIWOEtOt/p1ho=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rQbe1/NOFSG373p6DM0sddUUT8YOvuGXE9IyfhH+xsy/DlwWE60pyePrVLDfvmfB1
         EB3VQxjxgdeiJXrRf2ERmkIv8jfBUGZty955Sc7bOyrDgiabAPafQ0heZ2Ni2ICESF
         L1gbD3NZjeSFoBOyaOkewh6A9yApVpLzP8xfc3dQ=
Date:   Thu, 4 Nov 2021 08:53:47 -0500
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Alistair Francis <alistair@alistair23.me>,
        linux-kernel@vger.kernel.org,
        Robert Marko <robert.marko@sartura.hr>
Subject: Re: [PATCH] mfd: simple-mfd-i2c: Fix linker error due to new
 mfd-core dependency
Message-ID: <20211104135347.GD3600@sequoia>
References: <20211103190426.1511507-1-tyhicks@linux.microsoft.com>
 <YYOYvDnX7yA932re@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YYOYvDnX7yA932re@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-11-04 08:24:28, Lee Jones wrote:
> On Wed, 03 Nov 2021, Tyler Hicks wrote:
> 
> > Select CONFIG_MFD_CORE from CONFIG_MFD_SIMPLE_MFD_I2C, now that
> > simple-mfd-i2c.c calls devm_mfd_add_devices(), to fix the following
> > linker error:
> > 
> >  ld: drivers/mfd/simple-mfd-i2c.o: in function `simple_mfd_i2c_probe':
> >  simple-mfd-i2c.c:(.text+0x62): undefined reference to `devm_mfd_add_devices'
> >  make: *** [Makefile:1187: vmlinux] Error 1
> > 
> > Fixes: c753ea31781a ("mfd: simple-mfd-i2c: Add support for registering devices via MFD cells")
> > Cc: stable@vger.kernel.org # 5.15.x
> > Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
> > ---
> >  drivers/mfd/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> 
> Looks like the same change that has already been applied.
> 
> Could you rebase on top of the MFD tree please?

Ah, that commit wasn't in for-mfd-next when I wrote up this patch
yesterday.

I think that the Fixes line in that patch is wrong as I didn't see this
issue in 5.10 and reverting c753ea31781a fixes the build failure.

Tyler

> 
> -- 
> Lee Jones [李琼斯]
> Senior Technical Lead - Developer Services
> Linaro.org │ Open source software for Arm SoCs
> Follow Linaro: Facebook | Twitter | Blog
> 
