Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9548327042
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Feb 2021 05:25:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbhB1ETt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Feb 2021 23:19:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbhB1ETk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Feb 2021 23:19:40 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0494C06174A
        for <linux-kernel@vger.kernel.org>; Sat, 27 Feb 2021 20:18:59 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id i4-20020a17090a7184b02900bfb60fbc6bso937259pjk.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 Feb 2021 20:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KE12Frzs1jM/79rLleMhK+xA9rg3g9kBwFaCNo8NOwg=;
        b=cdvKgLLWN27BBZ/Y/bPZjnsFmRsKWIbj7fontXY55aXIxjraBd3SKXHIzQJ3CIdlgP
         wE55oQ6XpeMluAYIiT+ZmWwmzR1W5jpOH6f9VbUfW0I1i0gtC/24qSIOqustgHob6rlJ
         gk+GbBR+bH+Jf2lEjSremeyrJ9Ghk7czavoo2AnGoXqghp3/QNCiT8Dx3dsifPN18Upp
         SQgHW6NGMST6Opwcfd3Bf3UURKfDZ/bk1DuBgTbbXU2pfeu9Du5XPjvei3VODAVyDoZp
         sP1YFHlbK1zMzl83EpTiumszlzBNZzaZF5CeFNSXOpaetMPFgHfuQGieGi/uxEm/Tc8a
         ovkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KE12Frzs1jM/79rLleMhK+xA9rg3g9kBwFaCNo8NOwg=;
        b=XF5hX7HLobee3fi3ocBkf+XGa1ER1iGPN/68XJcV+glKj6z7t6t0wrXQwjfY/lRuu8
         9RyaFCjSuYWceC05Ic2NXVg65sl3YD6a5uZxEaxxp3GQ5lQh+vyg9E+sD3sb3ejR2ZCg
         rvDVV7G+/XM17BOLKueOvNUIwiuDrBd9Wjc3n6dwVodHRaDgRK/nqKEEOuaBWSWiwZnU
         cIDUJi0KZgj97Bi0qWqJvZ483pTFWznqiuG3gIUxHFrbZlpWMe9biyqtzmd359etVmPr
         EwUuax63ou/pA+A7OXs0XMsP6WyQDBDXTr8IpDtCTAxwfg+y8xYwZI55mUaZGYLQVE4w
         /zFw==
X-Gm-Message-State: AOAM532uyuhQiXyJObxvmSs+CnU3JTY/bteMxLH4ral+IMfgTHm80wwv
        LihIPDzBcSxHXrD3pCcGJJQDrAS/xtg=
X-Google-Smtp-Source: ABdhPJzc4Vqi3LJ3Whd+dRw+kAcTK23AcV2J0x53j28Xd34FeH1NdRzaS6Pft4qIJJAlxW/p8oqgFw==
X-Received: by 2002:a17:902:d886:b029:e1:7784:4db5 with SMTP id b6-20020a170902d886b02900e177844db5mr10017093plz.72.1614485938381;
        Sat, 27 Feb 2021 20:18:58 -0800 (PST)
Received: from [10.230.29.30] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d12sm12074966pgm.83.2021.02.27.20.18.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Feb 2021 20:18:57 -0800 (PST)
Subject: Re: [PATCH v2 2/2] memblock: do not start bottom-up allocations with
 kernel_end
To:     Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        Kamal Dasu <kdasu.kdev@gmail.com>, linux-mips@linux-mips.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>, rppt@kernel.org,
        iamjoonsoo.kim@lge.com, riel@surriel.com
Cc:     Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Rik van Riel <riel@surriel.com>,
        Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
References: <20201217201214.3414100-1-guro@fb.com>
 <20201217201214.3414100-2-guro@fb.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <23fc1ef9-7342-8bc2-d184-d898107c52b2@gmail.com>
