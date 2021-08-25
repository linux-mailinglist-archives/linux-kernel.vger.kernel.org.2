Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 765F33F7E12
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 00:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234711AbhHYWBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 18:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbhHYWBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 18:01:13 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABEE2C061757
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 15:00:26 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id b6so1554904wrh.10
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 15:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VP7hAF8ls8WkvlCHkg0U3S1rBI/H+rl66JEKTeyx4Ek=;
        b=os8ABd0qMG0XdDqkzJllzSwLfCjDVzZG3rxntC5ImhFvnkPh6Ylm8zs0CVt+SXOvuI
         XR2BFGLXLJauMJ30h0XkZmxN1JiNjTyQ8bIIJnDrf9ab/GEPC8iLmUhax2t0QvkY3sBm
         xSOlpWtcMzyr3seI08A7kspdkpExv1wIz+2mD84XTwYfScGq3RlsLvq7d9iHDY26AFwi
         ydmq/zFXz/ZcCrzZFAGwdgngc+66mA4l1i+vOScBMPMiMXvIgPkGHjjhSytgpKHn9cUC
         1+LUfHiiHxHXz6DeS0rOVKmN+gIbbI501qOMMWw0+5IJ2tDwIcNETy3OGXcqwfG7Qjsu
         E9Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VP7hAF8ls8WkvlCHkg0U3S1rBI/H+rl66JEKTeyx4Ek=;
        b=aH9/pMXvONAw4+08BMUDZ+3Q9HKrrX3hnNvS2ema07ZVaiPGQG1F/EZ50gPgAjy/wl
         +1d+WA8A9tnkAdZF6wzy7hx70BZrPmQNI5kwAsq3LfLiWo/qdOMksKsjIACT3CELbr7W
         WNyVW6uyHIp5wLMdfcfA++s1pVU5phHWNFBbpN21yywShu3vnOkv4jG+2Xsi+KjvlpZa
         AH+4RzytmWbFEUTCqDnMntU8hMhm8mtgedh448ATz3rRSIR8tEVCEyD37fw3EZAJ1SGI
         B2c7n/rVKn6+jt7UL36OBJ6v8RF573vqbuthHWiTPTaZaVeqsU2BnWBW+IF8rK2o2O4k
         tatQ==
X-Gm-Message-State: AOAM532sSpQD6yT8crhMoDLL/dQB6ItVU5sDNgvUGU5ZAcNBz8jaKaFJ
        nkDm5KoIL/KQFu4KMzkYC/Xj6Pbzis0=
X-Google-Smtp-Source: ABdhPJz6peHOyG55+BQXdhcUVTJxayq7JyIyWiBK6YJ0S9CeelSDlu4i1WQD43ExB5/rWCtfsAdeUg==
X-Received: by 2002:adf:f143:: with SMTP id y3mr319126wro.168.1629928825207;
        Wed, 25 Aug 2021 15:00:25 -0700 (PDT)
Received: from skbuf ([82.78.148.104])
        by smtp.gmail.com with ESMTPSA id k4sm1076132wrm.74.2021.08.25.15.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 15:00:24 -0700 (PDT)
Date:   Thu, 26 Aug 2021 01:00:23 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Vladimir Oltean <vladimir.oltean@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Lee Jones <lee.jones@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Biwen Li <biwen.li@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] mfd: syscon: request a regmap with raw spinlocks for
 some devices
Message-ID: <20210825220023.rqskspy2usvleoqr@skbuf>
References: <20210825205041.927788-1-vladimir.oltean@nxp.com>
 <20210825205041.927788-3-vladimir.oltean@nxp.com>
 <CAK8P3a1oDeU-S5dLqKTT3YFvGREvNt_a=PTkVoDhUJYquJGePQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1oDeU-S5dLqKTT3YFvGREvNt_a=PTkVoDhUJYquJGePQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2021 at 11:24:52PM +0200, Arnd Bergmann wrote:
> On Wed, Aug 25, 2021 at 10:50 PM Vladimir Oltean
> <vladimir.oltean@nxp.com> wrote:
> >
> > This patch solves a ls-extirq irqchip driver bug in a perhaps
> > non-intuitive (at least non-localized) way.
> >
> > The issue is that ls-extirq uses regmap, and due to the fact that it is
> > being called by the IRQ core under raw spinlock context, it needs to use
> > raw spinlocks itself. So it needs to request raw spinlocks from the
> > regmap config.
> >
> > All is fine so far, except the ls-extirq driver does not manage its own
> > regmap, instead it uses syscon_node_to_regmap() to get it from the
> > parent syscon (this driver).
> >
> > Because the syscon regmap is initialized before any of the consumer
> > drivers (ls-extirq) probe, we need to know beforehand whether to request
> > raw spinlocks or not.
> >
> > The solution seems to be to check some compatible string. The ls-extirq
> > driver probes on quite a few NXP Layerscape SoCs, all with different
> > compatible strings. This is potentially fragile and subject to bit rot
> > (since the fix is not localized to the ls-extirq driver, adding new
> > compatible strings there but not here seems plausible). Anyway, it is
> > probably the best we can do without major rework.
> >
> > Suggested-by: Mark Brown <broonie@kernel.org>
> > Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
>
> This should work, but how hard would it be to change the ls-extirq
> driver instead to not use the syscon driver at all but make the extirq
> driver set up the regmap itself?
>
> Are there any other users of the syscon?

Not that I can see, but that doesn't make the fact that it uses a syscon a bad decision.

For context, Layerscape devices have a "Misc" / "And Others" memory region
called "Supplemental Configuration Unit" (SCFG) which "provides the
chip-specific configuration and status registers for the device. It is the
chip-defined module for extending the device configuration unit (DCFG) module."
to quote the documentation.

The ls-extirq file is a driver around _a_single_register_ of SCFG. SCFG
provides an option of reversing the interrupt polarity of the external IRQ
pins: make them active-low instead of active-high, or rising instead of
falling.

The reason for the existence of the driver is that we got some pushback during
device tree submission: while we could describe in the device tree an interrupt
as "active-high" and going straight to the GIC, in reality that interrupt is
"active-low" but inverted by the SCFG (the inverted is enabled by default).
Additionally, the GIC cannot process active-low interrupts in the first place
AFAIR, which is why an inverter exists in front of it.

Some other SCFG registers are (at least on LS1021A):

Deep Sleep Control Register
eTSEC Clock Deep Sleep Control Register (eTSEC is our Ethernet controller)
Pixel Clock Control Register
PCIe PM Write Control Register
PCIe PM Read Control Register
USB3 parameter 1 control register
ETSEC MAC1 ICID
SATA ICID
QuadSPI configuration
Endianness Control Register
Snoop configuration
Interrupt Polarity <- this is the register controlled by ls-extirq
etc etc.

Also, even if you were to convince me that we shouldn't use a syscon, I feel
that the implication (change the device trees for 7 SoCs) just to solve a
kernel splat would be like hitting a nail with an atomic bomb. I'm not going to
do it.
