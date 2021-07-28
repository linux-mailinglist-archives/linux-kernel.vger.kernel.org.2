Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 867483D87A2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 08:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233956AbhG1GFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 02:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbhG1GE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 02:04:57 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 762E7C061757;
        Tue, 27 Jul 2021 23:04:56 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: gtucker)
        with ESMTPSA id 8D4CF1F433B5
Subject: Re: renesas/master bisection:
 baseline-nfs.bootrr.rockchip-usb2phy0-probed on rk3399-gru-kevin
To:     kernelci-results@groups.io, Johan Jonker <jbx6244@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>
References: <61002766.1c69fb81.8f53.9f6a@mx.google.com>
Cc:     Maciej Matuszczyk <maccraft123mc@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Jacob Chen <jacob2.chen@rock-chips.com>,
        Sandy Huang <hjc@rock-chips.com>, linux-kernel@vger.kernel.org,
        Chen-Yu Tsai <wens@csie.org>,
        Cameron Nemo <cnemo@tutanota.com>, devicetree@vger.kernel.org,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Helen Koike <helen.koike@collabora.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Shunqian Zheng <zhengsq@rock-chips.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Rob Herring <robh+dt@kernel.org>,
        Yifeng Zhao <yifeng.zhao@rock-chips.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Collabora Kernel ML <kernel@collabora.com>
From:   Guillaume Tucker <guillaume.tucker@collabora.com>
Message-ID: <c52f6cfb-1316-dd6a-46fa-17abfcc4bf18@collabora.com>
Date:   Wed, 28 Jul 2021 07:04:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <61002766.1c69fb81.8f53.9f6a@mx.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please see the bisection report below about usb2phy failing to
probe on rk3399-gru-kevin.

Reports aren't automatically sent to the public while we're
trialing new bisection features on kernelci.org but this one
looks valid.

The bisection was run in the Renesas tree but the same regression
is present in mainline for both usb2phy0 and usb2phy1 devices:

  https://linux.kernelci.org/test/plan/id/6100af012344eef9b85018f3/
  https://linux.kernelci.org/test/case/id/6100af012344eef9b85018fa/

I don't see any errors in the logs, it looks like the driver is
just not probing.

Best wishes,
Guillaume


