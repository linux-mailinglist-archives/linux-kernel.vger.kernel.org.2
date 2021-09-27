Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35D07419DC5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 20:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235888AbhI0SEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 14:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235696AbhI0SEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 14:04:24 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26DB8C061575
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 11:02:46 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id k17so16587823pff.8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 11:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:cc;
        bh=kqA+b8WyryIpFuzgEauZMeFlbAUIee5IxoFNe6qMPlM=;
        b=nFr1Ur+sIEeh9RC7UtVBlpyJ9mfSlsJ+VRMQq5vh8lCxhMLGAT0ACANEtHpwP/uqYR
         hqnGRcZ9vCYeST9c9CyDDSd421BbmY5qmAwUiC8U9xMSZ2vK9QmSTyPRh1xbrbZnk9kg
         aUjtG4KhpyuV69Bmg4JWrAmD27A3Aa5HvP5sr+DuOWEvjoLM+54qxieQ68soxMmnwgC6
         B9wP1LEDsOi4h7G7BVS1T2GhswpIdWpkb38Tk4mAZ9V5a/8sjuiAwYUrkninKoDqI4Sl
         s1csDojCTzy2CemjDWWmmKb87b9tKMsjEj+AS0n8FwQ65AAQu7+t7ZtvDJKwcwSK6nA4
         i5fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:cc;
        bh=kqA+b8WyryIpFuzgEauZMeFlbAUIee5IxoFNe6qMPlM=;
        b=ZJcEdNpZEt3/JRESkW7LM0a89BTRonQg7zpTSRI2u6Y/+dFjsZmNNENNWn6HcRAxYB
         YPh7jSUvpn3kKlI2OHUvhanHv+ENzbIMFf/FmVhrVfYOAEjDWPDzoyFk4Ffpl0tocth1
         ORKqXy491w5hPziZN2Nznl/+sX7DN/Gtw981+Gx/7CjswOD6cTFqWoqTZTGi7ctc+ho2
         bRcYub6Ffhh3M/fVu17FAITaL8S/DdAL5KbsAavqOF1moOoffpCHaSeYw+aIaJ6srXBi
         ycR6FBjKkxm5MmadPPGe+ZZQtl07dWWSqTvXS1MQXLgVhjI7HMhSAcH0IclY9SxueWww
         aLag==
X-Gm-Message-State: AOAM533nctFF9wHI6bYOLVp46LvFuNO3w94I1KCkyNOvhwz9LFddE27H
        2eLWjoNSOIXn6tK6GN9nR7qzZUS+Ro/IjO17t78=
X-Received: by 2002:a62:7f58:0:b0:44b:5ea6:9fb6 with SMTP id
 a85-20020a627f58000000b0044b5ea69fb6mt953120pfd.19.1632765765609; Mon, 27 Sep
 2021 11:02:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210920053951.4093668-1-goldstein.w.n@gmail.com>
In-Reply-To: <20210920053951.4093668-1-goldstein.w.n@gmail.com>
From:   Noah Goldstein <goldstein.w.n@gmail.com>
Date:   Mon, 27 Sep 2021 13:02:34 -0500
Message-ID: <CAFUsyfJWXJEc1879uX_YOJg7cvie0gitv+bu83DiUXiE74uQww@mail.gmail.com>
Subject: Re: [PATCH v1] x86/fpu: Remove opmask state from avx512_timestamp check
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        X86 ML <x86@kernel.org>, hpa@zytor.com,
        Andy Lutomirski <luto@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2021 at 12:40 AM Noah Goldstein <goldstein.w.n@gmail.com> wrote:
>
> This commit creates a new mask, XFEATURE_MASK_ZMM, to test against
> xfeatures for conditionally updating the axx512_timestamp.
>
> Based on the comments, the avx512 state is meant to track when the
> state would cause frequencey throttling. The opmasks (k0-k7) do not
> cause frequency throttling, so they don't make sense to include.
>
> The current implementation, as well as the old, still does have a
> false positive on ymm16-ymm31 and xmm16-31 because
> XFEATURE_MASK_Hi16_ZMM includes them.
>
> Signed-off-by: Noah Goldstein <goldstein.w.n@gmail.com>
> ---
> Issue is reproducible with the following code on x86_64:
>
> ```
>         .global _start
>         .text
> _start:
>         korq    %k0, %k0, %k0
>
> loop:
>         jmp     loop
>
>
>         movl    $60, %eax
>         xorl    %edi, %edi
>         syscall
> ```
>
> Pretending run as executable named "foo":
>
> $> cat /proc/$(pidof foo)/arch_status
>
>
> This should yield -1 as no frequency changing AVX512 instructions
> where used but instead tracks the process.
>
> Note there still is a false positive with ymm16-ymm31 and xmm16-xmm31
> but since there is no state to distinguish between there use and
> zmm16-31 that seems inevitable.
>
>
>  arch/x86/include/asm/fpu/types.h | 2 ++
>  arch/x86/kernel/fpu/core.c       | 4 +++-
>  2 files changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/include/asm/fpu/types.h b/arch/x86/include/asm/fpu/types.h
> index f5a38a5f3ae1..a4816fa7d541 100644
> --- a/arch/x86/include/asm/fpu/types.h
> +++ b/arch/x86/include/asm/fpu/types.h
> @@ -141,6 +141,8 @@ enum xfeature {
>  #define XFEATURE_MASK_AVX512           (XFEATURE_MASK_OPMASK \
>                                          | XFEATURE_MASK_ZMM_Hi256 \
>                                          | XFEATURE_MASK_Hi16_ZMM)
> +#define XFEATURE_MASK_ZMM              (XFEATURE_MASK_ZMM_Hi256 \
> +                                        | XFEATURE_MASK_Hi16_ZMM)
>
>  #define FIRST_EXTENDED_XFEATURE        XFEATURE_YMM
>
> diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
> index 7ada7bd03a32..342620a2e8ef 100644
> --- a/arch/x86/kernel/fpu/core.c
> +++ b/arch/x86/kernel/fpu/core.c
> @@ -104,8 +104,10 @@ void save_fpregs_to_fpstate(struct fpu *fpu)
>                 /*
>                  * AVX512 state is tracked here because its use is
>                  * known to slow the max clock speed of the core.
> +                * Note: This has a false positive on Hi16 ymm and
> +                * xmm registers.
>                  */
> -               if (fpu->state.xsave.header.xfeatures & XFEATURE_MASK_AVX512)
> +               if (fpu->state.xsave.header.xfeatures & XFEATURE_MASK_ZMM)
>                         fpu->avx512_timestamp = jiffies;
>                 return;
>         }
> --
> 2.25.1
>
Ping

(sorry if this has shown up multiple times for anyone,
was accidentally including HTML earlier)
