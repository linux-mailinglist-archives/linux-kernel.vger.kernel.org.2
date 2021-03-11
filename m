Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 628AE336E67
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 10:01:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231793AbhCKJBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 04:01:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:46258 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231610AbhCKJBY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 04:01:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1615453283; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CcB+wwDhIbUpya9FjTC3IoMV0ad0fmmO/z8wJ33LFgM=;
        b=gzHoIUpD4LkHOEvqU1uY8Cj7XJdmdL631wFyi72H3SGpQYvAd3fVJP88hioaJHvKEBxpg8
        qocTUiXY506CqE8koQiGPC00grsUletAsdJbSTTFYVRjxdkNO173bo6WIiNnSwKeJmw9tD
        TBBL+MFDSaJCPMBppi8ZNXLPKM+1dOs=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8056BAB8C;
        Thu, 11 Mar 2021 09:01:23 +0000 (UTC)
Date:   Thu, 11 Mar 2021 10:01:22 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Shakeel Butt <shakeelb@google.com>, tglx@linutronix.de,
        john.ogness@linutronix.de, urezki@gmail.com, ast@fb.com,
        Eric Dumazet <edumazet@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] hugetlb: select PREEMPT_COUNT if HUGETLB_PAGE for
 in_atomic use
Message-ID: <YEncYrWCVn2/20/C@dhcp22.suse.cz>
References: <20210311021321.127500-1-mike.kravetz@oracle.com>
 <YEnY5hWLT/en7kw1@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YEnY5hWLT/en7kw1@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 11-03-21 09:46:30, Peter Zijlstra wrote:
> On Wed, Mar 10, 2021 at 06:13:21PM -0800, Mike Kravetz wrote:
> > from irq context.  Changing the check in the code from !in_task to
> > in_atomic would handle the situations when called with irqs disabled.
> 
> It does not. local_irq_disable() does not change preempt_count().

You are right. Earlier I was suggesting to check of irq_disabled() as
well http://lkml.kernel.org/r/YD4I+VPr3UNt063H@dhcp22.suse.cz

back then it was not really clear to me that in fact we do care about
spin locks more than irq disabled code. I am not even sure whether we
need to care about irq disabled regions without any locks held that
wouldn't be covered by in_atomic. But it would be safer to add
irq_disabled check as well.

-- 
Michal Hocko
SUSE Labs
