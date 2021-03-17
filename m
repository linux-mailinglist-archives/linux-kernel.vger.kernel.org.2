Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC94D33EFE3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 12:57:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbhCQL5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 07:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbhCQL5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 07:57:07 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8166C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 04:57:07 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id d2so1180773ilm.10
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 04:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RR+rcy6pnAWWL/XpVw755u50h+DKgQXAmw6pXe2bZw0=;
        b=Cj0olu2vEsqHE62+jHcgS3nBnS2+BtrcaF3M5XhgRw2/k4xehdNkzvoLVDfvV5luvY
         XuuF2Sr2g2D6/RuclVad1a8P/orRAeYIKDMMwqreSWUXCCD+dKYdjz9/MUUf/g1VZev4
         Qszgq5VihiYWDWj+CR49913zzBuxGLQ48uj0RXNK9kYcBWDuONoMoYDPqk2LVu6GYWt6
         IGF18pW+W/Bd/+XkriLoR1Hw5U+pZO+KOTlx2fn/R7s34pivmVC97tENj9fTLlr6dkWZ
         HuFDk8QYIQFSsMTJseLAHIowFnvkpoOkDkXQKPqXccRQTJ0ikBe8DFvleOYLLxB4nX5r
         LeVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RR+rcy6pnAWWL/XpVw755u50h+DKgQXAmw6pXe2bZw0=;
        b=e06QZ6e34hbV6l52c8ZCxnooGpqCanaJJ6i5Um/LPrkVagNl7m5ZUwnpzO7kCmvbKd
         SFsR7nk7nh86Y74pVo2je/Cbx8uDA73X4Ov3AjJ/9mSpX+kVHgkqWnxQiHv/w5PvzjPt
         qw5pwq/NANoGb4snSd939U6r7KF3wOgrpk+5DPv5hLQbF8XqGLsMeGLrKpJ7fPJpdlGz
         31pQju2YifAfRy4N5GzIBuqWJ9EVejSTWxwo9tlLoLmeszBH50lg4RhULNYLoDoPkDV6
         +AE0IE378pb9l8Z3m1+5oR2lQSbH0eKeebhPDcp86IFOSyy/a9pAPdjrG8n97HLtYUrJ
         RTUA==
X-Gm-Message-State: AOAM533ndQujOeWWzcxdNbpK71C1JOsfdYBtsVWteVtQwoh3i3mir78m
        2Vu/aszMxjOzj6HaTu8FbSX2WygXmIvw58UBVlY=
X-Google-Smtp-Source: ABdhPJwoMcL9mjlZ0Wi9ZhtsT7e4LXc4Bzvl3v0rrKZsEHnWlTWr6b2nfamHta+bPoxhwLxlE/Xehu7bPGo3lRoot1M=
X-Received: by 2002:a92:874d:: with SMTP id d13mr6985839ilm.214.1615982227034;
 Wed, 17 Mar 2021 04:57:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210311192746.7362-1-heiko.thiery@gmail.com> <20210317080249.GT11246@dragon>
 <CAEyMn7b3qGupUh28rgf3THW7+8aNwCVnxtmOyS8MJXgJ3UuE7A@mail.gmail.com>
In-Reply-To: <CAEyMn7b3qGupUh28rgf3THW7+8aNwCVnxtmOyS8MJXgJ3UuE7A@mail.gmail.com>
From:   Heiko Thiery <heiko.thiery@gmail.com>
Date:   Wed, 17 Mar 2021 12:56:56 +0100
Message-ID: <CAEyMn7akxwP8kXpdDttBBp1Hos3tXtAVS7=Ti7T6JAxmLf5zGg@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: configs: Enable PCIe support for imx8mq boards
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Lucas Stach <l.stach@pengutronix.de>,
        Baruch Siach <baruch@tkos.co.il>,
        Fabio Estevam <festevam@gmail.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shawn,

Am Mi., 17. M=C3=A4rz 2021 um 12:52 Uhr schrieb Heiko Thiery
<heiko.thiery@gmail.com>:
>
> Hi Shawn,
>
> Am Mi., 17. M=C3=A4rz 2021 um 09:02 Uhr schrieb Shawn Guo <shawnguo@kerne=
l.org>:
> >
> > On Thu, Mar 11, 2021 at 08:27:47PM +0100, Heiko Thiery wrote:
> > > Enable PCI_IMX6 to get PCI support for imx8mq boards like imx8mq-evk,
> > > imx8mq-kontron-pitx-imx8m and imx8mq-zii-ultra.
> > >
> > > Signed-off-by: Heiko Thiery <heiko.thiery@gmail.com>
> > > ---
> > > v2:
> > >  - slightly modified the commit message (Fabio Estevam)
> > >
> > >  arch/arm64/configs/defconfig | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defcon=
fig
> > > index 1f673b00c5f5..522bae6a8f21 100644
> > > --- a/arch/arm64/configs/defconfig
> > > +++ b/arch/arm64/configs/defconfig
> > > @@ -225,6 +225,7 @@ CONFIG_PCI_HOST_THUNDER_PEM=3Dy
> > >  CONFIG_PCI_HOST_THUNDER_ECAM=3Dy
> > >  CONFIG_PCIE_ROCKCHIP_HOST=3Dm
> > >  CONFIG_PCIE_BRCMSTB=3Dm
> > > +CONFIG_PCI_IMX6=3Dy
> >
> > Do we really want it to be built-in?  If so, it would be nice to have s=
ome
> > comments about that in commit log.

Or do you mean why it cannot be enabled as a module? The PCI_IMX6
driver is only a bool option in the Kconfig and cannot be built as a
module. So it is required to have it built-in.

>
> Why would you not want it? I see other SOC PCI controllers are also
> enabled. I would like to have it because we have an Intel e1000 on our
> pitx-imx8m board and the seconds PCI slot is for a m.2 card. So we
> would have the PCI support with the default defconfig. On the NXP
> imx8mq EVK a m.2 is connected to the PCI interface.
>
> Is this the kind of comments you want?
>
> > Shawn
> >
> > >  CONFIG_PCI_LAYERSCAPE=3Dy
> > >  CONFIG_PCIE_LAYERSCAPE_GEN4=3Dy
> > >  CONFIG_PCI_HISI=3Dy
> > > --
> > > 2.30.0
> > >
>
> BR
> --
> Heiko
> --
> Heiko
