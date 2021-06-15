Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30E113A7551
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 05:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbhFODnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 23:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbhFODnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 23:43:37 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408FEC061574
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 20:41:34 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id h15so18406900ybm.13
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 20:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t/YamNGP+ckwga9loSudtTcbfG6KNZMYD9dgrRElUEY=;
        b=enOTOgUPsHecPapW0EVbJYb4dNAsLVbTc7It8jRha4hyxFAsCO7rCIN/4hGnR3aOy6
         cDdSp2lR3seoHr8Nm530jsODbJyul5qZA3eXWJULxB0tDVLDU0rRcMN/NU5fTzyXTKKi
         CbDVz2unkihaqMs6J0/IJsj6KxfY3/69d8NACWUTqppeVkJgiIQPKxgi/y2ef7DwZLH5
         2bFxRdEwpnVsgpGE8vQ8NFoACN0C8Sy988+fMrjtSTOBqtiiEqILIPrihaVgJ078w4hq
         vJViARxaY98Ti0OEHm6kRSd0qxzHao4VklA+Vhw2rUCr/0F8wokrccwoyguF+sXBdPm2
         0ZYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t/YamNGP+ckwga9loSudtTcbfG6KNZMYD9dgrRElUEY=;
        b=gWM2St+8g73v6yY4xFvGzVGbX1DdOBVVNHy52xkx8EMC35pT37o6V6kkpz4IiOSvZj
         4LeYGuTl3ZQ/5JsAdfu+Z5cZTprBrve7T+L3/Qn7JKU5U2zUddOWGqFJ0ywjfCkZf81w
         1iGQQg2xG/aXJeDjEslt7rB21tX0on2Re7ZZfVTWMZThrSxEeYhGEdjiMpOQkxD9i1ys
         ADHQkev4ihz6Cvapj782YLT94JRGzgNzQwTj6ksTniw/dfejxAXvIx2MGDuoIh2INylJ
         FOXImb5sb2fCBgbaIvbcgqSrhP/r2ORjDBdY3Ctsjizput+UuRO8tHruuUx3YUAoWicR
         fzvw==
X-Gm-Message-State: AOAM531iVynSQOmbZnVK8n5Ni6dMAxBJFxmYSPWN9uaVxUuR6GiehVLU
        yk8mQAf9VYcTkTSnmPYGVajwMgrAXSlK+G4Hkvo=
X-Google-Smtp-Source: ABdhPJw/GJouabv8wuGtyUdszFLf/gI1rZKiJqk5oAbZvePMYRuZPppJfnLCUIPqqVHUy0xvodHT7ZT/7ifMp2uN3II=
X-Received: by 2002:a25:b8c:: with SMTP id 134mr29650853ybl.332.1623728493419;
 Mon, 14 Jun 2021 20:41:33 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1621516826.git.christophe.leroy@csgroup.eu> <c9a1201dd0a66b4a0f91f0fb46d9385cbf030feb.1621516826.git.christophe.leroy@csgroup.eu>
