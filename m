Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE5F640FE49
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 18:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244023AbhIQRA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 13:00:57 -0400
Received: from foss.arm.com ([217.140.110.172]:55694 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237058AbhIQRAz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 13:00:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 83E82101E;
        Fri, 17 Sep 2021 09:59:31 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A27393F59C;
        Fri, 17 Sep 2021 09:59:29 -0700 (PDT)
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
Subject: [PATCH] x86/resctrl: Fix kfree() of the wrong type in domain_add_cpu()
Date:   Fri, 17 Sep 2021 16:59:24 +0000
Message-Id: <20210917165924.28254-1-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210728170637.25610-1-james.morse@arm.com>
References: <20210728170637.25610-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 792e0f6f789b ("x86/resctrl: Split struct rdt_domain") separated
the architecture specific and filesystem parts of the resctrl domain
structures.

This left the error paths in domain_add_cpu() kfree()ing the memory
with the wrong type.

This will cause a problem if someone adds a new member to struct
rdt_hw_domain meaining d_resctrl is no longer the first member.

Fixes: 792e0f6f789b ("x86/resctrl: Split struct rdt_domain")
Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/x86/kernel/cpu/resctrl/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index b5de5a6c115c..bb1c3f5f60c8 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -527,14 +527,14 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
 	rdt_domain_reconfigure_cdp(r);
 
 	if (r->alloc_capable && domain_setup_ctrlval(r, d)) {
-		kfree(d);
+		kfree(hw_dom);
 		return;
 	}
 
 	if (r->mon_capable && domain_setup_mon_state(r, d)) {
 		kfree(hw_dom->ctrl_val);
 		kfree(hw_dom->mbps_val);
-		kfree(d);
+		kfree(hw_dom);
 		return;
 	}
 
-- 
2.30.2

