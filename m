Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB49324EE4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 12:13:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233864AbhBYLNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 06:13:14 -0500
Received: from foss.arm.com ([217.140.110.172]:54228 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233501AbhBYLMC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 06:12:02 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 69B55113E;
        Thu, 25 Feb 2021 03:11:17 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4E5FD3F73D;
        Thu, 25 Feb 2021 03:11:16 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Mel Gorman <mgorman@suse.de>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org, Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH 6/6] sched: Simplify set_affinity_pending refcounts
In-Reply-To: <YDdtkvUFxLs6zlyu@hirez.programming.kicks-ass.net>
References: <20210224122439.176543586@infradead.org> <20210224131355.724130207@infradead.org> <YDZyIugiyxAq0tVz@hirez.programming.kicks-ass.net> <jhjeeh55ouy.mognet@arm.com> <YDdtkvUFxLs6zlyu@hirez.programming.kicks-ass.net>
User-Agent: Notmuch/0.21 (http://notmuchmail.org) Emacs/26.3 (x86_64-pc-linux-gnu)
Date:   Thu, 25 Feb 2021 11:11:13 +0000
Message-ID: <jhj4ki05rn2.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/02/21 10:27, Peter Zijlstra wrote:
> On Wed, Feb 24, 2021 at 05:59:01PM +0000, Valentin Schneider wrote:
>
>> Your change reinstores the "triple SCA" pattern, where a stopper can run
>> with arg->pending && arg->pending != p->migration_pending, which I was
>> kinda happy to see go away...
>
> Right, fair enough. Any workload that can tell the difference is doing
> it wrong anyway :-)
>
> OK, I've munged your two patches together into the below.
>

Thanks!

I haven't found much else to say on the series after having slept on it, so
feel free to add:

Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>

to the rest. I'll go see about testing it in some way.
