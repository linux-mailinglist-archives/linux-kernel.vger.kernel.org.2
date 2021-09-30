Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7E7C41D6AE
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 11:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349630AbhI3JrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 05:47:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:46566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349519AbhI3Jqo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 05:46:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B418C6197A;
        Thu, 30 Sep 2021 09:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632995101;
        bh=FzacY9NXvSC18ci2MXEiMFfDtcQdnIfbuhcv0SGmGRk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EH6vgTUlsmmYYWkUQNdYo7uQgiyKoQRLp2p7E75dAgAG8cAhxOFSY1lmkMS//ev0q
         HPwMlqKgnlqMmT8EfU52I9QxzeptzBmGIzRMtiPWmJ4KCZzk+Merv7Ss4eTOprWOQk
         4fxiDiPIdfcPrh8dtl9UUzyx6rAk0ewz28fB3qNstQaMgv7zmqfm5GxKq/S1xkGe//
         SmfruSfguYtoyfTaSqQTF89YagMKzQlGoFAWCSZkFuKznDcGILo/ioSiwVfrSu2RLi
         zirfTgpLf7F3Ma1l4dy9GXqEImjfPzXtjrS43T3wbjaLgB5vyqB2I+G0Gs7sobfJUU
         kjGV/VN6j141A==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mVscd-002ATU-RN; Thu, 30 Sep 2021 11:44:59 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Anatoly Pugachev <matorola@gmail.com>,
        Carlos Bilbao <bilbao@vt.edu>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 7/7] ABI: sysfs-devices-system-cpu: use cpuX instead of cpu#
Date:   Thu, 30 Sep 2021 11:44:54 +0200
Message-Id: <60b1a79189d1a9d9f1c9c9c299770e69b18972fd.1632994837.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1632994837.git.mchehab+huawei@kernel.org>
References: <cover.1632994837.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some What entries here use cpu# as a wildcard, while others
use, instead, cpuX.

As scripts/get_abi.pl doesn't consider "#" as a wildcard,
replace:

	cpu# -> cpuX

inside the file.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---

See [PATCH v2 0/7] at: https://lore.kernel.org/all/cover.1632994837.git.mchehab+huawei@kernel.org/

 .../ABI/testing/sysfs-devices-system-cpu      | 52 +++++++++----------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
index 4ffc7e6ef403..69c65da16dff 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -7,7 +7,7 @@ Description:
 		Individual CPU attributes are contained in subdirectories
 		named by the kernel's logical CPU number, e.g.:
 
-		/sys/devices/system/cpu/cpu#/
+		/sys/devices/system/cpu/cpuX/
 
 What:		/sys/devices/system/cpu/kernel_max
 		/sys/devices/system/cpu/offline
@@ -53,7 +53,7 @@ Description:	Dynamic addition and removal of CPU's.  This is not hotplug
 		the system.  Information written to the file to remove CPU's
 		is architecture specific.
 
-What:		/sys/devices/system/cpu/cpu#/node
+What:		/sys/devices/system/cpu/cpuX/node
 Date:		October 2009
 Contact:	Linux memory management mailing list <linux-mm@kvack.org>
 Description:	Discover NUMA node a CPU belongs to
@@ -67,41 +67,41 @@ Description:	Discover NUMA node a CPU belongs to
 		/sys/devices/system/cpu/cpu42/node2 -> ../../node/node2
 
 
-What:		/sys/devices/system/cpu/cpu#/topology/core_id
-		/sys/devices/system/cpu/cpu#/topology/core_siblings
-		/sys/devices/system/cpu/cpu#/topology/core_siblings_list
-		/sys/devices/system/cpu/cpu#/topology/physical_package_id
-		/sys/devices/system/cpu/cpu#/topology/thread_siblings
-		/sys/devices/system/cpu/cpu#/topology/thread_siblings_list
+What:		/sys/devices/system/cpu/cpuX/topology/core_id
+		/sys/devices/system/cpu/cpuX/topology/core_siblings
+		/sys/devices/system/cpu/cpuX/topology/core_siblings_list
+		/sys/devices/system/cpu/cpuX/topology/physical_package_id
+		/sys/devices/system/cpu/cpuX/topology/thread_siblings
+		/sys/devices/system/cpu/cpuX/topology/thread_siblings_list
 Date:		December 2008
 Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
 Description:	CPU topology files that describe a logical CPU's relationship
 		to other cores and threads in the same physical package.
 
