Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44CC7334845
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 20:47:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbhCJTrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 14:47:20 -0500
Received: from mga09.intel.com ([134.134.136.24]:48818 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233659AbhCJTrE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 14:47:04 -0500
IronPort-SDR: kg3MYwHw/fFW83zCk7hbPjc2YkqKs4BlYXEJOeVIDqQkiizX94K9VrLKQjV2uo1Zfgcca8pDkT
 F7k98TgwUAvQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9919"; a="188648904"
X-IronPort-AV: E=Sophos;i="5.81,238,1610438400"; 
   d="scan'208";a="188648904"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2021 11:47:04 -0800
IronPort-SDR: Q5lcKJC4ou1WSE4Aso0a7QJqHUzCpOseCl7OaifJ1nRy0sCO513dGhZbvpd4VXx2apLUhCVwAi
 I8Ti0AtqyAUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,238,1610438400"; 
   d="scan'208";a="410326573"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga008.jf.intel.com with ESMTP; 10 Mar 2021 11:47:03 -0800
Date:   Wed, 10 Mar 2021 11:46:44 -0800
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     kan.liang@linux.intel.com, peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org, acme@kernel.org, tglx@linutronix.de,
        namhyung@kernel.org, jolsa@redhat.com, ak@linux.intel.com,
        yao.jin@linux.intel.com, alexander.shishkin@linux.intel.com,
        adrian.hunter@intel.com,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH V2 1/25] x86/cpufeatures: Enumerate Intel Hybrid
 Technology feature bit
Message-ID: <20210310194644.GA1218@ranerica-svr.sc.intel.com>
References: <1615394281-68214-1-git-send-email-kan.liang@linux.intel.com>
 <1615394281-68214-2-git-send-email-kan.liang@linux.intel.com>
 <20210310165358.GI23521@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210310165358.GI23521@zn.tnic>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2021 at 05:53:58PM +0100, Borislav Petkov wrote:
> On Wed, Mar 10, 2021 at 08:37:37AM -0800, kan.liang@linux.intel.com wrote:
> > From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> > 
> > Add feature enumeration to identify a processor with Intel Hybrid
> > Technology: one in which CPUs of more than one type are the same package.
> > On a hybrid processor, all CPUs support the same homogeneous (i.e.,
> > symmetric) instruction set. All CPUs enumerate the same features in CPUID.
> > Thus, software (user space and kernel) can run and migrate to any CPU in
> > the system as well as utilize any of the enumerated features without any
> > change or special provisions. The main difference among CPUs in a hybrid
> > processor are power and performance properties.
> > 
> > Cc: Andi Kleen <ak@linux.intel.com>
> > Cc: Kan Liang <kan.liang@linux.intel.com>
> > Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
> > Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> > Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
> > Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > Cc: linux-kernel@vger.kernel.org
> > Reviewed-by: Len Brown <len.brown@intel.com>
> > Reviewed-by: Tony Luck <tony.luck@intel.com>
> > Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> > ---
> > Changes since v1 (as part of patchset for perf change for Alderlake)
> >  * None
> > 
> > Changes since v1 (in a separate posting):
> >  * Reworded commit message to clearly state what is Intel Hybrid
> >    Technology. Stress that all CPUs can run the same instruction
> >    set and support the same features.
> > ---
> >  arch/x86/include/asm/cpufeatures.h | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> > index cc96e26d69f7..e7cfc9eedf8d 100644
> > --- a/arch/x86/include/asm/cpufeatures.h
> > +++ b/arch/x86/include/asm/cpufeatures.h
> > @@ -374,6 +374,7 @@
> >  #define X86_FEATURE_MD_CLEAR		(18*32+10) /* VERW clears CPU buffers */
> >  #define X86_FEATURE_TSX_FORCE_ABORT	(18*32+13) /* "" TSX_FORCE_ABORT */
> >  #define X86_FEATURE_SERIALIZE		(18*32+14) /* SERIALIZE instruction */
> > +#define X86_FEATURE_HYBRID_CPU		(18*32+15) /* This part has CPUs of more than one type */
> 
> 							  /* "" This ...
> 
> unless you have a valid use case for "hybrid_cpu" being present there.

But this series provides the use case, right? Kan's patches handle PMU counters
that may differ cross types of CPUs. In patch 2, get_hybrid_params()
needs to check first if X86_FEATURE_HYBRID_CPU is enabled before
querying the hybrid parameters. Otherwise, we would need to rely on the
maximum level of CPUID, which may not be reliable.

Thanks and BR,
Ricardo
