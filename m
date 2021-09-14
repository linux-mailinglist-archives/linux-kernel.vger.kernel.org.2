Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3842B40AB0F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 11:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbhINJnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 05:43:55 -0400
Received: from imap2.colo.codethink.co.uk ([78.40.148.184]:60726 "EHLO
        imap2.colo.codethink.co.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229560AbhINJnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 05:43:53 -0400
X-Greylist: delayed 945 seconds by postgrey-1.27 at vger.kernel.org; Tue, 14 Sep 2021 05:43:53 EDT
Received: from cpc152649-stkp13-2-0-cust121.10-2.cable.virginm.net ([86.15.83.122] helo=[192.168.0.21])
        by imap2.colo.codethink.co.uk with esmtpsa  (Exim 4.92 #3 (Debian))
        id 1mQ4hw-0003UJ-HY; Tue, 14 Sep 2021 10:26:28 +0100
Subject: Re: [RFC PATCH V4 6/6] riscv: soc: Add Allwinner SoC kconfig option
To:     Maxime Ripard <maxime@cerno.tech>, guoren@kernel.org
Cc:     anup.patel@wdc.com, atish.patra@wdc.com, palmerdabbelt@google.com,
        christoph.muellner@vrull.eu, philipp.tomsich@vrull.eu, hch@lst.de,
        liush@allwinnertech.com, wefu@redhat.com, lazyparser@gmail.com,
        drew@beagleboard.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, taiten.peng@canonical.com,
        aniket.ponkshe@canonical.com, heinrich.schuchardt@canonical.com,
        gordan.markus@canonical.com, Guo Ren <guoren@linux.alibaba.com>,
        Chen-Yu Tsai <wens@csie.org>
References: <20210911092139.79607-1-guoren@kernel.org>
 <20210911092139.79607-7-guoren@kernel.org>
 <20210913084520.kkbsupogkzv226x3@gilmour>
From:   Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
Message-ID: <7d9e1f45-f349-fd07-75ac-c2902882c14a@codethink.co.uk>
Date:   Tue, 14 Sep 2021 10:26:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210913084520.kkbsupogkzv226x3@gilmour>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/09/2021 09:45, Maxime Ripard wrote:
> Hi,
> 
> On Sat, Sep 11, 2021 at 05:21:39PM +0800, guoren@kernel.org wrote:
>> From: Liu Shaohua <liush@allwinnertech.com>
>>
>> Add Allwinner kconfig option which selects SoC specific and common
>> drivers that is required for this SoC.
>>
>> Allwinner D1 uses custom PTE attributes to solve non-coherency SOC
>> interconnect issues for dma synchronization, so we set the default
>> value when SOC_SUNXI selected.
>>
>> Signed-off-by: Liu Shaohua <liush@allwinnertech.com>
>> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
>> Signed-off-by: Wei Fu <wefu@redhat.com>
>> Cc: Anup Patel <anup.patel@wdc.com>
>> Cc: Atish Patra <atish.patra@wdc.com>
>> Cc: Christoph Hellwig <hch@lst.de>
>> Cc: Chen-Yu Tsai <wens@csie.org>
>> Cc: Drew Fustini <drew@beagleboard.org>
>> Cc: Maxime Ripard <maxime@cerno.tech>
>> Cc: Palmer Dabbelt <palmerdabbelt@google.com>
>> Cc: Wei Wu <lazyparser@gmail.com>
>> ---
>>   arch/riscv/Kconfig.socs      | 15 +++++++++++++++
>>   arch/riscv/configs/defconfig |  1 +
>>   2 files changed, 16 insertions(+)
>>
>> diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
>> index 30676ebb16eb..8721c000ef23 100644
>> --- a/arch/riscv/Kconfig.socs
>> +++ b/arch/riscv/Kconfig.socs
>> @@ -70,4 +70,19 @@ config SOC_CANAAN_K210_DTB_SOURCE
>>   
>>   endif
>>   
>> +config SOC_SUNXI
>> +	bool "Allwinner SoCs"
>> +	depends on MMU
>> +	select DWMAC_GENERIC
>> +	select ERRATA_THEAD
>> +	select RISCV_DMA_NONCOHERENT
>> +	select RISCV_ERRATA_ALTERNATIVE
>> +	select SERIAL_8250
>> +	select SERIAL_8250_CONSOLE
>> +	select SERIAL_8250_DW
>> +	select SIFIVE_PLIC
>> +	select STMMAC_ETH
>> +	help
>> +	  This enables support for Allwinner SoC platforms like the D1.
>> +
> 
> I'm not sure we should select the drivers there. We could very well
> imagine a board without UART, or even more so without ethernet.

I could make a case for selecting the serial as it is probably the
console, however the ethernet is not necessary for operation and I
would prefer to see this removed.

I wonder if we should have a new Kconfig keyword of suggest which
marks drivers as suggested for a given SoC/board/platform.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html
