Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EADC334B8D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 23:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232991AbhCJW0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 17:26:17 -0500
Received: from mga02.intel.com ([134.134.136.20]:11590 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230076AbhCJW0J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 17:26:09 -0500
IronPort-SDR: 9s2MadHV4EeEeTFcNjq4SAlwPbjI4q7DbQ4uk/pg/coorOyVtpyVw3+LV7Yjs0HNw6IydOYQAK
 +Ky1qRAj5lOA==
X-IronPort-AV: E=McAfee;i="6000,8403,9919"; a="175680130"
X-IronPort-AV: E=Sophos;i="5.81,238,1610438400"; 
   d="scan'208";a="175680130"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2021 14:26:08 -0800
IronPort-SDR: DaCZbLZi7fkrqtJT63YDgJ9vtvM2pKT5MASD2FBLcCpMUXff05RJq3bf/LphX3vS87zmTdte7J
 UobTP9hAZUog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,238,1610438400"; 
   d="scan'208";a="372111578"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga006.jf.intel.com with ESMTP; 10 Mar 2021 14:26:08 -0800
Date:   Wed, 10 Mar 2021 14:25:48 -0800
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        kan.liang@linux.intel.com, peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org, acme@kernel.org, tglx@linutronix.de,
        namhyung@kernel.org, jolsa@redhat.com, ak@linux.intel.com,
        yao.jin@linux.intel.com, alexander.shishkin@linux.intel.com,
        adrian.hunter@intel.com,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Subject: Re: [PATCH V2 1/25] x86/cpufeatures: Enumerate Intel Hybrid
 Technology feature bit
Message-ID: <20210310222548.GA28393@ranerica-svr.sc.intel.com>
References: <1615394281-68214-1-git-send-email-kan.liang@linux.intel.com>
 <1615394281-68214-2-git-send-email-kan.liang@linux.intel.com>
 <20210310165358.GI23521@zn.tnic>
 <20210310194644.GA1218@ranerica-svr.sc.intel.com>
 <20210310200147.GJ23521@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210310200147.GJ23521@zn.tnic>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2021 at 09:01:47PM +0100, Borislav Petkov wrote:
> On Wed, Mar 10, 2021 at 11:46:44AM -0800, Ricardo Neri wrote:
> > But this series provides the use case, right? Kan's patches handle PMU counters
> > that may differ cross types of CPUs. In patch 2, get_hybrid_params()
> > needs to check first if X86_FEATURE_HYBRID_CPU is enabled before
> > querying the hybrid parameters. Otherwise, we would need to rely on the
> > maximum level of CPUID, which may not be reliable.
> 
> On Wed, Mar 10, 2021 at 11:33:54AM -0800, Srinivas Pandruvada wrote:
> > We are working on changes to P-State driver for hybrid CPUs using this
> > define. They are still work in progress.
> > But this patch can be submitted later with our set of changes.
> 
> Answering to both with a single mail:
> 
> I don't have a problem with X86_FEATURE_HYBRID_CPU - I simply don't want
> to show "hybrid_cpu" in /proc/cpuinfo unless there's a valid use case
> for userspace to know that it is running on a hybrid CPU.

Ah, I get your point now. You would like to see

#define X86_FEATURE_HYBRID_CPU               (18*32+15) /* "" This part has CPUs of more than one type */

Right? Now your first comment makes sense.

Srinivas, Kan, I don't think we need to expose "hybrid_cpu" in
/proc/cpuinfo, do we?

Thanks and BR,
Ricardo
