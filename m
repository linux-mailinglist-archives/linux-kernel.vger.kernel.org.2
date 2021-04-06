Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2E1B35548D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 15:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240666AbhDFNHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 09:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232492AbhDFNHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 09:07:07 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7040FC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 06:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=j2c2vVMgDzxpq/NDOYVmtTlifBkvHOiRtuxxd/tOLOU=; b=Ixh7YWXW5iwUXA8g5hR5tO3hV3
        wG45ru/AtScmmfh4oKJc7dIeVodRxISsutJcgwkG9yFZqkTlLA7CVe1Ec4w4Z1Hxk8qZWitgeSwsv
        jcUHhpJp0bibrHmXorX+zDtP08l7w1Z6XhcuZmrlhIm8smsEC52HhCsXsba4MBSIetev/4n1s/HA9
        /ta1+1Nwx6e1jr4cnU7gQwGVP1w9XL/DGbTU0kHlez817m9M3PEY/rTs5x+Q1BGdF1Cdn9r6w5OtB
        QjXKrie7hTVeFyqazHLJ73n+/21Lx4lmXovm3/441fFWovu2Q4EYIoC21y58/rifTVfLwT15zcSA8
        7y1mFazg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lTlPY-002f9I-BA; Tue, 06 Apr 2021 13:06:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 08F82304B54;
        Tue,  6 Apr 2021 15:06:23 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 141002C1D2B56; Tue,  6 Apr 2021 13:18:09 +0200 (CEST)
Date:   Tue, 6 Apr 2021 13:18:09 +0200
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
Message-ID: <YGxDcccJ1U9ru0kV@hirez.programming.kicks-ass.net>
References: <20210406041108.7416-1-ricardo.neri-calderon@linux.intel.com>
 <20210406041108.7416-4-ricardo.neri-calderon@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210406041108.7416-4-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 05, 2021 at 09:11:07PM -0700, Ricardo Neri wrote:
> +static bool cpu_group_is_smt(int cpu, struct sched_group *sg)
> +{
> +#ifdef CONFIG_SCHED_SMT
> +	if (!static_branch_likely(&sched_smt_present))
> +		return false;
> +
> +	if (sg->group_weight == 1)
> +		return false;
> +
> +	if (cpumask_weight(cpu_smt_mask(cpu)) == 1)
> +		return false;

Please explain this condition. Why is it required?

> +	return cpumask_equal(sched_group_span(sg), cpu_smt_mask(cpu));
> +#else
> +	return false;
> +#endif
> +}
