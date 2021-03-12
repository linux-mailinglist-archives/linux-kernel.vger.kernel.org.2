Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65B223395BC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 19:01:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233299AbhCLSAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 13:00:49 -0500
Received: from foss.arm.com ([217.140.110.172]:58732 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232985AbhCLSAX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 13:00:23 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 59166106F;
        Fri, 12 Mar 2021 10:00:23 -0800 (PST)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8C9173F7D7;
        Fri, 12 Mar 2021 10:00:21 -0800 (PST)
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
        D Scott Phillips OS <scott@os.amperecomputing.com>
Subject: [PATCH v2 17/24] x86/resctrl: Use cdp_enabled in rdt_domain_reconfigure_cdp()
Date:   Fri, 12 Mar 2021 17:58:42 +0000
Message-Id: <20210312175849.8327-18-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210312175849.8327-1-james.morse@arm.com>
References: <20210312175849.8327-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rdt_domain_reconfigure_cdp() infers whether CDP is enabled by
checking the alloc_capable and alloc_enabled flags of the data
resources.

Now that we have an explicit cdp_enabled, use that.

Reviewed-by: Jamie Iles <jamie@nuviainc.com>
Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 55c17adf763c..378cad0020da 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1933,14 +1933,16 @@ static int set_cache_qos_cfg(int level, bool enable)
 /* Restore the qos cfg state when a domain comes online */
 void rdt_domain_reconfigure_cdp(struct rdt_resource *r)
 {
-	if (!r->alloc_capable)
+	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
+
+	if (!hw_res->cdp_capable)
 		return;
 
 	if (r == &rdt_resources_all[RDT_RESOURCE_L2DATA].resctrl)
-		l2_qos_cfg_update(&r->alloc_enabled);
+		l2_qos_cfg_update(&hw_res->cdp_enabled);
 
 	if (r == &rdt_resources_all[RDT_RESOURCE_L3DATA].resctrl)
-		l3_qos_cfg_update(&r->alloc_enabled);
+		l3_qos_cfg_update(&hw_res->cdp_enabled);
 }
 
 /*
-- 
2.30.0

