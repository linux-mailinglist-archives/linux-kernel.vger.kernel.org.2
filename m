Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C512B3B0661
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 15:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbhFVOCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 10:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbhFVOCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 10:02:08 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BDB0C061756
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 06:59:51 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id d7so23894231edx.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 06:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TvpjBACzoV42mn66zZsleALOXDYyAjKfVllzcHMcfwM=;
        b=Wp1TqiybqZXzu69uHeEPGREFTO4HIBfR+ESJKgc0unJBPRzOBSE7xOgXcg8pCqdhI0
         l8CHinSE9Y/aEqHbLuiB6OSStiCxRY0Hn+tzuJawj+ViDwS02PWNcI/dvUNECQlf4i1J
         HSvmL13FTBydydk0Gb5/zUkalgf6J0ziuYZCI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TvpjBACzoV42mn66zZsleALOXDYyAjKfVllzcHMcfwM=;
        b=OlLb/jWx4TJwEpunuks0EYQWH4WJvn6qHYKCq+EuSYa4zo7TJHyucoiQlnnCBcPwlP
         uePIhhh6VLI2GpyPZssDjfOXFQpBRDSS8kaox8qB1haGrB8ps3rif63QxLO3wIcu8Ydm
         zrFUGk362bPezAmRZJEmh/+VJH/vKnS/50CYHE+QHC8dTlRO9Csa9q7m2I4ebHVMu5wE
         2uaY155AK0Sd9CmsXonSt7VaGCDtJe+wCnSuUKks+KFDbCxjYVPntXLgpjW+ppzCT1tt
         HiSm8ZYwFNirl+NenNA4FciuIR+JTy70Aj4ZMfEfbmCvvnrL1xi9iymr2bIoQoDfDaCc
         R2eA==
X-Gm-Message-State: AOAM532wbOtALQuBAplZeJqyd49uNuVw1E53hx656jzvcLLkZ8aSYV4b
        r3SsPE1iVG9AVphGqwF9gaO0F11N2d/ufDyS/0rV0Q==
X-Google-Smtp-Source: ABdhPJw/q9PxAXyZv2WBeIUBgEA/9dXP9RWMWTh4uf9ndcmWUOV/Ki10fp+3NvT1lHWph76Diq/QxzKIiaoVikN66Oo=
X-Received: by 2002:aa7:c644:: with SMTP id z4mr172031edr.204.1624370390201;
 Tue, 22 Jun 2021 06:59:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210621072424.111733-1-jagan@amarulasolutions.com>
 <20210621072424.111733-8-jagan@amarulasolutions.com> <CAHCN7x+RKuOwBEFC5ySHJuFiC26ZdYuv620+5FiTfrh-3y2-Lg@mail.gmail.com>
In-Reply-To: <CAHCN7x+RKuOwBEFC5ySHJuFiC26ZdYuv620+5FiTfrh-3y2-Lg@mail.gmail.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Tue, 22 Jun 2021 19:29:39 +0530
Message-ID: <CAMty3ZCR7A76UfN98ffawET20D+nN5=EMmzosXu1G2vaNtBdfw@mail.gmail.com>
Subject: Re: [RFC PATCH 7/9] arm64: dts: imx8mm: Add eLCDIF node support
To:     Adam Ford <aford173@gmail.com>
Cc:     Peng Fan <peng.fan@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Tomasz Figa <t.figa@samsung.com>,
        Fancy Fang <chen.fang@nxp.com>,
        devicetree <devicetree@vger.kernel.org>,
        Francis Laniel <francis.laniel@amarulasolutions.com>,
        Matteo Lisi <matteo.lisi@engicam.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Milco Pratesi <milco.pratesi@engicam.com>,
        Anthony Brandon <anthony@amarulasolutions.com>,
        linux-phy@lists.infradead.org,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        arm-soc <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 22, 2021 at 8:39 AM Adam Ford <aford173@gmail.com> wrote:
>
> On Mon, Jun 21, 2021 at 2:25 AM Jagan Teki <jagan@amarulasolutions.com> wrote:
> >
> > Add eLCDIF controller node for i.MX8MM.
> >
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > ---
> >  arch/arm64/boot/dts/freescale/imx8mm.dtsi | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> > index fe5485ee9419..5f68182ed3a6 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> > @@ -1030,6 +1030,25 @@ aips4: bus@32c00000 {
> >                         #size-cells = <1>;
> >                         ranges = <0x32c00000 0x32c00000 0x400000>;
> >
> > +                       lcdif: lcdif@32e00000 {
> > +                               compatible = "fsl,imx8mm-lcdif", "fsl,imx6sx-lcdif";
>
> Based on a comment I read from Marek [1] from this patch series for
> the driver, I think fallback compatible should be fsl,imx28-lcdif.
>
> "The iMX8MM and iMX8MN do not support the overlay plane, so they are MXSFB V4"
>
> [1] - https://patchwork.kernel.org/project/dri-devel/patch/20210620224834.189411-1-marex@denx.de/

Yes, I saw that, look like some conversation is going on that thread.
will update accordingly in next version.

Jagan.
