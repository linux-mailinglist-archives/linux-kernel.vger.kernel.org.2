Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FBFE4099D1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 18:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239169AbhIMQrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 12:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239107AbhIMQrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 12:47:20 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F23FC061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 09:46:04 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id i25so18446095lfg.6
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 09:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4AWqq8PdF0T27j1u4r8SJdSDQAmnIa798/DXEHvOpSI=;
        b=FU+bAjJMm7Th8TwF7GGVELgB1n/Ftr6IutqHVydD9w8PX1GQcf6GzsLJOqGGh6CW0l
         EgHYwD/xUZZOVDsGOol3BaZ8xHn83V7/OXyGzkFbGAGnI2UYFevtlAxVK0miRIcA5sma
         7ChEqHKPnv+jjr4rq9563XtC1/WAT8qcu+Bu7KgwmwaedbS/lr08mFRMX8yVsveRl3dO
         fkLTwlz3V17XMGEE2CT1WMP4SCJwRxX6N5cqDDMKSzUVH2QVfP4XIwCjwyqgdH3MERlO
         vZR1EV6lwCy9I9JF6m4YNjNRIsj/BeIG+3ZUtcKRVlTuJJG9gt3JEr6a+crt5Rin8pfL
         MU5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4AWqq8PdF0T27j1u4r8SJdSDQAmnIa798/DXEHvOpSI=;
        b=fb+lrw89tZpSU1l266W5gBJIn02njl/KXedttcHUSM3FTCN4rYuEfs0SZ9vEfuHeiu
         Ttj1llukfWakfaFod9qSwE9k03J1iFEUcRd67F8lhHmOjMY3NBQEF4N/YDv24QUTQAT0
         J+GOTQRnPTV63vdrXOxf0LnQI8iupvPJ78mo05G+bHpyq9XjL9PlkKtNYhwYMU4akJu4
         s/taZ/NDvUz5K+KaQi4Gxd34yPEkVHqyzENgyO+EsaFoPItzpJetWAzrkzj/mGcmLVM7
         9HtD32K2pAr5uk/MgIFY2EiPUU86sEoIPwn6oCds06O2Nal9YXkyGPXi7k8S61n+5+Ig
         7wEA==
X-Gm-Message-State: AOAM533KBTFdF7FF+8Pg7AFCyKTUpcy3yM7o0Io9s74SI7U6tJBaulH2
        xLb2dtIKYP4WYK40SoYXz74H93YknsfLZircAJhxAA==
X-Google-Smtp-Source: ABdhPJyr2c+1gD5MNC+tqhvxKv/vc4WNHyPe6OFeOs4hvUvdmby0LD98BjnKqvYF/pKBwcggQnXp9YvzSMG63YviiFw=
X-Received: by 2002:a05:6512:139c:: with SMTP id p28mr9178591lfa.523.1631551562217;
 Mon, 13 Sep 2021 09:46:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210913163547.5156-1-will@kernel.org>
In-Reply-To: <20210913163547.5156-1-will@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 13 Sep 2021 09:45:51 -0700
Message-ID: <CAKwvOd=gO=7MjL9bQR_+xUYCMVNVbsCGV0WCb0hK-rSiJ3kpbA@mail.gmail.com>
Subject: Re: [PATCH] x86/uaccess: Fix 32-bit __get_user_asm_u64() when CC_HAS_ASM_GOTO_OUTPUT=y
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Bill Wendling <morbo@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2021 at 9:36 AM Will Deacon <will@kernel.org> wrote:
>
> Commit 865c50e1d279 ("x86/uaccess: utilize CONFIG_CC_HAS_ASM_GOTO_OUTPUT")
> added an optimised version of __get_user_asm() for x86 using 'asm goto'.
>
> Like the non-optimised code, the 32-bit implementation of 64-bit get_user()
> expands to a pair of 32-bit accesses. Unlike the non-optimised code, the
> _original_ pointer is incremented to copy the high word instead of loading
> through a new pointer explicitly constructed to point at a 32-bit type.
> Consequently, if the pointer points at a 64-bit type then we end up
> loading the wrong data for the upper 32-bits.
>
> This was observed as a mount() failure in Android targetting i686 after

s/targetting/targeting/

> b0cfcdd9b967 ("d_path: make 'prepend()' fill up the buffer exactly on
> overflow") because the call to copy_from_kernel_nofault() from
> prepend_copy() ends up in __get_kernel_nofault() and casts the source
> pointer to a 'u64 __user *'. An attempt to mount at "/debug_ramdisk"
> therefore ends up failing trying to mount "/debumdismdisk".
>
> Use the existing '__gu_ptr' source pointer to unsigned int for 32-bit
> __get_user_asm_u64() instead of the original pointer.
>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Bill Wendling <morbo@google.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Reported-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Fixes: 865c50e1d279 ("x86/uaccess: utilize CONFIG_CC_HAS_ASM_GOTO_OUTPUT")
> Signed-off-by: Will Deacon <will@kernel.org>

Sorry I missed this; I think -Wunused-variable would have helped here.
Thanks for debugging+fixing.

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  arch/x86/include/asm/uaccess.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
> index c9fa7be3df82..5c95d242f38d 100644
> --- a/arch/x86/include/asm/uaccess.h
> +++ b/arch/x86/include/asm/uaccess.h
> @@ -301,8 +301,8 @@ do {                                                                        \
>         unsigned int __gu_low, __gu_high;                               \
>         const unsigned int __user *__gu_ptr;                            \
>         __gu_ptr = (const void __user *)(ptr);                          \
> -       __get_user_asm(__gu_low, ptr, "l", "=r", label);                \
> -       __get_user_asm(__gu_high, ptr+1, "l", "=r", label);             \
> +       __get_user_asm(__gu_low, __gu_ptr, "l", "=r", label);           \
> +       __get_user_asm(__gu_high, __gu_ptr+1, "l", "=r", label);        \
>         (x) = ((unsigned long long)__gu_high << 32) | __gu_low;         \
>  } while (0)
>  #else
> --
> 2.33.0.309.g3052b89438-goog
>


-- 
Thanks,
~Nick Desaulniers
