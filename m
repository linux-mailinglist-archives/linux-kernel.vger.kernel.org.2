Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C234540FE4F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 19:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244543AbhIQRBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 13:01:33 -0400
Received: from foss.arm.com ([217.140.110.172]:55734 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243848AbhIQRBc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 13:01:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 43992101E;
        Fri, 17 Sep 2021 10:00:10 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5E4103F59C;
        Fri, 17 Sep 2021 10:00:08 -0700 (PDT)
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
Subject: [PATCH] x86/resctrl: Free the ctrlval arrays when domain_setup_mon_state() fails
Date:   Fri, 17 Sep 2021 16:59:58 +0000
Message-Id: <20210917165958.28313-1-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210728170637.25610-1-james.morse@arm.com>
References: <20210728170637.25610-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

domain_add_cpu() is called whenever a CPU is brought online. The
earlier call to domain_setup_ctrlval() allocates the control value
arrays.

If domain_setup_mon_state() fails, the control value arrays are not
freed.

Add the missing kfree() calls.

Fixes: 1bd2a63b4f0de ("x86/intel_rdt/mba_sc: Add initialization support")
Fixes: edf6fa1c4a951 ("x86/intel_rdt/cqm: Add RMID (Resource monitoring ID) management")
Signed-off-by: James Morse <james.morse@arm.com>
---
This will not apply prior to v5.15-rc1, I'll provide a backport.
~s/hw_dom/d/;
---
 arch/x86/kernel/cpu/resctrl/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 4b8813bafffd..b5de5a6c115c 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -532,6 +532,8 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
 	}
 
 	if (r->mon_capable && domain_setup_mon_state(r, d)) {
+		kfree(hw_dom->ctrl_val);
+		kfree(hw_dom->mbps_val);
 		kfree(d);
 		return;
 	}
-- 
2.30.2

