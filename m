Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E60C3A3C0D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 08:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbhFKGeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 02:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbhFKGeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 02:34:03 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3457EC061574;
        Thu, 10 Jun 2021 23:31:52 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id a20so4798740wrc.0;
        Thu, 10 Jun 2021 23:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=T7iF5ZMY6ZWEGrhXL0YRbotr29Dqadw5YgVTwfLkbGk=;
        b=jiFAVTLKQGsQUiKVCdzHcNXE3o1xXLiM0IL/4KXay1WhV6Yg5KZFlZtJ0CdtZ6Fhfu
         5Lq0BXpcT+nOVFnAV5aS3zt1UdjiWGx2ody4FU6qwAjtoY4tGurrXJzoHrDNfNCKXiRH
         SYrNd0+Q9si5UqH+n3swnslcZmOYucR0RFeXnx/PJp3N5zDXoRldv38l8QCN5ht4WJon
         Z7BevAdBItb6GMFFeB9AgSp4ibe/Vgupp80PFICjxxMPx1EL89RKA56J1m78nSnqVn5M
         84jEi19mUfHQ/J5NcxjdKxNujjURuyxSakJq0ybCxmGxQJCK82frwPEzxIVxciYHLNTp
         enxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=T7iF5ZMY6ZWEGrhXL0YRbotr29Dqadw5YgVTwfLkbGk=;
        b=FmksU+9bhJfFUXCiFHtUJl7ljCwFKr8mYxEOQXp6NdGOhc9gw+rQlaugMiWlMKPf2f
         Y2IX5d0/rwqRoCnBaI63J/dbVJ1nLTeMq0M3MqtfGdfscGfvXVwSmialdlY4M3GhHiF0
         /M4C94tO2DigwO63x1sPHpfSIg83+xJDOt3iadNtyHTgUy3t8+/OuEpPu2BUwf/NEMue
         hFQf1SLZHYsk+RcRY7fR+qF7AcpaKkgZ/gJdRhFz0tBLaEuEWitiSVAEsVh9l5G5p0Ne
         nNNHHdTlOMFQU1sKok9gjhW0H+3cp0h9bUR4b8sT+8bPX3M4LKyKEkv2en2KT0ri707b
         VTOw==
X-Gm-Message-State: AOAM532hDaSBRDxk7kGdzYv5IVtDhrkMSa5ViS0MzeL2xSMuihMiHIl2
        BlzZLMwn+JJLa3KtSZNVv4I=
X-Google-Smtp-Source: ABdhPJxQcF/2GQrwzEYdryfigc6qm741ARdp5fVdTOCppp7+c8t6+czedXyrqHFvB9pc49BfOKru+g==
X-Received: by 2002:a5d:6d8a:: with SMTP id l10mr2190754wrs.63.1623393110791;
        Thu, 10 Jun 2021 23:31:50 -0700 (PDT)
Received: from BV030612LT ([188.24.178.25])
        by smtp.gmail.com with ESMTPSA id i2sm4859160wmo.40.2021.06.10.23.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 23:31:50 -0700 (PDT)
Date:   Fri, 11 Jun 2021 09:31:47 +0300
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Manivannan Sadhasivam <mani@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ARM: dts: owl-s500-roseapplepi: Add ethernet support
Message-ID: <20210611063147.GA1520454@BV030612LT>
References: <cover.1623358117.git.cristian.ciocaltea@gmail.com>
 <632e12c445ced7f10e6d7240162484ae5afc148e.1623358117.git.cristian.ciocaltea@gmail.com>
 <20210611055606.GB6950@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210611055606.GB6950@thinkpad>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 11, 2021 at 11:26:06AM +0530, Manivannan Sadhasivam wrote:
> On Fri, Jun 11, 2021 at 12:09:22AM +0300, Cristian Ciocaltea wrote:
> > Add pinctrl configuration for enabling the Ethernet MAC on RoseapplePi
> > SBC. Additionally, provide the necessary properties for the generic S500
> > ethernet node in order to setup PHY and MDIO.
> > 
> > Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> > ---
> >  arch/arm/boot/dts/owl-s500-roseapplepi.dts | 56 ++++++++++++++++++++++
> >  1 file changed, 56 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/owl-s500-roseapplepi.dts b/arch/arm/boot/dts/owl-s500-roseapplepi.dts
> > index b8c5db2344aa..bffabc7eaa50 100644
> > --- a/arch/arm/boot/dts/owl-s500-roseapplepi.dts
> > +++ b/arch/arm/boot/dts/owl-s500-roseapplepi.dts
> > @@ -225,6 +225,38 @@ bias1-pinconf {
> >  			bias-pull-down;
> >  		};
> >  	};
> > +
> > +	ethernet_pins: ethernet-pins {
> > +		txd01-pinmux {
> > +			groups = "rmii_txd0_mfp", "rmii_txd1_mfp";
> > +			function = "eth_rmii";
> > +		};
> > +
> > +		rxd01-pinmux {
> > +			groups = "rmii_rxd0_mfp", "rmii_rxd1_mfp";
> > +			function = "eth_rmii";
> > +		};
> > +
> > +		txen_rxer-pinmux {
> > +			groups = "rmii_txen_mfp", "rmii_rxen_mfp";
> > +			function = "eth_rmii";
> > +		};
> > +
> > +		crs_dv_ref_clk-pinmux {
> > +			groups = "rmii_crs_dv_mfp", "rmii_ref_clk_mfp";
> > +			function = "eth_rmii";
> 
> Since the function is same, just club all the groups together.

Sure.

> > +		};
> > +
> > +		ref_clk-pinconf {
> > +			groups = "rmii_ref_clk_drv";
> > +			drive-strength = <2>;
> > +		};
> > +
> > +		phy_clk-pinmux {
> > +			groups = "clko_25m_mfp";
> > +			function = "clko_25m";
> > +		};
> 
> Move this above node pinconf.

Ok.

> > +	};
> >  };
> >  
> >  /* uSD */
> > @@ -241,6 +273,30 @@ &mmc0 {
> >  	vqmmc-supply = <&sd_vcc>;
> >  };
> >  
> > +&ethernet {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&ethernet_pins>;
> > +	phy-mode = "rmii";
> > +	phy-handle = <&eth_phy>;
> > +	status = "okay";
> > +
> > +	mdio {
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +
> > +		reset-gpios = <&pinctrl 88 GPIO_ACTIVE_LOW>; /* GPIOC24 */
> > +		reset-delay-us = <10000>;
> > +		reset-post-delay-us = <150000>;
> 
> reset-* properties belong to "ethernet-phy" node. Also, while adding new nodes
> please run the dtbs_check and try to address the warnings.

The properties are those described in Documentation/devicetree/bindings/net/mdio.yaml
The dtbs_check doesn't report any issues in my case, usually this
happens when dtschema is not updated to the latest version. I always
run the following command after rebasing to a new kernel version:

  pip3 install --upgrade dtschema

Thanks for the review,
Cristi

> Thanks,
> Mani
> 
> > +
> > +		eth_phy: ethernet-phy@3 {
> > +			reg = <0x3>;
> > +			max-speed = <100>;
> > +			interrupt-parent = <&sirq>;
> > +			interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
> > +		};
> > +	};
> > +};
> > +
> >  &twd_timer {
> >  	status = "okay";
> >  };
> > -- 
> > 2.32.0
> > 
