Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29A2845D4C1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 07:24:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349045AbhKYG1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 01:27:34 -0500
Received: from mail-mw2nam10on2041.outbound.protection.outlook.com ([40.107.94.41]:45913
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1347445AbhKYGZd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 01:25:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SDXDB/25pFRz39J7zc79oIFKEZbGP7xDwbwt9qPkkZ/0haIZ4O5DfkjXwzXjSZ90kGs28oRT2aF65K/y18mkLnmHv2TNYMWv8Xe3z4m/Uz+LMn4ur7Y/GlpGdGmg52/ncsu08ZwCIyqO3gFv5b4sCFSBLTdvE0ZJvEUsB05jx4WmxGWZXxHSpDO34iZ3E1xRk6+Iclbhcy3Nlf3TejC8HW0b4Rf0lZR1+sEElIQg+DOJh+KwkXGdkdWSAkZATzucE6T1XN3SSBGekRKrKZckjj/44Q64WAqHgvmBOc0d3PqelMiODVM3TP8VvHEX/rEGHxUa5Cqs+U/nA1sS6HSflg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CiWY2u57YEUVQpzlBfyyb4fQ9nCtat+l/p5DUn0Hkbs=;
 b=A3Xhg6YbGUxUCf6SCbAAVV6Kqkiz0553xD2DL3srB7mJTWU4gUPIP1G4MCISLdcFA3XOkld213jB1NNcMdWI4AIN+07PWhQkXhUeMQE9jXMDOeaPG/EIKVpb7pdZvP9S4blRB5ElnrlcfXLdaYda3bHtbEn2DKrFZ/dO4fJ16HYGfALic1+VG6deUVYuMHVgONuB8/AZlqYhaEPX1uz/fHb/sdCv9k2BX8D4JnuS61BfeQWZuIIUnSHFCPsIThIOEaOXcdvlwGoGHkvrpxeVpjaBxOPK6mJBBnM7LbmCv1H+nmr1WFK2dOO/NeRFGKGSHWWGNVgmpNeehkV96S7wGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CiWY2u57YEUVQpzlBfyyb4fQ9nCtat+l/p5DUn0Hkbs=;
 b=GJhgFE6W4l4xYVh0txnz/3yPw814Sl0tcCZLru7eWoswm/8Ck5PkPM2NTPH3jLnqf7XtDq/AfDkyHpSUIKQoWlSlo828mYNdYIgf5uwSo+mOnhtzGEvInGXXXajPxM0gS+qivebGSU1ZwqF6Dm+KC0JTxVLQIOtsx7jl7Chb/RU=
Received: from DS7PR03CA0184.namprd03.prod.outlook.com (2603:10b6:5:3b6::9) by
 BYAPR12MB2615.namprd12.prod.outlook.com (2603:10b6:a03:61::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4713.24; Thu, 25 Nov 2021 06:22:16 +0000
Received: from DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b6:cafe::12) by DS7PR03CA0184.outlook.office365.com
 (2603:10b6:5:3b6::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20 via Frontend
 Transport; Thu, 25 Nov 2021 06:22:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT032.mail.protection.outlook.com (10.13.173.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.22 via Frontend Transport; Thu, 25 Nov 2021 06:22:15 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 25 Nov
 2021 00:22:14 -0600
Received: from chrome.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Thu, 25 Nov 2021 00:22:11 -0600
From:   Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
To:     <sboyd@kernel.org>, <rafael@kernel.org>,
        <linux-clk@vger.kernel.org>
CC:     <Vijendar.Mukunda@amd.com>, <Alexander.Deucher@amd.com>,
        <Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        <Mario.Limonciello@amd.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        Michael Turquette <mturquette@baylibre.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 6/7] drivers: x86: clk-fch: Add 48MHz fixed clk support on Renoir platform
Date:   Thu, 25 Nov 2021 11:50:35 +0530
Message-ID: <20211125062036.1185994-7-AjitKumar.Pandey@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211125062036.1185994-1-AjitKumar.Pandey@amd.com>
References: <20211125062036.1185994-1-AjitKumar.Pandey@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 36cdf583-401b-4dde-b3bc-08d9afdbed02
X-MS-TrafficTypeDiagnostic: BYAPR12MB2615:
X-Microsoft-Antispam-PRVS: <BYAPR12MB26150CA9C76B9CEB6D70F05482629@BYAPR12MB2615.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YsYdOw614VkfsBCkL0x5DUpt23CuUOC2HFWbmzXUYmpIL1rKjRgPaOH1U8C+4rzqZxCIT7an4a8llWG8+coriBz3/V/E+V4y83Ns6nnpx6WaiVLLIuQaBLsFUg+6td1AkwCDXHLaZnJDTVKZ8ik0nL9TeBfozH8b0Lxe/pbBxoqXU5FoRJovJiGQshYX4CSLt8MMEm41K6TrvIM0gzYJr9CHHxC520j9JaLra+lbuhrBiQVAOF4bG3f/LQN19rxqo8h5ObNp4TC57oMBqJGN9N9bW5OWKioF13GCyCZnAg65dcE7uUUuJ1mFcEN6/GaOfhyuoOtYmBcO/cKGuJP5R176o1hvqiNAbxAI+LGJpg+EFZzDsTch/VWAtE4P1LLjMJxUkKApv4zG9RFjWBRnBHLpjcA4fmbaFPpmH4ji9SzlKIpKLMGBUxBch+hFhJUM9sDlJ6oA9y5qH4vACnIYb5AtEX83PJG3v+p2dPdSSiPYNj9HkMMWM09AlURi9OHRHKBes1PlrUNVuqWxQRFrvJ2rbCRGfVYYPfV62/LR7CgC49yU6TOA8JWqW2H+1PXDkMYXIB0E/PLp+cJQmZ3PKD685Bxi7m1JHK9EjkBU3bBSUs3S07mzQM6QsW0iFRI7wzIHhryp39HlOQxrkI5fY+j/zTauHT6z6fZm5kRf8n35QRSOzcWMQKrdt/PgSeVt0nUl485O/CPLZ2mTypJP1Jg2SWYQ02kFpE2Us2lRJa8=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(426003)(70586007)(81166007)(70206006)(7696005)(2616005)(1076003)(82310400004)(336012)(4326008)(316002)(83380400001)(47076005)(54906003)(110136005)(186003)(4744005)(36756003)(26005)(86362001)(356005)(8676002)(508600001)(6666004)(5660300002)(2906002)(36860700001)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2021 06:22:15.7882
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36cdf583-401b-4dde-b3bc-08d9afdbed02
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2615
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add renoir SOC pci root port id into pci_device_id table to enable 48
MHz fixed fch clock support on renoir platforms.

Signed-off-by: Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
---
 drivers/clk/x86/clk-fch.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/x86/clk-fch.c b/drivers/clk/x86/clk-fch.c
index 0578297d8322..9683c0973e62 100644
--- a/drivers/clk/x86/clk-fch.c
+++ b/drivers/clk/x86/clk-fch.c
@@ -33,12 +33,14 @@
 
 /* List of supported CPU ids for fixed clk */
 #define AMD_CPU_ID_RV			0x15D0
+#define AMD_CPU_ID_RN			0x1630
 
 static const char * const clk_oscout1_parents[] = { "clk48MHz", "clk25MHz" };
 static struct clk_hw *hws[ST_MAX_CLKS];
 
 static const struct pci_device_id fch_pci_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, AMD_CPU_ID_RV) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, AMD_CPU_ID_RN) },
 	{ }
 };
 
-- 
2.25.1

