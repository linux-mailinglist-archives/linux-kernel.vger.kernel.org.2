Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF20A3A0832
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 02:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232437AbhFIASw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 20:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbhFIASv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 20:18:51 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C90C061574
        for <linux-kernel@vger.kernel.org>; Tue,  8 Jun 2021 17:16:58 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id b5so22260474ilc.12
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 17:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:cc;
        bh=Q7umJMxlcORXR8DXG5jeDR7TIw3EETGwHHTK3QtzcYo=;
        b=osmrq6EEKAmwXGO/ag5dY9/jajOyVwQXpRNKs8GMHVHuhmDzAL9cVQjwcfNeyNcXn0
         IohPl1F9egwLhobBY44FPD/W6IiYAVhBueN86+qrXveAZpBrolRQFIR5hVqStziJ/4SZ
         5uHkK9+YdImOVE0mM6m1zByJgRl/z/ykAruJ4QatYWyWL0/P4djpnlS2vMtRmmb4GmAo
         GFPwNrcvpN2oBBq92E6StvD+uYSaj1yGsKY9VnC5mJ+WRtKLog6bLjjKAHxIy8wXIKLF
         WlGinZaID9doaVmdBN2Sxji2g0zpq/MUuB0Nx5ngndjKogYUKmhYFUzertPiODPt2AN+
         WMIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:cc;
        bh=Q7umJMxlcORXR8DXG5jeDR7TIw3EETGwHHTK3QtzcYo=;
        b=ckf4baL58p17mjNUeG0i89iflnLrtQi7viiIR27hLLMkuCex0GP3MKIL8rMR2/OcMk
         tn2AAfRAQw/XVNpTepqAOZwAT4AUYV3QReUfHpsgfu0qfKjTK6SQp3teaFBEBCE4ScA6
         JcRigedfC9EKLp4noqDsQPI2Y8DZ4sIR9GMxAWwh1DPgcT03Frpm95PxLQkLQ0WoduUX
         OfFd/c9R/ArNW44OIs/T56KAUg73aJuyhsMEqVGdY/6IhhwaWuJKJcyjHuY3pHE9IxYa
         nBUbfnOGEtIBFR9BfR51S0MpUFFTN5LQprPW3YpFtIfnMfJ5mvvR29vJ515TZdoV+0A7
         5kHw==
X-Gm-Message-State: AOAM53338Fbd1PrDPCXX0fZCq5Ua+p3JJup9LKe28oG9Fyca35e+ml8C
        gBFA43Ydu1ltIXsYX0NSQJJ97Rv83NXqVvXi3w==
X-Received: by 2002:a05:6638:210d:: with SMTP id n13mt23313955jaj.7.1623197817102;
 Tue, 08 Jun 2021 17:16:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210608103359.84907-1-kernelfans@gmail.com>
In-Reply-To: <20210608103359.84907-1-kernelfans@gmail.com>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Wed, 9 Jun 2021 08:16:46 +0800
Message-ID: <CAFgQCTvM7NJSxXbOC7XoKzZwEsWcL2hRupvtsYA=Fi4um9rVCw@mail.gmail.com>
Subject: Re: [PATCH] crash_core, vmcoreinfo: Append 'SECTION_SIZE_BITS' to vmcoreinfo
Cc:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Boris Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        James Morse <james.morse@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Dave Anderson <anderson@redhat.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kexec Mailing List <kexec@lists.infradead.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        k-hagio-ab@nec.com
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct mail address of Kazuhito

On Tue, Jun 8, 2021 at 6:34 PM Pingfan Liu <kernelfans@gmail.com> wrote:
>
> As mentioned in kernel commit 1d50e5d0c505 ("crash_core, vmcoreinfo:
> Append 'MAX_PHYSMEM_BITS' to vmcoreinfo"), SECTION_SIZE_BITS in the
> formula:
>     #define SECTIONS_SHIFT    (MAX_PHYSMEM_BITS - SECTION_SIZE_BITS)
>
> Besides SECTIONS_SHIFT, SECTION_SIZE_BITS is also used to calculate
> PAGES_PER_SECTION in makedumpfile just like kernel.
>
> Unfortunately, this arch-dependent macro SECTION_SIZE_BITS changes, e.g.
> recently in kernel commit f0b13ee23241 ("arm64/sparsemem: reduce
> SECTION_SIZE_BITS"). But user space wants a stable interface to get this
> info. Such info is impossible to be deduced from a crashdump vmcore.
> Hence append SECTION_SIZE_BITS to vmcoreinfo.
>
> Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> Cc: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> Cc: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Boris Petkov <bp@alien8.de>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: James Morse <james.morse@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Dave Anderson <anderson@redhat.com>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-kernel@vger.kernel.org
> Cc: kexec@lists.infradead.org
> Cc: x86@kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> ---
>  kernel/crash_core.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index 825284baaf46..684a6061a13a 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -464,6 +464,7 @@ static int __init crash_save_vmcoreinfo_init(void)
>         VMCOREINFO_LENGTH(mem_section, NR_SECTION_ROOTS);
>         VMCOREINFO_STRUCT_SIZE(mem_section);
>         VMCOREINFO_OFFSET(mem_section, section_mem_map);
> +       VMCOREINFO_NUMBER(SECTION_SIZE_BITS);
>         VMCOREINFO_NUMBER(MAX_PHYSMEM_BITS);
>  #endif
>         VMCOREINFO_STRUCT_SIZE(page);
> --
> 2.29.2
>
