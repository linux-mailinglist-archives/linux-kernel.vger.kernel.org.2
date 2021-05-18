Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAAF93876E6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 12:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348655AbhERKuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 06:50:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:40994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348645AbhERKuN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 06:50:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D9C5C611CC;
        Tue, 18 May 2021 10:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621334935;
        bh=iVNbRw1dHUuSUOPzXc7Jidh1IKCJlI7ySxLTSP7inAw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OilJjhtZl8il3ekgHqbyhCEb+SN+uKEPvQA3Gh7EfEhk9mJHtqshFfn45akRvZ1g2
         hoyPouMIsh3M6oxJUN2UuEHZewhmqQD2lfd+nns2yIwxLkuS9VzJench9Hv4PHYm4b
         bKZztOnuxYaS9fiDUyYZRSpezG5lky3ZDGVKsdWHIrK+/wuz3rWm4D21NPQwQThARz
         c/oJTxRy62x6kuLs7fuPbE5FhMlnKl4S52nwDJigqOBUTYP8fZBNUbMiDSSR4wA0eN
         2jtqWlX342G0h8WVirnllgGYPerY6Czrz5d/e8rkbrY1jvb73VNTYRRwiKcX/rlkP4
         by9K38khy3I/A==
Date:   Tue, 18 May 2021 11:48:49 +0100
From:   Will Deacon <will@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Nitesh Lal <nilal@redhat.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, Frank Li <Frank.li@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>
Subject: Re: [patch 0/8] genirq, perf: Cleanup the abuse of
 irq_set_affinity_hint()
Message-ID: <20210518104849.GB7770@willie-the-truck>
References: <20210518091725.046774792@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210518091725.046774792@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Tue, May 18, 2021 at 11:17:25AM +0200, Thomas Gleixner wrote:
> The modular PMU drivers use irq_set_affinity_hint() to set the affinity
> for the PMU interrupts, which relies on the undocumented side effect that
> this function actually sets the affinity under the hood.
> 
> Setting an hint is clearly not a guarantee and for these PMU interrupts an
> affinity hint, which is supposed to guide userspace for setting affinity,
> is beyond pointless, because the affinity of these interrupts cannot be
> modified from user space.
> 
> Aside of that the error checks are bogus because the only error which is
> returned from irq_set_affinity_hint() is when there is no irq descriptor
> for the interrupt number, but not when the affinity set fails. That's on
> purpose because the hint can point to an offline CPU.
> 
> Sigh, if people would at least talk if something is missing...
> 
> Clean up the mess by exposing irq_set_affinity() and converting the drivers
> over to that.

This all looks good to me, thanks. Given the number of PMU drivers it
touches, it may well conflict with driver work for 5.14. If you put the
IRQ core stuff on a stable branch, then I could pull that into the Arm
perf tree and stick all the driver changes on top. That also means any
new drivers that come in can use irq_set_affinity() right away.

Does that work for you?

Cheers,

Will
