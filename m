Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53FF341646C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 19:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242546AbhIWRac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 13:30:32 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47366 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242288AbhIWRa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 13:30:29 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: gtucker)
        with ESMTPSA id 5E6351F44619
Subject: Re: next/master bisection: baseline.login on qemu_arm-vexpress-a9
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>
References: <614ad319.1c69fb81.2a0c1.4782@mx.google.com>
From:   Guillaume Tucker <guillaume.tucker@collabora.com>
Cc:     "kernelci-results@groups.io" <kernelci-results@groups.io>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Liviu Dudau <liviu.dudau@arm.com>,
        linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Message-ID: <8d6223d2-8ca7-0373-bb49-b62894e5fad7@collabora.com>
Date:   Thu, 23 Sep 2021 18:28:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <614ad319.1c69fb81.2a0c1.4782@mx.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Please see the bisection report below about a boot failure on ARM
Versatile Express.

Reports aren't automatically sent to the public while we're
trialing new bisection features on kernelci.org but this one
looks valid.

Some more details can be found here, for Cortex A9:

  https://linux.kernelci.org/test/case/id/614c36cf0c427f123799a2db/

The same issue appears to be reproducible with A15:

  https://linux.kernelci.org/test/case/id/614c3693c63eb30bb799a2f7/

Please let us know if you need help debugging the issue or if you
have a fix to try.

Best wishes,
Guillaume


GitHub: https://github.com/kernelci/kernelci-project/issues/56


