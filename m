Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4371C343B19
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 08:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbhCVH7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 03:59:01 -0400
Received: from gecko.sbs.de ([194.138.37.40]:60831 "EHLO gecko.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229870AbhCVH6q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 03:58:46 -0400
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 12M7wYCD021043
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Mar 2021 08:58:35 +0100
Received: from [167.87.37.70] ([167.87.37.70])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 12M7wY2u002040;
        Mon, 22 Mar 2021 08:58:34 +0100
Subject: Re: [PATCH] of/fdt: Make sure no-map does not remove already reserved
 regions
To:     Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andre Przywara <andre.przywara@arm.com>
Cc:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ian Campbell <ian.campbell@citrix.com>,
        Grant Likely <grant.likely@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>
References: <20190703050827.173284-1-drinkcat@chromium.org>
From:   Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <12b02977-d038-8fc7-d61e-e694a6b90f7b@siemens.com>
Date:   Mon, 22 Mar 2021 08:58:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20190703050827.173284-1-drinkcat@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.07.19 07:08, Nicolas Boichat wrote:
> If the device tree is incorrectly configured, and attempts to
> define a "no-map" reserved memory that overlaps with the kernel
> data/code, the kernel would crash quickly after boot, with no
> obvious clue about the nature of the issue.
> 
> For example, this would happen if we have the kernel mapped at
> these addresses (from /proc/iomem):
> 40000000-41ffffff : System RAM
>   40080000-40dfffff : Kernel code
>   40e00000-411fffff : reserved
>   41200000-413e0fff : Kernel data
> 
> And we declare a no-map shared-dma-pool region at a fixed address
> within that range:
> mem_reserved: mem_region {
> 	compatible = "shared-dma-pool";
> 	reg = <0 0x40000000 0 0x01A00000>;
> 	no-map;
> };
> 
> To fix this, when removing memory regions at early boot (which is
> what "no-map" regions do), we need to make sure that the memory
> is not already reserved. If we do, __reserved_mem_reserve_reg
> will throw an error:
> [    0.000000] OF: fdt: Reserved memory: failed to reserve memory
>    for node 'mem_region': base 0x0000000040000000, size 26 MiB
> and the code that will try to use the region should also fail,
> later on.
> 
> We do not do anything for non-"no-map" regions, as memblock
> explicitly allows reserved regions to overlap, and the commit
> that this fixes removed the check for that precise reason.
> 
> Fixes: 094cb98179f19b7 ("of/fdt: memblock_reserve /memreserve/ regions in the case of partial overlap")
> Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> ---
>  drivers/of/fdt.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index cd17dc62a71980a..a1ded43fc332d0c 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -1138,8 +1138,16 @@ int __init __weak early_init_dt_mark_hotplug_memory_arch(u64 base, u64 size)
>  int __init __weak early_init_dt_reserve_memory_arch(phys_addr_t base,
>  					phys_addr_t size, bool nomap)
>  {
> -	if (nomap)
> +	if (nomap) {
> +		/*
> +		 * If the memory is already reserved (by another region), we
> +		 * should not allow it to be removed altogether.
> +		 */
> +		if (memblock_is_region_reserved(base, size))
> +			return -EBUSY;
> +
>  		return memblock_remove(base, size);
> +	}
>  	return memblock_reserve(base, size);
>  }
>  
> 

Likely the wrong patch to blame but hopefully the right audience:

I'm trying to migrate my RPi4 setup to mainline, and this commit breaks 
booting with TF-A (current master) in the loop. Error:

[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd083]                                                                                                                                                                        
[    0.000000] Linux version 5.10.24+ (jan@md1f2u6c) (aarch64-linux-gnu-gcc (GNU Toolchain for the A-profile Architecture 9.2-2019.12 (arm-9.10)) 9.2.1 20191025, GNU ld (GNU Toolchain for the A-profile Architecture 9.2-2019.12 (arm-9.10)1
[    0.000000] Machine model: Raspberry Pi 4 Model B Rev 1.1                                                                                                                                                                                  
[    0.000000] efi: UEFI not found.                                                                                                                                                                                                           
[    0.000000] OF: fdt: Reserved memory: failed to reserve memory for node 'atf@0': base 0x0000000000000000, size 0 MiB                                                                                                                       

And then we hang later on when Linux does start to use that memory and 
seems to trigger an exception.

Is there a bug in the upstream RPi4 DT?

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux
