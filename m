Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB14341C18
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 13:18:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbhCSMRd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 08:17:33 -0400
Received: from foss.arm.com ([217.140.110.172]:48070 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229847AbhCSMRK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 08:17:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 06F64ED1;
        Fri, 19 Mar 2021 05:17:10 -0700 (PDT)
Received: from [10.57.50.37] (unknown [10.57.50.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F02D83F70D;
        Fri, 19 Mar 2021 05:17:07 -0700 (PDT)
Subject: Re: [PATCH] dt: rockchip: rk3399: Add dynamic power coefficient for
 GPU
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, heiko@sntech.de
Cc:     Rob Herring <robh+dt@kernel.org>, Johan Jonker <jbx6244@gmail.com>,
        Helen Koike <helen.koike@collabora.com>,
        Shunqian Zheng <zhengsq@rock-chips.com>,
        Jacob Chen <jacob2.chen@rock-chips.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Markus Reichl <m.reichl@fivetechno.de>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Rockchip SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC support" 
        <linux-rockchip@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20210319110511.24787-1-daniel.lezcano@linaro.org>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <5db868e4-5b86-7b32-51e0-665a2e1fc1ac@arm.com>
Date:   Fri, 19 Mar 2021 12:17:01 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210319110511.24787-1-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-03-19 11:05, Daniel Lezcano wrote:
> The DTPM framework is looking for upstream SoC candidates to share the
> power numbers.
> 
> We can see around different numbers but the one which seems to be
> consistent with the initial post for the values on the CPUs can be
> found in the patch https://lore.kernel.org/patchwork/patch/810159/

The kernel hacker in me would be more inclined to trust the BSP that the 
vendor actively supports than a 5-year-old patch that was never pursued 
upstream. Apparently that was last updated more recently:

https://github.com/rockchip-linux/kernel/commit/98d4505e1bd62ff028bd79fbd8284d64b6f468f8

The ex-mathematician in me can't even comment either way without 
evidence that whatever model expects to consume this value is even 
comparable to whatever "arm,mali-simple-power-model" is. The way the 
latter apparently needs an explicit "static" coefficient as well as a 
"dynamic" one, and the value here being nearly 3 times that of a 
similarly-named one in active use downstream (ChromeOS appears to still 
be using the values from before the above commit), certainly incline me 
to think they may not be...

> I don't know the precision of this value but it is better than
> nothing.

But is it? If it leads to some throttling mechanism kicking in and 
crippling GPU performance because it's massively overestimating power 
consumption, that would be objectively worse for most users, no?

Robin.

> Hopefully, one day SoC vendors will be more generous with the power
> numbers at least for the SoC which are from the previous generation
> and give the community the opportunity to develop power based
> frameworks.
> ---
>   arch/arm64/boot/dts/rockchip/rk3399.dtsi | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> index edbbf35fe19e..1ab1d293d2e9 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> @@ -1933,6 +1933,7 @@
>   		interrupt-names = "job", "mmu", "gpu";
>   		clocks = <&cru ACLK_GPU>;
>   		#cooling-cells = <2>;
> +		dynamic-power-coefficient = <977>;
>   		power-domains = <&power RK3399_PD_GPU>;
>   		status = "disabled";
>   	};
> 
