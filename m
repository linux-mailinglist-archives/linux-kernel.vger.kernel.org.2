Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 351C23332A4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 02:07:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbhCJBGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 20:06:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:56970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231294AbhCJBGR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 20:06:17 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 013D6650ED;
        Wed, 10 Mar 2021 01:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615338377;
        bh=doMwAKvc65hJgV0hGY24kZEfV+65wCntr/zwMUzueIQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=dyaO8KTX+anVrEkoN9VagAZvK0lUdHW2mPB7jY9f2ztrLks9+/bwMpYCWe+yFFLKW
         WIu2nMpurS05zyuK822hE+itjjcyrhku61u5SiNFZvEYVw0xalJ4Iwu2MmskIos8eu
         wfVju7ZrrYFHA+uacTYRkVPMXNq04h/2+Zpjxf6YiF+Aea7AyhpSACIBEtl8TN3kNV
         scKlOQOWNilZF6fEg35zQ/Cf4CVb/fGZCYzUgnAQSUmzorrppqEWE0HGaWtMH5W5dB
         nSKU+oU/qhyqNd+1leQrs8S6QlirF3RGzqmg+X47QCHzHE5KIeh87xWhFqn0tvLXrj
         hPy40hePw1QAg==
Subject: Re: [PATCH 1/3] arm64: dts: ls1046a: mark crypto engine dma coherent
To:     =?UTF-8?Q?Horia_Geant=c4=83?= <horia.geanta@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210307204737.12063-1-horia.geanta@nxp.com>
 <20210307204737.12063-2-horia.geanta@nxp.com>
From:   Greg Ungerer <gerg@kernel.org>
Message-ID: <fb608f39-a6ce-3ab5-328e-29a80d2d6b8a@kernel.org>
Date:   Wed, 10 Mar 2021 11:06:12 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210307204737.12063-2-horia.geanta@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/3/21 6:47 am, Horia Geantă wrote:
> Crypto engine (CAAM) on LS1046A platform is configured HW-coherent,
> mark accordingly the DT node.
> 
> As reported by Greg and Sascha, and explained by Robin, lack of
> "dma-coherent" property for an IP that is configured HW-coherent
> can lead to problems, e.g. on v5.11:
> 
>> kernel BUG at drivers/crypto/caam/jr.c:247!
>> Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
>> Modules linked in:
>> CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.11.0-20210225-3-00039-g434215968816-dirty #12
>> Hardware name: TQ TQMLS1046A SoM on Arkona AT1130 (C300) board (DT)
>> pstate: 60000005 (nZCv daif -PAN -UAO -TCO BTYPE=--)
>> pc : caam_jr_dequeue+0x98/0x57c
>> lr : caam_jr_dequeue+0x98/0x57c
>> sp : ffff800010003d50
>> x29: ffff800010003d50 x28: ffff8000118d4000
>> x27: ffff8000118d4328 x26: 00000000000001f0
>> x25: ffff0008022be480 x24: ffff0008022c6410
>> x23: 00000000000001f1 x22: ffff8000118d4329
>> x21: 0000000000004d80 x20: 00000000000001f1
>> x19: 0000000000000001 x18: 0000000000000020
>> x17: 0000000000000000 x16: 0000000000000015
>> x15: ffff800011690230 x14: 2e2e2e2e2e2e2e2e
>> x13: 2e2e2e2e2e2e2020 x12: 3030303030303030
>> x11: ffff800011700a38 x10: 00000000fffff000
>> x9 : ffff8000100ada30 x8 : ffff8000116a8a38
>> x7 : 0000000000000001 x6 : 0000000000000000
>> x5 : 0000000000000000 x4 : 0000000000000000
>> x3 : 00000000ffffffff x2 : 0000000000000000
>> x1 : 0000000000000000 x0 : 0000000000001800
>> Call trace:
>>   caam_jr_dequeue+0x98/0x57c
>>   tasklet_action_common.constprop.0+0x164/0x18c
>>   tasklet_action+0x44/0x54
>>   __do_softirq+0x160/0x454
>>   __irq_exit_rcu+0x164/0x16c
>>   irq_exit+0x1c/0x30
>>   __handle_domain_irq+0xc0/0x13c
>>   gic_handle_irq+0x5c/0xf0
>>   el1_irq+0xb4/0x180
>>   arch_cpu_idle+0x18/0x30
>>   default_idle_call+0x3c/0x1c0
>>   do_idle+0x23c/0x274
>>   cpu_startup_entry+0x34/0x70
>>   rest_init+0xdc/0xec
>>   arch_call_rest_init+0x1c/0x28
>>   start_kernel+0x4ac/0x4e4
>> Code: 91392021 912c2000 d377d8c6 97f24d96 (d4210000)
> 
> Cc: <stable@vger.kernel.org> # v4.10+
> Fixes: 8126d88162a5 ("arm64: dts: add QorIQ LS1046A SoC support")
> Link: https://lore.kernel.org/linux-crypto/fe6faa24-d8f7-d18f-adfa-44fa0caa1598@arm.com
> Reported-by: Greg Ungerer <gerg@kernel.org>
> Reported-by: Sascha Hauer <s.hauer@pengutronix.de>
> Tested-by: Sascha Hauer <s.hauer@pengutronix.de>
> Signed-off-by: Horia Geantă <horia.geanta@nxp.com>

Acked-by: Greg Ungerer <gerg@kernel.org>


> ---
>   arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> index f581a6d1f881..37fec474673a 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> @@ -354,6 +354,7 @@
>   			ranges = <0x0 0x00 0x1700000 0x100000>;
>   			reg = <0x00 0x1700000 0x0 0x100000>;
>   			interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
> +			dma-coherent;
>   
>   			sec_jr0: jr@10000 {
>   				compatible = "fsl,sec-v5.4-job-ring",
> 
