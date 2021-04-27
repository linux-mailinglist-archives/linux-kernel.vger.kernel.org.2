Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5757E36C524
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 13:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236062AbhD0LdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 07:33:12 -0400
Received: from mail-eopbgr700049.outbound.protection.outlook.com ([40.107.70.49]:35681
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230270AbhD0LdH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 07:33:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A2Z1fdFmTqd0GArWRvdvHBP6oGufE5ZOn1YhSp+6aqXnxZXsVRIRH0ltCVwHWVz+ovNIPjvKwUKMktxaeZ97m75bdjFWq91EkTWHeFLrtS9dh06+Q2TdApk8bMli3HBWViUqfhVDMALpunGP0F8kaxlStPV+WGSR9fkQvTWgp6X1a8/Q3Zu0b3qsFeJ9Q+DMjC33pkBHaE2OL2nfIHnYFd/TVTXKyNsWygW1Ve+mmsiI4AEEIaTyGt/Z+IT6S6INkAlDqJH6FJEo4ksRUrOSjEjYO4EmlyY5QbO4FdA8G/n+GNTwpQUX1ptHF7s3PXmiM6Nnrr8vLC5drTU1K001Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0BeuZoxenLnE8VmKSmVTtyYjiijUwBlHPOBZRTggydA=;
 b=BoZcPzPoy4TVyt5OzzgeBFlLCknKwqr7k2+U815T/Abv+eZypZvQc3mBRNPMstsIXEqXUryhX1w/D8cwsQx5jPwzlvv7fo2VOuZf65Qd4RgaitwMq/dGY1hb34JwFK4x3m0z/LojU6OzcsX4h33kbDUgXbdpsTPkkeGkKVbsfT/ZQ1It4xZHqK1lgluFQCn2QVwtOiS6wko5cNqgKMGjWU+ZLPcRbWaSoHokAMscBWmYjPctq+BTabK3lNrPmoBqbHtnsnL1dXX6durGzHBYl69Sv8UToJz784SeocbJMfdtT2rlO9LGsLGu+SCbwQTwIIl5kpKypKLPylPrAQ4X8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0BeuZoxenLnE8VmKSmVTtyYjiijUwBlHPOBZRTggydA=;
 b=eLKg/WfVVzXpFy0DUSvW3ycRSGvhGL0UCGnZGN14yttajkTyCkUZPcvntxgdMRURygAJkjNx1CuqpQEGVnn5PAnQYRYjX7MPmM7fzTU5o/NZq4VmuCdz7WGoOlm5WidTa3XYvouzUPNrBG2kSQWU0bW9Jz/46UmG/oyneVBQLis=
Received: from BLAPR03CA0109.namprd03.prod.outlook.com (2603:10b6:208:32a::24)
 by CY4PR02MB2487.namprd02.prod.outlook.com (2603:10b6:903:70::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.25; Tue, 27 Apr
 2021 11:32:22 +0000
Received: from BL2NAM02FT032.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:32a:cafe::4d) by BLAPR03CA0109.outlook.office365.com
 (2603:10b6:208:32a::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21 via Frontend
 Transport; Tue, 27 Apr 2021 11:32:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BL2NAM02FT032.mail.protection.outlook.com (10.152.77.169) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4065.21 via Frontend Transport; Tue, 27 Apr 2021 11:32:22 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 27 Apr 2021 04:32:05 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Tue, 27 Apr 2021 04:32:05 -0700
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
        id 1lbLwi-000328-3d; Tue, 27 Apr 2021 04:32:04 -0700
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
Subject: [PATCH 3/3] irqchip: xilinx: Add support to remove the Xilinx INTC driver module.
Date:   Tue, 27 Apr 2021 17:01:36 +0530
Message-ID: <20210427113136.12469-4-anirudha.sarangi@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210427113136.12469-1-anirudha.sarangi@xilinx.com>
References: <20210427113136.12469-1-anirudha.sarangi@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d20cc9e5-bd5a-4c23-0165-08d909701fd2
X-MS-TrafficTypeDiagnostic: CY4PR02MB2487:
X-Microsoft-Antispam-PRVS: <CY4PR02MB2487BD8485D2E2C5F9B661DADA419@CY4PR02MB2487.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RauWucipxkuHo/dcuOwtef51C0T0IFCERRxagzY935GUUMxkoirSs3uMhwjGokPoR1uK04sBF/MxM7a3BisI2gfGgpA45wEM42LuIR/8ULoChLcKsZnylJd+JW7d8SDQq+ndflHbaiaHQnfcSJjzXPvLdVE02Z0654hmHwCBanv9mtx+YxKM9U+WGhtUZEvjZeAG1UP5FzWiPTzvwsIToAFHLHF8EtEpzA0dR1k0q1LRaCCgOUIceSPIH2JdFX1LHEUz4ifTKe2cDbHtfBDWnyhhDMP2q768TpG0ywo1nJvHfLCuzYZ0T7+kxc5UzXYe5gz9eNPxxaWlmHC3HISnvsc9ijOHcoxHELPmmELH20Q+OoMIhiBq9nvms06guGWt2oX2DACnEfn4ugcN/h+3fIrNkSAsxZ2lI0n2+fu23XaZT8vT+Q0wd9RlG/UseuqIR6krEOwYsgiGeYbxXsrGdhgDD4nd2MzkIUAcnZWq/12tg29VJDAG4p466H1JOEhj4V8iV3iGYS6jq4Xw2UelglSpukYfChVmMAifgY5qGKh1DsuZS9185IDmDKfFnsgklLwC6jpNdNpFx9bpIKLxueI85P5cgiff8lgK5uazuwmbNv+eYo86hprWsxmHp/+KHeWj525L0ajlt0eJc4h925FMznYoQprA/bh/o8RK3ewVChO2AXSh9DtFW0oAArdp
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(396003)(136003)(376002)(346002)(39850400004)(36840700001)(46966006)(5660300002)(83380400001)(70586007)(6666004)(70206006)(82310400003)(47076005)(6916009)(82740400003)(2616005)(36906005)(1076003)(54906003)(7636003)(356005)(7696005)(316002)(8936002)(8676002)(36756003)(4326008)(7416002)(2906002)(44832011)(107886003)(478600001)(26005)(186003)(426003)(9786002)(36860700001)(336012)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2021 11:32:22.3020
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d20cc9e5-bd5a-4c23-0165-08d909701fd2
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT032.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB2487
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The existing Xilinx INTC driver does not have mechanism to remove the
driver when it is being used as a module. For example, if the Xilinx
INTC IP is part of a removable fpga partition and a user intends to
replace the removable partition with a new one, the existing
implementation will not support the same.
The enhancement is done by adding a new remove API and making other
necessary changes.

Signed-off-by: Anirudha Sarangi <anirudha.sarangi@xilinx.com>
---
 drivers/irqchip/irq-xilinx-intc.c | 49 +++++++++++++++++++++++++++++--
 1 file changed, 47 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-xilinx-intc.c b/drivers/irqchip/irq-xilinx-intc.c
index 642733a6cbdf..2c5b76efabf6 100644
--- a/drivers/irqchip/irq-xilinx-intc.c
+++ b/drivers/irqchip/irq-xilinx-intc.c
@@ -39,6 +39,7 @@ struct xintc_irq_chip {
 	struct		irq_domain *root_domain;
 	u32		intr_mask;
 	u32		nr_irq;
+	int		irq;
 };
 
 static struct xintc_irq_chip *primary_intc;
@@ -234,6 +235,8 @@ static int xilinx_intc_of_init(struct device_node *intc,
 
 	if (parent) {
 		irq = irq_of_parse_and_map(intc, 0);
+		irqc->irq = irq;
+		intc->data = irqc;
 		if (irq) {
 			irq_set_chained_handler_and_data(irq,
 							 xil_intc_irq_handler,
@@ -257,5 +260,47 @@ static int xilinx_intc_of_init(struct device_node *intc,
 
 }
 
-IRQCHIP_DECLARE(xilinx_intc_xps, "xlnx,xps-intc-1.00.a", xilinx_intc_of_init);
-IRQCHIP_DECLARE(xilinx_intc_opb, "xlnx,opb-intc-1.00.c", xilinx_intc_of_init);
+static int xilinx_intc_of_remove(struct device_node *intc,
+				 struct device_node *parent)
+{
+	int irq;
+	struct xintc_irq_chip *irqc;
+
+	if (!parent)
+		return 0;
+
+	irqc = intc->data;
+	irq = irqc->irq;
+	irq_set_chained_handler_and_data(irq, NULL, NULL);
+	if (irqc->domain) {
+		irq_dispose_mapping(irq);
+		irq_domain_remove(irqc->domain);
+	}
+	/*
+	 * Disable all external interrupts until they are
+	 * explicity requested.
+	 */
+	xintc_write(irqc, IER, 0);
+	/* Acknowledge any pending interrupts just in case. */
+	xintc_write(irqc, IAR, 0xffffffff);
+	/* Turn off the Master Enable. */
+	xintc_write(irqc, MER, 0x0);
+
+	iounmap(irqc->base);
+	kfree(irqc);
+
+	return 0;
+}
+
+static struct irqc_init_remove_funps intc_funps = {
+		.irqchip_initp = xilinx_intc_of_init,
+		.irqchip_removep = xilinx_intc_of_remove,
+};
+
+IRQCHIP_PLATFORM_DRIVER_BEGIN(xilinx_intc_xps)
+IRQCHIP_MATCH("xlnx,xps-intc-1.00.a", &intc_funps)
+IRQCHIP_PLATFORM_DRIVER_END(xilinx_intc_xps)
+
+IRQCHIP_PLATFORM_DRIVER_BEGIN(xilinx_intc_opb)
+IRQCHIP_MATCH("xlnx,opb-intc-1.00.c", &intc_funps)
+IRQCHIP_PLATFORM_DRIVER_END(xilinx_intc_opb)
-- 
2.17.1

