Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D83E933D683
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 16:11:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234418AbhCPPLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 11:11:05 -0400
Received: from smtp1.de.adit-jv.com ([93.241.18.167]:52844 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbhCPPKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 11:10:46 -0400
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
        by smtp1.de.adit-jv.com (Postfix) with ESMTP id 703CB3C04C0;
        Tue, 16 Mar 2021 16:10:44 +0100 (CET)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
        by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id uZ8oA5G736kb; Tue, 16 Mar 2021 16:10:38 +0100 (CET)
Received: from hi2exch02.adit-jv.com (hi2exch02.adit-jv.com [10.72.92.28])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id 5B7EF3C00C0;
        Tue, 16 Mar 2021 16:10:38 +0100 (CET)
Received: from lxhi-065.adit-jv.com (10.72.94.12) by hi2exch02.adit-jv.com
 (10.72.92.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 16 Mar
 2021 16:10:37 +0100
Date:   Tue, 16 Mar 2021 16:10:31 +0100
From:   Eugeniu Rosca <erosca@de.adit-jv.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     Eugeniu Rosca <erosca@de.adit-jv.com>,
        <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Jiafei Pan <Jiafei.Pan@nxp.com>,
        Romain Perier <romain.perier@gmail.com>,
        Andrew Gabbasov <andrew_gabbasov@mentor.com>,
        Dirk Behme <dirk.behme@de.bosch.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Subject: Re: [PATCH] softirq: Be more verbose on t->state BUG()
Message-ID: <YFDKZ5Ukwy/j8Xk3@lxhi-065.adit-jv.com>
References: <20210315154421.11463-1-erosca@de.adit-jv.com>
 <87k0q7186h.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87k0q7186h.fsf@nanos.tec.linutronix.de>
X-Originating-IP: [10.72.94.12]
X-ClientProxiedBy: hi2exch02.adit-jv.com (10.72.92.28) To
 hi2exch02.adit-jv.com (10.72.92.28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Thomas,

On Tue, Mar 16, 2021 at 03:31:50PM +0100, Thomas Gleixner wrote:
> On Mon, Mar 15 2021 at 16:44, Eugeniu Rosca wrote:
> > From: Dirk Behme <dirk.behme@de.bosch.com>
> >
> > In case this BUG() is hit, it helps debugging a lot to get an idea
> > what tasklet is the root cause. So, be slightly more verbose here.
> >
> > Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
> > Signed-off-by: Eugeniu Rosca <erosca@de.adit-jv.com>
> > ---
> >  kernel/softirq.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/softirq.c b/kernel/softirq.c
> > index 9908ec4a9bfe..a6b602ad48d6 100644
> > --- a/kernel/softirq.c
> > +++ b/kernel/softirq.c
> > @@ -550,9 +550,13 @@ static void tasklet_action_common(struct softirq_action *a,
> >  
> >  		if (tasklet_trylock(t)) {
> >  			if (!atomic_read(&t->count)) {
> > -				if (!test_and_clear_bit(TASKLET_STATE_SCHED,
> > -							&t->state))
> > +				if (!test_and_clear_bit(TASKLET_STATE_SCHED, &t->state)) {
> > +					if (t->use_callback)
> > +						pr_emerg("tasklet failed, cb: %pS\n", t->callback);
> > +					else
> > +						pr_emerg("tasklet failed, func: %pS\n", t->func);
> >  					BUG();
> > +				}
> >  				if (t->use_callback)
> >  					t->callback(t);
> >  				else
> 
> This belongs into unreadable land and actually the BUG() should just be
> replaced by a WARN_ONCE(). Something like the below. Hmm?

Many thanks for the quick and constructive reply.

If no other comments in the next days, I will resubmit your proposal as
v2, marked with 'Suggested-by: Thomas Gleixner <tglx@linutronix.de>'.

Alternatively, feel free to author the patch and submit it with us in Cc.

Thanks again.

-- 
Best regards,
Eugeniu Rosca
