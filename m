Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85677337316
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 13:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233232AbhCKMvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 07:51:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233233AbhCKMvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 07:51:37 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30925C061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 04:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qKBDtPk/2Y6bHbVoX2mn8xLIPE5f9fft8oeQWMj2OzI=; b=ctuXjNF2HrLIk+0zhDgpkg2AiF
        2jlubnv2xV5f19FSfPHNnJbJRAkHjGZv9pwm7wIi7ilFR7N+rh+D5C0EMS2kEm6pXmDDm8eflncRH
        2j1o75ySDxgXsHCIZnZAOa13p269AwnHhSAwDkqUs/+h+t4p6ExxxtPvNBLUrjWXw1DBtI5LGhAeo
        8VKrB+cthtEBawC/mp6tWypjU4RdQR+bfwuP4+iqJzw7XkHFVPum+VZZwGNkMJpf8iIw9leNanT1Y
        RVqK3BbVpnHnOMNLdmFhRoLtY6kiq3hz7oKCZb5hrotYonYEpczyZ4+RNw89xiWpgXX39kuRJW3oz
        vMRpigOA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lKKmm-0099R5-KG; Thu, 11 Mar 2021 12:51:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D2E32301959;
        Thu, 11 Mar 2021 13:51:27 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C3BF429D00069; Thu, 11 Mar 2021 13:51:27 +0100 (CET)
Date:   Thu, 11 Mar 2021 13:51:27 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, acme@kernel.org,
        tglx@linutronix.de, bp@alien8.de, namhyung@kernel.org,
        jolsa@redhat.com, ak@linux.intel.com, yao.jin@linux.intel.com,
        alexander.shishkin@linux.intel.com, adrian.hunter@intel.com
Subject: Re: [PATCH V2 20/25] perf/x86/intel: Add Alder Lake Hybrid support
Message-ID: <YEoST/CMrA99gPZB@hirez.programming.kicks-ass.net>
References: <1615394281-68214-1-git-send-email-kan.liang@linux.intel.com>
 <1615394281-68214-21-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1615394281-68214-21-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2021 at 08:37:56AM -0800, kan.liang@linux.intel.com wrote:
