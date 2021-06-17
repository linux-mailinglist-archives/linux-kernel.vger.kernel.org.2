Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF0693AAE06
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 09:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbhFQHyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 03:54:14 -0400
Received: from foss.arm.com ([217.140.110.172]:49806 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229666AbhFQHyM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 03:54:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 042F81042;
        Thu, 17 Jun 2021 00:52:05 -0700 (PDT)
Received: from e123083-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B28F03F694;
        Thu, 17 Jun 2021 00:52:03 -0700 (PDT)
Date:   Thu, 17 Jun 2021 09:51:54 +0200
From:   Morten Rasmussen <morten.rasmussen@arm.com>
To:     Ley Foon Tan <lftan.linux@gmail.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Quentin Perret <qperret@google.com>
Subject: Re: sched: Question about big and little cores system with SMP and
 EAS
Message-ID: <20210617074942.GA21285@e123083-lin>
References: <CAFiDJ5-ZO=BuSwBPPPecZhLyjyipTLenQxgCK=t52Pj7r659sQ@mail.gmail.com>
 <YMni2eclmqf05cL4@hirez.programming.kicks-ass.net>
 <c81ac071-c648-54ac-72ad-2dab0fa1dd4b@arm.com>
 <CAFiDJ5-j8UER1mGggC62C309T+t+y6-vy_NuKOJL6TQHrHAGtA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFiDJ5-j8UER1mGggC62C309T+t+y6-vy_NuKOJL6TQHrHAGtA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2021 at 01:00:12PM +0800, Ley Foon Tan wrote:
> On Wed, Jun 16, 2021 at 9:20 PM Dietmar Eggemann
> <dietmar.eggemann@arm.com> wrote:
> >
> > - Quentin Perret <quentin.perret@arm.com>
> > + Quentin Perret <qperret@google.com>
> >
> > On 16/06/2021 13:39, Peter Zijlstra wrote:
> > > On Wed, Jun 16, 2021 at 07:29:26PM +0800, Ley Foon Tan wrote:
> > >> Hi all
> > >>
> > >> Would like to ask the experts here regarding the Symmetric
> > >> Multi-Processing mode (SMP) with Energy aware scheduler (EAS) support
> > >> on the big + little cores system.
> > >
> > > And the you ask a question unrelated to either Symmetric MP or EAS :-)
> > >
> > >> Hardware system:
> > >> Big and little cores have almost the same ISA, but the big core has
> > >> some extension instructions that little core doesn't have.
> > >
> > > That problem is unrelated to big.Little / EAS, also by definition that
> > > is not SMP seeing how the 'S' is a blatant lie.
> > >
> > > The simplest solution is to simply disallow usage of the extended ISA
> > > and force mandate the common subset. The complicated answer is something
> > > along the lines of:
> > >
> > >   https://lkml.kernel.org/r/20210608180313.11502-1-will@kernel.org
> >
> > We don't encourage asymmetric ISA extensions for EAS*/CAS** on
> > big.Little systems.
> > It would be simply a nightmare to schedule tasks on such systems.
> >
> > The exception to this is the 'asymmetric 32-bit Soc' to support 32bit
> > legacy Apps. The nightmare for scheduling is reduced in this case to CPU
> > affinity, something the task scheduler has to live with already today.
> > (+ DL admission control for 32bit tasks).
> >
> > *  Documentation/scheduler/sched-energy.rst
> > ** Documentation/scheduler/sched-capacity.rst
> 
> Thanks for the reply.
> Yes, forsee it is very complicated and nightmare for software to
> support for SMP mode but HW is not real "symmetric".
> That's why post the question here to ask the advice and comment from
> experts here. So that can feedback to HW team.
> Asymmetric extension instructions issue should more complicated than
> asymmetric 32-bit app support, it can happen in all the areas (kernel,
> app, library and etc).

Indeed. Detecting what extensions a task might use difficult, if not
impossible. Also, we certainly don't want to end up in situation where
the CPU subsets supporting two extensions are disjoint and a task
requires both extensions.

Morten
