Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 945C144BFDE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 12:09:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbhKJLMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 06:12:41 -0500
Received: from foss.arm.com ([217.140.110.172]:45032 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231158AbhKJLMj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 06:12:39 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 55F0D101E;
        Wed, 10 Nov 2021 03:09:52 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.59.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 256323F718;
        Wed, 10 Nov 2021 03:09:50 -0800 (PST)
Date:   Wed, 10 Nov 2021 11:09:40 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Quentin Perret <qperret@google.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Will Deacon <will@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v6 2/2] arm64: implement support for static call
 trampolines
Message-ID: <YYuoawC2CpornRSG@FVFF77S0Q05N>
References: <20211105145917.2828911-1-ardb@kernel.org>
 <20211105145917.2828911-3-ardb@kernel.org>
 <YYq1/a10XGBthteg@FVFF77S0Q05N>
 <CAMj1kXHrTjxWWX0cfF1Bx58aTR9Fp=xkfhizkWnQRjYtRm879w@mail.gmail.com>
 <YYrFvXg12eANs0gz@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YYrFvXg12eANs0gz@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Nov 09, 2021 at 07:02:21PM +0000, Quentin Perret wrote:
> On Tuesday 09 Nov 2021 at 19:09:21 (+0100), Ard Biesheuvel wrote:
> > Android relies heavily on tracepoints for vendor hooks, and given the
> > performance impact of CFI on indirect calls, there has been interest
> > in enabling static calls to replace them.

Hhmm.... what exactly is a "vendor hook" in this context, and what is it doing
with a tracepoint? From an upstream perspective that sounds somewhat fishy
usage.

> > Quentin, anything to add here?
> 
> Yes, Android should definitely benefit from static calls.
> 
> Modules attaching to tracepoints cause a measurable overhead w/ CFI as
> the jump target is a bit harder to verify if it is not in-kernel.

Where does that additional overhead come from when the target is not in-kernel?

I hope that I am wrong in understanding that __cfi_slowpath_diag() means we're
always doing an out-of-line check when calling into a module?

If that were the case, that would seem to be a much more general problem with
the current clang CFI scheme, and my fear here is that we're adding fragility
and complexity in specific plces to work around general problems with the CFI
scheme.

Thanks,
Mark.

> But sadly that's a common pattern for GKI. The current 'workaround' in
> Android has been to just plain disable CFI around all tracepoints in the
> kernel, which is a bit sad from a security PoV. But there was really no other
> option at the time, and we needed the performance back. Static calls would be
> a far superior solution as they would avoid much of the CFI overhead, and are
> not vulnerable in the CFI sense (that is, the branch target can't be easily
> overridden with a random OOB write from a dodgy driver). So yes, we'd really
> like to have those please :)
> 
> Thanks,
> Quentin
