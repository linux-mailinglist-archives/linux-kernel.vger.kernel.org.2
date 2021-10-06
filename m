Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 925A0423BBD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 12:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238183AbhJFKv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 06:51:26 -0400
Received: from foss.arm.com ([217.140.110.172]:51864 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238171AbhJFKvV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 06:51:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EF2D51FB;
        Wed,  6 Oct 2021 03:49:27 -0700 (PDT)
Received: from [10.57.22.120] (unknown [10.57.22.120])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D3DCB3F70D;
        Wed,  6 Oct 2021 03:49:26 -0700 (PDT)
Subject: Re: [PATCH] arm64: dts: rockchip: nanopi4: decrease Bluetooth UART
 baud rate
To:     Chen-Yu Tsai <wens@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210920175647.13008-1-wens@kernel.org>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <64f06ddb-cde6-d71a-7920-41c485a1d3fb@arm.com>
Date:   Wed, 6 Oct 2021 11:49:20 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210920175647.13008-1-wens@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-09-20 18:56, Chen-Yu Tsai wrote:
> From: Chen-Yu Tsai <wens@csie.org>
> 
> The RK3399 does not seem to be able to properly generate the required
> 64 MHz clock for the UART to operate at 4MBd.
> 
> Drop the baud rate down to 3MBd, which can be used as the clock
> controller is able to produce a 48 MHz clock.

Hmm, I've been running mine this way (with DMA) for ages now :/

Looking at clk_summary, clk_uart0_src ends up at 800MHz off CPLL (same 
as several other significant clocks), with clk_uart0 at an exact 64MHz 
as a division of that. I stuck a scope on the UART pins of the module 
and all the edges look nicely lined up to 250ns intervals.

This is with a 5.11.4 kernel, though - I wonder if the recent fractional 
divider changes in the clock driver have changed anything?

Robin.

> Fixes: 3e2f0bb72be3 ("arm64: dts: rockchip: Add nanopi4 bluetooth")
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>   arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
> index 8c0ff6c96e03..45ff053b119d 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
> @@ -699,7 +699,7 @@ bluetooth {
>   		device-wakeup-gpios = <&gpio2 RK_PD2 GPIO_ACTIVE_HIGH>;
>   		host-wakeup-gpios = <&gpio0 RK_PA4 GPIO_ACTIVE_HIGH>;
>   		shutdown-gpios = <&gpio0 RK_PB1 GPIO_ACTIVE_HIGH>;
> -		max-speed = <4000000>;
> +		max-speed = <3000000>;
>   		pinctrl-names = "default";
>   		pinctrl-0 = <&bt_reg_on_h &bt_host_wake_l &bt_wake_l>;
>   		vbat-supply = <&vcc3v3_sys>;
> 
