Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F92C3282B6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 16:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237354AbhCAPlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 10:41:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237137AbhCAPlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 10:41:40 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37BD8C061756
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 07:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6bCu91Y9Ljglob4huEndBp2bwsvB8cz8ka4XeKdQ8WI=; b=t9CW+70yCH5q8TdbYhSqTX8bAk
        7AXoGWU+vVTccSlMkxbNyxJZAzxkdmNjuWAExsbsKOfGoYCWc2fRAhqpy3D03gWbnPczY5Wa2dWXQ
        ZC8z69Id2K3+rw5eIn7it/bIwT1cUSy4O4VhKs4BtaUZ8kPn4Aqhb+7Qqe3z7q9+sM383os3+W7F2
        F1Xw8oHf+5x+7mdDB685OEyePFL5DKWLK7YdiCnNchs+xGadDfi5hDK9opAeZDMK6l+m4PXYhbYlw
        051Za9kop2nyvJ4IOpBxAbgsTPBAuuLO+tXxpONP4vQv/p9DO+VHACWrUb37NWWCUVrbNUOtHcmD/
        0pRR2/tw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1lGkex-00052a-OJ; Mon, 01 Mar 2021 15:40:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8BE8B3003E1;
        Mon,  1 Mar 2021 16:40:33 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 702A120849103; Mon,  1 Mar 2021 16:40:33 +0100 (CET)
Date:   Mon, 1 Mar 2021 16:40:33 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michael Neuling <mikey@neuling.org>,
        Gautham R Shenoy <ego@linux.vnet.ibm.com>,
        Parth Shah <parth@linux.ibm.com>
Subject: Re: [PATCH] sched/fair: Prefer idle CPU to cache affinity
Message-ID: <YD0K8Sal4KbxWD23@hirez.programming.kicks-ass.net>
References: <20210226164029.122432-1-srikar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210226164029.122432-1-srikar@linux.vnet.ibm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 26, 2021 at 10:10:29PM +0530, Srikar Dronamraju wrote:
> +static int prefer_idler_llc(int this_cpu, int prev_cpu, int sync)
> +{
> +	struct sched_domain_shared *tsds, *psds;
> +	int pnr_busy, pllc_size, tnr_busy, tllc_size, diff;
> +
> +	tsds = rcu_dereference(per_cpu(sd_llc_shared, this_cpu));
> +	tnr_busy = atomic_read(&tsds->nr_busy_cpus);
> +	tllc_size = per_cpu(sd_llc_size, this_cpu);
> +
> +	psds = rcu_dereference(per_cpu(sd_llc_shared, prev_cpu));
> +	pnr_busy = atomic_read(&psds->nr_busy_cpus);
> +	pllc_size = per_cpu(sd_llc_size, prev_cpu);
> +

nr_busy_cpus is NO_HZ_COMMON So this code that consumes it should be
too.
