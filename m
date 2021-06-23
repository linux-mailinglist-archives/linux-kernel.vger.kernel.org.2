Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CDC53B1F72
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 19:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbhFWRbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 13:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbhFWRbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 13:31:01 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED64C061574
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 10:28:42 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id i13so5406073lfc.7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 10:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F/vUEwxy90Jyy7FMebdqoObUzJ3pmM2D9gxlfjjbcKQ=;
        b=TKzKGcBbX+ngqWx+kD0QeNv2Zi3w6KLcMiZbHxJ66bOajlhh/PSJsPh1YFF0rFwySb
         OhjcEkBvjYXERgo8Bjr4tj0QwbWRc3NjO8/+fL/qlome64TyHL87d/es4MWJuz3/lX7j
         lZDqU1wg+T0qtaZIq45ttbRUw+cfOwr+ShMjNDgA6QLkWfkJw0Weae2eBMsHTcszUeL8
         XdOhUiPOaBMM+JehU1ju3fB9+bPlRaQYs3zKqD8VMfxUJ4q6IDKas/M9POkhNfW2xfXu
         63Lj/R6VD3HElc4W0gCAR/rxmxNL/9GBQZ0x2M/m56u0EX3WY+IN/p7p88BVRFkET/nq
         oTDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F/vUEwxy90Jyy7FMebdqoObUzJ3pmM2D9gxlfjjbcKQ=;
        b=mWyGeCBtBbCStGUhca8q5Oxky6MnuOe2xCkQ/LVSnfQyZ0pWz7HUb1MwdfgLwwJs6O
         DKO4UY9nKEwhCpRvM6FQf9Pn034b6MIh8G5nVqqYrtr8zlHkG3HUaPorRLsfKchBWdfS
         hRV0ULkKkTDKoyeq+eudRbN7GsZ3SO8GHXu79bqDlzONCZfbcXJAlaS4XnnrMijakxPJ
         mtPoqUaRsji2cfVlyE21nBqcAWfyrviNcglGlddokO3dyZkSKgoVrZQzTq2r1XMyWdDB
         sAD86o4Ga5bxY+aeFEIB3yHMo3rRh+Ljk7CwCoWenfnyPfK8lOh1ZBpOZ71TpGUYXQX+
         7yQg==
X-Gm-Message-State: AOAM530Y0ZOGSlCDWOu58Ii+Lp4x1xopyn9LJgwugRVJ3b08EcpKjAgT
        q7rw32UWKM0ChUIhP29kz4ccvSMQGFgfvYFOAnuonaEyd+dUNA==
X-Google-Smtp-Source: ABdhPJxvJDjQTCESK0tRERkzUu8Pe7SBp+bxYBC14IFybM5WsbzZMhHiRxg8c5NTAxXsI0Hi4+a5u3rAbQBxLezVnXI=
X-Received: by 2002:a05:6512:1390:: with SMTP id p16mr505946lfa.597.1624469320848;
 Wed, 23 Jun 2021 10:28:40 -0700 (PDT)
