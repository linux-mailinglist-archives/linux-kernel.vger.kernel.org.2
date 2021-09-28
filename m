Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1033F41B957
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 23:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242961AbhI1Vf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 17:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242958AbhI1Vfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 17:35:53 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBBBEC061745
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 14:34:13 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id b12so501118ilf.11
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 14:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nsKPNLpo86tI1e6ufngSnoqSL1V2L8ufaWTNn+WM/mg=;
        b=ZdFqvI3Mj1kGHOB64g6Sqw5DhZw2STyUD5AYUnXGDmyf1JcDViRF7thmt74LMPQ64l
         9hR1u0pAC8YXfL5Onb71OahQ5XmH6p1KJNvhNhpSXUWNTU7ZgaTcit/2fpnNvf7eYT2G
         ZKVwP+Y4y796Pfy+QWBLH2XWcGUvi1C6IeA4BoSh6911/vxzAC/+/fp69P0oDCZqnoAj
         S4WLF1vouOhmKbAsCovmaJsPk/JDPctK3179KkCC3SOTkjKUypM7WWNqrXyNy0v1r+Ll
         cpq1P7lwIQcZZXnjPrRk15rRPpd/53f2hUtBoqpQiW8FvcabXQA1/ag2+TIoAkghUxZn
         eUMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nsKPNLpo86tI1e6ufngSnoqSL1V2L8ufaWTNn+WM/mg=;
        b=cz8dC6ve9wumfvbKw7mpbXZM1ThLO3KYVJ/c8g3nncmAX9JZcrvgJvUeD6JtrHdso2
         G38b/XUxYYHUb5XDfV0bJrW9kAfIfZcZvpANRI9Cmw7Kd04WLiyfX23JVooM5Mds7sZQ
         jyo87KhVM00ASTLCV02OhvyslY0gb907yc/EkFjpxgcSu7YeWpcDgER7GXjZNwKJAfoP
         RzjRXedKjqqy1tHPC5Kf+6LFsnetTmRw+tpjDuK2edvXyLnhVms3pmbOFz+UGv7Q3xnK
         I35YziVI0yDgdXMnd1/bEkeq4M3nnmaMSWX0DiQVLyMJykOq1sqgwNdgol94sjSsCwf+
         dSKg==
X-Gm-Message-State: AOAM532sa8wNV6p3QXWRIFoPPl2Uu525sG+0AKs7RJqbfsTU+PN5m0JB
        efF3dO/Cnc5lQ4qrkd1EfCgtkHIUuyJHdmVY5g==
X-Google-Smtp-Source: ABdhPJyS89tWTU+xwEtX6H94HzuqwKMBrfdfNL3W3moCpbUfv3KsvHcgW2Th5eerA+hxEHg7j74iF+RINthbKymt1ds=
X-Received: by 2002:a05:6e02:1a46:: with SMTP id u6mr6109975ilv.214.1632864853227;
 Tue, 28 Sep 2021 14:34:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210926150838.197719-1-jiangshanlai@gmail.com> <20210926150838.197719-17-jiangshanlai@gmail.com>
In-Reply-To: <20210926150838.197719-17-jiangshanlai@gmail.com>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Tue, 28 Sep 2021 17:34:02 -0400
Message-ID: <CAMzpN2iubB2suZVT3r9f4_T5mkqt4Kgb4GaS0o=MD8NY6qaDtA@mail.gmail.com>
Subject: Re: [PATCH V2 16/41] x86/entry: Implement the whole error_entry() as
 C code
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Youquan Song <youquan.song@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tony Luck <tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 26, 2021 at 11:13 AM Lai Jiangshan <jiangshanlai@gmail.com> wrote:
>
> From: Lai Jiangshan <laijs@linux.alibaba.com>
>
> All the needed facilities are set in entry64.c, the whole error_entry()
> can be implemented in C in entry64.c.  The C version generally has better
> readability and easier to be updated/improved.
>
> No function change intended. Only a check for X86_FEATURE_XENPV is added
> because the new error_entry() does not use the pv SWAPGS, rather it uses
> native_swapgs().  And for XENPV, error_entry() has nothing to do, so it
> can return directly.
>
> Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
> ---
>  arch/x86/entry/entry64.c     | 76 ++++++++++++++++++++++++++++++++++
>  arch/x86/entry/entry_64.S    | 80 +-----------------------------------
>  arch/x86/include/asm/traps.h |  1 +
>  3 files changed, 78 insertions(+), 79 deletions(-)
>
> diff --git a/arch/x86/entry/entry64.c b/arch/x86/entry/entry64.c
> index dafae60d31f9..5f2be4c3f333 100644
> --- a/arch/x86/entry/entry64.c
> +++ b/arch/x86/entry/entry64.c
> @@ -56,3 +56,78 @@ static __always_inline void kernel_entry_fence_no_swapgs(void)
>  {
>         alternative("", "lfence", X86_FEATURE_FENCE_SWAPGS_KERNEL);
>  }
> +
> +/*
> + * Put pt_regs onto the task stack and switch GS and CR3 if needed.
> + * The actual stack switch is done in entry_64.S.
> + *
> + * Becareful, it might be in the user CR3 and user GS base at the start
> + * of the function.
> + */
> +asmlinkage __visible __entry_text
> +struct pt_regs *error_entry(struct pt_regs *eregs)
> +{
> +       unsigned long iret_ip = (unsigned long)native_irq_return_iret;
> +
> +       asm volatile ("cld");

The C ABI states that the direction flag must be clear on function
entry and exit, so the CLD instruction needs to remain in the asm
code.

https://refspecs.linuxbase.org/elf/x86_64-abi-0.99.pdf#subsection.3.2.1

--
Brian Gerst
