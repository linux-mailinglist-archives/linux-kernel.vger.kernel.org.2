Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B963F422B0F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 16:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235395AbhJEOcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 10:32:04 -0400
Received: from foss.arm.com ([217.140.110.172]:51310 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235090AbhJEOcD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 10:32:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7E7621FB;
        Tue,  5 Oct 2021 07:30:12 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.23.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4CA793F70D;
        Tue,  5 Oct 2021 07:30:06 -0700 (PDT)
Date:   Tue, 5 Oct 2021 15:30:03 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Daniel Axtens <dja@axtens.net>
Cc:     keescook@chromium.org, catalin.marinas@arm.com,
        clang-built-linux@googlegroups.com, hca@linux.ibm.com,
        jarmo.tiitto@gmail.com, linux-kernel@vger.kernel.org,
        lukas.bulwahn@gmail.com, masahiroy@kernel.org, maskray@google.com,
        morbo@google.com, nathan@kernel.org, ndesaulniers@google.com,
        oberpar@linux.ibm.com, ojeda@kernel.org, peterz@infradead.org,
        samitolvanen@google.com, torvalds@linux-foundation.org,
        wcw@google.com, will@kernel.org
Subject: Re: ARCH_WANTS_NO_INSTR (Re: [GIT PULL] Clang feature updates for
 v5.14-rc1)
Message-ID: <20211005143003.GC6678@C02TD0UTHF1T.local>
References: <202106281231.E99B92BB13@keescook>
 <20211005131015.3153458-1-dja@axtens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211005131015.3153458-1-dja@axtens.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 06, 2021 at 12:10:15AM +1100, Daniel Axtens wrote:
> Hi,

Hi Daniel,

> Apologies, I can't find the original email for this:
> 
> >      Kconfig: Introduce ARCH_WANTS_NO_INSTR and CC_HAS_NO_PROFILE_FN_ATTR
> 
> which is now commit 51c2ee6d121c ("Kconfig: Introduce ARCH_WANTS_NO_INSTR and
> CC_HAS_NO_PROFILE_FN_ATTR"). It doesn't seem to show up on Google, this was the
> best I could find.

Unless I've misunderstood, the commit title was rewritten when the patch
was applied, from the third link in commit 51c2ee6d121c. For reference,
those three links are:

  Link: https://lore.kernel.org/lkml/YMTn9yjuemKFLbws@hirez.programming.kicks-ass.net/
  Link: https://lore.kernel.org/lkml/YMcssV%2Fn5IBGv4f0@hirez.programming.kicks-ass.net/
  Link: https://lore.kernel.org/r/20210621231822.2848305-4-ndesaulniers@google.com

> Anyway, the commit message reads:
> 
>     Kconfig: Introduce ARCH_WANTS_NO_INSTR and CC_HAS_NO_PROFILE_FN_ATTR
>     
>     We don't want compiler instrumentation to touch noinstr functions,
>     which are annotated with the no_profile_instrument_function function
>     attribute. Add a Kconfig test for this and make GCOV depend on it, and
>     in the future, PGO.
>     
>     If an architecture is using noinstr, it should denote that via this
>     Kconfig value. That makes Kconfigs that depend on noinstr able to express
>     dependencies in an architecturally agnostic way.
> 
> However, things in generic code (such as rcu_nmi_enter) are tagged with
> `noinstr`, so I'm worried that this commit subtly breaks things like KASAN on
> platforms that haven't opted in yet. (I stumbled across this while developing
> KASAN on ppc64, but at least riscv and ppc32 have KASAN but not
> ARCH_WANTS_NO_INSTR already.)
> 
> As I said, I haven't been able to find the original thread - is there any reason
> this shouldn't be always on? Why would an arch not opt in? What's the motivation
> for ignoring the noinstr markings?

IIRC the thinking was that architectures which have their entry logic in
asm could/might avoid the problematic instrumentation by construction,
and we didn't want to break functionality for those.

As you say, if that asm has to call code which can't safely be
instrumented, that's equally broken, and that might have been
wrong-headed.

> Should generic KASAN/KCSAN/anything else marked in noinstr also have markings
> requring ARCH_WANTS_NO_INSTR? AFAICT they should, right?

I suspect so, if we could otherwise get unexpected or unsafe recursion
between instrumentation.

Thanks,
Mark.
