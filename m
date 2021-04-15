Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4209C36102A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 18:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233518AbhDOQ35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 12:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbhDOQ3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 12:29:49 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7B1FC061574
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 09:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=K2m/s8XtAQXIWhkWByFxUBgfPkUPowtAwvmwg2l85mQ=; b=VNPDt/kxQ78RntA8EWuBokJOMx
        vacXlC03B1oLodFWCLLuatEToPztLTIvNjI4M9fQo8ORveRFb5sgh8uVWeQ/OcC5z33DCDsgmkcnl
        xGqLH2tfluFQsbXUXINMYvZmEjL3SGmqpG6L3HbOLuCYjzOQ2ZWcPcqJnOSrGGcPgS7iDnE90jJvl
        hWyvGhpqZ0pv1NcXafB54BJ39s5tAtnkPVwCxpnQ7VPI9AwZ5Gpwewvvsfu93KvQ2iKOsr30zpCWJ
        FpZFdBq30KOuFA8oqcsAKVXm134oelbvYmoRxGplihQX/OIO2H3Y4S/FUntgV+lI2HR/2GMjdSyOr
        NQvqB4yQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lX4rb-00Gju0-0X; Thu, 15 Apr 2021 16:29:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 38C0930021C;
        Thu, 15 Apr 2021 18:29:06 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 01F312C80212C; Thu, 15 Apr 2021 18:29:05 +0200 (CEST)
Date:   Thu, 15 Apr 2021 18:29:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, mgorman@suse.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
        joshdon@google.com, valentin.schneider@arm.com
Cc:     linux-kernel@vger.kernel.org, greg@kroah.com,
        linux@rasmusvillemoes.dk,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] sched/debug: Rename the sched_debug parameter to
 sched_debug_verbose
Message-ID: <YHhp0THHD2ofUdZD@hirez.programming.kicks-ass.net>
References: <20210412101421.609526370@infradead.org>
 <20210412102001.287610138@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210412102001.287610138@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 12, 2021 at 12:14:25PM +0200, Peter Zijlstra wrote:

> +	debugfs_create_bool("debug_enabled", 0644, debugfs_sched, &sched_debug_enabled);

How's this on top of the whole series?

---
Subject: sched/debug: Rename the sched_debug parameter to sched_debug_verbose
From: Peter Zijlstra <peterz@infradead.org>
Date: Thu Apr 15 18:23:17 CEST 2021

CONFIG_SCHED_DEBUG is the build-time Kconfig knob, the boot param
sched_debug and the /debug/sched/debug_enabled knobs control the
sched_debug_enabled variable, but what they really do is make
SCHED_DEBUG more verbose, so rename the lot.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 Documentation/admin-guide/kernel-parameters.txt |    3 ++-
 Documentation/scheduler/sched-domains.rst       |   10 +++++-----
 kernel/sched/debug.c                            |    4 ++--
 kernel/sched/topology.c                         |   10 +++++-----
 4 files changed, 14 insertions(+), 13 deletions(-)

--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4756,7 +4756,8 @@
 
 	sbni=		[NET] Granch SBNI12 leased line adapter
 
-	sched_debug	[KNL] Enables verbose scheduler debug messages.
+	sched_debug_verbose
+			[KNL] Enables verbose scheduler debug messages.
 
 	schedstats=	[KNL,X86] Enable or disable scheduled statistics.
 			Allowed values are enable and disable. This feature
--- a/Documentation/scheduler/sched-domains.rst
+++ b/Documentation/scheduler/sched-domains.rst
@@ -74,8 +74,8 @@ for a given topology level by creating a
 calling set_sched_topology() with this array as the parameter.
 
 The sched-domains debugging infrastructure can be enabled by enabling
-CONFIG_SCHED_DEBUG and adding 'sched_debug' to your cmdline. If you forgot to
-tweak your cmdline, you can also flip the /sys/kernel/debug/sched_debug
-knob. This enables an error checking parse of the sched domains which should
-catch most possible errors (described above). It also prints out the domain
-structure in a visual format.
+CONFIG_SCHED_DEBUG and adding 'sched_debug_verbose' to your cmdline. If you
+forgot to tweak your cmdline, you can also flip the
+/sys/kernel/debug/sched/verbose knob. This enables an error checking parse of
+the sched domains which should catch most possible errors (described above). It
+also prints out the domain structure in a visual format.
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -275,7 +275,7 @@ static const struct file_operations sche
 
 #endif /* CONFIG_PREEMPT_DYNAMIC */
 
-__read_mostly bool sched_debug_enabled;
+__read_mostly bool sched_debug_verbose;
 
 static const struct seq_operations sched_debug_sops;
 
@@ -300,7 +300,7 @@ static __init int sched_init_debug(void)
 	debugfs_sched = debugfs_create_dir("sched", NULL);
 
 	debugfs_create_file("features", 0644, debugfs_sched, NULL, &sched_feat_fops);
-	debugfs_create_bool("debug_enabled", 0644, debugfs_sched, &sched_debug_enabled);
+	debugfs_create_bool("verbose", 0644, debugfs_sched, &sched_debug_verbose);
 #ifdef CONFIG_PREEMPT_DYNAMIC
 	debugfs_create_file("preempt", 0644, debugfs_sched, NULL, &sched_dynamic_fops);
 #endif
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -14,7 +14,7 @@ static cpumask_var_t sched_domains_tmpma
 
 static int __init sched_debug_setup(char *str)
 {
-	sched_debug_enabled = true;
+	sched_debug_verbose = true;
 
 	return 0;
 }
@@ -22,7 +22,7 @@ early_param("sched_debug", sched_debug_s
 
 static inline bool sched_debug(void)
 {
-	return sched_debug_enabled;
+	return sched_debug_verbose;
 }
 
 #define SD_FLAG(_name, mflags) [__##_name] = { .meta_flags = mflags, .name = #_name },
@@ -131,7 +131,7 @@ static void sched_domain_debug(struct sc
 {
 	int level = 0;
 
-	if (!sched_debug_enabled)
+	if (!sched_debug_verbose)
 		return;
 
 	if (!sd) {
@@ -152,7 +152,7 @@ static void sched_domain_debug(struct sc
 }
 #else /* !CONFIG_SCHED_DEBUG */
 
-# define sched_debug_enabled 0
+# define sched_debug_verbose 0
 # define sched_domain_debug(sd, cpu) do { } while (0)
 static inline bool sched_debug(void)
 {
@@ -2141,7 +2141,7 @@ build_sched_domains(const struct cpumask
 	if (has_asym)
 		static_branch_inc_cpuslocked(&sched_asym_cpucapacity);
 
-	if (rq && sched_debug_enabled) {
+	if (rq && sched_debug_verbose) {
 		pr_info("root domain span: %*pbl (max cpu_capacity = %lu)\n",
 			cpumask_pr_args(cpu_map), rq->rd->max_cpu_capacity);
 	}
