Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA32410573
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 11:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244370AbhIRJ1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 05:27:23 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:16278 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243891AbhIRJ0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 05:26:50 -0400
Received: from dggeme755-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4HBQQ42Wpqz8t8l;
        Sat, 18 Sep 2021 17:24:44 +0800 (CST)
Received: from [10.40.166.221] (10.40.166.221) by
 dggeme755-chm.china.huawei.com (10.3.19.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Sat, 18 Sep 2021 17:25:24 +0800
Message-ID: <6145B084.6020803@hisilicon.com>
Date:   Sat, 18 Sep 2021 17:25:24 +0800
From:   Wei Xu <xuwei5@hisilicon.com>
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
MIME-Version: 1.0
To:     Michael Walle <michael@walle.cc>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] arm64: dts: hisilicon: fix arm,sp805 compatible string
References: <20210830165113.222867-1-michael@walle.cc>
In-Reply-To: <20210830165113.222867-1-michael@walle.cc>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.166.221]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggeme755-chm.china.huawei.com (10.3.19.101)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

On 2021/8/31 0:51, Michael Walle wrote:
> According to Documentation/devicetree/bindings/watchdog/arm,sp805.yaml
> the compatible is:
>   compatible = "arm,sp805", "arm,primecell";
> 
> The current compatible string doesn't exist at all. Fix it.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>

Applied to the HiSilicon arm64 dt tree.
Thanks!

Best Regards,
Wei

> ---
> There are also the layerscape SoC which are using these compatible
> strings. I'm on it to change these, too.
> 
>  arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 4 ++--
>  arch/arm64/boot/dts/hisilicon/hi6220.dtsi | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> index 2d5c1a348716..6eabec2602e2 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> @@ -1087,7 +1087,7 @@ dwmmc2: dwmmc2@ff3ff000 {
>  		};
>  
>  		watchdog0: watchdog@e8a06000 {
> -			compatible = "arm,sp805-wdt", "arm,primecell";
> +			compatible = "arm,sp805", "arm,primecell";
>  			reg = <0x0 0xe8a06000 0x0 0x1000>;
>  			interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
>  			clocks = <&crg_ctrl HI3660_OSC32K>,
> @@ -1096,7 +1096,7 @@ watchdog0: watchdog@e8a06000 {
>  		};
>  
>  		watchdog1: watchdog@e8a07000 {
> -			compatible = "arm,sp805-wdt", "arm,primecell";
> +			compatible = "arm,sp805", "arm,primecell";
>  			reg = <0x0 0xe8a07000 0x0 0x1000>;
>  			interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
>  			clocks = <&crg_ctrl HI3660_OSC32K>,
> diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> index dde9371dc545..e4860b8a638e 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> @@ -840,7 +840,7 @@ dwmmc_2: dwmmc2@f723f000 {
>  		};
>  
>  		watchdog0: watchdog@f8005000 {
> -			compatible = "arm,sp805-wdt", "arm,primecell";
> +			compatible = "arm,sp805", "arm,primecell";
>  			reg = <0x0 0xf8005000 0x0 0x1000>;
>  			interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
>  			clocks = <&ao_ctrl HI6220_WDT0_PCLK>,
> 
