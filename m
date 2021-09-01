Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6E33FD467
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 09:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242579AbhIAH2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 03:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbhIAH2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 03:28:52 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95779C061575
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 00:27:56 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d17so951215plr.12
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 00:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Fc6CZS+bGPvfj267sYMmDl3dI5YtuEsdV4q3SHhX8KQ=;
        b=dw9Z2GXH5iuf/XyfZfnF+MROZm9z8E3oYsVWHmI1xh2af0q3zEEkeDvTPxm/md6SQT
         OI4fi9Cryk3CcHCn1Qb6oahEQkesubljXKoIFac/ZoVu1ka2IZXUd/d7qhJzopQKN/LJ
         oDrwxHPTWF0s7grJTAtiC47nQxcSyww8MmHuL0wXA27BtoYzQUp9pGkJ5UUEQV6X1qoV
         M0DqR6+xlr5DtArHaHnzlz54RJVr9VJ0iDqvZrf+6cP+xVdH6XxHaD654Yw04zRIa2xz
         x81McOXNngF4IZBAsbvSiSRcKa2uE7PcRqPZGhX70+ejLhSE7sBw+YZoELpRxvXaRK1/
         AL4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Fc6CZS+bGPvfj267sYMmDl3dI5YtuEsdV4q3SHhX8KQ=;
        b=dRk2YxsPqkdgD02blLUhIUvy1zL/o4tLJYd6KVQDSWjUGAq1fDZvEdBWzH+FQADnP+
         6sOS8DCMUmIuwL2FLv4Sj//5bZJ5yq5jy5v4bXMD+wvs4y8/16zvONnZldlkzN6pyzVv
         m+FfOYwyW+SbukNmC2dCC4qm/lYd1CDYw/E+5qhP5FesSfg2O0bg5du+RH2XTgSGtOQ0
         93zjNITTssS5z3BzcAFWMiqUk4sQswcCCswXbgFEIuw7fWDP45mTXnoMY0vQfQ0QsVEj
         l8BnwwfvgtmX0SgLDsHNzWcicztAgOMhWN/nSrq4dypIQXgbJ/OUCfjpTKcq7MX3gfJi
         Mdqg==
X-Gm-Message-State: AOAM533cq7C6F46aVElJSEsZBuY5ZxNF1YSffE+L6Ut+P4pElAfcuthT
        8nDHemmCW3SZzKvnLwOU0AlEdw==
X-Google-Smtp-Source: ABdhPJyCM6tjHQsFwmJzpKUnu4VmsVjiRDRWhx+BvMKc/P1PEf79iogjeGuEDqhkhR36Qoz8DQypIQ==
X-Received: by 2002:a17:90a:509:: with SMTP id h9mr10464679pjh.71.1630481276056;
        Wed, 01 Sep 2021 00:27:56 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([213.173.35.225])
        by smtp.gmail.com with ESMTPSA id x191sm13122164pfc.60.2021.09.01.00.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 00:27:55 -0700 (PDT)
Date:   Wed, 1 Sep 2021 15:27:51 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        Orito Takao <orito.takao@socionext.com>
Subject: Re: [RFC PATCH] irqchip/gic, gic-v3: Ensure data visibility in
 peripheral
Message-ID: <20210901072751.GB303522@leoy-ThinkPad-X240s>
References: <20210901063115.383026-1-leo.yan@linaro.org>
 <87bl5cwzdz.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bl5cwzdz.wl-maz@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On Wed, Sep 01, 2021 at 08:03:52AM +0100, Marc Zyngier wrote:
> On Wed, 01 Sep 2021 07:31:15 +0100,
> Leo Yan <leo.yan@linaro.org> wrote:
> > 
> > When an interrupt line is assered, GIC handles interrupt with the flow
> > (with EOImode == 1):
> > 
> >   gic_handle_irq()
> >    `> do_read_iar()                          => Change int state to active
> >    `> gic_write_eoir()                       => Drop int priority
> >    `> handle_domain_irq()
> >        `> generic_handle_irq_desc()
> >        `> handle_fasteoi_irq()
> >            `> handle_irq_event()             => Peripheral handler and
> > 	                                        de-assert int line
> >            `> cond_unmask_eoi_irq()
> > 	       `> chip->irq_eoi()
> > 	           `> gic_eoimode1_eoi_irq() => Change int state to inactive
> > 
> > In this flow, it has no explicit memory barrier between the functions
> > handle_irq_event() and chip->irq_eoi(), it's possible that the
> > outstanding data has not reached device in handle_irq_event() but the
> > callback chip->irq_eoi() is invoked, this can lead to state transition
> > for level triggered interrupt:
> > 
> >   Flow                             |  Interrupt state in GIC
> >   ---------------------------------+-------------------------------------
> >   Interrupt line is asserted       |  'inactive' -> 'pending'
> >   do_read_iar()                    |  'pending'  -> 'pending & active'
> >   handle_irq_event()               |  Write peripheral register but it's
> >                                    |    not visible for device, so the
> > 				   |    interrupt line is still asserted
> >   chip->irq_eoi()                  |  'pending & active' -> 'pending'
> >                                   ...
> >   Produce spurious interrupt       |
> >       with interrupt ID: 1024      |
> 
> 1024? Surely not.

Sorry for typo, should be 1023.

> 
> >                                    |  Finally the peripheral reigster is
> > 				   |  updated and the interrupt line is
> > 				   |  deasserted: 'pending' -> 'inactive'
> > 
> > To avoid this potential issue, this patch adds wmb() barrier prior to
> > invoke EOI operation, this can make sure the interrupt line is
> > de-asserted in peripheral before deactivating interrupt in GIC.  At the
> > end, this can avoid spurious interrupt.
> 
> If you want to ensure completion of device-specific writes, why isn't
> this the job of the device driver to implement whatever semantic it
> desires?

Seems to me, it's a common requirement for all device drivers to
ensure the outstanding transactions to the endpoint to de-assert the
interrupt line before the GIC driver deactivates the interrupt line.

> What if the interrupt is (shock, horror!) driven by a system
> register instead?

Okay, this is good reason that it's not always to need barrier.

> I think this is merely papering over a driver bug, and adds a
> significant cost to all interrupts for no good reasons.

Understand.  The memory barrier can be added per device driver.

Thanks for quick response,
Leo
