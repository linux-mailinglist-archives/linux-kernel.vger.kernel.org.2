Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88A8F3610B5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 19:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234385AbhDOREB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 13:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbhDORD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 13:03:59 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60DDDC061574
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 10:03:36 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id z8so27889984ljm.12
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 10:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U8nRxp9yxovE2rmz0BaOdHpuJsy82akPvndDf9QOMYI=;
        b=UJ/0rFU007c1xrSDt8rnZaY/C/1wRNIWX286uco8cqj/s1k0wTz/Ujh2svSH30FjaK
         XZxpO8u7ysEBnv0NcKQ6dpO+A7eotLNYjTXnUYy3V4XHhFL97q6dQrqErGkeVyLzoPyM
         evSWoRUKIrCVBH9EKNzM7YPyS/tfKFqIVyfQhe9TTbCJq4kpxktOhkBsUT6sa4veCcK0
         Jkq3Hcp2rb1dcFf8JUBPOJaNKkW/wUMRirwse8u+dFV6BPCyyKZ87niieDLZDN/I6n7r
         uVFfDpxnHrlO8VrY6z0ZjHBAcVmB/EYs5p8a51hOiHFPmWy7s09RQUEGXYYLeGwLbEgk
         5GYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U8nRxp9yxovE2rmz0BaOdHpuJsy82akPvndDf9QOMYI=;
        b=cTAzDY4wyuFiTsrrDEbaDKFLLQXk7v/6sZ4Y3YTiUNiC6K3niVCUgh1cR5XRfdJ28w
         ch7ISbbGkVRWl3dBT9RpADbFBAwmEbVAyZ+qj5/1oVShRPwT+PUYbm7ySMtR7ZGQL5tF
         XLWAckghsgz37KoF9anSTKVv8VoaLY6M4eT4TbA4gsMDnu5Xe1GUrbaV1DE5OHYR4ZZE
         VKn6kZrVxzfrOfs7wxemSrjaVR/R7/vr7HWhgP6S+NlLrVmAVCKk09savk2kNQCc2QYA
         o+8M8+D+/5/C2Dih8oM63l1hpnOwprCKz8TV5VuFTkP26uPeqnIvYP+ph5sz+Jt2LK+D
         iZeg==
X-Gm-Message-State: AOAM532NBeQmieRYVZsGH/XWw+6Cs2Wnjen/CFPdGZh6RzWMuK/mVl0i
        1jx8Ub3JE+b1EJMT/Te9gEyFP/y8IO1KHNRFeglbyA==
X-Google-Smtp-Source: ABdhPJzdrq2tUExTUzkH5bkt6SJE+5dWE9+ZFyIQkUZDabxJo2IcH+5mYxkVQlZgH+J+JU3vOyIDEuaaM678dV7Y+wU=
X-Received: by 2002:a2e:968a:: with SMTP id q10mr121750lji.0.1618506214722;
 Thu, 15 Apr 2021 10:03:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210415094305.30964-1-zhaoxiao@uniontech.com>
In-Reply-To: <20210415094305.30964-1-zhaoxiao@uniontech.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 15 Apr 2021 10:03:23 -0700
Message-ID: <CAKwvOdmNkMb35q=jNfpGSxtabaDSQStXtWHrnYaBizRq+GQ2XQ@mail.gmail.com>
Subject: Re: [PATCH] X86: Makefile: Replace -pg with CC_FLAGS_FTRACE
To:     zhaoxiao <zhaoxiao@uniontech.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Arvind Sankar <nivedita@alum.mit.edu>, clin@suse.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <jroedel@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2021 at 2:43 AM zhaoxiao <zhaoxiao@uniontech.com> wrote:
>
> In preparation for x86 supporting ftrace built on other compiler
> options, let's have the x86 Makefiles remove the $(CC_FLAGS_FTRACE)
> flags, whatever these may be, rather than assuming '-pg'.
>
> There should be no functional change as a result of this patch.
>
> Signed-off-by: zhaoxiao <zhaoxiao@uniontech.com>
> ---
>  arch/x86/kernel/Makefile | 16 ++++++++--------
>  arch/x86/lib/Makefile    |  2 +-

I see additional CFLAGS_REMOVE_* = -pg in
- arch/x86/mm/Makefile
- arch/x86/kernel/cpu/Makefile
- arch/x86/entry/vdso/Makefile
- arch/x86/um/vdso/Makefile
- arch/x86/xen/Makefile

Would this same change be appropriate to all of the above?  Seeing the
additional possible values of CC_FLAGS_FTRACE (`-mrecord-mcount`,
`-mnop-mcount`, `-mfentry`) makes we wonder if those are currently
broken for these files as they are not removed, or if only `-pg` is
problematic?

Thank you for the patch.

>  2 files changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
> index 2ddf08351f0b..2811fc6a17ba 100644
> --- a/arch/x86/kernel/Makefile
> +++ b/arch/x86/kernel/Makefile
> @@ -13,14 +13,14 @@ CPPFLAGS_vmlinux.lds += -U$(UTS_MACHINE)
>
>  ifdef CONFIG_FUNCTION_TRACER
>  # Do not profile debug and lowlevel utilities
> -CFLAGS_REMOVE_tsc.o = -pg
> -CFLAGS_REMOVE_paravirt-spinlocks.o = -pg
> -CFLAGS_REMOVE_pvclock.o = -pg
> -CFLAGS_REMOVE_kvmclock.o = -pg
> -CFLAGS_REMOVE_ftrace.o = -pg
> -CFLAGS_REMOVE_early_printk.o = -pg
> -CFLAGS_REMOVE_head64.o = -pg
> -CFLAGS_REMOVE_sev-es.o = -pg
> +CFLAGS_REMOVE_tsc.o = $(CC_FLAGS_FTRACE)
> +CFLAGS_REMOVE_paravirt-spinlocks.o = $(CC_FLAGS_FTRACE)
> +CFLAGS_REMOVE_pvclock.o = $(CC_FLAGS_FTRACE)
> +CFLAGS_REMOVE_kvmclock.o = $(CC_FLAGS_FTRACE)
> +CFLAGS_REMOVE_ftrace.o = $(CC_FLAGS_FTRACE)
> +CFLAGS_REMOVE_early_printk.o = $(CC_FLAGS_FTRACE)
> +CFLAGS_REMOVE_head64.o = $(CC_FLAGS_FTRACE)
> +CFLAGS_REMOVE_sev-es.o = $(CC_FLAGS_FTRACE)
>  endif
>
>  KASAN_SANITIZE_head$(BITS).o                           := n
> diff --git a/arch/x86/lib/Makefile b/arch/x86/lib/Makefile
> index bad4dee4f0e4..0aa71b8a5bc1 100644
> --- a/arch/x86/lib/Makefile
> +++ b/arch/x86/lib/Makefile
> @@ -21,7 +21,7 @@ KASAN_SANITIZE_cmdline.o  := n
>  KCSAN_SANITIZE_cmdline.o  := n
>
>  ifdef CONFIG_FUNCTION_TRACER
> -CFLAGS_REMOVE_cmdline.o = -pg
> +CFLAGS_REMOVE_cmdline.o = $(CC_FLAGS_FTRACE)
>  endif
>
>  CFLAGS_cmdline.o := -fno-stack-protector -fno-jump-tables
> --
> 2.20.1
>
>
>


-- 
Thanks,
~Nick Desaulniers
