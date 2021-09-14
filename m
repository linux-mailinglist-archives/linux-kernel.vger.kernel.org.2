Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7BA40A300
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 04:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234530AbhINCCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 22:02:55 -0400
Received: from mail-dm6nam10on2040.outbound.protection.outlook.com ([40.107.93.40]:24160
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235332AbhINCCw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 22:02:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vh9d0aBUBpM2bcfINyzO2ATBvKcEZ5zzF9uu8SilEPMjkSEcVajXRPjwRXR8Ujyl/0GxYax8VdCzf5mxXyfYZOhxljBq/OHKh8HKZzkl7t2CIdWSHzEBHr/j3co9Cdh25MZWR4GnOrdBUm25R/R7vwAszN07792Pm4EFyUj7ON0xN2iVfrLjYWXH8Hruxs5yacB2LlbD75nEAY1woMECQJUWSNucwh32Mj3UgcgV5Ite7OU+pAfoMIHa505F3C5zRWKGRsX95u/+EMdZ/uIubNXJ2dSkFbuvpQ9KdYbHR+L0R3rXDe6I3E1Y+5gJ5o1n9qTc0L03BstlTChugl0tSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=PL7X4Nh3Po08LHO+6x29FDfGQppfckpF/+XX1zJzcgQ=;
 b=WmzgYEjXQ1su1x7H4BQzvZCz7DSPQL8QZ8FfVcwqy0XuVtwFLt/LBMM07ZatMS7fbZ301sJRcb/OVto58g9uuFTL6g4pm16xDTZXvcIF2nHI6D4qP7spCnCElkaF72gH+F85NKwl3yB63O1lpDLkVgJ7p8VlN/ls5K1p/4IcofX0Tys5lkBypZPZ9k0aWPTWGJolwmKqYc8ef2grzbk+KSrjt2E6+PMLTWC/VbZECFVeJa/3N0cqP+o22GlahdM+KQL2+0QmI18gGJ1uz1/6W+T1BsFrsy9ECu9bvN/W22fENeBdE1UDUN2hYlhTb4GErKWvlYfim3q4kNm0F4MvhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PL7X4Nh3Po08LHO+6x29FDfGQppfckpF/+XX1zJzcgQ=;
 b=glo+M9q5UTaaY0c/oWDlX0+OfMiVMyXziJspzUR4oNnya8f+EKq6pGHh1M3YxvdSe9ur/QoyLEjKimPA57pRVZi35Fstm/H0BAtvoheEdBqiZZ3Od4eZNGxFMc1sZub7pUtF3VjzyE8PPfcUAomGGyla2ucuVppAhNli3/B+Zv0=
Received: from MW4PR04CA0347.namprd04.prod.outlook.com (2603:10b6:303:8a::22)
 by BYAPR12MB3112.namprd12.prod.outlook.com (2603:10b6:a03:ae::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Tue, 14 Sep
 2021 02:01:34 +0000
Received: from CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8a:cafe::61) by MW4PR04CA0347.outlook.office365.com
 (2603:10b6:303:8a::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Tue, 14 Sep 2021 02:01:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT031.mail.protection.outlook.com (10.13.174.118) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Tue, 14 Sep 2021 02:01:33 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 13 Sep
 2021 21:01:32 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Hans de Goede <hdegoede@redhat.com>
CC:     Mario Limonciello <mario.limonciello@amd.com>, <stable@kernel.org>,
        "Julian Sikorski" <belegdol@gmail.com>,
        Mark Gross <mgross@linux.intel.com>,
        "open list:AMD PMC DRIVER" <platform-driver-x86@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH] platform/x86: amd-pmc: Increase the response register timeout
Date:   Mon, 13 Sep 2021 21:01:14 -0500
Message-ID: <20210914020115.655-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a7b430ff-1728-48d8-f44e-08d9772393fe
X-MS-TrafficTypeDiagnostic: BYAPR12MB3112:
X-Microsoft-Antispam-PRVS: <BYAPR12MB31128769F75293C7BA250F37E2DA9@BYAPR12MB3112.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1091;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x8l44wUxyFWPW+gQzcB3dmKO4ejt+dd6oA9IoQ2c4Tv8QTwpurng+GQQT6PQ35u9dTDVcrY3jmmUf3y6LbR6kPYHefPj7/UBaWFT4fhaLElMula+KmqKB/65BvJ8FfihuFElA3C1X43zRMhExh6nzib8r4rdH3H/pzBis7CHo4uHJxhyjA4/5GbCMEGZeQJ8GUaNQgg+keCrYhvNf8gYVI8mv1o5bN9EN08+03YKKymOyFXNU9eNhegEX/Uaojm55U9yThk5rreYNQ4Tld6Ped9+wjsMi3Zl2CdFys78cCgT80ti6RQmJae13PYSMRUk2EoezrM3HF4OiXZm5AWI22RkDr3+Xy5DziMLgeV22lvXr/nxlZp6ErsU+5RfU9aO2+gtICO8E/pKsJyOAJBFs5uwJ5wS2lFmGx26dZUUD3tyaA8hgvA27RqQ+L0oqxu+Im04N0y1FrrayKwGRuwJVOOo2KDUExzWFTyPsTq1u5ZuyI5RpS+NsqdsUBysMSq/LB3VSc5LldzdK3FGb/mN0LKkdF5i7RwPX8+YYMWnmK6VSRI4uzoCqew3WKTV8rWdkMvD6j+4Zkm4DuaTAEu3N1zE+a+IXYOuCzYPbuhqB1oHqgZBPQ1Cpcnb/JsvKaCDW6wpgMJ2OFrHyPl+Br1/B5VcWjsigNAt5GSXlM11emw3NEzX9FJW2Dp2DI/uxvuPKZJNbZV6uVxffiupKSoFQRZaiHNzqvZ7NpN4JFZD7lg=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(376002)(39860400002)(46966006)(36840700001)(186003)(82740400003)(70206006)(70586007)(83380400001)(2616005)(336012)(426003)(8936002)(44832011)(81166007)(16526019)(4326008)(2906002)(1076003)(110136005)(36860700001)(5660300002)(54906003)(26005)(6666004)(316002)(966005)(47076005)(478600001)(86362001)(8676002)(356005)(82310400003)(7696005)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2021 02:01:33.8476
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7b430ff-1728-48d8-f44e-08d9772393fe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3112
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There have been reports of approximately a 0.9%-1.7% failure rate in SMU
communication timeouts with s0i3 entry on some OEM designs.  Currently
the design in amd-pmc is to try every 100us for up to 20ms.

However the GPU driver which also communicates with the SMU using a
mailbox register which the driver polls every 1us for up to 2000ms.
In the GPU driver this was increased by commit 055162645a40 ("drm/amd/pm:
increase time out value when sending msg to SMU")

Increase the maximum timeout used by amd-pmc to 2000ms to match this
behavior.  This has been shown to improve the stability for machines
that randomly have failures.

Cc: stable@kernel.org
Reported-by: Julian Sikorski <belegdol@gmail.com>
BugLink: https://gitlab.freedesktop.org/drm/amd/-/issues/1629
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/platform/x86/amd-pmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/amd-pmc.c b/drivers/platform/x86/amd-pmc.c
index 3481479a2942..d6a7c896ac86 100644
--- a/drivers/platform/x86/amd-pmc.c
+++ b/drivers/platform/x86/amd-pmc.c
@@ -71,7 +71,7 @@
 #define AMD_CPU_ID_YC			0x14B5
 
 #define PMC_MSG_DELAY_MIN_US		100
-#define RESPONSE_REGISTER_LOOP_MAX	200
+#define RESPONSE_REGISTER_LOOP_MAX	20000
 
 #define SOC_SUBSYSTEM_IP_MAX	12
 #define DELAY_MIN_US		2000
-- 
2.25.1

