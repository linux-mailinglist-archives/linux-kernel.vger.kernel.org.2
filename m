Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76CF343CA08
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 14:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240364AbhJ0MuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 08:50:16 -0400
Received: from foss.arm.com ([217.140.110.172]:42982 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231542AbhJ0MuP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 08:50:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 046931FB;
        Wed, 27 Oct 2021 05:47:50 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.72.240])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 08DC73F73D;
        Wed, 27 Oct 2021 05:47:46 -0700 (PDT)
Date:   Wed, 27 Oct 2021 13:47:44 +0100
From:   Mark Rutland <mark.rutland@arm.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        James Morse <james.morse@arm.com>,
        Quentin Perret <qperret@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH 2/4] arm64: implement support for static call trampolines
Message-ID: <20211027124744.GE54628@C02TD0UTHF1T.local>
References: <20211025122102.46089-3-frederic@kernel.org>
 <YXa3q2AOH0T+smFy@hirez.programming.kicks-ass.net>
 <CAMj1kXELqoVp5zBcQ8g+0O56sBq9qAEDO-7OTenDkpRcb7oeQQ@mail.gmail.com>
 <YXa85OTw7i3Bg9yj@hirez.programming.kicks-ass.net>
 <YXbC3NRWDDfsW6DG@hirez.programming.kicks-ass.net>
 <CAMj1kXEKASsYJMHHNA=uNGTnLMoXO_4BP0--1k7cEfZZupdsog@mail.gmail.com>
 <YXbHJCtkBdMP/bF6@hirez.programming.kicks-ass.net>
 <CAMj1kXHYXzU=pW6tUJB61QW5VBL7WKBhT7BkNJ970FQdHz1VVw@mail.gmail.com>
 <20211026103655.GB30152@C02TD0UTHF1T.local>
 <7d807624275a4938871f8e433e510e3c@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d807624275a4938871f8e433e510e3c@AcuMS.aculab.com>
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2021 at 11:06:11AM +0000, David Laight wrote:
> From: Mark Rutland
> > Sent: 26 October 2021 11:37
> ...
> > My preference overall is to keep the trampoline self-contained, and I'd
> > prefer to keep the RET inline in the trampoline rather than trying to
> > factor it out so that all the control-flow is clearly in one place.
> > 
> > So I'd prefer that we have the sequence as-is:
> > 
> > | 0:	.quad 0x0
> > | 	bti	c
> > | 	< insn >
> > | 	ldr	x16, 0b
> > | 	cbz	x16, 1f
> > | 	br	x16
> > | 1:	ret
> 
> What is wrong with:
> 0:	.quad 1f
> 	bti	c
> 	< insn >
> 	ldr	x16, 0b
> 	br	x16
> 1:	bti	c
> 	ret
> 
> Self-contained and reasonably easy to read.

FWIW, that would work for me too.

Thanks,
Mark.
