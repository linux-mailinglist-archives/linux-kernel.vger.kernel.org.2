Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADA3B3063EB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 20:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbhA0TRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 14:17:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbhA0TRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 14:17:18 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC47C061574
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 11:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/56oh1F5D8pHMsQ0pvbjfvOA2FpHD772+NHhO0EYal0=; b=SjqCGe7TakG0OQ8dRUg2OVDXhr
        ZPOZub3Ah2hW43iZxxkh3YnFG7GtCGt+s6tx/5WcMXULMNUBpl3J2MT54/GI/uiR1olEbPDgznY5f
        DIc04WPneQqEnY7k/qklmYlPNRe6MnjKSaDFj0TcUdOGcoBjF4RNVr+XpckNfAbTqjz6nyW2nZqS9
        SVLzlPCFCP+P3a7w8JhZ/LbSKZfIv5U5RgJhU2sb7EIv7d7o9KeLBiWKRE/NyMJC0qCNePBL/bsn/
        E1o1BJBT51wMBokdhC7dh7gwgvHrqavU3Er3wSnDB6DL6lzgzmvZ+2C+UBEXCc0PRQpSDF9mHgatJ
        OFPpeKAA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l4qIa-007OmJ-Ql; Wed, 27 Jan 2021 19:16:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3EB9C300DAE;
        Wed, 27 Jan 2021 20:16:16 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2547C207D3C43; Wed, 27 Jan 2021 20:16:16 +0100 (CET)
Date:   Wed, 27 Jan 2021 20:16:16 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     acme@kernel.org, mingo@kernel.org, linux-kernel@vger.kernel.org,
        eranian@google.com, namhyung@kernel.org, jolsa@redhat.com,
        ak@linux.intel.com, yao.jin@linux.intel.com
Subject: Re: [PATCH 03/12] perf/x86/intel: Add perf core PMU support for
 Sapphire Rapids
Message-ID: <YBG8ACJBCvZsSbW5@hirez.programming.kicks-ass.net>
References: <1611088711-17177-1-git-send-email-kan.liang@linux.intel.com>
 <1611088711-17177-4-git-send-email-kan.liang@linux.intel.com>
 <YBAq11TjpYj2rAot@hirez.programming.kicks-ass.net>
 <4ce07775-1076-0a2d-55be-bea3c7dc63f9@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ce07775-1076-0a2d-55be-bea3c7dc63f9@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 26, 2021 at 10:44:17AM -0500, Liang, Kan wrote:
> 
> 
> On 1/26/2021 9:44 AM, Peter Zijlstra wrote:
> > On Tue, Jan 19, 2021 at 12:38:22PM -0800, kan.liang@linux.intel.com wrote:
> > > @@ -3671,6 +3853,31 @@ static int intel_pmu_hw_config(struct perf_event *event)
> > >   		}
> > >   	}
> > > +	/*
> > > +	 * To retrieve complete Memory Info of the load latency event, an
> > > +	 * auxiliary event has to be enabled simultaneously. Add a check for
> > > +	 * the load latency event.
> > > +	 *
> > > +	 * In a group, the auxiliary event must be in front of the load latency
> > > +	 * event. The rule is to simplify the implementation of the check.
> > > +	 * That's because perf cannot have a complete group at the moment.
> > > +	 */
> > > +	if (x86_pmu.flags & PMU_FL_MEM_LOADS_AUX &&
> > > +	    (event->attr.sample_type & PERF_SAMPLE_DATA_SRC) &&
> > > +	    is_mem_loads_event(event)) {
> > > +		struct perf_event *leader = event->group_leader;
> > > +		struct perf_event *sibling = NULL;
> > > +
> > > +		if (!is_mem_loads_aux_event(leader)) {
> > > +			for_each_sibling_event(sibling, leader) {
> > > +				if (is_mem_loads_aux_event(sibling))
> > > +					break;
> > > +			}
> > > +			if (list_entry_is_head(sibling, &leader->sibling_list, sibling_list))
> > > +				return -ENODATA;
> > > +		}
> > > +	}
> > > +
> > >   	if (!(event->attr.config & ARCH_PERFMON_EVENTSEL_ANY))
> > >   		return 0;
> > 
> > I have vague memories of this getting mentioned in a call at some point.
> > Pretend I don't know anything and tell me more.
> > 
> 
> Adding the auxiliary event is for the new data source fields, data block &
> address block. If perf only samples the load latency event, the value of the
> data block & address block fields in a sample is not correct. To get the
> correct value, we have to sample both the auxiliary event and the load
> latency together on SPR. So I add the check in the kernel. I also modify the
> perf mem in the perf tool accordingly.

This is an active work around for a chip defect right? Something we're
normally have an errata for. Can we call it that?
