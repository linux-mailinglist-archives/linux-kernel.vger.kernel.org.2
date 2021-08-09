Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 843643E4A2B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 18:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233357AbhHIQqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 12:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232861AbhHIQqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 12:46:02 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C9F0C0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 09:45:41 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id w20so8622490lfu.7
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 09:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NNohOuq32VQSGJ5Dr+kGVWFdhQNRwvqaFBsp9NaZjZE=;
        b=XqiDAKWWAykN/86e2tI6O3p3rJD7IHeqMat7+UvoFXAd0AeavrdivqAYOT6Utc7g7t
         pum2q1rx7q7obehPvQFnuwMQCj7BzvVhepCdD4Cja5MolL0axkpBI5z3bf1h03rcwJLb
         r2LIAXlJKOYGYF62Jwkh2+nDj0mSU30FAo49Zwb/6D4fftyxw2tSH2GMjB2mqdGFfFKC
         T2ieAoROlYbcCQGYIaPJbLC6/ySK0D6i1SZb65OnnbjGtndUAM+pfyKl+5yHlzF4F0jg
         n8GZQLa3pfrxNarkMZGWzXzgDzCDopUQcJppHRRLZxonBT95SfiUva6E3mpjkmKG9FS1
         r1lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NNohOuq32VQSGJ5Dr+kGVWFdhQNRwvqaFBsp9NaZjZE=;
        b=KiGiZGJuMdZSgrbJojGbYN/mV4NGkBt9qjq0Yq0aWdtA7+cBLBGcggObr6hIRSOUU+
         20QObJksUNYsJgd/JJjJ8lrH9ZgrvLOP+2DtiAHRzDChC6s7/LP6WHU5U6SRPkynwYT6
         MB8oiMnNbu24OUpxhEB7EAg2lBvj02VfRMC3fpBfthwmgyYpoiGpsdfM02TC5ixB4hPH
         iw4GZo+U+gZRWcHh23BAj4Z0YRwD0WqDXY3fewVw1XdWt/3NoYz5x7+H42gxMgA7N9Ww
         oMo11ivwBrVJMcnum3npEvTxhzU6zr97RXohcqYCm5Tp91Bl6xtLwXuhDqpr5qI5Ah2H
         RDEA==
X-Gm-Message-State: AOAM533E867iQCy1RhHowodZWF0vzbaLSRW3wi+qB8C5JuTSzZA3wYZ2
        wTG+EAwXj5gxXDq1VJPdIJJtgwdQ6gSF26SWagTm/A==
X-Google-Smtp-Source: ABdhPJxyI2i1Bp4GZ9EmKfX9ci3dbTEJdgVMG4dKKn799o/1+IWhlwM8oG8YRqD06coXmUgYxNNn8cFOT+fWW5NPtJc=
X-Received: by 2002:a05:6512:6c9:: with SMTP id u9mr15826479lff.411.1628527539525;
 Mon, 09 Aug 2021 09:45:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210809152651.2297337-1-maz@kernel.org> <20210809152651.2297337-12-maz@kernel.org>
In-Reply-To: <20210809152651.2297337-12-maz@kernel.org>
From:   Oliver Upton <oupton@google.com>
Date:   Mon, 9 Aug 2021 09:45:28 -0700
Message-ID: <CAOQ_Qshfi=RN8fExhXQh1i640LAZaZjQSJApyvdU2Gva9KtFaQ@mail.gmail.com>
Subject: Re: [PATCH 11/13] clocksource/arm_arch_timer: Fix masking for high
 freq counters
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Shier <pshier@google.com>,
        Raghavendra Rao Ananta <rananta@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 9, 2021 at 8:48 AM Marc Zyngier <maz@kernel.org> wrote:
