Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9358F3530F9
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 00:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235327AbhDBWKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 18:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbhDBWKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 18:10:04 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14DBDC0613E6;
        Fri,  2 Apr 2021 15:10:03 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id u21so9004323ejo.13;
        Fri, 02 Apr 2021 15:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tjO0cf2S9OYcNIa/GqCdKlOlb54R0YEGYyV9mPheIxM=;
        b=uJIyafAFjYXzENLxNRGfP12as4MjsHlfo1KOv+yRJsAUcNIOHzMIzGEcmw1ojW7/St
         AdozcCQC1oltkqOh3c32EnF8sN1fFZV1IIhneoAZrX0Wp0iBOgNbRDPDFlC0JOVp7rfh
         BmhtFA68gKu4Vw/pFdPi+Pbe7Fdv07o7bnnG08EE19Y6tps6gNjQbqi7cLI24NmTj9r/
         ocdENBHKdzB40s89cqQkBPKa2UXiJlY8FhIfpEDoVBW15HqZqvrVTC29+OmnGbnsyjJg
         0OYNF8bugfnCrEraYhx9UqiVgtOnxxEdhaGVoWhJoyj9XnOfI7TZ+pkRAJVeFvkmUOEz
         iOeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tjO0cf2S9OYcNIa/GqCdKlOlb54R0YEGYyV9mPheIxM=;
        b=WXXcPfbwtQo2yXQtjAWF8+Ii4b+uqc43XQI4GN5yTyHYXzzhDR98N6zkftZzRO3bPY
         3s1XGod1H8PgNxbS+z9u7PtpTwx9wqD/O7mzcigM7DB4v9QDTPjZRzfnvN2uI5iKUTy/
         ydofQ5poIajJb/eeG5w8/3gKsoZZTwnUQTJfzd92yf6KEvTUloE9sA9tS81V/1dF8kCM
         F+787DkXU8gGr7nT5SBrqFgpqL4M81aH+SXc9qt29RTZdykOGrHQb8zLQHX5b0ijMzZL
         oY/dbCRJb1A8deL8wYEfsjthmR6Zzdq58j2loiuQWDdHPjAPH8PDS8A5RmXSwVTRSkCo
         yNrw==
X-Gm-Message-State: AOAM533KB5QwAjmuhXjvpvK/BxQDVBRffgoQgtClKBeQ+xUdVS1/Havb
        FY5fcphccbZ7v2HmsdmOX42bjijK29pOUJMxfV4=
X-Google-Smtp-Source: ABdhPJxatYsLZ4Iweea2WJvIPqel18Arhd2gWwyU7X2mOkC8D1idWeZ+ktk5uk9vcv9BvfEgsPsH+9TiGm89MLuE6SQ=
X-Received: by 2002:a17:906:ae8d:: with SMTP id md13mr16203946ejb.275.1617401401649;
 Fri, 02 Apr 2021 15:10:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210402164506.520121-1-adrien.grassein@gmail.com>
 <20210402174228.wjl6paul5hxu7dnx@fsr-ub1664-175> <CABkfQAH+Gvu69UeDbxBGyQ1GroYuEqmrYFbkNE-qaLM2zpGRfQ@mail.gmail.com>
 <20210402175850.6ovyum7ot4pgv2wx@fsr-ub1664-175> <CABkfQAESbRQsn3fWo4uKeVMMf84LurCLkdgvbPi+A4Kqr87enw@mail.gmail.com>
In-Reply-To: <CABkfQAESbRQsn3fWo4uKeVMMf84LurCLkdgvbPi+A4Kqr87enw@mail.gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Fri, 2 Apr 2021 17:09:50 -0500
Message-ID: <CAHCN7x+cb-Nz9_3aciJLWx=j603RFXgLG92WbBk0MMYwM_mx6g@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] Add imx8m power domain driver
To:     Adrien Grassein <adrien.grassein@gmail.com>
Cc:     Abel Vesa <abel.vesa@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Peng Fan <peng.fan@nxp.com>, Anson Huang <Anson.Huang@nxp.com>,
        DTML <devicetree@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 2, 2021 at 1:16 PM Adrien Grassein
