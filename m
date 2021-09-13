Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3197F409C84
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 20:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240853AbhIMSuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 14:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233322AbhIMSuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 14:50:17 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A3D7C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 11:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=L7mB/EjCwCDnhaJaXb65CjmSnvHmmBmJCpIcPA/aoNo=; b=todp+Gry3S2Qgwhmfzji6NJqYP
        XCJed/FrciTtwZe4TqQ25r9bOYeb0PVqGcC4V0/1yLUV6eihtdYkXOJAzg33s3jfoKGUPM4qWFSMy
        +27XlcKmZtnhbYFwZQ/RT2RArY+fY3JPO+C/C8/NH9IePPn0QLI1/N/PUtzX7TcQRW3lN5IYTQ45+
        d9hYKlu1rhHWpfz2rjtUjdUiWUpDZWbysyt9ojFmxgSm640u1Nbl07Nn0r1ftWLDduiFfvamPTW1D
        fN4aXtv8BTudwJr/7U3XxPAFhCBmyXN8t7FxhzGCiQjLpxN+hc1KibOWuQ0lanfjE00aJ4GkYwKv0
        dXwZ7y3w==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mPr0b-0031L4-Rm; Mon, 13 Sep 2021 18:48:49 +0000
Subject: Re: [RFC PATCH V4 6/6] riscv: soc: Add Allwinner SoC kconfig option
To:     Guo Ren <guoren@kernel.org>, Maxime Ripard <maxime@cerno.tech>
Cc:     Anup Patel <anup.patel@wdc.com>, Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        =?UTF-8?Q?Christoph_M=c3=bcllner?= <christoph.muellner@vrull.eu>,
        philipp.tomsich@vrull.eu, Christoph Hellwig <hch@lst.de>,
        liush <liush@allwinnertech.com>, wefu@redhat.com,
        =?UTF-8?B?V2VpIFd1ICjlkLTkvJ8p?= <lazyparser@gmail.com>,
        Drew Fustini <drew@beagleboard.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        taiten.peng@canonical.com, aniket.ponkshe@canonical.com,
        heinrich.schuchardt@canonical.com, gordan.markus@canonical.com,
        Guo Ren <guoren@linux.alibaba.com>,
        Chen-Yu Tsai <wens@csie.org>
References: <20210911092139.79607-1-guoren@kernel.org>
 <20210911092139.79607-7-guoren@kernel.org>
 <20210913084520.kkbsupogkzv226x3@gilmour>
 <CAJF2gTT_8VLTt0B=LxXAPWVpHaBaVxy+V0rGCjr7JZyRiO7LfQ@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <d2ac3da8-f4d5-52c1-da7f-f8260a0bb604@infradead.org>
Date:   Mon, 13 Sep 2021 11:48:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAJF2gTT_8VLTt0B=LxXAPWVpHaBaVxy+V0rGCjr7JZyRiO7LfQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/13/21 2:20 AM, Guo Ren wrote:
> On Mon, Sep 13, 2021 at 4:45 PM Maxime Ripard <maxime@cerno.tech> wrote:
>>
>> Hi,
>>
>> On Sat, Sep 11, 2021 at 05:21:39PM +0800, guoren@kernel.org wrote:
>>> From: Liu Shaohua <liush@allwinnertech.com>
>>>
>>> Add Allwinner kconfig option which selects SoC specific and common
>>> drivers that is required for this SoC.
>>>
>>> Allwinner D1 uses custom PTE attributes to solve non-coherency SOC
>>> interconnect issues for dma synchronization, so we set the default
>>> value when SOC_SUNXI selected.
>>>
>>> Signed-off-by: Liu Shaohua <liush@allwinnertech.com>
>>> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
>>> Signed-off-by: Wei Fu <wefu@redhat.com>
>>> Cc: Anup Patel <anup.patel@wdc.com>
>>> Cc: Atish Patra <atish.patra@wdc.com>
>>> Cc: Christoph Hellwig <hch@lst.de>
>>> Cc: Chen-Yu Tsai <wens@csie.org>
>>> Cc: Drew Fustini <drew@beagleboard.org>
>>> Cc: Maxime Ripard <maxime@cerno.tech>
>>> Cc: Palmer Dabbelt <palmerdabbelt@google.com>
>>> Cc: Wei Wu <lazyparser@gmail.com>
>>> ---
>>>   arch/riscv/Kconfig.socs      | 15 +++++++++++++++
>>>   arch/riscv/configs/defconfig |  1 +
>>>   2 files changed, 16 insertions(+)
>>>
>>> diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
>>> index 30676ebb16eb..8721c000ef23 100644
>>> --- a/arch/riscv/Kconfig.socs
>>> +++ b/arch/riscv/Kconfig.socs
>>> @@ -70,4 +70,19 @@ config SOC_CANAAN_K210_DTB_SOURCE
>>>
>>>   endif
>>>
>>> +config SOC_SUNXI
>>> +     bool "Allwinner SoCs"
>>> +     depends on MMU
>>> +     select DWMAC_GENERIC
>>> +     select ERRATA_THEAD
>>> +     select RISCV_DMA_NONCOHERENT
>>> +     select RISCV_ERRATA_ALTERNATIVE
>>> +     select SERIAL_8250
>>> +     select SERIAL_8250_CONSOLE
>>> +     select SERIAL_8250_DW
>>> +     select SIFIVE_PLIC
>>> +     select STMMAC_ETH
>>> +     help
>>> +       This enables support for Allwinner SoC platforms like the D1.
>>> +
>>
>> I'm not sure we should select the drivers there. We could very well
>> imagine a board without UART, or even more so without ethernet.
> We just want people could bring D1 up easier, 8250 is the basic component.
> 
> 
>>
>> These options should be in the defconfig.

Agreed, using a defconfig is the right way to do this.

-- 
~Randy

