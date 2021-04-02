Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DABF7352EB5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 19:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235426AbhDBRs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 13:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234488AbhDBRs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 13:48:56 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77CC5C0613E6;
        Fri,  2 Apr 2021 10:48:53 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id u17so2083815ejk.2;
        Fri, 02 Apr 2021 10:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0owosgkyykKYDuIsHi10QhU2e22nKyvwNVjoqMdEnjs=;
        b=Cb5PT3Hp3SOPJsk1LImYGcw8Nn0ud/sn3Smo2IhUs1op/As+hrOOOJp/gouWLNEb8h
         Nrer/MmRIqVnP2dWbobYZwoFv4daWFaDKkFtPYGFo14lJk//iMlK9R/Ns3zYQ6HrpPER
         9E7UZSBdi9MciIUNXlkdqOGHdZhxA+bR1/3+TbCLdVAHp4zFuvhWHuqRD1KY0DbbIp4K
         HD5P+cOTFFlMBWFzJeZYB34ZHvQr1trGVW/vCDcm9l6bhieONt7KtuDsllgot60rWXRY
         5gFpLBrEgwbPDmJKEAeo23aUT6ZAVDaeCvFY57ZcDwEBQ1WQJKlOlQlyIn+6bMoPMsUc
         lI1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0owosgkyykKYDuIsHi10QhU2e22nKyvwNVjoqMdEnjs=;
        b=RVWjRXLRr7Ez4ZidmXlYLWaHgBpcrGL6uP74zlGkPcNljS7Ml6kJhcEyOA3k01YDTQ
         3EvZUBFcxfO8st1Phn+/3Qk10SKWf9o9YrYCR9bN3pnFwAe3Xy9wsFzmg+jxy2TlLxON
         PYjnsyBEbGcvGlMF5djpmUB98D0QCkEnDN56o+cKYfXwMKrVspiIRJAk7n8EgH3dcQkL
         IEC8bSVasu9vUKHgkDPo/iMdUxDv9T5T4GFQ/U7s8CuKOd3Xv4HWLFn2g/djD8DehYnn
         MxGv5Tb4KqpoM8D5gN/SHKEMrDDjXQTsnPz/p9EWYWTca69H7mPzLwSaXukxp+ZmtfeM
         Y89A==
X-Gm-Message-State: AOAM531mMf3nxwAHHhh6c34+ItuqlzSC6BuEcWYp7WOqxd/B3TtQq62C
        jS7J6Avq/f4teUJ2xuZhyEovT7DJ5RXwx8/5q8A=
X-Google-Smtp-Source: ABdhPJxgzlz0K4m1J3BoAgiWsvQVCCYJ6YWYMf/U++AKWa+vazkMzqbpcAtLQHLYfR+hVx/z4N16fa2KOAyX3+5Ad3g=
X-Received: by 2002:a17:907:7785:: with SMTP id ky5mr14646048ejc.133.1617385732116;
 Fri, 02 Apr 2021 10:48:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210402164506.520121-1-adrien.grassein@gmail.com> <20210402174228.wjl6paul5hxu7dnx@fsr-ub1664-175>
In-Reply-To: <20210402174228.wjl6paul5hxu7dnx@fsr-ub1664-175>
From:   Adrien Grassein <adrien.grassein@gmail.com>
Date:   Fri, 2 Apr 2021 19:48:41 +0200
Message-ID: <CABkfQAH+Gvu69UeDbxBGyQ1GroYuEqmrYFbkNE-qaLM2zpGRfQ@mail.gmail.com>
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

Hi,

Le ven. 2 avr. 2021 =C3=A0 19:42, Abel Vesa <abel.vesa@nxp.com> a =C3=A9cri=
t :
>
> On 21-04-02 18:45:04, Adrien Grassein wrote:
> > Hi,
> >
> > this patch et aims to add the support of the i.MX 8 Power Domain driver=
.
> > Some devices (like usbotg2) can't work without this patch as their
> > attached power domain are down.
> >
> > The original drivr was taken from le imx kernel and aapted to fit with
> > the actual mainline (minor fixes).
> >
> > Thanks,
> >
>
> Big NACK for the whole series.
>
> This approach has already been rejected upstream.

So what is the correct approach?
At this point otg2 node of imx8mm is not working at all (and blocks the who=
le
boot of the kernel)

>
> Plus, you changed the original author, this work was originally done by J=
acky Bai.

I have not changed this, the original author is not mentioned on the
original patch.
(Taken from https://github.com/Freescale/linux-fslc branch 5.4-2.2.x-imx)

>
> > Adrien Grassein (2):
> >   dt-bindings: power: Add documentation for imx8m power domain driver
> >   soc: imx: add Power Domain driver for i.MX8M(M|N|P)
> >
> >  .../bindings/power/fsl,imx-power-domain.yaml  |  89 +++++++
> >  MAINTAINERS                                   |  10 +
> >  drivers/soc/imx/Kconfig                       |   7 +
> >  drivers/soc/imx/Makefile                      |   1 +
> >  drivers/soc/imx/imx8m_pm_domains.c            | 233 ++++++++++++++++++
> >  include/dt-bindings/power/imx8mm-power.h      |  21 ++
> >  include/dt-bindings/power/imx8mn-power.h      |  15 ++
> >  include/dt-bindings/power/imx8mp-power.h      |  28 +++
> >  include/soc/imx/imx_sip.h                     |  12 +
> >  9 files changed, 416 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/power/fsl,imx-pow=
er-domain.yaml
> >  create mode 100644 drivers/soc/imx/imx8m_pm_domains.c
> >  create mode 100644 include/dt-bindings/power/imx8mm-power.h
> >  create mode 100644 include/dt-bindings/power/imx8mn-power.h
> >  create mode 100644 include/dt-bindings/power/imx8mp-power.h
> >  create mode 100644 include/soc/imx/imx_sip.h
> >
> > --
> > 2.25.1
> >

Thanks,
