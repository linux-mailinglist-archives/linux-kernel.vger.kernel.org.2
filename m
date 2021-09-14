Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1270340A4E4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 05:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239173AbhINDvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 23:51:20 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:55778
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236149AbhINDvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 23:51:18 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 41B034025D
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 03:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631591395;
        bh=HI7zQXcihg2fy5dwCYrDgeNZBtRGWofDhJtkvOD6HGQ=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=I7CqaaEWKD+u8Xx92tTRcf1W5088CiPYsB79UsJjNp5Ah8yYPxd0LvhyNFd8K7meX
         wUGuIcNWDaKOvbFHHGK+fhP2k84a44xC1Nf5AgDXOVCIyjYJ2mBOJlvTekVZuH1dCl
         8VSxjGRLsxwV83iwz61Zm9nOZKUGFTITVd0/XdAuZG177ztWMcWbMr8LcY8sE1Bjd6
         Tuxop2wJxRWgsaw0688ra/Q7qLQRe1r1WAYeDC0og57iqSRB0bW/nRVPAlkEoM3bp3
         MWk+uR1ERTe/BJErE0kEtijI6ST/ZZlPfzgC3MPDN/Yokh/IQVSAwgrxNn4+8vKnYJ
         BzYUQVgTYTBOQ==
Received: by mail-wr1-f71.google.com with SMTP id i4-20020a5d5224000000b0015b14db14deso3394800wra.23
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 20:49:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HI7zQXcihg2fy5dwCYrDgeNZBtRGWofDhJtkvOD6HGQ=;
        b=PR9tbrqRYGZ9RdCbo5F1iKkVpO6pOyMQeIhqbLI0jpU2s66j8DgATSY7e/Wh23xSzx
         USVFlj3XiiScIXdCKHuas6DmJTz8Wb+Mj67UGnimacQVIvCW7hiyNXdAickHg5g88389
         CX6BvUZXaODAXetB8OGscYi9cM/zeH78Ju+j6KzUIYsnXoOiJdu9+f/YyULy9agCIJ1l
         8pUpxhVK7FzsjBDotvZ/grNSYmF6mtj8TuG012nRP5G9lL8MM2Pd+hGgjtjWcVUI+wS9
         oBUTHWhQi317wU243655yq+y6qQ1m9zzZo3jS7t4D1+Myvzgc7U5ss/9dgENGxU43MEB
         Nhxw==
X-Gm-Message-State: AOAM530jnxsfaQInpPwu58Ai1Gkb9kZtJQ0h5tPIpUFsSlfKjKqasNuw
        vQERQgdk+I61Mss8Jrl6+st5l61MGmEtlAhl9VGzIR8OBlzzeivjMe1wYinoKZjeU++4Vo4nakV
        e1hUocQWKjnbrBHYe1f6mtgTeFJ+5CBaoe7SZPTX9FQ==
X-Received: by 2002:adf:8b03:: with SMTP id n3mr16188858wra.439.1631591394887;
        Mon, 13 Sep 2021 20:49:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwsO5Q5kY8Baak47Z/dM9JRQYNve65e5T72yYyoRiroYEO20cQg0HcDjZhu/ZwygPR7LKR/UQ==
X-Received: by 2002:adf:8b03:: with SMTP id n3mr16188840wra.439.1631591394671;
        Mon, 13 Sep 2021 20:49:54 -0700 (PDT)
Received: from [192.168.178.189] ([46.253.247.67])
        by smtp.gmail.com with ESMTPSA id q128sm10172520wma.27.2021.09.13.20.49.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Sep 2021 20:49:54 -0700 (PDT)
Subject: Re: [RFC PATCH V4 6/6] riscv: soc: Add Allwinner SoC kconfig option
To:     guoren@kernel.org, Liu Shaohua <liush@allwinnertech.com>,
        wefu@redhat.com
Cc:     anup.patel@wdc.com, atish.patra@wdc.com, palmerdabbelt@google.com,
        christoph.muellner@vrull.eu, philipp.tomsich@vrull.eu, hch@lst.de,
        liush@allwinnertech.com, lazyparser@gmail.com,
        drew@beagleboard.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, taiten.peng@canonical.com,
        aniket.ponkshe@canonical.com, gordan.markus@canonical.com,
        Guo Ren <guoren@linux.alibaba.com>,
        Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <maxime@cerno.tech>
References: <20210911092139.79607-1-guoren@kernel.org>
 <20210911092139.79607-7-guoren@kernel.org>
 <20210913084520.kkbsupogkzv226x3@gilmour>
From:   Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Message-ID: <e46bb02d-961d-672d-76c7-9844d76ee69b@canonical.com>
Date:   Tue, 14 Sep 2021 05:49:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210913084520.kkbsupogkzv226x3@gilmour>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/13/21 10:45 AM, Maxime Ripard wrote:
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

The draft of the RISC-V platform specification is available here:
https://github.com/riscv/riscv-platform-specs/blob/main/riscv-platform-spec.adoc#uartserial-console

The specification requires in section "2.1.5.1. UART/Serial Console" 
that on platforms with a rich operating system (e.g. Linux) you have a 
serial console. Hence requiring 8250 support for the D1 CPU is justified.

In the riscv defconfig as of v5.14 we have:

CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
# CONFIG_SERIAL_8250_DW is not set
(Support for Synopsys DesignWare 8250 quirks)

CONFIG_SERIAL_8250_DW should be enabled (=y) in the defconfig.

As the specification requires a 16550 UART and marks 8250 as deprecated 
I expect that future Allwinner SoCs will move to 16550. Calling a 
Kconfig menu item "Allwinner SoCs" which includes all future Allwinner 
SoCs irritates me. How about CONFIG_SOC_SUNXI_D1 instead?

Why does the patch use 'depends on MMU' and does not 'select MMU'?

Best regards

Heinrich

> 
> These options should be in the defconfig.
> 
> Maxime
> 
