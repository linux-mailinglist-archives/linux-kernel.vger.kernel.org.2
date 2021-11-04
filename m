Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3E044546B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 15:00:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbhKDODa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 10:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbhKDOD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 10:03:29 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92EA7C061714
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 07:00:51 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id b203so3510261iof.10
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 07:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KJZSc1C/C2VIQ/P2PrKNaWRPpHJaj9Cr0StcpQfS/Zc=;
        b=XElEUZHbKeNnKsbty0cOq3o5zuq3C1Zr3xTa7jBfKJXHuXydgKXgHxg4s+EORp6CNc
         6l5VrFKJhqBfJ3ecnpeo/wYePf9tHAR238INSSW2mluqljIGYUBWhWgbBhgEiQdNR60q
         3IOEu/90JXk7bk/ymjoEbZ3f4T/113XlYqGY3ohu6mCV8cmOhs+GlarHyOYMKCdhZkhn
         ueaNR3U7aPHBR808k59FcAvAxy9d/w5Sq6sicH5q87DkvG4ty9CjCrBY/KbQVPyR/46H
         RiON3Aeg7z4XkHb+LovYeNADiR4LUZPv/7toISTUakJ2bblwkmtTpfhOVp/5FJZnHqI2
         foPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KJZSc1C/C2VIQ/P2PrKNaWRPpHJaj9Cr0StcpQfS/Zc=;
        b=BiYNViGrhCPlv+0d+Sc9CC949549shDuxBtjAX8LGMC3A8reJCtnsFH/atZuGC6pqY
         Y2VaoknO+5FiSA6QVYos63tJpEt7/uIven/7wPHxJ3afNkirr7kRFsH3qYSUpfuYdudU
         Lj44UUe6CmOM9Tc7I9oJjqjorMCW7UlY/X/glYdDeNylWdpBUUtRusbR7MUEjC9YkbZ6
         AAz6g0eKw4ST6PGr2yaAk8k6GdT0zsreqipkPwkLDeapEJ85Sj4ChpnHZ57IqWQRj5t+
         Mvp16dBgTeRcGjT160j4KdgtcH7I+9dWQk7lkqYyPyjfo0chFDUE2kg1YW9fOoeYz9+U
         GKYA==
X-Gm-Message-State: AOAM533QneMmvHBphCvgvXs+HYN1D1iCbuqdINt2PVksmUuq5cP12E2h
        vWDxTW0Z0qwXfRlSFhE3gAjVSaLDJhx2KAXel5sp+/qaMKdp6g==
X-Google-Smtp-Source: ABdhPJwoP1SsCFjnrX5csF0o7nZrKpBmngcuQ++KwJQVfyX69vI93jO/N9TSvj9DrtRzR/9Wq/g0USy9lBok4J8TJec=
X-Received: by 2002:a05:6602:140d:: with SMTP id t13mr35923239iov.176.1636034451030;
 Thu, 04 Nov 2021 07:00:51 -0700 (PDT)
MIME-Version: 1.0
References: <20211103190426.1511507-1-tyhicks@linux.microsoft.com>
 <YYOYvDnX7yA932re@google.com> <20211104135347.GD3600@sequoia>
In-Reply-To: <20211104135347.GD3600@sequoia>
From:   Robert Marko <robert.marko@sartura.hr>
Date:   Thu, 4 Nov 2021 15:00:40 +0100
Message-ID: <CA+HBbNFPN91SF8CGVHt1bLptj4rbD7MDFgHNWQ+ry_y_wR+-NA@mail.gmail.com>
Subject: Re: [PATCH] mfd: simple-mfd-i2c: Fix linker error due to new mfd-core dependency
To:     Tyler Hicks <tyhicks@linux.microsoft.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Alistair Francis <alistair@alistair23.me>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 4, 2021 at 2:53 PM Tyler Hicks <tyhicks@linux.microsoft.com> wr=
ote:
>
> On 2021-11-04 08:24:28, Lee Jones wrote:
> > On Wed, 03 Nov 2021, Tyler Hicks wrote:
> >
> > > Select CONFIG_MFD_CORE from CONFIG_MFD_SIMPLE_MFD_I2C, now that
> > > simple-mfd-i2c.c calls devm_mfd_add_devices(), to fix the following
> > > linker error:
> > >
> > >  ld: drivers/mfd/simple-mfd-i2c.o: in function `simple_mfd_i2c_probe'=
:
> > >  simple-mfd-i2c.c:(.text+0x62): undefined reference to `devm_mfd_add_=
devices'
> > >  make: *** [Makefile:1187: vmlinux] Error 1
> > >
> > > Fixes: c753ea31781a ("mfd: simple-mfd-i2c: Add support for registerin=
g devices via MFD cells")
> > > Cc: stable@vger.kernel.org # 5.15.x
> > > Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
> > > ---
> > >  drivers/mfd/Kconfig | 1 +
> > >  1 file changed, 1 insertion(+)
> >
> > Looks like the same change that has already been applied.
> >
> > Could you rebase on top of the MFD tree please?
>
> Ah, that commit wasn't in for-mfd-next when I wrote up this patch
> yesterday.
>
> I think that the Fixes line in that patch is wrong as I didn't see this
> issue in 5.10 and reverting c753ea31781a fixes the build failure.

Hi Tyler, I would agree with you on the fixes tag.
I messed that one up, c753ea31781a is the correct one.

Regards,
Robert
>
> Tyler
>
> >
> > --
> > Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> > Senior Technical Lead - Developer Services
> > Linaro.org =E2=94=82 Open source software for Arm SoCs
> > Follow Linaro: Facebook | Twitter | Blog
> >



--=20
Robert Marko
Staff Embedded Linux Engineer
Sartura Ltd.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr
