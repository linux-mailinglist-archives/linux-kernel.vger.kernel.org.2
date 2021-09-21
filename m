Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 074E341330B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 13:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232538AbhIUMBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 08:01:09 -0400
Received: from mail-dm6nam12on2042.outbound.protection.outlook.com ([40.107.243.42]:9409
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231778AbhIUMBI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 08:01:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AnJNsnBVjIdxx26YahZof2PDE2s2h98/eo6QEqjEzdG6Uxtu2VWpH/Oh2LThyx/mjKYKCwlHHX5bBpKk+gL5mi5k/2I9DPok20v40RYxoG1c/JziBvuw6nqVX+y+g8tq5jPK8JjKto6WNytWPFyYa4dN3iF05BZXpxoNJJ77dW8Rr8WmI0QqgEgDQReGqp1aOjjxAf7D9PGYto/OeyvewdsK9JmrqYimUeh8Ak2x0FnxMKrgCJcXvVHM+ANmI/qgYbI4IYo63o2exIqNpM9a6aWEdRCnkjVRiJMnhtXld4Lr9ZIWxNBDEXFlvzxmCiCb1IZ3W1hEvz/GO9MN61VG8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=SA6131eOa7+KuGTQu50pSPCrnEBKwElVbMFwPSX6Po8=;
 b=X3RF3T6ADlo9VGZl9AA1VxVchcmOS3Xi5OC8sR+OOT5IbTIfhhD7AWF+t/kbyDHH+Q5bvAOGHWeZieJ9MTlY41j2bYp4MCm0pxyEZ9a1xvIG8Wd3zw9lW9leJG9WdFMiBDtmzuBZJuyQIB8c+yYBOVHIC/TUjmB9qncG/JoxTk5YK/hFgl+eVs+jNkUF1SyMMMvIoUsZWfTsEhoDNZ4XhXw0IQZvl9BLGdQqsx4CBpZxTOSmYZUfKdNA6gabEn9PHgbheehCrzfCi0mBuDinbs6kiBC6oYjxWSsmVMp7YFpZB8ErhC9pwOc3jh46se4TeNrLVicIyYDDHVO/RAzx6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SA6131eOa7+KuGTQu50pSPCrnEBKwElVbMFwPSX6Po8=;
 b=qV7gvDzhZKkgogHkwpAz2N7TvPVq0SrcVCurvq5vHq0sCKX8/WJIfxJ2WAlxR68Ru5v2bfWoDw5tek3MWu5d0k5IG2xEwxzxQzWkiv8cgq1m39y5iRSq7zd2s6vtTmc5CzH6cLGxJtMehxXGF0UXQ31sXcSVGyISCOKOyDYt1Pg=
Received: from DS7PR03CA0218.namprd03.prod.outlook.com (2603:10b6:5:3ba::13)
 by BYAPR12MB2823.namprd12.prod.outlook.com (2603:10b6:a03:96::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Tue, 21 Sep
 2021 11:59:38 +0000
Received: from DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ba:cafe::d7) by DS7PR03CA0218.outlook.office365.com
 (2603:10b6:5:3ba::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Tue, 21 Sep 2021 11:59:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT066.mail.protection.outlook.com (10.13.173.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4523.14 via Frontend Transport; Tue, 21 Sep 2021 11:59:37 +0000
Received: from amd-Mandolin-PCO.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 21 Sep
 2021 06:59:35 -0500
From:   Sanket Goswami <Sanket.Goswami@amd.com>
To:     <Shyam-sundar.S-k@amd.com>, <hdegoede@redhat.com>,
        <mgross@linux.intel.com>
CC:     <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Sanket Goswami <Sanket.Goswami@amd.com>
Subject: [PATCH] platform/x86: amd-pmc: Send command to dump data after clearing OS_HINT
Date:   Tue, 21 Sep 2021 17:29:10 +0530
Message-ID: <20210921115910.19401-1-Sanket.Goswami@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 47235419-7550-4b03-c679-08d97cf7495b
X-MS-TrafficTypeDiagnostic: BYAPR12MB2823:
X-Microsoft-Antispam-PRVS: <BYAPR12MB282317A069BC610AD9AFA29A9CA19@BYAPR12MB2823.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YeiH4fFve+Kps0R0RKqykfi2LaQlMApm76TXE5j1waIwS91W1fkH2Xyj8eSvzcgsmzKEd3xPICHB0wUQNS5Yv3/fjxkiMCiV+mvk7TuypXZbgK31/Q/oSM2G5l+rviH+Mj90AR5qr9PBruJMrWdkpl68nlZzULt1emzk6RggFqWjd49tPAp/YpUxhoXVh6+hpMRiDedGI61HRQZsRqMD8jtqHCtevF3lAX7sx+t09EUkkNAGQvhitzx53TuPs9BsiDc9rjcPyMjYt/q7v4KgQu5bs8Lq6mmUSQt+mWRMFM6qCCfTBnXH6SlWrvlqik5aSJ7D/Lp1bpj2dU1ipoMoqtyDbPPy04BfQQCSXL1E8Afwit+3A6c53ALo3KnPT7EO6Tx1H4cqlaqfng7RuygllMN7+9QiIisgcPTXG2qkIi3z3gare7Xb3l7FAP+TRQkCvGMPyELWjCxrbbMwQzAs/NLBxhVBW/UbbKcZtOZSrrk1RBaOI1Y1ZVOgsTM3X0tYB6yrP43ZKaRKYgqQ56NtTSouwBnaHTzhBaUGtDskUg4jvBBcA99ghGFf1XnjwS8RzmitvnJFCqwKqKsQMj51jcIv+8JYS/bouBsCYYsmBniaGCvuew3V+QHa6BH6ciWQxwyOlonSuGgAbzyv10dIVCykmUAoXJhOI1x5q7ve2FOlod2luVsmnQF5JbViK8vFhhYIG6G/3ZqJwN7d/fsYm48ebeUyrL0tOQwnF5fe0WI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(8936002)(110136005)(36860700001)(86362001)(47076005)(82310400003)(54906003)(186003)(7696005)(4326008)(5660300002)(316002)(6666004)(26005)(70206006)(508600001)(16526019)(36756003)(336012)(70586007)(81166007)(2616005)(8676002)(426003)(83380400001)(2906002)(356005)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 11:59:37.8363
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47235419-7550-4b03-c679-08d97cf7495b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2823
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was reported that the resume stats received from the firmware are
always zero. This happens because the SMU expects the driver to send the
command to dump the log data after clearing the OS_HINT.

Adjust the order of the commands sent to SMU.

Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Signed-off-by: Sanket Goswami <Sanket.Goswami@amd.com>
---
 drivers/platform/x86/amd-pmc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/amd-pmc.c b/drivers/platform/x86/amd-pmc.c
index 91c1f1c6c929..bc7c4498067b 100644
--- a/drivers/platform/x86/amd-pmc.c
+++ b/drivers/platform/x86/amd-pmc.c
@@ -436,14 +436,14 @@ static int __maybe_unused amd_pmc_resume(struct device *dev)
 	int rc;
 	u8 msg;
 
-	/* Let SMU know that we are looking for stats */
-	amd_pmc_send_cmd(pdev, 0, NULL, SMU_MSG_LOG_DUMP_DATA, 0);
-
 	msg = amd_pmc_get_os_hint(pdev);
 	rc = amd_pmc_send_cmd(pdev, 0, NULL, msg, 0);
 	if (rc)
 		dev_err(pdev->dev, "resume failed\n");
 
+	/* Let SMU know that we are looking for stats */
+	amd_pmc_send_cmd(pdev, 0, NULL, SMU_MSG_LOG_DUMP_DATA, 0);
+
 	/* Dump the IdleMask to see the blockers */
 	amd_pmc_idlemask_read(pdev, dev, NULL);
 
-- 
2.25.1

