Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11E8C334BC1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 23:43:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233710AbhCJWnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 17:43:06 -0500
Received: from mga11.intel.com ([192.55.52.93]:25329 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233312AbhCJWms (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 17:42:48 -0500
IronPort-SDR: 6fNVxwACgFBbacAks+SYZzD3dZjvh5a/HpDSrnVJRVw3uWavVZvHd3myPb2KhOWrmHY1kJW0Nk
 umBqw6VRO70Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9919"; a="185221962"
X-IronPort-AV: E=Sophos;i="5.81,238,1610438400"; 
   d="scan'208";a="185221962"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2021 14:42:48 -0800
IronPort-SDR: 7QmvimHVZdBPd/6Oxp+gWQo1JczrApAEid/XwVZGVgNxif/6i+gnmW61AaoSAHwAlxmIt98SAd
 2A/fsM+h0GpA==
X-IronPort-AV: E=Sophos;i="5.81,238,1610438400"; 
   d="scan'208";a="431385953"
Received: from dkalra-mobl1.amr.corp.intel.com ([10.212.74.3])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2021 14:42:47 -0800
Message-ID: <7331f3cc0e78ba2cecdb98c52679a5a5b25ea790.camel@linux.intel.com>
Subject: Re: [PATCH V2 1/25] x86/cpufeatures: Enumerate Intel Hybrid
 Technology feature bit
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>
Cc:     kan.liang@linux.intel.com, peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org, acme@kernel.org, tglx@linutronix.de,
        namhyung@kernel.org, jolsa@redhat.com, ak@linux.intel.com,
        yao.jin@linux.intel.com, alexander.shishkin@linux.intel.com,
        adrian.hunter@intel.com,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Date:   Wed, 10 Mar 2021 14:42:47 -0800
In-Reply-To: <20210310222548.GA28393@ranerica-svr.sc.intel.com>
References: <1615394281-68214-1-git-send-email-kan.liang@linux.intel.com>
         <1615394281-68214-2-git-send-email-kan.liang@linux.intel.com>
         <20210310165358.GI23521@zn.tnic>
         <20210310194644.GA1218@ranerica-svr.sc.intel.com>
         <20210310200147.GJ23521@zn.tnic>
         <20210310222548.GA28393@ranerica-svr.sc.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-03-10 at 14:25 -0800, Ricardo Neri wrote:
> On Wed, Mar 10, 2021 at 09:01:47PM +0100, Borislav Petkov wrote:
> > On Wed, Mar 10, 2021 at 11:46:44AM -0800, Ricardo Neri wrote:
> > > But this series provides the use case, right? Kan's patches
> > > handle PMU counters
> > > that may differ cross types of CPUs. In patch 2,
> > > get_hybrid_params()
> > > needs to check first if X86_FEATURE_HYBRID_CPU is enabled before
> > > querying the hybrid parameters. Otherwise, we would need to rely
> > > on the
> > > maximum level of CPUID, which may not be reliable.
> > 
> > On Wed, Mar 10, 2021 at 11:33:54AM -0800, Srinivas Pandruvada
> > wrote:
> > > We are working on changes to P-State driver for hybrid CPUs using
> > > this
> > > define. They are still work in progress.
> > > But this patch can be submitted later with our set of changes.
> > 
> > Answering to both with a single mail:
> > 
> > I don't have a problem with X86_FEATURE_HYBRID_CPU - I simply don't
> > want
> > to show "hybrid_cpu" in /proc/cpuinfo unless there's a valid use
> > case
> > for userspace to know that it is running on a hybrid CPU.
> 
> Ah, I get your point now. You would like to see
> 
> #define X86_FEATURE_HYBRID_CPU               (18*32+15) /* "" This
> part has CPUs of more than one type */
> 
> Right? Now your first comment makes sense.
> 
> Srinivas, Kan, I don't think we need to expose "hybrid_cpu" in
> /proc/cpuinfo, do we?
I don't see any need.

Thanks,
Srinivas


> 
> Thanks and BR,
> Ricardo

