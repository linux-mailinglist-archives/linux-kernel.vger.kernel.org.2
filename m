Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C36E3D5316
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 08:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbhGZFim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 01:38:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:44828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231263AbhGZFil (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 01:38:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 255FD60E09;
        Mon, 26 Jul 2021 06:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627280350;
        bh=xF8lgHoYB4TvhYMo5h7NMc8pDB8PIcibAKK3NzNZmhs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kJ2O4aX3nWetnqsBOgGQ4oe174GfGCvBQ6CJksw7aL9+LQI33a8xFPIwRwzkan7k3
         eEj+XJ4tfOoXyIx/ZW48cOZ0cM98EW3S8VCMVlR0kBy7HlzMQGZolMzMEwkkzIAveK
         /nm8K3CMEniZz2PIY34EqZYenWr5Y04uwspZXVJ5BKa9kKKU9gPolQhw9x6H841gjM
         Zv9Pxu8pGlB8UblBOdgiH1NA+dYDe3vk29803JHZa7G/8Ch1mOtr+G20x+KHiXzE0C
         R1QINqcWVI9Rm9q08veUejzr29KIXNv6uYJAfhCDSLAg46IiWBU1cmUauBPlpurwQE
         y8oHDO3h+T+og==
Date:   Mon, 26 Jul 2021 08:19:03 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Wei Xu <xuwei5@hisilicon.com>
Cc:     <linuxarm@huawei.com>, <mauro.chehab@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, "xuwei (O)" <xuwei5@huawei.com>
Subject: Re: [PATCH 1/2] dts: hisilicon: add support for the PMIC found on
 Hikey 970
Message-ID: <20210726081812.54431189@coco.lan>
In-Reply-To: <60FE20AC.3050400@hisilicon.com>
References: <cover.1627116285.git.mchehab+huawei@kernel.org>
        <4a3583dd683512c2a4a138e88d4c889e51bf48e8.1627116285.git.mchehab+huawei@kernel.org>
        <60FE20AC.3050400@hisilicon.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, 26 Jul 2021 10:40:44 +0800
Wei Xu <xuwei5@hisilicon.com> escreveu:

> Hi Mauro,
> 
> On 2021/7/24 16:55, Mauro Carvalho Chehab wrote:
> > Add a device tree for the HiSilicon 6421v600 SPMI PMIC, used
> > on HiKey970 board.
> > 
> > As we now have support for it, change the fixed regulators
> > used by the SD I/O to use the proper LDO supplies.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---
> >  .../boot/dts/hisilicon/hi3670-hikey970.dts    | 22 +----
> >  .../boot/dts/hisilicon/hikey970-pmic.dtsi     | 86 +++++++++++++++++++
> >  2 files changed, 89 insertions(+), 19 deletions(-)
> >  create mode 100644 arch/arm64/boot/dts/hisilicon/hikey970-pmic.dtsi
> > 
> > diff --git a/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts b/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts
> > index d8abf442ee7e..7c32f5fd5cc5 100644
> > --- a/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts
> > +++ b/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts
> > @@ -12,6 +12,7 @@
> >  
> >  #include "hi3670.dtsi"
> >  #include "hikey970-pinctrl.dtsi"
> > +#include "hikey970-pmic.dtsi"
> >  
> >  / {
> >  	model = "HiKey970";
> > @@ -39,23 +40,6 @@ memory@0 {
> >  		reg = <0x0 0x0 0x0 0x0>;
> >  	};
> >  
> > -	sd_1v8: regulator-1v8 {
> > -		compatible = "regulator-fixed";
> > -		regulator-name = "fixed-1.8V";
> > -		regulator-min-microvolt = <1800000>;
> > -		regulator-max-microvolt = <1800000>;
> > -		regulator-always-on;
> > -	};
> > -
> > -	sd_3v3: regulator-3v3 {
> > -		compatible = "regulator-fixed";
> > -		regulator-name = "fixed-3.3V";
> > -		regulator-min-microvolt = <3300000>;
> > -		regulator-max-microvolt = <3300000>;
> > -		regulator-boot-on;
> > -		regulator-always-on;
> > -	};
> > -
> >  	wlan_en: wlan-en-1-8v {
> >  		compatible = "regulator-fixed";
> >  		regulator-name = "wlan-en-regulator";
> > @@ -402,8 +386,8 @@ &dwmmc1 {
> >  	pinctrl-0 = <&sd_pmx_func
> >  		     &sd_clk_cfg_func  
> >  		     &sd_cfg_func>;  
> > -	vmmc-supply = <&sd_3v3>;
> > -	vqmmc-supply = <&sd_1v8>;
> > +	vmmc-supply = <&ldo16>;
> > +	vqmmc-supply = <&ldo9>;
> >  	status = "okay";
> >  };
> >  
> > diff --git a/arch/arm64/boot/dts/hisilicon/hikey970-pmic.dtsi b/arch/arm64/boot/dts/hisilicon/hikey970-pmic.dtsi
> > new file mode 100644
> > index 000000000000..970047f2dabd
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/hisilicon/hikey970-pmic.dtsi
> > @@ -0,0 +1,86 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * dts file for Hi6421v600 SPMI PMIC used at the HiKey970 Development Board
> > + *
> > + * Copyright (C) 2020, Huawei Tech. Co., Ltd.
> > + */
> > +
> > +#include <dt-bindings/spmi/spmi.h>
> > +
> > +/ {
> > +	spmi: spmi@fff24000 {
> > +		compatible = "hisilicon,kirin970-spmi-controller";
> > +		#address-cells = <2>;
> > +		#size-cells = <0>;
> > +		status = "okay";
> > +		reg = <0x0 0xfff24000 0x0 0x1000>;
> > +		hisilicon,spmi-channel = <2>;
> > +
> > +		pmic: pmic@0 {
> > +			compatible = "hisilicon,hi6421-spmi";  
> 
> Should this be "hisilicon,hi6421-pmic" which is already in the binding document "mfd/hi6421.txt"?
> Others are OK to me.

No. 

hisilicon,hi6421-pmic is used by this driver
	drivers/mfd/hi6421-pmic-core.c

which provides support for the Hi6421 variants that don't use a MIPI
SPMI bus.

The "hisilicon,hi6421-spmi" compatible is for the new driver:
	drivers/mfd/hi6421-spmi-pmic.c

And it is defined at:
	Documentation/devicetree/bindings/mfd/hisilicon,hi6421-spmi-pmic.yaml

Both DT bindings and the driver were promoted from staging on this patch:

	https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git/commit/?h=staging-next&id=9bd9e0de1cf5b89c4854be505ac0a418ddcc01bf

Regards,
Mauro
