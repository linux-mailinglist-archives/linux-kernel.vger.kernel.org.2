Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF0A3F69C9
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 21:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234659AbhHXT0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 15:26:20 -0400
Received: from mail-bn1nam07on2078.outbound.protection.outlook.com ([40.107.212.78]:42819
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234424AbhHXTYr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 15:24:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X5pPvuI/iYg+Ehec3QiXzZ10gCnpiZ7bQrLF3POVBPoCeWfv5y/pRb0wY6QPHzTYMbZMRdmoaFNd627IxQWOx1pyucsr/yPYsu4COSzO/EfVPSEZDpiep0HpUXoA5pZ4nXE6f1oV816UvH9iyD5HumzyHFiEtGRgJBHTDqbo4bLu1u3JK6p8KXs83oIbVfhnuBhuEOoieehAuDntYXgPunPQ1thefPHfxphYXbkNa/aBcDpWo94W9g6aOmu/sVfxES8zx8OovnwxBqH1b0mN/gA0ugGBhZrDR97Pm0NgbdoBmiMnDmqMIRZ16bVrer7o1Nzpj8MjT7xK5nrKpvxCpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HacWl7J+2xZt9WOxKhHB7yJsKR0t2hzWKVFC5VIt2NI=;
 b=AL6LmmIHL/6ObZqYuHvQh8RtUj/T2PQ7nRjfflINGrqfSIyfhXXdL7+o7hZ/uw2BIMvivdizBG/1vjPlnqLIlvNHIWo0aunTFVAQMBfdQh5JZdKuBeiqQm1ATeJBZz4z3uERCBEwQ+nquC3m6WdHGy74ngSP1ZPxsAKHNfEVmkKsu0eGvk/ReG/7hKActCZNhA63Fw76p5tGCXJ/d4JJlhgRKUnlh+u+Z+2GebPLzsx1icuw/34OhLpS7KC+t8iz/19sqYYLqFIfJn5fShawFhJoe556IFu7L/iWAJ+4rO6OHsKLJWwWc/Elwetl4839U5jKl1oWEa5Kvjag9WyzLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HacWl7J+2xZt9WOxKhHB7yJsKR0t2hzWKVFC5VIt2NI=;
 b=4ClUvITayzA3jR6vB9/W6aKFOe/iUaIqqQfEXy58cbDsJCccm/z25Tp83NbJQFU2EGfiWF4N8/qS48Zz9jDkq8CTLS9mlwhCaaVcIsKXB1hqB+7RVLJunXGZbmjOH3EttZlZ6kJT2M1fe59ZAF2+Ocq7heVxk0rvXGctG7vw2cQ=
Received: from BN9PR03CA0590.namprd03.prod.outlook.com (2603:10b6:408:10d::25)
 by BYAPR12MB3622.namprd12.prod.outlook.com (2603:10b6:a03:d9::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.23; Tue, 24 Aug
 2021 19:24:00 +0000
Received: from BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10d:cafe::ce) by BN9PR03CA0590.outlook.office365.com
 (2603:10b6:408:10d::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17 via Frontend
 Transport; Tue, 24 Aug 2021 19:24:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT028.mail.protection.outlook.com (10.13.176.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4436.19 via Frontend Transport; Tue, 24 Aug 2021 19:23:59 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Tue, 24 Aug
 2021 14:23:57 -0500
From:   Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kun.liu2@amd.com>, <alexander.deucher@amd.com>,
        Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com>
Subject: [RESEND PATCH 2/2] usb: dwc3: pci add property to allow user space role switch
Date:   Wed, 25 Aug 2021 00:53:37 +0530
Message-ID: <20210824192337.3100288-1-Nehal-Bakulchandra.shah@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f12a8a43-6dfb-4fe0-a163-08d96734b9a3
X-MS-TrafficTypeDiagnostic: BYAPR12MB3622:
X-Microsoft-Antispam-PRVS: <BYAPR12MB36223A2BEA47ADA3A60CB73DA0C59@BYAPR12MB3622.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vd8RQopm0RiPneJ/zHjLkllbNwqiyww/JsR5okrQbibRI9bmv5tVBBIICadVte5cXtMaW5pNIrTJT8GyFBXufjR3MR3uEDqpJ2rZ/reFmd3IcEkEaE+8DMPivhgaSojOeEeZ+MT0TtmNwTpn6mwemT6CL/hCcCuvi/Zyv5Xc1F3900l3OjcHkHQAGVv3LgrF7AcaOpPcEaWMZfx4NSI8NDvsRpkCqJTsxI2Bfuwks2J/5Jr57Xp3cyFN6HmMjdv8ZYf7buG6CauaVG14jWIULr2eociziuQXoVeQBez96dcLDRCE6gco9kDsrQTt5A5DZT8ltfdBPd2UMfMIVANw6QS/Jz3J3qvb4PrUbgucdGf1kXrGHqTn4yHtRgdolQJZS26r15SHRm4b2rYvGh7LBlmCXyYOGs8omkfz8ARm8buvY7WOvJtqXttS6w07KgJlPH2GMJvf5RZrK/mp3LfPv2cGhoTkFWXHDeZKlfCbH3Ik1utyikI717YZjcAw5xrBMx5t5dAzmKCeaHYId4IZ7NhRLoYLg9OeXS3VFxSjQgytUoF34sHCBQEZexIIqYUqgg7ZbUuDnazfGuXap5O7aXZuC7r9dnlEN1uqbVUvj30cGqooOG57dp+NS8rDGuHLa+U1JKDqf/dhlCGuflHHptxI/DYCBjsDuQSUapw7DFVdQxYBO8QYdXJuiMSt/hLco+DOQrJU6je+CMZvHBJ1X8wLUJB4dJ0VzUh4hvhu7H0=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(136003)(39860400002)(376002)(396003)(346002)(46966006)(36840700001)(36860700001)(82310400003)(70206006)(70586007)(426003)(82740400003)(2906002)(5660300002)(316002)(1076003)(6666004)(81166007)(86362001)(54906003)(356005)(4326008)(336012)(7696005)(8936002)(47076005)(26005)(478600001)(8676002)(16526019)(186003)(36756003)(110136005)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2021 19:23:59.9675
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f12a8a43-6dfb-4fe0-a163-08d96734b9a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3622
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For AMD platform there is a requirement to enable user space role
switch from host to device and device to host as customer platform is not
completely capable of OTG i.e. with type C controller it does not have PD
to support role switching. Hence, based ACPI/EC interrupt role switch is
triggered by the usemode script running in background.

Signed-off-by: Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com>
---
 drivers/usb/dwc3/drd.c      | 2 ++
 drivers/usb/dwc3/dwc3-pci.c | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/usb/dwc3/drd.c b/drivers/usb/dwc3/drd.c
index 8fcbac10510c..6d579780ffcc 100644
--- a/drivers/usb/dwc3/drd.c
+++ b/drivers/usb/dwc3/drd.c
@@ -555,6 +555,8 @@ static int dwc3_setup_role_switch(struct dwc3 *dwc)
 		mode = DWC3_GCTL_PRTCAP_DEVICE;
 	}
 
+	if (device_property_read_bool(dwc->dev, "allow-userspace-role-switch"))
+		dwc3_role_switch.allow_userspace_control = true;
 	dwc3_role_switch.fwnode = dev_fwnode(dwc->dev);
 	dwc3_role_switch.set = dwc3_usb_role_switch_set;
 	dwc3_role_switch.get = dwc3_usb_role_switch_get;
diff --git a/drivers/usb/dwc3/dwc3-pci.c b/drivers/usb/dwc3/dwc3-pci.c
index 7ff8fc8f79a9..c1412a6e85b6 100644
--- a/drivers/usb/dwc3/dwc3-pci.c
+++ b/drivers/usb/dwc3/dwc3-pci.c
@@ -153,6 +153,7 @@ static const struct property_entry dwc3_pci_mr_properties[] = {
 	PROPERTY_ENTRY_STRING("dr_mode", "otg"),
 	PROPERTY_ENTRY_BOOL("usb-role-switch"),
 	PROPERTY_ENTRY_STRING("role-switch-default-mode", "host"),
+	PROPERTY_ENTRY_BOOL("allow-userspace-role-switch"),
 	PROPERTY_ENTRY_BOOL("linux,sysdev_is_parent"),
 	{}
 };
-- 
2.25.1

