Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF13F31C9B0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 12:32:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbhBPLbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 06:31:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbhBPLbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 06:31:32 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9CBC061574
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 03:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=v2p5F2l64ss/iukjOf8SrXtGqS4gt9hnzkVOGo1KctE=; b=NiVr76PKF7+lTtseC5CuPHNv7G
        1tV/o5sEkt/vj/j1TTwmbe0lmKO+I1/25sYS+dxZPrANIDZ7+C1quR2OQ9y1OZ2GZOKYjg+zW09yi
        2pwOoyeQI6QJS/allnV1+YcFSTAj63iB4zt75MVnaENwrJDpaYOZMRiRrU0NMVRdgAl+5BZm6NH1D
        82wu9DjVAMbfd6IDFy9SXDCHWdr7Uu2r7CInM/xxNsfsZbGOtIPxNljPKoJx7PZcmGk/TtdNA1Kx3
        uoeqHKm0Wwjof7ac1a78V9Jv43/IxlX/zqhJVai7kwwxM3u78uHNFAXHINSrsu8f9zrupqIBWwayI
        HdPft1/A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lByXR-00Gnf2-KR; Tue, 16 Feb 2021 11:29:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 515293003E5;
        Tue, 16 Feb 2021 12:29:02 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3DD922BB730E1; Tue, 16 Feb 2021 12:29:02 +0100 (CET)
Date:   Tue, 16 Feb 2021 12:29:02 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alison Schofield <alison.schofield@intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "H. Peter Anvin" <hpa@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Prarit Bhargava <prarit@redhat.com>, brice.goglin@gmail.com
Subject: Re: [PATCH] x86, sched: Allow NUMA nodes to share an LLC on Intel
 platforms
Message-ID: <YCusfhxYO9rJ2wG1@hirez.programming.kicks-ass.net>
References: <20210209223943.9834-1-alison.schofield@intel.com>
 <YCOTujUj3D53uGjd@hirez.programming.kicks-ass.net>
 <b717d5cd-e40d-c86a-05de-a512a5e3b0af@intel.com>
 <YCQ2QiC7If2X8jnP@hirez.programming.kicks-ass.net>
 <20210210221134.GA12410@alison-desk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210210221134.GA12410@alison-desk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 02:11:34PM -0800, Alison Schofield wrote:

> This is equivalent to determining if x86_has_numa_in_package.
> Do you think there is an opportunity to set x86_has_numa_in_package
> earlier, and use it here and in set_cpu_sibling_map()?

Sure. Not sure that's actually clearer though.

> With that additional info (match_pkg()) how about -
> 
> Instead of this:
> -       if (!topology_same_node(c, o) && x86_match_cpu(snc_cpu))
> +       if (!topology_same_node(c, o) && x86_match_cpu(snc_cpu) && match_pkg(c, o))
> 
> Do this:
> 
> -       if (!topology_same_node(c, o) && x86_match_cpu(snc_cpu))
> +       if (!topology_same_node(c, o) && match_pkg(c, o))
> 
> 
> Looking at Commit 316ad248307f ("sched/x86: Rewrite set_cpu_sibling_map())
> which reworked topology WARNINGs, the intent was to "make sure to
> only warn when the check changes the end result"
> 
> This check doesn't change the end result. It returns false directly
> and if it were bypassed completely, it would still return false with
> a WARNING.

I'm not following the argument, we explicitly *do* modify the end result
for those SNC caches. Also, by doing what you propose, we fail to get a
warning if/when AMD decides to do 'funny' things.

Suppose AMD too thinks this is a swell idea, but they have subtly
different cache behaviour (just for giggles), then it all goes
undetected, which would be bad.

> If we add that additional match_pkg() check is removing the WARNING for
> all cases possible?

How many parts had that Intel Cluster-on-Die thing? Seeing how all the
new parts have the SNC crud, that seems like a finite list.

Wikipedia seems to suggest haswell and broadwell were the only onces
with COD on, skylake and later has the SNC.

How's something like this then (needs splitting into multiple patches I
suppose):

---
 arch/x86/kernel/smpboot.c | 76 +++++++++++++++++++++++++----------------------
 1 file changed, 41 insertions(+), 35 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 117e24fbfd8a..cfe23badf9a3 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -458,8 +458,31 @@ static bool match_smt(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
 	return false;
 }
 
