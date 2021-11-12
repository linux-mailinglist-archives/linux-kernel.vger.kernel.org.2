Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5A0A44EB81
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 17:39:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235361AbhKLQm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 11:42:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233445AbhKLQmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 11:42:25 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 035DCC061766
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 08:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=US2LVy9rrFWMWH9Jn1bAl+TRbKz4CCjVMY+Q65Udfp4=; b=c4GRwQ9nyqyLiGMWlGxOly7iFA
        RPMTYzYqK9CH2VlsopIlm4Q4nlpgTuRcBUcV/92MkMjnAVKQqECNL3oVSKxEmG8TeRFsUQH3h0Nqu
        UtCVvKM/xcULSn8doXr6wi+RzRfD+RLaQNh8ds3FnxxcujQ3hkqVR/60VQzcAKsjif5gZxGOPcaAL
        JtmxoJbqHoIw4tZrzQ4I7tlP+e+qe0izfUt7BRV1uXffxntso8YTBupDkT3EaLETynhGBDCQIQJ0b
        kEHHCsF8Q0/rG2JkeGjzLhtTRYKykStRj1PfzVlnOokX9xxpHTSQh88q9bph+SiPw1vnlaQqSpFI0
        LtQuseFg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mlZaC-003fyx-8r; Fri, 12 Nov 2021 16:39:21 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E3FF630001B;
        Fri, 12 Nov 2021 17:39:19 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CAFB22CEFE160; Fri, 12 Nov 2021 17:39:19 +0100 (CET)
Date:   Fri, 12 Nov 2021 17:39:19 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Stephane Eranian <eranian@google.com>
Cc:     linux-kernel@vger.kernel.org, kim.phillips@amd.com,
        acme@redhat.com, jolsa@redhat.com, songliubraving@fb.com,
        mpe@ellerman.id.au, maddy@linux.ibm.com
Subject: Re: [PATCH v2 03/13] perf/x86/amd: add AMD Fam19h Branch Sampling
 support
Message-ID: <YY6YtwqSIWxP7GfR@hirez.programming.kicks-ass.net>
References: <20211111084415.663951-1-eranian@google.com>
 <20211111084415.663951-4-eranian@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211111084415.663951-4-eranian@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 11, 2021 at 12:44:05AM -0800, Stephane Eranian wrote:
> +/*
> + * Because of the way BRS operates with an inactive and active phases, and
> + * the link to one counter, it is not possible to have two events using BRS
> + * scheduled at the same time. There would be an issue with enforcing the
> + * period of each one and given that the BRS saturates, it would not be possible
> + * to guarantee correlated content for all events. Therefore, in situations
> + * where multiple events want to use BRS, the kernel enforces mutual exclusion.
> + * Exclusion is enforced by chosing only one counter for events using BRS.
> + * The event scheduling logic will then automatically multiplex the
> + * events and ensure that at most one event is actively using BRS.
> + *
> + * The BRS counter could be any counter, but there is no constraint on Fam19h,
> + * therefore all counters are equal and thus we pick the first one: PMC0
> + */
> +static struct event_constraint amd_fam19h_brs_cntr0_constraint =
> +	EVENT_CONSTRAINT(0, 0x1, AMD64_RAW_EVENT_MASK);
> +
> +static struct event_constraint amd_fam19h_brs_pair_cntr0_constraint =
> +	__EVENT_CONSTRAINT(0, 0x1, AMD64_RAW_EVENT_MASK, 1, 0, PERF_X86_EVENT_PAIR);
> +
> +static struct event_constraint *
> +amd_get_event_constraints_f19h(struct cpu_hw_events *cpuc, int idx,
> +			  struct perf_event *event)
> +{
> +	struct hw_perf_event *hwc = &event->hw;
> +	bool has_brs = is_amd_brs(hwc);
> +
> +	/*
> +	 * In case BRS is used with an event requiring a counter pair,
> +	 * the kernel allows it but only on counter 0 & 1 to enforce
> +	 * multiplexing requiring to protect BRS in case of multiple
> +	 * BRS users
> +	 */
> +	if (amd_is_pair_event_code(hwc)) {
> +		return has_brs ? &amd_fam19h_brs_pair_cntr0_constraint
> +			       : &pair_constraint;
> +	}
> +
> +	if (has_brs)
> +		return &amd_fam19h_brs_cntr0_constraint;
> +
> +	return &unconstrained;
> +}

That still allows BRS to be used together with unrelated counters and it
*will* destroy their utility by delaying the NMI.

BRS could perhaps share the PMU with !sampling counters, but sharing
with sampling counters is just asking for trouble.
