Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC1823D548A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 09:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232760AbhGZHDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 03:03:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:60092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231836AbhGZHDV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 03:03:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8B2F160C51;
        Mon, 26 Jul 2021 07:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627285430;
        bh=NHQc2BQbV+EpmfsJG7sWI5huE7s0E6egpdCnikBrACM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eNU1PUe114yOBv0o1RHTLCE8znJx8Uk9ZBT6kFZTYU0a36Vy2xEhw8bNjEs9IHVfv
         jtyTc1mto+46eT036JLZFXRTMUTvnaG5rbH7bwhtv6y/nBKUI+6doUtSbz6VnG5V2Q
         98nUMQQeKIIFkZEFKtUOG3UGllOAFVwO1/c5GMEMKLoiUPJrvVnP4EqsmDlFpc/URt
         P863pG8JKLDUzEvJ5phAjW2D2jqGX8IrcEs9STx2ZXty+XtfTn5a96bqngV9Ooic8P
         YsI7PoYZBKlYRru/mnpfyk09rrt/JuPPZXgs+9KmuxlGxLiFttcXMRIOshl8JfeBvb
         srgn7c56rCJFw==
Date:   Mon, 26 Jul 2021 09:43:44 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Wei Xu <xuwei5@hisilicon.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     <linuxarm@huawei.com>, <mauro.chehab@huawei.com>,
        Rob Herring <robh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, "xuwei (O)" <xuwei5@huawei.com>
Subject: Re: [PATCH 1/2] dts: hisilicon: add support for the PMIC found on
 Hikey 970
Message-ID: <20210726094344.0a415bd0@coco.lan>
In-Reply-To: <60FE57B5.2010603@hisilicon.com>
References: <cover.1627116285.git.mchehab+huawei@kernel.org>
        <4a3583dd683512c2a4a138e88d4c889e51bf48e8.1627116285.git.mchehab+huawei@kernel.org>
        <60FE20AC.3050400@hisilicon.com>
        <20210726081812.54431189@coco.lan>
        <60FE57B5.2010603@hisilicon.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, 26 Jul 2021 14:35:33 +0800
Wei Xu <xuwei5@hisilicon.com> escreveu:

