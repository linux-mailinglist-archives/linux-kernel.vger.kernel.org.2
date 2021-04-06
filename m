Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B695354E79
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 10:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240003AbhDFIWq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 6 Apr 2021 04:22:46 -0400
Received: from mail-vk1-f177.google.com ([209.85.221.177]:36754 "EHLO
        mail-vk1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239922AbhDFIWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 04:22:43 -0400
Received: by mail-vk1-f177.google.com with SMTP id d82so3016055vkd.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 01:22:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Az9dSdeZDXjGuSIhOGjrTFbuKwYYbifVIyBF0wPvnYY=;
        b=SjxAg5w+mrVv/Vpr2o9Pod9xoLSBum1JkEgFQL1r2ZIWQvntzSPolBDOisz+XiFFNr
         uCsnGwiKpkcGkZUgo1BjdA0ZUBbYsDCVc95LtP6/dhDsUWll9fluUptCsjbaDEhg/9AZ
         rDABdlSEa4J0eyi6LIka4RSbjFwXv/Q+OYmdWMoNyjm1IwGhE6GR3gme7l4sBzb2euua
         Q702R/PD0JV0j/kvzQtNiRh5pM2y8YS/csJ+Ua2tkJzPC6h//WJKJhg4uA9u4nkHA0Yr
         13EUm+D29zQFMxsvBJRAEb4FQnt4KcRlm64tPLwN9CVD+3Xim+LCF4xC0ZzD6/57CD9U
         mr3w==
X-Gm-Message-State: AOAM533cSLEdA0eoRweUa3D5mR+dUpBXdoOx4wVYOez7ow4hnV2+BfSJ
        zq4mrKFRFUOv54D4bOGnyuh4F1sXpEIOtexhdU9qdMLq
X-Google-Smtp-Source: ABdhPJwInFUg0m12roEg3q500Awfy5x1BUAIQ5ytLX95F4UD20kjXf8E8UTOC6DOaP6o5rKGvUMbHiVNmrl577DGpks=
X-Received: by 2002:a1f:2502:: with SMTP id l2mr16284892vkl.5.1617697355921;
 Tue, 06 Apr 2021 01:22:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210405085712.1953848-1-mick@ics.forth.gr> <20210405085712.1953848-4-mick@ics.forth.gr>
 <CAMuHMdWi+wo0+PCR6B1wyXVesG-kL9NQt8XFBuWhZ3SdVUaLZg@mail.gmail.com> <5a09d1f0ded4581c9e7458f546db9329@mailhost.ics.forth.gr>
In-Reply-To: <5a09d1f0ded4581c9e7458f546db9329@mailhost.ics.forth.gr>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 6 Apr 2021 10:22:24 +0200
Message-ID: <CAMuHMdWnRFuzSzSMCgBtNwxtq+itQ+iuX+i7nu5RD1E1W1FW-g@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] RISC-V: Improve init_resources
To:     Nick Kossifidis <mick@ics.forth.gr>
Cc:     linux-riscv <linux-riscv@lists.infradead.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

On Tue, Apr 6, 2021 at 10:11 AM Nick Kossifidis <mick@ics.forth.gr> wrote:
> Hello Geert,
> Στις 2021-04-06 10:19, Geert Uytterhoeven έγραψε:
> > On Mon, Apr 5, 2021 at 10:57 AM Nick Kossifidis <mick@ics.forth.gr>
> > wrote:
> >> * Kernel region is always present and we know where it is, no
> >> need to look for it inside the loop, just ignore it like the
> >> rest of the reserved regions within system's memory.
> >>
> >> * Don't call memblock_free inside the loop, if called it'll split
> >> the region of pre-allocated resources in two parts, messing things
> >> up, just re-use the previous pre-allocated resource and free any
> >> unused resources after both loops finish.
> >>
> >> * memblock_alloc may add a region when called, so increase the
> >> number of pre-allocated regions by one to be on the safe side
> >> (reported and patched by Geert Uytterhoeven)
> >>
> >> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> >
> > Where does this SoB come from?
> >
> >> Signed-off-by: Nick Kossifidis <mick@ics.forth.gr>
> >
> >> --- a/arch/riscv/kernel/setup.c
> >> +++ b/arch/riscv/kernel/setup.c
> >
> >> @@ -129,53 +139,42 @@ static void __init init_resources(void)
> >>         struct resource *res = NULL;
> >>         struct resource *mem_res = NULL;
> >>         size_t mem_res_sz = 0;
> >> -       int ret = 0, i = 0;
> >> -
> >> -       code_res.start = __pa_symbol(_text);
> >> -       code_res.end = __pa_symbol(_etext) - 1;
> >> -       code_res.flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
> >> -
> >> -       rodata_res.start = __pa_symbol(__start_rodata);
> >> -       rodata_res.end = __pa_symbol(__end_rodata) - 1;
> >> -       rodata_res.flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
> >> -
> >> -       data_res.start = __pa_symbol(_data);
> >> -       data_res.end = __pa_symbol(_edata) - 1;
> >> -       data_res.flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
> >> +       int num_resources = 0, res_idx = 0;
> >> +       int ret = 0;
> >>
> >> -       bss_res.start = __pa_symbol(__bss_start);
> >> -       bss_res.end = __pa_symbol(__bss_stop) - 1;
> >> -       bss_res.flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
> >> +       /* + 1 as memblock_alloc() might increase
> >> memblock.reserved.cnt */
> >> +       num_resources = memblock.memory.cnt + memblock.reserved.cnt +
> >> 1;
> >> +       res_idx = num_resources - 1;
> >>
> >> -       mem_res_sz = (memblock.memory.cnt + memblock.reserved.cnt) *
> >> sizeof(*mem_res);
> >
> > Oh, you incorporated my commit ce989f1472ae350e ("RISC-V: Fix
> > out-of-bounds
> > accesses in init_resources()") (from v5.12-rc4) into your patch.
> > Why? This means your patch does not apply against upstream.
> >
>
> Sorry if this looks awkward, I'm under the impression that new features
> go on for-next instead of fixes and your patch hasn't been merged on
> for-next yet. I thought it would be cleaner to have one patch to merge
> for init_resources instead of two, and simpler for people to test the
> series. I can rebase this on top of fixes if that works better for you
> or Palmer.

Ideally the fixes branch is part of the next branch.  That also helps
to avoid other people having to fix conflicts when merging both.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
