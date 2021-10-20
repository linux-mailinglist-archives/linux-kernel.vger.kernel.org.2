Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66C94434BA4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 14:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbhJTM7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 08:59:41 -0400
Received: from foss.arm.com ([217.140.110.172]:59910 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229702AbhJTM7i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 08:59:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5DD611FB;
        Wed, 20 Oct 2021 05:57:24 -0700 (PDT)
Received: from [10.57.27.231] (unknown [10.57.27.231])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5A4933F73D;
        Wed, 20 Oct 2021 05:57:23 -0700 (PDT)
Subject: Re: [PATCH] arm64: dts: rockchip: nanopi4: decrease Bluetooth UART
 baud rate
To:     wens@kernel.org, Heiko Stuebner <heiko@sntech.de>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20210920175647.13008-1-wens@kernel.org>
 <64f06ddb-cde6-d71a-7920-41c485a1d3fb@arm.com>
 <CAGb2v67dixQ7BH+YoBVWEJFup9FdgvrDaCZACEYidPuD4pB7YQ@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <f52c254b-b44b-67df-87bc-010e818fd8ef@arm.com>
Date:   Wed, 20 Oct 2021 13:57:18 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAGb2v67dixQ7BH+YoBVWEJFup9FdgvrDaCZACEYidPuD4pB7YQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-10-07 18:13, Chen-Yu Tsai wrote:
> On Wed, Oct 6, 2021 at 6:49 PM Robin Murphy <robin.murphy@arm.com> wrote:
>>
>> On 2021-09-20 18:56, Chen-Yu Tsai wrote:
>>> From: Chen-Yu Tsai <wens@csie.org>
>>>
>>> The RK3399 does not seem to be able to properly generate the required
>>> 64 MHz clock for the UART to operate at 4MBd.
>>>
>>> Drop the baud rate down to 3MBd, which can be used as the clock
>>> controller is able to produce a 48 MHz clock.
>>
>> Hmm, I've been running mine this way (with DMA) for ages now :/
> 
> I guess you have extra patches on top for DMA? I sent another patch
> to hook up DMA.

Indeed I've been using Katsuhiro's patch from ages ago:

https://lore.kernel.org/linux-rockchip/20190321162244.10080-1-katsuhiro@katsuster.net/

Heiko - as far as I'm aware pl330 still isn't hooked up to virt-dma; I 
think the core change to avoid using DMA for the console UART has merely 
mitigated the issue by leaving just enough channels available for "most" 
use-cases.

>> Looking at clk_summary, clk_uart0_src ends up at 800MHz off CPLL (same
>> as several other significant clocks), with clk_uart0 at an exact 64MHz
>> as a division of that. I stuck a scope on the UART pins of the module
>> and all the edges look nicely lined up to 250ns intervals.
> 
> Could you provide a partial dump of /sys/kernel/debug/clk/clk_summary ?
> Just the bits related to uart0 should be enough.
> 
> Mine is also running from CPLL, but ends up at 1843200 Hz, which seems
> like the clock rate used for 115200 baud:
> 
>   xin24m                              24       24        0    24000000
>          0     0  50000         Y
>      pll_cpll                          1        1        0   800000000
>          0     0  50000         Y
>         cpll                           7       15        0   800000000
>          0     0  50000         Y
>            clk_uart0_src               1        1        0   800000000
>          0     0  50000         Y
>               clk_uart0_div            1        1        0   800000000
>          0     0  50000         Y
>                  clk_uart0_frac        1        1        0     1843200
>          0     0  50000         Y
>                     clk_uart0          1        1        0     1843200
>          0     0  50000         Y
> 
> I also observe a couple error messages:
> 
> Bluetooth: hci0: BCM: failed to write clock (-56)
> Bluetooth: hci0: Failed to set baudrate
> Bluetooth: hci0: BCM: chip id 130
> Bluetooth: hci0: BCM: features 0x0f
> Bluetooth: hci0: BCM4345C5
> Bluetooth: hci0: BCM4345C5 (003.006.006) build 0000
> Bluetooth: hci0: BCM4345C5 'brcm/BCM4345C5.hcd' Patch
> Bluetooth: hci0: BCM: failed to write clock (-56)
> Bluetooth: hci0: BCM4345C5 Ampak_CL1.5 UART 37.4 MHz BT 5.0 [Version:
> Version: 0033.0080]
> Bluetooth: hci0: BCM4345C5 (003.006.006) build 0080
> 
> So I think my UART is actually still running at its initial speed.

FWIW, with a functioning 5.14 kernel back on my board (5.15-rc4 couldn't 
even boot due to eMMC issues), nothing stands out except the lack of 
errors. However, looking again at said errors and digging in to 
bcm_set_baudrate(), it looks like it's actually the module itself being 
unhappy about the special command to update *its* clock, which then 
prevents the host baud rate from being changed from its initial 115200. 
The internet leads me to believe that BCM4345C5 is BCM43455 which is now 
CYW43555 whose datasheet says "UART baud rates up to 4 Mbps", so 
whatever the issue is it looks to be beyond the limit of my knowledge.

Poking around hci_bcm to see if there's any notable difference between 
the modules, I spotted commit e601daed271e mentioning issues with 
AP6256, so I wonder if using the "brcm,bcm4345c5" compatible as an 
override in the M4B DTS makes any difference?

If not, now that things seem to make a bit more sense it might be 
reasonable to tweak the speed for M4B as a workaround to avoid sending 
the offending command (since AP6356S as used on the other variants seems 
unaffected), unless Bluetooth people can shed any more light on why the 
module is unhappy about it.

Cheers,
Robin.

> Another thing is that the Rockchip datasheet says something about the
> denominator has to be 20 times larger than the nominator for a stable clock.
> 
>> This is with a 5.11.4 kernel, though - I wonder if the recent fractional
>> divider changes in the clock driver have changed anything?
> 
> I tried reverting the three patches but that didn't make a difference.
> 
> Regards
> ChenYu
> 
> 
>>
>>> Fixes: 3e2f0bb72be3 ("arm64: dts: rockchip: Add nanopi4 bluetooth")
>>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>>> ---
>>>    arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
>>> index 8c0ff6c96e03..45ff053b119d 100644
>>> --- a/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
>>> +++ b/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
>>> @@ -699,7 +699,7 @@ bluetooth {
>>>                device-wakeup-gpios = <&gpio2 RK_PD2 GPIO_ACTIVE_HIGH>;
>>>                host-wakeup-gpios = <&gpio0 RK_PA4 GPIO_ACTIVE_HIGH>;
>>>                shutdown-gpios = <&gpio0 RK_PB1 GPIO_ACTIVE_HIGH>;
>>> -             max-speed = <4000000>;
>>> +             max-speed = <3000000>;
>>>                pinctrl-names = "default";
>>>                pinctrl-0 = <&bt_reg_on_h &bt_host_wake_l &bt_wake_l>;
>>>                vbat-supply = <&vcc3v3_sys>;
>>>
