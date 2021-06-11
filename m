Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFA063A3C14
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 08:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbhFKGlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 02:41:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:58542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229510AbhFKGlo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 02:41:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3444E61285;
        Fri, 11 Jun 2021 06:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623393587;
        bh=7XTJ+zxV7skHRXnn2pnhP4tpSNvduxlBN3JkyMlwBgc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NAO1IuG6hK8hwDDHT0Ud00c5ysdRvABJHZ99YlSCUvVOUlwPbjqgkiuaP4W9qKLwT
         aRFs9YqvRG0uh+ehpZ9FgTKhcjj1XmBdL+A1pRYIeksWrnfqk/N4svJ4+YHFdHmHdI
         FCrBn3CYB6yDKtexafaz5KrE1FkbWmPDWt29Y1xi/fb6ciYLsJWGI8lf0tajQYWimW
         P9giwdVCbJxFknufVrsmKMWKaOv7gARyiApeQhr4PN5LYdcfNlRq8vdjKInbEmghFz
         8SjAUG+m3nVqMywkP8Ofii/4dQ/JQyWQ5E9KQ0iD1ZpnQjiV+7F/PxCJcMd+B1dlXe
         BKszMR4ZlRexA==
Date:   Fri, 11 Jun 2021 12:09:40 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ARM: dts: owl-s500-roseapplepi: Add ethernet support
Message-ID: <20210611063940.GD6950@thinkpad>
References: <cover.1623358117.git.cristian.ciocaltea@gmail.com>
 <632e12c445ced7f10e6d7240162484ae5afc148e.1623358117.git.cristian.ciocaltea@gmail.com>
 <20210611055606.GB6950@thinkpad>
 <20210611063147.GA1520454@BV030612LT>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210611063147.GA1520454@BV030612LT>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 11, 2021 at 09:31:47AM +0300, Cristian Ciocaltea wrote:
> On Fri, Jun 11, 2021 at 11:26:06AM +0530, Manivannan Sadhasivam wrote:
> > On Fri, Jun 11, 2021 at 12:09:22AM +0300, Cristian Ciocaltea wrote:
> > > Add pinctrl configuration for enabling the Ethernet MAC on RoseapplePi
> > > SBC. Additionally, provide the necessary properties for the generic S500
> > > ethernet node in order to setup PHY and MDIO.
> > > 
> > > Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> > > ---
> > >  arch/arm/boot/dts/owl-s500-roseapplepi.dts | 56 ++++++++++++++++++++++
> > >  1 file changed, 56 insertions(+)
> > > 
> > > diff --git a/arch/arm/boot/dts/owl-s500-roseapplepi.dts b/arch/arm/boot/dts/owl-s500-roseapplepi.dts
> > > index b8c5db2344aa..bffabc7eaa50 100644
> > > --- a/arch/arm/boot/dts/owl-s500-roseapplepi.dts
> > > +++ b/arch/arm/boot/dts/owl-s500-roseapplepi.dts

[...]

> > > +	mdio {
> > > +		#address-cells = <1>;
> > > +		#size-cells = <0>;
> > > +
> > > +		reset-gpios = <&pinctrl 88 GPIO_ACTIVE_LOW>; /* GPIOC24 */
> > > +		reset-delay-us = <10000>;
> > > +		reset-post-delay-us = <150000>;
> > 
> > reset-* properties belong to "ethernet-phy" node. Also, while adding new nodes
> > please run the dtbs_check and try to address the warnings.
> 
> The properties are those described in Documentation/devicetree/bindings/net/mdio.yaml

Do you mean the reset properties are applicable for all PHYs in this SoC?

> The dtbs_check doesn't report any issues in my case, usually this
> happens when dtschema is not updated to the latest version. I always
> run the following command after rebasing to a new kernel version:
> 
>   pip3 install --upgrade dtschema
> 

That's good!

Thanks,
Mani

> Thanks for the review,
> Cristi
> 
> > Thanks,
> > Mani
> > 
> > > +
> > > +		eth_phy: ethernet-phy@3 {
> > > +			reg = <0x3>;
> > > +			max-speed = <100>;
> > > +			interrupt-parent = <&sirq>;
> > > +			interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
> > > +		};
> > > +	};
> > > +};
> > > +
> > >  &twd_timer {
> > >  	status = "okay";
> > >  };
> > > -- 
> > > 2.32.0
> > > 
