Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7221D44239F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 23:58:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232296AbhKAXBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 19:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbhKAXBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 19:01:05 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B61C061714;
        Mon,  1 Nov 2021 15:58:31 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 5so68389078edw.7;
        Mon, 01 Nov 2021 15:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jZ9LOwzZ3P8QcHNJCOuEJw++blcCddHe1Pn0IJjCj6o=;
        b=LJPT46Bf/d6iZrm2CLPmbX29KWiXzDDlgAjjSY9ajlH6grzuqSR+qwzBV52z+zDze2
         opoYDD22jFsH/HYRAgshAr5f186FCKLzE8EwMzRmIwaCKKUyr1pWDfL3xrXwqBpBCZUV
         tqRt2waMiCCddQI3D9w/tUCdjzrwGRqsrimWFwFbRXEsM4qweAtOGl0vNVg7HRnzs0d6
         CDqRtMMsjUECxN7iHg2bgS3UI4rDhNZ8cZ+N3cvYHtMjWZf6EOfY0AW7AXK1QBX+Uj3v
         NA/989sk5X9rwOHv180+6jMkPwu77ZwGshiSe4rGcsQvVUOIE2Yb0mth0GPwmCctVgfJ
         WtfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jZ9LOwzZ3P8QcHNJCOuEJw++blcCddHe1Pn0IJjCj6o=;
        b=hZkF+VtjJKJX1+2d3VXu/WDPsf4crsLyrhLVCk85H8PtHskSVAdDXrP9r5VP9lFaiN
         ZLa7MmAhdryKuSrkPo57JveTFjVsfWUTSyZz6D057GrZeCoH4QMcPsAiqAwfad4bsR+9
         kBgIM7mBHtsQ/pTg/Ni8X+VsatqQ2QcrFRkSnLuvX54rZtED5nkrut/Cn0gI8lMKiZ/O
         xF441vdMJ9nf9HpD+ej1WSTpn1QR/OlkhCcYmQiHkgPqnJ6xiwF1Lh9EdVW16CqGaF+H
         ZSRC2Thv+jbRBFnNMRbrcYsGZdOF46nJggrlVs/xt9/vZvMJx+ZNawlLB28Iu8UGBZXA
         qYtA==
X-Gm-Message-State: AOAM531y8DC+PFxqwZu1stW2GEaSne0lEiydWvJLvWwbFzaRQqtJ0MEd
        f/1H2Vs2t3TuO7CCIl2mV7M=
X-Google-Smtp-Source: ABdhPJwcRG0ef+5apgQqvFYVa9abYfLIGt4MhDq3CfIAjIQaUosJZTBseiEBU8hcYsX6qiD5XXHyvg==
X-Received: by 2002:a05:6402:402:: with SMTP id q2mr45339719edv.248.1635807510530;
        Mon, 01 Nov 2021 15:58:30 -0700 (PDT)
Received: from tom-desktop (net-188-153-110-208.cust.vodafonedsl.it. [188.153.110.208])
        by smtp.gmail.com with ESMTPSA id t16sm18007edd.18.2021.11.01.15.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 15:58:30 -0700 (PDT)
Date:   Mon, 1 Nov 2021 23:58:27 +0100
From:   Tommaso Merciai <tomm.merciai@gmail.com>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>, Alice Guo <alice.guo@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Adam Ford <aford173@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH] arm64: dts: imx8m: add syscon node for display_blk_ctrl
 module regs
Message-ID: <20211101225827.GA9208@tom-desktop>
References: <20211101222857.6940-1-tomm.merciai@gmail.com>
 <c04d4af6-8c7b-da23-d562-78324948ac35@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c04d4af6-8c7b-da23-d562-78324948ac35@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 01, 2021 at 11:35:49PM +0100, Ahmad Fatoum wrote:
> Hello Tommaso,
> 
> On 01.11.21 23:28, Tommaso Merciai wrote:
> > Add system controller node for registers of module Display Block Control
> > (DISPLAY_BLK_CTRL, base address: 0x32e28000).
> > The DISPLAY_BLK_CTRL module contains general purpose registers (GPRs),
> > which control varied features of the associated peripherals.
> > Reference: IMX8MMRM Rev. 3, 11/2020, p 3897
> > ---
> >  arch/arm64/boot/dts/freescale/imx8mm.dtsi | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> > index 2f632e8ca388..3e496b457e1a 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> > @@ -961,6 +961,11 @@ aips4: bus@32c00000 {
> >  			#size-cells = <1>;
> >  			ranges = <0x32c00000 0x32c00000 0x400000>;
> >  
> > +			dispmix_gpr: display-gpr@32e28000 {
> > +				compatible = "fsl, imx8mm-iomuxc-gpr", "syscon";
> 
> Please read vendor patches before submitting them. The space
> is out-of-place in the compatible and the compatible is wrong:
> This doesn't look like a i.MX8MM pin controller.
> 
> Cheers,
> Ahmad

  Hi Ahmad,
  Thanks for your review. Do you think this is correct?

  compatible = "fsl,imx8mm-dispmix-gpr", "syscon";

  Let me know.

  Thanks,
  Tommaso

> 
> > +				reg = <0x32e28000 0x100>;
> > +			};
> > +
> >  			usbotg1: usb@32e40000 {
> >  				compatible = "fsl,imx8mm-usb", "fsl,imx7d-usb";
> >  				reg = <0x32e40000 0x200>;
> > 
> 
> 
> -- 
> Pengutronix e.K.                           |                             |
> Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
