Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E66B42CAB6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 22:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239096AbhJMUOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 16:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236302AbhJMUOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 16:14:02 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CFADC061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 13:11:58 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id x27so17099460lfu.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 13:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eTnL5kNpHunSoH20hdsr5IOYGrMPB41KKgAoQoY3zuI=;
        b=MQhlfteEnWjVjWjOHOuy0NnGGHr6nufVPwI24OBAERHQITRaLKGcAua02cSG8Te9+i
         qUxWvDNiMl1Fl8afGUmOu63cf0DlJBCUqBoFrmrkAAQ6x22QLrXn5rby8g+mZKNbkKIq
         0ryWAAfhcsRE+9zo2niQbNt2063xntPcOZNWtwa60v+U9/AiMbcCwD9BqGUzsA/4xgYi
         dUJqpkpjSF0Jbk/RQ6cl9iwenNxiIniHMHni1lAj3TVz+NjkVXgmWRRHsOgrrkkUtaFv
         ZkkkIXTSyILah5NaLqYqYvsIUpoyJ+Sv6jfEkxRuDhsanCXMuUBwdhzMzBnVfmed7qkh
         EZ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eTnL5kNpHunSoH20hdsr5IOYGrMPB41KKgAoQoY3zuI=;
        b=SpVqsmgsIGdMV10YwuutOLx2vzbcdA6m5CqfxiB8NTnDAijYabHSn0oh6SByNO1dbj
         ApjKkL7qgO9KCKq7np09kePwKw4ZVa9qkuTVXJiV++nvNykeIRgnHe9oZPx07LJ20JJX
         13mAHQAa0YB3eFWDd6dFhXTNvq+eaeIVjhBzo91zMzWuA+keu6Qd9lGH+HsSeTtXQy8D
         WpcEMDssxm+Qi6cd14Wvo2f1bFtSy/Rway+so9aa/tPlbUpKmKtWEYDT4/7PdyIHdCtM
         ex2jRtXfNxXnzHtj1NPYQ3DuBMi40CQ0bCtxfXtdbXyYCCce+wavhFdNxBbq2WIvoN2r
         WHXg==
X-Gm-Message-State: AOAM530Kybox6AWOOptkmF1zJP9De/W9AptFjWq/gQQ0GMu/CyG2mtfO
        S/sDC4p7WBZlv4IcNHbnumdT/CwHVs6f2nEZUwRSKLFMww90eg==
X-Google-Smtp-Source: ABdhPJw5KzKgdLCPfSyjlf4rWFXZ4VuxWJfrG5u3EefAaZAL6aFkHAR2YfTWw9wo9nTJLw9ngVCyTGDCQj9rL+Gcr0k=
X-Received: by 2002:a05:651c:1108:: with SMTP id d8mr1554950ljo.220.1634155916648;
 Wed, 13 Oct 2021 13:11:56 -0700 (PDT)
MIME-Version: 1.0
References: <20211013122217.304265366@infradead.org> <20211013123645.119101107@infradead.org>
In-Reply-To: <20211013123645.119101107@infradead.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 13 Oct 2021 13:11:45 -0700
Message-ID: <CAKwvOd=4s70S9irWGV94u2AoyQyo67XZ9tU12cdhf=6879gA+w@mail.gmail.com>
Subject: Re: [PATCH 5/9] x86/alternative: Handle Jcc __x86_indirect_thunk_\reg
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, jpoimboe@redhat.com, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, alexei.starovoitov@gmail.com,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 5:41 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Handle the rare cases where the compiler (clang) does an indirect
> conditional tail-call using:
>
>   Jcc __x86_indirect_thunk_\reg

`Jcc.d32 __x86_indirect_thunk_\reg` might be clearer; otherwise
putting that in an assembler and assembling/disassembling produces the
2B instructions, which makes the below patch confusing. Ah, it is
stated in the comment added below.

>
> For the !RETPOLINE case this can be rewritten to fit the original (6
> byte) instruction like:
>
>   Jncc.d8       1f
>   JMP           *%\reg
>   NOP
> 1:
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/kernel/alternative.c |   38 ++++++++++++++++++++++++++++++++++----
>  1 file changed, 34 insertions(+), 4 deletions(-)
>
> --- a/arch/x86/kernel/alternative.c
> +++ b/arch/x86/kernel/alternative.c
> @@ -378,7 +378,8 @@ static int emit_indirect(int op, int reg
>  static int patch_retpoline(void *addr, struct insn *insn, u8 *bytes)
>  {
>         void (*target)(void);
> -       int reg, i = 0;
> +       int reg, ret, i = 0;
> +       u8 op, cc;
>
>         if (cpu_feature_enabled(X86_FEATURE_RETPOLINE))
>                 return -1;
> @@ -390,9 +391,34 @@ static int patch_retpoline(void *addr, s
>         if (WARN_ON_ONCE(reg & ~0xf))
>                 return -1;
>
> -       i = emit_indirect(insn->opcode.bytes[0], reg, bytes);
> -       if (i < 0)
> -               return i;
> +       op = insn->opcode.bytes[0];
> +
> +       /*
> +        * Convert:
> +        *
> +        *   Jcc.d32 __x86_indirect_thunk_\reg
> +        *
> +        * into:
> +        *
> +        *   Jncc.d8 1f
> +        *   jmp *%\reg
> +        *   nop
> +        * 1:
> +        */
> +       if (op == 0x0f && (insn->opcode.bytes[1] & 0xf0) == 0x80) {
> +               cc = insn->opcode.bytes[1] & 0xf;
> +               cc ^= 1; /* invert condition */
> +
> +               bytes[i++] = 0x70 + cc; /* Jcc.d8 */
> +               bytes[i++] = insn->length - 2;

Isn't `insn->length - 2` always 4 (in this case)? We could avoid
computing that at runtime I suspect if we just hardcoded it.

Either way, I've looked at the disassembly enough that this LGTM.
Thanks for the patch.

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> +
> +               op = JMP32_INSN_OPCODE;
> +       }
> +
> +       ret = emit_indirect(op, reg, bytes + i);
> +       if (ret < 0)
> +               return ret;
> +       i += ret;
>
>         for (; i < insn->length;)
>                 bytes[i++] = BYTES_NOP1;
> @@ -423,6 +449,10 @@ void __init_or_module noinline apply_ret
>                 case JMP32_INSN_OPCODE:
>                         break;
>
> +               case 0x0f: /* escape */
> +                       if (op2 >= 0x80 && op2 <= 0x8f)
> +                               break;
> +                       fallthrough;
>                 default:
>                         WARN_ON_ONCE(1);
>                         continue;
>
>


-- 
Thanks,
~Nick Desaulniers
