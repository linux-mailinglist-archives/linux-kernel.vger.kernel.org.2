Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98F4435C47B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 12:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239745AbhDLK4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 06:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239482AbhDLK4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 06:56:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D8EFC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 03:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ys3C0Ut54acSs9l5VxPhbodFpcrmvcx7s05IJDaIX+k=; b=vcVW8ir8krS7ck3GLo60IoPKEL
        xSg7r6yB5XMPNt6dZRm0SMO7JGQFIeV3LTXOMWtEOOF5NxvLUmjYNDJeT9G9CJRIJNLE8IIJ85NCg
        sMbuuX+cpMNuIqXrR3xcTwofug16NSre03Kuy5a0j981x3DsDMh2hTXxqCJx8zL7ZR/QIQdGswQ33
        sSbYBk4IE9AMWRf9eoqGtivivVz4239y0xOj0OnBAwVR3d0h3WDO2QGl09vW46Zr8RymF5+wU2sP3
        NWUTUXmacfo/PGtWlfSENjIBNzGvuldD0oR21Uic7wIis+Qc37RpDg3HZB5K2gBQmYcwMEvvC81W2
        /YKVwG8Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lVuDr-004Dhb-Gr; Mon, 12 Apr 2021 10:55:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 881C9300036;
        Mon, 12 Apr 2021 12:55:14 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4F15820224209; Mon, 12 Apr 2021 12:55:14 +0200 (CEST)
Date:   Mon, 12 Apr 2021 12:55:14 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     valentin.schneider@arm.com, tglx@linutronix.de, mingo@kernel.org,
        bigeasy@linutronix.de, swood@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vincent.donnefort@arm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] cpumask: Introduce DYING mask
Message-ID: <YHQnEgXFi3YAFvIP@hirez.programming.kicks-ass.net>
References: <20210310145258.899619710@infradead.org>
 <20210310150109.151441252@infradead.org>
 <20210321193037.7o3mqcmwjthbos7n@e107158-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210321193037.7o3mqcmwjthbos7n@e107158-lin>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 21, 2021 at 07:30:37PM +0000, Qais Yousef wrote:
> On 03/10/21 15:53, Peter Zijlstra wrote:
> > --- a/kernel/cpu.c
> > +++ b/kernel/cpu.c
> > @@ -160,6 +160,9 @@ static int cpuhp_invoke_callback(unsigne
> >  	int (*cb)(unsigned int cpu);
> >  	int ret, cnt;
> >  
> > +	if (bringup != !cpu_dying(cpu))
> 
> nit: this condition is hard to read
> 
> > +		set_cpu_dying(cpu, !bringup);

How's:

	if (cpu_dying(cpu) != !bringup)
		set_cpu_dying(cpu, !bringup);

> since cpu_dying() will do cpumask_test_cpu(), are we saving  much if we
> unconditionally call set_cpu_dying(cpu, !bringup) which performs
> cpumask_{set, clear}_cpu()?

This is hotplug, it's all slow, endlessly rewriting that bit shouldn't
be a problem I suppose.
