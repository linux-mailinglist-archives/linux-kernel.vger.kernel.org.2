Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 188BD3473A1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 09:30:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233592AbhCXI3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 04:29:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:41344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233472AbhCXI32 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 04:29:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 918FD619F7
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 08:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616574568;
        bh=vlJ9js9b5fHVG8v7WcK4E//fEklX9BQWdi27y5hQum4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jbl05DxGc7eu5VEE2/O0UAF7/J1JeJxciE24kTfb+VlGWmJApyP+bARo8DDatOpxV
         6wX63LF9Fh2uSqedSwrsj0FFq8/HOqgc5lwG0q6L1BSbIFGH5o/PZJ4//TzopW7s4B
         Ry32n0BezAlUvSHNLi65EpoGhPt/przVtHzzTVNO9ct1QNkQw9kGQrczv4kCfkfwVT
         TVAimwIgrpy/nxvtvSgWxRsTfyRSom2YfnwomtnaXIEr8Q/ciNx0AsEDBsxyZn2gUt
         mlGmgK3tPTl8ZtBD+9BaVQOOZGXKFOAX1gsuup+5Pxpphn6gE+M8U0h654SKSZqP8o
         f0+7xNOK35/rQ==
Received: by mail-ot1-f45.google.com with SMTP id h6-20020a0568300346b02901b71a850ab4so22240391ote.6
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 01:29:28 -0700 (PDT)
X-Gm-Message-State: AOAM5338e/6OxhPzBf/dmUEsI0BaURwANA7xD6I7YiaR1fLd/Ob1wJfP
        F2RyAKUpUfA62Q4AJ+lX/bV66SK2CjlKaQv640w=
X-Google-Smtp-Source: ABdhPJy63uDM7U/cXPe0XOmA1hgDO95OKcW62PlvXUdQW6ScL5ZAc2shBCcq1YoyPOki09FcGf4nAEGkyLtMXgJ6Fjw=
X-Received: by 2002:a9d:12cb:: with SMTP id g69mr2155076otg.77.1616574567849;
 Wed, 24 Mar 2021 01:29:27 -0700 (PDT)
MIME-Version: 1.0
References: <6c819e1944044bfa8f88574beb094ef5@huawei.com>
In-Reply-To: <6c819e1944044bfa8f88574beb094ef5@huawei.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 24 Mar 2021 09:29:16 +0100
X-Gmail-Original-Message-ID: <CAMj1kXH3BPi75h+OfLSr6S24fLD7pN=C=0tNMerXh9tY0whfEQ@mail.gmail.com>
Message-ID: <CAMj1kXH3BPi75h+OfLSr6S24fLD7pN=C=0tNMerXh9tY0whfEQ@mail.gmail.com>
Subject: Re: [question] insert ko failed because count_plts return 0 when
 CONFIG_RANDOMIZE_BASE is not set
To:     "chenjun (AM)" <chenjun102@huawei.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Xiangrui (Euler)" <rui.xiang@huawei.com>,
        liuyanshi <liuyanshi@huawei.com>,
        wuzengkun <wuzengkun@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Mar 2021 at 08:27, chenjun (AM) <chenjun102@huawei.com> wrote:
>
> Hi
>
> I make a Image for arm64 (without CONFIG_RANDOMIZE_BASE). And a ko (13M)
> can not be inserted.
>

How many large modules have you loaded already? The module region is
only 128 MB, so if your modules are huge, you may run out of space.

Please check the kernel VA address and the load address of the module,
and check whether they are more than 128 MB apart.


> WARNING: CPU: 2 PID: 1998 at arch/arm64/kernel/module-plts.c:39
> module_emit_plt_entry+0x100/0x118
> ...
> Call trace:
> module_emit_plt_entry+0x100/0x118
> apply_relocate_add+0x34c/0x570
> ...
>
> I think the problem is that:
> in apply_relocate_add:
>                   case R_AARCH64_CALL26:
>                       ovf = reloc_insn_imm(RELOC_OP_PREL, loc, val, 2, 26,
>                                                AARCH64_INSN_IMM_26);
>
>                       if (IS_ENABLED(CONFIG_ARM64_MODULE_PLTS) &&
>                           ovf == -ERANGE) {
>                               val = module_emit_plt_entry(me, sechdrs,
> loc, &rel[i], sym); realoc_insn_imm return -ERANGE (because the ko is
> too big?)
>
> in module_emit_plt_entry:
> WARN_ON(pltsec->plt_num_entries > pltsec->plt_max_entries)
> pltsec->plt_max_entries is 0 if CONFIG_RANDOMIZE_BASE is not be set.
>
> a257e02 arm64/kernel: don't ban ADRP to work around Cortex-A53 erratum
> #843419
>    static unsigned int count_plts(Elf64_Sym *syms, Elf64_Rela *rela, int
> num,
> -                              Elf64_Word dstidx)
> +                              Elf64_Word dstidx, Elf_Shdr *dstsec)
>    {
> ...
>                   switch (ELF64_R_TYPE(rela[i].r_info)) {
>                   case R_AARCH64_JUMP26:
>                   case R_AARCH64_CALL26:
> +                       if (!IS_ENABLED(CONFIG_RANDOMIZE_BASE))
> +                               break;
> +
>
> Why we need break if !IS_ENABLED(CONFIG_RANDOMIZE_BASE)? or any
> restrictions on ko?
>
> I comment out this part of the code. the ko could be inserted, and seems
> to work well. So is it a accepted way? or any solution for my case?
>
> --
> Regards
> Chen Jun
>
