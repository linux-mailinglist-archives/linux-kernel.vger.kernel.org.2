Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA98C3AA34A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 20:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231942AbhFPSna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 14:43:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:42240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231910AbhFPSn0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 14:43:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BF0CB613EE;
        Wed, 16 Jun 2021 18:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623868880;
        bh=KhuEyFARAncSbBn3We8wXGWjyOelaJec1tgfBHwmMTQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=jybkIbAoOZGcwi20yIw7ePBdWNwLx0jT1TwrMxStZ+N8KloS+UtzmDQxz525eIQqV
         sEKTE9kjhg16cTF4iHcIT4xxpMl4yyv49j183cCdzmOSGO6hUrUdau4r2oBmTQGF6Z
         eUS0nej8hfpjHWRDm3OkZn/0o75gIY+BJZ01o7ip8tXp9eeTUQ31BBGiFOy9UqEM2S
         yx1NVghmuX/IVq/KDIne0Mn0xZDj2EStMlcb6D0L494h1EWYB+y2kUQPUGca7xrPks
         2Ey7rPorO5Rp2CdL8LY06bVX4uSMAkYdI4175WbEd+W/Vul9ZH4rT9v3NSLooTPvon
         SWK8Xf4FCsOKw==
Subject: Re: [PATCH 4/8] membarrier: Make the post-switch-mm barrier explicit
To:     Peter Zijlstra <peterz@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
References: <cover.1623813516.git.luto@kernel.org>
 <f184d013a255a523116b692db4996c5db2569e86.1623813516.git.luto@kernel.org>
 <1623816595.myt8wbkcar.astroid@bobo.none>
 <YMmpxP+ANG5nIUcm@hirez.programming.kicks-ass.net>
From:   Andy Lutomirski <luto@kernel.org>
Message-ID: <617cb897-58b1-8266-ecec-ef210832e927@kernel.org>
Date:   Wed, 16 Jun 2021 11:41:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YMmpxP+ANG5nIUcm@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/16/21 12:35 AM, Peter Zijlstra wrote:
> On Wed, Jun 16, 2021 at 02:19:49PM +1000, Nicholas Piggin wrote:
>> Excerpts from Andy Lutomirski's message of June 16, 2021 1:21 pm:
>>> membarrier() needs a barrier after any CPU changes mm.  There is currently
>>> a comment explaining why this barrier probably exists in all cases.  This
>>> is very fragile -- any change to the relevant parts of the scheduler
>>> might get rid of these barriers, and it's not really clear to me that
>>> the barrier actually exists in all necessary cases.
>>
>> The comments and barriers in the mmdrop() hunks? I don't see what is 
>> fragile or maybe-buggy about this. The barrier definitely exists.
>>
>> And any change can change anything, that doesn't make it fragile. My
>> lazy tlb refcounting change avoids the mmdrop in some cases, but it
>> replaces it with smp_mb for example.
> 
> I'm with Nick again, on this. You're adding extra barriers for no
> discernible reason, that's not generally encouraged, seeing how extra
> barriers is extra slow.
> 
> Both mmdrop() itself, as well as the callsite have comments saying how
> membarrier relies on the implied barrier, what's fragile about that?
> 

My real motivation is that mmgrab() and mmdrop() don't actually need to
be full barriers.  The current implementation has them being full
barriers, and the current implementation is quite slow.  So let's try
that commit message again:

membarrier() needs a barrier after any CPU changes mm.  There is currently
a comment explaining why this barrier probably exists in all cases. The
logic is based on ensuring that the barrier exists on every control flow
path through the scheduler.  It also relies on mmgrab() and mmdrop() being
full barriers.

mmgrab() and mmdrop() would be better if they were not full barriers.  As a
trivial optimization, mmgrab() could use a relaxed atomic and mmdrop()
could use a release on architectures that have these operations.  Larger
optimizations are also in the works.  Doing any of these optimizations
while preserving an unnecessary barrier will complicate the code and
penalize non-membarrier-using tasks.

Simplify the logic by adding an explicit barrier, and allow architectures
to override it as an optimization if they want to.

One of the deleted comments in this patch said "It is therefore
possible to schedule between user->kernel->user threads without
passing through switch_mm()".  It is possible to do this without, say,
writing to CR3 on x86, but the core scheduler indeed calls
switch_mm_irqs_off() to tell the arch code to go back from lazy mode
to no-lazy mode.
