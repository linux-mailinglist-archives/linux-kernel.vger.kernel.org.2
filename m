Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 104A544548E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 15:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbhKDOMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 10:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbhKDOMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 10:12:30 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E86C061714
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 07:09:52 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id v65so7027157ioe.5
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 07:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WfGZ6Qz+htweSPjbgLUofa5PuRPT9mWIYFiRCyWubS0=;
        b=1UWhvE3cGXn87LwVe+imvMgFv10wN5WaywVZj86S5VTY3Zrx1EWKtZ/rzw8BuHfpQs
         fnOn+MpplEhW7ns/kXYI7FJQL+MKpYKIB0ArjiU/HlmWI5xm3HeT+Bn4PG3wBXO9aPxv
         yRbqEhPCwWFizGOo++Be+E/pEQ0MNJ8s+CnEz/SS8H90Y5pWS0EvKjPZ6oW0ns/RLSzv
         uoBl4da6rKoD/h1/rkVIT3o/wVhxBODMJVYHqpBJylcCMdDCbWlLAdyZKFzqMmm5kp4t
         2gtMMFraZCpnF91cEVgFWy4GbxgJpDkj5m1+TiDK629eWMXNHBMdBdU2rOan+1gBnhhZ
         EFmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WfGZ6Qz+htweSPjbgLUofa5PuRPT9mWIYFiRCyWubS0=;
        b=PJGIEXgItGKJqmJ/3q4QDoz49zgBbAVWj20pPgGjYckdTZS9YpQ5i2YLR7E7N6DX4O
         8WHK/R5GORg0Jji8ApM1BG1YYN4n7006RoyZQHAg7D9DaBsiADK0tB1W1wXVTW502XY3
         flKq8ynulVVAzYmWZKlLAcR7R0rZtyOhfsgg0nujV/LumQFIoXLMDQPhONZxZ182EpNt
         wqSbTEa4hQJ43yTMO4Bg+UyAVXU79+YKp+1SGL/Z3f+BnnIUMqjzp93tFDm3lChUwjZH
         AchY0IQ5ch3pqwwljmDi22CPwAKP2Fd+04YZuIIuIExZsQPjoRoODUh9isa+HJNzM5So
         Wajw==
X-Gm-Message-State: AOAM530m2JSlN4JhV/AV22y04HjB5N/Mm2GJX5zi3Tx4ddo9vGY1jz2+
        bqzUaxwZn04CoFEvz0sOkpMe8Cnvj+mi10wPsieT0A==
X-Google-Smtp-Source: ABdhPJyirX29oJNH5im1R++rem+lFhke7mtcExagl1rDbN/47No7tsPkxJwTFUBUI4LIuc5r+IGoJ3SCgMN72GyO3ac=
X-Received: by 2002:a02:741b:: with SMTP id o27mr4144948jac.84.1636034991726;
 Thu, 04 Nov 2021 07:09:51 -0700 (PDT)
MIME-Version: 1.0
References: <20211103190426.1511507-1-tyhicks@linux.microsoft.com>
 <YYOYvDnX7yA932re@google.com> <20211104135347.GD3600@sequoia>
 <CA+HBbNFPN91SF8CGVHt1bLptj4rbD7MDFgHNWQ+ry_y_wR+-NA@mail.gmail.com> <YYPpewMhot95DceK@google.com>
In-Reply-To: <YYPpewMhot95DceK@google.com>
From:   Robert Marko <robert.marko@sartura.hr>
Date:   Thu, 4 Nov 2021 15:09:41 +0100
Message-ID: <CA+HBbNEUBYwTDRgpt3CAb_ArbpVaPpRZYEeJ2YmZe=R1ZSOecQ@mail.gmail.com>
Subject: Re: [PATCH] mfd: simple-mfd-i2c: Fix linker error due to new mfd-core dependency
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Tyler Hicks <tyhicks@linux.microsoft.com>,
        Alistair Francis <alistair@alistair23.me>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 4, 2021 at 3:09 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> On Thu, 04 Nov 2021, Robert Marko wrote:
>
> > On Thu, Nov 4, 2021 at 2:53 PM Tyler Hicks <tyhicks@linux.microsoft.com=
> wrote:
> > >
> > > On 2021-11-04 08:24:28, Lee Jones wrote:
> > > > On Wed, 03 Nov 2021, Tyler Hicks wrote:
> > > >
> > > > > Select CONFIG_MFD_CORE from CONFIG_MFD_SIMPLE_MFD_I2C, now that
> > > > > simple-mfd-i2c.c calls devm_mfd_add_devices(), to fix the followi=
ng
> > > > > linker error:
> > > > >
> > > > >  ld: drivers/mfd/simple-mfd-i2c.o: in function `simple_mfd_i2c_pr=
obe':
> > > > >  simple-mfd-i2c.c:(.text+0x62): undefined reference to `devm_mfd_=
add_devices'
> > > > >  make: *** [Makefile:1187: vmlinux] Error 1
> > > > >
> > > > > Fixes: c753ea31781a ("mfd: simple-mfd-i2c: Add support for regist=
ering devices via MFD cells")
> > > > > Cc: stable@vger.kernel.org # 5.15.x
> > > > > Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
> > > > > ---
> > > > >  drivers/mfd/Kconfig | 1 +
> > > > >  1 file changed, 1 insertion(+)
> > > >
> > > > Looks like the same change that has already been applied.
> > > >
> > > > Could you rebase on top of the MFD tree please?
> > >
> > > Ah, that commit wasn't in for-mfd-next when I wrote up this patch
> > > yesterday.
> > >
> > > I think that the Fixes line in that patch is wrong as I didn't see th=
is
> > > issue in 5.10 and reverting c753ea31781a fixes the build failure.
> >
> > Hi Tyler, I would agree with you on the fixes tag.
> > I messed that one up, c753ea31781a is the correct one.
>
> All good.  I fixed it for you.

Thanks, sorry for the mess up.

Regards,
Robert
>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> Senior Technical Lead - Developer Services
> Linaro.org =E2=94=82 Open source software for Arm SoCs
> Follow Linaro: Facebook | Twitter | Blog



--=20
Robert Marko
Staff Embedded Linux Engineer
Sartura Ltd.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr
