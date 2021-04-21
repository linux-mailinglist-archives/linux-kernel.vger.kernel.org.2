Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1418366776
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 11:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237769AbhDUJCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 05:02:14 -0400
Received: from mail-eopbgr760078.outbound.protection.outlook.com ([40.107.76.78]:60630
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237043AbhDUJCJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 05:02:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lvfuxlJM83MM5RP8Uc3RFunZnYeczZIh12X1Shi/5KF3YyigEPPMwDpe6+GLMOVqXHcLO4GpqK+sMsywwr6khfIX6meBSd3ossC2o49JQq8fHxZnRNJcyoIl79kBN6DzuKnS4pfu+RvxOL8RteKpuBRGgXPHMxG0IWZwWUyUWdIdD5c/vNjOy5CEhvpiwYu0KOnbJCg/2p+rJh1r/cyUGCf/Wbn140WRsoed+iXqvgKUbmSULsjZZ6aPrULEPSqb6xt1ZIuRMcKrssXoxZ1/ppZ81Ab+Ybb+9+qes2H8mvDf8WbE2x+toTZDwbHOSQA0vbxV9LqqJ2jiiP8AvcS6nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oMJEF2RK9BZpBqUSnsAi4Om9qfYjmfhkNbXhy8MQGx8=;
 b=P7rS1TlweKIOrRLGjEkAdySl+Ls208p2ih4a2lsGXrpgqX7fHU/HosuyMNKx12MBaQgoJUec90NV88+Z0we+i4EtKinblzxRQxYzOEVjvyQTAI8SjdFwmHIz8J71Z+jzFnTzubvCiYMJ2ZcqyPeayKn8TGVtWZGBegwkgv5XKnPHkd6rMhDJGD3kSdGgmEvsUHyB9gMqdBK2ZePo4m5Avb8k8cwmCXC1xFoo3gWpk/mtzBzlnwQvf86bVANBsMdA3HzzChXJhbaJd/7aAXTeaF33EQ6Wh84gQ+XJdpAdMLDmIjqNBeoHefwWrO8TOYh/KBEv+m2mpu4RrrvdiMJ+kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oMJEF2RK9BZpBqUSnsAi4Om9qfYjmfhkNbXhy8MQGx8=;
 b=ZijAse/Kq2hon/+vqYWBT3wPa6qYWKkXDjlf3Ww6O3H4yeILVfrFEt774kGyxAZ2WBX4CJfZFCcaEXygYpg9bV7u6JKxlKcPE890scwEoPGJVkGjGxTfYQBmW/5qPTG/8JnTm+YSiYoQUdSb4ppY4aJu1K6K4DStm9EHxB5LzMI=
Received: from CO2PR04CA0197.namprd04.prod.outlook.com (2603:10b6:104:5::27)
 by DM5PR1201MB0155.namprd12.prod.outlook.com (2603:10b6:4:55::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.24; Wed, 21 Apr
 2021 09:01:35 +0000
Received: from CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:5:cafe::bc) by CO2PR04CA0197.outlook.office365.com
 (2603:10b6:104:5::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend
 Transport; Wed, 21 Apr 2021 09:01:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT028.mail.protection.outlook.com (10.13.175.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4065.21 via Frontend Transport; Wed, 21 Apr 2021 09:01:35 +0000
Received: from rsaripalli-Inspiron-5676.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Wed, 21 Apr 2021 04:01:33 -0500
From:   Ramakrishna Saripalli <rsaripal@amd.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>
CC:     <bsd@redhat.com>, <rsaripal@amd.com>
Subject: [PATCH 2/4] x86/speculation: Introduce SPEC_CTRL_MSR bit for PSFD
Date:   Wed, 21 Apr 2021 04:01:15 -0500
Message-ID: <20210421090117.22315-3-rsaripal@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210421090117.22315-1-rsaripal@amd.com>
References: <20210421090117.22315-1-rsaripal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e2ec5388-4d6f-4bd6-a297-08d904a410ff
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0155:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB01554B93DC656A5CEC9066C49B479@DM5PR1201MB0155.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1227;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wHfC4INJkyNb+QJQ8laIQzsY3iTIojIHzaXObj82Z3opni8oViyoeTkaphXBcWuZB7HObyD8ILTbdsNbs1IJtDF1deahQEa7ZY2mx8gz5loM2EoS+iV/SjVb+0QAvubqWhF1d/BqAsCZ/eisFgGHgM5Fb6xbn7k4CiS8Ud/TerzJ/p2HB9pYTTOfWscaiO2SNQKdZ87gZX84cMOi98cm/Bgy1v5BTq74EjSpKSxidxyH1l7AbT8s3yllcpubpI0mDjZQenZNrhSHt7jz81iuw7Vs/pLnbD5cNEA07OqKfb2GHUnyG5XNrmyHPNKMxr7Hm0iBgb1+0HOEesmJsbwlRa3zZeKGyiAe3b1SA3GSkoHYborui+WW6peEhz51o99SLf1g1W3Na2Qt98vDpgSM/WRJI2t454mn8P9TKcqPs63VPHTY9H2M8cwQE23RIEkQrIOWt+lm5QmlOtHOm4Wkw2WcdJCMFQVcC5Mtc2AqUEEGLcIkF8MIZeMHK+JXSM0wqm5E+1cFf4z1EwOVErF54QxSl6TTL42GE+re4QGCgl6e4bHY7uK20npiRxdvzezdWAkg1G2iPBHPT9x8aAPU5RtDD+W1V8PDg/zkwui8e8RBP+aPV5JqypZTEQEqmcYr2kWGiwYzgdKYFrZzNgoQTVy1CsyvK3HWVy2FqtPuyBhai9shayJVgZlggm49KTZ3
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(376002)(39860400002)(346002)(396003)(136003)(46966006)(36840700001)(1076003)(70206006)(356005)(316002)(7696005)(8676002)(54906003)(2616005)(82310400003)(5660300002)(36756003)(4326008)(426003)(110136005)(47076005)(2906002)(6666004)(26005)(336012)(81166007)(186003)(8936002)(16526019)(82740400003)(36860700001)(70586007)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2021 09:01:35.4383
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2ec5388-4d6f-4bd6-a297-08d904a410ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0155
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ramakrishna Saripalli <rk.saripalli@amd.com>

All AMD processors that support PSF implement a bit in
SPEC_CTRL MSR (0x48) to disable or enable Predictive Store
Forwarding.

Signed-off-by: Ramakrishna Saripalli<rk.saripalli@amd.com>
---
 arch/x86/include/asm/msr-index.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 546d6ecf0a35..f569918c8754 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -51,6 +51,8 @@
 #define SPEC_CTRL_STIBP			BIT(SPEC_CTRL_STIBP_SHIFT)	/* STIBP mask */
 #define SPEC_CTRL_SSBD_SHIFT		2	   /* Speculative Store Bypass Disable bit */
 #define SPEC_CTRL_SSBD			BIT(SPEC_CTRL_SSBD_SHIFT)	/* Speculative Store Bypass Disable */
+#define SPEC_CTRL_PSFD_SHIFT		7
+#define SPEC_CTRL_PSFD			BIT(SPEC_CTRL_PSFD_SHIFT)	/* Predictive Store Forwarding Disable */
 
 #define MSR_IA32_PRED_CMD		0x00000049 /* Prediction Command */
 #define PRED_CMD_IBPB			BIT(0)	   /* Indirect Branch Prediction Barrier */
-- 
2.25.1

