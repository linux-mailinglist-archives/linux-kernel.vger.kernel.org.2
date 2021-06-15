Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D08B23A7554
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 05:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbhFODoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 23:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbhFODoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 23:44:21 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4B88C061574
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 20:42:15 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id i4so18516685ybe.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 20:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hSm4lDQmvuYcNCJIDeoEyVLYEDl2O+na4iPfgEBo8es=;
        b=b8g4K1XKnGa0I4a6RVUeAajfdq3ihZvzQ2SFupYVUvkuetR6V7C/ZsVH3wtc3n6GNS
         UAdJ8hO/Dy2tB4L77mF7tvHUV/nJDLI38kqk+bfYwMtAhwR0uEf9FI2E4adb5WeLpWoF
         oeXcvhfIXyuCgTgcJA7YyHoEDfaDrROGxTitG23AflJ/JjcbBh3y1wxPXFvKVX9/luxD
         /tG3zci1NYk23GcE1IvM/hZqQv/llEKN4fo+0iQO5Ia7qTdLTjO4XWOuW5Q3nBF/YErc
         +BUZBYAWZY3uQxo2PM7sxDSvuChRPzpW6/Mmol9HB/2wEfEquYaY4Pp6xc4IkeWMejA8
         xGZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hSm4lDQmvuYcNCJIDeoEyVLYEDl2O+na4iPfgEBo8es=;
        b=OAOj/b7NN7LNnTQ7PHLg74TJgXaXQa3RE5d1lI4NVEDCXruCCec/N4lyvRsP5/YdMr
         IxZfL8eNpVc8HoY+8s+HuUl80zOIvgy+oV7dZdXMJsYHreJu0CR2G6Ur+S9Uljj9Ttxp
         8hI5Irrx+N9Wf7fo1i4u+196ypP99mM4FCi+wQ9Tz6ZDUB9F9JRlAB/NNvNUsTUtjSTz
         m6IzwO8af2JOrWY2GMT2gyUdAK8WE/zPhoL6UHjPD5sRM3/IAkFs+gjR8WLRtK85rlxn
         KbHYRxzW5fbfL6EiuQGhPzvDOnLChIMjTserujfBB13XjJJZ8biInvFe3mDP0xQhD9RY
         JOKQ==
X-Gm-Message-State: AOAM532Kg+tVoQNUkftHjkzNuvqsVMeKeGe8Vj6u9SKMSD8udmb/EC38
        ygsYDLa9yNDNat7xyFl9yOJtfNKukBQS94yu9x8=
X-Google-Smtp-Source: ABdhPJyJlaazuVTiHhxwPWGRiL+TnZD0tSp1fyqD2f0GyTEVhJqpni/fKv1dqGASeqvgTr2Ftb0zhSeJodqBbHPL7zw=
X-Received: by 2002:a25:69ce:: with SMTP id e197mr27366126ybc.265.1623728534967;
 Mon, 14 Jun 2021 20:42:14 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1621516826.git.christophe.leroy@csgroup.eu> <5f6b9c8c83170ed310953eac2f5b14539bfc964a.1621516826.git.christophe.leroy@csgroup.eu>
In-Reply-To: <5f6b9c8c83170ed310953eac2f5b14539bfc964a.1621516826.git.christophe.leroy@csgroup.eu>
From:   Jordan Niethe <jniethe5@gmail.com>
Date:   Tue, 15 Jun 2021 13:42:03 +1000
Message-ID: <CACzsE9o+nuDEPk9ENig8_aAbLYLmpoWP8_JZKJWX=AqfOV2ODg@mail.gmail.com>
Subject: Re: [PATCH v2 06/12] powerpc/lib/code-patching: Make
 instr_is_branch_to_addr() static
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2021 at 11:50 PM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
> instr_is_branch_to_addr() is only used in code-patching.c
>
> Make it static.
>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  arch/powerpc/include/asm/code-patching.h |  1 -
>  arch/powerpc/lib/code-patching.c         | 18 +++++++++---------
>  2 files changed, 9 insertions(+), 10 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/code-patching.h b/arch/powerpc/include/asm/code-patching.h
> index f1d029bf906e..f9bd1397b696 100644
> --- a/arch/powerpc/include/asm/code-patching.h
> +++ b/arch/powerpc/include/asm/code-patching.h
> @@ -59,7 +59,6 @@ static inline int modify_instruction_site(s32 *site, unsigned int clr, unsigned
>
>  int instr_is_relative_branch(struct ppc_inst instr);
>  int instr_is_relative_link_branch(struct ppc_inst instr);
> -int instr_is_branch_to_addr(const struct ppc_inst *instr, unsigned long addr);
>  unsigned long branch_target(const struct ppc_inst *instr);
>  int translate_branch(struct ppc_inst *instr, const struct ppc_inst *dest,
>                      const struct ppc_inst *src);
> diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
> index 0308429b0d1a..82f2c1edb498 100644
> --- a/arch/powerpc/lib/code-patching.c
> +++ b/arch/powerpc/lib/code-patching.c
> @@ -367,15 +367,6 @@ unsigned long branch_target(const struct ppc_inst *instr)
>         return 0;
>  }
>
> -int instr_is_branch_to_addr(const struct ppc_inst *instr, unsigned long addr)
> -{
> -       if (instr_is_branch_iform(ppc_inst_read(instr)) ||
> -           instr_is_branch_bform(ppc_inst_read(instr)))
> -               return branch_target(instr) == addr;
> -
> -       return 0;
> -}
> -
>  int translate_branch(struct ppc_inst *instr, const struct ppc_inst *dest,
>                      const struct ppc_inst *src)
>  {
> @@ -410,6 +401,15 @@ void __patch_exception(int exc, unsigned long addr)
>
>  #ifdef CONFIG_CODE_PATCHING_SELFTEST
>
> +static int instr_is_branch_to_addr(const struct ppc_inst *instr, unsigned long addr)
> +{
> +       if (instr_is_branch_iform(ppc_inst_read(instr)) ||
> +           instr_is_branch_bform(ppc_inst_read(instr)))
> +               return branch_target(instr) == addr;
> +
> +       return 0;
> +}
> +
>  static void __init test_trampoline(void)
>  {
>         asm ("nop;\n");
> --
> 2.25.0
>
Reviewed by: Jordan Niethe <jniethe5@gmail.com>
