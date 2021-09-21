Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDBC64134D6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 15:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233419AbhIUNwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 09:52:06 -0400
Received: from foss.arm.com ([217.140.110.172]:34172 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233293AbhIUNwF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 09:52:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 190736D;
        Tue, 21 Sep 2021 06:50:37 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.23.155])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 578F83F719;
        Tue, 21 Sep 2021 06:50:35 -0700 (PDT)
Date:   Tue, 21 Sep 2021 14:50:32 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        James Morse <james.morse@arm.com>,
        Quentin Perret <qperret@google.com>
Subject: Re: [PATCH 1/4] sched/preempt: Prepare for supporting
 !CONFIG_GENERIC_ENTRY dynamic preemption
Message-ID: <20210921135032.GB35846@C02TD0UTHF1T.local>
References: <20210920233237.90463-1-frederic@kernel.org>
 <20210920233237.90463-2-frederic@kernel.org>
 <YUmFUkk4idIZENAk@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUmFUkk4idIZENAk@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 21, 2021 at 09:10:10AM +0200, Peter Zijlstra wrote:
> On Tue, Sep 21, 2021 at 01:32:34AM +0200, Frederic Weisbecker wrote:
> > There is no need to force dynamic preemption to depend on the generic
> > entry code. The latter is convenient but not mandatory. An architecture
> > that doesn't support it just need to provide a static call on its
> > kernel IRQ exit preemption path.
> 
> True; but at the same time ARM64 is also moving to generic entry. Mark?

That's the aspiration, but it's going to take a while to rework the
arm64 and common code. So far I've just been focusing on the groundwork
of moving stuff out of asm so that we can see the wood for the trees.

Generally my preference would be to move things over in stages, to avoid
a flag day where there's the potential for many things to break
simultaneously. So if this is relatively self contained, I think it
maybe worthwhile to do on its own, but I don't have very strong feelings
on that.

Thanks,
Mark.
