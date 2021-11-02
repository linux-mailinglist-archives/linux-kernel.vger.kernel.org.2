Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78A82442C64
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 12:20:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbhKBLXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 07:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbhKBLXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 07:23:09 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ACF4C061714
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 04:20:35 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id e144so25035940iof.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 04:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9FG5GWFuqdAEkefBuy5rnOkbDGeJchChVFws3/VGbU4=;
        b=0cAjnAMqxcCzUfiqoeKDBZ95MzkmZsw2t7RZrJBYUGFNo3aDFJ8nnCXr4ENXzZvBfJ
         8vbdq6bPqD/XXnkgXpQ0PxEDzaChaZN5S9qSho3XW0NZyWiyIpknHev+2rC41BDobqDK
         9YotmUrbz/op6afHfA2R/hNzNCUrgYvjxZIrtqXlQPR36rOhdexOeCEA7esZM+xmHyjD
         +/TrRQI/6p0gjzetXt1huazRCR1UHHnfh139y+DVr0cqw/PlvwSflTchFJvoc3EzwL6A
         dkEvTn2QXbcRYGdHQUQBQz7IH00VXavOSv7ZXtrKu6yXn/BWSTTkZFE2oP/x6Ip3gKhx
         MZPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9FG5GWFuqdAEkefBuy5rnOkbDGeJchChVFws3/VGbU4=;
        b=Gb5qg3uwFr609z0gfVXH+4GneWu5HPh5KWs80B7E22TsTrpZTp0l3t/zVoAx6+8iAm
         wMgQO7zT2wxkcG5YnlpjpWczTBewGYr/C8p1jKQ553anXBIYaTZJKTDTHx9eZJkDWi+F
         GkMdbJZh/3BywCC6dvN/pA+qoUUHvX/MyviJGeC7BawHFpV16ybSHyvdQ/p2OjkoCyyE
         EKY1o7B9t0rtrclVVfTtzlASCA+yPV3fbZpHdzgWol7LSPMnwJMyfEI4cvV77N25W+G3
         /1qBzg84wAMNDKfq3t3/oQvF+dnvrRe+0xngGG0kNeRdZlmL99QbwbxZFwzp+1y0mrAf
         KrLA==
X-Gm-Message-State: AOAM532rKckkZ+LAHX7ELYYpRbJIt2R7ZvsYeD3P1vKEqHvkmhkep2Yn
        OzFmzGaG4YnFeqWtgnHD4S6gydsFwstMm9kChkOy107M9+d33A==
X-Google-Smtp-Source: ABdhPJx2Hi/VyVLFwo+zyiIc3Q7oD27x3OtsN8FyUoCty6C4lST0in2W289wvh3Jsl8FUBl480an9wCh3JJmV5nKH5I=
X-Received: by 2002:a02:ab8d:: with SMTP id t13mr4498176jan.94.1635852034819;
 Tue, 02 Nov 2021 04:20:34 -0700 (PDT)
MIME-Version: 1.0
References: <20211102100420.112215-1-robert.marko@sartura.hr> <YYEeS8gz8TBW63X8@google.com>
In-Reply-To: <YYEeS8gz8TBW63X8@google.com>
From:   Robert Marko <robert.marko@sartura.hr>
Date:   Tue, 2 Nov 2021 12:20:24 +0100
Message-ID: <CA+HBbNHWV=+qDpOaD-ePz2yPpSjBOFEgdkuWBiqobBP9VN7W4g@mail.gmail.com>
Subject: Re: [PATCH] mfd: simple-mfd-i2c: Select MFD_CORE to fix build error
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Michael Walle <michael@walle.cc>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 2, 2021 at 12:17 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> On Tue, 02 Nov 2021, Robert Marko wrote:
>
> > MFD_SIMPLE_MFD_I2C should select the MFD_CORE to a prevent build error:
> >
> > aarch64-linux-ld: drivers/mfd/simple-mfd-i2c.o: in function `simple_mfd=
_i2c_probe':
> > drivers/mfd/simple-mfd-i2c.c:55: undefined reference to `devm_mfd_add_d=
evices'
>
> What is your use-case?
>
> How are you enabling this symbol?

Hi Lee,
I am adding a symbol like MFD_SL28CPLD does that you can depend on and
that simply
selects the MFD_SIMPLE_MFD_I2C and I have hit this issue since the
MFD_CORE is not selected.

Regards,
Robert
>
> > Fixes: 3abee4579484 ("mfd: Add simple regmap based I2C driver")
> > Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> > ---
> >  drivers/mfd/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> > index 61992edf6a4d..2de69892b631 100644
> > --- a/drivers/mfd/Kconfig
> > +++ b/drivers/mfd/Kconfig
> > @@ -1204,6 +1204,7 @@ config MFD_SI476X_CORE
> >  config MFD_SIMPLE_MFD_I2C
> >       tristate
> >       depends on I2C
> > +     select MFD_CORE
> >       select REGMAP_I2C
> >       help
> >         This driver creates a single register map with the intention fo=
r it
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
