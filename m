Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E260732F26F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 19:24:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbhCESYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 13:24:16 -0500
Received: from gate.crashing.org ([63.228.1.57]:54749 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229631AbhCESYG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 13:24:06 -0500
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 125IGTa8026099;
        Fri, 5 Mar 2021 12:16:29 -0600
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 125IGS7W026098;
        Fri, 5 Mar 2021 12:16:28 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Fri, 5 Mar 2021 12:16:28 -0600
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marco Elver <elver@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Mark Brown <broonie@kernel.org>,
        Paul Mackerras <paulus@samba.org>,
        linux-toolchains@vger.kernel.org, Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v1] powerpc: Include running function as first entry in save_stack_trace() and friends
Message-ID: <20210305181628.GW29191@gate.crashing.org>
References: <CANpmjNOvgbUCf0QBs1J-mO0yEPuzcTMm7aS1JpPB-17_LabNHw@mail.gmail.com> <1802be3e-dc1a-52e0-1754-a40f0ea39658@csgroup.eu> <YD+o5QkCZN97mH8/@elver.google.com> <20210304145730.GC54534@C02TD0UTHF1T.local> <CANpmjNOSpFbbDaH9hNucXrpzG=HpsoQpk5w-24x8sU_G-6cz0Q@mail.gmail.com> <20210304165923.GA60457@C02TD0UTHF1T.local> <YEEYDSJeLPvqRAHZ@elver.google.com> <CAKwvOd=wBArMwvtDC8zV-QjQa5UuwWoxksQ8j+hUCZzbEAn+Fw@mail.gmail.com> <20210304192447.GT29191@gate.crashing.org> <ed3c08d2-04ba-217e-9924-28cab7750234@csgroup.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ed3c08d2-04ba-217e-9924-28cab7750234@csgroup.eu>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 05, 2021 at 07:38:25AM +0100, Christophe Leroy wrote:
> Le 04/03/2021 à 20:24, Segher Boessenkool a écrit :
> https://github.com/linuxppc/linux/commit/a9a3ed1eff36
> 
> >
> >That is much heavier than needed (an mb()).  You can just put an empty
> >inline asm after a call before a return, and that call cannot be
> >optimised to a sibling call: (the end of a function is an implicit
> >return:)

> In the commit mentionned at the top, it is said:
> 
> The next attempt to prevent compilers from tail-call optimizing
> the last function call cpu_startup_entry(), ... , was to add an empty 
> asm("").
> 
> This current solution was short and sweet, and reportedly, is supported
> by both compilers but we didn't get very far this time: future (LTO?)
> optimization passes could potentially eliminate this,

This is simply not true.  A volatile inline asm (like this is, all
asm without outputs are) is always run on the reel machine exactly like
on the abstract machine.  LTO can not eliminate it, not more than any
other optimisation can.  The compiler makes no assumption about the
constents of the template of an asm, empty or not.

If you are really scared the compiler violates the rules of GCC inline
asm and thinks it knows what "" means, you can write
  asm(";#");
(that is a comment on all supported archs).

> which leads us
> to the third attempt: having an actual memory barrier there which the
> compiler cannot ignore or move around etc.

Why would it not be allowed to delete this, and delete some other asm?

And the compiler *can* move around asm like this.  But the point is,
it has to stay in order with other side effects, so there cannot be a
sibling call here, the call has to remain: any call contains a sequence
point, so side effects cannot be reordered over it, so the call (being
before the asm) cannot be transformed to a tail call.


Segher
