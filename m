Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1BF13E3766
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Aug 2021 00:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbhHGWax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 18:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbhHGWaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 18:30:52 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B450C061760
        for <linux-kernel@vger.kernel.org>; Sat,  7 Aug 2021 15:30:34 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id b6so9481716lff.10
        for <linux-kernel@vger.kernel.org>; Sat, 07 Aug 2021 15:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h3euVpJgEjMjWH6KpM1SDhO+CKYMPA0RpWax7oFssMk=;
        b=ExBygCcFiFcsUM0rKb5xSAOAPHAVryFMAZ9arRJvMuUtltf6tecnncWkNdeoWplPdT
         1vkprJXb6puvREwGfxm4CKVYSV0qiLcTdpwpizSEPRDKIJ9AhtXmVcDGcLX8N2BOmyKr
         CqwIeEuYd6NYS9popUmnMn01KBH420NXDmksueUTSJx9oy7387J0S7MJWz13f9CKF4mR
         cNA7xe61nGGtqYn55RYmgMdohoo7dFeNlLwdOgXS/1YimTjx63Tnwc2ZU4gMQ1Wgb3HW
         pCKzCsVjXKSKs99d6mg+gX1louYahkeXfsX1PKvOSJlIZNBF7gw9fT9cvZY7uzbzDzvx
         fKUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h3euVpJgEjMjWH6KpM1SDhO+CKYMPA0RpWax7oFssMk=;
        b=tQsQvOYkrTd9zYqIIABvYw/qdiqhmUiAgwVgTErkFra0AkBTM23u/x7uEQP3O22H68
         Jkpp/A6WLbPNHGDcpELkNj432JPj/vE94ROIw9jYTF1/kVunPh8UwmEM2awigtKuVsXi
         gS5sX91Q9B1KwxUxH9flxYH6mlrmmI+ic8sAQbBJ40be7FDmP3t8B430WoRs4UXLfKqM
         XOoM9Erze5ZHRZbnkoGAraAG81wD1DjhCSr1JGpLtmBj0HgTlXdBbCGLkggW9R7Db5re
         j0v+LN7waKmKx1glvz8Q3Gz12FCNTySlH+fsiI4l6/eEcjd+m+uKxotdX1DLcBkTDep3
         Vgkw==
X-Gm-Message-State: AOAM5303JNYOSFN2P/W4YjavfWth645ANkM103JkDVmnYR1umL4t1L63
        e6DkZRH8p47M9F4ckrIQgV9frX/clhouF1la9EdMeg==
X-Google-Smtp-Source: ABdhPJyIlqrjyHmzNWa7x4ijGMsV/3aCejAtDRcqB7OwjB5Mzl2W0PQVpnkjunueAu+eWbTxBzpsFny0pq9sK/yqi7U=
X-Received: by 2002:a05:6512:32a3:: with SMTP id q3mr855898lfe.157.1628375431922;
 Sat, 07 Aug 2021 15:30:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210807191428.3488948-1-oupton@google.com>
In-Reply-To: <20210807191428.3488948-1-oupton@google.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 8 Aug 2021 00:30:20 +0200
Message-ID: <CACRpkdYPEGygxAtU8jrCtnJsQr_JoYkBCRGpRFpvxGiOzUmxgg@mail.gmail.com>
Subject: Re: [PATCH v2] clocksource/arm_arch_timer: Fix masking for high freq counters
To:     Oliver Upton <oupton@google.com>
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

On Sat, Aug 7, 2021 at 9:14 PM Oliver Upton <oupton@google.com> wrote:

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

This patch looks good to me:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Just a thought that crossed my mind: as this is real hardware we are
talking about mostly, how hard would it be for arch_counter_get_width()
to detect how wide it actually is if nbits > 56?

I would do something like this pseudocode:

nbits = 56;
while (nbits < 64)
    startval = GENMASK(nbits, 0);
    write_counter(startval);
    start_counter;
    nsleep(1);
    stop_counter;
    now = read_counter;
    if (now < startval)
         /* Ooops it wrapped */
         break;
    nbits++

pr_info("counter has %d bits\n", nbits);

Or did you folks already try this approach?

Yours,
Linus Walleij