> @@ -4059,6 +4099,34 @@ tfa_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
>  	return c;
>  }
>  
> +static struct event_constraint *
> +adl_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
> +			  struct perf_event *event)
> +{
> +	struct x86_hybrid_pmu *pmu = hybrid_pmu(event->pmu);
> +
> +	if (pmu->cpu_type == INTEL_HYBRID_TYPE_CORE)
> +		return spr_get_event_constraints(cpuc, idx, event);
> +	else if (pmu->cpu_type == INTEL_HYBRID_TYPE_ATOM)
> +		return tnt_get_event_constraints(cpuc, idx, event);
> +
> +	WARN_ON(1);
> +	return &emptyconstraint;
> +}
> +
> +static int adl_hw_config(struct perf_event *event)
> +{
> +	struct x86_hybrid_pmu *pmu = hybrid_pmu(event->pmu);
> +
> +	if (pmu->cpu_type == INTEL_HYBRID_TYPE_CORE)
> +		return hsw_hw_config(event);
> +	else if (pmu->cpu_type == INTEL_HYBRID_TYPE_ATOM)
> +		return intel_pmu_hw_config(event);
> +
> +	WARN_ON(1);
> +	return -EOPNOTSUPP;
> +}
> +
>  /*
>   * Broadwell:
>   *

> @@ -5266,6 +5342,84 @@ static const struct attribute_group *attr_update[] = {
>  	NULL,
>  };
>  
> +EVENT_ATTR_STR_HYBRID(slots,			slots_hybrid,			"event=0x00,umask=0x4", INTEL_HYBRID_TYPE_CORE);
> +EVENT_ATTR_STR_HYBRID(topdown-retiring,		td_retiring_hybrid,		"event=0xc2,umask=0x0;event=0x00,umask=0x80", INTEL_HYBRID_TYPE_ATOM | INTEL_HYBRID_TYPE_CORE);
> +EVENT_ATTR_STR_HYBRID(topdown-bad-spec,		td_bad_spec_hybrid,		"event=0x73,umask=0x0;event=0x00,umask=0x81", INTEL_HYBRID_TYPE_ATOM | INTEL_HYBRID_TYPE_CORE);
> +EVENT_ATTR_STR_HYBRID(topdown-fe-bound,		td_fe_bound_hybrid,		"event=0x71,umask=0x0;event=0x00,umask=0x82", INTEL_HYBRID_TYPE_ATOM | INTEL_HYBRID_TYPE_CORE);
> +EVENT_ATTR_STR_HYBRID(topdown-be-bound,		td_be_bound_hybrid,		"event=0x74,umask=0x0;event=0x00,umask=0x83", INTEL_HYBRID_TYPE_ATOM | INTEL_HYBRID_TYPE_CORE);
> +EVENT_ATTR_STR_HYBRID(topdown-heavy-ops,	td_heavy_ops_hybrid,		"event=0x00,umask=0x84", INTEL_HYBRID_TYPE_CORE);
> +EVENT_ATTR_STR_HYBRID(topdown-br-mispredict,	td_br_mispredict_hybrid,	"event=0x00,umask=0x85", INTEL_HYBRID_TYPE_CORE);
> +EVENT_ATTR_STR_HYBRID(topdown-fetch-lat,	td_fetch_lat_hybrid,		"event=0x00,umask=0x86", INTEL_HYBRID_TYPE_CORE);
> +EVENT_ATTR_STR_HYBRID(topdown-mem-bound,	td_mem_bound_hybrid,		"event=0x00,umask=0x87", INTEL_HYBRID_TYPE_CORE);
> +
> +static struct attribute *adl_hybrid_events_attrs[] = {
> +	EVENT_PTR(slots_hybrid),
> +	EVENT_PTR(td_retiring_hybrid),
> +	EVENT_PTR(td_bad_spec_hybrid),
> +	EVENT_PTR(td_fe_bound_hybrid),
> +	EVENT_PTR(td_be_bound_hybrid),
> +	EVENT_PTR(td_heavy_ops_hybrid),
> +	EVENT_PTR(td_br_mispredict_hybrid),
> +	EVENT_PTR(td_fetch_lat_hybrid),
> +	EVENT_PTR(td_mem_bound_hybrid),
> +	NULL,
> +};
> +
> +/* Must be in IDX order */
> +EVENT_ATTR_STR_HYBRID(mem-loads, mem_ld_adl_hybrid, "event=0xd0,umask=0x5,ldlat=3;event=0xcd,umask=0x1,ldlat=3", INTEL_HYBRID_TYPE_ATOM | INTEL_HYBRID_TYPE_CORE);
> +EVENT_ATTR_STR_HYBRID(mem-stores, mem_st_adl_hybrid, "event=0xd0,umask=0x6;event=0xcd,umask=0x2", INTEL_HYBRID_TYPE_ATOM | INTEL_HYBRID_TYPE_CORE);
> +EVENT_ATTR_STR_HYBRID(mem-loads-aux, mem_ld_aux_hybrid, "event=0x03,umask=0x82", INTEL_HYBRID_TYPE_CORE);
> +
> +static struct attribute *adl_hybrid_mem_attrs[] = {
> +	EVENT_PTR(mem_ld_adl_hybrid),
> +	EVENT_PTR(mem_st_adl_hybrid),
> +	EVENT_PTR(mem_ld_aux_hybrid),
> +	NULL,
> +};
> +
> +EVENT_ATTR_STR_HYBRID(tx-start, tx_start_adl_hybrid, "event=0xc9,umask=0x1", INTEL_HYBRID_TYPE_CORE);
> +EVENT_ATTR_STR_HYBRID(tx-commit, tx_commit_adl_hybrid, "event=0xc9,umask=0x2", INTEL_HYBRID_TYPE_CORE);
> +EVENT_ATTR_STR_HYBRID(tx-abort, tx_abort_adl_hybrid, "event=0xc9,umask=0x4", INTEL_HYBRID_TYPE_CORE);
> +EVENT_ATTR_STR_HYBRID(tx-conflict, tx_conflict_adl_hybrid, "event=0x54,umask=0x1", INTEL_HYBRID_TYPE_CORE);
> +EVENT_ATTR_STR_HYBRID(cycles-t, cycles_t_adl_hybrid, "event=0x3c,in_tx=1", INTEL_HYBRID_TYPE_CORE);
> +EVENT_ATTR_STR_HYBRID(cycles-ct, cycles_ct_adl_hybrid, "event=0x3c,in_tx=1,in_tx_cp=1", INTEL_HYBRID_TYPE_CORE);
> +EVENT_ATTR_STR_HYBRID(tx-capacity-read, tx_capacity_read_adl_hybrid, "event=0x54,umask=0x80", INTEL_HYBRID_TYPE_CORE);
> +EVENT_ATTR_STR_HYBRID(tx-capacity-write, tx_capacity_write_adl_hybrid, "event=0x54,umask=0x2", INTEL_HYBRID_TYPE_CORE);
> +
> +static struct attribute *adl_hybrid_tsx_attrs[] = {
> +	EVENT_PTR(tx_start_adl_hybrid),
> +	EVENT_PTR(tx_abort_adl_hybrid),
> +	EVENT_PTR(tx_commit_adl_hybrid),
> +	EVENT_PTR(tx_capacity_read_adl_hybrid),
> +	EVENT_PTR(tx_capacity_write_adl_hybrid),
> +	EVENT_PTR(tx_conflict_adl_hybrid),
> +	EVENT_PTR(cycles_t_adl_hybrid),
> +	EVENT_PTR(cycles_ct_adl_hybrid),
> +	NULL,
> +};
> +
> +FORMAT_ATTR_HYBRID(in_tx, INTEL_HYBRID_TYPE_CORE);
> +FORMAT_ATTR_HYBRID(in_tx_cp, INTEL_HYBRID_TYPE_CORE);
> +FORMAT_ATTR_HYBRID(offcore_rsp, INTEL_HYBRID_TYPE_CORE | INTEL_HYBRID_TYPE_ATOM);
> +FORMAT_ATTR_HYBRID(ldlat, INTEL_HYBRID_TYPE_CORE | INTEL_HYBRID_TYPE_ATOM);
> +FORMAT_ATTR_HYBRID(frontend, INTEL_HYBRID_TYPE_CORE);


This really could do with something like:

enum {
	BIGGIE = 0x40,
	smalls = 0x20,
	B_I_G  = BIGGIE | smalls,
};

s/INTEL_HYBRID_TYPE_CORE/BIGGIE/g
s/INTEL_HYBRID_TYPE_ATOM/smalls/g
s/INTEL_HYBRID_TYPE_ATOM | INTEL_HYBRID_TYPE_CORE/B_I_G/g

Also, many of thaot ATTR thingies can do with some horizontal alignment,
they're unreadable gibberish.
