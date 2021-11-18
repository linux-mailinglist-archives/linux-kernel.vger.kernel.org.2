Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B21AD456275
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 19:34:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233446AbhKRShB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 13:37:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233034AbhKRShA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 13:37:00 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67509C061574
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 10:34:00 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id w1so31043150edd.10
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 10:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sD/7PXxY6oRC0H8y+i6m6lCMGSVi075KDguuoNalNQ0=;
        b=hJxBZZICvgbFiRetTm4xj9vuqHWJfMVMNt1XYSQu2SRxp4An02ggOtCwhdO0UlrfxG
         eY+3GVA2fExFSpchvXixcQT9x0nP+BFFqnIQEmZ5zOb56PMp9dPzAhO6J8a/qUEKmUdY
         HYc6v5BFp33RVFPKXIgUSc4ZoocbHTsFUhOwA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sD/7PXxY6oRC0H8y+i6m6lCMGSVi075KDguuoNalNQ0=;
        b=NXN5ssyLou+ZxbyinyGd3b6s0SQVKAcVZ04OxhVm+VCli9IiCVWSxDanhA40/f+7Ey
         diRHhLV3/6+X7a1Hq6g73ZgFWpiXtbhbwNCdqZP4plhZ1ulTILvyWJkZ0/zg6ij+LVpl
         BgVqRNOdlFl1DqOGthmdYYr4qKmcRJPUgzf/dSlmiu6vZw9JZL18icfrzdGRkZNKaqzs
         P68QAvfJyN8Ve1rU1+ti1DmNfFAbz+pNFgMsntWXpE5MmJP/Csbx9o0sNHgImKztE2LE
         r7LQZvkXcsRUA0rVjYijOPsr76MGKYM3xlfy3+irizsTd80EK43kYvwK2yOIFlgFMpi3
         zvkg==
X-Gm-Message-State: AOAM532UMAijbnbP3kTitedmW004PK7W8/7hX+pLHdpwPzenlqsx0Srg
        WsbLD7AmGYZPph9wED34PG9ALvtRItU62Dnh
X-Google-Smtp-Source: ABdhPJw+NtWIOL2HduxlAzXLqvXGW8YsqAZG22USFMpbCxlw73IEaiyDYcYpHkvWA1bZDJGJup7yxQ==
X-Received: by 2002:a17:906:d193:: with SMTP id c19mr1475421ejz.471.1637260438305;
        Thu, 18 Nov 2021 10:33:58 -0800 (PST)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com. [209.85.221.43])
        by smtp.gmail.com with ESMTPSA id p23sm321514edw.94.2021.11.18.10.33.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Nov 2021 10:33:56 -0800 (PST)
Received: by mail-wr1-f43.google.com with SMTP id a9so13364367wrr.8
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 10:33:55 -0800 (PST)
X-Received: by 2002:adf:dcd0:: with SMTP id x16mr33708224wrm.229.1637260435206;
 Thu, 18 Nov 2021 10:33:55 -0800 (PST)
MIME-Version: 1.0
References: <20211012141131.3c9a2eb1@gandalf.local.home> <CAHk-=wj2SbVnsO7yxgaD20HBaH=0rNM60nD92+BDSwQxofd9SQ@mail.gmail.com>
 <20211012145540.343541e9@gandalf.local.home> <CAHk-=wg6fw130AkO72GPFow9PHvP9odnC5LZ0UaY9bJQuF-C5A@mail.gmail.com>
 <20211022083845.08fe5754@gandalf.local.home> <CAHk-=wird-sCbSG3KxNavdD-mFWO1YkT2Qjoeb0Z1Ag4QDNwuA@mail.gmail.com>
 <20211118114746.3329bd33@gandalf.local.home>
In-Reply-To: <20211118114746.3329bd33@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 18 Nov 2021 10:33:39 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj4N=4JsTtXEZi3Hwqao8j-R=HROw=L21+T_28jTyaR=w@mail.gmail.com>
Message-ID: <CAHk-=wj4N=4JsTtXEZi3Hwqao8j-R=HROw=L21+T_28jTyaR=w@mail.gmail.com>
Subject: Re: [BUG] WARNING: CPU: 3 PID: 1 at mm/debug_vm_pgtable.c:493
To:     Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Gavin Shan <gshan@redhat.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18, 2021 at 8:47 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Triggered it again with the new update:
>
> [   24.751779] IPI shorthand broadcast: enabled
> [   24.761177] sched_clock: Marking stable (23431856262, 1329270511)->(28163092341, -3401965568)
> [   24.770495] device: 'cpu_dma_latency': device_add
> [   24.775232] PM: Adding info for No Bus:cpu_dma_latency
> [   24.780929] debug_vm_pgtable: [debug_vm_pgtable         ]: Validating architecture page table helpers
> [   24.799490] mtrr_type_lookup() returned 0 (0)

Ok, so that's MTRR_TYPE_UNCACHABLE, and "uniform" is 0.

Anyway, either the mtrr code is confused, or more likely it just does
the right thing, and  pud_set_huge() is simply expected to return 0 in
this situation, and that WARN_ON() in pud_huge_tests() is simply wrong
to trigger at all.

I didn't look at what all the code in debug_vm_pgtable() is trying to
set up to test. Honestly, it's all very opaque.

But I do notice that the pfn that the test uses ends up basically
being something random, where the "fixed" pfn is

        phys = __pa_symbol(&start_kernel);
        ...
        args->fixed_pud_pfn = __phys_to_pfn(phys & PUD_MASK);

rather than being an allocated real PUD-sized page. That can be a
problem in itself.

So I think the problem is that depending on where the kernel is
allocated, the fixed_pud_pfn ends up being in an area with MTRR
settings. In fact, I'm surprised it's not *always* in that area, since
presumabl;y you have the normal fixed MTRR issues with the 640k-1M
range.

But I didn't look - probably the MTRR code doesn't actually check the
special fixed MTRR's.

Anyway, I think that the end result is simply that the tests in
mm/debug_vm_pgtable.c are simply buggy, and the WARN_ON() is not a
sign of anything wrong in the mm, but with the tests themselves.

So the fixed_pud_pfn is dodgy, but it looks like the non-fixed
'pud_pfn' allocation may be dodgy too:

  #ifdef CONFIG_CONTIG_ALLOC
        if (order >= MAX_ORDER) {
                page = alloc_contig_pages((1 << order), GFP_KERNEL,
                                          first_online_node, NULL);

because afaik, alloc_contig_pages() does allocate a contiguous region,
but it doesn't necessarily allocate a _aligned_ contiguous region.

So I think _all_ those PUD tests are likely broken, but honestly, I
don't know the code well enough to be entirely sure, I'm just seeing
code that looks dodgy to me.

I don't think the breakage is x86-specific. Quite the reverse. I think
the x86 code just happens to randomly show it when some MTRR ends up
being used.

Maybe pfn_pud() should verify that it's actually given an aligned argument?

Gavin, Anshuman? Feel free to tell me what I missed.

Otherwise, we should disable those PUD tests (or fix them, of course).

For now, I consider this WARN_ON() to be a failure of the testing
infrastructure, not of the VM code.

                Linus
