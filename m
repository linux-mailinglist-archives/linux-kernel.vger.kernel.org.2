Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEEF73F89D4
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 16:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242787AbhHZOKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 10:10:40 -0400
Received: from foss.arm.com ([217.140.110.172]:47624 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229451AbhHZOKj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 10:10:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 56FBA31B;
        Thu, 26 Aug 2021 07:09:52 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 36B033F66F;
        Thu, 26 Aug 2021 07:09:52 -0700 (PDT)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
        id DDBDB682B70; Thu, 26 Aug 2021 15:09:50 +0100 (BST)
Date:   Thu, 26 Aug 2021 15:09:50 +0100
From:   Liviu Dudau <liviu.dudau@arm.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] arm64: dts: arm: align watchdog and mmc node names
 with dtschema
Message-ID: <YSegrnil/5rn/EVH@e110455-lin.cambridge.arm.com>
References: <20210820081733.83976-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210820081733.83976-1-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 20, 2021 at 10:17:31AM +0200, Krzysztof Kozlowski wrote:
> Align the watchdog and mmc device node names with the schema to fix
> warnings like:
> 
>   mmci@50000: $nodename:0: 'mmci@50000' does not match '^mmc(@.*)?$'
>   wdt@f0000: $nodename:0: 'wdt@f0000' does not match '^watchdog(@.*|-[0-9a-f])?$'
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

For the whole series: Acked-by: Liviu Dudau <liviu.dudau@arm.com>

Many thanks,
Liviu

> ---
>  arch/arm64/boot/dts/arm/juno-motherboard.dtsi    | 4 ++--
>  arch/arm64/boot/dts/arm/rtsm_ve-motherboard.dtsi | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/arm/juno-motherboard.dtsi b/arch/arm64/boot/dts/arm/juno-motherboard.dtsi
> index 40d95c58b55e..f45c912b2806 100644
> --- a/arch/arm64/boot/dts/arm/juno-motherboard.dtsi
> +++ b/arch/arm64/boot/dts/arm/juno-motherboard.dtsi
> @@ -218,7 +218,7 @@ led7 {
>  					};
>  				};
>  
> -				mmci@50000 {
> +				mmc@50000 {
>  					compatible = "arm,pl180", "arm,primecell";
>  					reg = <0x050000 0x1000>;
>  					interrupts = <5>;
> @@ -246,7 +246,7 @@ kmi@70000 {
>  					clock-names = "KMIREFCLK", "apb_pclk";
>  				};
>  
> -				wdt@f0000 {
> +				watchdog@f0000 {
>  					compatible = "arm,sp805", "arm,primecell";
>  					reg = <0x0f0000 0x10000>;
>  					interrupts = <7>;
> diff --git a/arch/arm64/boot/dts/arm/rtsm_ve-motherboard.dtsi b/arch/arm64/boot/dts/arm/rtsm_ve-motherboard.dtsi
> index 4c4a381d2c75..7260bcf4b2ab 100644
> --- a/arch/arm64/boot/dts/arm/rtsm_ve-motherboard.dtsi
> +++ b/arch/arm64/boot/dts/arm/rtsm_ve-motherboard.dtsi
> @@ -130,7 +130,7 @@ aaci@40000 {
>  					clock-names = "apb_pclk";
>  				};
>  
> -				mmci@50000 {
> +				mmc@50000 {
>  					compatible = "arm,pl180", "arm,primecell";
>  					reg = <0x050000 0x1000>;
>  					interrupts = <9>, <10>;
> @@ -190,7 +190,7 @@ v2m_serial3: serial@c0000 {
>  					clock-names = "uartclk", "apb_pclk";
>  				};
>  
> -				wdt@f0000 {
> +				watchdog@f0000 {
>  					compatible = "arm,sp805", "arm,primecell";
>  					reg = <0x0f0000 0x1000>;
>  					interrupts = <0>;
> -- 
> 2.30.2
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
