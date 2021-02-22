Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC5A321F5A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 19:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbhBVSqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 13:46:51 -0500
Received: from foss.arm.com ([217.140.110.172]:33386 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231336AbhBVSoO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 13:44:14 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AC72A1FB;
        Mon, 22 Feb 2021 10:43:24 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.51.127])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CBC3C3F73B;
        Mon, 22 Feb 2021 10:43:22 -0800 (PST)
Date:   Mon, 22 Feb 2021 18:43:20 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Hector Martin <marcan@marcan.st>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH 7/8 v1.5] arm64: Always keep DAIF.[IF] in sync
Message-ID: <20210222184320.GD77517@C02TD0UTHF1T.local>
References: <20210219113904.41736-8-mark.rutland@arm.com>
 <20210219172530.45805-1-marcan@marcan.st>
 <20210219182641.GB84857@C02TD0UTHF1T.local>
 <8c955dd3-8f40-3837-da33-7e117b357a35@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c955dd3-8f40-3837-da33-7e117b357a35@marcan.st>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 23, 2021 at 02:39:11AM +0900, Hector Martin wrote:
> On 20/02/2021 03.26, Mark Rutland wrote:
> > On Sat, Feb 20, 2021 at 02:25:30AM +0900, Hector Martin wrote:
> > > Apple SoCs (A11 and newer) have some interrupt sources hardwired to the
> > > FIQ line. We implement support for this by simply treating IRQs and FIQs
> > > the same way in the interrupt vectors.
> > > 
> > > To support these systems, the FIQ mask bit needs to be kept in sync with
> > > the IRQ mask bit, so both kinds of exceptions are masked together. No
> > > other platforms should be delivering FIQ exceptions right now, and we
> > > already unmask FIQ in normal process context, so this should not have an
> > > effect on other systems - if spurious FIQs were arriving, they would
> > > already panic the kernel.
> > 
> > This looks good to me; I've picked this up and pushed out my arm64/fiq
> > branch [1,2] incorporating this, tagged as arm64-fiq-20210219.
> > 
> > I'll give this version a few days to gather comments before I post a v2.
> > 
> > [1] git://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git arm64/fiq
> > [2] https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=arm64/fiqA
> 
> Thanks! Any chance you can do a rebase on top of torvalds/master? Since
> Marc's nVHE changes went in, we're going to need to add a workaround patch
> for the M1's lack of nVHE mode, which is going to be in the next version of
> my M1 bringup series - but right now that would involve telling people to
> merge two trees to build a base to apply it on, which is sub-optimal.

I generally try to base on a stable tag/commit, so I'd prefer to avoid
rebasing the development branch until rc1 if possible. I've pushed out a
new arm64-fiq-mainline-20210222 tag rebased atop torvalds/master:

git://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git arm64-fiq-mainline-20210222
https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/tag/?h=arm64-fiq-mainline-20210222

... leaving the main branch atop v5.11. Is that good enough for now? If
that's painful for development I can shuffle the main branch along too.

Thanks,
Mark.
