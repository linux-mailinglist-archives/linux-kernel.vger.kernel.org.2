Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5C683EA80A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 17:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238474AbhHLPyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 11:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238351AbhHLPyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 11:54:20 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93031C061756
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 08:53:55 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id k65so12610171yba.13
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 08:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9KW2/qijRYj1BOVATRIEUb5ZBc50beMYDjvUxmZFiRc=;
        b=LHuXb9xzqe5DwhBYGOjusfcVLJLfxSrMOqgAdsG7OgbRVJdCX8A+FCQsg0LRpoz+Tu
         AjQGQYHovApi+hFSLDN6rtlF9wmEBgVe6WbxXYtMJhWCS2fPc01sWMQwegW07LMbYBk1
         g4TyhI5MbyZmvOgDgZnThyIOICYEFkcpi8FSs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9KW2/qijRYj1BOVATRIEUb5ZBc50beMYDjvUxmZFiRc=;
        b=uhRHLa7BdFW3ju4iB5k7KYjqudM/ESNPier5LYVE4iN0XCFie282u4cJPSLru0Z0ah
         C4pBhpqx/6AvaS22Wsd1RoHVBLSLNCDYPuadr2/9aRH64V4zSRPMWw6/PQdgBDIzElcF
         08qrFLPADRAuwmmhYLlCUnI+Pavm/0RV0ET4HNPkUNDlFMqrdjZWDxbSuz/rJNLV1muk
         yY0Y5KGUlI4K0U2Ukhi9Z5pt1iYFUc659gm/cxhJa75L5SLls0kdnK9XuPeTJteUYDu0
         wQv0xY8P6Tn44mFZ2HvBx1q8liWrUD0aMcouqBUkQctMH6DqNlfVNzBpr/z23tyACG4I
         gvrQ==
X-Gm-Message-State: AOAM533VWp96phHPh7RYclFL+zYjL6KA3fGbqNHf3MUo5izNYyJaDzyE
        koFRPKqLj16Vy5eIgmhtBlpRxkJtx8fRQ5T8lQBa
X-Google-Smtp-Source: ABdhPJzZO0OsNFC/A2UHECLysjbKOC4vzD4gZilL/H0m8nkpIdJjITRQ2A/fHwlHwXIJYbEXwrlmPAVUpj41KqSL3h8=
X-Received: by 2002:a25:e094:: with SMTP id x142mr5068884ybg.147.1628783634885;
 Thu, 12 Aug 2021 08:53:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210812123433.27871-1-dimitri.ledkov@canonical.com>
In-Reply-To: <20210812123433.27871-1-dimitri.ledkov@canonical.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Thu, 12 Aug 2021 08:53:44 -0700
Message-ID: <CAOnJCULTxFmRbpw4wp7SYN8EJxFhSN5J04QDE=cfxLAB01ZOFA@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: prevent sbi_send_cpumask_ipi race with ftrace
To:     Dimitri John Ledkov <dimitri.ledkov@canonical.com>
Cc:     "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Pierce Andjelkovic <pierceandjelkovic@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 12, 2021 at 5:36 AM Dimitri John Ledkov
<dimitri.ledkov@canonical.com> wrote:
>
> From: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
>
> ftrace will patch instructions in sbi_send_cpumask_ipi, which is going to
> be used by flush_icache_range, leading to potential races and crashes like
> this:
>
> [    0.000000] ftrace: allocating 38893 entries in 152 pages
> [    0.000000] Oops - illegal instruction [#1]
> [    0.000000] Modules linked in:
> [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 5.11.0-1014-generic #14-Ubuntu
> [    0.000000] epc: ffffffe00000920e ra : ffffffe000009384 sp : ffffffe001803d30
> [    0.000000]  gp : ffffffe001a14240 tp : ffffffe00180f440 t0 : ffffffe07fe38000
> [    0.000000]  t1 : ffffffe0019cd338 t2 : 0000000000000000 s0 : ffffffe001803d70
> [    0.000000]  s1 : 0000000000000000 a0 : ffffffe0000095aa a1 : 0000000000000001
> [    0.000000]  a2 : 0000000000000002 a3 : 0000000000000000 a4 : 0000000000000000
> [    0.000000]  a5 : 0000000000000000 a6 : 0000000000000004 a7 : 0000000052464e43
> [    0.000000]  s2 : 0000000000000002 s3 : 0000000000000001 s4 : 0000000000000000
> [    0.000000]  s5 : 0000000000000000 s6 : 0000000000000000 s7 : 0000000000000000
> [    0.000000]  s8 : ffffffe001a170c0 s9 : 0000000000000001 s10: 0000000000000001
> [    0.000000]  s11: 00000000fffcc5d0 t3 : 0000000000000068 t4 : 000000000000000b
> [    0.000000]  t5 : ffffffe0019cd3e0 t6 : ffffffe001803cd8
> [    0.000000] status: 0000000200000100 badaddr: 000000000513f187 cause: 0000000000000002
> [    0.000000] ---[ end trace f67eb9af4d8d492b ]---
> [    0.000000] Kernel panic - not syncing: Attempted to kill the idle task!
> [    0.000000] ---[ end Kernel panic - not syncing: Attempted to kill the idle task! ]---
>
> Where ffffffe00000920e lies in the middle of sbi_send_cpumask_ipi.
>
> Reproduced on Unmatched board using Ubuntu kernels. See
> https://people.canonical.com/~xnox/lp1934548/ for sample images,
> kernels, debug symbols.
>
> BugLink: https://bugs.launchpad.net/bugs/1934548
> Reported-by: Pierce Andjelkovic <pierceandjelkovic@gmail.com>
> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
> Signed-off-by: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
> cc: Paul Walmsley <paul.walmsley@sifive.com>
> cc: linux-riscv@lists.infradead.org
> cc: stable@vger.kernel.org
> ---
>  arch/riscv/kernel/sbi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
> index 7402a417f38e..158199865c68 100644
> --- a/arch/riscv/kernel/sbi.c
> +++ b/arch/riscv/kernel/sbi.c
> @@ -562,7 +562,7 @@ long sbi_get_mimpid(void)
>         return __sbi_base_ecall(SBI_EXT_BASE_GET_MIMPID);
>  }
>
> -static void sbi_send_cpumask_ipi(const struct cpumask *target)
> +static void notrace sbi_send_cpumask_ipi(const struct cpumask *target)
>  {
>         struct cpumask hartid_mask;
>

flush_icache_range doesn't invoke sbi_send_cpumask_ipi.
flush_icache_range->flush_icache_all->sbi_remote_fence_i->__sbi_rfence->sbi_ecall

Moreover, sbi.c should be removed from ftrace path as it is compiled
with notrace flag after the patch [1]

CFLAGS_REMOVE_sbi.o   = $(CC_FLAGS_FTRACE)

This solution was proposed as a result of earlier discussion [2] last year.

[1] https://patchwork.kernel.org/project/linux-riscv/patch/1608220905-1962-5-git-send-email-guoren@kernel.org/
[2] https://lkml.org/lkml/2020/11/3/735

The proposed fix probably hiding the root cause somehow.

Do you have the patch[1] in your kernel ?


> --
> 2.30.2
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv



-- 
Regards,
Atish
