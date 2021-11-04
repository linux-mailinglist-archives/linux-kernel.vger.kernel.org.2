Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C062445490
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 15:10:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbhKDONB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 10:13:01 -0400
Received: from linux.microsoft.com ([13.77.154.182]:34754 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbhKDOM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 10:12:59 -0400
Received: from sequoia (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 86A0120ABA90;
        Thu,  4 Nov 2021 07:10:21 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 86A0120ABA90
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1636035021;
        bh=m2VDAM2LgZwK23bpeTVTQg2Pflqf2h5GtAHZ5yFkZCs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T5IAZK7GpQkwVv8RglhvlxLWlMvcXR0UkDY9BxJyQmZSkf2tAfVodaHOkOBpynlRh
         DeHc5FYlfF7cxK0W+NrSkfC3TO1IRjl6AryOSd3VKHNyFOt0LyeO++JamAcrtnGpva
         Q+cWSfIRhcx/7Cgz85G3IowwqRUGciH17/yJBZiA=
Date:   Thu, 4 Nov 2021 09:10:19 -0500
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Robert Marko <robert.marko@sartura.hr>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Alistair Francis <alistair@alistair23.me>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mfd: simple-mfd-i2c: Fix linker error due to new
 mfd-core dependency
Message-ID: <20211104141019.GE3600@sequoia>
References: <20211103190426.1511507-1-tyhicks@linux.microsoft.com>
 <YYOYvDnX7yA932re@google.com>
 <20211104135347.GD3600@sequoia>
 <CA+HBbNFPN91SF8CGVHt1bLptj4rbD7MDFgHNWQ+ry_y_wR+-NA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+HBbNFPN91SF8CGVHt1bLptj4rbD7MDFgHNWQ+ry_y_wR+-NA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-11-04 15:00:40, Robert Marko wrote:
> On Thu, Nov 4, 2021 at 2:53 PM Tyler Hicks <tyhicks@linux.microsoft.com> wrote:
> >
> > On 2021-11-04 08:24:28, Lee Jones wrote:
> > > On Wed, 03 Nov 2021, Tyler Hicks wrote:
> > >
> > > > Select CONFIG_MFD_CORE from CONFIG_MFD_SIMPLE_MFD_I2C, now that
> > > > simple-mfd-i2c.c calls devm_mfd_add_devices(), to fix the following
> > > > linker error:
> > > >
> > > >  ld: drivers/mfd/simple-mfd-i2c.o: in function `simple_mfd_i2c_probe':
> > > >  simple-mfd-i2c.c:(.text+0x62): undefined reference to `devm_mfd_add_devices'
> > > >  make: *** [Makefile:1187: vmlinux] Error 1
> > > >
> > > > Fixes: c753ea31781a ("mfd: simple-mfd-i2c: Add support for registering devices via MFD cells")
> > > > Cc: stable@vger.kernel.org # 5.15.x
> > > > Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
> > > > ---
> > > >  drivers/mfd/Kconfig | 1 +
> > > >  1 file changed, 1 insertion(+)
> > >
> > > Looks like the same change that has already been applied.
> > >
> > > Could you rebase on top of the MFD tree please?
> >
> > Ah, that commit wasn't in for-mfd-next when I wrote up this patch
> > yesterday.
> >
> > I think that the Fixes line in that patch is wrong as I didn't see this
> > issue in 5.10 and reverting c753ea31781a fixes the build failure.
> 
> Hi Tyler, I would agree with you on the fixes tag.
> I messed that one up, c753ea31781a is the correct one.

It is probably better to overshoot than undershoot with Fixes tags. :)

Lee, I don't know if you rebase that branch (I doubt it) but if you do
to fix up the Fixes tag, please also add an explicit Cc: stable tag
since this affects the new LTS release.

Tyler

> 
> Regards,
> Robert
> >
> > Tyler
> >
> > >
> > > --
> > > Lee Jones [李琼斯]
> > > Senior Technical Lead - Developer Services
> > > Linaro.org │ Open source software for Arm SoCs
> > > Follow Linaro: Facebook | Twitter | Blog
> > >
> 
> 
> 
> -- 
> Robert Marko
> Staff Embedded Linux Engineer
> Sartura Ltd.
> Lendavska ulica 16a
> 10000 Zagreb, Croatia
> Email: robert.marko@sartura.hr
> Web: www.sartura.hr
> 
