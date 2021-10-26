Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 947BC43BDAF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 01:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240206AbhJZXSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 19:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbhJZXR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 19:17:58 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45754C061570
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 16:15:34 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id nn3-20020a17090b38c300b001a03bb6c4ebso669877pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 16:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:cc;
        bh=2/dPlzQXyUrhPSkM0+tKmxPBQy3NoWlkGO5NrhUnd4c=;
        b=ltzgSzMhRgcu+wB0oxx/kTBf5T9s7Hky/B/l4IU11VJhothOVyQQu6qmdTTGoVHvrP
         QPwlH7g1A95prZ/JTxNmMKxca9YIifD8lz1zTi94ejMJgm0sWUViONTpg+/u+qjv0jn5
         Vg0hrocFAJ3MCx1RZcyko0B+YHswYgRPhAS9opgBlv4G28QL4a9aYMQpM+OL4BShCCW4
         SGVQ1XS7MjFndbc2hsPfitB1MFdn6CW1pbNy7nk2CIZy+Z0HwayfVMvTeMZmbkBTMgNo
         a/eB83zX4itb2jzx6bYoj8WKScAWgEo0dpx9xNlqsBT+TZqFhpT6zvfuHWeiG1jzoUCq
         AKRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:cc;
        bh=2/dPlzQXyUrhPSkM0+tKmxPBQy3NoWlkGO5NrhUnd4c=;
        b=uvuwFdl0Bb2smKIhKfGdvvL+7uGskfnvt5udqwvQTuCqyLE7k4XI1gpm0+UxXa7MPb
         X99ZHdqFIUs9oXCV7bMAKRTMrh6YbLxMkVYZxN6Hii1bkPV1dsIDZ/FND3bi8tgZlOJM
         aYVgntEv2fL2mMMLYyUbNoe5WO9ZdkFLangcZHf16H2WNa38G2nF73EyKVW9j+eVl0O8
         DN6kpcVgNETkiDZCPIh/pewkpQ7LN1LgJTb3o2RjORxa3iWChhqf0y2+06scpfg4ZNRE
         TJtI0en0kMikvoPxfAvgx1J9sun4IgDlTYgh06kOymC0FGBml1f5er4U9/AUarK0LA84
         vjTw==
X-Gm-Message-State: AOAM531Hj/gwUW7dtFFn0UA911n1yOW3fdpqSw9fBtwYSMGfxwXmWVLG
        FbsNxqLHtBXFEDLotVwTRVrvK0MEKO/OPYC8F6E=
X-Received: by 2002:a17:902:848c:b0:13f:e969:3c26 with SMTP id
 c12-20020a170902848c00b0013fe9693c26mt17639390plo.34.1635290133591; Tue, 26
 Oct 2021 16:15:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210920053951.4093668-1-goldstein.w.n@gmail.com> <20211015204713.2855996-1-goldstein.w.n@gmail.com>
In-Reply-To: <20211015204713.2855996-1-goldstein.w.n@gmail.com>
From:   Noah Goldstein <goldstein.w.n@gmail.com>
Date:   Tue, 26 Oct 2021 18:15:22 -0500
Message-ID: <CAFUsyfLte2vkHxe3yt9Srw0RhcANMWK=_cAWrHt2xazM_z5N3w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] x86/fpu: Add helper function for tracking AVX512 status
Cc:     tglx@linutronix.de, mingo@redhat.com,
        Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>,
        hpa@zytor.com, Andy Lutomirski <luto@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2021 at 3:57 PM Noah Goldstein <goldstein.w.n@gmail.com> wrote:
>
> This commit adds a new helper function 'fpu_update_avx_timestamp' to
> perform the logic from tracking AVX512 feature use.
>
> Signed-off-by: Noah Goldstein <goldstein.w.n@gmail.com>
> ---
> Since Borislav Petkov is concerned about adding more macro masks and
> inlining the AVX512 status this patch adds a new helper function. This
> patch does not change the behavior of the current AVX512 status.
>
>  arch/x86/include/asm/fpu/xstate.h |  1 +
>  arch/x86/kernel/fpu/core.c        |  6 ++----
>  arch/x86/kernel/fpu/xstate.c      | 13 +++++++++++++
>  3 files changed, 16 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
> index 109dfcc75299..fe84ac5fb039 100644
> --- a/arch/x86/include/asm/fpu/xstate.h
> +++ b/arch/x86/include/asm/fpu/xstate.h
> @@ -134,6 +134,7 @@ extern u64 xstate_fx_sw_bytes[USER_XSTATE_FX_SW_WORDS];
>  extern void __init update_regset_xstate_info(unsigned int size,
>                                              u64 xstate_mask);
>
> +void fpu_update_avx_timestamp(struct fpu *fpu);
>  void *get_xsave_addr(struct xregs_state *xsave, int xfeature_nr);
>  int xfeature_size(int xfeature_nr);
>  int copy_uabi_from_kernel_to_xstate(struct xregs_state *xsave, const void *kbuf);
> diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
> index 7ada7bd03a32..6dbf3ee642f9 100644
> --- a/arch/x86/kernel/fpu/core.c
> +++ b/arch/x86/kernel/fpu/core.c
> @@ -102,11 +102,9 @@ void save_fpregs_to_fpstate(struct fpu *fpu)
>                 os_xsave(&fpu->state.xsave);
>
>                 /*
> -                * AVX512 state is tracked here because its use is
> -                * known to slow the max clock speed of the core.
> +                * Track of the state of desired avx related xfeatures.
>                  */
> -               if (fpu->state.xsave.header.xfeatures & XFEATURE_MASK_AVX512)
> -                       fpu->avx512_timestamp = jiffies;
> +               fpu_update_avx_timestamp(fpu);
>                 return;
>         }
>
> diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
> index c8def1b7f8fb..00b495914be2 100644
> --- a/arch/x86/kernel/fpu/xstate.c
> +++ b/arch/x86/kernel/fpu/xstate.c
> @@ -1245,6 +1245,19 @@ void xrstors(struct xregs_state *xstate, u64 mask)
>         WARN_ON_ONCE(err);
>  }
>
> +/*
> + * Track of the state of desired avx architecture features.
> + */
> +void fpu_update_avx_timestamp(struct fpu *fpu)
> +{
> +       /*
> +        * AVX512 state is tracked here because its use is known to slow
> +        * the max clock speed of the core.
> +        */
> +       if (fpu->state.xsave.header.xfeatures & XFEATURE_MASK_AVX512)
> +               fpu->avx512_timestamp = jiffies;
> +}
> +
>  #ifdef CONFIG_PROC_PID_ARCH_STATUS
>  /*
>   * Report the amount of time elapsed in millisecond since last AVX512
> --
> 2.25.1
>

Ping.
