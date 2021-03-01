Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D39632932E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 22:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239073AbhCAVGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 16:06:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237658AbhCARM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 12:12:58 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43324C061794
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 09:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tjW7UgwNvhAB6c+CxM0TgH3E/t+orZ9IpzUrq+oUHuk=; b=d817ea8DdcyjF1Ms0vm4tG30S7
        Njl0UIbfVny9x2ckhx90bzXas056RIuK4skUznHM4aVPINN2yDrvMHCTWL6qxGoXhxBpUKdR3jhsi
        Z/7BZnnPU3MqituD0C3SWo75teptezEh6mghCXidUVxcp+jTJzEvnLIQGTOqctQg9RS9G1/E9TOFa
        HUkEqf8wt7NT410YbIx7sl2aCX2qnojxpEax88/NuaxveNWQiZeMt/DmwxOlnFWMVVVJh8gu/lrCt
        3YaRYMGMKB33ItMgKDsJnUUSvrjOzGo9MqPYZUatuk4irkCWFvmV0QD1OHJ9k+nu7mVNka5vDtD+5
        oTJczHYw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1lGm4J-0006pR-HL; Mon, 01 Mar 2021 17:10:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 21F343003E1;
        Mon,  1 Mar 2021 18:10:48 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 02524201A7D18; Mon,  1 Mar 2021 18:10:47 +0100 (CET)
Date:   Mon, 1 Mar 2021 18:10:47 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nadav Amit <namit@vmware.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Rik van Riel <riel@surriel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v6 1/9] smp: Run functions concurrently in
 smp_call_function_many_cond()
Message-ID: <YD0gF9VuqKyVUgVS@hirez.programming.kicks-ass.net>
References: <20210220231712.2475218-1-namit@vmware.com>
 <20210220231712.2475218-2-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210220231712.2475218-2-namit@vmware.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 20, 2021 at 03:17:04PM -0800, Nadav Amit wrote:
> +		/*
> +		 * Choose the most efficient way to send an IPI. Note that the
> +		 * number of CPUs might be zero due to concurrent changes to the
> +		 * provided mask.
> +		 */
> +		if (nr_cpus == 1)
> +			arch_send_call_function_single_ipi(last_cpu);
> +		else if (likely(nr_cpus > 1))
> +			arch_send_call_function_ipi_mask(cfd->cpumask_ipi);

I just ran into conflicts with another patch set, and noticed that the
above should probably be:

		if (nr_cpus == 1)
			send_call_function_single_ipi(last_cpu);
		else if (likely(nr_cpus > 1))
			arch_send_call_function_ipi_mask(cfd->cpumask_ipi);

Which will avoid the IPI when @last_cpu is idle.


