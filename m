Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A58AD3DBB7B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 17:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239287AbhG3PAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 11:00:43 -0400
Received: from foss.arm.com ([217.140.110.172]:43280 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239519AbhG3O7L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 10:59:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A1A441063;
        Fri, 30 Jul 2021 07:59:06 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.13.245])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 464EF3F66F;
        Fri, 30 Jul 2021 07:59:04 -0700 (PDT)
Date:   Fri, 30 Jul 2021 15:59:01 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Bert Vermeulen <bert@biot.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        John Crispin <john@phrozen.org>, Felix Fietkau <nbd@nbd.name>
Subject: Re: [PATCH 3/5] ARM: dts: Add basic support for EcoNet EN7523
Message-ID: <20210730145901.GC19569@C02TD0UTHF1T.local>
References: <20210730134552.853350-1-bert@biot.com>
 <20210730134552.853350-4-bert@biot.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210730134552.853350-4-bert@biot.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 30, 2021 at 03:45:50PM +0200, Bert Vermeulen wrote:
> From: John Crispin <john@phrozen.org>
> 
> Add basic support for EcoNet EN7523, enough for booting to console.
> 
> The UART is basically 8250-compatible, except for the clock selection.
> A clock-frequency value is synthesized to get this to run at 115200 bps.
> 
> Signed-off-by: John Crispin <john@phrozen.org>
> Signed-off-by: Bert Vermeulen <bert@biot.com>
> ---
>  arch/arm/boot/dts/Makefile       |   2 +
>  arch/arm/boot/dts/en7523-evb.dts |  17 ++++
>  arch/arm/boot/dts/en7523.dtsi    | 128 +++++++++++++++++++++++++++++++
>  3 files changed, 147 insertions(+)
>  create mode 100644 arch/arm/boot/dts/en7523-evb.dts
>  create mode 100644 arch/arm/boot/dts/en7523.dtsi
> 

> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;

> +		cpu0: cpu@0 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a7";
> +			reg = <0x0>;
> +			enable-method = "psci";
> +			clock-frequency = <80000000>;
> +			next-level-cache = <&L2_0>;
> +
> +		};

> +	gic: interrupt-controller@09000000 {
> +		compatible = "arm,gic-v3";
> +		interrupt-controller;
> +		#interrupt-cells = <3>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		reg = <0x09000000 0x20000>,
> +			  <0x09080000 0x80000>;
> +		interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_LOW>;
> +
> +		its: gic-its@09020000 {
> +			compatible = "arm,gic-v3-its";
> +			msi-controller;
> +			#msi-cell = <1>;

Missing 's' here for '#msi-cells'.

> +			reg = <0x090200000 0x20000>;
> +		};
> +	};

Looking at this again, I was under the impression that Cortex-A7 only
supported GICv2; is this actually a Cortex-A7 or a different CPU?

Which revision is this?

Thanks,
Mark.
