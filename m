Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 179BB3A1299
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 13:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239047AbhFIL1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 07:27:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:40858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237376AbhFIL1k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 07:27:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1FAD561184;
        Wed,  9 Jun 2021 11:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623237946;
        bh=c54OUGESMRp934+SAAOMMobp54ilfYzv+4CFnvOlhoA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aJ2tul7LZIem+qa4no0D7IRLQmvS7hWNIxSH2QccKQDsLluEKyUQScglWYJFmkR5n
         4xdxmVMf6Zl6HNnOJE722sLD9b8bG5Zq4oDi117dGRmAi9n+W+U+Ygi7zCAM5t3q/d
         KTkljaIsOYxXZbvEx0EPY+J9Yaz02jqW+TBLeOC4HwrdprlLIazCtxsZIYrxUFZXHL
         X0/MyAqtQe2e+mOEm6WEQZ03VdfwOzvewO8+XzKWt32aLz7RzyUbf99oprAmuTk/gD
         FVzU4svZTYKSoOIHRXkWR320hEUc1sPuq1ip06UX9Ng/rtMiY/5QNQRHD4lNse4E7+
         Hu7P4KQvt21FQ==
Date:   Wed, 9 Jun 2021 13:25:44 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] sched: Add default dynamic preempt mode Kconfig
Message-ID: <20210609112544.GB104634@lothringen>
References: <20210608120442.93587-1-frederic@kernel.org>
 <20210608120442.93587-2-frederic@kernel.org>
 <YL9271QMQfyn174k@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YL9271QMQfyn174k@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 08, 2021 at 03:55:59PM +0200, Peter Zijlstra wrote:
> On Tue, Jun 08, 2021 at 02:04:41PM +0200, Frederic Weisbecker wrote:
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 9e9a5be35cde..df47a8275c37 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -6238,6 +6238,14 @@ enum {
> >  
> >  int preempt_dynamic_mode = preempt_dynamic_full;
> >  
> > +#if defined(CONFIG_PREEMPT_DYNAMIC_FULL)
> > +static __initdata int preempt_dynamic_mode_init = preempt_dynamic_full;
> > +#elif defined(CONFIG_PREEMPT_DYNAMIC_VOLUNTARY)
> > +static __initdata int preempt_dynamic_mode_init = preempt_dynamic_voluntary;
> > +#elif defined(CONFIG_PREEMPT_DYNAMIC_NONE)
> > +static __initdata int preempt_dynamic_mode_init = preempt_dynamic_none;
> > +#endif
> 
> Why does preempt_dynamic_mode_init exist? Why can't we simply set
> preempt_dynamic_mode?

To avoid the unconditional calls to static_call_update() on boot but I can do
it in a more simple way.

Thanks.
