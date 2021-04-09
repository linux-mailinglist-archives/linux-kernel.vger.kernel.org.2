Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA741359BC0
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 12:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233544AbhDIKQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 06:16:33 -0400
Received: from mailgate.ics.forth.gr ([139.91.1.2]:53964 "EHLO
        mailgate.ics.forth.gr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234104AbhDIKLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 06:11:47 -0400
Received: from av3.ics.forth.gr (av3in.ics.forth.gr [139.91.1.77])
        by mailgate.ics.forth.gr (8.15.2/ICS-FORTH/V10-1.8-GATE) with ESMTP id 139ABX3q022004
        for <linux-kernel@vger.kernel.org>; Fri, 9 Apr 2021 13:11:33 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; d=ics.forth.gr; s=av; c=relaxed/simple;
        q=dns/txt; i=@ics.forth.gr; t=1617963088; x=1620555088;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=QFV5gLACFlf4gevkP93SS+cgfDbAfoayGgtdPXRAXUE=;
        b=GzrHi45RpDzuDPwwWgvAMn9JV4upmtq6ntwEaN+FRE8uvHx93Qu6lIU7fMqGgIA9
        TmKBInCvcL0jMpsh3wRT3bmxNTp3/zqjSAdqCzFano6bssRQXdwV+Ad+ijkES0my
        bMDnPagm/ZvSK2LmaawDCdRQB+PtC8ZL/wbEHlk1froJchVShdMwJKAZFKwDd9Y+
        XmW3oVS8uZe+vKgRQm9CNmRzJrTENTTHjcAghnpCYQIAyJxDitH3RH1DUOPKmBeE
        oeFVg8QKcIQJHYHhiAxeiFitbHqpjp4+VWG1m0yknzMAZYGKoWZATJrdKmgL0oea
        S6Wt5CXgpDt3E0P7TC4F4Q==;
X-AuditID: 8b5b014d-a70347000000209f-39-6070284fe5d0
Received: from enigma.ics.forth.gr (enigma.ics.forth.gr [139.91.151.35])
        by av3.ics.forth.gr (Symantec Messaging Gateway) with SMTP id AA.10.08351.F4820706; Fri,  9 Apr 2021 13:11:28 +0300 (EEST)
X-ICS-AUTH-INFO: Authenticated user:  at ics.forth.gr
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Fri, 09 Apr 2021 13:11:27 +0300
From:   Nick Kossifidis <mick@ics.forth.gr>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Nick Kossifidis <mick@ics.forth.gr>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 3/5] RISC-V: Improve init_resources
Organization: FORTH
In-Reply-To: <CAMuHMdWnRFuzSzSMCgBtNwxtq+itQ+iuX+i7nu5RD1E1W1FW-g@mail.gmail.com>
References: <20210405085712.1953848-1-mick@ics.forth.gr>
 <20210405085712.1953848-4-mick@ics.forth.gr>
 <CAMuHMdWi+wo0+PCR6B1wyXVesG-kL9NQt8XFBuWhZ3SdVUaLZg@mail.gmail.com>
 <5a09d1f0ded4581c9e7458f546db9329@mailhost.ics.forth.gr>
 <CAMuHMdWnRFuzSzSMCgBtNwxtq+itQ+iuX+i7nu5RD1E1W1FW-g@mail.gmail.com>
Message-ID: <f17d8d4de8f11b9a914e1b413460a756@mailhost.ics.forth.gr>
X-Sender: mick@mailhost.ics.forth.gr
User-Agent: Roundcube Webmail/1.3.16
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMLMWRmVeSWpSXmKPExsXSHT1dWTdAoyDB4N8KFotnt/YyWVzeNYfN
        YtvnFjaL5nfn2C1eXu5htmibxe/A5vHm5UsWj4ebLjF5HDrcweixeUm9x6Xm6+wenzfJBbBF
        cdmkpOZklqUW6dslcGX8797HVnBQuuLagWXMDYxLRbsYOTkkBEwkDjfeZu9i5OIQEjjKKLFw
        XxsTRMJUYvbeTkYQm1dAUOLkzCcsIDazgIXE1Cv7GSFseYnmrbOZQWwWAVWJpjPzwGrYBDQl
        5l86CGRzcIgI6ErM+ckEMp9ZoJNJ4sf6TWC9wgJWEhNm/gPbxS8gLPHp7kVWEJtTIFDi1+vl
        zBAHbWCS+Lq7ix3iCBeJ2X2vmSGOU5H48PsBO8gCUSB781ylCYyCs5CcOgvJqbOQnLqAkXkV
        o0BimbFeZnKxXlp+UUmGXnrRJkZwuDP67mC8vfmt3iFGJg7GQ4wSHMxKIrzNzfkJQrwpiZVV
        qUX58UWlOanFhxilOViUxHl59SbECwmkJ5akZqemFqQWwWSZODilGpgsatO4Z/iysCnmZdfL
        rxI1OKO4escvqfyrhvMUjZjE/qccV48vCzh+oeXvi4XNLWaCO73PZ5qnrcw0mcAd6Mb0/s7C
        Hw89ZR71PVgTwrE1/L9j3N4zpg/nnjl0+Y7w/6pyi2lxbx2FL1yY9+T9J6bNPuxGZfFmu8wn
        B6zaxM714mSkgsSKHdG5KTsvX9pX+f6Xi3vSqtsTNi6oXt7xIGifzYXJzLPCzHz2h9Qc13Kx
        C/kZrxG5ZB7T5Dm/xXLe5l24Jvroz+PfRg9eiEcE5HjsKA96zHO2Te7ypxknGX8IJs6blGPY
        VbK68nTZ1jupwoXHfva+dVLbcvU1r/b0pdN2qp59YBIV8eMzz7u4k5z/lFiKMxINtZiLihMB
        71MmyeYCAAA=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Στις 2021-04-06 11:22, Geert Uytterhoeven έγραψε:
