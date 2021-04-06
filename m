Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6911F355491
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 15:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242350AbhDFNIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 09:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232492AbhDFNIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 09:08:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 094CFC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 06:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8/xaxLHR6n03/FPfkB/ueROTepgwsZt0N+t/P6W8Crc=; b=pP+Vwozp2pDlGvkJRd9fOuJVyu
        YFdFrinNiV/263xPtsEc4Jq7qFk5xH3xF+bUB1oj0r3HTLTXYEuiyWKhucISmZRYirgh1E12PD2A9
        9lce97dVjzzS8R76LnkWh8M9StXCjpGg8sK9a2hrnn0XzKq/EZ0WvRXoxkf0lUlgbPHTn6C6piqNp
        NHnmLN/H5HUa3pP144kujvUAyGgyTK9/ERqTxhimZmLLL7hbACqttTIcAojXNkX+dNfwr7PG6z51R
        hra79wMkB4jiYocq0cy10rpNtKIzw62ZqU5JqgkIpSxXjrJW5kIjl5fJ+tgY8az2WlDmfsMJhnvN6
        2YAvBNQA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lTlPY-00CpnV-I2; Tue, 06 Apr 2021 13:06:33 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 06604301179;
        Tue,  6 Apr 2021 15:06:23 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9805C2C1D2B54; Tue,  6 Apr 2021 13:17:28 +0200 (CEST)
Date:   Tue, 6 Apr 2021 13:17:28 +0200
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
Message-ID: <YGxDSMorjMADJGIT@hirez.programming.kicks-ass.net>
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
> @@ -8507,6 +8619,10 @@ static bool update_sd_pick_busiest(struct lb_env *env,
>  	if (!sgs->sum_h_nr_running)
>  		return false;
>  
> +	if (sgs->group_type == group_asym_packing &&
> +	    !asym_can_pull_tasks(env->dst_cpu, sds, sgs, sg))
> +		return false;

All of this makes my head hurt; but afaict this isn't right.

Your update_sg_lb_stats() change makes that we unconditionally set
sgs->group_asym_packing, and then this is to undo that. But it's not
clear this covers all cases right.

Even if !sched_asym_prefer(), we could end up selecting this sg as
busiest, but you're just bailing out here.

