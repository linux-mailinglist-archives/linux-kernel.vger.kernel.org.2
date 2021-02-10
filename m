Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E62931706C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 20:42:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232892AbhBJTlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 14:41:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232536AbhBJTjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 14:39:45 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DCCBC061786
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 11:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=brclteCp5S0ACW9GqYHC/I0po7E3ehhIK15zyfOy9Ik=; b=mHl3Atv+mjArxbxhH66gGJzHij
        urjoFuWegb8cdmswXnGDgt0ESy7kLxLtVSQI642JrNjg+hxQbWPx2Ni68QU5sczIVFIwnR8iFcQWN
        cokI0+SgqAGWekoCD+cU63UBFAJMv4jOeawOG3A4NH5m4Vd7uOf1c0uOh9WZjPTwWsCywVg9df+kJ
        XMVtFFblLgEixEZNeztp2QBsuY1XeFMDNdqL7tB4B/uDS6XKP6tXorKkqVyzWl3/4GAjKpHaqtmrM
        PNCkwJmv3dbF3I4qMPPf+A0eV7MPt4JifQMGfhfg1NDPCrxNoqj6Mo80J5F8FVyGKkXjMMrJ7OBDh
        BglGq1WQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l9vJz-009IjI-RK; Wed, 10 Feb 2021 19:38:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 53FFA3010D2;
        Wed, 10 Feb 2021 20:38:42 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3B0B02018E5A1; Wed, 10 Feb 2021 20:38:42 +0100 (CET)
Date:   Wed, 10 Feb 2021 20:38:42 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
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
Message-ID: <YCQ2QiC7If2X8jnP@hirez.programming.kicks-ass.net>
References: <20210209223943.9834-1-alison.schofield@intel.com>
 <YCOTujUj3D53uGjd@hirez.programming.kicks-ass.net>
 <b717d5cd-e40d-c86a-05de-a512a5e3b0af@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b717d5cd-e40d-c86a-05de-a512a5e3b0af@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 07:22:03AM -0800, Dave Hansen wrote:
> On 2/10/21 12:05 AM, Peter Zijlstra wrote:
> >> +	if (IS_ENABLED(CONFIG_NUMA))
> >> +		set_cpu_bug(c, X86_BUG_NUMA_SHARES_LLC);
> >>  }
> > This seens wrong too, it shouldn't be allowed pre SKX. And ideally only
> > be allowed when SNC is enabled.
> 
> Originally, this just added a few more models to the list of CPUs with
> SNC.  I was hoping for something a bit more durable that we wouldn't
> have to go back and poke at every year or two.

It's not like we don't have to update a gazillion FMS tables for each
new instance anyway :-(

> > Please make this more specific than: all Intel CPUs. Ofcourse, since you
> > all knew this was an issue, you could've made it discoverable
> > _somewhere_ :-(
> 
> You're totally right, of course.  The hardware could enumerate SNC as a
> feature explicitly somewhere.  But, that's a little silly because all of
> the information that it's enumerating about the CPU caches and NUMA
> nodes present and correct is *correct*.  The secondary information would
> only be for the CPU to say, "yeah, I'm really sure about that other stuff".
> 
> I think this sanity check has outlived its usefulness.

Maybe BIOS monkeys got better, but I'm not sure I trust it all.

So SNC is all on-package, do all those nodes have the same pkg id? That
is, I'm trying to find something to restrict topological madness.


diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 88cd0064d1f8..de1010dd0bba 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -458,6 +458,26 @@ static bool match_smt(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
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
  * Define snc_cpu[] for SNC (Sub-NUMA Cluster) CPUs.
  *
@@ -495,33 +515,12 @@ static bool match_llc(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
 	 * means 'c' does not share the LLC of 'o'. This will be
 	 * reflected to userspace.
 	 */
-	if (!topology_same_node(c, o) && x86_match_cpu(snc_cpu))
+	if (!topology_same_node(c, o) && x86_match_cpu(snc_cpu) && match_pkg(c, o))
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
-
 #if defined(CONFIG_SCHED_SMT) || defined(CONFIG_SCHED_MC)
 static inline int x86_sched_itmt_flags(void)
 {
