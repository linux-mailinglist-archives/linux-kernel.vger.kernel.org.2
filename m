Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62A74392824
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 09:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234540AbhE0HF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 03:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233092AbhE0HFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 03:05:24 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC9DC061574;
        Thu, 27 May 2021 00:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=algR1xGAqGkW+cyqC0FjZ1B3MB1RsaFxY2Mhr0ENyvc=; b=jgP2B028zN2MAoXN5jm1jfgJQk
        8cg25hlQRdEoas8x4ienzjIQ0MnW4BV7YS4nhEqpZCLlN9cA75uWdzgNz7XMIWX+g7iSRgVJdJzxC
        HNMCRWJHZ6Cy5PRs/h26Q7b3/LhP1GRyAXNisWs4CtQV+JBbDb2J9lKjzvgG8Ka7pjEvXmJ+9YnZy
        zGjbU+vjguN1W+Ghc2Gf2Zo9PU2L4Cqx/m1VkAvyFB2Gpz9UT3L4bIXZQE5V/LoIwRd7Naz37T2C6
        RLb3PxBpqJwcL/d05trpWkfKi8hXk5uTLjr0FXoPfvKUjc/Dw6omQ/oKufvGadBXv3fYw+TC2iin6
        GR1ENOIA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lmA3L-000wGK-Ba; Thu, 27 May 2021 07:03:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5144F300223;
        Thu, 27 May 2021 09:03:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0EEA22C6D2B90; Thu, 27 May 2021 09:03:39 +0200 (CEST)
Date:   Thu, 27 May 2021 09:03:38 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Beata Michalska <beata.michalska@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org, corbet@lwn.net,
        rdunlap@infradead.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v5 2/3] sched/topology: Rework CPU capacity asymmetry
 detection
Message-ID: <YK9ESqNEo+uacyMD@hirez.programming.kicks-ass.net>
References: <20210524101617.8965-1-beata.michalska@arm.com>
 <20210524101617.8965-3-beata.michalska@arm.com>
 <87fsyc6mfz.mognet@arm.com>
 <20210524225508.GA14880@e120325.cambridge.arm.com>
 <87a6oj6sxo.mognet@arm.com>
 <20210525102945.GA24210@e120325.cambridge.arm.com>
 <98ad8837-b9b8-ff50-5a91-8d5951ee757c@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98ad8837-b9b8-ff50-5a91-8d5951ee757c@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 26, 2021 at 11:52:25AM +0200, Dietmar Eggemann wrote:

> For me asym_cpu_capacity_classify() is pretty hard to digest ;-) But I
> wasn't able to break it. It also performs correctly on (non-existing SMT)
> layer (with sd span eq. single CPU).

This is the simplest form I could come up with this morning:

static inline int
asym_cpu_capacity_classify(struct sched_domain *sd,
                          const struct cpumask *cpu_map)
{
	struct asym_cap_data *entry;
	int i = 0, n = 0;

	list_for_each_entry(entry, &asym_cap_list, link) {
		if (cpumask_intersects(sched_domain_span(sd), entry->cpu_mask))
			i++;
		else
			n++;
	}

	if (WARN_ON_ONCE(!i) || i == 1) /* no asymmetry */
		return 0;

	if (n) /* partial asymmetry */
		return SD_ASYM_CPUCAPACITY;

	/* full asymmetry */
	return SD_ASYM_CPUCAPACITY | SD_ASYM_CPUCAPACITY_FULL;
}


The early termination and everything was cute; but this isn't
performance critical code and clarity is paramount.
