Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64ECE318C9A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 14:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232201AbhBKNuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 08:50:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:35568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231912AbhBKNgD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 08:36:03 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3B29164E95
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 13:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613050520;
        bh=rTiqbGm61u+Ivnr3xRKwut6NNnHVY3C/fRPscsmypyY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Su/T1oN8vczZIJGjXYaGJFiOFZMBkeXo2R6SLYQYX8MD9hCMwPzNwjmGnz3DlYCyE
         USM9Nnm1lAXeEeidW1efu1P6RLhNVUo71IdOf5opk0MCnlKFkTOTaa4WNniNMRBcHO
         HU2Eq2q79zFQ2KRJBKPVhWL440CA9/tV4vqFJ7GO591O48bPfsiF2MfTaKGXnhgt16
         WhN7ucWnBs93kHFRrWqFv6CCf1jmBuwpFoscBUayOLnuJVqNPoJ/tBabyyaLsDJJZF
         R2lAXcPpm0DmjdjWBoQgGI9SNe/fUQDN4fwFA/OWdzqkJAOh6dgRzDf5gSDeWmTqkP
         99dYtZiBJT13A==
Received: by mail-ot1-f42.google.com with SMTP id o12so5083786ote.12
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 05:35:20 -0800 (PST)
X-Gm-Message-State: AOAM533mznIKNPrenwfTq6Bwkz3c9eFGBcEgxBiVMCdwzLir9vSQmjJo
        9JIkOye9Wgs0aXAAjI7rg1r5NQ8SCBoZWZpcBek=
X-Google-Smtp-Source: ABdhPJxeVig17JlRjMwO/9Ofoer9NvF2kKtNDK0T936SvJbFKJ05bIvbrM7pJkWWw8tXsWhluEon/UXYhgR+n2ISi8o=
X-Received: by 2002:a05:6830:1285:: with SMTP id z5mr5686918otp.90.1613050519509;
 Thu, 11 Feb 2021 05:35:19 -0800 (PST)
MIME-Version: 1.0
References: <20210211125602.44248-1-vincenzo.frascino@arm.com>
In-Reply-To: <20210211125602.44248-1-vincenzo.frascino@arm.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 11 Feb 2021 14:35:08 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHED=O4uXzRAKiD8kE1Vb3Dr=oU-shLQ8UBBDn2N-1nuA@mail.gmail.com>
Message-ID: <CAMj1kXHED=O4uXzRAKiD8kE1Vb3Dr=oU-shLQ8UBBDn2N-1nuA@mail.gmail.com>
Subject: Re: [PATCH] arm64: Fix warning in mte_get_random_tag()
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Feb 2021 at 13:57, Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
>
> The simplification of mte_get_random_tag() caused the introduction of the
> warning below:
>
> In file included from arch/arm64/include/asm/kasan.h:9,
>                  from include/linux/kasan.h:16,
>                  from mm/kasan/common.c:14:
> mm/kasan/common.c: In function =E2=80=98mte_get_random_tag=E2=80=99:
> arch/arm64/include/asm/mte-kasan.h:45:9: warning: =E2=80=98addr=E2=80=99 =
is used
>                                          uninitialized [-Wuninitialized]
>    45 |         asm(__MTE_PREAMBLE "irg %0, %0"
>       |
>
> Fix the warning initializing the address to NULL.
>
> Note: mte_get_random_tag() returns a tag and it never dereferences the ad=
dress,
> hence 'addr' can be safely initialized to NULL.
>
> Fixes: c8f8de4c0887 ("arm64: kasan: simplify and inline MTE functions")
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Andrey Konovalov <andreyknvl@google.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
>
> This patch is based on linux-next/akpm
>
>  arch/arm64/include/asm/mte-kasan.h | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/include/asm/mte-kasan.h b/arch/arm64/include/asm/=
mte-kasan.h
> index 3d58489228c0..b2850b750726 100644
> --- a/arch/arm64/include/asm/mte-kasan.h
> +++ b/arch/arm64/include/asm/mte-kasan.h
> @@ -40,7 +40,12 @@ static inline u8 mte_get_mem_tag(void *addr)
>  /* Generate a random tag. */
>  static inline u8 mte_get_random_tag(void)
>  {
> -       void *addr;
> +       /*
> +        * mte_get_random_tag() returns a tag and it
> +        * never dereferences the address, hence addr
> +        * can be safely initialized to NULL.
> +        */
> +       void *addr =3D NULL;
>
>         asm(__MTE_PREAMBLE "irg %0, %0"
>                 : "+r" (addr));
> --
> 2.30.0
>

Might it be better to simply change the asm constraint to "=3Dr" ?
