Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7C96453814
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 17:49:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236603AbhKPQw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 11:52:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233805AbhKPQwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 11:52:24 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A0AC061570
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 08:49:27 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id c4so18773991pfj.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 08:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DcKtBNaNWlF88DbzL7zdkFORAyARs3UmVuV2AcC8jrU=;
        b=LwjJm2fkf4vdAN+0kzRnPMOdfGniTBfcxOJHNWha28XalZV/Ej2XBao7j0kq9+iPxR
         WLiAwpqZ2KpwyVw7k3f6evlUw5NPWM7eHRAxas06QzuW/VF/pCb3vUUCPtOpWVxYkdf/
         3hHnq7zBmOhp+5e4xrSX7fRkjIL8FZQcrD1oIi9K15FDbJQUHiCXg1PzDvjJ7KFF/172
         iSHZAifQAimU5oz4Kr5PD+TWRdUCN2X7HJkQSYr8mN7TPb6LW9zg5k/w72JXHUCzWlqj
         UWAkDXVKPHPae1TnoXggzfUO72gf44celMQs1kAwZknjoYcx3q+YBFnYe/l0015GT3nX
         sgDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DcKtBNaNWlF88DbzL7zdkFORAyARs3UmVuV2AcC8jrU=;
        b=HYyXdBnR5C8gZn8TFpNPnrNYk2pz1fJG4UPI57/RXf5WrM+6CAqHE7eLQ081gWkIEV
         yzbFbj9Pmi/UzsUG1Ekef59mYLkgKp6LmUlr0PWn6AioIH1aiox1OMUaLFsYY3YrGd86
         Aw/7kHVqs+QhPe3eQxH4Gfm7XIp95uVERWJ5ThGG56lJAw9nVMVq+3xyyLptKWB02H65
         5ESXPSq7fYPfpng+VgHRzDEOEOG9wYVRR4my8HhVoBuhj9hrsMvJG0GJzZ5hbQ4gh6Xr
         GuquHaTxe3CAj/yKMqOdYOVjw0+LsiZ7rYBOtt0sK5Xg0Wjd4qxL+fbVpPuUuVpKg4rA
         GbeQ==
X-Gm-Message-State: AOAM5324GmpKEvxMwEn08lHJfQnoEKn7ffGJm1hgS7xtyTyuMSOF3WrL
        0Qo/WAvLy17FTvz7qI9iWbidzE+bUafxabe9zU4=
X-Google-Smtp-Source: ABdhPJwXeuoKCBGgIqAL1sIu+6bBuPTsijrFdVzykxcwVEkX/UvEgB7mFXaeMWA09/cmSjAsBUqQZikZYFbi2EXjqXI=
X-Received: by 2002:a62:8c55:0:b0:49f:df22:c4ca with SMTP id
 m82-20020a628c55000000b0049fdf22c4camr41817366pfd.11.1637081367477; Tue, 16
 Nov 2021 08:49:27 -0800 (PST)
MIME-Version: 1.0
References: <20210920053951.4093668-1-goldstein.w.n@gmail.com>
 <20211027182103.2569136-1-goldstein.w.n@gmail.com> <20211027182103.2569136-2-goldstein.w.n@gmail.com>
 <YZPakmnn75rCvUMo@zn.tnic>
In-Reply-To: <YZPakmnn75rCvUMo@zn.tnic>
From:   Noah Goldstein <goldstein.w.n@gmail.com>
Date:   Tue, 16 Nov 2021 10:49:16 -0600
Message-ID: <CAFUsyfJ6=pXN7Wv9eXhTw4AYDOWTdjXwjRev_pNOinQxK6LRJA@mail.gmail.com>
Subject: Re: [PATCH] x86/fpu: Correct AVX512 state tracking
To:     Borislav Petkov <bp@alien8.de>
Cc:     tglx@linutronix.de, mingo@redhat.com, X86 ML <x86@kernel.org>,
        hpa@zytor.com, Andy Lutomirski <luto@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16, 2021 at 10:21 AM Borislav Petkov <bp@alien8.de> wrote:
>
> Does that still work with your test case? (Ontop of -rc1)

This should work.

>
> ---
> From: Noah Goldstein <goldstein.w.n@gmail.com>
> Date: Tue, 16 Nov 2021 17:14:21 +0100
> Subject: [PATCH] x86/fpu: Correct AVX512 state tracking
>
> Add a separate, local mask for tracking AVX512 usage which does not
> include the opmask xfeature set. Opmask registers usage does not cause
> frequency throttling so it is a completely unnecessary false positive.
>
> While at it, carve it out into a separate function to keep that
> abomination extracted out.
>
>  [ bp: Rediff and cleanup ontop of 5.16-rc1. ]
>
> Signed-off-by: Noah Goldstein <goldstein.w.n@gmail.com>
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Link: https://lore.kernel.org/r/20210920053951.4093668-1-goldstein.w.n@gmail.com
> ---
>  arch/x86/kernel/fpu/core.c | 21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
>
> diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
> index 8ea306b1bf8e..dd3777ac0443 100644
> --- a/arch/x86/kernel/fpu/core.c
> +++ b/arch/x86/kernel/fpu/core.c
> @@ -98,6 +98,19 @@ bool irq_fpu_usable(void)
>  }
>  EXPORT_SYMBOL(irq_fpu_usable);
>
> +/*
> + * Track AVX512 state use because it is known to slow the max clock
> + * speed of the core.
> + */
> +static void update_avx_timestamp(struct fpu *fpu)
> +{
> +
> +#define AVX512_TRACKING_MASK   (XFEATURE_MASK_ZMM_Hi256 | XFEATURE_MASK_Hi16_ZMM)
> +
> +       if (fpu->fpstate->regs.xsave.header.xfeatures & AVX512_TRACKING_MASK)
> +               fpu->avx512_timestamp = jiffies;
> +}
> +
>  /*
>   * Save the FPU register state in fpu->fpstate->regs. The register state is
>   * preserved.
> @@ -116,13 +129,7 @@ void save_fpregs_to_fpstate(struct fpu *fpu)
>  {
>         if (likely(use_xsave())) {
>                 os_xsave(fpu->fpstate);
> -
> -               /*
> -                * AVX512 state is tracked here because its use is
> -                * known to slow the max clock speed of the core.
> -                */
> -               if (fpu->fpstate->regs.xsave.header.xfeatures & XFEATURE_MASK_AVX512)
> -                       fpu->avx512_timestamp = jiffies;
> +               update_avx_timestamp(fpu);
>                 return;
>         }
>
> --
> 2.29.2
>
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
