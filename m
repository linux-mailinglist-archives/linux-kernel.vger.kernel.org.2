Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 705813EF130
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 19:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232415AbhHQR71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 13:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbhHQR70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 13:59:26 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31ECBC061764
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 10:58:52 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id i28so16248197lfl.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 10:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jPB5XR4EZE+ryoBMzfC592JqQnRRPIK/l+bH1/q+ypg=;
        b=g6DRAZ7fttfTmAEadrmjEFAP2o7eAlIKLHw0OwNPJ6hokoxN5yt6XK58EmD28xcS48
         Uwqj2+HbVeS8hnfrDeIw093dCNqhk5NnM5cV8ddYFJmCPHf8ngnoeDWN27prPQPJYuUN
         yN4dp1t1E55YQFwCderI9F5HVLceFAJ1F4lQZR22WXiH409I5wVyeJbPhWDIiXBPEgbX
         /xSsi+2wialTJGyKp8+TV8qKRNuWre5wbZ/LN8Aeyu3eB2v5cmdSWEWQSbHqjTCa2g/W
         Ni1WRWL16QjnnQKZCxpdJpOziEorje9StA76rLLXf6zFeRCwIg0g73mWN37oYJBwgdd3
         L1OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jPB5XR4EZE+ryoBMzfC592JqQnRRPIK/l+bH1/q+ypg=;
        b=M73Gl/lMi8Z/JIgUPoGcE+awmVbo4XZ14Dzh5MPGrxItEpyo63foI3aVFY7yixhar8
         0J+zCpy5r2wgP9avU9Btbgup6GVW82wItHaMqoyFG+zlBk4nOVJoHtMiA4hVT8781ZLF
         Gh+rDq9i1enLoCSVau8SFi3Ln65MbFrj9AlA4tdS7lqZUKJSyzTqECkSmGrqyCJdd4wt
         mFFmdWCEJ6AD0DBlsYC1ikpwfihCyNUq+Bx92ZFy5wymbgpBQ9dWLwW8Ec4UGMXkQcMF
         8ZxkWdll9TgiVxk5mXm00NCI4IjUQSW9I6MjDvWlZIlAbJeBWuJCi0ai8IsDVd/nSXmf
         U0Jg==
X-Gm-Message-State: AOAM531ABeM/lvkhtXqBuhJe+sYu3QLEoyi9g7wdaRt8mGklWC8HrjDw
        Libu5nctDSssFg3QEY4o//C6hMbZwiPbQjNjyaP+mg==
X-Google-Smtp-Source: ABdhPJxVUlGuGbwSaSO8q8+rFRfEzz2A+JkKK3IosopyTguc0Ka1OpJQV89/dwXKa8egSHBGOr9MmEYojyPzmWIqDsM=
X-Received: by 2002:a19:f017:: with SMTP id p23mr3274062lfc.547.1629223130100;
 Tue, 17 Aug 2021 10:58:50 -0700 (PDT)
MIME-Version: 1.0
References: <269701460.117528.1629210189833@office.mailbox.org>
In-Reply-To: <269701460.117528.1629210189833@office.mailbox.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 17 Aug 2021 10:58:39 -0700
Message-ID: <CAKwvOdkpJc66DWTJV1qTZ6ch-qLxf+g-mJnLmP0ea396P1oYmA@mail.gmail.com>
Subject: Re: [PATCH 1/2] x86, Makefile: Move the CPU-specific 64-bit tuning
 settings to arch/x86/Makefile.cpu
To:     torvic9@mailbox.org
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tor,
Thanks for the patches. One thing I always try to do is use
./scripts/get_maintainer.pl to get the appropriate maintainers and
reviewers cc'ed. I prefer to explicitly put the maintainers that I
expect to pick up a patch in the To: line.

$ ./scripts/get_maintainer.pl arch/x86/Makefile -norolestats
Thomas Gleixner <tglx@linutronix.de>
Ingo Molnar <mingo@redhat.com>
Borislav Petkov <bp@alien8.de>
x86@kernel.org
"H. Peter Anvin" <hpa@zytor.com>
Nathan Chancellor <nathan@kernel.org>
Nick Desaulniers <ndesaulniers@google.com>
linux-kernel@vger.kernel.org
clang-built-linux@googlegroups.com

