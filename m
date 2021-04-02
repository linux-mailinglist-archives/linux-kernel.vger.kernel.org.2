Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 190FA352EFE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 20:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235871AbhDBSLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 14:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235623AbhDBSLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 14:11:32 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A07E4C0613E6;
        Fri,  2 Apr 2021 11:11:30 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id bx7so6179495edb.12;
        Fri, 02 Apr 2021 11:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TuJ0uVTL20WxHyg1gD206OF/xZJVZhxnY6dMAURywT0=;
        b=PMv2TxqLmQz5BBc6Y2+S5ulm2iBIgOZMVtAFMguU5xlmWfA2hhKSxLy7EpAh/8Hq+V
         2thopZrdl5sUj6Ye399tywizji/8WvA7sOunlnednVUb/HVVqXaP6uurOvDzxdhZRwCW
         recCxYhQAH32kqZJ7++vCqZ9UJMp/YthFVKAscV28wefvqqt14992757Ez1k2IdugZOj
         QHJCqon9uupwHost80P36PvSDl4OpEjy7egIwPHmABXJO6MmfTuFTqQjGmxqunMD8MfG
         RYaakSJic2MScwwmX+DFSeXAu3UTD0ZqNIBa1j0cfSJyE7WkzJEmSotP0JSGKjOakK4E
         UmGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TuJ0uVTL20WxHyg1gD206OF/xZJVZhxnY6dMAURywT0=;
        b=saLlti3eOM2prQHT6YmBl1u4gppQ4L5/A6V1/lzCBtxNy8Hw9vjnazqVngfWPJGkRr
         wUOj4BtRvjOqpVs5Dcb3VMSZSeAE7ICL4WauOK9uDgGSUMnUhY++z9/91MKCY42FXasF
         O/JJK8h0CTvOmdBfghs3P2dk5wCHLjNVHhb7YaBwa6nhsWF+vTKFHF0xnleM2WEprAag
         SnkF9nteO5jrLRFCgdniCFuWND0opOplq2T8EpjxZupjBi7hdw1o0JWAp8gDoYVRzqCP
         UymTEp4No6iX7vuiv3M4J6bDK5CesBdSeqAXepS4FD85N2NexHiGXfMo9DGEpJOVKFZq
         CdNQ==
X-Gm-Message-State: AOAM532bsVFUu2fCMWKS/mA6FJDkOfZULNsA7KO/CC9o4xQTC4I0NWIQ
        p2j1Wg4NCEWWxnZYBZembXzHClaS/bTN/CGLfw4=
X-Google-Smtp-Source: ABdhPJx7ID24r12mlmAnuOryPOiJLzvScjP17Geo/549//FxKAwoZ8p88Ejho+wQXlVwMGVDSs4ZXj3rYLlrSCYpw6U=
X-Received: by 2002:a50:eb8f:: with SMTP id y15mr16878186edr.115.1617387089360;
 Fri, 02 Apr 2021 11:11:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210402164506.520121-1-adrien.grassein@gmail.com>
 <20210402174228.wjl6paul5hxu7dnx@fsr-ub1664-175> <CABkfQAH+Gvu69UeDbxBGyQ1GroYuEqmrYFbkNE-qaLM2zpGRfQ@mail.gmail.com>
 <20210402175850.6ovyum7ot4pgv2wx@fsr-ub1664-175>
In-Reply-To: <20210402175850.6ovyum7ot4pgv2wx@fsr-ub1664-175>
From:   Adrien Grassein <adrien.grassein@gmail.com>
Date:   Fri, 2 Apr 2021 20:11:18 +0200
Message-ID: <CABkfQAESbRQsn3fWo4uKeVMMf84LurCLkdgvbPi+A4Kqr87enw@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] Add imx8m power domain driver
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, arnd@arndb.de,
        peng.fan@nxp.com, Anson.Huang@nxp.com,
        DTML <devicetree@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le ven. 2 avr. 2021 =C3=A0 19:58, Abel Vesa <abel.vesa@nxp.com> a =C3=A9cri=
t :
>
> On 21-04-02 19:48:41, Adrien Grassein wrote:
> > Hi,
> >
> > Le ven. 2 avr. 2021 =C3=A0 19:42, Abel Vesa <abel.vesa@nxp.com> a =C3=
=A9crit :
> > >
> > > On 21-04-02 18:45:04, Adrien Grassein wrote:
> > > > Hi,
> > > >
> > > > this patch et aims to add the support of the i.MX 8 Power Domain dr=
iver.
> > > > Some devices (like usbotg2) can't work without this patch as their
> > > > attached power domain are down.
> > > >
> > > > The original drivr was taken from le imx kernel and aapted to fit w=
ith
> > > > the actual mainline (minor fixes).
> > > >
> > > > Thanks,
> > > >
> > >
> > > Big NACK for the whole series.
> > >
> > > This approach has already been rejected upstream.
> >
> > So what is the correct approach?
> > At this point otg2 node of imx8mm is not working at all (and blocks the=
 whole
> > boot of the kernel)
> >
>
> Have a look at this thread:
>
> https://lkml.org/lkml/2020/4/27/706
>
Understood, so I will try to update the gpc driver (at least for otg).

> > >
> > > Plus, you changed the original author, this work was originally done =
by Jacky Bai.
> >
> > I have not changed this, the original author is not mentioned on the
> > original patch.
>
> Here is the original commit:
>
> https://github.com/Freescale/linux-fslc/commit/7ebcf5ccf423afe4ccd9c53ef2=
04018b0b653ce0
>
>
> >
> > >
> > > > Adrien Grassein (2):
> > > >   dt-bindings: power: Add documentation for imx8m power domain driv=
er
> > > >   soc: imx: add Power Domain driver for i.MX8M(M|N|P)
> > > >
> > > >  .../bindings/power/fsl,imx-power-domain.yaml  |  89 +++++++
> > > >  MAINTAINERS                                   |  10 +
> > > >  drivers/soc/imx/Kconfig                       |   7 +
> > > >  drivers/soc/imx/Makefile                      |   1 +
> > > >  drivers/soc/imx/imx8m_pm_domains.c            | 233 ++++++++++++++=
++++
> > > >  include/dt-bindings/power/imx8mm-power.h      |  21 ++
> > > >  include/dt-bindings/power/imx8mn-power.h      |  15 ++
> > > >  include/dt-bindings/power/imx8mp-power.h      |  28 +++
> > > >  include/soc/imx/imx_sip.h                     |  12 +
> > > >  9 files changed, 416 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/power/fsl,imx=
-power-domain.yaml
> > > >  create mode 100644 drivers/soc/imx/imx8m_pm_domains.c
> > > >  create mode 100644 include/dt-bindings/power/imx8mm-power.h
> > > >  create mode 100644 include/dt-bindings/power/imx8mn-power.h
> > > >  create mode 100644 include/dt-bindings/power/imx8mp-power.h
> > > >  create mode 100644 include/soc/imx/imx_sip.h
> > > >
> > > > --
> > > > 2.25.1
> > > >
> >
> > Thanks,

Thanks,
