Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A04533E5669
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 11:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233628AbhHJJKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 05:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbhHJJKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 05:10:21 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F512C0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 02:09:59 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id m18so16706721ljo.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 02:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JnJ0T/rRMAww2rZUPvrvzkcO1SdypMaqmfJvjZnDJQ8=;
        b=TxI0AalAZbS9JUclyc8EbgwKcG7AX5v42uqGFcg1AdQtSaPygBRl7xHOW5GaVFd2uD
         17RoplHZhLe2joauVmXijZmkAc9IiNwF1PWcFp1F/klB6pDaMdu1fn7i3X259ti2/Y+p
         D5Tgiau9QG/ElhpJqOrs1B5Skg3XnKZNxD8sYs4fx66Oa4qau0AezHTinHdQl0hlRzEa
         NqsBg3Od9hU+GwYeSui/Dvg2NtO7FwEq4/lFqFmmO5gn4Z/v8YGjiEOhWAIGeWldUaFW
         TPR0Hvnt8tah6q++nG9Qo9gn2GKtv3zpwOTH7U6AtHTxXLHr/HzTT/avVDcoqgkTSidX
         2Vlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JnJ0T/rRMAww2rZUPvrvzkcO1SdypMaqmfJvjZnDJQ8=;
        b=SSzCZSaatkt+pBqAuEeLr2tmbmJVoZ9Fb3Dfnv5DaoTHw7zEpgN/LKVroiW2gzQz9p
         04g6S64FdLJIoasUyqR5k9nhvZ4tMeyXQEfirMaWghO+KSYnbcbMcB8DpFg/zEoH9V30
         6BB2VvpZoumhyI0ORSLqyuezz1E+gUQPaaLuPoaoNU3ur73DCZLhO30Q0xYRTdiyMOuC
         K4x6Fv93am10rjtISTusix6tc595UBaBcN+H4jVHMvMcCEeeOODeuj1XjVkidVwTgiR1
         km7Ye/IZ+TlotSmRrwWUIONbsjObqjef1At/qSZNllXCqi/3UAwhD0/ZwR3qfzkOf+iV
         xE3A==
X-Gm-Message-State: AOAM530GdT403/cy69mrYKnMqZHqjyxMhHsfkPBeotniqCdEJ8HHgnEW
        sEThKkS+SKXCkTzGlELgNsynYFUrK8p6o0/2kVTBgw==
X-Google-Smtp-Source: ABdhPJwR7hlGhSgg9cQauZw9iEQxX2GhJV47JDweuivNr9zqWSWukRwYXgZ3uj9w0QnsrqIQ3VnlUa9bwCDKv5Eb2Ao=
X-Received: by 2002:a2e:89c4:: with SMTP id c4mr18482300ljk.275.1628586597590;
 Tue, 10 Aug 2021 02:09:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210809152651.2297337-1-maz@kernel.org> <20210809152651.2297337-12-maz@kernel.org>
 <CAOQ_Qshfi=RN8fExhXQh1i640LAZaZjQSJApyvdU2Gva9KtFaQ@mail.gmail.com> <87eeb1bsl6.wl-maz@kernel.org>
In-Reply-To: <87eeb1bsl6.wl-maz@kernel.org>
From:   Oliver Upton <oupton@google.com>
Date:   Tue, 10 Aug 2021 02:09:46 -0700
Message-ID: <CAOQ_QsjWH5EL-ajadf4PT3R_0TqrucaN4c5m0YvOj6Foh00sQg@mail.gmail.com>
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

