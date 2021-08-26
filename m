Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7C2A3F90D1
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 01:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243731AbhHZXC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 19:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbhHZXCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 19:02:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F23C061757
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 16:01:37 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630018896;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QhAhXFtWFEQ6Fdud3DSVJ+WltS966zTxEwlJ84LG7/A=;
        b=D31R1diY5EMMf2tOjF+6cu84KqhQ5KjS9eZ1nxjl3GKuOUhT28KjdP4VwVjzktiUynTz2n
        hnzf3tjdblm0GLkZU4vrbOqkA5/i1+82PTLU3WS017cseiPuy7ya5miPR934n8r5W+AmG+
        NYf4klgm8B+blGOWYDAtzBjdy0KTJU/9Tq3bqXhkkAszQHmSS5NApbLt+/jLwzUD+iGE1n
        i141aTUPdJQXsXWNAQtxrTTuBmTOXqlImhZAE7YbPVyfpjIR5ybtfj+jS3vsDGfOkqAwcm
        09avdmN++wpUj8gtICzLu7u13uB1DIita/QGoxl6Yb7nfKHESdVm1Ss02TINGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630018896;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QhAhXFtWFEQ6Fdud3DSVJ+WltS966zTxEwlJ84LG7/A=;
        b=IOd1zB7uwqqmnYnXZMHPbcYVak9RPVS0waZw011OMQ8Ky2nld5qhyi1TZfkw2AKtqTOL6+
        5Aw+UnQJxXtxkPDA==
To:     Vladimir Oltean <vladimir.oltean@nxp.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Lee Jones <lee.jones@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <maz@kernel.org>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Biwen Li <biwen.li@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] regmap: teach regmap to use raw spinlocks if
 requested in the config
In-Reply-To: <20210825205041.927788-2-vladimir.oltean@nxp.com>
References: <20210825205041.927788-1-vladimir.oltean@nxp.com>
 <20210825205041.927788-2-vladimir.oltean@nxp.com>
Date:   Fri, 27 Aug 2021 01:01:35 +0200
Message-ID: <875yvr3j5c.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25 2021 at 23:50, Vladimir Oltean wrote:

> Some drivers might access regmap in a context where a raw spinlock is
> held. An example is drivers/irqchip/irq-ls-extirq.c, which calls
> regmap_update_bits() from struct irq_chip :: irq_set_type, which is a
> method called by __irq_set_trigger() under the desc->lock raw spin lock.
>
> Since desc->lock is a raw spin lock and the regmap internal lock for
> mmio is a plain spinlock (which can become sleepable on RT), this is an
> invalid locking scheme and we get a splat stating that this is a
> "[ BUG: Invalid wait context ]".
>
> It seems reasonable for regmap to have an option use a raw spinlock too,
> so add that in the config such that drivers can request it.

What's reasonable about that?

What exactly prevents the regmap locking to use a raw spinlock
unconditionally?

Even for the case where the regmap is not dealing with irq chips it does
not make any sense to protect low level operations on shared register
with a regular spinlock. I might be missing something though...

Thanks,

        tglx



