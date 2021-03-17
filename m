Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74BA333EFD2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 12:53:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbhCQLxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 07:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231450AbhCQLwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 07:52:41 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C1AC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 04:52:40 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id y20so22257999iot.4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 04:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3GnH7IuPMuZB3zOdmNDmDDINcmgrcCBc+6P7g2+V2QI=;
        b=hlpYaquqzg4eTsxiHokwmIhOXyQao5FnQJLEXfOf1xXS5ovKOeKbtnEOvK3KV0tQzr
         0hLvPzckheCRb7WMtfLpGNtkR1+aHZFSCVLkeYD/L2v+WwcUBeuXqmApzTIfyIHuGXm0
         iJGlo1ytscgHntuIclmQpQStjZIM8P/IOXZaDdT0lZULUeLkcwFevaAq5ebsVNWcj6qB
         aRHA4EbBvrTkLmTWkLX/sepnu8Q1L/OEKfbkejAjw/E0e0uxom0dQ9nWqP8CtomJu9XR
         xIr05G2Os+aQLaxyRFyONt0fbF5wR9aFUiBiPc365DwhfdpyPKGdg5AumBFf2IMVFkKk
         4xIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3GnH7IuPMuZB3zOdmNDmDDINcmgrcCBc+6P7g2+V2QI=;
        b=jB+huC7QnUX+i0/C3xvD7oI81uqUrcffk3U0dH4X3DVEGaDdWus/FmPXrkRUCzOzhy
         iGIVk3CWcj2TC0b17hqYaivJ2YWCpBcfJo30zYHFC+7rkiK8TdYc7Sx7XyaBdZfsz/oL
         WyEq97/Dj0TPSCwQDCY8+gAbT8Cmz8EKygao1M1B/eP/z9CswNCzwanZ5a+Np8wETt72
         cqDRyjZ6/Y0d8/xTrn9/RRQgEvb5T24h+FMju+7B9fjSDizFuL+QnxDM/MsU4itDg29L
         oxBpkdZp6eOCcLyhleIDucJRRiBlN3LvKDKlCTwRNP3WyPNNiNhHuy+CQ0HRjScU+TN8
         9O5A==
X-Gm-Message-State: AOAM531QuIjg+G/ukT/wM8pEu/Vj2igVmpJiGcO5/bDtUAVb/Q1xa0Il
        lNycDVIwP+4CjtgecH6utjmqBSXjg5EE0GKIbfKEittn9bmZxw==
X-Google-Smtp-Source: ABdhPJx3ZCw+lqKyq02WUT1FQGzJBKczFWMk4SNRyxpIgHKZuCxyycqgYCz6xNpKWkH/v+WlEOrXkTIBFQ+jjKyIb8o=
X-Received: by 2002:a05:6638:f11:: with SMTP id h17mr2487601jas.67.1615981960288;
 Wed, 17 Mar 2021 04:52:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210311192746.7362-1-heiko.thiery@gmail.com> <20210317080249.GT11246@dragon>
In-Reply-To: <20210317080249.GT11246@dragon>
From:   Heiko Thiery <heiko.thiery@gmail.com>
Date:   Wed, 17 Mar 2021 12:52:29 +0100
Message-ID: <CAEyMn7b3qGupUh28rgf3THW7+8aNwCVnxtmOyS8MJXgJ3UuE7A@mail.gmail.com>
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

Am Mi., 17. M=C3=A4rz 2021 um 09:02 Uhr schrieb Shawn Guo <shawnguo@kernel.=
org>:
>
> On Thu, Mar 11, 2021 at 08:27:47PM +0100, Heiko Thiery wrote:
> > Enable PCI_IMX6 to get PCI support for imx8mq boards like imx8mq-evk,
> > imx8mq-kontron-pitx-imx8m and imx8mq-zii-ultra.
> >
> > Signed-off-by: Heiko Thiery <heiko.thiery@gmail.com>
> > ---
> > v2:
> >  - slightly modified the commit message (Fabio Estevam)
> >
> >  arch/arm64/configs/defconfig | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfi=
g
> > index 1f673b00c5f5..522bae6a8f21 100644
> > --- a/arch/arm64/configs/defconfig
> > +++ b/arch/arm64/configs/defconfig
> > @@ -225,6 +225,7 @@ CONFIG_PCI_HOST_THUNDER_PEM=3Dy
> >  CONFIG_PCI_HOST_THUNDER_ECAM=3Dy
> >  CONFIG_PCIE_ROCKCHIP_HOST=3Dm
> >  CONFIG_PCIE_BRCMSTB=3Dm
> > +CONFIG_PCI_IMX6=3Dy
>
> Do we really want it to be built-in?  If so, it would be nice to have som=
e
> comments about that in commit log.

Why would you not want it? I see other SOC PCI controllers are also
enabled. I would like to have it because we have an Intel e1000 on our
pitx-imx8m board and the seconds PCI slot is for a m.2 card. So we
would have the PCI support with the default defconfig. On the NXP
imx8mq EVK a m.2 is connected to the PCI interface.

Is this the kind of comments you want?

> Shawn
>
> >  CONFIG_PCI_LAYERSCAPE=3Dy
> >  CONFIG_PCIE_LAYERSCAPE_GEN4=3Dy
> >  CONFIG_PCI_HISI=3Dy
> > --
> > 2.30.0
> >

BR
--=20
Heiko
--=20
Heiko
