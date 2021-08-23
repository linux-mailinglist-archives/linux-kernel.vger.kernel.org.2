Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48FCD3F509C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 20:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbhHWSqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 14:46:10 -0400
Received: from mail-mw2nam10on2069.outbound.protection.outlook.com ([40.107.94.69]:14464
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231430AbhHWSqI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 14:46:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c8tPTCEMkE0WNxPZ+yUMzqUw4v4Nh6/BY43Ck6Mbbz0dMzsWcL2ORhJAOcC/KNEmG5JXSRdnqi2Zew3hmtbYM9O4whpmfRuNr8IZi8cKYH/KPu5aM+Lo7uqd04ExZzEIzfgf6F7nRXK6jjd7X+vsFnWl+h0zW2k3t59XPeY7pvU307LrzZb9WW/H5uJO8IjWaZDZjfP0nbObN3LqAQlWN4vidDREXr6a93EpR7bzZidj3SaKAUjOopB/WsJR0RY2hKEVFeei74FfUjw7Wt1mwF8T45aNVJd7n2DVbr6sNSq89D8Q6uL2l6ZM6xzfwaA5iw94xv6SqcwNBrPylE+Q4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mZ/mF1hjvf+SjTnHCPRot23FeNQ8KkokLj1VHt3Y5Zw=;
 b=SD1bAnqR473Ijm8NSxAMW0BNR+SD5hXoEJbUGVax2Hsi8LkksntEfhpf+sChaRxsoySiaoVHp2F2y2vkYIQXCXcaxxVov/bbg+IpP/uLwQW3sprWgI5GVKKZb23+dgzwn1CTgHOjO3aPAOj8C3vN6WQCFkUVT6T1NfezcZSe67Umvtq5cZyErG8HVQdzUsD3rov08p6oVED4NcPtTKEsUPqVxrLnxpBA7Vjuu1BFIji3Y1+v8Pdzn2dgpObIkgukjTLM5AAe7SxO45zshpjLJX0T+dQmZkRp7DhEdqAD/FiVLMm4rle/AMHgGLEP9hTPkW4MqUk4ow/QLAeiPV16eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mZ/mF1hjvf+SjTnHCPRot23FeNQ8KkokLj1VHt3Y5Zw=;
 b=RkwTtUXkKTsDBeU4jNcYEChbOx9WA2KXp9A3NdD/S3DXDqTD6yPOCf6BGYSmPS44rS1o3Uy+c/Omt/9tSIrok6l4SnIg6PUnBokYGz9PqbwKJUiMun8qqT/t3NukDYwgOkpb9SciE/cF/w5T9ImMLmzTyO7yTMEWCrt6zQyb8ac=
Received: from BN9PR03CA0810.namprd03.prod.outlook.com (2603:10b6:408:13f::35)
 by MW3PR12MB4393.namprd12.prod.outlook.com (2603:10b6:303:2c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Mon, 23 Aug
 2021 18:45:23 +0000
Received: from BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13f:cafe::e1) by BN9PR03CA0810.outlook.office365.com
 (2603:10b6:408:13f::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.18 via Frontend
 Transport; Mon, 23 Aug 2021 18:45:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT045.mail.protection.outlook.com (10.13.177.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4436.19 via Frontend Transport; Mon, 23 Aug 2021 18:45:23 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Mon, 23 Aug
 2021 13:45:21 -0500
From:   Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kun.liu2@amd.com>, <alexander.deucher@amd.com>,
        Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com>
Subject: [PATCH 1/2] usb: dwc3: pci: add support for AMD's newer generation platform.
Date:   Tue, 24 Aug 2021 00:14:48 +0530
Message-ID: <20210823184449.2796184-2-Nehal-Bakulchandra.shah@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210823184449.2796184-1-Nehal-Bakulchandra.shah@amd.com>
References: <20210823184449.2796184-1-Nehal-Bakulchandra.shah@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7c4369a4-afaf-4b8d-887c-08d966662a94
X-MS-TrafficTypeDiagnostic: MW3PR12MB4393:
X-Microsoft-Antispam-PRVS: <MW3PR12MB43934F30EFF5830D8241127FA0C49@MW3PR12MB4393.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:369;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lWeWm2Q50owakh2+f1jZQCk27jJPkugMxg4GJoocM5fuXxlu4s7DkIzSv/8UWJHl7pg5v7uIbN3XVnB6AablctTzSiJmGI1bE5y4h7q8QgBb3mLWMQnmDwG+RV/W22yLzSIyI9Blsr31rIHgI6YvjE7WjedWMrV4+Pdpfv2WUm5yag3VlP0ub5AvsHi82xna28/ORDtTnMYlxTfOhQMsxzh/0WFzt7K2mlZWsuCqK9/1PMCiYSuReR3FSuvT8qrmMt++vVeM4iggbCv+SnVTpaA1gNlnJzrgqnwubB6xlxxx2ATGqirlZjL/yLqpU6hNt9V8A3VuzMGUxJKkz2SPPpSKeTsaIxKVutQu27a50sDmVjUnY+VQoGpm1FhY4j4v0DW8MbUi8F/X4G+8EFRvvArUwnBozftIR6LX7PLa3wZXKuDOTcAtaP/NvQ/UL8xAX2vQl+GMgjhDspDBeVQ2DedwBf4eVs519/HQhXnEGuAsVXmj7qpZhTkqZNXgWSRnWsymigl9lw6XQnnNwRWqr+NxaX1R+1v7Kdb6JupRtJVsVBZd5OZ6J5CEmSbnZSOKDn26X5wCumrjMVWQDjupXsSIEm8/TtKmA2szOiwYiE+OTxoVF7zatVXmznjhofjVqmR8LTa5DOqxCmR99hx+27vT0bW8sLqkYHjLtQCx6PJArZp0Q1Ekp7KCZ3izdP0obA230eMamcDJ30+/Q8LpnqnHPGiijV8iyBWvABcECdDKWgDytRDPxA5/MaoX1cXbhIWtcPGLOvoI/HEDmBW/QA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(376002)(136003)(396003)(39860400002)(346002)(46966006)(36840700001)(356005)(5660300002)(47076005)(82740400003)(81166007)(70206006)(2906002)(34020700004)(1076003)(86362001)(316002)(6666004)(82310400003)(36860700001)(70586007)(36756003)(16526019)(8676002)(4326008)(26005)(8936002)(186003)(7696005)(426003)(336012)(2616005)(478600001)(110136005)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2021 18:45:23.6290
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c4369a4-afaf-4b8d-887c-08d966662a94
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4393
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AMD's latest platforms has DWC3 controller. Add the PCI ID and
properties for the same.

Signed-off-by: Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com>
---
 drivers/usb/dwc3/dwc3-pci.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/usb/dwc3/dwc3-pci.c b/drivers/usb/dwc3/dwc3-pci.c
index 2b37bdd39a74..7ff8fc8f79a9 100644
--- a/drivers/usb/dwc3/dwc3-pci.c
+++ b/drivers/usb/dwc3/dwc3-pci.c
@@ -44,6 +44,7 @@
 #define PCI_DEVICE_ID_INTEL_ADLM		0x54ee
 #define PCI_DEVICE_ID_INTEL_ADLS		0x7ae1
 #define PCI_DEVICE_ID_INTEL_TGL			0x9a15
+#define PCI_DEVICE_ID_AMD_MR			0x163a
 
 #define PCI_INTEL_BXT_DSM_GUID		"732b85d5-b7a7-4a1b-9ba0-4bbd00ffd511"
 #define PCI_INTEL_BXT_FUNC_PMU_PWR	4
@@ -148,6 +149,14 @@ static const struct property_entry dwc3_pci_amd_properties[] = {
 	{}
 };
 
+static const struct property_entry dwc3_pci_mr_properties[] = {
+	PROPERTY_ENTRY_STRING("dr_mode", "otg"),
+	PROPERTY_ENTRY_BOOL("usb-role-switch"),
+	PROPERTY_ENTRY_STRING("role-switch-default-mode", "host"),
+	PROPERTY_ENTRY_BOOL("linux,sysdev_is_parent"),
+	{}
+};
+
 static const struct software_node dwc3_pci_intel_swnode = {
 	.properties = dwc3_pci_intel_properties,
 };
@@ -160,6 +169,10 @@ static const struct software_node dwc3_pci_amd_swnode = {
 	.properties = dwc3_pci_amd_properties,
 };
 
+static const struct software_node dwc3_pci_amd_mr_swnode = {
+	.properties = dwc3_pci_mr_properties,
+};
+
 static int dwc3_pci_quirks(struct dwc3_pci *dwc)
 {
 	struct pci_dev			*pdev = dwc->pci;
@@ -401,6 +414,10 @@ static const struct pci_device_id dwc3_pci_id_table[] = {
 
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_NL_USB),
 	  (kernel_ulong_t) &dwc3_pci_amd_swnode, },
+
+	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_MR),
+	  (kernel_ulong_t)&dwc3_pci_amd_mr_swnode, },
+
 	{  }	/* Terminating Entry */
 };
 MODULE_DEVICE_TABLE(pci, dwc3_pci_id_table);
-- 
2.25.1

