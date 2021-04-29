Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A25E36E660
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 09:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237310AbhD2H4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 03:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231528AbhD2H4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 03:56:13 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E683C06138B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 00:55:26 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id a22-20020a05600c2256b0290142870824e9so3795510wmm.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 00:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qmJlsNemUgj3XZEoe8PGtodHTnvLV7K7B1GWOlD5JPY=;
        b=MC8vXuPxHiaY4P/7KjvzPf+whH9V6z99NLOPd0W5Gyt7V1Y7mWqTkmMHr13Wr3Lb4k
         TdqMAf1i/sw5xYsUyK7UlSM5pASgeocY0x7G1w9SR41sQFXIQ9yjRw7fcT36PbGO74yg
         G9ueACKVUSp7Cy4I08Ufm+gTZC4JunjqJ+Z0rzFbbuKtHn/e26pS2ucuLp/fdqMjI5xc
         9jarGC4IU800VC+rN8h2vNHuUmRAcz16Zvgt5L8Q5f6hN1IP+gbpSgwIsWpsc2wx4n1g
         GgN+XDQVYQb/eIiLOWR2XH36+njznkuAkPr/4PoTpG3r3FrLZJph6FxIXhsAKLi3euvM
         7H9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qmJlsNemUgj3XZEoe8PGtodHTnvLV7K7B1GWOlD5JPY=;
        b=pCkiok+0DT3D9IanD/M94NRCDVCdpdPB2iZgjCBzsby3sdvjQSTAPRnI3tMgEIpspT
         bhQBKdmWEWTYRfpoUWM5LHiozTKvdk7kv9D/x/WlB8Jqjck5XiahU7EyKKZjWDm+1xEz
         YwQmdtT0DN5L620z2sfk9KeRjmgk/CDRfMaWRsLMyfrTB/0WsK4xHUsXCxfzC6M7QVRW
         akh7BVidGVwqMnaVtmfVVx2j/DMghomiyHCb96oYHL3bQ/CBRiwlIbeB8FRhi6S46dIb
         Ig2TcP/SRyX1R5XiissWrLrNhX0NlYLZu8b1eje6SFtXRZZ73KHAKFycE2igxcDI3ZEb
         iiKw==
X-Gm-Message-State: AOAM531rFib/1JuZxGUP6UDUqtEijnhS1nZrV+xhZUUUSD84BTo40sk6
        FWHH2HrT+9KUChRXbwr5VFk89TmDb/UarQT4ZCgq6Q==
X-Google-Smtp-Source: ABdhPJzmiOF3xJqL0l47OKPp6r3szhwHqR1tHXYt5EGgYJiCmB2qjo4Ft1myb006o3nevFZh0bQsaZqQYjoTBApA0qs=
X-Received: by 2002:a05:600c:9:: with SMTP id g9mr36255849wmc.134.1619682925177;
 Thu, 29 Apr 2021 00:55:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210429061713.783628-1-palmer@dabbelt.com>
In-Reply-To: <20210429061713.783628-1-palmer@dabbelt.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 29 Apr 2021 13:25:14 +0530
Message-ID: <CAAhSdy0Euh_rqpYkqB-_WtRmMJG5YpAk8nXghrz59-ARjD-9FA@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: insn: Use a raw spinlock to protect TEXT_POKE*
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     linux-riscv <linux-riscv@lists.infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Peter Zijlstra <peterz@infradead.org>, jpoimboe@redhat.com,
        jbaron@akamai.com, rostedt@goodmis.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        Anup Patel <Anup.Patel@wdc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>, mhiramat@kernel.org,
        Zong Li <zong.li@sifive.com>,
        Guo Ren <guoren@linux.alibaba.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>, 0x7f454c46@gmail.com,
        chenhuang5@huawei.com,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        kernel-team@android.com, Palmer Dabbelt <palmerdabbelt@google.com>,
        Changbin Du <changbin.du@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2021 at 11:50 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> From: Palmer Dabbelt <palmerdabbelt@google.com>
