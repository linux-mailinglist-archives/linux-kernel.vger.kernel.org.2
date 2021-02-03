Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0DD430DC7B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 15:19:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232845AbhBCOSB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 3 Feb 2021 09:18:01 -0500
Received: from mga11.intel.com ([192.55.52.93]:53896 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232192AbhBCORz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 09:17:55 -0500
IronPort-SDR: jEmnbIgjgKYb7hh4EvKXFpk5kNf+NdDRTSFL8wHU0VUSmeYTI53/VHFzzK1RjdwKzQT5cssYxy
 FghkTcRWg6pQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9883"; a="177539360"
X-IronPort-AV: E=Sophos;i="5.79,398,1602572400"; 
   d="scan'208";a="177539360"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2021 06:17:14 -0800
IronPort-SDR: un7CTrH3340njg5E1Tn51sO2+G9e5bhwpiANqUermFVnVzW6+n8IzGqk0yE+F6wub3Vf6wUX0n
 smKxUt2xiMbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,398,1602572400"; 
   d="scan'208";a="433430524"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP; 03 Feb 2021 06:17:14 -0800
Received: from shsmsx604.ccr.corp.intel.com (10.109.6.214) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 3 Feb 2021 06:17:13 -0800
Received: from shsmsx603.ccr.corp.intel.com (10.109.6.143) by
 SHSMSX604.ccr.corp.intel.com (10.109.6.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 3 Feb 2021 22:17:11 +0800
Received: from shsmsx603.ccr.corp.intel.com ([10.109.6.143]) by
 SHSMSX603.ccr.corp.intel.com ([10.109.6.143]) with mapi id 15.01.1713.004;
 Wed, 3 Feb 2021 22:17:11 +0800
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "kan.liang@linux.intel.com" <kan.liang@linux.intel.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>
Subject: RE: [PATCH 3/3] perf/x86/rapl: Fix psys-energy event on Intel SPR
 platform
Thread-Topic: [PATCH 3/3] perf/x86/rapl: Fix psys-energy event on Intel SPR
 platform
Thread-Index: AQHW7AYrkGH2U5eXgkirITO4BW5mdaorx78AgAwaqQCADrMocA==
Date:   Wed, 3 Feb 2021 14:17:11 +0000
Message-ID: <e246c407ce744662b8615aaa909b09e9@intel.com>
References: <20210115092208.20866-1-rui.zhang@intel.com>
 <20210115092208.20866-3-rui.zhang@intel.com>
 <YALhAmTgMHxEgeG4@hirez.programming.kicks-ass.net>
 <70b71922e7f84234be70c7104969331f@intel.com>
 <03e5815f89d749a18b47bdf986181f1f@intel.com>
In-Reply-To: <03e5815f89d749a18b47bdf986181f1f@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
x-originating-ip: [10.239.127.36]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Peter,

> -----Original Message-----
> From: Zhang, Rui
> Sent: Monday, January 25, 2021 2:11 PM
> To: 'Peter Zijlstra' <peterz@infradead.org>
> Cc: 'mingo@redhat.com' <mingo@redhat.com>; 'acme@kernel.org'
> <acme@kernel.org>; 'mark.rutland@arm.com' <mark.rutland@arm.com>;
> 'alexander.shishkin@linux.intel.com' <alexander.shishkin@linux.intel.com>;
> 'jolsa@redhat.com' <jolsa@redhat.com>; 'namhyung@kernel.org'
> <namhyung@kernel.org>; 'linux-kernel@vger.kernel.org' <linux-
> kernel@vger.kernel.org>; 'x86@kernel.org' <x86@kernel.org>;
> 'kan.liang@linux.intel.com' <kan.liang@linux.intel.com>; 'ak@linux.intel.com'
> <ak@linux.intel.com>
> Subject: RE: [PATCH 3/3] perf/x86/rapl: Fix psys-energy event on Intel SPR
> platform
> 
> Hi, Peter,
> 
> > -----Original Message-----
> > From: Zhang, Rui
> > Sent: Sunday, January 17, 2021 10:34 PM
> > To: 'Peter Zijlstra' <peterz@infradead.org>
> > Cc: mingo@redhat.com; acme@kernel.org; mark.rutland@arm.com;
> > alexander.shishkin@linux.intel.com; jolsa@redhat.com;
> > namhyung@kernel.org; linux-kernel@vger.kernel.org; x86@kernel.org;
> > kan.liang@linux.intel.com; ak@linux.intel.com
> > Subject: RE: [PATCH 3/3] perf/x86/rapl: Fix psys-energy event on Intel
> > SPR platform
> >
> > Hi, Peter,
> >
> > > -----Original Message-----
> > > From: Peter Zijlstra <peterz@infradead.org>
> > > Sent: Saturday, January 16, 2021 8:50 PM
> > > To: Zhang, Rui <rui.zhang@intel.com>
> > > Cc: mingo@redhat.com; acme@kernel.org; mark.rutland@arm.com;
> > > alexander.shishkin@linux.intel.com; jolsa@redhat.com;
> > > namhyung@kernel.org; linux-kernel@vger.kernel.org; x86@kernel.org;
> > > kan.liang@linux.intel.com; ak@linux.intel.com
> > > Subject: Re: [PATCH 3/3] perf/x86/rapl: Fix psys-energy event on
> > > Intel SPR platform
> > > Importance: High
> > >
> > > On Fri, Jan 15, 2021 at 05:22:08PM +0800, Zhang Rui wrote:
> > > > There are several things special for the RAPL Psys energy counter,
> > > > on Intel Sapphire Rapids platform.
> > > > 1. it contains one Psys master package, and only CPUs on the master
> > > >    package can read valid value of the Psys energy counter, reading the
> > > >    MSR on CPUs in the slave package returns 0.
> > > > 2. The master package does not have to be Physical package 0. And
> when
> > > >    all the CPUs on the Psys master package are offlined, we lose the Psys
> > > >    energy counter, at runtime.
> > > > 3. The Psys energy counter can be disabled by BIOS, while all the other
> > > >    energy counters are not affected.
> > > >
> > > > It is not easy to handle all of these in the current RAPL PMU
> > > > design because
> > > > a) perf_msr_probe() validates the MSR on some random CPU, which
> > > > may
> > > either
> > > >    be in the Psys master package or in the Psys slave package.
> > > > b) all the RAPL events share the same PMU, and there is not API to
> > remove
> > > >    the psys-energy event cleanly, without affecting the other events in
> > > >    the same PMU.
> > > >
> > > > This patch addresses the problems in a simple way.
> > > >
> > > > First, by setting .no_check bit for RAPL Psys MSR, the psys-energy
> > > > event is always added, so we don't have to check the Psys
> > > > ENERGY_STATUS MSR on master package.
> > > >
> > > > Then, rapl_not_visible() is removed because 1. it is useless for
> > > > RAPL MSRs with .no_check cleared, because the
> > > >    .is_visible() callbacks is always overridden in perf_msr_probe().
> > > > 2. it is useless for RAPL MSRs with .no_check set, because we actually
> > > >    want the sysfs attributes always be visible for those MSRs.
> > > >
> > > > With the above changes, we always probe the psys-energy event on
> > > > Intel SPR platform. Difference is that the event counter returns 0
> > > > when the Psys RAPL Domain is disabled by BIOS, or the Psys master
> > > > package is
> > > offlined.
> > >
> > > Maybe I'm too tired, but I cannot follow. How does this cure the
> > > fact that the rapl_cpu_mask might not include that master thing. And
> > > how can software detect what the master thing is to begin with?
> >
> > To make things simple, I ignore the master thing, and probe the
> > psys-energy counter blindly on SPR.
> > So rapl_cpu_mask still includes all the online CPUs.
> > This means that psys-energy is "valid" on all packages, and it just
> > returns different values on different packages.
> > AKA, whole system power consumption on Psys master package, and Zero
> > on Psys slave packages.
> >
> In short, the current code does not allow RAPL energy counter to return 0.
> And all the work I do is to allow Psys energy counter to return 0.
> In this way, the Psys event is "valid" on all CPUs, so we don't need to handle
> the master thing.
> The drawback is that we still see psys-energy event, but with 0 readout,
> when Psys counter is not available (master package offlined, or psys
> disabled).
> 
> TBH, I'm not quite sure if I understand your original question correctly or not,
> so please let me know if there is still something unclear.
> 
Sorry to bother, may I know your concern about this patch series?

Thanks,
rui
> Thanks,
> rui
> >
> > Thanks,
> > rui