On 27/07/2021 16:33, KernelCI bot wrote:
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
> renesas/master bisection: baseline-nfs.bootrr.rockchip-usb2phy0-probed on rk3399-gru-kevin
> 
> Summary:
>   Start:      42d1095acf6e Merge branch 'renesas-next', tag 'v5.14-rc3' into renesas-devel
>   Plain log:  https://storage.kernelci.org/renesas/master/renesas-devel-2021-07-26-v5.14-rc3/arm64/defconfig+CONFIG_RANDOMIZE_BASE=y/gcc-8/lab-collabora/baseline-nfs-rk3399-gru-kevin.txt
>   HTML log:   https://storage.kernelci.org/renesas/master/renesas-devel-2021-07-26-v5.14-rc3/arm64/defconfig+CONFIG_RANDOMIZE_BASE=y/gcc-8/lab-collabora/baseline-nfs-rk3399-gru-kevin.html
>   Result:     8c3d64251ac5 arm64: dts: rockchip: rename nodename for phy-rockchip-inno-usb2
> 
> Checks:
>   revert:     PASS
>   verify:     PASS
> 
> Parameters:
>   Tree:       renesas
>   URL:        https://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-devel.git
>   Branch:     master
>   Target:     rk3399-gru-kevin
>   CPU arch:   arm64
>   Lab:        lab-collabora
>   Compiler:   gcc-8
>   Config:     defconfig+CONFIG_RANDOMIZE_BASE=y
>   Test case:  baseline-nfs.bootrr.rockchip-usb2phy0-probed
> 
> Breaking commit found:
> 
> -------------------------------------------------------------------------------
> commit 8c3d64251ac5c5a3d10364f6b07d3603ac1e7b4a
> Author: Johan Jonker <jbx6244@gmail.com>
> Date:   Tue Jun 1 18:47:59 2021 +0200
> 
>     arm64: dts: rockchip: rename nodename for phy-rockchip-inno-usb2
>     
>     The pattern: "^(|usb-|usb2-|usb3-|pci-|pcie-|sata-)phy(@[0-9a-f,]+)*$"
>     in phy-provider.yaml has required "#phy-cells" for phy nodes.
>     The "phy-cells" in rockchip-inno-usb2 nodes are located in subnodes.
>     Rename the nodename to pattern "usb2phy@[0-9a-f]+$" to prevent
>     notifications.
>     
>     make ARCH=arm64 dtbs_check
>     DT_SCHEMA_FILES=~/.local/lib/python3.5/site-packages/dtschema/schemas/
>     phy/phy-provider.yaml
>     
>     Signed-off-by: Johan Jonker <jbx6244@gmail.com>
>     Link: https://lore.kernel.org/r/20210601164800.7670-5-jbx6244@gmail.com
>     Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> 
> diff --git a/arch/arm64/boot/dts/rockchip/px30.dtsi b/arch/arm64/boot/dts/rockchip/px30.dtsi
> index 4e243d72e16f..248ebb61aa79 100644
> --- a/arch/arm64/boot/dts/rockchip/px30.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/px30.dtsi
> @@ -822,7 +822,7 @@
>  		#address-cells = <1>;
>  		#size-cells = <1>;
>  
> -		u2phy: usb2-phy@100 {
> +		u2phy: usb2phy@100 {
>  			compatible = "rockchip,px30-usb2phy";
>  			reg = <0x100 0x20>;
>  			clocks = <&pmucru SCLK_USBPHY_REF>;
> diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> index bc0bdc3d86ff..8c821acb21ff 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> @@ -819,7 +819,7 @@
>  		#address-cells = <1>;
>  		#size-cells = <1>;
>  
> -		u2phy: usb2-phy@100 {
> +		u2phy: usb2phy@100 {
>  			compatible = "rockchip,rk3328-usb2phy";
>  			reg = <0x100 0x10>;
>  			clocks = <&xin24m>;
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> index a2eba5357693..c1a253507ac4 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> @@ -1418,7 +1418,7 @@
>  			status = "disabled";
>  		};
>  
> -		u2phy0: usb2-phy@e450 {
> +		u2phy0: usb2phy@e450 {
>  			compatible = "rockchip,rk3399-usb2phy";
>  			reg = <0xe450 0x10>;
>  			clocks = <&cru SCLK_USB2PHY0_REF>;
> @@ -1445,7 +1445,7 @@
>  			};
>  		};
>  
> -		u2phy1: usb2-phy@e460 {
> +		u2phy1: usb2phy@e460 {
>  			compatible = "rockchip,rk3399-usb2phy";
>  			reg = <0xe460 0x10>;
>  			clocks = <&cru SCLK_USB2PHY1_REF>;
> -------------------------------------------------------------------------------
> 
> 
> Git bisection log:
> 
> -------------------------------------------------------------------------------
> git bisect start
> # good: [3b9234c27991cbe7e6f97f22c3c7fef521fe34d3] Merge branch 'renesas-arm-dt-for-v5.15' into renesas-devel
> git bisect good 3b9234c27991cbe7e6f97f22c3c7fef521fe34d3
> # bad: [42d1095acf6e228a6baeec100d31a57c0c4d7704] Merge branch 'renesas-next', tag 'v5.14-rc3' into renesas-devel
> git bisect bad 42d1095acf6e228a6baeec100d31a57c0c4d7704
> # good: [514798d36572fb8eba6ccff3de10c9615063a7f5] Merge tag 'clk-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux
> git bisect good 514798d36572fb8eba6ccff3de10c9615063a7f5
> # good: [a16d8644bad461bb073b92e812080ea6715ddf2b] Merge tag 'staging-5.14-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging
> git bisect good a16d8644bad461bb073b92e812080ea6715ddf2b
> # good: [6e207b882159ed3e35a4cd4ff0fc155cce5e3cbc] Merge tag 'arm-soc-5.14' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
> git bisect good 6e207b882159ed3e35a4cd4ff0fc155cce5e3cbc
> # bad: [8b9cc17a46215af733c83bea36366419133dfa09] Merge tag 'scsi-misc' of git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi
> git bisect bad 8b9cc17a46215af733c83bea36366419133dfa09
> # good: [f82c6e6dd149757022ba3ed8502d56201652fb0f] Merge tag 'v5.14-rockchip-dts32-1' of git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip into arm/dt
> git bisect good f82c6e6dd149757022ba3ed8502d56201652fb0f
> # bad: [071e5aceebebf1d33b5c29ccfd2688ed39c60007] Merge tag 'arm-drivers-5.14' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
> git bisect bad 071e5aceebebf1d33b5c29ccfd2688ed39c60007
> # good: [1eb5f83ee936de6a69b2bcee95088a6e0ab7c202] Merge tag 'memory-controller-drv-tegra-5.14-2' of https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-mem-ctrl into arm/drivers
> git bisect good 1eb5f83ee936de6a69b2bcee95088a6e0ab7c202
> # bad: [c21cc3d8927350db675957bb44633eea9607da85] Merge tag 'qcom-arm64-for-5.14-1' of https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux into arm/dt
> git bisect bad c21cc3d8927350db675957bb44633eea9607da85
> # bad: [e1d635bc94bce69e45a2d4e93c94178613e01229] arm64: dts: rockchip: add ir-receiver for rk3399-roc-pc
> git bisect bad e1d635bc94bce69e45a2d4e93c94178613e01229
> # good: [837188d49823230f47afdbbec7556740e89a8557] arm64: dts: rockchip: add #power-domain-cells to power domain nodes
> git bisect good 837188d49823230f47afdbbec7556740e89a8557
> # bad: [9fcf74b274a1dc5bcda37c34470061ef1e1130dd] arm64: dts: rockchip: add USB support to rk3308.dtsi
> git bisect bad 9fcf74b274a1dc5bcda37c34470061ef1e1130dd
> # good: [5a65adfa2ad1542f856fc7de3999d51f3a35d2e2] arm64: dts: rockchip: Add support for PCIe on helios64
> git bisect good 5a65adfa2ad1542f856fc7de3999d51f3a35d2e2
> # good: [18d5c7bf50c6d820c366c2a23d71d468b14c87d6] arm64: dts: rockchip: add rk817 codec to Odroid Go
> git bisect good 18d5c7bf50c6d820c366c2a23d71d468b14c87d6
> # bad: [8c3d64251ac5c5a3d10364f6b07d3603ac1e7b4a] arm64: dts: rockchip: rename nodename for phy-rockchip-inno-usb2
> git bisect bad 8c3d64251ac5c5a3d10364f6b07d3603ac1e7b4a
> # first bad commit: [8c3d64251ac5c5a3d10364f6b07d3603ac1e7b4a] arm64: dts: rockchip: rename nodename for phy-rockchip-inno-usb2
> -------------------------------------------------------------------------------
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Groups.io Links: You receive all messages sent to this group.
> View/Reply Online (#14460): https://groups.io/g/kernelci-results/message/14460
> Mute This Topic: https://groups.io/mt/84484486/924702
> Group Owner: kernelci-results+owner@groups.io
> Unsubscribe: https://groups.io/g/kernelci-results/unsub [guillaume.tucker@collabora.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 
> 