> Hi Nick,
> 
> On Tue, Apr 6, 2021 at 10:11 AM Nick Kossifidis <mick@ics.forth.gr> 
> wrote:
>> Hello Geert,
>> Στις 2021-04-06 10:19, Geert Uytterhoeven έγραψε:
>> > On Mon, Apr 5, 2021 at 10:57 AM Nick Kossifidis <mick@ics.forth.gr>
>> > wrote:
>> >> * Kernel region is always present and we know where it is, no
>> >> need to look for it inside the loop, just ignore it like the
>> >> rest of the reserved regions within system's memory.
>> >>
>> >> * Don't call memblock_free inside the loop, if called it'll split
>> >> the region of pre-allocated resources in two parts, messing things
>> >> up, just re-use the previous pre-allocated resource and free any
>> >> unused resources after both loops finish.
>> >>
>> >> * memblock_alloc may add a region when called, so increase the
>> >> number of pre-allocated regions by one to be on the safe side
>> >> (reported and patched by Geert Uytterhoeven)
>> >>
>> >> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
>> >
>> > Where does this SoB come from?
>> >
>> >> Signed-off-by: Nick Kossifidis <mick@ics.forth.gr>
>> >
>> >> --- a/arch/riscv/kernel/setup.c
>> >> +++ b/arch/riscv/kernel/setup.c
>> >
>> >> @@ -129,53 +139,42 @@ static void __init init_resources(void)
>> >>         struct resource *res = NULL;
>> >>         struct resource *mem_res = NULL;
>> >>         size_t mem_res_sz = 0;
>> >> -       int ret = 0, i = 0;
>> >> -
>> >> -       code_res.start = __pa_symbol(_text);
>> >> -       code_res.end = __pa_symbol(_etext) - 1;
>> >> -       code_res.flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
>> >> -
>> >> -       rodata_res.start = __pa_symbol(__start_rodata);
>> >> -       rodata_res.end = __pa_symbol(__end_rodata) - 1;
>> >> -       rodata_res.flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
>> >> -
>> >> -       data_res.start = __pa_symbol(_data);
>> >> -       data_res.end = __pa_symbol(_edata) - 1;
>> >> -       data_res.flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
>> >> +       int num_resources = 0, res_idx = 0;
>> >> +       int ret = 0;
>> >>
>> >> -       bss_res.start = __pa_symbol(__bss_start);
>> >> -       bss_res.end = __pa_symbol(__bss_stop) - 1;
>> >> -       bss_res.flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
>> >> +       /* + 1 as memblock_alloc() might increase
>> >> memblock.reserved.cnt */
>> >> +       num_resources = memblock.memory.cnt + memblock.reserved.cnt +
>> >> 1;
>> >> +       res_idx = num_resources - 1;
>> >>
>> >> -       mem_res_sz = (memblock.memory.cnt + memblock.reserved.cnt) *
>> >> sizeof(*mem_res);
>> >
>> > Oh, you incorporated my commit ce989f1472ae350e ("RISC-V: Fix
>> > out-of-bounds
>> > accesses in init_resources()") (from v5.12-rc4) into your patch.
>> > Why? This means your patch does not apply against upstream.
>> >
>> 
>> Sorry if this looks awkward, I'm under the impression that new 
>> features
>> go on for-next instead of fixes and your patch hasn't been merged on
>> for-next yet. I thought it would be cleaner to have one patch to merge
>> for init_resources instead of two, and simpler for people to test the
>> series. I can rebase this on top of fixes if that works better for you
>> or Palmer.
> 
> Ideally the fixes branch is part of the next branch.  That also helps
> to avoid other people having to fix conflicts when merging both.
> 

OK I'll re-base this on top of fixes instead.
