Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA0A355881
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 17:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346054AbhDFPuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 11:50:55 -0400
Received: from mail-bn8nam12on2076.outbound.protection.outlook.com ([40.107.237.76]:45888
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1346013AbhDFPuk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 11:50:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a415miJ3EqcY1QbidTDsk9yHGhO2MWrb9xReroQZeHI4W8m9RnkGFtg7kciJWO16iKHS0E0VLlE/Hs9NejzI3b2O5Ke5ggZmsY/90sMeIqOdV5IcICDP71rUeOvLm5/O+8m1J+Fk+pmIIBq01OBX0il0Oe+6ouUieyCvhtZl93rRlvWCMIb2FXjjTbBPFTCix20P0MzPfPWOsefxVxC5ETwoiQHcBtnlOiL7PMNd/1ScLFfEft6VnSmJVqg2BNe5/SE5ksp4VJMovefLfkarR4LICc6C3dWqG0SdhGdBWZP4lgYhms+4zYyrMHDB/SUPP8XbdBf0a2I9VYRRGGNemg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oMJEF2RK9BZpBqUSnsAi4Om9qfYjmfhkNbXhy8MQGx8=;
 b=QWh3xil+/4NNDHGY6TyAUtbCgHvPkNAYyiDoXse7aOXF/w/OYQXEVfd4i6j2YD34vN1NuAtydAOEVioMuA03I6+NgsymRyGtKJsWY7zwvfOUwBpVStZyPaaAQgxyK7ED79hJPC9k0uz8n+8DChr6zo+OiZymelY54Gsl7fkK6Dzgwzu0fs4KwKdz06k117lQvOZUYeKOLB20lk0DyiodsdqiinzUN3ryX5qENZf+hzcDaJdELlM6gZsZKNwWfuDEXxpLu6PZ3yA+KNkOPrfPpTnmM47bBvGmQwtF0/8zy5A4ApZndmC/d8NVhayMgMTX0R+TjgtXVooI7Ckg2o2Bnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oMJEF2RK9BZpBqUSnsAi4Om9qfYjmfhkNbXhy8MQGx8=;
 b=KVwUCj6TxQPycvBO133CHgLUl6foB9tL2JvC4p0zswZ5vLv5Wfp5wr5z6EqLbCN6jYPuuKkWTlKjLmRqWJlaFduWfjmNSmY804hETpbHxIRJHWdwjL6B1XixtJeGiL3XjI2z/ZRuCTKqoYJS8gyLmt65RBF7kg6tpnz4TjChBn8=
Received: from MWHPR12CA0036.namprd12.prod.outlook.com (2603:10b6:301:2::22)
 by BYAPR12MB2728.namprd12.prod.outlook.com (2603:10b6:a03:61::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.29; Tue, 6 Apr
 2021 15:50:27 +0000
Received: from CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:2:cafe::60) by MWHPR12CA0036.outlook.office365.com
 (2603:10b6:301:2::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.29 via Frontend
 Transport; Tue, 6 Apr 2021 15:50:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT015.mail.protection.outlook.com (10.13.175.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3999.28 via Frontend Transport; Tue, 6 Apr 2021 15:50:26 +0000
Received: from rsaripalli-Inspiron-5676.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 6 Apr 2021 10:50:24 -0500
From:   Ramakrishna Saripalli <rsaripal@amd.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
CC:     <rsaripal@amd.com>
Subject: [PATCH 3/5] x86/speculation: Introduce SPEC_CTRL_MSR bit for PSFD
Date:   Tue, 6 Apr 2021 10:50:02 -0500
Message-ID: <20210406155004.230790-4-rsaripal@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210406155004.230790-1-rsaripal@amd.com>
References: <20210406155004.230790-1-rsaripal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd1c33db-6e70-4dc9-8e7b-08d8f913b27f
X-MS-TrafficTypeDiagnostic: BYAPR12MB2728:
X-Microsoft-Antispam-PRVS: <BYAPR12MB27282A24EB12036778FC3DA99B769@BYAPR12MB2728.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1227;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /DIiPdpedVxf95S/0M90MiuXEqBgagDfzJd0TZeu5OPLei3Ctj2LduVCubyT8iGfcoKraFCcBowaI/7VB6MpFZvQzhD5+SVL2P8G/MtilyZ8oP86R7bthr9LmyKdKhHkHMOurjPtIHufx8KoB0P5qPejjcyfAxoUHWTPAVrPfLaXwmBQnZ/feBGSWjO1q41Jr5UjLQEJQ8j6g/cbpJflP26m0efypYXktSvOYxgg0SXKSQlPNjRF/yPJLD55VprSl4A3waXAlR/Rkhp8TMKrAgCj57OMCrBTat4sy6+h3+wgI0y9vp3NRFSW5jKye1g9Wt+NCAZqnfGjv3DffmyfmczlrNd04AlQQlZmmqwCkpJr+MsGENXQjf0wKlLD+Lk5kIJ3oTneUA1ZUTunJFOW1wEQjEnE7adRfmkQpDWtCN7szRbpjMrdwjBmyzpPm4ddNA/21m4Q+RTgc8rxu8n7aw6wuq4mJBqCH2tskCsjQ64PxkLtaRjXMtRLR+0233sJc3KQsf9njw67MZ2AhViB7DF2sBshrxSXw542YdFnel0g5YoFXPkAJMK8KWrlWm/HsppOCihqy+yB4RrVaIvK2dulWhmFCNHVohCtY+c7aDnIfmD2c0Yq3HSMM9vQwvdGpjH6OQa6YMXa1HG+czheQ2mWMQZQb6KhwpHDrKn0pA0XW3C1IjS7ectruuOrSlP7
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(396003)(39860400002)(36840700001)(46966006)(82310400003)(8936002)(82740400003)(7696005)(186003)(110136005)(26005)(2906002)(16526019)(36756003)(1076003)(70206006)(8676002)(6666004)(4326008)(36860700001)(478600001)(356005)(5660300002)(2616005)(81166007)(426003)(336012)(316002)(70586007)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2021 15:50:26.5724
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd1c33db-6e70-4dc9-8e7b-08d8f913b27f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2728
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

