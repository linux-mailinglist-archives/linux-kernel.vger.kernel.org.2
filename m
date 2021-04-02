Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0CF5353105
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 00:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235279AbhDBW0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 18:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbhDBW0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 18:26:32 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 284C9C0613E6;
        Fri,  2 Apr 2021 15:26:30 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id r12so9071296ejr.5;
        Fri, 02 Apr 2021 15:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xEIpgBG61YTHEW9YtxoHbwMjHestDe0Z1cujeeYckiw=;
        b=sQkY2cDhUNUvoRMcensMmIg7FoCyrErqVe682tPWFa8QduQOJt9t3/XpgBRXKnXwiL
         CZ09OCz/1shYHx2GqvG8EFUGxVl4OPyjCu1NPCq3M0u4LU4FenRyssQNgwBuf55GW4oO
         +wdWRjKRzJVZj2LfZIOonSy1WHeINLM4o8E+0KDagrLtxZeVIpKHggi1oYtxwDWFLsEP
         UBsI2rMR7QA62a42eRkyzn3c5I2q4qc0vsztW9fuyh8bQkskn5iXTFEzXLElIn6co6Xn
         gY71qv95r2+mmO2X6xuEvJ6HRb8kPrgBp3CoP/02MrbfxM7Evhnva1TLN9UPvid6ZiNB
         B5Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xEIpgBG61YTHEW9YtxoHbwMjHestDe0Z1cujeeYckiw=;
        b=p14G8kRL0zTigpcbGdaO3me2R1VtNsXAkcZS4solrz5R8n1aQwh4egG/LekbwrV+uD
         0yRtLsLknvQFuDqfjpwW94/HY8oskjcwQ7XUsU0cdL4mwufnlj/Be2qrehcs6JLeBEln
         PAVBubk43Dob5QCl5eDc48HNrdtp3NfuH4Rqt/LtKlN+9+nTiS7Y76KyXfyQ6vDES9ox
         mnKKGORc/XpbZYBr35QLIJ4PoFp69M+6CznNCmXeEIyte3fKWM/XMLDi8f7DNwUGyBB+
         aX41olcN+LIX53mESD9aQ446I2ko2yGHMQmGSdx86fj+SEvS1jUi30oR2xFJJMLPbijs
         PLeA==
X-Gm-Message-State: AOAM53204Ki1Za4v52oTbAFEZsJDetyD7oVX97EGhTfInnM5pOYzxHok
        OjgERbwa0zRebM7vOw2+liBvv6lScmzsiDhv5tw=
X-Google-Smtp-Source: ABdhPJzeeQivEAeXGEZIkfXzA6SHJU0afgYlPE8I1WKVuB/UM04pSNXqK8/9PJ1hhwepXD1Z6gJHkX0+zV+1+fX6xs0=
X-Received: by 2002:a17:906:7842:: with SMTP id p2mr16793241ejm.87.1617402388704;
 Fri, 02 Apr 2021 15:26:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210402164506.520121-1-adrien.grassein@gmail.com>
 <20210402174228.wjl6paul5hxu7dnx@fsr-ub1664-175> <CABkfQAH+Gvu69UeDbxBGyQ1GroYuEqmrYFbkNE-qaLM2zpGRfQ@mail.gmail.com>
 <20210402175850.6ovyum7ot4pgv2wx@fsr-ub1664-175> <CABkfQAESbRQsn3fWo4uKeVMMf84LurCLkdgvbPi+A4Kqr87enw@mail.gmail.com>
 <CAHCN7x+cb-Nz9_3aciJLWx=j603RFXgLG92WbBk0MMYwM_mx6g@mail.gmail.com>
In-Reply-To: <CAHCN7x+cb-Nz9_3aciJLWx=j603RFXgLG92WbBk0MMYwM_mx6g@mail.gmail.com>
From:   Adrien Grassein <adrien.grassein@gmail.com>
Date:   Sat, 3 Apr 2021 00:26:17 +0200
Message-ID: <CABkfQAEm=AE_p3YT_Xi+E8haW5eXqPHY-Lh3L--rU8VSeD40SA@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] Add imx8m power domain driver
To:     Adam Ford <aford173@gmail.com>
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

Hi,

