Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA6E3A6FE3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 22:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235262AbhFNUMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 16:12:34 -0400
Received: from foss.arm.com ([217.140.110.172]:45632 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235102AbhFNUMZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 16:12:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3E13C11D4;
        Mon, 14 Jun 2021 13:10:22 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 161943F694;
        Mon, 14 Jun 2021 13:10:19 -0700 (PDT)
From:   James Morse <james.morse@arm.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        James Morse <james.morse@arm.com>,
        shameerali.kolothum.thodi@huawei.com,
        Jamie Iles <jamie@nuviainc.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        lcherian@marvell.com
Subject: [PATCH v4 10/24] x86/resctrl: Swizzle rdt_resource and resctrl_schema in pseudo_lock_region
Date:   Mon, 14 Jun 2021 20:09:27 +0000
Message-Id: <20210614200941.12383-11-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210614200941.12383-1-james.morse@arm.com>
References: <20210614200941.12383-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct pseudo_lock_region points to the rdt_resource.

Once the resources are merged, this won't be unique. The resource name
is moving into the schema, so that the filesystem portions of resctrl can
generate it.

Swap pseudo_lock_region's rdt_resource pointer for a schema pointer.

Reviewed-by: Jamie Iles <jamie@nuviainc.com>
Signed-off-by: James Morse <james.morse@arm.com>
---
No changes since v3.

Changes since v2:
 * Shuffled commit message,
---
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 4 ++--
 arch/x86/kernel/cpu/resctrl/internal.h    | 6 +++---
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c | 8 ++++----
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 4 ++--
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index dbbdd9f275e9..4428ec499037 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -227,7 +227,7 @@ static int parse_line(char *line, struct resctrl_schema *s,
 				 * the required initialization for single
 				 * region and return.
 				 */
-				rdtgrp->plr->r = r;
+				rdtgrp->plr->s = s;
 				rdtgrp->plr->d = d;
 				rdtgrp->plr->cbm = d->new_ctrl;
 				d->plr = rdtgrp->plr;
@@ -426,7 +426,7 @@ int rdtgroup_schemata_show(struct kernfs_open_file *of,
 				ret = -ENODEV;
 			} else {
 				seq_printf(s, "%s:%d=%x\n",
-					   rdtgrp->plr->r->name,
+					   rdtgrp->plr->s->res->name,
 					   rdtgrp->plr->d->id,
 					   rdtgrp->plr->cbm);
 			}
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 07aeff6c1af9..60155c20bd33 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -158,8 +158,8 @@ struct mongroup {
 
 /**
  * struct pseudo_lock_region - pseudo-lock region information
- * @r:			RDT resource to which this pseudo-locked region
- *			belongs
+ * @s:			Resctrl schema for the resource to which this
+ *			pseudo-locked region belongs
  * @d:			RDT domain to which this pseudo-locked region
  *			belongs
  * @cbm:		bitmask of the pseudo-locked region
@@ -179,7 +179,7 @@ struct mongroup {
  * @pm_reqs:		Power management QoS requests related to this region
  */
 struct pseudo_lock_region {
-	struct rdt_resource	*r;
+	struct resctrl_schema	*s;
 	struct rdt_domain	*d;
 	u32			cbm;
 	wait_queue_head_t	lock_thread_wq;
diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
index f079561409ab..2f99210a9d69 100644
--- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
+++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
@@ -246,7 +246,7 @@ static void pseudo_lock_region_clear(struct pseudo_lock_region *plr)
 	plr->line_size = 0;
 	kfree(plr->kmem);
 	plr->kmem = NULL;
-	plr->r = NULL;
+	plr->s = NULL;
 	if (plr->d)
 		plr->d->plr = NULL;
 	plr->d = NULL;
@@ -290,10 +290,10 @@ static int pseudo_lock_region_init(struct pseudo_lock_region *plr)
 
 	ci = get_cpu_cacheinfo(plr->cpu);
 
-	plr->size = rdtgroup_cbm_to_size(plr->r, plr->d, plr->cbm);
+	plr->size = rdtgroup_cbm_to_size(plr->s->res, plr->d, plr->cbm);
 
 	for (i = 0; i < ci->num_leaves; i++) {
-		if (ci->info_list[i].level == plr->r->cache_level) {
+		if (ci->info_list[i].level == plr->s->res->cache_level) {
 			plr->line_size = ci->info_list[i].coherency_line_size;
 			return 0;
 		}
@@ -796,7 +796,7 @@ bool rdtgroup_cbm_overlaps_pseudo_locked(struct rdt_domain *d, unsigned long cbm
 	unsigned long cbm_b;
 
 	if (d->plr) {
-		cbm_len = d->plr->r->cache.cbm_len;
+		cbm_len = d->plr->s->res->cache.cbm_len;
 		cbm_b = d->plr->cbm;
 		if (bitmap_intersects(&cbm, &cbm_b, cbm_len))
 			return true;
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 301a8acfaaf3..eaad9c8e6c04 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1439,8 +1439,8 @@ static int rdtgroup_size_show(struct kernfs_open_file *of,
 			ret = -ENODEV;
 		} else {
 			seq_printf(s, "%*s:", max_name_width,
-				   rdtgrp->plr->r->name);
-			size = rdtgroup_cbm_to_size(rdtgrp->plr->r,
+				   rdtgrp->plr->s->res->name);
+			size = rdtgroup_cbm_to_size(rdtgrp->plr->s->res,
 						    rdtgrp->plr->d,
 						    rdtgrp->plr->cbm);
 			seq_printf(s, "%d=%u\n", rdtgrp->plr->d->id, size);
-- 
2.30.2

