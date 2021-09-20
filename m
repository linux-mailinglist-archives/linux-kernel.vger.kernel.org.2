Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10D2E411884
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 17:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238219AbhITPmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 11:42:53 -0400
Received: from mail-dm6nam12on2060.outbound.protection.outlook.com ([40.107.243.60]:54273
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237813AbhITPmw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 11:42:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QL6RC+grYs1i7PSQk4qU1KTkw0L6YWPMYE9AzVVljbnLt2nmYhgSHG5rzNWxJjMmjnuQILdS02siOOo5VexZrfYV7veUjkyn/tGB04V3mopuhIPK+mr9fD71ZGqb6ImK+GwFBAs892IEt4VMGh9xVAgUmYHEzkGhNp7lG2Axk7DoYrbF0fwjYL4a5+27sS9tN7Dw3v/DkEWYYI8vUVZ2M5ENJQapvxYIfNSR4dFJyXgQK3T/zH3KyDKWJCH/ADPfQkdaBQuiD6s0x8tN0iq1NPjA7s2+ylp4dpYxSQaI4/5JTisFYAFNGbmhBe+5WOCOY1EdFbciDE8qoRc2dlHGGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=SHstRfTBCx1wPWNgFygVixGDitPKwyXgQhfS0FDabPY=;
 b=noDGU1T8cZw74AZJV8zLitpgUmAWzr2A1SirGnbcM9WUBtNu26pT0V3opDGcwpzb0jfqd7IShYpCMjlUwhO+W//BlRDPImzg9gC6H+qxUodGj1zcXL6ZDqzmxz42ns5JzoQMjKM+0r0pLoqEnWPl+a/ummN8ySAHWiJMIvl8IyNhZfPqe3G060BnP7mULYOsYyBxyVCT5gX1OyLLDxkMwnm8J8OZ0zPnVdJJ1X4Kvupqk/892RgmkG7rC38wcp16R8KbcbnEswz0zWI/mtl185iIFc2zCmLeaa3dI0Zwkbs7HlAjEGjnpat7UNCDQjQsZ6eC0BCL1nLtbAKqIf/s2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SHstRfTBCx1wPWNgFygVixGDitPKwyXgQhfS0FDabPY=;
 b=Q45R3tkT4SIV7X3m9oI5Kfh7mF0ibRc7GNd5TFZh+8xFElbPOd4257U272fVnNTrTfquitMD1Qs+2G5WU+z8xcAzggDZydlkLJplUIPjHzuCEp1OaJTjh9zcZnQpRuNtbmRJ4q/oRJhZMo2rMSwsmiQGktX6QvxnxYODgijI4aI=
Received: from BN8PR04CA0008.namprd04.prod.outlook.com (2603:10b6:408:70::21)
 by BN8PR12MB3250.namprd12.prod.outlook.com (2603:10b6:408:99::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.17; Mon, 20 Sep
 2021 15:41:22 +0000
Received: from BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:70:cafe::9f) by BN8PR04CA0008.outlook.office365.com
 (2603:10b6:408:70::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Mon, 20 Sep 2021 15:41:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT019.mail.protection.outlook.com (10.13.176.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4523.14 via Frontend Transport; Mon, 20 Sep 2021 15:41:22 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 20 Sep
 2021 10:41:19 -0500
From:   Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com>
To:     <mathias.nyman@intel.com>, <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Nehal Bakulchandra Shah" <Nehal-Bakulchandra.shah@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Subject: [PATCH] usb: xhci: Enable runtime-pm by default on AMD Yellow Carp platform
Date:   Mon, 20 Sep 2021 21:11:00 +0530
Message-ID: <20210920154100.3195683-1-Nehal-Bakulchandra.shah@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b4d3fe53-c3bc-4086-60b5-08d97c4d18e0
X-MS-TrafficTypeDiagnostic: BN8PR12MB3250:
X-Microsoft-Antispam-PRVS: <BN8PR12MB3250DFA7D8C9EAC80F627786A0A09@BN8PR12MB3250.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rEPTe0MXQtJ2B47tTnzCdXpB8LkECTdDwTsWJ/+w01Qpe/WCDLR+7lr6tPT2Aa4ejIp1L1T5FEEsxslC96NFDvJ1sYEUDTpfPquPcSFQhnWGkE9GSEJjlKz1geyNqIS75LYySq8x8hY9ce9Wia2rYXMgbu720RYptbDlsftfhETgHlNpeBHh0xu8WZDKHFgbg0+FHBzr8Pvxbd3at2Yj/PrL2RFDqCI2XS+lkRioSXn+N3KJarmeNi+YlnuUiUtnwdbFhsbF7ULs6/2/7kvfY4VBLNKBYWVltc1siU1McsnLEUtoxa6Yf4DUfLw9WzdZUhlpwIyd58V245ScZqZM+5wp+3O9RockcagRifPps1ILDI9RxPEhgQHY5y+RYAEAfcKjN895cJDgSf+10L5W4IdFuWPL1AcICkq6nkE0fmOnFGUtOw0YIWwgnso4oXEbgFwvaxLWudyevLnliAInYc1SncTjCynOJUqxVo2NPnkAcUG2UY4BYBtinWUWh/dsTdm5IgSa2ypN1lPNAG4Bftzejq8e8ekWa5d21bzJCGB3e23TPMdsYoEH56ddlslQwyo5e4/GzrXy/ZY77O3qV/zifqLhceKxdHp0ZJQt9taFDQhvFk4JOxQKizhQOtV+lU4V028WXeDWexyU7lgfN5XRFe85rf5RSlXp04hUfsfdkE5LQfNJ41VEqfRABhBV2XvNKx3tA5dJjDNdoUzu+fa64fGOBXivb4vYSUcnACI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(396003)(39860400002)(36840700001)(46966006)(36860700001)(8936002)(186003)(16526019)(82310400003)(54906003)(82740400003)(26005)(2616005)(1076003)(70206006)(70586007)(7696005)(2906002)(86362001)(47076005)(5660300002)(8676002)(478600001)(316002)(4326008)(6666004)(36756003)(336012)(426003)(110136005)(81166007)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2021 15:41:22.0890
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4d3fe53-c3bc-4086-60b5-08d97c4d18e0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3250
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AMD's Yellow Carp platform supports runtime power management for
XHCI Controllers, so enable the same by default for all XHCI Controllers.

Signed-off-by: Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com>
Reviewed-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
---
 drivers/usb/host/xhci-pci.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index 2c9f25ca8edd..0e571d6af2ab 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -69,6 +69,12 @@
 #define PCI_DEVICE_ID_ASMEDIA_1142_XHCI			0x1242
 #define PCI_DEVICE_ID_ASMEDIA_2142_XHCI			0x2142
 #define PCI_DEVICE_ID_ASMEDIA_3242_XHCI			0x3242
+#define PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_1	0x161a
+#define PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_2	0x161b
+#define PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_3	0x161d
+#define PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_4	0x161e
+#define PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_5	0x15d6
+#define PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_6	0x15d7
 
 static const char hcd_name[] = "xhci_hcd";
 
@@ -313,6 +319,15 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 	     pdev->device == PCI_DEVICE_ID_AMD_PROMONTORYA_4))
 		xhci->quirks |= XHCI_NO_SOFT_RETRY;
 
+	if (pdev->vendor == PCI_VENDOR_ID_AMD &&
+	    (pdev->device == PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_1 ||
+	    pdev->device == PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_2 ||
+	    pdev->device == PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_3 ||
+	    pdev->device == PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_4 ||
+	    pdev->device == PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_5 ||
+	    pdev->device == PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_6))
+		xhci->quirks |= XHCI_DEFAULT_PM_RUNTIME_ALLOW;
+
 	if (xhci->quirks & XHCI_RESET_ON_RESUME)
 		xhci_dbg_trace(xhci, trace_xhci_dbg_quirks,
 				"QUIRK: Resetting on resume");
-- 
2.25.1

