Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E47303F6EAC
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 07:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbhHYFED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 01:04:03 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:18821 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbhHYFEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 01:04:02 -0400
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 17P52n98028375
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 14:02:50 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 17P52n98028375
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1629867770;
        bh=6C4sQo9dtpPkDe/kpNCwYcQCmRxzrS3oEeKpZzUkbOU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=zMjDwrFrRnemkWRRTO9atXbYCyT+SyaKiugU5QFtLQ2skCFoca00Rapsk02Jo8myG
         VOZ/ZftcPdOrXaFTL8fgnR5BH96VEaiqiOs7NzhLky2hulW9M5H+y/YvcQRYFNcY3F
         nujhBG+pEbnU1eCQLWofEJt5wYG2D6V18d8hHhgkguXtbUkbK7bQ/VlQGPqry5df9o
         9NanDltJ+kHWJVyZFmk6s8DCo32HMfEH12b5RDIUgAIeQXODkFPPF8zYtte+pkYC9/
         hCUiYNbx73JtoETATW2tdQh76HnKdTXnXu7nZzoLqlSFzeAb45tRvjBspuvvRNDUyw
         DdSWMggE4ft/w==
X-Nifty-SrcIP: [209.85.215.181]
Received: by mail-pg1-f181.google.com with SMTP id k24so21909250pgh.8
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 22:02:50 -0700 (PDT)
X-Gm-Message-State: AOAM532e/xLR9EPJh0vG8/EAStovcvDYnUSMeofmrPz8U4p3WXU6Wt7r
        1iqKxG60CuX8ro8yAYUakWvAOQ97nUZUFrjBtPA=
X-Google-Smtp-Source: ABdhPJzt1x1E4uLTBw30Hb1c97PdFbGJtPwUvsycM+DGy/CX74V3moOyXdsPTFwL7v4TswLIh2QnTKq+sP76+mTCtQw=
X-Received: by 2002:aa7:98da:0:b029:3e0:8b98:df83 with SMTP id
 e26-20020aa798da0000b02903e08b98df83mr42835714pfm.63.1629867769373; Tue, 24
 Aug 2021 22:02:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210729140023.442101-1-masahiroy@kernel.org>
In-Reply-To: <20210729140023.442101-1-masahiroy@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 25 Aug 2021 14:02:12 +0900
X-Gmail-Original-Message-ID: <CAK7LNASoPDMeaNr2MTEOHkRNF1ttNmiRqkukdud6wooOFHEW+g@mail.gmail.com>
Message-ID: <CAK7LNASoPDMeaNr2MTEOHkRNF1ttNmiRqkukdud6wooOFHEW+g@mail.gmail.com>
Subject: Re: [PATCH 1/2] x86/build: remove the left-over bzlilo target
To:     X86 ML <x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     "H . Peter Anvin" <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 29, 2021 at 11:00 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Commit f279b49f13bd ("x86/boot: Modernize genimage script; hdimage+EFI
> support") remove the 'bzlilo' target from arch/x86/boot/Makefile.
>
> Remove the left-over from arch/x86/Makefile.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---

Hello x86 maintainers.

Can you pick up these trivial cleanups?




>
>  arch/x86/Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/Makefile b/arch/x86/Makefile
> index 0fa7dc73b5d8..4f784d9ac925 100644
> --- a/arch/x86/Makefile
> +++ b/arch/x86/Makefile
> @@ -275,8 +275,8 @@ endif
>  $(BOOT_TARGETS): vmlinux
>         $(Q)$(MAKE) $(build)=$(boot) $@
>
> -PHONY += install bzlilo
> -install bzlilo:
> +PHONY += install
> +install:
>         $(Q)$(MAKE) $(build)=$(boot) $@
>
>  PHONY += vdso_install
> --
> 2.27.0
>


-- 
Best Regards
Masahiro Yamada
