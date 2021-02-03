Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C360330D1AE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 03:40:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbhBCCin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 21:38:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231657AbhBCCig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 21:38:36 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C57DC061573;
        Tue,  2 Feb 2021 18:37:56 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id y5so21075774ilg.4;
        Tue, 02 Feb 2021 18:37:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c9KYKY7BZB045Y0XHBzCqMEwAkz/SHgyfk9a9Zvnx1w=;
        b=dO6jtuqtKEavhfxhTNu5s7lQe29zOh50QUYflKA2OwgBi8wTI2YuiTJ+aggFGb7T8b
         +KijGMkTZsaqDFhcH0CRPKPeM0wYr5Aai6tG8A4MBOxwBtsK+O63QaVlXLi0ZUU39R3T
         TpPBBtUTWBnoeGNGOEkDcejLEN1/9DOhjhtoXztDtVbDB2MBt2IsEkkdUGhoh0KClfqL
         lz/BJRYhw9IamdVEGssrPDgtl98vYxq6mAShmHWH9NwEBu6mHwD8oUxCsREmtAOmDDJ0
         FmJL7vfxnMv0mijpZAnhBA9/vDUA6IzW85xgMucOdqJUs+wCDzpZLDg8VSAjkuBglS8k
         hNnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c9KYKY7BZB045Y0XHBzCqMEwAkz/SHgyfk9a9Zvnx1w=;
        b=mJ8/7iSYDVW1/rhTFY7Nmw+hC4SgKPo5BpOdAwQi/JSpf2x09JFWhicSLNHCWtePAf
         WggwLbpNYP2hsgNEvovagOhjHXm70Z6WSwfLNMnTtRO/z8UgKBmelr0BsLARFtu0rYNL
         v+ExF54QNY4MUOq07MOgPKjNVy6hDk7UC525z79VB6wIat4K57bEGDnDlL+zAQMvCFbu
         aunR6xEWB0R+GB7ex8lxW/IIGiSadbib6PGuRI5XZx8kYMR5zTz1dczDKkcc4U0z5GOZ
         S9wp3roMLKlYs5q7Lt6JfvsTIEvPaVUA3lE16aPB/IbKT+gFUrrbdvg9KvPx1BXuIIsk
         nTmA==
X-Gm-Message-State: AOAM533J6l91+/OE8DbYS29rkp9NqD5dPE8TXfMiVbgTl0v5FyllaLQk
        5Z3zBb3ZyYlg/oq2vL3aUosGx/IaHzCK/7L56FDYq6ZDZOI=
X-Google-Smtp-Source: ABdhPJxstGXg5V8CFyAY5tIsoqIS7MtVBE41LQI6vI7iMaFPp/NfUERZR2dFTmDyFToFVWiBbfpQGve9fuFgA0tr8Cc=
X-Received: by 2002:a92:4b06:: with SMTP id m6mr989025ilg.177.1612319876111;
 Tue, 02 Feb 2021 18:37:56 -0800 (PST)
MIME-Version: 1.0
References: <20210117180301.1956-1-alistair@alistair23.me> <20210117180301.1956-3-alistair@alistair23.me>
 <20210129071341.GH4356@dragon>
In-Reply-To: <20210129071341.GH4356@dragon>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Tue, 2 Feb 2021 18:37:29 -0800
Message-ID: <CAKmqyKOoTG+BGhRFtppQxnaV61GFxXXhmZJcxqGQVbnuV1PfqA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] arch/arm/configs: Enable VMSPLIT_2G in imx_v6_v7_defconfig
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Alistair Francis <alistair@alistair23.me>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 28, 2021 at 11:13 PM Shawn Guo <shawnguo@kernel.org> wrote:
>
> On Sun, Jan 17, 2021 at 10:03:01AM -0800, Alistair Francis wrote:
> > The reMarkable2 requires VMSPLIT_2G, so lets set this in the
> > imx_v6_v7_defconfig.
>
> Hmm, why is VMSPLIT_2G required by reMarkable2?

I'm not too sure. It's difficult to debug problems as I only have a
UART but without this I don't see any kernel prints so it seems like
the kernel doesn't get very far. I haven't had any luck with earlycon
on the device so I don't know how I can get more information.

Alistair

>
> Shawn
>
> >
> > Signed-off-by: Alistair Francis <alistair@alistair23.me>
> > ---
> >  arch/arm/configs/imx_v6_v7_defconfig | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
> > index 55674cb1ffce..fa9229616106 100644
> > --- a/arch/arm/configs/imx_v6_v7_defconfig
> > +++ b/arch/arm/configs/imx_v6_v7_defconfig
> > @@ -29,6 +29,7 @@ CONFIG_SOC_IMX7D=y
> >  CONFIG_SOC_IMX7ULP=y
> >  CONFIG_SOC_VF610=y
> >  CONFIG_SMP=y
> > +CONFIG_VMSPLIT_2G=y
> >  CONFIG_ARM_PSCI=y
> >  CONFIG_HIGHMEM=y
> >  CONFIG_FORCE_MAX_ZONEORDER=14
> > --
> > 2.29.2
> >
