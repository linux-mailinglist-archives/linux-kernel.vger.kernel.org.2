Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C06EC3E37C9
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Aug 2021 03:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbhHHBPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 21:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbhHHBPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 21:15:07 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D7C7C061760
        for <linux-kernel@vger.kernel.org>; Sat,  7 Aug 2021 18:14:48 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id c16so26328445lfc.2
        for <linux-kernel@vger.kernel.org>; Sat, 07 Aug 2021 18:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wwLB2sgxDNJxrsRKy3cO69bGswM3jHSxHYZRFy23cBc=;
        b=K7KcvIxFqTEDS3+xkumu+uHP34AJ9RoRjJH3XT4D6bLzIx6tnzHyOs/hyiPVRCVNV4
         YSVMJ6R5Qb/7dP9Eti8+ENQTPfsuWIY8PG+tfSe9Xe10lS4TI57U30yo4iGU4Ajfcoyc
         oZ3XsyNGwvHuspquRpLk6g5auLI+8IKt+DTIX7ftcpEw4+20cO3kjQilh2W/fMDQSnmN
         DyupLlbBAAXKUKCelgYlpvnYfUA5A3UKQ5wm6itiV49QSrfhnpPBxuR6xoCFyNt1aIDQ
         cNKwi23qgPW4NhpDlVT7dl42heEW2rXalzcT5LtDyMHbfiS3xyGGrD80faiQrqNkDBjD
         xAXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wwLB2sgxDNJxrsRKy3cO69bGswM3jHSxHYZRFy23cBc=;
        b=Fv3CFCnp/INrrspiyv8gX0Grj6oAQZcvNOQ+mvO+CdzmF7nCps6rY9qjJW9gmMI7qt
         fRq1qB0tmQEvKaEsj7vTWcnJT+coJEterFB/My84FqG3coMF2Qa+Mh3SLMPQb2eGbJo2
         0MBRN6qkmLhvzsa3qfasefvlwS2oHmjLNQ3UEbVPob/3etuZeaiwm/jx6EaiIQ3RlZ+I
         Mot4zpixI/91ClFCo9e8k9Ew4xzK9IIcfIxtAK00+ePjCV/QPHfh+8aZYra31r9ACmVs
         HwVt/9zWa0rgEbRaYBWNQtl4nXzJr25nTcQNAq19waHLGtqOS62myYISXGBEFXPK5Z2E
         WfjQ==
X-Gm-Message-State: AOAM5337uQq1Tm+JDHpekCrXISdTVMdASA5CJs7YlHf+3UY0tbRDlOtn
        IkZxLuYTgG2gAeZz8GYpnRMs96NLOXC8BtE/kFajsw==
X-Google-Smtp-Source: ABdhPJxllwS7CLfo+9Wlvp/JFo4cLPm0AwBFYrBLQKQz9C8nbjoskdBYsxUVEWavkvBYVgHb8+bDcvtgE7A5HGBINAg=
X-Received: by 2002:ac2:429a:: with SMTP id m26mr12394342lfh.80.1628385286677;
 Sat, 07 Aug 2021 18:14:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210807191428.3488948-1-oupton@google.com> <CACRpkdYPEGygxAtU8jrCtnJsQr_JoYkBCRGpRFpvxGiOzUmxgg@mail.gmail.com>
In-Reply-To: <CACRpkdYPEGygxAtU8jrCtnJsQr_JoYkBCRGpRFpvxGiOzUmxgg@mail.gmail.com>
From:   Oliver Upton <oupton@google.com>
Date:   Sat, 7 Aug 2021 18:14:35 -0700
Message-ID: <CAOQ_QsiECN7iVDyiyos12tk__viGkFhH9b6ZfkZVAYjeKhB=pQ@mail.gmail.com>
Subject: Re: [PATCH v2] clocksource/arm_arch_timer: Fix masking for high freq counters
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Shier <pshier@google.com>,
        Raghavendra Rao Ananta <rananta@google.com>,
        Ricardo Koller <ricarkol@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Sat, Aug 7, 2021 at 3:30 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Sat, Aug 7, 2021 at 9:14 PM Oliver Upton <oupton@google.com> wrote:
>
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
>
> This patch looks good to me:
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>

Thanks for the review!

> Just a thought that crossed my mind: as this is real hardware we are
> talking about mostly, how hard would it be for arch_counter_get_width()
> to detect how wide it actually is if nbits > 56?
>
> I would do something like this pseudocode:
>
> nbits = 56;
> while (nbits < 64)
>     startval = GENMASK(nbits, 0);
>     write_counter(startval);
>     start_counter;
>     nsleep(1);
>     stop_counter;
>     now = read_counter;
>     if (now < startval)
>          /* Ooops it wrapped */
>          break;
>     nbits++
>
> pr_info("counter has %d bits\n", nbits);
>
> Or did you folks already try this approach?

This would be a good idea, although I believe our only means of
offsetting the counter are available in EL2. I had thought we could
use a CVAL register instead, but this quote from the ARM ARM doesn't
imply the CVAL bit width matches that of the system counter:

<quote>
If the Generic counter is implemented at a size less than 64 bits,
then this field is permitted to be implemented at the same width as
the counter, and the upper bits are RES0.
</quote>

The only other sane idea that I could come up with is providing this
information to the kernel through DT, although that would leave ACPI
systems behind.

--
Thanks,
Oliver
