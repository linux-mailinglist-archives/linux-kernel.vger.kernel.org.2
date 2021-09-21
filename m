Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15260413313
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 14:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232602AbhIUMCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 08:02:10 -0400
Received: from mail-bn7nam10on2080.outbound.protection.outlook.com ([40.107.92.80]:9312
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232605AbhIUMCJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 08:02:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZYayl8bQlYhYPkp8nw/Ilk6yfd8M9hqSbdi0P59oFxwJk5Fi2ZxETKvxIquuQrC8jnVf0pf87DufxpiOPSjr+v07tHaquUjj+b6DgNGNnP6PF0DEsaorY5PtF6T0ykvKejF0c9X3GLp8yOhUFCmHYYHN3XJLvOYf8klr4xf4GRnHiVhdQBGuLhcxuNZf4cnX3OkR9MxITd9svIr8GaGmsbx78RJnnlTCwlnuhV5wBrvNP+13qWCVuw8fW6QsIWfuNi1cBplAm1pHDLyLthz+kURyCAyAGkeR0BQKQHXPbzfgvcqdlm31H0toL3iyfBGZyOobYSugVs/KNxFYXPTUQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=1EuNq3J8lrxWVK3sIOVV1dsr621AFiRt1dGmExkl4KY=;
 b=jdrWLcpZeWNeSHYPMHoss42ytjYtp9JXQ2ywgfFOJC1c/Kxc8ubAXb2zInLzwrWB7vPONckdB4SVAyoIOf0kuVvwCE7P5bsaV5N+tqOQ9INW9JqTU4jS9iU4zukNX/eRpQivaTUK0E4mkHUyewlsypDXbXfR2V7DGVphkUN3KLF8/j3P6NZfBdeciKUYaxyOfboir+T6ohitrS+y0AOrTT079fxALgUUoqyPdRzBkEgh08AOzLsuuuFslOP/FeHIzlMkbFl2cztMxNk/GiPIkbRmW+gn1BWIzmb6AVzTm1am3szTVvV6L0XzDxYZDXIRUkCSU/1oLaTYFgtH3ccEZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1EuNq3J8lrxWVK3sIOVV1dsr621AFiRt1dGmExkl4KY=;
 b=hxb1nsGgb8JnQn/ops2t6u3GcRRClij/BzzmO9P6eL5iVg1hYgN8iTvx9kpk2FsXXF2lkNbU82pDTMoqpbRt8Kgi88HwJ7nwpzYac0GFTlL+ar2Yy3SKQ/CEJSFdwSgOiubCf+QyModvink4gjlSQGoJEx1VpjOL+Iik/WqNk0M=
Received: from DM6PR18CA0002.namprd18.prod.outlook.com (2603:10b6:5:15b::15)
 by DM4PR12MB5102.namprd12.prod.outlook.com (2603:10b6:5:391::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Tue, 21 Sep
 2021 12:00:39 +0000
Received: from DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:15b:cafe::cb) by DM6PR18CA0002.outlook.office365.com
 (2603:10b6:5:15b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend
 Transport; Tue, 21 Sep 2021 12:00:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT050.mail.protection.outlook.com (10.13.173.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4523.14 via Frontend Transport; Tue, 21 Sep 2021 12:00:39 +0000
Received: from amd-Mandolin-PCO.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 21 Sep
 2021 07:00:36 -0500
From:   Sanket Goswami <Sanket.Goswami@amd.com>
To:     <Shyam-sundar.S-k@amd.com>, <hdegoede@redhat.com>,
        <mgross@linux.intel.com>
CC:     <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Sanket Goswami <Sanket.Goswami@amd.com>
Subject: [PATCH] platform/x86: amd-pmc: Add a message to print resume time info
Date:   Tue, 21 Sep 2021 17:30:20 +0530
Message-ID: <20210921120020.19454-1-Sanket.Goswami@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c54225f-7453-4a57-89fc-08d97cf76dec
X-MS-TrafficTypeDiagnostic: DM4PR12MB5102:
X-Microsoft-Antispam-PRVS: <DM4PR12MB5102D36FB5CA683AEC0853FA9CA19@DM4PR12MB5102.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:22;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sJlZ1FaHb+pz89lwL+iWJIh2ILSoD9Wk0tL1fUv2/AjdxuhGzuJZGwTHQiLBSvU1IiGZYE9RCwKt9MCA7qqDJhgN4lQnx19rC1NhL1HeACxiMCAYRhHjvi74ILxKKn0EXLQSF2+yvEQGu6vKSNU434YuAcs49Jq/816ktlzaUzehGlqVmE77URRF2+cEJ4jRfS7Ptxb82TroYU3voLWE0MYbo9vNZffwzP+nqg8q2483ILK1evxyzfRjYkqe8R8KLqy11WxqU5M3LqesWZE/RvA4J7CJYeOXrgnfbJ/ph9eqNBhNNN885BVz96LcCM2W8klJP5Kk18Bp/vAWmXVTSl47hlNfm8zwTSIJtuNQ9SQsZdXDxvdkReM57gniw7QZEPiAGKYq0Z03sflTd+ihv2+aaQZyEeqFBfDdBT3RWH8EfM3aNa6CaCKoKqzx29mYkQ1iXvp2dxfCvL57conr+bqSivW27DKZw2pzbPLWEa2Iwva7mt6xLcOnnoC3SRdKs2bEE9UxrvBhqlfmyA8SxzLwOBVKsEpZ1IzzlPZ+GxMaqmVfkSUFYiiZr0F0TCa7xrG66XcSAL4rNXPXcx434yyewuwSrm7fmFEtww4trVHaMN1XO7e07Cf8JDQyU4TY4WrfcszwtHyca18y8PNERjz9ZoVTJzKY3YZ3XZk7nu1pUEhj4juT20IByds7nSQUQFL3WgjgfNsE03GHhEAdmHeVC/8lwwsqBfl7BbSVSkw=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(2616005)(83380400001)(7696005)(36756003)(316002)(81166007)(15650500001)(356005)(186003)(4326008)(5660300002)(426003)(2906002)(6666004)(8676002)(4744005)(508600001)(26005)(70586007)(8936002)(70206006)(82310400003)(36860700001)(1076003)(110136005)(54906003)(86362001)(336012)(47076005)(16526019)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 12:00:39.1840
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c54225f-7453-4a57-89fc-08d97cf76dec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5102
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a message to print the resume time information obtained from the
smu_metrics structure.

Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Signed-off-by: Sanket Goswami <Sanket.Goswami@amd.com>
---
 drivers/platform/x86/amd-pmc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/platform/x86/amd-pmc.c b/drivers/platform/x86/amd-pmc.c
index bc7c4498067b..27c04ff57ffb 100644
--- a/drivers/platform/x86/amd-pmc.c
+++ b/drivers/platform/x86/amd-pmc.c
@@ -174,6 +174,8 @@ static int smu_fw_info_show(struct seq_file *s, void *unused)
 		   "Unknown/Fail");
 	seq_printf(s, "Time (in us) to S0i3: %lld\n", table.timeentering_s0i3_lastcapture);
 	seq_printf(s, "Time (in us) in S0i3: %lld\n", table.timein_s0i3_lastcapture);
+	seq_printf(s, "Time (in us) to resume from S0i3: %lld\n",
+		   table.timeto_resume_to_os_lastcapture);
 
 	seq_puts(s, "\n=== Active time (in us) ===\n");
 	for (idx = 0 ; idx < SOC_SUBSYSTEM_IP_MAX ; idx++) {
-- 
2.25.1

