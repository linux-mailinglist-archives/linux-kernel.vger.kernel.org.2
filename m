Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1646A3807C4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 12:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbhENKzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 06:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbhENKzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 06:55:36 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0CFAC061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 03:54:24 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id v22so23217800oic.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 03:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=19+6o3O/hPf0SMu1IJyh2NJXMIWlR4MKseltzsIotXU=;
        b=EgU769fqyzATqlSnLY5ku6xf+VKKYLbQqzvSARt0lQYra3enTK1/+cqYL+MW1l5K47
         7mUf1oMPWFF8nklSPkdv5saGpEDBteZ9c7Ah42KuBcuLPI4ylPynRc8wroOvh++yBXud
         xDJzRWoIvtNwcaYRi3BVuaDI+p1R0nXY2bIvx9cxQTtZHNDdFFwEYYVL3jMnBfGP10vP
         mftJRkeTn/E70GZBhY+QAhvPwLigGOAc8t1DU6+Jb6BxFaYL3Hf6XkkovvJpg+dPFW5w
         V3vupXVJMYxCshNK1XSh4gsa7f6/MPlE0QHxFLbjzcVCmSi9AiT6lnVyAq6doDFEFahL
         6MdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=19+6o3O/hPf0SMu1IJyh2NJXMIWlR4MKseltzsIotXU=;
        b=n4/3CCcAHLT4E3ZdfEUcbYX6bLiN97bWR7gaz2q8P18u6NJCrKybt/AbzZurMkTvWC
         IxFNLNxBMMde3q4ngHzL1cJ4DDXqfgqDi/xbgMVQzc1FhLkNrnVBN9SLi6wFmvWu8qSH
         vtRRQlu7zqbm6X4Nje8jdARN1gDEX6yNngjPlLlenB2ESZzzzt+FBmx4sWlnLoUiVQ5L
         U/lqWwposVkJ2aVNqYu7iHABosfqVeU7KHVviTmlmf9Z85eF6bg2SUig+pXDN9Qn1G7l
         n6HzYrg6LF/uqaQsRwjC+XXQ7KXP913W8dK+prodYnQlYPTIdr9G84vR7SicRK630ReB
         6tug==
X-Gm-Message-State: AOAM530cXqJ3rdkbkXosoNaOkdWRiplifECtwRf6B3LK0qIw9vCgFm2h
        Kc3RywmT37irasetar5ntjoaPxXSBsHAwxt/rr5tyWvc4Fc=
X-Google-Smtp-Source: ABdhPJzEld2VXr88ppdtAYgcr8j3hYxHUIsTctRtLkil/6RBGyBVEdFTHSaFdqfBGNxtIwZuxkT2x1h1RqIqIrnbqi0=
X-Received: by 2002:aca:408a:: with SMTP id n132mr34053651oia.70.1620989663822;
 Fri, 14 May 2021 03:54:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210514092139.3225509-1-svens@linux.ibm.com> <20210514092139.3225509-2-svens@linux.ibm.com>
In-Reply-To: <20210514092139.3225509-2-svens@linux.ibm.com>
From:   Marco Elver <elver@google.com>
Date:   Fri, 14 May 2021 12:54:11 +0200
Message-ID: <CANpmjNNB=KTDBb65qtNwrPbwnbD2ThAFchA1HSCg9HKETkQvCg@mail.gmail.com>
Subject: Re: [PATCH 1/2] kfence: add function to mask address bits
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for trying to get KFENCE on s390.

On Fri, 14 May 2021 at 11:22, Sven Schnelle <svens@linux.ibm.com> wrote:
>
> s390 only reports the page address during a translation fault.
> To make the kfence unit tests pass, add a function that might
> be implemented by architectures to mask out address bits.

The point of the test is to test the expected behaviour. And s390
certainly isn't behaving as we'd expect, because we really ought to
see the precise address to facilitate debugging. Granted, by default
KFENCE prints hashed pointers, but with no_hash_pointers we still want
to see the precise address.

Is there any way to make s390 give us precise addresses?

Of course if you say this deviation is reasonable, see my suggestions below.

> Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
> ---
>  include/linux/kfence.h  | 1 +
>  mm/kfence/core.c        | 5 +++++
>  mm/kfence/kfence_test.c | 6 +++++-
>  3 files changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/kfence.h b/include/linux/kfence.h
> index a70d1ea03532..2e15f4c4ee95 100644
> --- a/include/linux/kfence.h
> +++ b/include/linux/kfence.h
> @@ -199,6 +199,7 @@ static __always_inline __must_check bool kfence_free(void *addr)
>   * present, so that the kernel can proceed.
>   */
>  bool __must_check kfence_handle_page_fault(unsigned long addr, bool is_write, struct pt_regs *regs);
> +unsigned long kfence_arch_mask_addr(unsigned long addr);

I think this should not be part of the public interface, as commented below.

>  #else /* CONFIG_KFENCE */
>
> diff --git a/mm/kfence/core.c b/mm/kfence/core.c
> index e18fbbd5d9b4..bc15e3cb71d5 100644
> --- a/mm/kfence/core.c
> +++ b/mm/kfence/core.c
> @@ -50,6 +50,11 @@ static unsigned long kfence_sample_interval __read_mostly = CONFIG_KFENCE_SAMPLE
>  #endif
>  #define MODULE_PARAM_PREFIX "kfence."
>
> +unsigned long __weak kfence_arch_mask_addr(unsigned long addr)
> +{
> +       return addr;
> +}

I don't think this belongs here, because it's test-specific,
furthermore if possible we'd like to put all arch-specific code into
<asm/kfence.h> (whether or not your arch will have 'static inline'
functions only, like x86 and arm64, or not is up to you).

Because I don't see this function being terribly complex, also let's
just make it a macro.

Then in kfence_test.c, we can have:

#ifndef kfence_test_mask_address
#define kfence_test_mask_address(addr) (addr)
#endif

and then have it include <asm/kfence.h>. And in your <asm/kfence.h>
you can simply say:

#define kfence_test_mask_address(addr) (.........)

It also avoids having to export kfence_test_mask_address, because
kfence_test can be built as a module.

>  static int param_set_sample_interval(const char *val, const struct kernel_param *kp)
>  {
>         unsigned long num;
> diff --git a/mm/kfence/kfence_test.c b/mm/kfence/kfence_test.c
> index 4acf4251ee04..9ec572991014 100644
> --- a/mm/kfence/kfence_test.c
> +++ b/mm/kfence/kfence_test.c
> @@ -82,6 +82,7 @@ static const char *get_access_type(const struct expect_report *r)
>  /* Check observed report matches information in @r. */
>  static bool report_matches(const struct expect_report *r)
>  {
> +       unsigned long addr = (unsigned long)r->addr;
>         bool ret = false;
>         unsigned long flags;
>         typeof(observed.lines) expect;
> @@ -131,22 +132,25 @@ static bool report_matches(const struct expect_report *r)
>         switch (r->type) {
>         case KFENCE_ERROR_OOB:
>                 cur += scnprintf(cur, end - cur, "Out-of-bounds %s at", get_access_type(r));
> +               addr = kfence_arch_mask_addr(addr);
>                 break;
>         case KFENCE_ERROR_UAF:
>                 cur += scnprintf(cur, end - cur, "Use-after-free %s at", get_access_type(r));
> +               addr = kfence_arch_mask_addr(addr);
>                 break;
>         case KFENCE_ERROR_CORRUPTION:
>                 cur += scnprintf(cur, end - cur, "Corrupted memory at");
>                 break;
>         case KFENCE_ERROR_INVALID:
>                 cur += scnprintf(cur, end - cur, "Invalid %s at", get_access_type(r));
> +               addr = kfence_arch_mask_addr(addr);
>                 break;
>         case KFENCE_ERROR_INVALID_FREE:
>                 cur += scnprintf(cur, end - cur, "Invalid free of");
>                 break;
>         }
>
> -       cur += scnprintf(cur, end - cur, " 0x%p", (void *)r->addr);
> +       cur += scnprintf(cur, end - cur, " 0x%p", (void *)addr);

The rest here looks reasonable if you think there's no way to get s390
to give us precise addresses.

Thanks,
-- Marco