Le sam. 3 avr. 2021 =C3=A0 00:10, Adam Ford <aford173@gmail.com> a =C3=A9cr=
it :
>
> On Fri, Apr 2, 2021 at 1:16 PM Adrien Grassein
> <adrien.grassein@gmail.com> wrote:
> >
> > Le ven. 2 avr. 2021 =C3=A0 19:58, Abel Vesa <abel.vesa@nxp.com> a =C3=
=A9crit :
> > >
> > > On 21-04-02 19:48:41, Adrien Grassein wrote:
> > > > Hi,
> > > >
> > > > Le ven. 2 avr. 2021 =C3=A0 19:42, Abel Vesa <abel.vesa@nxp.com> a =
=C3=A9crit :
> > > > >
> > > > > On 21-04-02 18:45:04, Adrien Grassein wrote:
> > > > > > Hi,
> > > > > >
> > > > > > this patch et aims to add the support of the i.MX 8 Power Domai=
n driver.
> > > > > > Some devices (like usbotg2) can't work without this patch as th=
eir
> > > > > > attached power domain are down.
> > > > > >
> > > > > > The original drivr was taken from le imx kernel and aapted to f=
it with
> > > > > > the actual mainline (minor fixes).
> > > > > >
> > > > > > Thanks,
> > > > > >
> > > > >
> > > > > Big NACK for the whole series.
> > > > >
> > > > > This approach has already been rejected upstream.
> > > >
> > > > So what is the correct approach?
> > > > At this point otg2 node of imx8mm is not working at all (and blocks=
 the whole
> > > > boot of the kernel)
> > > >
> > >
> > > Have a look at this thread:
> > >
> > > https://lkml.org/lkml/2020/4/27/706
> > >
> > Understood, so I will try to update the gpc driver (at least for otg).
>
> Thanks for doing that. I know Lucas tried a few times to get something
> going.  I'm willing to adapt whatever work you do on the Mini toward
> the Nano if you don't have time.
>

NP, the problem here is that I don't have an Nano to test.

> adam
> >
> > > > >
> > > > > Plus, you changed the original author, this work was originally d=
one by Jacky Bai.
> > > >
> > > > I have not changed this, the original author is not mentioned on th=
e
> > > > original patch.
> > >
> > > Here is the original commit:
> > >
> > > https://github.com/Freescale/linux-fslc/commit/7ebcf5ccf423afe4ccd9c5=
3ef204018b0b653ce0
> > >
> > >
> > > >
> > > > >
> > > > > > Adrien Grassein (2):
> > > > > >   dt-bindings: power: Add documentation for imx8m power domain =
driver
> > > > > >   soc: imx: add Power Domain driver for i.MX8M(M|N|P)
> > > > > >
> > > > > >  .../bindings/power/fsl,imx-power-domain.yaml  |  89 +++++++
> > > > > >  MAINTAINERS                                   |  10 +
> > > > > >  drivers/soc/imx/Kconfig                       |   7 +
> > > > > >  drivers/soc/imx/Makefile                      |   1 +
> > > > > >  drivers/soc/imx/imx8m_pm_domains.c            | 233 ++++++++++=
++++++++
> > > > > >  include/dt-bindings/power/imx8mm-power.h      |  21 ++
> > > > > >  include/dt-bindings/power/imx8mn-power.h      |  15 ++
> > > > > >  include/dt-bindings/power/imx8mp-power.h      |  28 +++
> > > > > >  include/soc/imx/imx_sip.h                     |  12 +
> > > > > >  9 files changed, 416 insertions(+)
> > > > > >  create mode 100644 Documentation/devicetree/bindings/power/fsl=
,imx-power-domain.yaml
> > > > > >  create mode 100644 drivers/soc/imx/imx8m_pm_domains.c
> > > > > >  create mode 100644 include/dt-bindings/power/imx8mm-power.h
> > > > > >  create mode 100644 include/dt-bindings/power/imx8mn-power.h
> > > > > >  create mode 100644 include/dt-bindings/power/imx8mp-power.h
> > > > > >  create mode 100644 include/soc/imx/imx_sip.h
> > > > > >
> > > > > > --
> > > > > > 2.25.1
> > > > > >
> > > >
> > > > Thanks,
> >
> > Thanks,
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

Thanks,
