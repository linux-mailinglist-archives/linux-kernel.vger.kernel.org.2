Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 578EB41F1BE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 18:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355253AbhJAQF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 12:05:29 -0400
Received: from foss.arm.com ([217.140.110.172]:46504 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355246AbhJAQFZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 12:05:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C91BC101E;
        Fri,  1 Oct 2021 09:03:40 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CC77E3F766;
        Fri,  1 Oct 2021 09:03:38 -0700 (PDT)
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
        lcherian@marvell.com, bobo.shaobowang@huawei.com,
        tan.shaopeng@fujitsu.com
Subject: [PATCH v2 06/23] x86/resctrl: Group struct rdt_hw_domain cleanup
Date:   Fri,  1 Oct 2021 16:02:45 +0000
Message-Id: <20211001160302.31189-7-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211001160302.31189-1-james.morse@arm.com>
References: <20211001160302.31189-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

domain_add_cpu() and domain_remove_cpu() need to kfree() the child
arrays that were allocated by domain_setup_ctrlval().

As this memory is moved around, and new arrays are created, adjusting
the error handling cleanup code becomes noisier.

To simplify this, move all the kfree() calls into a domain_free() helper.
This depends on struct rdt_hw_domain being kzalloc()d, allowing it to
unconditionally kfree() all the child arrays.

Signed-off-by: James Morse <james.morse@arm.com>
---
Changes since v1:
 * This patch is new
---
 arch/x86/kernel/cpu/resctrl/core.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index f1fa54de8136..7a2c24c5652c 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -414,6 +414,13 @@ void setup_default_ctrlval(struct rdt_resource *r, u32 *dc, u32 *dm)
 	}
 }
 
+void domain_free(struct rdt_hw_domain *hw_dom)
+{
+	kfree(hw_dom->ctrl_val);
+	kfree(hw_dom->mbps_val);
+	kfree(hw_dom);
+}
+
 static int domain_setup_ctrlval(struct rdt_resource *r, struct rdt_domain *d)
 {
 	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
@@ -488,7 +495,7 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
 	rdt_domain_reconfigure_cdp(r);
 
 	if (r->alloc_capable && domain_setup_ctrlval(r, d)) {
-		kfree(hw_dom);
+		domain_free(hw_dom);
 		return;
 	}
 
@@ -497,9 +504,7 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
 	err = resctrl_online_domain(r, d);
 	if (err) {
 		list_del(&d->list);
-		kfree(hw_dom->ctrl_val);
-		kfree(hw_dom->mbps_val);
-		kfree(d);
+		domain_free(hw_dom);
 	}
 }
 
@@ -547,12 +552,10 @@ static void domain_remove_cpu(int cpu, struct rdt_resource *r)
 		if (d->plr)
 			d->plr->d = NULL;
 
-		kfree(hw_dom->ctrl_val);
-		kfree(hw_dom->mbps_val);
 		bitmap_free(d->rmid_busy_llc);
 		kfree(d->mbm_total);
 		kfree(d->mbm_local);
-		kfree(hw_dom);
+		domain_free(hw_dom);
 		return;
 	}
 
-- 
2.30.2

