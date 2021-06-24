Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9612B3B2865
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 09:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231461AbhFXHND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 03:13:03 -0400
Received: from mga02.intel.com ([134.134.136.20]:26654 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231132AbhFXHNC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 03:13:02 -0400
IronPort-SDR: /bnUzpuKdF477EUPdeh2cD2VRj9TeDMctRwVY6N4aErR/NRChmTiYCXyoqkmjJNvRNu1qvdFct
 i57eKhZP/99g==
X-IronPort-AV: E=McAfee;i="6200,9189,10024"; a="194551615"
X-IronPort-AV: E=Sophos;i="5.83,295,1616482800"; 
   d="scan'208";a="194551615"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2021 00:10:33 -0700
IronPort-SDR: Ti6ZIlimv7yKLXc57TzFml+Lf5gYDpHvKIbNtEk2+k5+qWrff45T74rObrfMHAtb9zKZIuGi2c
 52XqxFrtoCqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,295,1616482800"; 
   d="scan'208";a="487644671"
Received: from e3-z238.sh.intel.com ([10.239.154.113])
  by orsmga001.jf.intel.com with ESMTP; 24 Jun 2021 00:10:29 -0700
From:   Zhou JianFeng <jianfeng.zhou@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, H Peter Anvin <hpa@zytor.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Zhou JianFeng <jianfeng.zhou@intel.com>
Subject: [PATCH] x86/apic: use MSR programmming interface to read APIC register in x2APIC mode
Date:   Thu, 24 Jun 2021 15:08:04 +0800
Message-Id: <20210624070804.935474-1-jianfeng.zhou@intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Memory-mapped interface is only supported when operating in xAPIC mode.

When x2APIC mode enabled, the following calling will read APIC register by
memory-mapping interface in x2APIC mode:
    default_setup_apic_routing()
        x2apic_cluster_probe()
            init_x2apic_ldr()
                apic_read(APIC_LDR)
The APIC id read by apic_read(APIC_LDR) is invalid(0xffffffff in my tests),
and will lead to MCE(machine check exception) when RAS(Reliability
Availability Serviceability) enabled.

Read APIC id by using programming interface in x2APIC mode.

Signed-off-by: Zhou JianFeng <jianfeng.zhou@intel.com>
---
 arch/x86/kernel/apic/x2apic_cluster.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/apic/x2apic_cluster.c b/arch/x86/kernel/apic/x2apic_cluster.c
index f4da9bb69a88..311a844bb779 100644
--- a/arch/x86/kernel/apic/x2apic_cluster.c
+++ b/arch/x86/kernel/apic/x2apic_cluster.c
@@ -100,9 +100,14 @@ static u32 x2apic_calc_apicid(unsigned int cpu)
 static void init_x2apic_ldr(void)
 {
 	struct cluster_mask *cmsk = this_cpu_read(cluster_masks);
-	u32 cluster, apicid = apic_read(APIC_LDR);
+	u32 cluster, apicid;
 	unsigned int cpu;
 
+	if (x2apic_enabled())
+		apicid = native_apic_msr_read(APIC_LDR);
+	else
+		apicid = apic_read(APIC_LDR);
+
 	this_cpu_write(x86_cpu_to_logical_apicid, apicid);
 
 	if (cmsk)
-- 
2.27.0

