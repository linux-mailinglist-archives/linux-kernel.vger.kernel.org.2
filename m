Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 209663AB197
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 12:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbhFQKqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 06:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232113AbhFQKqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 06:46:21 -0400
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02460C061574;
        Thu, 17 Jun 2021 03:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
         s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=5ZAjHr2/sRedtNcQxJ9H/2kl/+cFC7b6FXdpx/e4Ong=; b=KfJWApOwyH9DUAo+TUGHAsw0pt
        CRLQz9ZMbuwYo3Jj1sTPoJN3gRqYFmo++RDRXy4jB868GWdCFKtw76bjwLRH2q7QQ4ZMm+CZr6DLk
        nxTTW9e6N+ZDrZTHXTpGFVzxqbUzBFieic+dFYRc3/RX6DkT45gJEdx7uQlzfW5WHs4zxKbon82ty
        T1U3U/MZLY2wYi4st+nNDIQFUCO24mxRx+YwFp1bnlhYkqwj+pOACqkBSIeREYjTS+/SA83Icjbs7
        u6bfrfxpcvqhbThPhTXUGvRU3QkM87yHKH/tiTCCqPC/HfhHIl0F7UO5I1UZBMmKNgn0tpl2PKvyQ
        0s1jTBug==;
Received: from dsl-hkibng22-54f986-236.dhcp.inet.fi ([84.249.134.236] helo=toshino.localdomain)
        by mail.kapsi.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <mperttunen@nvidia.com>)
        id 1ltpVH-0006tB-Mw; Thu, 17 Jun 2021 13:44:07 +0300
From:   Mikko Perttunen <mperttunen@nvidia.com>
To:     catalin.marinas@arm.com, will@kernel.org, thierry.reding@gmail.com,
        jonathanh@nvidia.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org,
        Mikko Perttunen <mperttunen@nvidia.com>
Subject: [PATCH 2/2] soc: tegra: Add Tegra186 ARI driver
Date:   Thu, 17 Jun 2021 13:40:53 +0300
Message-Id: <20210617104053.765434-2-mperttunen@nvidia.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210617104053.765434-1-mperttunen@nvidia.com>
References: <20210617104053.765434-1-mperttunen@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 84.249.134.236
X-SA-Exim-Mail-From: mperttunen@nvidia.com
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a driver to hook into SError interrupts and print machine check
status for debugging. Status information is retrieved via SMC. This
is supported by upstream ARM Trusted Firmware.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/soc/tegra/Makefile       |  1 +
 drivers/soc/tegra/ari-tegra186.c | 78 ++++++++++++++++++++++++++++++++
 2 files changed, 79 insertions(+)
 create mode 100644 drivers/soc/tegra/ari-tegra186.c

diff --git a/drivers/soc/tegra/Makefile b/drivers/soc/tegra/Makefile
index 9c809c1814bd..054e862b63d8 100644
--- a/drivers/soc/tegra/Makefile
+++ b/drivers/soc/tegra/Makefile
@@ -7,3 +7,4 @@ obj-$(CONFIG_SOC_TEGRA_PMC) += pmc.o
 obj-$(CONFIG_SOC_TEGRA_POWERGATE_BPMP) += powergate-bpmp.o
 obj-$(CONFIG_SOC_TEGRA20_VOLTAGE_COUPLER) += regulators-tegra20.o
 obj-$(CONFIG_SOC_TEGRA30_VOLTAGE_COUPLER) += regulators-tegra30.o
+obj-$(CONFIG_ARCH_TEGRA_186_SOC) += ari-tegra186.o
diff --git a/drivers/soc/tegra/ari-tegra186.c b/drivers/soc/tegra/ari-tegra186.c
new file mode 100644
index 000000000000..51b95af1dc78
--- /dev/null
+++ b/drivers/soc/tegra/ari-tegra186.c
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2021, NVIDIA CORPORATION.  All rights reserved.
+ */
+
+#include <linux/arm-smccc.h>
+#include <linux/kernel.h>
+#include <linux/of.h>
+
+#include <asm/traps.h>
+
+#define SMC_SIP_INVOKE_MCE			0xc2ffff00
+#define MCE_SMC_READ_MCA			12
+
+#define MCA_ARI_CMD_RD_SERR			1
+
+#define MCA_ARI_RW_SUBIDX_STAT			1
+#define SERR_STATUS_VAL				BIT_ULL(63)
+
+#define MCA_ARI_RW_SUBIDX_ADDR			2
+#define MCA_ARI_RW_SUBIDX_MSC1			3
+#define MCA_ARI_RW_SUBIDX_MSC2			4
+
+static const char * const bank_names[] = {
+	"SYS:DPMU", "ROC:IOB", "ROC:MCB", "ROC:CCE", "ROC:CQX", "ROC:CTU",
+};
+
+static void read_uncore_mca(u8 cmd, u8 idx, u8 subidx, u8 inst, u64 *data)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_smc(SMC_SIP_INVOKE_MCE | MCE_SMC_READ_MCA,
+		      ((u64)inst << 24) | ((u64)idx << 16) |
+			      ((u64)subidx << 8) | ((u64)cmd << 0),
+		      0, 0, 0, 0, 0, 0, &res);
+
+	*data = res.a2;
+}
+
+static void tegra186_ari_process_serror(void)
+{
+	u64 status;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(bank_names); i++) {
+		read_uncore_mca(MCA_ARI_CMD_RD_SERR, i, MCA_ARI_RW_SUBIDX_STAT,
+				0, &status);
+
+		if (status & SERR_STATUS_VAL) {
+			u64 addr, misc1, misc2;
+
+			read_uncore_mca(MCA_ARI_CMD_RD_SERR, i,
+					MCA_ARI_RW_SUBIDX_ADDR, 0, &addr);
+			read_uncore_mca(MCA_ARI_CMD_RD_SERR, i,
+					MCA_ARI_RW_SUBIDX_MSC1, 0, &misc1);
+			read_uncore_mca(MCA_ARI_CMD_RD_SERR, i,
+					MCA_ARI_RW_SUBIDX_MSC2, 0, &misc2);
+
+			pr_crit("Machine Check Error in %s\n"
+				"  status=0x%llx addr=0x%llx\n"
+				"  msc1=0x%llx msc2=0x%llx\n",
+				bank_names[i], status, addr, misc1, misc2);
+		}
+	}
+}
+
+static struct serror_hook tegra186_ari_serror_hook = {
+	.fn = tegra186_ari_process_serror,
+};
+
+static int __init tegra186_ari_init(void)
+{
+	if (of_machine_is_compatible("nvidia,tegra186"))
+		register_serror_hook(&tegra186_ari_serror_hook);
+
+	return 0;
+}
+early_initcall(tegra186_ari_init);
-- 
2.30.1

