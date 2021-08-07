Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4153E36C9
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 20:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbhHGSfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 14:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhHGSfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 14:35:53 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F565C0613CF
        for <linux-kernel@vger.kernel.org>; Sat,  7 Aug 2021 11:35:35 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id g13so25026946lfj.12
        for <linux-kernel@vger.kernel.org>; Sat, 07 Aug 2021 11:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zMQAIZcGPoAZR0d005NxFzAT1cH+2rezexuQq2s5Nmg=;
        b=WnqZF1wEg6hyBHE1RzeEjFG5+hzHVSxSnAZMpPbOlBMQooBO0RA5IbY8DNrVoN9RWx
         YpbjI/bV25mEJ/9jHY/aJAmGRxNv2Fk5za8qj3d0cwtcZLzU/kQmlEg0ynbgZbHQBtAJ
         SyMK7xg17VCUnLo4AJBAdxelTzmhVa5HpGVB9ZPDtKsbaHae2XHB6P6SMU6vlxd21Ze6
         yl2hzxQ0FM1OL+qomTp3V3CFT0G5MeoHCssKqTVTXbwk+DrVHQdjJgtrO0vOm6AMYGwZ
         amrH2P+NRNa1ElDrLw6fk3cP4rU/v89a2cXFCXEOT4pcdePV4qAe33rNYeLyTIneOY3W
         yZBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zMQAIZcGPoAZR0d005NxFzAT1cH+2rezexuQq2s5Nmg=;
        b=r6zNuiM7hHUwsxyZU35jlFm6ZW9FVXfzURLkTSjtILBW9n2rnjGrrgvntjEHfO3NJQ
         VsCQ5vJia2qHKlXSdQY4Ui/odInyVwHVyuPaK5i4VohVuwUO+ekg9EShkcJcRjm/qi3s
         M8okH0V/oIHMC0XwDKpYVoVCjnJT3nJ+yYPj5gBDcb1Nd5cZLeJn+1OONmpeLPr3Vbnu
         IQUW5LV4oo2lji93z7Us0eU+AFSKIEENmm6jQ8/Z8ge7jwSyjtR+OOshNXRZWEWMw3aQ
         bq5zdJ6UwvMyUgLfBnSVNFzKs9xhW59WGllKHjpH1kZby5oIi9OKamVXDFbjYHVzwprI
         mWEQ==
X-Gm-Message-State: AOAM530KRJFivScNEpQLckjkPLPfvtg+xJIi49JA0CBBqhhZhFzbwA/L
        nwvsqqmKhT5G4dh+KEyqsvYQcHZFS4D4hKWGkaUzcw==
X-Google-Smtp-Source: ABdhPJzOv04ncKyacNrhyQgJgqiSy+AvgRyUtCA5QAtEfwBgWImBkmB4nfJXNJ0odR6ERj4vD1/Vyii3qz+IV/OlMpg=
X-Received: by 2002:a05:6512:6c9:: with SMTP id u9mr9486675lff.411.1628361333155;
 Sat, 07 Aug 2021 11:35:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210806182126.2842876-1-oupton@google.com> <87pmup1q8w.wl-maz@kernel.org>
In-Reply-To: <87pmup1q8w.wl-maz@kernel.org>
From:   Oliver Upton <oupton@google.com>
Date:   Sat, 7 Aug 2021 11:35:21 -0700
Message-ID: <CAOQ_QsiZgpHsLGF8Fp7+oiKPZXuW-vGsjPdpwKhJ06XZAxDfVQ@mail.gmail.com>
Subject: Re: [RESEND PATCH] clocksource/arm_arch_timer: Fix masking for high
 freq counters
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Shier <pshier@google.com>,
        Raghavendra Rao Ananta <rananta@google.com>,
        Ricardo Koller <ricarkol@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On Sat, Aug 7, 2021 at 3:52 AM Marc Zyngier <maz@kernel.org> wrote:
>
> Hi Oliver,
>
> On Fri, 06 Aug 2021 19:21:26 +0100,
> Oliver Upton <oupton@google.com> wrote:
> >
> > Unfortunately, the architecture provides no means to determine the bit
> > width of the system counter. However, we do know the following from the
> > specification:
> >
> >  - the system counter is at least 56 bits wide
> >  - Roll-over time of not less than 40 years
> >
> > To date, the arch timer driver has depended on the first property,
> > assuming any system counter to be 56 bits wide and masking off the rest.
> > However, combining a narrow clocksource mask with a high frequency
> > counter could result in prematurely wrapping the system counter by a
> > significant margin. For example, a 56 bit wide, 1GHz system counter
> > would wrap in a mere 2.28 years!
> >
> > This is a problem for two reasons: v8.6+ implementations are required to
> > provide a 64 bit, 1GHz system counter. Furthermore, before v8.6,
> > implementers may select a counter frequency of their choosing.
> >
> > Fix the issue by deriving a valid clock mask based on the second
> > property from above. Set the floor at 56 bits, since we know no system
> > counter is narrower than that.
> >
> > Suggested-by: Marc Zyngier <maz@kernel.org>
> > Signed-off-by: Oliver Upton <oupton@google.com>
> > ---
> > This patch was tested with QEMU, tweaked to provide a 1GHz system
> > counter frequency, as I could not easily figure out how to tweak the
> > base FVP to provide a 1GHz counter.
>
> <FVP>
> "bp.refcounter.base_frequency" is the property you are looking for. In
> general, passing --list-params to the model reveals a treasure trove
> of weird and wonderful options that can be used to configure the model
> to your liking.
> </FVP>

Ah! Thanks for the tip. I didn't find the fast models documentation to
be too terribly helpful.
> >
> > +/*
> > + * The minimum amount of time a generic timer is guaranteed to not roll over
>
> nit: s/timer/counter/
>

Ack.

> > + * (40 years)
>
> For later reference, could you add the section of the ARMv8 ARM where
> this is mentioned? Something like 'ARM DDI 0487G.a D11.1.2 ("The
> system counter")', either here or in the comment further down.
>

Sure thing. I think I'll drop it on the function below since we depend
on two properties of the system counter there.

> > +static int __init arch_counter_get_width(void)
> > +{
> > +     u64 min_cycles = MIN_ROLLOVER_SECS * arch_timer_get_cntfrq();
>
> That's unfortunately wishful thinking. We have stupidly broken systems
> out there that do not set CNTFRQ_EL0, and instead rely on DT
> properties to describe the counter frequency. You're likely to end up
> with a glorious zero as a result, with interesting consequences...

Blech. I didn't read the DT hooks for the driver.  That's awful.

> Use arch_timer_rate instead, which will be set as by the time you
> register the counter.

Ack.

>
> > +
> > +     /* guarantee the returned width is within the valid range */
> > +     return max(56, min(64, ilog2(min_cycles)));
>
> Maybe better written as "clamp_val(ilog2(min_cycles), 56, 64);".
>

Agreed.

> > +     width = arch_counter_get_width();
> > +     clocksource_counter.mask = CLOCKSOURCE_MASK(width);
> > +     cyclecounter.mask = CLOCKSOURCE_MASK(width);
>
> Since you move this to be computed at runtime, how about dropping the
> static initialisation of the mask fields?
>

Yep, already made the change locally after mailing out :)

> > +
> >       if (!arch_counter_suspend_stop)
> >               clocksource_counter.flags |= CLOCK_SOURCE_SUSPEND_NONSTOP;
> >       start_count = arch_timer_read_counter();
> > @@ -1040,8 +1065,7 @@ static void __init arch_counter_register(unsigned type)
> >       timecounter_init(&arch_timer_kvm_info.timecounter,
> >                        &cyclecounter, start_count);
> >
> > -     /* 56 bits minimum, so we assume worst case rollover */
> > -     sched_clock_register(arch_timer_read_counter, 56, arch_timer_rate);
> > +     sched_clock_register(arch_timer_read_counter, width, arch_timer_rate);
> >  }
> >
> >  static void arch_timer_stop(struct clock_event_device *clk)
>
> Another thing that needs addressing for high frequency counter support
> is to move away from TVAL programming and switch to CVAL, as the
> maximum deadline we can currently program is 4.2s at 1GHz.
>
> Fun fact: it has the interesting consequence of breaking XGene-1,
> which implemented CVAL in terms of TVAL instead of the other way
> around (what were these guys thinking?)

Yikes!

> , though I don't think anyone
> will notice in practice. I have a preliminary patch on a branch
> somewhere that I'll try to dust up and post in the coming days.

Sounds good, I'll clean this one up and send it out too.

--
Thanks,
Oliver