>
> From: Oliver Upton <oupton@google.com>
>
> Unfortunately, the architecture provides no means to determine the bit
> width of the system counter. However, we do know the following from the
> specification:
>
>  - the system counter is at least 56 bits wide
>  - Roll-over time of not less than 40 years
>
> To date, the arch timer driver has depended on the first property,
> assuming any system counter to be 56 bits wide and masking off the rest.
> However, combining a narrow clocksource mask with a high frequency
> counter could result in prematurely wrapping the system counter by a
> significant margin. For example, a 56 bit wide, 1GHz system counter
> would wrap in a mere 2.28 years!
>
> This is a problem for two reasons: v8.6+ implementations are required to
> provide a 64 bit, 1GHz system counter. Furthermore, before v8.6,
> implementers may select a counter frequency of their choosing.
>
> Fix the issue by deriving a valid clock mask based on the second
> property from above. Set the floor at 56 bits, since we know no system
> counter is narrower than that.
>
> Suggested-by: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Oliver Upton <oupton@google.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> [maz: fixed width computation not to lose the last bit, added
>       max delta generation for the timer]
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Link: https://lore.kernel.org/r/20210807191428.3488948-1-oupton@google.com
> ---
>  drivers/clocksource/arm_arch_timer.c | 34 ++++++++++++++++++++++++----
>  1 file changed, 29 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
> index fa09952b94bf..74eca831d0d9 100644
> --- a/drivers/clocksource/arm_arch_timer.c
> +++ b/drivers/clocksource/arm_arch_timer.c
> @@ -52,6 +52,12 @@
>  #define CNTV_CVAL_LO   0x30
>  #define CNTV_CTL       0x3c
>
> +/*
> + * The minimum amount of time a generic counter is guaranteed to not roll over
> + * (40 years)
> + */
> +#define MIN_ROLLOVER_SECS      (40ULL * 365 * 24 * 3600)
> +
>  static unsigned arch_timers_present __initdata;
>
>  struct arch_timer {
> @@ -95,6 +101,22 @@ static int __init early_evtstrm_cfg(char *buf)
>  }
>  early_param("clocksource.arm_arch_timer.evtstrm", early_evtstrm_cfg);
>
> +/*
> + * Makes an educated guess at a valid counter width based on the Generic Timer
> + * specification. Of note:
> + *   1) the system counter is at least 56 bits wide
> + *   2) a roll-over time of not less than 40 years
> + *
> + * See 'ARM DDI 0487G.a D11.1.2 ("The system counter")' for more details.
> + */
> +static int arch_counter_get_width(void)
> +{
> +       u64 min_cycles = MIN_ROLLOVER_SECS * arch_timer_rate;
> +
> +       /* guarantee the returned width is within the valid range */
> +       return clamp_val(ilog2(min_cycles - 1) + 1, 56, 64);
> +}

Reposting thoughts from the original patch:

Reading the ARM ARM
D11.1.2 'The system counter', I did not find any language that
suggested the counter saturates the register width before rolling
over. So, it may be paranoid, but I presumed it to be safer to wrap
within the guaranteed interval rather (40 years) than assume the
sanity of the system counter implementation.

--
Thanks,
Oliver

> +
>  /*
>   * Architected system timer support.
>   */
> @@ -208,13 +230,11 @@ static struct clocksource clocksource_counter = {
>         .id     = CSID_ARM_ARCH_COUNTER,
>         .rating = 400,
>         .read   = arch_counter_read,
> -       .mask   = CLOCKSOURCE_MASK(56),
>         .flags  = CLOCK_SOURCE_IS_CONTINUOUS,
>  };
>
>  static struct cyclecounter cyclecounter __ro_after_init = {
>         .read   = arch_counter_read_cc,
> -       .mask   = CLOCKSOURCE_MASK(56),
>  };
>
>  struct ate_acpi_oem_info {
> @@ -796,7 +816,7 @@ static u64 __arch_timer_check_delta(void)
>                 return CLOCKSOURCE_MASK(32);
>         }
>  #endif
> -       return CLOCKSOURCE_MASK(56);
> +       return CLOCKSOURCE_MASK(arch_counter_get_width());
>  }
>
>  static void __arch_timer_setup(unsigned type,
> @@ -1041,6 +1061,7 @@ struct arch_timer_kvm_info *arch_timer_get_kvm_info(void)
>  static void __init arch_counter_register(unsigned type)
>  {
>         u64 start_count;
> +       int width;
>
>         /* Register the CP15 based counter if we have one */
>         if (type & ARCH_TIMER_TYPE_CP15) {
> @@ -1065,6 +1086,10 @@ static void __init arch_counter_register(unsigned type)
>                 arch_timer_read_counter = arch_counter_get_cntvct_mem;
>         }
>
> +       width = arch_counter_get_width();
> +       clocksource_counter.mask = CLOCKSOURCE_MASK(width);
> +       cyclecounter.mask = CLOCKSOURCE_MASK(width);
> +
>         if (!arch_counter_suspend_stop)
>                 clocksource_counter.flags |= CLOCK_SOURCE_SUSPEND_NONSTOP;
>         start_count = arch_timer_read_counter();
> @@ -1074,8 +1099,7 @@ static void __init arch_counter_register(unsigned type)
>         timecounter_init(&arch_timer_kvm_info.timecounter,
>                          &cyclecounter, start_count);
>
> -       /* 56 bits minimum, so we assume worst case rollover */
> -       sched_clock_register(arch_timer_read_counter, 56, arch_timer_rate);
> +       sched_clock_register(arch_timer_read_counter, width, arch_timer_rate);
>  }
>
>  static void arch_timer_stop(struct clock_event_device *clk)
> --
> 2.30.2
>
