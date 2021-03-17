Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5080133FA2C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 21:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233498AbhCQU4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 16:56:36 -0400
Received: from foss.arm.com ([217.140.110.172]:47512 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233391AbhCQU4Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 16:56:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C512B1FB;
        Wed, 17 Mar 2021 13:56:15 -0700 (PDT)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DB28F3F70D;
        Wed, 17 Mar 2021 13:56:14 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     "Peter Zijlstra \(Intel\)" <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-ia64\@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        Sergei Trofimovich <slyfox@gentoo.org>,
        debian-ia64 <debian-ia64@lists.debian.org>
Subject: Re: [PATCH 0/1] sched/topology: NUMA distance deduplication
In-Reply-To: <87zgz1pmx4.mognet@arm.com>
References: <255d6b5d-194e-eb0e-ecdd-97477a534441@physik.fu-berlin.de> <8735wtr2ro.mognet@arm.com> <cf4d7277-54a0-8bc7-60fb-9b2f6befb511@physik.fu-berlin.de> <87zgz1pmx4.mognet@arm.com>
Date:   Wed, 17 Mar 2021 20:56:12 +0000
Message-ID: <87wnu5pkib.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/03/21 20:04, Valentin Schneider wrote:
> Technically it *is* coping with it, it's just dumping the entire NUMA
> distance matrix in the process... Let me see if I can't figure out why your
> system doesn't end up with nr_node_ids=1.
>

Does the below
a) compile
b) do anything?

From what I could gather, nothing actually tickles the possible map for
ia64. The standard pattern seems to be

        node_possible_map = numa_nodes_parsed;

but here at a quick glance it seems it's online or nothing, so that's what
I went for.

HTH.

---
diff --git a/arch/ia64/kernel/acpi.c b/arch/ia64/kernel/acpi.c
index a5636524af76..e2af6b172200 100644
--- a/arch/ia64/kernel/acpi.c
+++ b/arch/ia64/kernel/acpi.c
@@ -446,7 +446,8 @@ void __init acpi_numa_fixup(void)
 	if (srat_num_cpus == 0) {
 		node_set_online(0);
 		node_cpuid[0].phys_id = hard_smp_processor_id();
-		return;
+		slit_distance(0, 0) = LOCAL_DISTANCE;
+		goto out;
 	}
 
 	/*
@@ -489,7 +490,7 @@ void __init acpi_numa_fixup(void)
 			for (j = 0; j < MAX_NUMNODES; j++)
 				slit_distance(i, j) = i == j ?
 					LOCAL_DISTANCE : REMOTE_DISTANCE;
-		return;
+		goto out;
 	}
 
 	memset(numa_slit, -1, sizeof(numa_slit));
@@ -514,6 +515,8 @@ void __init acpi_numa_fixup(void)
 		printk("\n");
 	}
 #endif
+out:
+	node_possible_map = node_online_map;
 }
 #endif				/* CONFIG_ACPI_NUMA */
 