<adrien.grassein@gmail.com> wrote:
>
> Le ven. 2 avr. 2021 =C3=A0 19:58, Abel Vesa <abel.vesa@nxp.com> a =C3=A9c=
rit :
> >
> > On 21-04-02 19:48:41, Adrien Grassein wrote:
> > > Hi,
> > >
> > > Le ven. 2 avr. 2021 =C3=A0 19:42, Abel Vesa <abel.vesa@nxp.com> a =C3=
=A9crit :
> > > >
> > > > On 21-04-02 18:45:04, Adrien Grassein wrote:
> > > > > Hi,
> > > > >
> > > > > this patch et aims to add the support of the i.MX 8 Power Domain =
driver.
> > > > > Some devices (like usbotg2) can't work without this patch as thei=
r
> > > > > attached power domain are down.
> > > > >
> > > > > The original drivr was taken from le imx kernel and aapted to fit=
 with
> > > > > the actual mainline (minor fixes).
> > > > >
> > > > > Thanks,
> > > > >
> > > >
> > > > Big NACK for the whole series.
> > > >
> > > > This approach has already been rejected upstream.
> > >
> > > So what is the correct approach?
> > > At this point otg2 node of imx8mm is not working at all (and blocks t=
he whole
> > > boot of the kernel)
> > >
> >
> > Have a look at this thread:
> >
> > https://lkml.org/lkml/2020/4/27/706
> >
> Understood, so I will try to update the gpc driver (at least for otg).

Thanks for doing that. I know Lucas tried a few times to get something
going.  I'm willing to adapt whatever work you do on the Mini toward
the Nano if you don't have time.

adam
>
> > > >
> > > > Plus, you changed the original author, this work was originally don=
e by Jacky Bai.
> > >
> > > I have not changed this, the original author is not mentioned on the
> > > original patch.
> >
> > Here is the original commit:
> >
> > https://github.com/Freescale/linux-fslc/commit/7ebcf5ccf423afe4ccd9c53e=
f204018b0b653ce0
> >
> >
> > >
> > > >
> > > > > Adrien Grassein (2):
> > > > >   dt-bindings: power: Add documentation for imx8m power domain dr=
iver
> > > > >   soc: imx: add Power Domain driver for i.MX8M(M|N|P)
> > > > >
> > > > >  .../bindings/power/fsl,imx-power-domain.yaml  |  89 +++++++
> > > > >  MAINTAINERS                                   |  10 +
> > > > >  drivers/soc/imx/Kconfig                       |   7 +
> > > > >  drivers/soc/imx/Makefile                      |   1 +
> > > > >  drivers/soc/imx/imx8m_pm_domains.c            | 233 ++++++++++++=
++++++
> > > > >  include/dt-bindings/power/imx8mm-power.h      |  21 ++
> > > > >  include/dt-bindings/power/imx8mn-power.h      |  15 ++
> > > > >  include/dt-bindings/power/imx8mp-power.h      |  28 +++
> > > > >  include/soc/imx/imx_sip.h                     |  12 +
> > > > >  9 files changed, 416 insertions(+)
> > > > >  create mode 100644 Documentation/devicetree/bindings/power/fsl,i=
mx-power-domain.yaml
> > > > >  create mode 100644 drivers/soc/imx/imx8m_pm_domains.c
> > > > >  create mode 100644 include/dt-bindings/power/imx8mm-power.h
> > > > >  create mode 100644 include/dt-bindings/power/imx8mn-power.h
> > > > >  create mode 100644 include/dt-bindings/power/imx8mp-power.h
> > > > >  create mode 100644 include/soc/imx/imx_sip.h
> > > > >
> > > > > --
> > > > > 2.25.1
> > > > >
> > >
> > > Thanks,
>
> Thanks,
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