> Hi Mauro,
> 
> On 2021/7/26 14:19, Mauro Carvalho Chehab wrote:
> > Em Mon, 26 Jul 2021 10:40:44 +0800
> > Wei Xu <xuwei5@hisilicon.com> escreveu:
> >   
> >> Hi Mauro,
> >>
> >> On 2021/7/24 16:55, Mauro Carvalho Chehab wrote:  
> >>> Add a device tree for the HiSilicon 6421v600 SPMI PMIC, used
> >>> on HiKey970 board.
> >>>
> >>> As we now have support for it, change the fixed regulators
> >>> used by the SD I/O to use the proper LDO supplies.
> >>>
> >>> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> >>> ---
> >>>  .../boot/dts/hisilicon/hi3670-hikey970.dts    | 22 +----
> >>>  .../boot/dts/hisilicon/hikey970-pmic.dtsi     | 86 +++++++++++++++++++
> >>>  2 files changed, 89 insertions(+), 19 deletions(-)
> >>>  create mode 100644 arch/arm64/boot/dts/hisilicon/hikey970-pmic.dtsi
> >>>
> >>> diff --git a/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts b/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts
> >>> index d8abf442ee7e..7c32f5fd5cc5 100644
> >>> --- a/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts
> >>> +++ b/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts
> >>> @@ -12,6 +12,7 @@
> >>>  
> >>>  #include "hi3670.dtsi"
> >>>  #include "hikey970-pinctrl.dtsi"
> >>> +#include "hikey970-pmic.dtsi"
> >>>  
> >>>  / {
> >>>  	model = "HiKey970";
> >>> @@ -39,23 +40,6 @@ memory@0 {
> >>>  		reg = <0x0 0x0 0x0 0x0>;
> >>>  	};
> >>>  
> >>> -	sd_1v8: regulator-1v8 {
> >>> -		compatible = "regulator-fixed";
> >>> -		regulator-name = "fixed-1.8V";
> >>> -		regulator-min-microvolt = <1800000>;
> >>> -		regulator-max-microvolt = <1800000>;
> >>> -		regulator-always-on;
> >>> -	};
> >>> -
> >>> -	sd_3v3: regulator-3v3 {
> >>> -		compatible = "regulator-fixed";
> >>> -		regulator-name = "fixed-3.3V";
> >>> -		regulator-min-microvolt = <3300000>;
> >>> -		regulator-max-microvolt = <3300000>;
> >>> -		regulator-boot-on;
> >>> -		regulator-always-on;
> >>> -	};
> >>> -
> >>>  	wlan_en: wlan-en-1-8v {
> >>>  		compatible = "regulator-fixed";
> >>>  		regulator-name = "wlan-en-regulator";
> >>> @@ -402,8 +386,8 @@ &dwmmc1 {
> >>>  	pinctrl-0 = <&sd_pmx_func
> >>>  		     &sd_clk_cfg_func    
> >>>  		     &sd_cfg_func>;    
> >>> -	vmmc-supply = <&sd_3v3>;
> >>> -	vqmmc-supply = <&sd_1v8>;
> >>> +	vmmc-supply = <&ldo16>;
> >>> +	vqmmc-supply = <&ldo9>;
> >>>  	status = "okay";
> >>>  };
> >>>  
> >>> diff --git a/arch/arm64/boot/dts/hisilicon/hikey970-pmic.dtsi b/arch/arm64/boot/dts/hisilicon/hikey970-pmic.dtsi
> >>> new file mode 100644
> >>> index 000000000000..970047f2dabd
> >>> --- /dev/null
> >>> +++ b/arch/arm64/boot/dts/hisilicon/hikey970-pmic.dtsi
> >>> @@ -0,0 +1,86 @@
> >>> +// SPDX-License-Identifier: GPL-2.0
> >>> +/*
> >>> + * dts file for Hi6421v600 SPMI PMIC used at the HiKey970 Development Board
> >>> + *
> >>> + * Copyright (C) 2020, Huawei Tech. Co., Ltd.
> >>> + */
> >>> +
> >>> +#include <dt-bindings/spmi/spmi.h>
> >>> +
> >>> +/ {
> >>> +	spmi: spmi@fff24000 {
> >>> +		compatible = "hisilicon,kirin970-spmi-controller";
> >>> +		#address-cells = <2>;
> >>> +		#size-cells = <0>;
> >>> +		status = "okay";
> >>> +		reg = <0x0 0xfff24000 0x0 0x1000>;
> >>> +		hisilicon,spmi-channel = <2>;
> >>> +
> >>> +		pmic: pmic@0 {
> >>> +			compatible = "hisilicon,hi6421-spmi";    
> >>
> >> Should this be "hisilicon,hi6421-pmic" which is already in the binding document "mfd/hi6421.txt"?
> >> Others are OK to me.  
> > 
> > No. 
> > 
> > hisilicon,hi6421-pmic is used by this driver
> > 	drivers/mfd/hi6421-pmic-core.c
> > 
> > which provides support for the Hi6421 variants that don't use a MIPI
> > SPMI bus.
> > 
> > The "hisilicon,hi6421-spmi" compatible is for the new driver:
> > 	drivers/mfd/hi6421-spmi-pmic.c
> > 
> > And it is defined at:
> > 	Documentation/devicetree/bindings/mfd/hisilicon,hi6421-spmi-pmic.yaml
> > 
> > Both DT bindings and the driver were promoted from staging on this patch:
> > 
> > 	https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git/commit/?h=staging-next&id=9bd9e0de1cf5b89c4854be505ac0a418ddcc01bf  
> 
> Got it. Thanks for your kind explanation!
> So I am fine with this patch.
> Do you need my ack now or later I can merge it once it is out of staging.

Whatever works best for you and Greg.

It should be noticed that the driver should be out of staging for v5.15-rc1
(as the patch moving it out of staging was already merged at Greg's tree).
This patch is needed by the PCI driver patchset I'm currently working,
so the best would be if this patch could also be merged for v5.15-rc1
(either via HiSilicon tree or via staging tree).

I suspect that having your ack and merging this via staging would work
best, as this would ensure that both changes will be merged upstream
at the same time.

But, as I said, it is up to you both ;-)

Thanks,
Mauro
