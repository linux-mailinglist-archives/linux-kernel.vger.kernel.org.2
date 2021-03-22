Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11FB134495D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 16:36:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbhCVPgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 11:36:17 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:51440 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbhCVPf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 11:35:57 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12MFZl6V036824;
        Mon, 22 Mar 2021 10:35:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1616427347;
        bh=09AtaVjJH+oz8QL+pYId5GvQzzXcwsfv35oByjnH9A4=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=buPOGlo+3ezC5WQrcyWE9TjSH2g5L6uiHgVXJeBs5I7reuJH8J3QsZ/z9967wNr3n
         84syCKFZEtJ7oAzbExpCnD25nT6fb9PS5w7gVGUjDAc/CF5j/3vxB7O3jWP0MHmE30
         +FsE6p/SZbDh8hoxDGcQmxd/HVh6d3lgDHI00A+s=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12MFZl10108074
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 22 Mar 2021 10:35:47 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 22
 Mar 2021 10:35:47 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Mon, 22 Mar 2021 10:35:47 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12MFZlqN102141;
        Mon, 22 Mar 2021 10:35:47 -0500
Date:   Mon, 22 Mar 2021 10:35:47 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Aswath Govindraju <a-govindraju@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 3/3] arm64: dts: ti: k3-j7200: Add support for higher
 speed modes and update delay select values for MMCSD subsystems
Message-ID: <20210322153547.d5hkqydpe372rpwg@manicure>
References: <20210322131206.24887-1-a-govindraju@ti.com>
 <20210322131206.24887-4-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210322131206.24887-4-a-govindraju@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18:42-20210322, Aswath Govindraju wrote:
> The following speed modes are now supported in J7200 SoC,
> - HS200 and HS400 modes at 1.8 V card voltage, in MMCSD0 subsystem [1].
> - UHS-I speed modes in MMCSD1 subsystem [1].
> 
> Add support for UHS-I modes by adding voltage regulator device tree nodes
> and corresponding pinmux details, to power cycle and voltage switch cards.
> Set respective tags in sdhci0 and remove no-1-8-v tag from sdhci1
> device tree nodes.
> 
> Also update the delay values for various speed modes supported, based on
> the revised january 2021 J7200 datasheet[2].
> 
> [1] - section 12.3.6.1.1 MMCSD Features, in
>       https://www.ti.com/lit/ug/spruiu1a/spruiu1a.pdf,
>       (SPRUIU1A – JULY 2020 – REVISED JANUARY 2021)
> 
> [2] - https://www.ti.com/lit/ds/symlink/dra821u.pdf,
>       (SPRSP57B – APRIL 2020 – REVISED JANUARY 2021)
> 
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> ---
>  .../dts/ti/k3-j7200-common-proc-board.dts     | 42 +++++++++++++++++++
>  arch/arm64/boot/dts/ti/k3-j7200-main.dtsi     | 14 ++++++-
>  2 files changed, 54 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
> index b493f939b09a..de8c06bdc825 100644
> --- a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
> +++ b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
> @@ -16,6 +16,29 @@
>  		stdout-path = "serial2:115200n8";
>  		bootargs = "console=ttyS2,115200n8 earlycon=ns16550a,mmio32,0x02800000";
>  	};
> +
> +	vdd_mmc1: fixedregulator-sd {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vdd_mmc1";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-boot-on;
> +		enable-active-high;
> +		gpios = <&exp2 2 GPIO_ACTIVE_HIGH>;

is that gpio ?
I'd encourage to use vin-supply as well.

> +	};
> +
> +	vdd_sd_dv: gpio-regulator-vdd-sd-dv {
	What does this drive? TLV71033 ?
> +		compatible = "regulator-gpio";
> +		regulator-name = "vdd_sd_dv";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&vdd_sd_dv_pins_default>;
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-boot-on;

normally, I'd encourage to use vin-supply as well.

> +		gpios = <&main_gpio0 55 GPIO_ACTIVE_HIGH>;
> +		states = <1800000 0x0
> +			  3300000 0x1>;
states = <1800000 0x0>,
<3300000 0x1>;

Can you look at j721e as reference?

> +	};
>  };
>  

Kishon,
	can you look closer at this series?
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
