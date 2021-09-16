Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1778240DA46
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 14:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239672AbhIPMtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 08:49:50 -0400
Received: from mx1.tq-group.com ([93.104.207.81]:15265 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232181AbhIPMtq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 08:49:46 -0400
X-Greylist: delayed 431 seconds by postgrey-1.27 at vger.kernel.org; Thu, 16 Sep 2021 08:49:45 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1631796506; x=1663332506;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ykdzm4haCFJvWuW9ljTbSMtQyKZmQuVu8x/zfRHUC6Q=;
  b=SGK38Rpr+cm9l8W8y8/0HXBxFLKZWtyWSB5H8vprZwxggyK3wkc2FwA2
   /c90KffIJICx635rhOTNIkNSvckn/SfCZC5QEmFu5iz1/wmt7wHQ7xiwY
   Skc088XlIZdXR3nutJ182uHGU6jcqKQfjDg0Vt3AKKMeV0xxH6coo2BZl
   QwHRVYurGNcpmgBbQreMw1AT1M4IZ6PX+nQ6Sd+LjUMBHCUiSW0OJRBrL
   t5/ts94frqPIuZROvFTBFfepajjdZKgRY9WTrlgC9U4jCo8UYBAfdYF/1
   okdTXXWuXW4afEHfvs2ZYyf31Da55KRHAn+LHZcFsVFQQpo+qFDUAbB03
   w==;
X-IronPort-AV: E=Sophos;i="5.85,298,1624312800"; 
   d="scan'208";a="19552342"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 16 Sep 2021 14:41:13 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Thu, 16 Sep 2021 14:41:13 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Thu, 16 Sep 2021 14:41:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1631796073; x=1663332073;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ykdzm4haCFJvWuW9ljTbSMtQyKZmQuVu8x/zfRHUC6Q=;
  b=CZduA0BmJaq3hbWuV7mfdm3bUmlCQy44nIklP3xB2Ftdjxmt3DJNoY5c
   bliWZiX87V3Sr2c9AD1dExq/a74BOV5oVsqnrHhidt05WJA6z1AHNWg1K
   dmUsCTNC+ZqQqNTwVwNPXYZ9z5t/IpY2cX5zNztDjKwBF4VGw539U06zM
   imNjrBW1k2ZvY8lseoj6eZ9wMVtgzrAKP7fE0dDSTxrBjSnQTwDwUvmpr
   Upr4JcoiehoZCX4yYs53h3Dbi1uHOZ2CH23cX6LphV/7Cq2AITkDO1cmC
   srPQEtao2MfrOicB53pKHvWD0Ztbuq3Hw1dMvjxoHWzoQIMbyYBNXe4bZ
   Q==;
X-IronPort-AV: E=Sophos;i="5.85,298,1624312800"; 
   d="scan'208";a="19552341"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 16 Sep 2021 14:41:13 +0200
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.121.48.12])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 5E0FC280070;
        Thu, 16 Sep 2021 14:41:13 +0200 (CEST)
Message-ID: <ee4b6f3040d9357ad7d1be80e02ec97be05a9e5b.camel@ew.tq-group.com>
Subject: Re: [PATCH v2 1/2] ARM: dts: imx7-tqma7: add SPI-NOR flash
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Date:   Thu, 16 Sep 2021 14:41:11 +0200
In-Reply-To: <20201102082431.ww6q4x3kyr4ix72k@pengutronix.de>
References: <20201030102636.16476-1-matthias.schiffer@ew.tq-group.com>
         <20201102082431.ww6q4x3kyr4ix72k@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-11-02 at 09:24 +0100, Marco Felsch wrote:
> Hi Matthias,
> 
> On 20-10-30 11:26, Matthias Schiffer wrote:
> > The SPI-NOR flash on the SoM was missing from the device tree.
> > 
> > Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> > ---
> >  arch/arm/boot/dts/imx7-tqma7.dtsi | 30 ++++++++++++++++++++++++++++++
> >  1 file changed, 30 insertions(+)
> > 
> > v2: change node name to flash@0

