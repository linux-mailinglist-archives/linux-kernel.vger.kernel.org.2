Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB652454543
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 11:58:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236598AbhKQLBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 06:01:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232746AbhKQLBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 06:01:52 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60690C061570
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 02:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qb2MXksHrFhSPMnDsNPeW1G/02YBtky1rBQTJAdASck=; b=OLUpaqGnjGugDUqoNi4wA4OTzK
        uP5cC/c81Y6o6FL29WfOZoZmgRwn32jVeUNJsRttwhjZmwysWmviVUZJOY43Q3d6bVdmF+saLLaYc
        DvBhByuR2tUQuAUtMXMFaQMANgy+K5m6lhoASio0tEUKGY2lW46/gjw+Fc3Bk2HgAscmS0U7LFTKf
        JhfVNiDpAW6ZCq1muPBGUdskpImaHkVI2dcqEy4IB0/GzyYKttIHYHua+MdxwSuvXfpgv2cDwphsp
        yw5krzKMNIcl29qtJTnptYklGQIbg0f3eGiN7qrYXq9yuXqCa3WNfdzpS5w+2TEp1uK/40PiWzUBh
        SICDIVYw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mnIe9-007XOT-5N; Wed, 17 Nov 2021 10:58:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 04FD2300129;
        Wed, 17 Nov 2021 11:58:31 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DC21D29A09DCE; Wed, 17 Nov 2021 11:58:31 +0100 (CET)
Date:   Wed, 17 Nov 2021 11:58:31 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Peng Wang <rocking@linux.alibaba.com>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add busy loop polling for idle SMT
Message-ID: <YZTgVzAFvZzXBrzy@hirez.programming.kicks-ass.net>
References: <cover.1637062971.git.rocking@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1637062971.git.rocking@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16, 2021 at 07:51:35PM +0800, Peng Wang wrote:
> Now we have cpu_idle_force_poll which uses cpu_relax() waiting for
> an arriving IPI, while sometimes busy loop on idle cpu is also
> useful to provide consistent pipeline interference for hardware SMT.
> 
> When hardware SMT is enabled, the switching between idle and
> busy state of one cpu will cause performance fluctuation of
> other sibling cpus on the same core.
> 
> In pay-for-execution-time scenario, cloud service providers prefer
> stable performance data to set stabel price for same workload.
> Different execution time of the same workload caused by different
> idle or busy state of sibling SMT cpus will make different bills, which
> is confused for customers.
> 
> Since there is no dynamic CPU time scaling based on SMT pipeline interference,
> to coordinate sibling SMT noise no matter whether they are idle or not,
> busy loop in idle state can provide approximately consistent pipeline interference.
> 
> For example, a workload computing tangent and cotangent will finish in 9071ms when
> sibling SMT cpus are idle, and 13299ms when sibling SMT cpus are computiing other workload.
> This generate 32% performance fluctuation.
> 
> SMT idle polling makes things slower, but we can set bigger cpu quota to make up
> a deficiency. This also increase power consumption by 2.2%, which is acceptable.
> 
> There may be some other possible solutions, while each has its own problem:
> a) disbale hardware SMT, which means half of SMT is unused and more hardware cost.
> b) busy loop in a userspace thread, but the cpu usage is confusing.
> 
> We propose this patch to discuss the performance fluctuation problem related to SMT
> pipeline interference, and any comments are welcome.

I think you missed April Fools' Day by a wide margin.

Lowering performance and increasing power usage is a direct
contradiction to sanity. It also doesn't really work as advertised,
if the siblings are competing for AVX resources the performance is a
*lot* lower than when an AVX task is competing against a spinner like
this.


