Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC5C438798A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 15:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349432AbhERNJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 09:09:21 -0400
Received: from foss.arm.com ([217.140.110.172]:51652 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349431AbhERNJL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 09:09:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DD1EBD6E;
        Tue, 18 May 2021 06:07:52 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DAD533F73B;
        Tue, 18 May 2021 06:07:51 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>
Subject: [PATCH] sched/debug: Don't update sched_domain debug directories before sched_debug_init()
Date:   Tue, 18 May 2021 14:07:25 +0100
Message-Id: <20210518130725.3563132-1-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since CPU capacity asymmetry can stem purely from maximum frequency
differences (e.g. Pixel 1), a rebuild of the scheduler topology can be
issued upon loading cpufreq, see:

  arch_topology.c::init_cpu_capacity_callback()

Turns out that if this rebuild happens *before* sched_debug_init() is
run (which is a late initcall), we end up messing up the sched_domain debug
directory: passing a NULL parent to debugfs_create_dir() ends up creating
the directory at the debugfs root, which in this case creates
/sys/kernel/debug/domains (instead of /sys/kernel/debug/sched/domains).

This currently doesn't happen on asymmetric systems which use cpufreq-scpi
or cpufreq-dt drivers, as those are loaded via
deferred_probe_initcall() (it is also a late initcall, but appears to be
ordered *after* sched_debug_init()).

Ionela has been working on detecting maximum frequency asymmetry via ACPI,
and that actually happens via a *device* initcall, thus before
sched_debug_init(), and causes the aforementionned debugfs mayhem.

One option would be to punt sched_debug_init() down to
fs_initcall_sync(). Preventing update_sched_domain_debugfs() from running
before sched_debug_init() appears to be the safer option.

Link: http://lore.kernel.org/r/20210514095339.12979-1-ionela.voinescu@arm.com
Fixes: 3b87f136f8fc ("sched,debug: Convert sysctl sched_domains to debugfs")
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/sched/debug.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 3bdee5fd7d29..6b5d6c7612fd 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -388,6 +388,13 @@ void update_sched_domain_debugfs(void)
 {
 	int cpu, i;
 
+	/*
+	 * This can unfortunately be invoked before sched_debug_init() creates
+	 * the debug directory. Don't touch sd_sysctl_cpus until then.
+	 */
+	if (!debugfs_sched)
+		return;
+
 	if (!cpumask_available(sd_sysctl_cpus)) {
 		if (!alloc_cpumask_var(&sd_sysctl_cpus, GFP_KERNEL))
 			return;
-- 
2.25.1

