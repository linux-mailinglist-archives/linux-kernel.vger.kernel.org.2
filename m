Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81C343CA478
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 19:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234635AbhGOReh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 13:34:37 -0400
Received: from foss.arm.com ([217.140.110.172]:56252 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233622AbhGORe1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 13:34:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D8B426D;
        Thu, 15 Jul 2021 10:31:33 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E672D3F7D8;
        Thu, 15 Jul 2021 10:31:31 -0700 (PDT)
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
        lcherian@marvell.com, bobo.shaobowang@huawei.com
Subject: [PATCH v6 15/24] x86/resctrl: Rename update_domains() resctrl_arch_update_domains()
Date:   Thu, 15 Jul 2021 17:30:34 +0000
Message-Id: <20210715173043.14222-16-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210715173043.14222-1-james.morse@arm.com>
References: <20210715173043.14222-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

update_domains() merges the staged configuration changes into the
arch codes configuration array. Rename to make it clear its part of the
arch code interface to resctrl.

Reviewed-by: Jamie Iles <jamie@nuviainc.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: James Morse <james.morse@arm.com>
---
No changes since v3.

Changes since v2:
 * Shuffled commit message,

Changes since v1:
 * The closid is no longer staged as from resctrl its always going to be
   the same number even with CDP.
---
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 4 ++--
 arch/x86/kernel/cpu/resctrl/internal.h    | 1 -
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 2 +-
 include/linux/resctrl.h                   | 1 +
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index f29848f98846..8cde76df888a 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -259,7 +259,7 @@ static void apply_config(struct rdt_hw_domain *hw_dom,
 	}
 }
 
-int update_domains(struct rdt_resource *r, int closid)
+int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid)
 {
 	struct resctrl_staged_config *cfg;
 	struct rdt_hw_domain *hw_dom;
@@ -380,7 +380,7 @@ ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
 
 	list_for_each_entry(s, &resctrl_schema_all, list) {
 		r = s->res;
-		ret = update_domains(r, rdtgrp->closid);
+		ret = resctrl_arch_update_domains(r, rdtgrp->closid);
 		if (ret)
 			goto out;
 	}
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index b8b45bae4b5b..d89c251d7b5a 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -530,7 +530,6 @@ void rdt_pseudo_lock_release(void);
 int rdtgroup_pseudo_lock_create(struct rdtgroup *rdtgrp);
 void rdtgroup_pseudo_lock_remove(struct rdtgroup *rdtgrp);
 struct rdt_domain *get_domain_from_cpu(int cpu, struct rdt_resource *r);
-int update_domains(struct rdt_resource *r, int closid);
 int closids_supported(void);
 void closid_free(int closid);
 int alloc_rmid(void);
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 9f1354cb94e9..4b6de76493d6 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2870,7 +2870,7 @@ static int rdtgroup_init_alloc(struct rdtgroup *rdtgrp)
 				return ret;
 		}
 
-		ret = update_domains(r, rdtgrp->closid);
+		ret = resctrl_arch_update_domains(r, rdtgrp->closid);
 		if (ret < 0) {
 			rdt_last_cmd_puts("Failed to initialize allocations\n");
 			return ret;
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 51ba372f96cd..be5881171576 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -199,5 +199,6 @@ struct resctrl_schema {
 
 /* The number of closid supported by this resource regardless of CDP */
 u32 resctrl_arch_get_num_closid(struct rdt_resource *r);
+int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid);
 
 #endif /* _RESCTRL_H */
-- 
2.30.2

