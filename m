Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D49EF3A3CB0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 09:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbhFKHQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 03:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbhFKHQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 03:16:24 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2870C061574;
        Fri, 11 Jun 2021 00:14:26 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id cb9so35989776edb.1;
        Fri, 11 Jun 2021 00:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bIXUmcz0475283/uMOiisZMWlRUta5WeCtmUMaqN56g=;
        b=ecqbOYYVy7yWEVZKERSBjadHIuKhPGtC74g3WhlwcyWIj/JxdctZD3Au0B/q8y/UsI
         kmCORpQOu9HhrM6G5G0Vur/QxY1ghqvQRi2FVmAxAVCkwFAsYiRICI3MNxojomNo0vyP
         ZS2CbK6Gn3tL0ZKc6BeS/3LwqCxMM6EBfLZfD8dM50/a4pHBTIT4iv04E05biOw2QpRP
         XdcL/ls8YAgFGD0m0QgAbvAyVNAiUzSrswYm3QXWSPV04Hk14PHthNi4QH7T/R5dcotv
         KcrPOD6GAWTly6qIy2xQX0RBpeNQO+GqT8BUBTGXTdTtCogLEy+84l4vkZGP7BhDZv14
         i6HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bIXUmcz0475283/uMOiisZMWlRUta5WeCtmUMaqN56g=;
        b=sJZa3zrN6mjZ5c+WaElWEmi9DyMxguhnuDXHrui03GbW2u5lPbKlc7pkSa1K1741J6
         hLQOVI4PluadAixbfrkgCWsMxJbTOP7d2sHU7ardUl7bAkSE+c1+gmDsCsDCeso3Dm1U
         iXs7ZzYbfnePF4yPLU2M/FxK4OAE/HyplAHnhLvV5/ublUMks9rZ7Jv9R8wxhZv3em8B
         pc09J6JJY4NosvulefVBIAlcV5q9mhYaXOAn4Ai9Jk6tQjGoePNkBOlw7NwPNl2LbRBm
         4VnQtXP9DsbCK3LBvcEeTp3bt2aXGfSA+Yua6vTJB8AAtDIEaFJFhnf3W/RAWZfyVHlX
         Z6Jg==
X-Gm-Message-State: AOAM533m0KlAs0dbNSljGuc8QO2fpHRoSJrIkzAW6+N2UNPMaOA8FsVh
        yzngPiMl7/J87W9VsLnE450=
X-Google-Smtp-Source: ABdhPJz3xPPBl6k78Xi9P1zutkk7QbFlLnSMDn5+tRQMxJsIOscJVy4VeCdwULHnEEMAT424hNaeeQ==
X-Received: by 2002:aa7:dc12:: with SMTP id b18mr2216461edu.52.1623395665330;
        Fri, 11 Jun 2021 00:14:25 -0700 (PDT)
Received: from BV030612LT ([188.24.178.25])
        by smtp.gmail.com with ESMTPSA id q20sm1833645ejb.71.2021.06.11.00.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 00:14:24 -0700 (PDT)
Date:   Fri, 11 Jun 2021 10:14:22 +0300
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Manivannan Sadhasivam <mani@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ARM: dts: owl-s500-roseapplepi: Add ethernet support
Message-ID: <20210611071422.GB1520454@BV030612LT>
References: <cover.1623358117.git.cristian.ciocaltea@gmail.com>
 <632e12c445ced7f10e6d7240162484ae5afc148e.1623358117.git.cristian.ciocaltea@gmail.com>
 <20210611055606.GB6950@thinkpad>
 <20210611063147.GA1520454@BV030612LT>
 <20210611063940.GD6950@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210611063940.GD6950@thinkpad>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 11, 2021 at 12:09:40PM +0530, Manivannan Sadhasivam wrote:
> On Fri, Jun 11, 2021 at 09:31:47AM +0300, Cristian Ciocaltea wrote:
> > On Fri, Jun 11, 2021 at 11:26:06AM +0530, Manivannan Sadhasivam wrote:
> > > On Fri, Jun 11, 2021 at 12:09:22AM +0300, Cristian Ciocaltea wrote:
> > > > Add pinctrl configuration for enabling the Ethernet MAC on RoseapplePi
> > > > SBC. Additionally, provide the necessary properties for the generic S500
> > > > ethernet node in order to setup PHY and MDIO.
> > > > 
> > > > Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> > > > ---
> > > >  arch/arm/boot/dts/owl-s500-roseapplepi.dts | 56 ++++++++++++++++++++++
> > > >  1 file changed, 56 insertions(+)
> > > > 
> > > > diff --git a/arch/arm/boot/dts/owl-s500-roseapplepi.dts b/arch/arm/boot/dts/owl-s500-roseapplepi.dts
> > > > index b8c5db2344aa..bffabc7eaa50 100644
> > > > --- a/arch/arm/boot/dts/owl-s500-roseapplepi.dts
> > > > +++ b/arch/arm/boot/dts/owl-s500-roseapplepi.dts
> 
> [...]
> 
> > > > +	mdio {
> > > > +		#address-cells = <1>;
> > > > +		#size-cells = <0>;
> > > > +
> > > > +		reset-gpios = <&pinctrl 88 GPIO_ACTIVE_LOW>; /* GPIOC24 */
> > > > +		reset-delay-us = <10000>;
> > > > +		reset-post-delay-us = <150000>;
> > > 
> > > reset-* properties belong to "ethernet-phy" node. Also, while adding new nodes
> > > please run the dtbs_check and try to address the warnings.
> > 
> > The properties are those described in Documentation/devicetree/bindings/net/mdio.yaml
> 
> Do you mean the reset properties are applicable for all PHYs in this SoC?

Actually there is only one PHY connected. I've also checked the vendor
code and didn't notice any special handling for the PHY reset.

> > The dtbs_check doesn't report any issues in my case, usually this
> > happens when dtschema is not updated to the latest version. I always
> > run the following command after rebasing to a new kernel version:
> > 
> >   pip3 install --upgrade dtschema
> > 
> 
> That's good!
> 
> Thanks,
> Mani
> 
> > Thanks for the review,
> > Cristi
> > 
> > > Thanks,
> > > Mani
> > > 
> > > > +
> > > > +		eth_phy: ethernet-phy@3 {
> > > > +			reg = <0x3>;
> > > > +			max-speed = <100>;
> > > > +			interrupt-parent = <&sirq>;
> > > > +			interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
> > > > +		};
> > > > +	};
> > > > +};
> > > > +
> > > >  &twd_timer {
> > > >  	status = "okay";
> > > >  };
> > > > -- 
> > > > 2.32.0
> > > > 
