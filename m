Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD78745DF47
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 17:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356678AbhKYRBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 12:01:32 -0500
Received: from foss.arm.com ([217.140.110.172]:53256 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231615AbhKYQ7b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 11:59:31 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DE218113E;
        Thu, 25 Nov 2021 08:56:19 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (unknown [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DC18C3F73B;
        Thu, 25 Nov 2021 08:56:18 -0800 (PST)
Date:   Thu, 25 Nov 2021 16:56:16 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/core: Export pelt_thermal_tp
Message-ID: <20211125165616.2i24qr6wtuddl32q@e107158-lin.cambridge.arm.com>
References: <20211028115005.873539-1-qais.yousef@arm.com>
 <YXrJOKb17cH6vkTc@infradead.org>
 <20211028161855.GN174703@worktop.programming.kicks-ass.net>
 <YXrOLay3BbaDObM2@infradead.org>
 <YXrU5hQfEJFTP93d@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YXrU5hQfEJFTP93d@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter

On 10/28/21 18:50, Peter Zijlstra wrote:
> On Thu, Oct 28, 2021 at 09:22:05AM -0700, Christoph Hellwig wrote:
> > On Thu, Oct 28, 2021 at 06:18:55PM +0200, Peter Zijlstra wrote:
> > > > > @@ -36,6 +36,7 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(pelt_rt_tp);
> > > > >  EXPORT_TRACEPOINT_SYMBOL_GPL(pelt_dl_tp);
> > > > >  EXPORT_TRACEPOINT_SYMBOL_GPL(pelt_irq_tp);
> > > > >  EXPORT_TRACEPOINT_SYMBOL_GPL(pelt_se_tp);
> > > > > +EXPORT_TRACEPOINT_SYMBOL_GPL(pelt_thermal_tp);
> > > > >  EXPORT_TRACEPOINT_SYMBOL_GPL(sched_cpu_capacity_tp);
> > > > >  EXPORT_TRACEPOINT_SYMBOL_GPL(sched_overutilized_tp);
> > > > >  EXPORT_TRACEPOINT_SYMBOL_GPL(sched_util_est_cfs_tp);
> > > > 
> > > > ... and while we're at it, all these exports are unused and should
> > > > be deleted as well.
> > > 
> > > This is my concession wrt tracepoints. Actual tracepoints are ABI,
> > > exports are in-kernel interfaces and are explicitly not ABI.
> > > 
> > > This way people can use an external module to get at the tracepoint data
> > > without having in-tree tracepoints.
> > 
> > All of this makes no sense at all.  These are entirely dead exports.
> > If you remove them nothing else changes.  Note taht the tracepoints
> > do have in-kernel callers, so if people thing of them as an ABI you've
> > got your ABI already with or without the exports.
> 
> These are not normal traceevents, these are tracepoints, the distinction
> is that these things do not show up in tracefs and there is no userspace
> visible representation of them. No userspace gives no ABI.
> 
> All they provide is the in-code hook and in-kernel registration
> interface. These EXPORTS export that registration interface, such that
> an out-of-tree module can make use of them.
> 
> And yes, unused exports are iffy, out-of-tree modules are iffy, but in
> this case I made an exception since ABI contraints are worse. We very
> clearly state there is no such thing is kabi, so breaking any user of
> these exports if fair game.
> 
> Breaking users of userspace trace-events gets kernel patches reverted
> (been there, done that, never want to ever be there again).
> 
> People want to trace this stuff, but I *REALLY* do not want to commit to
> ABI, this is the middle-ground that sucks least :/

AFAICS this wasn't picked up. Should I tweak the commit message to make things
clearer?

Thanks!

--
Qais Yousef