MIME-Version: 1.0
References: <20201124141449.572446-1-maz@kernel.org> <20201124141449.572446-3-maz@kernel.org>
In-Reply-To: <20201124141449.572446-3-maz@kernel.org>
From:   Todd Kjos <tkjos@google.com>
Date:   Wed, 23 Jun 2021 10:28:26 -0700
Message-ID: <CAHRSSEw1U8DmQhK_zr-01bXf7bVaNPHamQhdkmBcCpwAkSZbYg@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] genirq: Allow an interrupt to be marked as 'raw'
To:     Marc Zyngier <maz@kernel.org>
Cc:     LAK <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Russell King <linux@arm.linux.org.uk>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 24, 2020 at 6:15 AM Marc Zyngier <maz@kernel.org> wrote:
>
> Some interrupts (such as the rescheduling IPI) rely on not going through
> the irq_enter()/irq_exit() calls. To distinguish such interrupts, add
> a new IRQ flag that allows the low-level handling code to sidestep the
> enter()/exit() calls.
>
> Only the architecture code is expected to use this. It will do the wrong
> thing on normal interrupts. Note that this is a band-aid until we can
> move to some more correct infrastructure (such as kernel/entry/common.c).
>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  include/linux/irq.h   |  2 ++
>  kernel/irq/Kconfig    |  3 +++
>  kernel/irq/debugfs.c  |  1 +
>  kernel/irq/irqdesc.c  | 17 ++++++++++++-----
>  kernel/irq/settings.h | 15 +++++++++++++++
>  5 files changed, 33 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/irq.h b/include/linux/irq.h
> index c55f218d5b61..605ba5949255 100644
> --- a/include/linux/irq.h
> +++ b/include/linux/irq.h
> @@ -72,6 +72,7 @@ enum irqchip_irq_state;
>   *                               mechanism and from core side polling.
>   * IRQ_DISABLE_UNLAZY          - Disable lazy irq disable
>   * IRQ_HIDDEN                  - Don't show up in /proc/interrupts
> + * IRQ_RAW                     - Skip tick management and irqtime accounting
>   */
>  enum {
>         IRQ_TYPE_NONE           = 0x00000000,
> @@ -99,6 +100,7 @@ enum {
>         IRQ_IS_POLLED           = (1 << 18),
>         IRQ_DISABLE_UNLAZY      = (1 << 19),
>         IRQ_HIDDEN              = (1 << 20),
> +       IRQ_RAW                 = (1 << 21),
>  };
>
>  #define IRQF_MODIFY_MASK       \
> diff --git a/kernel/irq/Kconfig b/kernel/irq/Kconfig
> index 164a031cfdb6..ae9b13d5ee91 100644
> --- a/kernel/irq/Kconfig
> +++ b/kernel/irq/Kconfig
> @@ -109,6 +109,9 @@ config GENERIC_IRQ_MATRIX_ALLOCATOR
>  config GENERIC_IRQ_RESERVATION_MODE
>         bool
>
> +config ARCH_WANTS_IRQ_RAW
> +       bool
> +
>  # Support forced irq threading
>  config IRQ_FORCED_THREADING
>         bool
> diff --git a/kernel/irq/debugfs.c b/kernel/irq/debugfs.c
> index e4cff358b437..f53475d88072 100644
> --- a/kernel/irq/debugfs.c
> +++ b/kernel/irq/debugfs.c
> @@ -140,6 +140,7 @@ static const struct irq_bit_descr irqdesc_states[] = {
>         BIT_MASK_DESCR(_IRQ_IS_POLLED),
>         BIT_MASK_DESCR(_IRQ_DISABLE_UNLAZY),
>         BIT_MASK_DESCR(_IRQ_HIDDEN),
> +       BIT_MASK_DESCR(_IRQ_RAW),
>  };
>
>  static const struct irq_bit_descr irqdesc_istates[] = {
> diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
> index 1a7723604399..f5beee546a6f 100644
> --- a/kernel/irq/irqdesc.c
> +++ b/kernel/irq/irqdesc.c
> @@ -667,10 +667,9 @@ int __handle_domain_irq(struct irq_domain *domain, unsigned int hwirq,
>  {
>         struct pt_regs *old_regs = set_irq_regs(regs);
>         unsigned int irq = hwirq;
> +       struct irq_desc *desc;
>         int ret = 0;
>
> -       irq_enter();
> -
>  #ifdef CONFIG_IRQ_DOMAIN
>         if (lookup)
>                 irq = irq_find_mapping(domain, hwirq);
> @@ -680,14 +679,22 @@ int __handle_domain_irq(struct irq_domain *domain, unsigned int hwirq,
>          * Some hardware gives randomly wrong interrupts.  Rather
>          * than crashing, do something sensible.
>          */
> -       if (unlikely(!irq || irq >= nr_irqs)) {
> +       if (unlikely(!irq || irq >= nr_irqs || !(desc = irq_to_desc(irq)))) {

I see a checkpatch error here:

ERROR:ASSIGN_IN_IF: do not use assignment in if condition
#96: FILE: kernel/irq/irqdesc.c:682:

>                 ack_bad_irq(irq);
>                 ret = -EINVAL;
> +               goto out;
> +       }
> +
> +       if (IS_ENABLED(CONFIG_ARCH_WANTS_IRQ_RAW) &&
> +           unlikely(irq_settings_is_raw(desc))) {
> +               generic_handle_irq_desc(desc);
>         } else {
> -               generic_handle_irq(irq);
> +               irq_enter();
> +               generic_handle_irq_desc(desc);
> +               irq_exit();
>         }
>
> -       irq_exit();
> +out:
>         set_irq_regs(old_regs);
>         return ret;
>  }
> diff --git a/kernel/irq/settings.h b/kernel/irq/settings.h
> index 51acdf43eadc..0033d459fdac 100644
> --- a/kernel/irq/settings.h
> +++ b/kernel/irq/settings.h
> @@ -18,6 +18,7 @@ enum {
>         _IRQ_IS_POLLED          = IRQ_IS_POLLED,
>         _IRQ_DISABLE_UNLAZY     = IRQ_DISABLE_UNLAZY,
>         _IRQ_HIDDEN             = IRQ_HIDDEN,
> +       _IRQ_RAW                = IRQ_RAW,
>         _IRQF_MODIFY_MASK       = IRQF_MODIFY_MASK,
>  };
>
> @@ -33,6 +34,7 @@ enum {
>  #define IRQ_IS_POLLED          GOT_YOU_MORON
>  #define IRQ_DISABLE_UNLAZY     GOT_YOU_MORON
>  #define IRQ_HIDDEN             GOT_YOU_MORON
> +#define IRQ_RAW                        GOT_YOU_MORON
>  #undef IRQF_MODIFY_MASK
>  #define IRQF_MODIFY_MASK       GOT_YOU_MORON
>
> @@ -180,3 +182,16 @@ static inline bool irq_settings_is_hidden(struct irq_desc *desc)
>  {
>         return desc->status_use_accessors & _IRQ_HIDDEN;
>  }
> +
> +static inline bool irq_settings_is_raw(struct irq_desc *desc)
> +{
> +       if (IS_ENABLED(CONFIG_ARCH_WANTS_IRQ_RAW))
> +               return desc->status_use_accessors & _IRQ_RAW;
> +
> +       /*
> +        * Using IRQ_RAW on architectures that don't expect it is
> +        * likely to be wrong.
> +        */
> +       WARN_ON_ONCE(1);
> +       return false;
> +}
> --
> 2.28.0
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
