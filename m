Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB82B42E190
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 20:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbhJNSrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 14:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231571AbhJNSrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 14:47:04 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D41D0C061755
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 11:44:58 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id x27so30664647lfa.9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 11:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dJip7K+K6ddBDtyVBqOLOFvZRLq1b7ylvd2srRqWSRQ=;
        b=BAYxaUWxXUxQONyuWASTyK+bHA+njF/YXdfOKoOr0yKb89IvBjdGBJ9ekpPxyJ5i/5
         I5pCp13CoRNHDz7Bxvz7164291WUkaHFlkzuTAetlo8K1BOP7tBNdy9ur8ZWwSJBRyqz
         i/+ihD+8JmhU39vlgaA6e9MGXLeEMgi5oOTXZ/c+riG4Hdf2E38UCYijkzr4h33Impay
         HAiV45LSP1JgoXhxT5Pcl8bz/IbWtFQdj3eY8vPhyK290PUMecQPyYtj9Y7SMK0zJ3P3
         v59QP2utklEbO1OGdcEWnw3nhixELcy4jFllgeKvwniO6VH7ZvinU7lHroWHUZHQfEEQ
         0Tsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dJip7K+K6ddBDtyVBqOLOFvZRLq1b7ylvd2srRqWSRQ=;
        b=vriospdPJwab5wH2PQ5jGs8Z2iI+52Wdy+H8S+5kj2kOV7jRuAiROVYKn25PK0YlS0
         r0EVndFoGoSGdgiBodv930IV4SQd3XyugAb+wTuw0Lq4WP9u2mfnYVPGUFgu9M8mN5s7
         ZWNsI9hiyZ2dV/K9pcFY3+R/70A2a3XCbcsEGQ+PH3N6stuXStjZHGcDm605txY4d2kF
         FOFr1I3Fu8HPNwxHelQWEAHsamIOhEaB43UIJs4DTykJXlG4jk86ij51AMApKaV/jYL3
         mWIV8wHKNB/raYlxlf2mAFCsD27K3Hb+OGdp0z9viWk0hu0fyy0LQBLeSlgP/9fcEaV2
         VvOw==
X-Gm-Message-State: AOAM533JS0OuqAxjiiO53A6ytpOn7W4Xk+wycajLDs/iZkN+UfCFVyNc
        aSktjrdelPqGGlE8RQl+YFYnUYX21YPyXebwehZ7vQ==
X-Google-Smtp-Source: ABdhPJzGVUPpKHDk8B/STzPaOM5nnzXJ4BTUz5HiVetGlGu1MCNmmT8SopdnT/9yBvlWIbHCOnoArkh9v9ibtRLCh+c=
X-Received: by 2002:a05:6512:3ba3:: with SMTP id g35mr6810880lfv.651.1634237096625;
 Thu, 14 Oct 2021 11:44:56 -0700 (PDT)
MIME-Version: 1.0
References: <1634167668-60198-1-git-send-email-ashimida@linux.alibaba.com>
In-Reply-To: <1634167668-60198-1-git-send-email-ashimida@linux.alibaba.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 14 Oct 2021 11:44:45 -0700
Message-ID: <CAKwvOdkv70XDdK-k3n4ycFQsz+h7V-sTiH8RuxxaLofp-okweQ@mail.gmail.com>
Subject: Re: [PATCH] [PATCH V4]ARM64: SCS: Add gcc plugin to support Shadow
 Call Stack
To:     Dan Li <ashimida@linux.alibaba.com>
Cc:     masahiroy@kernel.org, michal.lkml@markovi.net,
        catalin.marinas@arm.com, will@kernel.org, keescook@chromium.org,
        nathan@kernel.org, tglx@linutronix.de, akpm@linux-foundation.org,
        samitolvanen@google.com, frederic@kernel.org, rppt@kernel.org,
        mark.rutland@arm.com, yifeifz2@illinois.edu, rostedt@goodmis.org,
        viresh.kumar@linaro.org, andreyknvl@gmail.com,
        colin.king@canonical.com, ojeda@kernel.org,
        luc.vanoostenryck@gmail.com, elver@google.com,
        nivedita@alum.mit.edu, ardb@kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-hardening@vger.kernel.org, clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 On Wed, Oct 13, 2021 at 4:28 PM Dan Li <ashimida@linux.alibaba.com> wrote:
>
> - This function can be used to test whether the shadow stack is effective:
> //noinline void __noscs scs_test(void)
> noinline void scs_test(void)
> {
>     register unsigned long *sp asm("sp");
>     unsigned long * lr = sp + 1;
>
>     asm volatile("":::"x30");
>     *lr = 0;
> }
>
> when compiled with:
> CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
> CONFIG_ARM64_PTR_AUTH_KERNEL=y
> CONFIG_ARM64_BTI_KERNEL=y
>
> ffff800010013b60 <scs_test>:
> ffff800010013b60:       d503245f        bti     c
> ffff800010013b64:       d503201f        nop
> ffff800010013b68:       d503201f        nop
> ffff800010013b6c:       d503233f        paciasp
> ffff800010013b70:       f800865e        str     x30, [x18], #8
> ffff800010013b74:       a9bf7bfd        stp     x29, x30, [sp, #-16]!
> ffff800010013b78:       910003fd        mov     x29, sp
> ffff800010013b7c:       910003e0        mov     x0, sp
> ffff800010013b80:       f900041f        str     xzr, [x0, #8]
> ffff800010013b84:       a8c17bfd        ldp     x29, x30, [sp], #16
> ffff800010013b88:       f85f8e5e        ldr     x30, [x18, #-8]!
> ffff800010013b8c:       d50323bf        autiasp
> ffff800010013b90:       d65f03c0        ret
>
> If SCS protection is enabled, this function will return normally.
> If the function has __noscs attribute (scs disabled), it will crash due to 0
> address access.
> diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
> index cb9217f..426c8e5 100644
> --- a/include/linux/compiler-gcc.h
> +++ b/include/linux/compiler-gcc.h
> @@ -50,6 +50,10 @@
>  #define __latent_entropy __attribute__((latent_entropy))
>  #endif
>
> +#if defined(SHADOW_CALL_STACK_PLUGIN) && !defined(__CHECKER__)
> +#define __noscs __attribute__((no_shadow_call_stack))
> +#endif

Cool this is a nice addition, and something I don't think that clang
has.  For any new feature, having a function attribute to disable it
at the function granularity is nice, and plays better with LTO than -f
group flags.  Though that begs the question: what happens if a __noscs
callee is inlined into a non-__noscs caller, or vice versa?

I noticed that __noscs isn't actually applied anywhere in the kernel,
yet, at least in this series.  Were there any places necessary that
you've found thus far?

Overall, I'm happy with the patch and am ready to ack it, but I would
like to see a link to to the upstream GCC feature request for SCS (and
one created if it doesn't exist) cited explicitly in the commit
message.  I think that would be a good demonstration that this can or
will be upstreamed into the compiler proper for the compiler vendors
to maintain, rather than the kernel folks.  The compiler vendors may
have further feedback on the approach, such as my question above
pertaining to inlining.
-- 
Thanks,
~Nick Desaulniers
