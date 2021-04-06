Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9E2354E54
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 10:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233409AbhDFILj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 04:11:39 -0400
Received: from mailgate.ics.forth.gr ([139.91.1.2]:15850 "EHLO
        mailgate.ics.forth.gr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232131AbhDFILg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 04:11:36 -0400
Received: from av3.ics.forth.gr (av3in.ics.forth.gr [139.91.1.77])
        by mailgate.ics.forth.gr (8.15.2/ICS-FORTH/V10-1.8-GATE) with ESMTP id 1368BRhl016265
        for <linux-kernel@vger.kernel.org>; Tue, 6 Apr 2021 11:11:27 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; d=ics.forth.gr; s=av; c=relaxed/simple;
        q=dns/txt; i=@ics.forth.gr; t=1617696682; x=1620288682;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=2r0QMkSyPkhE8Ev1lT1DRSw293cf5b3ZEKEW8v8rynY=;
        b=p0WyOp2TyUEvFHDEbdhJTxNDzwMbMhuPcUMVTbMIOWiMEQiQeeYhhQYoIxbLjA+3
        jOZ3D+Ao95NTsgx81NBzSKV+xOGwtyyv+mkGgfZT0bJQjgs7hReDBWIM1eyd/UFi
        c53AnzImYMCcJcGL/xn4PayOaujdK9MlQVKi9oasLO0RA+T+1p9MAYVl2uGE7N+F
        5gZshlSIweY5mJEYfDLGSnyl7Sf8agy264/09xgUgwL9bPnIXayHyGLzz75JwW2L
        F4kRqm61v55hQHKAALjcZuwkbjHS42ZGB3YhCfSaT/TQurpHvfanf+2r2MqKQoYX
        0lHISwWipULW5IThJfyGQA==;
X-AuditID: 8b5b014d-a4c337000000209f-d5-606c17aaeef5
Received: from enigma.ics.forth.gr (enigma.ics.forth.gr [139.91.151.35])
        by av3.ics.forth.gr (Symantec Messaging Gateway) with SMTP id 4F.01.08351.AA71C606; Tue,  6 Apr 2021 11:11:22 +0300 (EEST)
X-ICS-AUTH-INFO: Authenticated user:  at ics.forth.gr
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Tue, 06 Apr 2021 11:11:22 +0300
From:   Nick Kossifidis <mick@ics.forth.gr>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Nick Kossifidis <mick@ics.forth.gr>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 3/5] RISC-V: Improve init_resources
Organization: FORTH
In-Reply-To: <CAMuHMdWi+wo0+PCR6B1wyXVesG-kL9NQt8XFBuWhZ3SdVUaLZg@mail.gmail.com>
References: <20210405085712.1953848-1-mick@ics.forth.gr>
 <20210405085712.1953848-4-mick@ics.forth.gr>
 <CAMuHMdWi+wo0+PCR6B1wyXVesG-kL9NQt8XFBuWhZ3SdVUaLZg@mail.gmail.com>
Message-ID: <5a09d1f0ded4581c9e7458f546db9329@mailhost.ics.forth.gr>
X-Sender: mick@mailhost.ics.forth.gr
User-Agent: Roundcube Webmail/1.3.16
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMLMWRmVeSWpSXmKPExsXSHT1dWXeVeE6Cwaef6hbPbu1lsri8aw6b
        xbbPLWwWze/OsVu8vNzDbNE2i9+BzePNy5csHg83XWLyOHS4g9Fj85J6j0vN19k9Pm+SC2CL
        4rJJSc3JLEst0rdL4Mo4M3UPa8Ed8Yrzk56wNjCuEupi5OSQEDCR+L1oA1MXIxeHkMBRRonT
        ew6zQCRMJWbv7WQEsXkFBCVOznwCFmcWsJCYemU/I4QtL9G8dTYziM0ioCqx6e4EdhCbTUBT
        Yv6lg0D1HBwiAroSc36CzWcW6GSS+LF+E1ivsICVxISZ/5hAbH4BYYlPdy+ygticAoESP59O
        gTpoHaPE8YZv7BBHuEgc/9/EDnGcisSH3w/YQRaIAtmb5ypNYBScheTUWUhOnYXk1AWMzKsY
        BRLLjPUyk4v10vKLSjL00os2MYLDndF3B+PtzW/1DjEycTAeYpTgYFYS4d3Rm50gxJuSWFmV
        WpQfX1Sak1p8iFGag0VJnJdXb0K8kEB6YklqdmpqQWoRTJaJg1OqgclTT25pxiJzlYYddYYr
        v7bpHlGonxgcVhTIv+UuQ83Pr489nnvNuf65UuTxln5dkYOHn3jcs1K7v+rZ0c1e895OF/Ep
        e1RuGB9fPuvcTnfBaxb6rp8ndx48NvHfg3VuE/fXhW5uy+lfwv2/4p7Eo6boUwu3vPeoMNQo
        dk+P8+cvu9+q6HbmbqdplsHZ9sqNW27IPApb1hjxOPHiqudTXCT8y39IXshl1G3eYLStKNtM
        ajPf8o9Gs523eUz/Envi2rWtng3fHGY7T+u24jq/KbP/7uKL27o4Ni96PnGhgbCUS/CnP7yK
        Mi57WjJ1y85XfGbOC5m4V+nqFZnKjV78lmLlaY8ubTHf0Rb7K6JYa7cSS3FGoqEWc1FxIgB2
        H1ll5gIAAA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Geert,