Date:   Sat, 27 Feb 2021 20:18:47 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20201217201214.3414100-2-guro@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/17/2020 12:12 PM, Roman Gushchin wrote:
> With kaslr the kernel image is placed at a random place, so starting
> the bottom-up allocation with the kernel_end can result in an
> allocation failure and a warning like this one:
> 
> [    0.002920] hugetlb_cma: reserve 2048 MiB, up to 2048 MiB per node
> [    0.002921] ------------[ cut here ]------------
> [    0.002922] memblock: bottom-up allocation failed, memory hotremove may be affected
> [    0.002937] WARNING: CPU: 0 PID: 0 at mm/memblock.c:332 memblock_find_in_range_node+0x178/0x25a
> [    0.002937] Modules linked in:
> [    0.002939] CPU: 0 PID: 0 Comm: swapper Not tainted 5.10.0+ #1169
> [    0.002940] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-1.fc33 04/01/2014
> [    0.002942] RIP: 0010:memblock_find_in_range_node+0x178/0x25a
> [    0.002944] Code: e9 6d ff ff ff 48 85 c0 0f 85 da 00 00 00 80 3d 9b 35 df 00 00 75 15 48 c7 c7 c0 75 59 88 c6 05 8b 35 df 00 01 e8 25 8a fa ff <0f> 0b 48 c7 44 24 20 ff ff ff ff 44 89 e6 44 89 ea 48 c7 c1 70 5c
> [    0.002945] RSP: 0000:ffffffff88803d18 EFLAGS: 00010086 ORIG_RAX: 0000000000000000
> [    0.002947] RAX: 0000000000000000 RBX: 0000000240000000 RCX: 00000000ffffdfff
> [    0.002948] RDX: 00000000ffffdfff RSI: 00000000ffffffea RDI: 0000000000000046
> [    0.002948] RBP: 0000000100000000 R08: ffffffff88922788 R09: 0000000000009ffb
> [    0.002949] R10: 00000000ffffe000 R11: 3fffffffffffffff R12: 0000000000000000
> [    0.002950] R13: 0000000000000000 R14: 0000000080000000 R15: 00000001fb42c000
> [    0.002952] FS:  0000000000000000(0000) GS:ffffffff88f71000(0000) knlGS:0000000000000000
> [    0.002953] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    0.002954] CR2: ffffa080fb401000 CR3: 00000001fa80a000 CR4: 00000000000406b0
> [    0.002956] Call Trace:
> [    0.002961]  ? memblock_alloc_range_nid+0x8d/0x11e
> [    0.002963]  ? cma_declare_contiguous_nid+0x2c4/0x38c
> [    0.002964]  ? hugetlb_cma_reserve+0xdc/0x128
> [    0.002968]  ? flush_tlb_one_kernel+0xc/0x20
> [    0.002969]  ? native_set_fixmap+0x82/0xd0
> [    0.002971]  ? flat_get_apic_id+0x5/0x10
> [    0.002973]  ? register_lapic_address+0x8e/0x97
> [    0.002975]  ? setup_arch+0x8a5/0xc3f
> [    0.002978]  ? start_kernel+0x66/0x547
> [    0.002980]  ? load_ucode_bsp+0x4c/0xcd
> [    0.002982]  ? secondary_startup_64_no_verify+0xb0/0xbb
> [    0.002986] random: get_random_bytes called from __warn+0xab/0x110 with crng_init=0
> [    0.002988] ---[ end trace f151227d0b39be70 ]---
> 
> At the same time, the kernel image is protected with memblock_reserve(),
> so we can just start searching at PAGE_SIZE. In this case the
> bottom-up allocation has the same chances to success as a top-down
> allocation, so there is no reason to fallback in the case of a
> failure. All together it simplifies the logic.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>

Hi Roman, Thomas and other linux-mips folks,

Kamal and myself have been unable to boot v5.11 on MIPS since this
commit, reverting it makes our MIPS platforms boot successfully. We do
not see a warning like this one in the commit message, instead what
happens appear to be a corrupted Device Tree which prevents the parsing
of the "rdb" node and leading to the interrupt controllers not being
registered, and the system eventually not booting.

The Device Tree is built-into the kernel image and resides at
arch/mips/boot/dts/brcm/bcm97435svmb.dts.

Do you have any idea what could be wrong with MIPS specifically here?

Thanks!
-- 
Florian
