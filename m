Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D12DA435DFC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 11:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbhJUJcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 05:32:23 -0400
Received: from mail-bn8nam12on2061.outbound.protection.outlook.com ([40.107.237.61]:41120
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231334AbhJUJcW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 05:32:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XEW2u14qNkSzSuPImHGOpSi+mPQQZV+OE9pNKXTH40Aor+vugS3BxUhKidRaMB10L9quC2cmBjQbG0bTgvpdCp2rVb2Ig1FjUpt8NAy6AeuF2q8x3vnE1WdxbmIUBrD82EyXXqxz1Z9su1d2ao9UV37xZWbf2kLsj9jF/y3jVrkBRs1kXaJRd/KcPqJ+bMZDQP6hYHeZqBQ6mXJwJspkjh2vTRaXxXLvCGVbBJXvCaYG6LpM1S1EboCqm2WqSjK8n8smVWvGug5ry133KmjFzp/DybKRfKKRu92TRy5RWyJGYgdGaAUIFmhCXdYir9UdgfdnOLzq66xf5S0o6aX1+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A0hEdDOFAY2kfKrWw8s7uMEzkzYqkJfyvJLPUJ+gbCw=;
 b=bcXT9wq4Zv6cdG4eeug7uNQsWmI4b1tvtYqBUyfDvCYsIYDSqK4hZM82nuOMACG0F5Xlk4NR2v9t0h8za2ZSq0TSJ1Aa2fn5zhhq0Ek5xaC7HX8kFEQ2gvYgLbpYiBKXfWIkD0kSHgE8Jhepcy/jOSIg3EN3sURnJXdHQkm7SzynTW7gmgWWtZkKTFUHjnJI8NzJkaERZf7Ida6J+ZoOHZoluZmz+TPfhHAjC6xkYK/0lfk4kJ6iJK0O5+jtxwCkv1sCidDbeSvtjObHupO5p2jNaLYLEAcFg+x4t0lUl63svsy05O2cqrjozC8gpNWBkRK6sN/pxYygcbUM9JXGuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A0hEdDOFAY2kfKrWw8s7uMEzkzYqkJfyvJLPUJ+gbCw=;
 b=V1IIvEDfw9NWeiuIYDjMHFl5Xo1IrYIlszk9KBXl1z3qdMBZ8TATwvEenIZwsa0+jXuF7RVaOAXaae1e9BVnmat3x8XA8IJwwf2DHtmrmUZDq0rVc7zNVJpmw7nfk1RbYtEXYpMDX5mAln/NYm3Zp7cF5gSgzhVM2lfkn0Z0fBE=
Received: from BN6PR12CA0027.namprd12.prod.outlook.com (2603:10b6:405:70::13)
 by BYAPR12MB3512.namprd12.prod.outlook.com (2603:10b6:a03:134::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Thu, 21 Oct
 2021 09:30:03 +0000
Received: from BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:70:cafe::a1) by BN6PR12CA0027.outlook.office365.com
 (2603:10b6:405:70::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15 via Frontend
 Transport; Thu, 21 Oct 2021 09:30:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT006.mail.protection.outlook.com (10.13.177.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Thu, 21 Oct 2021 09:30:03 +0000
Received: from amd-Mandolin-PCO.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 21 Oct
 2021 04:30:01 -0500
From:   Sanket Goswami <Sanket.Goswami@amd.com>
To:     <Shyam-sundar.S-k@amd.com>, <hdegoede@redhat.com>,
        <mgross@linux.intel.com>
CC:     <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Sanket Goswami <Sanket.Goswami@amd.com>
Subject: [PATCH v2 1/2] platform/x86: amd-pmc: Store the pci_dev instance inside struct amd_pmc_dev
Date:   Thu, 21 Oct 2021 14:59:38 +0530
Message-ID: <20211021092938.196933-1-Sanket.Goswami@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 25a08784-34d4-434a-5939-08d994755c86
X-MS-TrafficTypeDiagnostic: BYAPR12MB3512:
X-Microsoft-Antispam-PRVS: <BYAPR12MB3512831C63A5D9DAFDD9073B9CBF9@BYAPR12MB3512.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:98;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ICXSfV9uoY847VPwZ+virrKDganqOTbhugvjJqhnsDh29bAF49WJDaNLqLCFMgQN4SOr4mmA7kzMMG+UOY6mEXU3B8nLsP9C2CT+Q7lhIUeD+cYIijQNhV3khCex81XoCgeBRANw+E4XmIdgescN1vjXhZfc28Ujehrds4H1ymNNt0+mXWvKZ04jmwi0Ub0SM0363fzL6x5XwZmplcwiWXhM+vNDFUisZsJd0vl0tvP+0NTCR9ftwhhLKaR7iZuIdYSmd2cpugnG+6MeMTuqMDc5BeWUJG0o0zXp0zI3AIRFb+ZAZuH2ICmqAqfTsSc2xTQQjTF+cSWfyR755CuBaM4BTHeE/O+6QYC7by7uO+KmpDQQPQzZ/n1U/CGheqsSoqVcqm3jYGQa0aU7yqNzjwn+zq1UF8k+6P/zv7mKikpJ1N6pZUy0alGsFyQIggtraOi9/VNNNH1DjlBy4v3gPnbsFstikYjc5K0VaVw0mWAbWuUMUfzv36WrDOf8Vx+uH9e8xFRRnjL8bV2eYj8BZJouAEDgVrzprhpysDZIEmtswIFo9g3WeC0c4vuo36zNZK9Z3kOyI1DTsDK861FTlSf+QpCs8YO4Q2tlFKHpxqUSRlT9qtmpheHhWQyessoWa092XQqeosjMnLy9oImhkD6K1yEc97Y5n40tbYmIPSHNmgB31Gw1IVnW0RD/cVWwqj5ZNMqPymJOtZLgIdfsMYD+uazX6cvzVOedAX+Nepc=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(5660300002)(54906003)(2906002)(82310400003)(110136005)(86362001)(4326008)(81166007)(70206006)(6666004)(8676002)(2616005)(7696005)(70586007)(508600001)(26005)(316002)(36860700001)(83380400001)(426003)(186003)(336012)(1076003)(47076005)(36756003)(8936002)(356005)(16526019)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 09:30:03.3609
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25a08784-34d4-434a-5939-08d994755c86
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3512
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Store the root port information in amd_pmc_probe() so that the
information can be used across multiple routines.

Signed-off-by: Sanket Goswami <Sanket.Goswami@amd.com>
---
Changes in v2:
- Store the rdev info in amd_pmc_probe() as suggested by Hans.

 drivers/platform/x86/amd-pmc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/amd-pmc.c b/drivers/platform/x86/amd-pmc.c
index 55f14bdfdbfd..502f37eaba1f 100644
--- a/drivers/platform/x86/amd-pmc.c
+++ b/drivers/platform/x86/amd-pmc.c
@@ -119,6 +119,7 @@ struct amd_pmc_dev {
 	u16 minor;
 	u16 rev;
 	struct device *dev;
+	struct pci_dev *rdev;
 	struct mutex lock; /* generic mutex lock */
 #if IS_ENABLED(CONFIG_DEBUG_FS)
 	struct dentry *dbgfs_dir;
@@ -482,6 +483,7 @@ static int amd_pmc_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
+	dev->rdev = rdev;
 	dev->cpu_id = rdev->device;
 	err = pci_write_config_dword(rdev, AMD_PMC_SMU_INDEX_ADDRESS, AMD_PMC_BASE_ADDR_LO);
 	if (err) {
@@ -512,7 +514,6 @@ static int amd_pmc_probe(struct platform_device *pdev)
 	}
 
 	base_addr_hi = val & AMD_PMC_BASE_ADDR_LO_MASK;
-	pci_dev_put(dev->rdev);
 	base_addr = ((u64)base_addr_hi << 32 | base_addr_lo);
 
 	dev->regbase = devm_ioremap(dev->dev, base_addr + AMD_PMC_BASE_ADDR_OFFSET,
@@ -546,6 +547,7 @@ static int amd_pmc_remove(struct platform_device *pdev)
 	struct amd_pmc_dev *dev = platform_get_drvdata(pdev);
 
 	amd_pmc_dbgfs_unregister(dev);
+	pci_dev_put(dev->rdev);
 	mutex_destroy(&dev->lock);
 	return 0;
 }
-- 
2.25.1

