Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D11A343DE6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 11:31:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbhCVKai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 06:30:38 -0400
Received: from foss.arm.com ([217.140.110.172]:57074 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229761AbhCVKaV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 06:30:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 963211063;
        Mon, 22 Mar 2021 03:30:20 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.23.154])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B81A03F718;
        Mon, 22 Mar 2021 03:30:18 -0700 (PDT)
Date:   Mon, 22 Mar 2021 10:29:38 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will@kernel.org, catalin.marinas@arm.com, james.morse@arm.com,
        marcan@marcan.st, maz@kernel.org, tglx@linutronix.de
Subject: Re: [PATCHv3 2/6] arm64: don't use GENERIC_IRQ_MULTI_HANDLER
Message-ID: <20210322102938.GA75892@C02TD0UTHF1T.local>
References: <20210315115629.57191-1-mark.rutland@arm.com>
 <20210315115629.57191-3-mark.rutland@arm.com>
 <20210315192803.GB154861@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210315192803.GB154861@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On Mon, Mar 15, 2021 at 07:28:03PM +0000, Christoph Hellwig wrote:
> On Mon, Mar 15, 2021 at 11:56:25AM +0000, Mark Rutland wrote:
> > From: Marc Zyngier <maz@kernel.org>
> > 
> > In subsequent patches we want to allow irqchip drivers to register as
> > FIQ handlers, with a set_handle_fiq() function. To keep the IRQ/FIQ
> > paths similar, we want arm64 to provide both set_handle_irq() and
> > set_handle_fiq(), rather than using GENERIC_IRQ_MULTI_HANDLER for the
> > former.
> 
> Having looked through the series I do not understand this rationale
> at all.  You've only added the default_handle_irq logic, which seems
> perfectly suitable and desirable for the generic version. 

The default_handle_irq thing isn't the point of the series, that part is
all preparatory work. I agree that probably makes sense for the generic
code, and I'm happy to update core code with this.

The big thing here is that (unlike most architectures), with arm64 a CPU
has two interrupt pins, IRQ and FIQ, and we need separate root handlers
for these. That's what this series aims to do, and patches 1-5 are all
preparatory work with that appearing in patch 6.

Our initial stab at this did try to add that support to core code, but
that was more painful to deal with, since you either add abstractions to
make this look generic that make the code more complex for bot hthe
genreic code and arch code, or you place arch-specific assumptions in
the core code. See Marc's eariler stab at this, where in effect we had
to duplicate the logic in the core code so that we didn't adversely
affect existing entry assembly on other architectures due to the way the
function pointers were stored.

> Please don't fork off generic code for no good reason.

I appreciate that this runs counter to the general goal of making things
generic wherever possible, but I do think in this case we have good
reasons, and the duplication is better than adding single-user
abstractions in the generic code that complicate the generic code and
arch code.

Thanks,
Mark.
