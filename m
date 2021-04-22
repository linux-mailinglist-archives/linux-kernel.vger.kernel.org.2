Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81A62368699
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 20:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236945AbhDVSfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 14:35:13 -0400
Received: from gate.crashing.org ([63.228.1.57]:51471 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236058AbhDVSfL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 14:35:11 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 13MIVrSI029736;
        Thu, 22 Apr 2021 13:31:53 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 13MIVprr029735;
        Thu, 22 Apr 2021 13:31:51 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Thu, 22 Apr 2021 13:31:51 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     David Malcolm <dmalcolm@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-toolchains@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        yuanzhaoxiong@baidu.com
Subject: Re: static_branch/jump_label vs branch merging
Message-ID: <20210422183151.GD27473@gate.crashing.org>
References: <YHBS70ZQ6gOpMk2K@hirez.programming.kicks-ass.net> <3c062f70ffef2dcd48a661f7c8162fb8fbaf6869.camel@redhat.com> <YHCfgHwDtT7m4ffq@hirez.programming.kicks-ass.net> <0a9da587b0330bafdf612c3d51285e144b0b9e46.camel@redhat.com> <YHC0dgwhYS9hKcRT@hirez.programming.kicks-ass.net> <5a07bde1a9fa9a056a19637399b0635252ddb303.camel@redhat.com> <20210409213949.GA33256@worktop.programming.kicks-ass.net> <YIFilwwzWiSDZU6b@hirez.programming.kicks-ass.net> <20210422170820.GB27473@gate.crashing.org> <YIG3I+ojW+bc+o4l@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YIG3I+ojW+bc+o4l@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 07:49:23PM +0200, Peter Zijlstra wrote:
> On Thu, Apr 22, 2021 at 12:08:20PM -0500, Segher Boessenkool wrote:
> > On Thu, Apr 22, 2021 at 01:48:39PM +0200, Peter Zijlstra wrote:
> > > Can we please have a __pure__ attribute that is prescriptive and not a
> > > hint the compiler is free to ignore for $raisins ?
> > 
> > What does that mean?  What actual semantics do you want it to have?
> 
> I want a function marked as pure to be treated as such, unconditionally.
> 
> > The "pure" attribute means the compiler can assume this function does
> > not have side effects.  But in general (and in practice in many cases)
> > there is no way the compiler can actually check that, if that is what
> > you were asking for.
> 
> Right, so currently the pure attribute gets ignored by the compiler
> because of various reasons, one of them being an asm volatile ("") being
> present somewhere inside it (AFAIU).

In general, the compiler only sees the *declaration* of the function, so
it cannot do such a thing.

> Does this mean we can have invalid code generation when we faultily
> mark things pure? Yes, but then it's our own damn fault for sticking on
> pure in the first place.

Nope, you have undefined behaviour in that case, and you get to keep
all N pieces, the compiler cannot do anything wrong in such a case :-)

> In short; I want pure (or really_pure if you want a second attribute) to

You cannot make the meaning of "pure" different from what it has been
historically, because existing programs will no longer build (or worse,
start behaving differently).

> be a do-what-I-tell-you-already and not a
> only-if-you-think-you-can-prove-I-didn't-make-a-mistake kinda knob. A
> little bit like inline vs always_inline.

It sounds like you want it to behave like attribute((pure)) already is
documented as doing.  Please open a PR?  https://gcc.gnu.org/bugs.html
(We need buildable stand-alone example code, with what flags to use, and
something like what should happen and what did happen).

> > And any such checking will depend on optimisation level and related
> > flags, making that a no-go anyway.
> 
> Realistically I'm only bothered about -O2 and up since that's what we
> build the kernel with. Obviously one doesn't care about optimizations
> being lost when build with -O0.

GCC is used for other things as well, not just for building Linux ;-)


Segher
