Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3892736C51F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 13:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235938AbhD0Lc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 07:32:58 -0400
Received: from mail-dm3nam07on2072.outbound.protection.outlook.com ([40.107.95.72]:45473
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230270AbhD0Lc4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 07:32:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gUm2oMEUKm66JGWC9LBiY26fQBEy2kVWAySbdKe4Eq6O1V9ShAfAmHwnyBj7kVcxpMrrtwOF/Q6W61OvHHgM9xNd3PXyMJA6nGQrRM/aWDbTp8G/KLHh3JR1WBD6LLLj8Kya/RBGEqrQvBZjR2xLfI7zIbk1LH+p+6TaIElNV6oXGdQFpYYFRwVR2ZIGDtJwcAfFr9P5iui6IUAnfHCkhwNvjw7ZXbtnjy6RYovE4U+ld7jE/lu4JRSS6mtS9fqZU4dpMWtRfe6cDBC/NREfh2o2gmkbmjQrR7J7TDaoNG+tcawnFyFTrxse9NXHsqYXTTdTKwYwPkIvhfESDLXgQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m7TAenGLS/4jZ3x/eVJ+zFQuWqkcS5lTDlVhFL5LLJw=;
 b=XG7Er91f7dgKgh8bVJ2ZMSDRrFd9W8hrU9c7GwAAAs9k82DeOgWFizHXEkDPpUUGSmp6Cd2VKfWhuhkbcCgNtetk+bnRtgm209gvUkNWYLclaB8vXYU3chKFPMWKrp0w8/XCSvffc2iGWSsJU2HXBdlDFwWMzKJywzPCKObZ3fj089uXn8HFfKAofCc7gF9EohT7pD7fYGIDb9sHaNXrjxNWHEsID+vRU8TZGaLMdhHHzO9OxkzJS899OS1j00ICtgblXeCYwuGFXoQkFb9BHhgMsm4K9M3a7Oiy4ybjcpMEFNv64RTt7QFiMcDG6hD43QCxyzcApiSe+GvWBspWnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m7TAenGLS/4jZ3x/eVJ+zFQuWqkcS5lTDlVhFL5LLJw=;
 b=SPmR9ZqELxERD41GOZajrjtaALjG9/HtwbWpoWGgKtMlPrlmRSs6YW7Mu1lAx1igkXPa3FXu8XbepyV3CmchAwRvwu3M9vi/aV1MRAo8SA2uAc0zXoq0f5o5OB568JlUJOnECg/S6DusjKTYBjGhOULWkkJRYr34dBQX+e3++9Q=
Received: from MN2PR07CA0012.namprd07.prod.outlook.com (2603:10b6:208:1a0::22)
 by BL0PR02MB4691.namprd02.prod.outlook.com (2603:10b6:208:59::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Tue, 27 Apr
 2021 11:32:09 +0000
Received: from BL2NAM02FT010.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:1a0:cafe::b8) by MN2PR07CA0012.outlook.office365.com
 (2603:10b6:208:1a0::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25 via Frontend
 Transport; Tue, 27 Apr 2021 11:32:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BL2NAM02FT010.mail.protection.outlook.com (10.152.77.53) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4065.21 via Frontend Transport; Tue, 27 Apr 2021 11:32:09 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 27 Apr 2021 04:31:57 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Tue, 27 Apr 2021 04:31:57 -0700
Envelope-to: git@xilinx.com,
 maz@kernel.org,
 tglx@linutronix.de,
 valentin.schneider@arm.com,
 dianders@chromium.org,
 hdegoede@redhat.com,
 mkshah@codeaurora.org,
 thunder.leizhen@huawei.com,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 robh+dt@kernel.org,
 frowand.list@gmail.com,
 devicetree@vger.kernel.org
Received: from [10.140.6.2] (port=33778 helo=xhdanirudh40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <anirudha.sarangi@xilinx.com>)
        id 1lbLwZ-000328-Vr; Tue, 27 Apr 2021 04:31:56 -0700
From:   Anirudha Sarangi <anirudha.sarangi@xilinx.com>
To:     Marc Zyngier <maz@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Michal Simek <michal.simek@xilinx.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Douglas Anderson <dianders@chromium.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Maulik Shah <mkshah@codeaurora.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        <devicetree@vger.kernel.org>, <git@xilinx.com>,
        Anirudha Sarangi <anirudha.sarangi@xilinx.com>
Subject: [PATCH 1/3] irqchip: xilinx: Avoid __init macro usage for xilinx_intc_of_init
Date:   Tue, 27 Apr 2021 17:01:34 +0530
Message-ID: <20210427113136.12469-2-anirudha.sarangi@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210427113136.12469-1-anirudha.sarangi@xilinx.com>
References: <20210427113136.12469-1-anirudha.sarangi@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bc167d9b-aa0b-4d8d-7384-08d909701807
X-MS-TrafficTypeDiagnostic: BL0PR02MB4691:
X-Microsoft-Antispam-PRVS: <BL0PR02MB469142B903B266FD8125992BDA419@BL0PR02MB4691.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GiiNc/5oCp15uQ8/3YRLzIl+55E81brOJpNwCoPCA9OiJbt7Tykezdogvqa3TLQklwVJnqH1bYHJk6PJ0acp3ZMt83MBIFAGIbZGkHFu0WhtANTb7ox+QchhRXAMeDDAwQF0XQh2K+yix/uE6YDXPz4d2VDO36h9uLWXv17opjk0lz+n4QrMpcGz94Ky9lFQOGiEdgSxfvQ06kvtSK/3UZCI+JrmXgpLXck3M7+xqGmgVCvfAkmvz7QCcutyxVobGMMyP2641SKeekZHHmmu1Bn6VIfTSYckHALB+NbNaAfuWK6pk9BQpp/IDOfKf2JAQX6MKsrB26Pgw54hmFPmgiPRqI82/3MxN3pi+EqvP3VbdIJ5xL/q/OVf60BVIWRv+NuAES1gW1WUsUCr63A0KjssRL+RuEHV7elAFDMnxpN2IetCT0ZZdtH+ti5eXIQcOuPe/9JnKmaPmTaGU6QCzChoM4051BC4WDgoXsEgjpP5DuQuxIt2cVOHDsijCpZLmVNyIAJtM4Yv5/L4nyYBJU/CZY92AUU5Tvq2Rmr5myd45MlB9WQMNFdLznJmktJSzWA1apcAhrgEtLrMx4R+j4Waxj+pMxKEFsuVMPV23DIlYgUpbVyfVYPFgIJkqut/wnoTFtst1Jnkt+edu/yQ57okS2rfvUQB7Tq0yF6APL9TWaxuItHQuDnHOgHqjVsk
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(39850400004)(136003)(346002)(376002)(396003)(36840700001)(46966006)(8936002)(26005)(54906003)(1076003)(336012)(82310400003)(82740400003)(107886003)(426003)(186003)(47076005)(44832011)(7416002)(9786002)(70206006)(2906002)(70586007)(6916009)(36906005)(8676002)(36860700001)(4326008)(7696005)(36756003)(7636003)(356005)(83380400001)(6666004)(316002)(5660300002)(478600001)(2616005)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2021 11:32:09.2312
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc167d9b-aa0b-4d8d-7384-08d909701807
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT010.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4691
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch ensures that xilinx_intc_of_init API is not allocated into
the .init.text section. Since this API calls the API set_handle_irq
which uses __init macro to be put into .init.text section, this patch
makes changes to ensure that set_handle_irq also does not stay in
.init.text section.
This patch is in preparation for the patch through which the xilinx
intc driver will be loaded and unloaded as a module.

Signed-off-by: Anirudha Sarangi <anirudha.sarangi@xilinx.com>
---
 drivers/irqchip/irq-xilinx-intc.c | 4 ++--
 include/linux/irq.h               | 2 +-
 kernel/irq/handle.c               | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-xilinx-intc.c b/drivers/irqchip/irq-xilinx-intc.c
index 1d3d273309bd..642733a6cbdf 100644
--- a/drivers/irqchip/irq-xilinx-intc.c
+++ b/drivers/irqchip/irq-xilinx-intc.c
@@ -177,8 +177,8 @@ static void xil_intc_irq_handler(struct irq_desc *desc)
 	chained_irq_exit(chip, desc);
 }
 
-static int __init xilinx_intc_of_init(struct device_node *intc,
-					     struct device_node *parent)
+static int xilinx_intc_of_init(struct device_node *intc,
+			       struct device_node *parent)
 {
 	struct xintc_irq_chip *irqc;
 	int ret, irq;
diff --git a/include/linux/irq.h b/include/linux/irq.h
index 2efde6a79b7e..252fab8074de 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -1250,7 +1250,7 @@ int ipi_send_mask(unsigned int virq, const struct cpumask *dest);
  * Returns 0 on success, or -EBUSY if an IRQ handler has already been
  * registered.
  */
-int __init set_handle_irq(void (*handle_irq)(struct pt_regs *));
+int set_handle_irq(void (*handle_irq)(struct pt_regs *));
 
 /*
  * Allows interrupt handlers to find the irqchip that's been registered as the
diff --git a/kernel/irq/handle.c b/kernel/irq/handle.c
index 762a928e18f9..a0b18e8f5af0 100644
--- a/kernel/irq/handle.c
+++ b/kernel/irq/handle.c
@@ -218,7 +218,7 @@ irqreturn_t handle_irq_event(struct irq_desc *desc)
 }
 
 #ifdef CONFIG_GENERIC_IRQ_MULTI_HANDLER
-int __init set_handle_irq(void (*handle_irq)(struct pt_regs *))
+int set_handle_irq(void (*handle_irq)(struct pt_regs *))
 {
 	if (handle_arch_irq)
 		return -EBUSY;
-- 
2.17.1