Στις 2021-04-06 10:19, Geert Uytterhoeven έγραψε:
> Hi Nick,
> 
> Thanks for your patch!
> 
> On Mon, Apr 5, 2021 at 10:57 AM Nick Kossifidis <mick@ics.forth.gr> 
> wrote:
>> * Kernel region is always present and we know where it is, no
>> need to look for it inside the loop, just ignore it like the
>> rest of the reserved regions within system's memory.
>> 
>> * Don't call memblock_free inside the loop, if called it'll split
>> the region of pre-allocated resources in two parts, messing things
>> up, just re-use the previous pre-allocated resource and free any
>> unused resources after both loops finish.
>> 
>> * memblock_alloc may add a region when called, so increase the
>> number of pre-allocated regions by one to be on the safe side
>> (reported and patched by Geert Uytterhoeven)
>> 
>> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> 
> Where does this SoB come from?
> 
>> Signed-off-by: Nick Kossifidis <mick@ics.forth.gr>
> 
>> --- a/arch/riscv/kernel/setup.c
>> +++ b/arch/riscv/kernel/setup.c
> 
>> @@ -129,53 +139,42 @@ static void __init init_resources(void)
>>         struct resource *res = NULL;
>>         struct resource *mem_res = NULL;
>>         size_t mem_res_sz = 0;
>> -       int ret = 0, i = 0;
>> -
>> -       code_res.start = __pa_symbol(_text);
>> -       code_res.end = __pa_symbol(_etext) - 1;
>> -       code_res.flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
>> -
>> -       rodata_res.start = __pa_symbol(__start_rodata);
>> -       rodata_res.end = __pa_symbol(__end_rodata) - 1;
>> -       rodata_res.flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
>> -
>> -       data_res.start = __pa_symbol(_data);
>> -       data_res.end = __pa_symbol(_edata) - 1;
>> -       data_res.flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
>> +       int num_resources = 0, res_idx = 0;
>> +       int ret = 0;
>> 
>> -       bss_res.start = __pa_symbol(__bss_start);
>> -       bss_res.end = __pa_symbol(__bss_stop) - 1;
>> -       bss_res.flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
>> +       /* + 1 as memblock_alloc() might increase 
>> memblock.reserved.cnt */
>> +       num_resources = memblock.memory.cnt + memblock.reserved.cnt + 
>> 1;
>> +       res_idx = num_resources - 1;
>> 
>> -       mem_res_sz = (memblock.memory.cnt + memblock.reserved.cnt) * 
>> sizeof(*mem_res);
> 
> Oh, you incorporated my commit ce989f1472ae350e ("RISC-V: Fix 
> out-of-bounds
> accesses in init_resources()") (from v5.12-rc4) into your patch.
> Why? This means your patch does not apply against upstream.
> 

Sorry if this looks awkward, I'm under the impression that new features 
go on for-next instead of fixes and your patch hasn't been merged on 
for-next yet. I thought it would be cleaner to have one patch to merge 
for init_resources instead of two, and simpler for people to test the 
series. I can rebase this on top of fixes if that works better for you 
or Palmer.

Regards,
Nick
