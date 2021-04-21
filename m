Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4904C366777
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 11:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237820AbhDUJCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 05:02:18 -0400
Received: from mail-dm6nam10on2045.outbound.protection.outlook.com ([40.107.93.45]:58827
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237696AbhDUJCL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 05:02:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=etbjZUzikoyfgkk4IkK6VHH7XMeq1CiaBKA5ZiWl5kGsLycAS6TdJJKet4iciLvloZIq/eKd2zHK0mbIAYDv8ZHVGOlt5wZ+2g1+YwNfMDbgQB4t3j+cYH+QNTUalMhEvmzUACRLwshI9M+tIvktetiAHqTOKCXIPFlH0iKoinBzvVcUvY2Ce0CAmQCKHRknWmgMAFVVGBHZX6rJfYT3EaolRKxJjQWgoeA1JZMCw1rJtAFZH1TroUg4Xqif7BbQXHjG0pLq1FAoAvUQuoTulUDs9MWDjUOsLEvefulI/Mf5Ed3F8mVX6mPYpptxiBWOH/7ml61a8O4ECbkPeWMI9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TIzm9Xp/l13+OAteP4u3bfKS8PEAow3CEMKQBS7qnT8=;
 b=H0OZlOmzbIStaqVvaJ2pH4I8OP1QCw8XSOmxBCn/fryLCOOPwtpDfUdCBpxiM7+0957Vg/9pbWaC6QfFuXuGb1/TMuKbEwiNJb0g15bpoFwC8PO78trgrb6GyaeQ6Ll/4jrX0M6MHIMFlJJxnZV0G4sB9iC9Tk5KqUaKouih5AvB4Had+bewRGd+6OC5xxQfgquo92M56MNpIKCUgYRbOL+DQSVUwRV1rvnM7SLwoyoS13GOtFqSxOqN2r66UkMP2G+oPUPmPqhPwkD5nK55PUOMH94tdVWweWVAVgRNp98iyMxYXQQXJT4a7EgPa8S7E56jJs8MjykPNMS+faitnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TIzm9Xp/l13+OAteP4u3bfKS8PEAow3CEMKQBS7qnT8=;
 b=olsv+KSSgNHvSFOX+8x+jH0RxSBXgUkJWrm68VdyIBeubA8fFUajGdNas1y9FlukFIkpB50uWK5TSditwrzaCgOcEEgJwVY8diPxuAKOQeGh3OR0omrSVhnaEsCqd2FbGvQpZlpr9BSjjo//XFbMWvY2qdLx1Jfv1iYp9nUl6bw=
Received: from CO2PR04CA0199.namprd04.prod.outlook.com (2603:10b6:104:5::29)
 by PH0PR12MB5451.namprd12.prod.outlook.com (2603:10b6:510:ee::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.19; Wed, 21 Apr
 2021 09:01:37 +0000
Received: from CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:5:cafe::4e) by CO2PR04CA0199.outlook.office365.com
 (2603:10b6:104:5::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend
 Transport; Wed, 21 Apr 2021 09:01:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT028.mail.protection.outlook.com (10.13.175.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4065.21 via Frontend Transport; Wed, 21 Apr 2021 09:01:37 +0000
Received: from rsaripalli-Inspiron-5676.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Wed, 21 Apr 2021 04:01:34 -0500
From:   Ramakrishna Saripalli <rsaripal@amd.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        Jonathan Corbet <corbet@lwn.net>
CC:     <bsd@redhat.com>, <rsaripal@amd.com>
Subject: [PATCH 4/4] x86/speculation: Add PSF mitigation kernel parameters
Date:   Wed, 21 Apr 2021 04:01:17 -0500
Message-ID: <20210421090117.22315-5-rsaripal@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: e6c7b544-3933-4977-5c4f-08d904a41213
X-MS-TrafficTypeDiagnostic: PH0PR12MB5451:
X-Microsoft-Antispam-PRVS: <PH0PR12MB54517A18419F6F8068564B419B479@PH0PR12MB5451.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7jU3DVlC18Pyx2TaeT2sLAeyqV8PIGoHeaV7kk3CK+7Ssc5uYPDTm8H8QpPKrYDIEja/NW4echXDbvd4RhODu64NBywAy6V8+PP4Diqsr4dD5nKR/7pOUddMno2ile2OfAVh4hanq/lYs9GyOUvRgZIM+7Z1S55l94gdTe8emyqlSu6g20z6QX6Izl09/m6U7XpfQnEn1lnoNsScGLZFhPRqAm7Dxk2F7Upj3ytI2y8Rl8K7AvHPn89a4V1mEQ3ev3bgVlbLUl0WXVmprHMjas7Gvh+MPZhdHrkNiq8swKVBUaju2X4iGBycv+9yACpUXnFp4rllTE8aeVOJTXBWnDfaQ2K3l9HlqJtFGww4cVd8MdiQNL6VTO7+LntsNRXVChxqyj641YytNoCDi60o0wJAHIvYgB2DRBzL9iuGC+60gcv7nEKhsSD55QI016AWApGbUZS/a7vJfJRbRg1Pw85jLFu4qNFR1fafMN1VQjd4y+wMqHjB51/g6efocm2GXdYuMmiNKw96Epg0aAIbRlhqZTc8QpVW4BD+ypYhtSH+/qWAEBV9nKLJzNYckBOXIk7sYBkbXkGaAgXzJA01vWUA+HEYwxstMDiGtEU9XSIgx99noOYVn09JXBsU5ZXhjdA8L22g+ScTN+yTnxPIa35kZSYVZW5pKZ3PsVHYm33TahJ0wYcInU2MviDiNxwZ
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(136003)(396003)(346002)(376002)(39860400002)(46966006)(36840700001)(36860700001)(1076003)(316002)(110136005)(82310400003)(36756003)(6666004)(54906003)(4326008)(426003)(2616005)(7696005)(336012)(8676002)(5660300002)(8936002)(70206006)(70586007)(478600001)(82740400003)(4744005)(47076005)(2906002)(186003)(16526019)(81166007)(356005)(26005)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2021 09:01:37.2443
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6c7b544-3933-4977-5c4f-08d904a41213
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5451
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ramakrishna Saripalli <rk.saripalli@amd.com>

PSF mitigation introduces a new kernel parameter called
	predict_store_fwd.

Signed-off-by: Ramakrishna Saripalli<rk.saripalli@amd.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 04545725f187..58f6bd02385b 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3940,6 +3940,11 @@
 			Format: {"off"}
 			Disable Hardware Transactional Memory
 
+	predict_store_fwd	[X86] This option controls PSF mitigation
+			off - Turns on PSF mitigation.
+			on  - Turns off PSF mitigation.
+			default : on.
+
 	preempt=	[KNL]
 			Select preemption mode if you have CONFIG_PREEMPT_DYNAMIC
 			none - Limited to cond_resched() calls
-- 
2.25.1

