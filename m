Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50F01343C35
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 10:00:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbhCVI7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 04:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbhCVI7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 04:59:22 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66254C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 01:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gkJyH1ka82Nqgxz80lMFhKAEIXgYyo5mEmTvgPuh6PI=; b=ixb4/abe4TfMXQTJFEsCig074d
        CaAEl8FHq2w1iArMw3Ra3P8DuUPf8JjtK4NnXrSO77N2KeGN4JfX2Q/FViFy2smtdMtMm61bxCUxk
        OyzJLry08t+Q4Rldf9HRgGT2X1T3eGLlxW3snWhXUXFpHKio0QUKPpgVgB9R4cckx3aYM5ZDCwqBq
        Y4WiIrAzn1ZzIGZtpc4hpLx+0kSaSTDORivRbmTc29ySs+3u4epJhV7lMaNVrEFm9E6Z8wC8MNBde
        ixaFLBPMrjFzqP+GYsni28LZr0oXvG940+gTyS2H6xQ/GYW6rkxHPw7ugk+vD3pZrv8UZbroRQWeD
        CHZKGGgw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lOGNl-00BCx1-Fe; Mon, 22 Mar 2021 08:57:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5A274304BAE;
        Mon, 22 Mar 2021 09:57:51 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 42E232BA3A2F9; Mon, 22 Mar 2021 09:57:51 +0100 (CET)
Date:   Mon, 22 Mar 2021 09:57:51 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Li, Aubrey" <aubrey.li@linux.intel.com>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        torvalds@linux-foundation.org, fweisbec@gmail.com,
        keescook@chromium.org, Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, vineeth@bitbyteword.org,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com, dfaggioli@suse.com,
        rostedt@goodmis.org, benbjiang@tencent.com,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        James.Bottomley@hansenpartnership.com, OWeisse@umich.edu,
        Dhaval Giani <dhaval.giani@oracle.com>, chris.hyser@oracle.com,
        Josh Don <joshdon@google.com>, Hao Luo <haoluo@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Aubrey Li <aubrey.li@intel.com>
Subject: Re: [PATCH 1/6] sched: migration changes for core scheduling
Message-ID: <YFhcD/jz7kC8jaXa@hirez.programming.kicks-ass.net>
References: <20210319203253.3352417-1-joel@joelfernandes.org>
 <20210319203253.3352417-2-joel@joelfernandes.org>
 <20210320153457.GX4746@worktop.programming.kicks-ass.net>
 <28e13609-c526-c6ee-22a3-898652aed5e6@linux.intel.com>
 <YFhL4CMPB+Pfo965@hirez.programming.kicks-ass.net>
 <af3f6ea6-2c71-233f-fc6b-af039b004923@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af3f6ea6-2c71-233f-fc6b-af039b004923@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 04:12:17PM +0800, Li, Aubrey wrote:

> > But suppose there is an imbalance; then this cookie crud can forever
> > stall balance.
> > 
> > Imagine this cpu running a while(1); with a uniqie cookie on, then it
> > will _never_ accept other tasks == BAD.
> > 
> 
> How about putting the following check in sched_core_cookie_match()?
> 
> +	/*
> +	 * Ignore cookie match if there is a big imbalance between the src rq
> +	 * and dst rq.
> +	 */
> +	if ((src_rq->cfs.h_nr_running - rq->cfs.h_nr_running) > 1)
> +		return true;

That's just tinkering... cookie matching should not also look at
imbalance of any kind.

> Do you have any suggestions before we drop it?

Yeah, how about you make it part of task_hot() ? Have task_hot() refuse
migration it the cookie doesn't match.

task_hot() is a hint and will get ignored when appropriate.