On Tue, Aug 10, 2021 at 1:40 AM Marc Zyngier <maz@kernel.org> wrote:
>
> On Mon, 09 Aug 2021 17:45:28 +0100,
> Oliver Upton <oupton@google.com> wrote:
> >
> > On Mon, Aug 9, 2021 at 8:48 AM Marc Zyngier <maz@kernel.org> wrote:
> > >
> > > From: Oliver Upton <oupton@google.com>
> > >
> > > Unfortunately, the architecture provides no means to determine the bit
> > > width of the system counter. However, we do know the following from the
> > > specification:
> > >
> > >  - the system counter is at least 56 bits wide
> > >  - Roll-over time of not less than 40 years
> > >
> > > To date, the arch timer driver has depended on the first property,
> > > assuming any system counter to be 56 bits wide and masking off the rest.
> > > However, combining a narrow clocksource mask with a high frequency
> > > counter could result in prematurely wrapping the system counter by a
> > > significant margin. For example, a 56 bit wide, 1GHz system counter
> > > would wrap in a mere 2.28 years!
> > >
> > > This is a problem for two reasons: v8.6+ implementations are required to
> > > provide a 64 bit, 1GHz system counter. Furthermore, before v8.6,
> > > implementers may select a counter frequency of their choosing.
> > >
> > > Fix the issue by deriving a valid clock mask based on the second
> > > property from above. Set the floor at 56 bits, since we know no system
> > > counter is narrower than that.
> > >
> > > Suggested-by: Marc Zyngier <maz@kernel.org>
> > > Signed-off-by: Oliver Upton <oupton@google.com>
> > > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> > > [maz: fixed width computation not to lose the last bit, added
> > >       max delta generation for the timer]
> > > Signed-off-by: Marc Zyngier <maz@kernel.org>
> > > Link: https://lore.kernel.org/r/20210807191428.3488948-1-oupton@google.com
> > > ---
> > >  drivers/clocksource/arm_arch_timer.c | 34 ++++++++++++++++++++++++----
> > >  1 file changed, 29 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
> > > index fa09952b94bf..74eca831d0d9 100644
> > > --- a/drivers/clocksource/arm_arch_timer.c
> > > +++ b/drivers/clocksource/arm_arch_timer.c
> > > @@ -52,6 +52,12 @@
> > >  #define CNTV_CVAL_LO   0x30
> > >  #define CNTV_CTL       0x3c
> > >
> > > +/*
> > > + * The minimum amount of time a generic counter is guaranteed to not roll over
> > > + * (40 years)
> > > + */
> > > +#define MIN_ROLLOVER_SECS      (40ULL * 365 * 24 * 3600)
> > > +
> > >  static unsigned arch_timers_present __initdata;
> > >
> > >  struct arch_timer {
> > > @@ -95,6 +101,22 @@ static int __init early_evtstrm_cfg(char *buf)
> > >  }
> > >  early_param("clocksource.arm_arch_timer.evtstrm", early_evtstrm_cfg);
> > >
> > > +/*
> > > + * Makes an educated guess at a valid counter width based on the Generic Timer
> > > + * specification. Of note:
> > > + *   1) the system counter is at least 56 bits wide
> > > + *   2) a roll-over time of not less than 40 years
> > > + *
> > > + * See 'ARM DDI 0487G.a D11.1.2 ("The system counter")' for more details.
> > > + */
> > > +static int arch_counter_get_width(void)
> > > +{
> > > +       u64 min_cycles = MIN_ROLLOVER_SECS * arch_timer_rate;
> > > +
> > > +       /* guarantee the returned width is within the valid range */
> > > +       return clamp_val(ilog2(min_cycles - 1) + 1, 56, 64);
> > > +}
> >
> > Reposting thoughts from the original patch:
> >
> > Reading the ARM ARM
> > D11.1.2 'The system counter', I did not find any language that
> > suggested the counter saturates the register width before rolling
> > over. So, it may be paranoid, but I presumed it to be safer to wrap
> > within the guaranteed interval rather (40 years) than assume the
> > sanity of the system counter implementation.
>
> I really don't think that would be a likely implementation. The fact
> that the ARM ARM only talks about the width of the counter makes it a
> strong case that there is no 'ceiling' other than the natural
> saturation of the counter, IMO. If a rollover was allowed to occur
> before, it would definitely be mentioned.
>
> Think about it: you'd need to implement an extra comparator to drive
> the reset of the counter. It would also make the implementation of
> CVAL stupidly complicated: how do you handle the set of values that
> fit in the counter width, but are out of the counter range?
>
> Even though the architecture is not the clearest thing, I'm expecting
> the CPU designers to try and save gates, rather than trying to
> implement a GOTCHA, expensive counter... ;-)

Fair, I'll put the tinfoil away then :) Just wanted to avoid reading
between the lines, but it would be rather stunning to encounter
hardware in the wild that does this. Your additions to the patch LGTM.

--
Thanks,
Oliver