Sorry for the very late reply, I intend to address the review comments
soon.


> > 
> > 
> > diff --git a/arch/arm/boot/dts/imx7-tqma7.dtsi b/arch/arm/boot/dts/imx7-tqma7.dtsi
> > index 8773344b54aa..22f4194322ed 100644
> > --- a/arch/arm/boot/dts/imx7-tqma7.dtsi
> > +++ b/arch/arm/boot/dts/imx7-tqma7.dtsi
> > @@ -160,6 +160,20 @@
> >  		>;
> >  	};
> >  
> > +	pinctrl_qspi: qspigrp {
> > +		fsl,pins = <
> > +			MX7D_PAD_EPDC_DATA00__QSPI_A_DATA0	0x5A
> > +			MX7D_PAD_EPDC_DATA01__QSPI_A_DATA1	0x5A
> > +			MX7D_PAD_EPDC_DATA02__QSPI_A_DATA2	0x5A
> > +			MX7D_PAD_EPDC_DATA03__QSPI_A_DATA3	0x5A
> > +			MX7D_PAD_EPDC_DATA05__QSPI_A_SCLK	0x11
> > +			MX7D_PAD_EPDC_DATA06__QSPI_A_SS0_B	0x54
> > +			MX7D_PAD_EPDC_DATA07__QSPI_A_SS1_B	0x54
> 
> As far as I know we are using GPIO based chip selects and not the one
> from the controller-IP or is this different for qspi?

Native chip selects are used for QSPI. I don't think GPIO CS make sense
for this kind of QSPI controller that provides memory-mapped access to
SPI flash.


> 
> > +			/* #QSPI_RESET */
> > +			MX7D_PAD_EPDC_DATA04__GPIO2_IO4		0x40000052
> 
> Do you really need to mux the reset-gpio?

The muxing configures a pullup on the reset pin to ensure that a
connected flash chip is not held in reset. However, the signal is
marked as optional in the schematics, and on all SoMs I have here the
flash reset is wired to the board reset instead of this SoC GPIO.

Still, configuring the pullup seems like a good idea to me, in case
hardware variants with the optional signal actually exist - there
shouldn't be any downsides, as the pin is either unconnected or wired
to the flash reset.

I guess I could additionally add an input hog to ensure that the pin
cannot be changed?

The SION bit in the pad configuration seems to be a mistake, I'll
remove it.


> 
> > +		>;
> > +	};
> > +
> >  	pinctrl_usdhc3: usdhc3grp {
> >  		fsl,pins = <
> >  			MX7D_PAD_SD3_CMD__SD3_CMD		0x59
> > @@ -217,6 +231,22 @@
> >  	};
> >  };
> >  
> > +&qspi {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pinctrl_qspi>;
> > +	status = "okay";
> > +
> > +	flash0: flash@0 {
> > +		#address-cells = <1>;
> > +		#size-cells = <1>;
> > +		compatible = "jedec,spi-nor";
> > +		spi-max-frequency = <29000000>;
> > +		spi-rx-bus-width = <4>;
> > +		spi-tx-bus-width = <4>;
> > +		reg = <0>;
> 
> Please check Documentation/devicetree/bindings/mtd/partition.txt to see
> how partitions are added nowadays. With this in mind you should reorder
> the node to:
> 
> 	compatible = "jedec,spi-nor";
> 	reg = <0>;
> 	spi-max-frequency = <29000000>;
> 	spi-rx-bus-width = <4>;
> 	spi-tx-bus-width = <4>;
> 
> 
> Regards,
>   Marco
> 
> > +	};
> > +};
> > +
> >  &sdma {
> >  	status = "okay";
> >  };
> > -- 
> > 2.17.1
> > 
> > 
> > 

