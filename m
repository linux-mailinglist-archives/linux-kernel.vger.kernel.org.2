Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC90D32A577
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 17:18:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447152AbhCBMmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 07:42:43 -0500
Received: from mga17.intel.com ([192.55.52.151]:58109 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1443555AbhCBML2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 07:11:28 -0500
IronPort-SDR: S2Nuc8ih+592qCF194o7bPup1sNTwVPF/+CY6B3NwPMEeg3kXALWbzES06hH0J9pByhzVlS3iV
 3ANL+E2OixTw==
X-IronPort-AV: E=McAfee;i="6000,8403,9910"; a="166668153"
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; 
   d="scan'208";a="166668153"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2021 04:06:37 -0800
IronPort-SDR: R3TnxNNhCdKddKie29fSnND3/BYknL6xmNS6Lq2TdoGsNb+S8ZRwswqLAXCsekCNJThMfLXnCu
 iEnIWea47dkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; 
   d="scan'208";a="398979659"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.165])
  by fmsmga008.fm.intel.com with ESMTP; 02 Mar 2021 04:06:35 -0800
Date:   Tue, 2 Mar 2021 20:06:34 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        Qais Yousef <qais.yousef@arm.com>, andi.kleen@intel.com
Subject: Re: [PATCH] clocksource: don't run watchdog forever
Message-ID: <20210302120634.GB76460@shbuild999.sh.intel.com>
References: <1614653665-20905-1-git-send-email-feng.tang@intel.com>
 <YD4CdQqX5Lea1rB5@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YD4CdQqX5Lea1rB5@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Tue, Mar 02, 2021 at 10:16:37AM +0100, Peter Zijlstra wrote:
> On Tue, Mar 02, 2021 at 10:54:24AM +0800, Feng Tang wrote:
> > clocksource watchdog runs every 500ms, which creates some OS noise.
> > As the clocksource wreckage (especially for those that has per-cpu
> > reading hook) usually happens shortly after CPU is brought up or
> > after system resumes from sleep state, so add a time limit for
> > clocksource watchdog to only run for a period of time, and make
> > sure it run at least twice for each CPU.
> > 
> > Regarding performance data, there is no improvement data with the
> > micro-benchmarks we have like hackbench/netperf/fio/will-it-scale
> > etc. But it obviously reduces periodic timer interrupts, and may
> > help in following cases:
> > * When some CPUs are isolated to only run scientific or high
> >   performance computing tasks on a NOHZ_FULL kernel, where there
> >   is almost no interrupts, this could make it more quiet
> > * On a cluster which runs a lot of systems in parallel with
> >   barriers there are always enough systems which run the watchdog
> >   and make everyone else wait
> > 
> > Signed-off-by: Feng Tang <feng.tang@intel.com>
> 
> Urgh.. so this hopes and prays that the TSC wrackage happens in the
> first 10 minutes after boot.

Yes, the 10 minutes part is only based on our past experience and we
can make it longer. But if there was real case that the wrackage happened
long after CPU is brought up like days, then this patch won't help much.

> Given the previous patch, the watchdog wouldn't be running at all on
> modern machines, so why wreck it for the old machines where it's
> actually needed?

Yes, this is for the older x86 machines and some other architectures. 

Thanks,
Feng