added them to CC.  Probably needs a refresh at this point, but
https://nickdesaulniers.github.io/blog/2017/05/16/submitting-your-first-patch-to-the-linux-kernel-and-responding-to-feedback/
is still mostly relevant.

On Tue, Aug 17, 2021 at 7:23 AM torvic9 via Clang Built Linux
<clang-built-linux@googlegroups.com> wrote:
>
> In accordance with the FIXME comment in arch/x86/Makefile, move the
> CPU-specific 64-bit tuning settings to arch/x86/Makefile.cpu.
>
> Signed-off-by: Tor Vic <torvic9@mailbox.org>
> ---
>  arch/x86/Makefile     | 11 ++---------
>  arch/x86/Makefile.cpu | 12 ++++++++++++
>  2 files changed, 14 insertions(+), 9 deletions(-)
>  create mode 100644 arch/x86/Makefile.cpu
>
> diff --git a/arch/x86/Makefile b/arch/x86/Makefile
> index 307fd0000a83..94105d7ad22c 100644
> --- a/arch/x86/Makefile
> +++ b/arch/x86/Makefile
> @@ -119,15 +119,8 @@ else
>         # Use -mskip-rax-setup if supported.
>         KBUILD_CFLAGS += $(call cc-option,-mskip-rax-setup)
>
> -        # FIXME - should be integrated in Makefile.cpu (Makefile_32.cpu)
> -        cflags-$(CONFIG_MK8) += $(call cc-option,-march=k8)
> -        cflags-$(CONFIG_MPSC) += $(call cc-option,-march=nocona)
> -
> -        cflags-$(CONFIG_MCORE2) += \
> -                $(call cc-option,-march=core2,$(call cc-option,-mtune=generic))
> -       cflags-$(CONFIG_MATOM) += $(call cc-option,-march=atom) \
> -               $(call cc-option,-mtune=atom,$(call cc-option,-mtune=generic))
> -        cflags-$(CONFIG_GENERIC_CPU) += $(call cc-option,-mtune=generic)
> +        # CPU-specific tuning (64-bit).
> +        include arch/x86/Makefile.cpu

So we have arch/x86/Makefile_32.cpu, would it be more symmetrical to
have a new arch/x86/Makefile_64.cpu (rather than Makefile.cpu)?

>          KBUILD_CFLAGS += $(cflags-y)
>
>          KBUILD_CFLAGS += -mno-red-zone
> diff --git a/arch/x86/Makefile.cpu b/arch/x86/Makefile.cpu
> new file mode 100644
> index 000000000000..fb407ae94d90
> --- /dev/null
> +++ b/arch/x86/Makefile.cpu
> @@ -0,0 +1,12 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# CPU tuning section (64-bit) - shared with UML.
> +# Must change only cflags-y (or [yn]), not CFLAGS! That makes a difference for UML.
> +
> +cflags-$(CONFIG_MK8) += $(call cc-option,-march=k8)
> +cflags-$(CONFIG_MPSC) += $(call cc-option,-march=nocona)
> +
> +cflags-$(CONFIG_MCORE2) += \
> +       $(call cc-option,-march=core2,$(call cc-option,-mtune=generic))
> +cflags-$(CONFIG_MATOM) += $(call cc-option,-march=atom) \
> +       $(call cc-option,-mtune=atom,$(call cc-option,-mtune=generic))
> +cflags-$(CONFIG_GENERIC_CPU) += $(call cc-option,-mtune=generic)

I was going to say we probably don't want to limit -mtune=genric to
64b only, but it seems that arch/x86/Makefile_32.cpu has some
duplication here.

 47 cflags-$(CONFIG_X86_GENERIC)  += $(call tune,generic,$(call
tune,i686))

That probably could be hoisted back into arch/x86/Makefile before the
CONFIG_X86_32 check, but I'm not sure about the differences between
CONFIG_GENERIC_CPU vs CONFIG_X86_GENERIC?
-- 
Thanks,
~Nick Desaulniers
