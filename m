Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE3383F29BF
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 12:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238400AbhHTKDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 06:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236384AbhHTKDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 06:03:36 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56578C061575
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 03:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5a1qUC1TDL7NB7yLQig36eoKmcE9tEaDzDiTiSTE4do=; b=bt5AgiwtluyVMfGoec2oCCGMRA
        +sa400FzGCgOKdlY3nZtVlxI2jmRk7v5rJT94E/lHmGJQ0k6XPsDZJ9FmDVk+Od1c7RFJsLRQG1Ge
        gPs26AGjDCDtDUG9XTg1ukCn+DfDre0bLT+GnJtY3ytRY7oqClFsfqr5hU1onvsaAtXeV4VaMkP8D
        EjdIwAUd5SC1pCMkZ+MEmlm+crvdq0laAdO8CyhPCii3jW7CRUnCBmJT4fqwdFTRXR/2ucWSWpoZM
        N1UNIXpYsMQ4YYoKWDM37jXcSzZNf1/2KgaDlQ4kwuT9QEmFuYoZITlaMkETitnMKdlyQQ9uDNkRz
        wQn4BE9w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mH1MG-00BONu-AT; Fri, 20 Aug 2021 10:02:40 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 050639811F4; Fri, 20 Aug 2021 12:02:38 +0200 (CEST)
Date:   Fri, 20 Aug 2021 12:02:38 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Don <joshdon@google.com>
Cc:     Eugene Syromiatnikov <esyr@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Hyser,Chris" <chris.hyser@oracle.com>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christian Brauner <christian.brauner@ubuntu.com>, ldv@strace.io
Subject: Re: [PATCH] sched: Fix Core-wide rq->lock for uninitialized CPUs
Message-ID: <20210820100238.GA2314@worktop.programming.kicks-ass.net>
References: <20210422120459.447350175@infradead.org>
 <20210422123309.039845339@infradead.org>
 <20210817151542.GA1665@asgard.redhat.com>
 <YRvbS5ypWhcsBzzU@hirez.programming.kicks-ass.net>
 <20210817231734.GA4449@asgard.redhat.com>
 <YR473ZGeKqMs6kw+@hirez.programming.kicks-ass.net>
 <CABk29Ns9s5Nr25qVPtOxABchMk1BFqOb1wpEXhQpF8=jpgqAFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABk29Ns9s5Nr25qVPtOxABchMk1BFqOb1wpEXhQpF8=jpgqAFQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 19, 2021 at 05:18:22PM -0700, Josh Don wrote:
> Hi Peter,
> 
> On Thu, Aug 19, 2021 at 4:09 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > -       /* shared state */
> > +       /* shared state -- careful with sched_core_cpu_deactivate() */
> 
> Could also throw these fields into a wrapping struct. Either way seems fine.
> 
> Reviewed-by: Josh Don <joshdon@google.com>

Yes, I considered that, but didn't want the churn at this time.