In-Reply-To: <c9a1201dd0a66b4a0f91f0fb46d9385cbf030feb.1621516826.git.christophe.leroy@csgroup.eu>
From:   Jordan Niethe <jniethe5@gmail.com>
Date:   Tue, 15 Jun 2021 13:41:22 +1000
Message-ID: <CACzsE9qw7CuZdBoSVVUjkcZe6Z8Vzy9iNDVE7E3JLhJER+Z9xw@mail.gmail.com>
Subject: Re: [PATCH v2 05/12] powerpc: Do not dereference code as 'struct
 ppc_inst' (uprobe, code-patching, feature-fixups)
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
> 'struct ppc_inst' is an internal structure to represent an instruction,
> it is not directly the representation of that instruction in text code.
> It is not meant to map and dereference code.
>
> Dereferencing code directly through 'struct ppc_inst' has two main issues:
> - On powerpc, structs are expected to be 8 bytes aligned while code is
> spread every 4 byte.
> - Should a non prefixed instruction lie at the end of the page and the
> following page not be mapped, it would generate a page fault.
>
> In-memory code must be accessed with ppc_inst_read().
>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  arch/powerpc/kernel/uprobes.c     | 2 +-
>  arch/powerpc/lib/code-patching.c  | 8 ++++----
>  arch/powerpc/lib/feature-fixups.c | 2 +-
>  3 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/arch/powerpc/kernel/uprobes.c b/arch/powerpc/kernel/uprobes.c
> index 186f69b11e94..46971bb41d05 100644
> --- a/arch/powerpc/kernel/uprobes.c
> +++ b/arch/powerpc/kernel/uprobes.c
> @@ -42,7 +42,7 @@ int arch_uprobe_analyze_insn(struct arch_uprobe *auprobe,
>                 return -EINVAL;
>
>         if (cpu_has_feature(CPU_FTR_ARCH_31) &&
> -           ppc_inst_prefixed(auprobe->insn) &&
> +           ppc_inst_prefixed(ppc_inst_read(&auprobe->insn)) &&
>             (addr & 0x3f) == 60) {
>                 pr_info_ratelimited("Cannot register a uprobe on 64 byte unaligned prefixed instruction\n");
>                 return -EINVAL;
> diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
> index 870b30d9be2f..0308429b0d1a 100644
> --- a/arch/powerpc/lib/code-patching.c
> +++ b/arch/powerpc/lib/code-patching.c
> @@ -329,13 +329,13 @@ static unsigned long branch_iform_target(const struct ppc_inst *instr)
>  {
>         signed long imm;
>
> -       imm = ppc_inst_val(*instr) & 0x3FFFFFC;
> +       imm = ppc_inst_val(ppc_inst_read(instr)) & 0x3FFFFFC;
>
>         /* If the top bit of the immediate value is set this is negative */
>         if (imm & 0x2000000)
>                 imm -= 0x4000000;
>
> -       if ((ppc_inst_val(*instr) & BRANCH_ABSOLUTE) == 0)
> +       if ((ppc_inst_val(ppc_inst_read(instr)) & BRANCH_ABSOLUTE) == 0)
>                 imm += (unsigned long)instr;
>
>         return (unsigned long)imm;
> @@ -345,13 +345,13 @@ static unsigned long branch_bform_target(const struct ppc_inst *instr)
>  {
>         signed long imm;
>
> -       imm = ppc_inst_val(*instr) & 0xFFFC;
> +       imm = ppc_inst_val(ppc_inst_read(instr)) & 0xFFFC;
>
>         /* If the top bit of the immediate value is set this is negative */
>         if (imm & 0x8000)
>                 imm -= 0x10000;
>
> -       if ((ppc_inst_val(*instr) & BRANCH_ABSOLUTE) == 0)
> +       if ((ppc_inst_val(ppc_inst_read(instr)) & BRANCH_ABSOLUTE) == 0)
>                 imm += (unsigned long)instr;
>
>         return (unsigned long)imm;
> diff --git a/arch/powerpc/lib/feature-fixups.c b/arch/powerpc/lib/feature-fixups.c
> index fe26f2fa0f3f..8905b53109bc 100644
> --- a/arch/powerpc/lib/feature-fixups.c
> +++ b/arch/powerpc/lib/feature-fixups.c
> @@ -51,7 +51,7 @@ static int patch_alt_instruction(struct ppc_inst *src, struct ppc_inst *dest,
>
>         instr = ppc_inst_read(src);
>
> -       if (instr_is_relative_branch(*src)) {
> +       if (instr_is_relative_branch(ppc_inst_read(src))) {
The above variable instr could be used here, but that is not an issue
with this patch.
>                 struct ppc_inst *target = (struct ppc_inst *)branch_target(src);
>
>                 /* Branch within the section doesn't need translating */
> --
> 2.25.0
>
Reviewed by: Jordan Niethe <jniethe5@gmail.com>
