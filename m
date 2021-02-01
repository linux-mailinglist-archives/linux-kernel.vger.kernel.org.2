Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71E1E30A84A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 14:07:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231853AbhBANHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 08:07:20 -0500
Received: from outbound-smtp15.blacknight.com ([46.22.139.232]:50133 "EHLO
        outbound-smtp15.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231873AbhBANHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 08:07:03 -0500
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp15.blacknight.com (Postfix) with ESMTPS id 0F44A1C4C90
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 13:06:05 +0000 (GMT)
Received: (qmail 23314 invoked from network); 1 Feb 2021 13:06:04 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 1 Feb 2021 13:06:04 -0000
Date:   Mon, 1 Feb 2021 13:06:03 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     "Li, Aubrey" <aubrey.li@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Qais Yousef <qais.yousef@arm.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 0/4] Scan for an idle sibling in a single pass
Message-ID: <20210201130603.GI3592@techsingularity.net>
References: <20210127135203.19633-1-mgorman@techsingularity.net>
 <cec31f9f-0eda-706e-235d-5bd2bfad6c2c@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <cec31f9f-0eda-706e-235d-5bd2bfad6c2c@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 01, 2021 at 09:13:16AM +0800, Li, Aubrey wrote:
> > Peter's series tried to solve three problems at once, this subset addresses
> > one problem.
> > 
> >  kernel/sched/fair.c     | 151 +++++++++++++++++++---------------------
> >  kernel/sched/features.h |   1 -
> >  2 files changed, 70 insertions(+), 82 deletions(-)
> > 
> 
> 4 benchmarks measured on a x86 4s system with 24 cores per socket and
> 2 HTs per core, total 192 CPUs. 
> 
> The load level is [25%, 50%, 75%, 100%].
> 
> - hackbench almost has a universal win.
> - netperf high load has notable changes, as well as tbench 50% load.
> 

Ok, both netperf and tbench are somewhat expected as at those loads are
rapidly idling. Previously I observed that rapidly idling loads can
allow the has_idle_cores test pass for short durations and the double
scanning means there is a greater chance of finding an idle CPU over the
two passes. I think overall it's better to avoid double scanning even if
there are counter examples as it's possible we'll get that back through
better depth selection in the future.

Thanks.

-- 
Mel Gorman
SUSE Labs
