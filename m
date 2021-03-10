Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 225EA334810
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 20:35:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233881AbhCJTe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 14:34:27 -0500
Received: from mga02.intel.com ([134.134.136.20]:62504 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233946AbhCJTeN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 14:34:13 -0500
IronPort-SDR: MOInNSGVhlSE+H5+CHHNu/04JnUL7XrRW7VyZfo3b8RU8jaO1LyJPeIn2hk2AhzK0HACo3ZyQt
 qcdXH8TmWncA==
X-IronPort-AV: E=McAfee;i="6000,8403,9919"; a="175652841"
X-IronPort-AV: E=Sophos;i="5.81,238,1610438400"; 
   d="scan'208";a="175652841"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2021 11:33:56 -0800
IronPort-SDR: 4q/YlqleLLHuo+df+eE056illbBAZzKDsKmNMDjnNDlED8Wkyp3y48zXMwB2zoIKMGFRrveqn0
 SCA6P3+RQPJA==
X-IronPort-AV: E=Sophos;i="5.81,238,1610438400"; 
   d="scan'208";a="438024791"
Received: from ptaylor-mobl1.amr.corp.intel.com ([10.209.7.164])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2021 11:33:55 -0800
Message-ID: <de1e7b2b08619ef2b9a37c06302230848ea964ba.camel@linux.intel.com>
Subject: Re: [PATCH V2 1/25] x86/cpufeatures: Enumerate Intel Hybrid
 Technology feature bit
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>, kan.liang@linux.intel.com
Cc:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org, acme@kernel.org, tglx@linutronix.de,
        namhyung@kernel.org, jolsa@redhat.com, ak@linux.intel.com,
        yao.jin@linux.intel.com, alexander.shishkin@linux.intel.com,
        adrian.hunter@intel.com,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Date:   Wed, 10 Mar 2021 11:33:54 -0800
In-Reply-To: <20210310165358.GI23521@zn.tnic>
References: <1615394281-68214-1-git-send-email-kan.liang@linux.intel.com>
         <1615394281-68214-2-git-send-email-kan.liang@linux.intel.com>
         <20210310165358.GI23521@zn.tnic>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-03-10 at 17:53 +0100, Borislav Petkov wrote:
> On Wed, Mar 10, 2021 at 08:37:37AM -0800, kan.liang@linux.intel.com
> wrote:
> > From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> > 
> > Add feature enumeration to identify a processor with Intel Hybrid
> > Technology: one in which CPUs of more than one type are the same
> > package.
> > On a hybrid processor, all CPUs support the same homogeneous (i.e.,
> > symmetric) instruction set. All CPUs enumerate the same features in
> > CPUID.
> > Thus, software (user space and kernel) can run and migrate to any
> > CPU in
> > the system as well as utilize any of the enumerated features
> > without any
> > change or special provisions. The main difference among CPUs in a
> > hybrid
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
> > Changes since v1 (as part of patchset for perf change for
> > Alderlake)
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
> > diff --git a/arch/x86/include/asm/cpufeatures.h
> > b/arch/x86/include/asm/cpufeatures.h
> > index cc96e26d69f7..e7cfc9eedf8d 100644
> > --- a/arch/x86/include/asm/cpufeatures.h
> > +++ b/arch/x86/include/asm/cpufeatures.h
> > @@ -374,6 +374,7 @@
> >  #define X86_FEATURE_MD_CLEAR		(18*32+10) /* VERW
> > clears CPU buffers */
> >  #define X86_FEATURE_TSX_FORCE_ABORT	(18*32+13) /* ""
> > TSX_FORCE_ABORT */
> >  #define X86_FEATURE_SERIALIZE		(18*32+14) /* SERIALIZE
> > instruction */
> > +#define X86_FEATURE_HYBRID_CPU		(18*32+15) /* This part
> > has CPUs of more than one type */
> 
> 							  /* "" This
> ...
> 
> unless you have a valid use case for "hybrid_cpu" being present
> there.
We are working on changes to P-State driver for hybrid CPUs using this
define. They are still work in progress.
But this patch can be submitted later with our set of changes.

Thanks,
Srinivas
 

> 
> Thx.
> 

