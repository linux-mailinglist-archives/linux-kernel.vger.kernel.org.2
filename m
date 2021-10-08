Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04FF7426601
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 10:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233532AbhJHIga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 04:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbhJHIg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 04:36:29 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BAB7C061570
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 01:34:34 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id m26so8836911qtn.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 01:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YBAw7lZ94tPRxfH2x9IGL0hHeL3gAMxN0L+YoR8O/cw=;
        b=cQxBsyudUjObMyMwCEB+MCHxkOQHkbiaSmD5xFuFYNkgMklVR6njI73Y8LXg9agSQn
         /LffCYe5gOnFZko3I6LMRmCDs3fBqzTs3ENw7FeoKbBgZFFZeJRkF1gdWFbaxDtMTZbv
         rG0TbEKGCyqpNbvPeMoXnjxqE1/+xBbMo881OLlY68jlzD4fG03RlcNb3cNBpKfKhxed
         nUmgnsPi1yVqmkzHOrcnEOOKm8dKckPpAwwvPfIPAQevw1HtC1w9qbVh/eFcD/NTM+ef
         k9ohIMBhyfFIoaBN2fO+xJNfEQ/mS6H8er2UmneO1eSWRMjAwgRUBhHhKFBYN7JLtC/Z
         eplw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YBAw7lZ94tPRxfH2x9IGL0hHeL3gAMxN0L+YoR8O/cw=;
        b=YJn+GKSk1ZZEYESQUQ7MG6o0jRhHOEBmlxhiCf0/LggRg+YiXTZlg2rfIz4nh/00+y
         pzpYkcI1Wq1/55qeaAlkzN0CshttLnN91vV/58IZwlSh9rZqxlg5XgANTQ651J//x/K8
         D0Wze62FHu/8/rDIFEEtN+1alQpGhWnPjW9SeOeds/A3DNLojGNu7OEe/CB2a16HY5vx
         EtydioUjPQggqXrGmRCgvKK35otvUuAuQKzEPoeGSXBgSF7b8Nvd9FIUD+wslNFbqt/g
         3f0Pl7VIo9fVtL+pwMshYUkzOGP2r+SF+aTLMc3x70T7ELNGaWriAvbbTMwbjOSwqlP7
         D0ug==
X-Gm-Message-State: AOAM53199a06spKu9b3CaIHFbKOCsFpsWIPl1gbetOJQ4wT8/qePA50c
        eMFpQdBnotA12KM4rM/9CBE7pTqrE1VvYZFU16M=
X-Google-Smtp-Source: ABdhPJyL0LdcVsPb/8zGbDDHZOC1MIL0nZvt18z0mwQ5nvq/k4ABEPylnHMg4LxZSc0xrISHj5x+H7VFN1RStHwyaxk=
X-Received: by 2002:ac8:6a0a:: with SMTP id t10mr7679619qtr.299.1633682073502;
 Fri, 08 Oct 2021 01:34:33 -0700 (PDT)
MIME-Version: 1.0
References: <1633673269-15048-1-git-send-email-huangzhaoyang@gmail.com> <20211008080113.GA441@willie-the-truck>
In-Reply-To: <20211008080113.GA441@willie-the-truck>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Fri, 8 Oct 2021 16:34:12 +0800
Message-ID: <CAGWkznEh6RuEgxTH-vHB1kMjb0CERigqpL4+f0Lg1X1_VBQuMQ@mail.gmail.com>
Subject: Re: [RFC PATCH] arch: ARM64: add isb before enable pan
To:     Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Quentin Perret <qperret@google.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ke Wang <ke.wang@unisoc.com>, ping.zhou1@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 8, 2021 at 4:01 PM Will Deacon <will@kernel.org> wrote:
>
> Hi,
>
> On Fri, Oct 08, 2021 at 02:07:49PM +0800, Huangzhaoyang wrote:
> > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> >
> > set_pstate_pan failure is observed in an ARM64 system occasionaly on a reboot
> > test, which can be work around by a msleep on the sw context. We assume
> > suspicious on disorder of previous instr of disabling SW_PAN and add an isb here.
> >
> > PS:
> > The bootup test failed with a invalid TTBR1_EL1 that equals 0x34000000, which is
> > alike racing between on chip PAN and SW_PAN.
>
> Sorry, but I'm struggling to understand the problem here. Please could you
> explain it in more detail?
>
>   - Why does a TTBR1_EL1 value of `0x34000000` indicate a race?
>   - Can you explain the race that you think might be occurring?
>   - Why does an ISB prevent the race?
Please find panic logs[1], related codes[2], sample of debug patch[3]
below. TTBR1_EL1 equals 0x34000000 when panic and can NOT be captured
by the debug patch during retest (all entrances that msr ttbr1_el1 are
under watch) which should work. Adding ISB here to prevent race on
TTBR1 from previous access of sysregs which can affect the msr
result(the test is still ongoing). Could the race be
ARM64_HAS_PAN(automated by core) and SW_PAN.

[1]
[    0.348000]  [0:    migration/0:   11] Synchronous External Abort:
level 1 (translation table walk) (0x96000055) at 0xffffffc000e06004
[    0.352000]  [0:    migration/0:   11] Internal error: : 96000055
[#1] PREEMPT SMP
[    0.352000]  [0:    migration/0:   11] Modules linked in:
[    0.352000]  [0:    migration/0:   11] Process migration/0 (pid:
11, stack limit = 0x        (ptrval))
[    0.352000]  [0:    migration/0:   11] CPU: 0 PID: 11 Comm:
migration/0 Tainted: G S
4.14.199-22631304-abA035FXXU0AUJ4_T4 #2
[    0.352000]  [0:    migration/0:   11] Hardware name: Spreadtrum
UMS9230 1H10 SoC (DT)
[    0.352000]  [0:    migration/0:   11] task:         (ptrval)
task.stack:         (ptrval)
[    0.352000]  [0:    migration/0:   11] pc : patch_alternative+0x68/0x27c
[    0.352000]  [0:    migration/0:   11] lr :
__apply_alternatives.llvm.7450387295891320208+0x60/0x160

[2]
__apply_alternatives
   for()
       patch_alternative    <----panic here in the 2nd round of loop
after invoking flush_icache_range
       flush_icache_range

[3]
sub \tmp1, \tmp1, #SWAPPER_DIR_SIZE
+ tst     \tmp1, #0xffff80000000 // check ttbr1_el1 valid
+    b.le    .
msr ttbr1_el1, \tmp1 // set reserved ASID

>
> > Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > ---
> >  arch/arm64/kernel/cpufeature.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> > index efed283..3c0de0d 100644
> > --- a/arch/arm64/kernel/cpufeature.c
> > +++ b/arch/arm64/kernel/cpufeature.c
> > @@ -1663,6 +1663,7 @@ static void cpu_enable_pan(const struct arm64_cpu_capabilities *__unused)
> >       WARN_ON_ONCE(in_interrupt());
> >
> >       sysreg_clear_set(sctlr_el1, SCTLR_EL1_SPAN, 0);
> > +     isb();
> >       set_pstate_pan(1);
>
> SCTLR_EL1.SPAN only affects the PAN behaviour on taking an exception, which
> is itself a context-synchronizing event, so I can't see why the ISB makes
> any difference here (at least, for the purposes of PAN).
>
> Thanks,
>
> Will
