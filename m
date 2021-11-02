Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 760D8442CCC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 12:38:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbhKBLkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 07:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbhKBLkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 07:40:41 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01687C061714
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 04:38:07 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id p204so13461538iod.8
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 04:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2R+yXj293966xAWPKmIcAFTeSjlx41a47gGv/u4xHXI=;
        b=lwQpy5YxbAyQ3Zur1kQw9Xod0FrG6ggiBvmHmDdOzlSvZMhVfuhlNKWegUaSMQHm/E
         HVPmuxHjSm4ZZaFp7WrEaOL74CkXmdwkOf39mW5PetdddzDeIe5SPL5sOrOXl9UyNBLZ
         Fn5xtSo8mkTH0O4Jar7UWHCVuhrgM0svbuvPxHFbSSpWcTTpzI4RdO+ekYSjs0/ztxsr
         JsID5YTyb3/ctUsjK27+hZGvcqRY94kvW4JRSc54v8fAszSyo6sMRRw+xcIROnEpQn6F
         qYmpLOUaaNTsahRxsCDGqCrIQOtLQll6UrNyl6kqwPfeX5e2N+XVB2nwHMKuBZuHuP+0
         /F4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2R+yXj293966xAWPKmIcAFTeSjlx41a47gGv/u4xHXI=;
        b=NnLRNAHAYB4WjW57fKDbKBqFW6UosSlRJrm1poVmIWDwVm/bp5uIK2XNXTBQN8l5/E
         nZKCx3NDY9H2Me/EoU9OlZgoYMDGNVysBGnp4kHcEX9LA4vqLBeHygXNhl0ywTcXXDnq
         T8wN/W76k+RKuObl3WDWxUn29SyEm7lvoE/YWTCXl4n/p8N6fNSkk8ObhgQewuKFk4Hc
         dszXGOheqXzt55/2CIOoTEvhxUPjZCkwFAM1ZJRvETesTSFzWjRuIxiXe5dmzUVi5M6f
         VD95pGPjUoO4uWjwfcBVMcuejAh3c18L/7XhQm6P9t5UQISNGbeiyJv8FJu/T6r+EY7v
         zcyg==
X-Gm-Message-State: AOAM530Z2KpKAX7M6ibsRMJQDuPQXW6DVfP+TjgUV5zwj4I0oiUVBLR+
        d5yqRTmSE4mO5uG1M+cS6Y6DsXy71BpC+7koFkbnYff9vpZSOA==
X-Google-Smtp-Source: ABdhPJw7w2LfWs1y8fgqzomLc9Wq1+oOq2ZgUGb4kKmeOSIcoMlu7MCDLq4ZznzPTdlPyQNNtF4tkeYmP7D620UmNCo=
X-Received: by 2002:a5d:994f:: with SMTP id v15mr26631778ios.88.1635853086482;
 Tue, 02 Nov 2021 04:38:06 -0700 (PDT)
MIME-Version: 1.0
References: <20211102100420.112215-1-robert.marko@sartura.hr>
 <YYEeS8gz8TBW63X8@google.com> <CA+HBbNHWV=+qDpOaD-ePz2yPpSjBOFEgdkuWBiqobBP9VN7W4g@mail.gmail.com>
 <YYEiijBp3dK92ep4@google.com>
In-Reply-To: <YYEiijBp3dK92ep4@google.com>
From:   Robert Marko <robert.marko@sartura.hr>
Date:   Tue, 2 Nov 2021 12:37:55 +0100
Message-ID: <CA+HBbNGGpSXtTqvXb=cGGadT38LkrOGdcjQ5XwojvnA8yTUuTg@mail.gmail.com>
Subject: Re: [PATCH] mfd: simple-mfd-i2c: Select MFD_CORE to fix build error
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Michael Walle <michael@walle.cc>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 2, 2021 at 12:35 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> On Tue, 02 Nov 2021, Robert Marko wrote:
>
> > On Tue, Nov 2, 2021 at 12:17 PM Lee Jones <lee.jones@linaro.org> wrote:
> > >
> > > On Tue, 02 Nov 2021, Robert Marko wrote:
> > >
> > > > MFD_SIMPLE_MFD_I2C should select the MFD_CORE to a prevent build er=
ror:
> > > >
> > > > aarch64-linux-ld: drivers/mfd/simple-mfd-i2c.o: in function `simple=
_mfd_i2c_probe':
> > > > drivers/mfd/simple-mfd-i2c.c:55: undefined reference to `devm_mfd_a=
dd_devices'
> > >
> > > What is your use-case?
> > >
> > > How are you enabling this symbol?
> >
> > Hi Lee,
> > I am adding a symbol like MFD_SL28CPLD does that you can depend on and
> > that simply
> > selects the MFD_SIMPLE_MFD_I2C and I have hit this issue since the
> > MFD_CORE is not selected.
>
> That's interesting.
>
> I wonder how MFD_SL28CPLD selects it?

It doesn't, it just selects MFD_SIMPLE_MFD_I2C

MFD_CORE is probably selected by something else masking this issue.

Regards,
Robert
>
> > > > Fixes: 3abee4579484 ("mfd: Add simple regmap based I2C driver")
> > > > Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> > > > ---
> > > >  drivers/mfd/Kconfig | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> > > > index 61992edf6a4d..2de69892b631 100644
> > > > --- a/drivers/mfd/Kconfig
> > > > +++ b/drivers/mfd/Kconfig
> > > > @@ -1204,6 +1204,7 @@ config MFD_SI476X_CORE
> > > >  config MFD_SIMPLE_MFD_I2C
> > > >       tristate
> > > >       depends on I2C
> > > > +     select MFD_CORE
> > > >       select REGMAP_I2C
> > > >       help
> > > >         This driver creates a single register map with the intentio=
n for it
> > >
> >
> >
> >
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