-		One cpu# directory is created per logical CPU in the system,
+		One cpuX directory is created per logical CPU in the system,
 		e.g. /sys/devices/system/cpu/cpu42/.
 
 		Briefly, the files above are:
 
-		core_id: the CPU core ID of cpu#. Typically it is the
+		core_id: the CPU core ID of cpuX. Typically it is the
 		hardware platform's identifier (rather than the kernel's).
 		The actual value is architecture and platform dependent.
 
-		core_siblings: internal kernel map of cpu#'s hardware threads
+		core_siblings: internal kernel map of cpuX's hardware threads
 		within the same physical_package_id.
 
 		core_siblings_list: human-readable list of the logical CPU
-		numbers within the same physical_package_id as cpu#.
+		numbers within the same physical_package_id as cpuX.
 
-		physical_package_id: physical package id of cpu#. Typically
+		physical_package_id: physical package id of cpuX. Typically
 		corresponds to a physical socket number, but the actual value
 		is architecture and platform dependent.
 
-		thread_siblings: internal kernel map of cpu#'s hardware
-		threads within the same core as cpu#
+		thread_siblings: internal kernel map of cpuX's hardware
+		threads within the same core as cpuX
 
-		thread_siblings_list: human-readable list of cpu#'s hardware
-		threads within the same core as cpu#
+		thread_siblings_list: human-readable list of cpuX's hardware
+		threads within the same core as cpuX
 
 		See Documentation/admin-guide/cputopology.rst for more information.
 
@@ -237,7 +237,7 @@ Description:
 		Total number of times this state has been requested by the CPU
 		while entering suspend-to-idle.
 
-What:		/sys/devices/system/cpu/cpu#/cpufreq/*
+What:		/sys/devices/system/cpu/cpuX/cpufreq/*
 Date:		pre-git history
 Contact:	linux-pm@vger.kernel.org
 Description:	Discover and change clock speed of CPUs
@@ -252,7 +252,7 @@ Description:	Discover and change clock speed of CPUs
 		See files in Documentation/cpu-freq/ for more information.
 
 
-What:		/sys/devices/system/cpu/cpu#/cpufreq/freqdomain_cpus
+What:		/sys/devices/system/cpu/cpuX/cpufreq/freqdomain_cpus
 Date:		June 2013
 Contact:	linux-pm@vger.kernel.org
 Description:	Discover CPUs in the same CPU frequency coordination domain
@@ -301,16 +301,16 @@ Description:	Processor frequency boosting control
 		Documentation/admin-guide/pm/cpufreq.rst
 
 
-What:		/sys/devices/system/cpu/cpu#/crash_notes
-		/sys/devices/system/cpu/cpu#/crash_notes_size
+What:		/sys/devices/system/cpu/cpuX/crash_notes
+		/sys/devices/system/cpu/cpuX/crash_notes_size
 Date:		April 2013
 Contact:	kexec@lists.infradead.org
 Description:	address and size of the percpu note.
 
 		crash_notes: the physical address of the memory that holds the
-		note of cpu#.
+		note of cpuX.
 
-		crash_notes_size: size of the note of cpu#.
+		crash_notes_size: size of the note of cpuX.
 
 
 What:		/sys/devices/system/cpu/intel_pstate/max_perf_pct
@@ -503,12 +503,12 @@ Description:	Identifies the subset of CPUs in the system that can execute
 		If absent, then all or none of the CPUs can execute AArch32
 		applications and execve() will behave accordingly.
 
-What:		/sys/devices/system/cpu/cpu#/cpu_capacity
+What:		/sys/devices/system/cpu/cpuX/cpu_capacity
 Date:		December 2016
 Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
 Description:	information about CPUs heterogeneity.
 
-		cpu_capacity: capacity of cpu#.
+		cpu_capacity: capacity of cpuX.
 
 What:		/sys/devices/system/cpu/vulnerabilities
 		/sys/devices/system/cpu/vulnerabilities/meltdown
@@ -560,7 +560,7 @@ Description:	Control Symmetric Multi Threading (SMT)
 			 If control status is "forceoff" or "notsupported" writes
 			 are rejected.
 
-What:		/sys/devices/system/cpu/cpu#/power/energy_perf_bias
+What:		/sys/devices/system/cpu/cpuX/power/energy_perf_bias
 Date:		March 2019
 Contact:	linux-pm@vger.kernel.org
 Description:	Intel Energy and Performance Bias Hint (EPB)
-- 
2.31.1

