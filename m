Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ADBF3E3C56
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Aug 2021 21:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232477AbhHHTBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Aug 2021 15:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232284AbhHHTBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Aug 2021 15:01:44 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C18C061760
        for <linux-kernel@vger.kernel.org>; Sun,  8 Aug 2021 12:01:24 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id h11so5296928ljo.12
        for <linux-kernel@vger.kernel.org>; Sun, 08 Aug 2021 12:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PjnX2TEMPAPiZ/kp81d0YhSgmUwTPzKGuUQM+YmXs4c=;
        b=JRpXYGUv2G/4ssKII2wJcey4sbrhrFwvQDc2CpNEI3hsE14FBi43tpu/MKvyyPiXxX
         c0t/C3ROjaZsz+7Lck4xhjiD9o4xAqQtijKSnxuFW2YbUFoyjt0GvUoNM4zWNmK+ETTF
         AqP6yojgSdFv+8C4QfYzcB+XUK86xx9ERciBYNmSxjJb3KPLgVr6LO2egxKReJALYl6A
         y2RZS8ZtO2IW5oAxVchiVV36oY8I2Ra3JMZ8uRGcDpqaW3z7SCSEzxOL7W6nQVk9TTHU
         AGMZguzrOBV+LAb+8qPFjHlXTBJh2W/7QBwC2X6h9PvgUj6KKWtgcHlD4pW90Ps8KGNM
         waoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PjnX2TEMPAPiZ/kp81d0YhSgmUwTPzKGuUQM+YmXs4c=;
        b=LXlkmTZpP5jVNaTEF6LKMHh8uZMIK1ZKNTvS25Eq+RYNBpzapMGt2VbE9znyeB7amW
         oPMk+mlEfEcTh/BxD20VVNLQmWubdNgmRq7cMIKx8mmCTDyZr8DUZWkGWBk28PWRBrAz
         qFnAP6GzxopC547ffEihHCiIJJ1MiifQmpZoCQ3MHI5O2MniQiHA1TjIonwGFXzW49WG
         CzRJmeD1JgdCq4gjJhUVMNrhDEfRStAgPMJ9WIerP6G9Gc6irbeQDnZsGQw2j0JOFmXg
         1ehNa7Lv36DToTU8CXegryCIPL7KduR8n4wlMTSVC7dfwRjyTL3wgh5SI2gtelkZcuE0
         trQg==
X-Gm-Message-State: AOAM532E9cgKhqCGgMUMBUVW3pyZRpe5gBZgeRYVLWf7La6TZMSkddDw
        d9ve2AAd7baBjXX6e5DbsYQluXnD9a3ZLnHXKksuFg==
X-Google-Smtp-Source: ABdhPJyPnh5yn6wq7Jj3tFhTDnKXZVlu3fnXEVebob8cNhVvYtEE04eE6QUQbuRLKHswuIaH6udlQsYAelN2uAuKZDI=
X-Received: by 2002:a05:651c:1119:: with SMTP id d25mr7173477ljo.129.1628449282038;
 Sun, 08 Aug 2021 12:01:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210807191428.3488948-1-oupton@google.com> <CACRpkdYPEGygxAtU8jrCtnJsQr_JoYkBCRGpRFpvxGiOzUmxgg@mail.gmail.com>
 <CAOQ_QsiECN7iVDyiyos12tk__viGkFhH9b6ZfkZVAYjeKhB=pQ@mail.gmail.com> <87lf5c1aox.wl-maz@kernel.org>
In-Reply-To: <87lf5c1aox.wl-maz@kernel.org>
From:   Oliver Upton <oupton@google.com>
Date:   Sun, 8 Aug 2021 12:01:10 -0700
Message-ID: <CAOQ_Qsi-r0=YubmaTezB7Cq-RhzU3njWm+P5w-RWZcUz4kMfDA@mail.gmail.com>
Subject: Re: [PATCH v2] clocksource/arm_arch_timer: Fix masking for high freq counters
To:     Marc Zyngier <maz@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
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

On Sun, Aug 8, 2021 at 3:40 AM Marc Zyngier <maz@kernel.org> wrote:
>
> On Sun, 08 Aug 2021 02:14:35 +0100,
> Oliver Upton <oupton@google.com> wrote:
>
> > The only other sane idea that I could come up with is providing this
> > information to the kernel through DT, although that would leave ACPI
> > systems behind.
>
> It also has the disadvantage that a large number of DT timer nodes are
> a mess of cargo-culted, copy-pasted idioms, and that adding another
> property would only make it worse.

Agreed, this does seem like the best solution, short of the
architecture actually providing something to determine the counter
width.

On that note, I wonder how (if ever) we will be able to move away from
unnecessarily masking a 64 bit counter, i.e. a v8.6 or above
implementation. With this patch, one such counter would wrap after
36.56 years, short of the 40 year guarantee we have from the
architecture for < v8.6 implementations. Getting it to 64 bits would
squarely make it someone else's problem ~585 years from now :)

--
Thanks,
Oliver
