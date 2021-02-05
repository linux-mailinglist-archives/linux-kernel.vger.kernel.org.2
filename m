Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ADAF3108DE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 11:21:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbhBEKS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 05:18:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbhBEKP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 05:15:28 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CD54C0613D6
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 02:14:47 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id n201so6420630iod.12
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 02:14:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w+/kEe1Bmcdr9lG9N+AIixjjPvoTCuRotm37ECiHk3I=;
        b=SzI+qVqSZY6w76mb2V6J28cSeezGP5UrYHGt/7PK+kEb559IFKqaooGrWc1ZsOhmRZ
         zHWn36gqyAItMNXWY7aB9k15NvJHvV0wAsUZbYTzI/7iV9jCgkrwJTUYTCeqmjy3TUaX
         1acWRwGfTEte7kGO05QwwCIwDL/61KKO/8Y3+ZWSyxS3cAydnT7zkkB2UH2kuVecToV1
         /TZU/eOEAnNRuC4mI3dft+hO2B7BzRGiQrU2AZAzlX/UGhQOU4Oq7Ctl1Jqhofvtn3mm
         72TuIs2XOfppP57+d9fzQ8dgUe0ZT/4sVsuzZCuBokB9yuheHdpYWZdUtpqrBQ+yKHZm
         GKeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w+/kEe1Bmcdr9lG9N+AIixjjPvoTCuRotm37ECiHk3I=;
        b=B8T6krXK7uHAUunOmdCUUlSUe1nUqF+wNsY5p0rL/7912NZKK57/jyPWUKQQYo953f
         7DXsCoz5ZyUq9/3XQ6bydTAJUWh/5aGVjzlPMLKUyK4vmbjSTrryEytyNkV6RJ8FVYnG
         taNMFLwRUENFw8jNI/TkoKQ6O1QXjPJyDZ8t33xfVuOwyM2n5qqWet86dTkT8Uui/GS4
         YzIyncurMHrNILIL3g6K1MJ8qpBkO4lCWs4qzDM7yfzNMBBcIAlMq5VnW1H67+MFnY6W
         6UyPmdp5BjQ96WhEguKpyBcQJldoE4/liswZvlxx+NFd6oCHQZTVhkLXDtUZlDlXbKhD
         WoiQ==
X-Gm-Message-State: AOAM533zMS/+AO2w5XgbKqES2ysKw2r7kVCqJ1p97x5K8UN8UdmudBb3
        6wq2n/L9a550Fkw9IKtYNLY1uHzShjyEx24YGWM=
X-Google-Smtp-Source: ABdhPJzwcW4kjducUDD0flJG4k+9zT5EQW8zfbVSzfa7EizYXX0+zJG5oN7VG2KZ0mvCJzbe35vRwV28QX73vjaazVM=
X-Received: by 2002:a02:449:: with SMTP id 70mr4051139jab.137.1612520086618;
 Fri, 05 Feb 2021 02:14:46 -0800 (PST)
MIME-Version: 1.0
References: <20210204204903.350275743@linutronix.de> <20210204211155.214169844@linutronix.de>
In-Reply-To: <20210204211155.214169844@linutronix.de>
From:   Lai Jiangshan <jiangshanlai+lkml@gmail.com>
Date:   Fri, 5 Feb 2021 18:14:35 +0800
Message-ID: <CAJhGHyDF-wuK0Q0RZ9mDTo19rayA-jjJ1SGp2-1TS_d5-eHDzw@mail.gmail.com>
Subject: Re: [patch 11/12] softirq: Allow inlining do_softirq_own_stack()
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 5, 2021 at 10:04 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> The function to switch to the irq stack on x86 is now minimal and there is
> only a single caller. Allow the stack switch to be inlined.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  include/linux/interrupt.h |    2 ++
>  kernel/softirq.c          |    4 ++++
>  2 files changed, 6 insertions(+)
>
> --- a/include/linux/interrupt.h
> +++ b/include/linux/interrupt.h
> @@ -570,7 +570,9 @@ asmlinkage void do_softirq(void);
>  asmlinkage void __do_softirq(void);
>
>  #ifdef __ARCH_HAS_DO_SOFTIRQ
> +# ifndef __ARCH_HAS_DO_SOFTIRQ_INLINE
>  void do_softirq_own_stack(void);
> +# endif
>  #else
>  static inline void do_softirq_own_stack(void)
>  {

Hello

This patch and the next patch have three "#if[n]def" with
__ARCH_HAS_DO_SOFTIRQ_INLINE and this one is nested in
__ARCH_HAS_DO_SOFTIRQ.

I wonder if we can use __ARCH_HAS_DO_SOFTIRQ only.

For example, we can move "void do_softirq_own_stack(void);" to around
the code where __ARCH_HAS_DO_SOFTIRQ are defined in very ARCHs.
(And for x86, do_softirq_own_stack() is a macro instead of function
declaration as next patch shows)

Thanks
Lai

> --- a/kernel/softirq.c
> +++ b/kernel/softirq.c
> @@ -26,6 +26,10 @@
>  #include <linux/tick.h>
>  #include <linux/irq.h>
>
> +#ifdef __ARCH_HAS_DO_SOFTIRQ_INLINE
> +# include <asm/irq_stack.h>
> +#endif
> +
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/irq.h>
>
>