>
> We currently use text_mutex to protect the fixmap sections from
> concurrent callers.  This is convienent for kprobes as the generic code
> already holds text_mutex, but ftrace doesn't which triggers a lockdep
> assertion.  We could take text_mutex for ftrace, but the jump label
> implementation (which is currently taking text_mutex) isn't explicitly
> listed as being sleepable and it's called from enough places it seems
> safer to just avoid sleeping.
>
> arm64 and parisc, the other two TEXT_POKE-style patching
> implemnetations, already use raw spinlocks.  abffa6f3b157 ("arm64:
> convert patch_lock to raw lock") lays out the case for a raw spinlock as
> opposed to a regular spinlock, and while I don't know of anyone using rt
> on RISC-V I'm sure it'll eventually show up and I don't see any reason
> to wait.
>
> Fixes: ebc00dde8a97 ("riscv: Add jump-label implementation")
> Reported-by: Changbin Du <changbin.du@gmail.com>
> Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>

Looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  arch/riscv/include/asm/fixmap.h |  3 +++
>  arch/riscv/kernel/jump_label.c  |  2 --
>  arch/riscv/kernel/patch.c       | 13 +++++++++----
>  3 files changed, 12 insertions(+), 6 deletions(-)
>
> diff --git a/arch/riscv/include/asm/fixmap.h b/arch/riscv/include/asm/fixmap.h
> index 54cbf07fb4e9..d1c0a1f123cf 100644
> --- a/arch/riscv/include/asm/fixmap.h
> +++ b/arch/riscv/include/asm/fixmap.h
> @@ -24,8 +24,11 @@ enum fixed_addresses {
>         FIX_HOLE,
>         FIX_PTE,
>         FIX_PMD,
> +
> +       /* Only used in kernel/insn.c */
>         FIX_TEXT_POKE1,
>         FIX_TEXT_POKE0,
> +
>         FIX_EARLYCON_MEM_BASE,
>
>         __end_of_permanent_fixed_addresses,
> diff --git a/arch/riscv/kernel/jump_label.c b/arch/riscv/kernel/jump_label.c
> index 20e09056d141..45bb32f91b5c 100644
> --- a/arch/riscv/kernel/jump_label.c
> +++ b/arch/riscv/kernel/jump_label.c
> @@ -35,9 +35,7 @@ void arch_jump_label_transform(struct jump_entry *entry,
>                 insn = RISCV_INSN_NOP;
>         }
>
> -       mutex_lock(&text_mutex);
>         patch_text_nosync(addr, &insn, sizeof(insn));
> -       mutex_unlock(&text_mutex);
>  }
>
>  void arch_jump_label_transform_static(struct jump_entry *entry,
> diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
> index 0b552873a577..dfa7ee8eb63f 100644
> --- a/arch/riscv/kernel/patch.c
> +++ b/arch/riscv/kernel/patch.c
> @@ -19,6 +19,8 @@ struct patch_insn {
>         atomic_t cpu_count;
>  };
>
> +static DEFINE_RAW_SPINLOCK(patch_lock);
> +
>  #ifdef CONFIG_MMU
>  /*
>   * The fix_to_virt(, idx) needs a const value (not a dynamic variable of
> @@ -54,13 +56,14 @@ static int patch_insn_write(void *addr, const void *insn, size_t len)
>         void *waddr = addr;
>         bool across_pages = (((uintptr_t) addr & ~PAGE_MASK) + len) > PAGE_SIZE;
>         int ret;
> +       unsigned long flags = 0;
>
>         /*
> -        * Before reaching here, it was expected to lock the text_mutex
> -        * already, so we don't need to give another lock here and could
> -        * ensure that it was safe between each cores.
> +        * FIX_TEXT_POKE{0,1} are only used for text patching, but we must
> +        * ensure that concurrent callers do not re-map these before we're done
> +        * with them.
>          */
> -       lockdep_assert_held(&text_mutex);
> +       raw_spin_lock_irqsave(&patch_lock, flags);
>
>         if (across_pages)
>                 patch_map(addr + len, FIX_TEXT_POKE1);
> @@ -74,6 +77,8 @@ static int patch_insn_write(void *addr, const void *insn, size_t len)
>         if (across_pages)
>                 patch_unmap(FIX_TEXT_POKE1);
>
> +       raw_spin_unlock_irqrestore(&patch_lock, flags);
> +
>         return ret;
>  }
>  NOKPROBE_SYMBOL(patch_insn_write);
> --
> 2.31.1.498.g6c1eba8ee3d-goog
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