On 22/09/2021 07:54, kernelci.org bot wrote:
> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> * This automated bisection report was sent to you on the basis  *
> * that you may be involved with the breaking commit it has      *
> * found.  No manual investigation has been done to verify it,   *
> * and the root cause of the problem may be somewhere else.      *
> *                                                               *
> * If you do send a fix, please include this trailer:            *
> *   Reported-by: "kernelci.org bot" <bot@kernelci.org>          *
> *                                                               *
> * Hope this helps!                                              *
> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> 
> next/master bisection: baseline.login on qemu_arm-vexpress-a9
> 
> Summary:
>   Start:      83fa5857d812b Add linux-next specific files for 20210921
>   Plain log:  https://storage.kernelci.org/next/master/next-20210921/arm/vexpress_defconfig/gcc-8/lab-baylibre/baseline-qemu_arm-vexpress-a9.txt
>   HTML log:   https://storage.kernelci.org/next/master/next-20210921/arm/vexpress_defconfig/gcc-8/lab-baylibre/baseline-qemu_arm-vexpress-a9.html
>   Result:     078fb7aa6a830 arm: dts: vexpress: Fix addressing issues with 'motherboard-bus' nodes
> 
> Checks:
>   revert:     PASS
>   verify:     PASS
> 
> Parameters:
>   Tree:       next
>   URL:        https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
>   Branch:     master
>   Target:     qemu_arm-vexpress-a9
>   CPU arch:   arm
>   Lab:        lab-baylibre
>   Compiler:   gcc-8
>   Config:     vexpress_defconfig
>   Test case:  baseline.login
> 
> Breaking commit found:
> 
> -------------------------------------------------------------------------------
> commit 078fb7aa6a8305bce09cdfbe77b4c987934442ba
> Author: Rob Herring <robh@kernel.org>
> Date:   Thu Aug 19 13:42:39 2021 -0500
> 
>     arm: dts: vexpress: Fix addressing issues with 'motherboard-bus' nodes
>     
>     The 'motherboard-bus' node in Arm Ltd boards fails schema checks as
>     'simple-bus' child nodes must have a unit-address. The 'ranges' handling is
>     also wrong (or at least strange) as the mapping of SMC chip selects should
>     be in the 'arm,vexpress,v2m-p1' node rather than a generic 'simple-bus'
>     node. Either there's 1 too many levels of 'simple-bus' nodes or 'ranges'
>     should be moved down a level. The latter change is more simple, so let's do
>     that. As the 'ranges' value doesn't vary for a given motherboard instance,
>     we can move 'ranges' into the motherboard dtsi files.
>     
>     Link: https://lore.kernel.org/r/20210819184239.1192395-6-robh@kernel.org
>     Cc: Andre Przywara <andre.przywara@arm.com>
>     Cc: Sudeep Holla <sudeep.holla@arm.com>
>     Cc: Linus Walleij <linus.walleij@linaro.org>
>     Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>     Signed-off-by: Rob Herring <robh@kernel.org>
>     Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> 
> diff --git a/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi b/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi
> index f58e8e17120d8..75927a052f8f7 100644
> --- a/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi
> +++ b/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi
> @@ -101,13 +101,22 @@
>  	};
>  
>  	bus@8000000 {
> -		motherboard-bus {
> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +
> +		motherboard-bus@8000000 {
>  			arm,hbi = <0x190>;
>  			arm,vexpress,site = <0>;
>  			compatible = "arm,vexpress,v2m-p1", "simple-bus";
>  			#address-cells = <2>; /* SMB chipselect number and offset */
>  			#size-cells = <1>;
> -			ranges;
> +			ranges = <0 0 0x08000000 0x04000000>,
> +				 <1 0 0x14000000 0x04000000>,
> +				 <2 0 0x18000000 0x04000000>,
> +				 <3 0 0x1c000000 0x04000000>,
> +				 <4 0 0x0c000000 0x04000000>,
> +				 <5 0 0x10000000 0x04000000>;
>  
>  			nor_flash: flash@0 {
>  				compatible = "arm,vexpress-flash", "cfi-flash";
> diff --git a/arch/arm/boot/dts/vexpress-v2m.dtsi b/arch/arm/boot/dts/vexpress-v2m.dtsi
> index 0819d112de123..0547f633764fa 100644
> --- a/arch/arm/boot/dts/vexpress-v2m.dtsi
> +++ b/arch/arm/boot/dts/vexpress-v2m.dtsi
> @@ -20,13 +20,23 @@
>  
>  / {
>  	bus@40000000 {
> -		motherboard {
> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0x40000000 0x40000000 0x10000000>,
> +			 <0x10000000 0x10000000 0x00020000>;
> +
> +		motherboard-bus@40000000 {
>  			arm,hbi = <0x190>;
>  			arm,vexpress,site = <0>;
>  			compatible = "arm,vexpress,v2m-p1", "simple-bus";
>  			#address-cells = <2>; /* SMB chipselect number and offset */
>  			#size-cells = <1>;
> -			ranges;
> +			ranges = <0 0 0x40000000 0x04000000>,
> +				 <1 0 0x44000000 0x04000000>,
> +				 <2 0 0x48000000 0x04000000>,
> +				 <3 0 0x4c000000 0x04000000>,
> +				 <7 0 0x10000000 0x00020000>;
>  
>  			flash@0,00000000 {
>  				compatible = "arm,vexpress-flash", "cfi-flash";
> diff --git a/arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts b/arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts
> index e63c5c0bfb43f..7fb387a7f81bd 100644
> --- a/arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts
> +++ b/arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts
> @@ -237,16 +237,7 @@
>  	};
>  
>  	bus@8000000 {
> -		compatible = "simple-bus";
> -
> -		#address-cells = <2>;
> -		#size-cells = <1>;
> -		ranges = <0 0 0 0x08000000 0x04000000>,
> -			 <1 0 0 0x14000000 0x04000000>,
> -			 <2 0 0 0x18000000 0x04000000>,
> -			 <3 0 0 0x1c000000 0x04000000>,
> -			 <4 0 0 0x0c000000 0x04000000>,
> -			 <5 0 0 0x10000000 0x04000000>;
> +		ranges = <0x8000000 0 0x8000000 0x18000000>;
>  
>  		#interrupt-cells = <1>;
>  		interrupt-map-mask = <0 0 63>;
> diff --git a/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts b/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
> index 012d40a7228c1..f81d147532732 100644
> --- a/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
> +++ b/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
> @@ -609,16 +609,7 @@
>  	};
>  
>  	smb: bus@8000000 {
> -		compatible = "simple-bus";
> -
> -		#address-cells = <2>;
> -		#size-cells = <1>;
> -		ranges = <0 0 0 0x08000000 0x04000000>,
> -			 <1 0 0 0x14000000 0x04000000>,
> -			 <2 0 0 0x18000000 0x04000000>,
> -			 <3 0 0 0x1c000000 0x04000000>,
> -			 <4 0 0 0x0c000000 0x04000000>,
> -			 <5 0 0 0x10000000 0x04000000>;
> +		ranges = <0x8000000 0 0x8000000 0x18000000>;
>  
>  		#interrupt-cells = <1>;
>  		interrupt-map-mask = <0 0 63>;
> diff --git a/arch/arm/boot/dts/vexpress-v2p-ca5s.dts b/arch/arm/boot/dts/vexpress-v2p-ca5s.dts
> index 7aa64ae257798..42dbf606b1e27 100644
> --- a/arch/arm/boot/dts/vexpress-v2p-ca5s.dts
> +++ b/arch/arm/boot/dts/vexpress-v2p-ca5s.dts
> @@ -207,16 +207,7 @@
>  	};
>  
>  	smb: bus@8000000 {
> -		compatible = "simple-bus";
> -
> -		#address-cells = <2>;
> -		#size-cells = <1>;
> -		ranges = <0 0 0x08000000 0x04000000>,
> -			 <1 0 0x14000000 0x04000000>,
> -			 <2 0 0x18000000 0x04000000>,
> -			 <3 0 0x1c000000 0x04000000>,
> -			 <4 0 0x0c000000 0x04000000>,
> -			 <5 0 0x10000000 0x04000000>;
> +		ranges = <0 0x8000000 0x18000000>;
>  
>  		#interrupt-cells = <1>;
>  		interrupt-map-mask = <0 0 63>;
> diff --git a/arch/arm/boot/dts/vexpress-v2p-ca9.dts b/arch/arm/boot/dts/vexpress-v2p-ca9.dts
> index 1317f0f58d53d..99b2f339cc04c 100644
> --- a/arch/arm/boot/dts/vexpress-v2p-ca9.dts
> +++ b/arch/arm/boot/dts/vexpress-v2p-ca9.dts
> @@ -296,16 +296,6 @@
>  	};
>  
>  	smb: bus@40000000 {
> -		compatible = "simple-bus";
> -
> -		#address-cells = <2>;
> -		#size-cells = <1>;
> -		ranges = <0 0 0x40000000 0x04000000>,
> -			 <1 0 0x44000000 0x04000000>,
> -			 <2 0 0x48000000 0x04000000>,
> -			 <3 0 0x4c000000 0x04000000>,
> -			 <7 0 0x10000000 0x00020000>;
> -
>  		#interrupt-cells = <1>;
>  		interrupt-map-mask = <0 0 63>;
>  		interrupt-map = <0 0  0 &gic 0  0 4>,
> diff --git a/arch/arm64/boot/dts/arm/fvp-base-revc.dts b/arch/arm64/boot/dts/arm/fvp-base-revc.dts
> index 2732d8e5bb5da..269b649934b5a 100644
> --- a/arch/arm64/boot/dts/arm/fvp-base-revc.dts
> +++ b/arch/arm64/boot/dts/arm/fvp-base-revc.dts
> @@ -195,17 +195,6 @@
>  	};
>  
>  	bus@8000000 {
> -		compatible = "simple-bus";
> -
> -		#address-cells = <2>;
> -		#size-cells = <1>;
> -		ranges = <0 0 0 0x08000000 0x04000000>,
> -			 <1 0 0 0x14000000 0x04000000>,
> -			 <2 0 0 0x18000000 0x04000000>,
> -			 <3 0 0 0x1c000000 0x04000000>,
> -			 <4 0 0 0x0c000000 0x04000000>,
> -			 <5 0 0 0x10000000 0x04000000>;
> -
>  		#interrupt-cells = <1>;
>  		interrupt-map-mask = <0 0 63>;
>  		interrupt-map = <0 0  0 &gic 0 0 GIC_SPI  0 IRQ_TYPE_LEVEL_HIGH>,
> diff --git a/arch/arm64/boot/dts/arm/juno-base.dtsi b/arch/arm64/boot/dts/arm/juno-base.dtsi
> index e4fea639731ed..6288e104a0893 100644
> --- a/arch/arm64/boot/dts/arm/juno-base.dtsi
> +++ b/arch/arm64/boot/dts/arm/juno-base.dtsi
> @@ -802,16 +802,6 @@
>  	};
>  
>  	bus@8000000 {
> -		compatible = "simple-bus";
> -		#address-cells = <2>;
> -		#size-cells = <1>;
> -		ranges = <0 0 0 0x08000000 0x04000000>,
> -			 <1 0 0 0x14000000 0x04000000>,
> -			 <2 0 0 0x18000000 0x04000000>,
> -			 <3 0 0 0x1c000000 0x04000000>,
> -			 <4 0 0 0x0c000000 0x04000000>,
> -			 <5 0 0 0x10000000 0x04000000>;
> -
>  		#interrupt-cells = <1>;
>  		interrupt-map-mask = <0 0 15>;
>  		interrupt-map = <0 0  0 &gic 0 GIC_SPI  68 IRQ_TYPE_LEVEL_HIGH>,
> diff --git a/arch/arm64/boot/dts/arm/juno-motherboard.dtsi b/arch/arm64/boot/dts/arm/juno-motherboard.dtsi
> index 4e124d955c8e7..fefd2b5f01762 100644
> --- a/arch/arm64/boot/dts/arm/juno-motherboard.dtsi
> +++ b/arch/arm64/boot/dts/arm/juno-motherboard.dtsi
> @@ -92,11 +92,21 @@
>  	};
>  
>  	bus@8000000 {
> -		motherboard-bus {
> +		compatible = "simple-bus";
> +		#address-cells = <2>;
> +		#size-cells = <1>;
> +		ranges = <0 0x8000000 0 0x8000000 0x18000000>;
> +
> +		motherboard-bus@8000000 {
>  			compatible = "arm,vexpress,v2p-p1", "simple-bus";
>  			#address-cells = <2>;  /* SMB chipselect number and offset */
>  			#size-cells = <1>;
> -			ranges;
> +			ranges = <0 0 0 0x08000000 0x04000000>,
> +				 <1 0 0 0x14000000 0x04000000>,
> +				 <2 0 0 0x18000000 0x04000000>,
> +				 <3 0 0 0x1c000000 0x04000000>,
> +				 <4 0 0 0x0c000000 0x04000000>,
> +				 <5 0 0 0x10000000 0x04000000>;
>  			arm,hbi = <0x252>;
>  			arm,vexpress,site = <0>;
>  
> diff --git a/arch/arm64/boot/dts/arm/rtsm_ve-aemv8a.dts b/arch/arm64/boot/dts/arm/rtsm_ve-aemv8a.dts
> index 3050f45bade4a..258991ad7cc0a 100644
> --- a/arch/arm64/boot/dts/arm/rtsm_ve-aemv8a.dts
> +++ b/arch/arm64/boot/dts/arm/rtsm_ve-aemv8a.dts
> @@ -133,17 +133,6 @@
>  	};
>  
>  	bus@8000000 {
> -		compatible = "simple-bus";
> -
> -		#address-cells = <2>;
> -		#size-cells = <1>;
> -		ranges = <0 0 0 0x08000000 0x04000000>,
> -			 <1 0 0 0x14000000 0x04000000>,
> -			 <2 0 0 0x18000000 0x04000000>,
> -			 <3 0 0 0x1c000000 0x04000000>,
> -			 <4 0 0 0x0c000000 0x04000000>,
> -			 <5 0 0 0x10000000 0x04000000>;
> -
>  		#interrupt-cells = <1>;
>  		interrupt-map-mask = <0 0 63>;
>  		interrupt-map = <0 0  0 &gic GIC_SPI  0 IRQ_TYPE_LEVEL_HIGH>,
> diff --git a/arch/arm64/boot/dts/arm/rtsm_ve-motherboard-rs2.dtsi b/arch/arm64/boot/dts/arm/rtsm_ve-motherboard-rs2.dtsi
> index b917d9d3f1c4c..33182d9e58267 100644
> --- a/arch/arm64/boot/dts/arm/rtsm_ve-motherboard-rs2.dtsi
> +++ b/arch/arm64/boot/dts/arm/rtsm_ve-motherboard-rs2.dtsi
> @@ -6,7 +6,7 @@
>   */
>  / {
>  	bus@8000000 {
> -		motherboard-bus {
> +		motherboard-bus@8000000 {
>  			arm,v2m-memory-map = "rs2";
>  
>  			iofpga-bus@300000000 {
> diff --git a/arch/arm64/boot/dts/arm/rtsm_ve-motherboard.dtsi b/arch/arm64/boot/dts/arm/rtsm_ve-motherboard.dtsi
> index d4c5528307432..5f6cab668aa07 100644
> --- a/arch/arm64/boot/dts/arm/rtsm_ve-motherboard.dtsi
> +++ b/arch/arm64/boot/dts/arm/rtsm_ve-motherboard.dtsi
> @@ -77,11 +77,21 @@
>  	};
>  
>  	bus@8000000 {
> -		motherboard-bus {
> +		compatible = "simple-bus";
> +		#address-cells = <2>;
> +		#size-cells = <1>;
> +		ranges = <0 0x8000000 0 0x8000000 0x18000000>;
> +
> +		motherboard-bus@8000000 {
>  			compatible = "arm,vexpress,v2m-p1", "simple-bus";
>  			#address-cells = <2>; /* SMB chipselect number and offset */
>  			#size-cells = <1>;
> -			ranges;
> +			ranges = <0 0 0 0x08000000 0x04000000>,
> +				 <1 0 0 0x14000000 0x04000000>,
> +				 <2 0 0 0x18000000 0x04000000>,
> +				 <3 0 0 0x1c000000 0x04000000>,
> +				 <4 0 0 0x0c000000 0x04000000>,
> +				 <5 0 0 0x10000000 0x04000000>;
>  
>  			flash@0 {
>  				compatible = "arm,vexpress-flash", "cfi-flash";
> diff --git a/arch/arm64/boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts b/arch/arm64/boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts
> index d859914500a70..5f6a5951adef7 100644
> --- a/arch/arm64/boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts
> +++ b/arch/arm64/boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts
> @@ -145,17 +145,7 @@
>  	};
>  
>  	smb: bus@8000000 {
> -		compatible = "simple-bus";
> -
> -		#address-cells = <2>;
> -		#size-cells = <1>;
> -		ranges = <0 0 0 0x08000000 0x04000000>,
> -			 <1 0 0 0x14000000 0x04000000>,
> -			 <2 0 0 0x18000000 0x04000000>,
> -			 <3 0 0 0x1c000000 0x04000000>,
> -			 <4 0 0 0x0c000000 0x04000000>,
> -			 <5 0 0 0x10000000 0x04000000>;
> -
> +		ranges = <0x8000000 0 0x8000000 0x18000000>;
>  		#interrupt-cells = <1>;
>  		interrupt-map-mask = <0 0 63>;
>  		interrupt-map = <0 0  0 &gic GIC_SPI  0 IRQ_TYPE_LEVEL_HIGH>,
> -------------------------------------------------------------------------------
> 
> 
> Git bisection log:
> 
> -------------------------------------------------------------------------------
> git bisect start
> # good: [4c17ca27923c16fd73bbb9ad033c7d749c3bcfcc] Merge tag 'spi-fix-v5.15-rc2' of git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi
> git bisect good 4c17ca27923c16fd73bbb9ad033c7d749c3bcfcc
> # bad: [83fa5857d812b46010841c677a90a3f858c2c838] Add linux-next specific files for 20210921
> git bisect bad 83fa5857d812b46010841c677a90a3f858c2c838
> # bad: [e3d55aba26023f58316d5f09972e078a7062fbbe] Merge branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git
> git bisect bad e3d55aba26023f58316d5f09972e078a7062fbbe
> # bad: [ce9cef713f919ce3c0920a090f9d2cf9193d5b31] Merge branch 'fscache-next' of git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git
> git bisect bad ce9cef713f919ce3c0920a090f9d2cf9193d5b31
> # good: [df0148f671633f6c0bd0a7648c46bcbace96329a] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux.git
> git bisect good df0148f671633f6c0bd0a7648c46bcbace96329a
> # bad: [5e678fcdf3c5a8c03ae89695c638911c3a6daf42] Merge branch 'sunxi/for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git
> git bisect bad 5e678fcdf3c5a8c03ae89695c638911c3a6daf42
> # good: [6092ed8fe34ac73f16a7dfa50f0ec0732e594962] Merge branch 'v5.16-clk/next' into for-next
> git bisect good 6092ed8fe34ac73f16a7dfa50f0ec0732e594962
> # good: [a56098cf11bf42f0037c77b8664fef98370e9671] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git
> git bisect good a56098cf11bf42f0037c77b8664fef98370e9671
> # good: [bb289f4c0b2bb10c7ecd51b6799cd9d1b9c409aa] Merge branches 'sunxi/clk-for-5.16', 'sunxi/core-for-5.16', 'sunxi/drivers-for-5.16', 'sunxi/dt-for-5.16' and 'sunxi/fixes-for-5.15' into sunxi/for-next
> git bisect good bb289f4c0b2bb10c7ecd51b6799cd9d1b9c409aa
> # bad: [34eae8520c886bca0ca43c2cbe3ddf1a24cc2e04] Merge branch 'for-next/juno' of git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux into for-linux-next
> git bisect bad 34eae8520c886bca0ca43c2cbe3ddf1a24cc2e04
> # good: [55c71dc69ecb328e6212ac5154099c4230d0b83f] arm: dts: vexpress: Drop unused properties from motherboard node
> git bisect good 55c71dc69ecb328e6212ac5154099c4230d0b83f
> # good: [849dca7fbdcc589764dde874b3c2d6c99ea277c4] Merge branch 'for-next/scmi' of git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux into for-linux-next
> git bisect good 849dca7fbdcc589764dde874b3c2d6c99ea277c4
> # bad: [078fb7aa6a8305bce09cdfbe77b4c987934442ba] arm: dts: vexpress: Fix addressing issues with 'motherboard-bus' nodes
> git bisect bad 078fb7aa6a8305bce09cdfbe77b4c987934442ba
> # good: [2e9edc07df2ec6f835222151fa4e536e9e54856a] arm: dts: vexpress-v2p-ca9: Fix the SMB unit-address
> git bisect good 2e9edc07df2ec6f835222151fa4e536e9e54856a
> # first bad commit: [078fb7aa6a8305bce09cdfbe77b4c987934442ba] arm: dts: vexpress: Fix addressing issues with 'motherboard-bus' nodes
> -------------------------------------------------------------------------------
> 

