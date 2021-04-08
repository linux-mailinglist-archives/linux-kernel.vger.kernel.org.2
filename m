Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 354F3358A0C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 18:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232419AbhDHQrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 12:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232416AbhDHQr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 12:47:29 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7CAFC061760
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 09:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JBQCrEQpJXA35QmMh4iDu6rMe60DVzt8Dr0EBOiGeZ4=; b=bFKy4l5dt1Rx5mH1LbL9A12RZp
        0YVsCNRUPKvhC6R9+pA8e2z6Kp3F9r/kdEJhgOF0ZpL/YG7lAo8vsTfY/xAHKljmFZvZ29Kc12VSR
        waihz3kMswD/jjEIwwCFxdYwF4XeWd05BQ6RlNcMVEFaX54FtpcyKYabXotiwrb3JaFRXlmTbGzG8
        p9mFk/jdxh5eE9Kd+asi0+oqSbvi2TvbHAvVQMf4aMdN+5KrXyyfxVH4yu9zwCzutmiev1TbmKPZU
        lbapyXQ/yreqzzBGOsrNVk4NOu/eQf/hcqX9T0AKvEQkNymlwrPmM2F5rXrPdz+N32xl+s/h46d0p
        kVL4UW9g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lUXnx-008g4s-39; Thu, 08 Apr 2021 16:46:53 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F3C583001C0;
        Thu,  8 Apr 2021 18:46:29 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 44DA92B71A276; Thu,  8 Apr 2021 13:10:39 +0200 (CEST)
Date:   Thu, 8 Apr 2021 13:10:39 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     Ingo Molnar <mingo@kernel.org>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.comi>, Mel Gorman <mgorman@suse.de>,
        Len Brown <len.brown@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        Quentin Perret <qperret@google.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, Aubrey Li <aubrey.li@intel.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH 3/4] sched/fair: Consider SMT in ASYM_PACKING load balance
Message-ID: <YG7kr0Gyj86sMBF8@hirez.programming.kicks-ass.net>
References: <20210406041108.7416-1-ricardo.neri-calderon@linux.intel.com>
 <20210406041108.7416-4-ricardo.neri-calderon@linux.intel.com>
 <YGxDSMorjMADJGIT@hirez.programming.kicks-ass.net>
 <20210406231710.GB27195@ranerica-svr.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210406231710.GB27195@ranerica-svr.sc.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 06, 2021 at 04:17:10PM -0700, Ricardo Neri wrote:
> On Tue, Apr 06, 2021 at 01:17:28PM +0200, Peter Zijlstra wrote:
> > On Mon, Apr 05, 2021 at 09:11:07PM -0700, Ricardo Neri wrote:
> > > @@ -8507,6 +8619,10 @@ static bool update_sd_pick_busiest(struct lb_env *env,
> > >  	if (!sgs->sum_h_nr_running)
> > >  		return false;
> > >  
> > > +	if (sgs->group_type == group_asym_packing &&
> > > +	    !asym_can_pull_tasks(env->dst_cpu, sds, sgs, sg))
> > > +		return false;
> > 
> > All of this makes my head hurt; but afaict this isn't right.
> > 
> > Your update_sg_lb_stats() change makes that we unconditionally set
> > sgs->group_asym_packing, and then this is to undo that. But it's not
> > clear this covers all cases right.
> 
> We could not make a decision to set sgs->group_asym_packing in
> update_sg_lb_stats() because we don't have information about the dst_cpu
> and its SMT siblings if any. That is the reason I proposed to delay the
> decision to update_sd_pick_busiest(), where we can compare local and
> sgs.

Yeah, I sorta got that.

> > Even if !sched_asym_prefer(), we could end up selecting this sg as
> > busiest, but you're just bailing out here.
> 
> Even if sgs->group_asym_packing is unconditionally set, sgs can still
> be classified as group_overloaded and group_imbalanced. In such cases
> we wouldn't bailout. sgs could not be classified as group_fully_busy
> or group_has_spare and we would bailout, though. Is your concern about
> these? I can fixup these two cases.

Yes. Either explain (in a comment) why those cases are not relevant, or
handle them properly.

Because when reading this, it wasn't at all obvious that this is correct
or as intended.