+static bool match_die(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
+{
+	if ((c->phys_proc_id == o->phys_proc_id) &&
+		(c->cpu_die_id == o->cpu_die_id))
+		return true;
+	return false;
+}
+
+/*
+ * Unlike the other levels, we do not enforce keeping a
+ * multicore group inside a NUMA node.  If this happens, we will
+ * discard the MC level of the topology later.
+ */
+static bool match_pkg(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
+{
+	if (c->phys_proc_id == o->phys_proc_id)
+		return true;
+	return false;
+}
+
 /*
- * Define snc_cpu[] for SNC (Sub-NUMA Cluster) CPUs.
+ * Define intel_cod_cpu[] for Intel COD (Cluster-on-Die) CPUs.
+ *
+ * Any Intel CPU that has multiple nodes per package and doesn't match this
+ * will have the newer SNC (Sub-NUMA Cluster).
  *
  * These are Intel CPUs that enumerate an LLC that is shared by
  * multiple NUMA nodes. The LLC on these systems is shared for
@@ -473,14 +496,18 @@ static bool match_smt(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
  * NUMA nodes).
  */
 
-static const struct x86_cpu_id snc_cpu[] = {
-	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_X, NULL),
+static const struct x86_cpu_id intel_cod_cpu[] = {
+	X86_MATCH_INTEL_FAM6_MODEL(HASWELL_X, 0),	/* COD */
+	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL_X, 0),	/* COD */
+	X86_MATCH_INTEL_FAM6_MODEL(ANY, 1),		/* SNC */
 	{}
 };
 
 static bool match_llc(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
 {
+	const struct x86_cpu_id *id = x86_match_cpu(intel_cod_cpu);
 	int cpu1 = c->cpu_index, cpu2 = o->cpu_index;
+	bool intel_snc = id && id->driver_data;
 
 	/* Do not match if we do not have a valid APICID for cpu: */
 	if (per_cpu(cpu_llc_id, cpu1) == BAD_APICID)
@@ -495,32 +522,12 @@ static bool match_llc(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
 	 * means 'c' does not share the LLC of 'o'. This will be
 	 * reflected to userspace.
 	 */
-	if (!topology_same_node(c, o) && x86_match_cpu(snc_cpu))
+	if (match_pkg(c, o) && !topology_same_node(c, o) && intel_snc)
 		return false;
 
 	return topology_sane(c, o, "llc");
 }
 
-/*
- * Unlike the other levels, we do not enforce keeping a
- * multicore group inside a NUMA node.  If this happens, we will
- * discard the MC level of the topology later.
- */
-static bool match_pkg(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
-{
-	if (c->phys_proc_id == o->phys_proc_id)
-		return true;
-	return false;
-}
-
-static bool match_die(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
-{
-	if ((c->phys_proc_id == o->phys_proc_id) &&
-		(c->cpu_die_id == o->cpu_die_id))
-		return true;
-	return false;
-}
-
 
 #if defined(CONFIG_SCHED_SMT) || defined(CONFIG_SCHED_MC)
 static inline int x86_sched_itmt_flags(void)
@@ -592,14 +599,23 @@ void set_cpu_sibling_map(int cpu)
 	for_each_cpu(i, cpu_sibling_setup_mask) {
 		o = &cpu_data(i);
 
+		if (match_pkg(c, o) && !topology_same_node(c, o))
+			x86_has_numa_in_package = true;
+
 		if ((i == cpu) || (has_smt && match_smt(c, o)))
 			link_mask(topology_sibling_cpumask, cpu, i);
 
 		if ((i == cpu) || (has_mp && match_llc(c, o)))
 			link_mask(cpu_llc_shared_mask, cpu, i);
 
+		if ((i == cpu) || (has_mp && match_die(c, o)))
+			link_mask(topology_die_cpumask, cpu, i);
 	}
 
+	threads = cpumask_weight(topology_sibling_cpumask(cpu));
+	if (threads > __max_smt_threads)
+		__max_smt_threads = threads;
+
 	/*
 	 * This needs a separate iteration over the cpus because we rely on all
 	 * topology_sibling_cpumask links to be set-up.
@@ -613,8 +629,7 @@ void set_cpu_sibling_map(int cpu)
 			/*
 			 *  Does this new cpu bringup a new core?
 			 */
-			if (cpumask_weight(
-			    topology_sibling_cpumask(cpu)) == 1) {
+			if (threads == 1) {
 				/*
 				 * for each core in package, increment
 				 * the booted_cores for this new cpu
@@ -631,16 +646,7 @@ void set_cpu_sibling_map(int cpu)
 			} else if (i != cpu && !c->booted_cores)
 				c->booted_cores = cpu_data(i).booted_cores;
 		}
-		if (match_pkg(c, o) && !topology_same_node(c, o))
-			x86_has_numa_in_package = true;
-
-		if ((i == cpu) || (has_mp && match_die(c, o)))
-			link_mask(topology_die_cpumask, cpu, i);
 	}
-
-	threads = cpumask_weight(topology_sibling_cpumask(cpu));
-	if (threads > __max_smt_threads)
-		__max_smt_threads = threads;
 }
 
 /* maps the cpu to the sched domain representing multi-core */
