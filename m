Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 088F93F8909
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 15:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242278AbhHZNes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 09:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbhHZNeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 09:34:46 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E81C061757
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 06:33:59 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id n5so5052093wro.12
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 06:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OT2SsyZ10OYeuy7VscVaFJwl6PBRquiIV5ifXUolnFM=;
        b=PoMFsDQMmczT1CVFz8jP/kDe8KUKNCjo8/yjmzfE7JBpEfUtPRol70KhKG8mRIwuMd
         wVJ2+ffUTqUq/cXoFwXLAOYhrRWSV+LgUQVUEgF9/w0/f3u95zXv+jV4LclFH0eCe/bI
         EiXdIQs2sNBtT9H9QCc1/LYvpUjJ07FgvEGQu+/HKNZC7V6cMHSFXaI1De+bn9CyLspl
         9kZ9yDnGAAfLmV0XonBxcblkBrF5ggTWBhs3EXnu3t6HAg+u9YgCsP7x2HkbYo7KQhoG
         ZKi3jaRNix7+ec5ulmmRfFOtxa3B7D5t/IZ63Y6kWUUdA6+qO3wsPe4w+wapgMiozhmH
         aPvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OT2SsyZ10OYeuy7VscVaFJwl6PBRquiIV5ifXUolnFM=;
        b=HvhAoQj0lBa1xVgabUwbb/EXCra52S/CCWZ5P/+rWesBRC4PbbIArs5rf2d9DQ8ZYV
         MrCzQH+iKIyX0XgsRUJZSK3LwNd7Br65lDct9gO71gSS/zcUihF7g+hKoTkV0v5b3Ycs
         OqHIx0HGRIzi1K51wnp1KPYYJbYNJ6yz9tTagbmrEVCpsT+ZVoPXUFcUl/VUZ7mwVA7D
         FCuclmWIwqXfeAVO6xJ2PaZwaZZD2GjQOTv3BKhA8dEdOI0pTORFX/lkn7rf8QC+abUo
         5JELSprM2WXTXh7M8fZ+4LGFZ3Gvik55rDHV5wQmzgX/TDt7asn/3GPZR3TeTUfmZHYN
         VK6Q==
X-Gm-Message-State: AOAM530th8y5Gt0PJ1VOu0us+NBMMzCql1tKygdyOBpma5w+HNFmAE83
        VBXHA37qHyuTpqT9snvgKpo=
X-Google-Smtp-Source: ABdhPJyztkmOyXTnjwrWEqUA3gbrsQ3AIhgAmCcGdTjYzNGZUNdqH6uRRXW3uKKf+XqHWygwnU0IgQ==
X-Received: by 2002:a5d:460a:: with SMTP id t10mr4064638wrq.147.1629984837694;
        Thu, 26 Aug 2021 06:33:57 -0700 (PDT)
Received: from skbuf ([82.78.148.104])
        by smtp.gmail.com with ESMTPSA id d9sm3981805wrb.36.2021.08.26.06.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 06:33:57 -0700 (PDT)
Date:   Thu, 26 Aug 2021 16:33:55 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Mark Brown <broonie@kernel.org>, Lee Jones <lee.jones@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
        Esben Haabendal <esben@geanix.com>
Subject: Re: "BUG: Invalid wait context" in ls_extirq_set_type
Message-ID: <20210826133355.lbb26bdf4ov5jjyp@skbuf>
References: <20210825135438.ubcuxm5vctt6ne2q@skbuf>
 <26de7b85-e466-e9af-077a-9d1dc087e061@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26de7b85-e466-e9af-077a-9d1dc087e061@rasmusvillemoes.dk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2021 at 11:01:31AM +0200, Rasmus Villemoes wrote:
> On 25/08/2021 15.54, Vladimir Oltean wrote:
> > Hi,
> >
> > Apologies for my novice level of understanding. I see a stack trace on
> > my system and would like to understand what is the correct way to get
> > rid of it.
> >
> > I have a consumer of the drivers/irqchip/irq-ls-extirq.c driver which
> > calls request_threaded_irq.
> >
> > struct irq_desc has a lock which is a raw spinlock.
> > The __setup_irq function takes this desc->lock raw spinlock, then calls
> > __irq_set_trigger. Finally this calls chip->irq_set_type which is
> > implemented by ls_extirq_set_type.
> >
> > The problem is that ls_extirq_set_type uses regmap_update_bits, which
> > ends up taking a non-raw spin lock, the kind that becomes sleepable on RT
> > (this system is not RT, but still).
> > So that's kind of bad, and this is what the stack trace below is saying:
> >
>
> So, we've been using the irq-ls-extirq driver for years, on an RT
> kernel, without seeing something like that. Does it require certain
> debug knobs in .config? Or perhaps the sanity checks have been added
> later, we've mostly been using it on 4.14.y and 4.19.y.

Grepping for "BUG: Invalid wait context" in the kernel yields a single
hit, and answers both questions. It was added by commit

commit de8f5e4f2dc1f032b46afda0a78cab5456974f89
Author: Peter Zijlstra <peterz@infradead.org>
Date:   Sat Mar 21 12:26:01 2020 +0100

    lockdep: Introduce wait-type checks

    Extend lockdep to validate lock wait-type context.

and selectable via "config PROVE_RAW_LOCK_NESTING".

>
> I don't know what the right fix is. Am I right when a say that for !RT,
> spinlock==raw_spinlock? If so, switching regmap's spinlock to
> raw_spinlock would be nop for !RT and fix this issue, but would of
> course have quite far-reaching effects on RT kernels.

far-reaching? Explain?
It is _a_single_register_, accessed once per IRQ line, all at consumer driver probe time
(typically boot time).

We are not switching regmap from normal to raw spinlocks, we are just
adding the option for raw spinlocks for this one register.

> Perhaps it's silly for the driver to use syscon's regmap to access that
> single register, maybe it should just iomap it itself, and protect
> access with a raw_spinlock of its own. While syscon's regmap would cover
> that intpcr register, nobody else would ever access it, so that should
> work fine.

I believe my competence ends here, I will re-read Arnd's email too, but
I just don't see how the syscon API gives you something that is "not a
regmap", something you can ioremap yourself as a consumer driver.

> Then there's your suggestion. While there's nothing wrong with adding
> raw_spinlock lock support in regmap, the fact that nobody has needed
> that till now suggests that one should at least pause and think about
> other options. And you point out the weaknesses of basing the
> .use_raw_spinlock on a .compatible string yourself.
>
> > What to do?
>
> TL;DR: I don't know.
>
> Rasmus
