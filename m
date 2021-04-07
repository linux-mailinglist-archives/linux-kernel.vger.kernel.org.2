Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC397356C9E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 14:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352439AbhDGMu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 08:50:56 -0400
Received: from mail-bn8nam12on2042.outbound.protection.outlook.com ([40.107.237.42]:37088
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1352424AbhDGMuu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 08:50:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RdpVJefT2+jcwBxJVAjzCD88+zem6KUjX2zRD/mGm/lEbZMk9VpyCa9I8mw2HbWbDuX3FcfFex2ZKJZsPPFKXSGfaqwoCBGYe/W+tz09VhNRgUWhZ95JjjgjKkqQTV39Vyrlzillb7ea0OW3E3PtH38D3Q6BgHd+HedLaXAsSppNGmBhk5XYYZ/QPiQQNK4NhQrOhKXVhN/VkA9qRHskn00rMH63yZ/SIHB1tNAYWRir075HePiqZ+vYeRCQESrATQUntSM8Vg/l+33RQCptofOcE6JraPkeYFtJ+wr33J5QlEgujHteRneyrUL/cyBHSBkGnUXiKlL55M/YTry3OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Jq/38YBFGqAxVQItBx421hIk/hEUAgkVWEuzEvOg5s=;
 b=a5I+dJTBdK0skL7PWH0dvGEv54q51ASbY5xSphLcWO+xiNMjm7W3fH+AHJLoNURRnXldhgCLSwKOUQbHKeVXVwwXflHDZ+HzRwr/ehEAMH0fL5WNwI8S/5UyxtKx3uKXghQKzroFRXdXC4YmcU31len6kMg9Ubaxnboo/y4p5xYRpsmoBZzvsMG7s0FHSHaeYdkNIg/geKvZUGWLDYsJLXyA+q7XZ5xPPdlOxx4ufAwXTFFPO8LaIfQe59BxZ0U4eVqz9jqKEAcKlJWqsYeG+KP8VMZuu9YVBIaKZoRgVGHKKuAuWunaR89TldjKGsfgD7i6qiDQ1A19ZcH6Idl1hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Jq/38YBFGqAxVQItBx421hIk/hEUAgkVWEuzEvOg5s=;
 b=WM4TuxYGsLKmp/5ORjRQJW808ypQxmdRzYOZuT8vkOhXwbtoJSfobjRS9DKtN+I6v373USD6KSFMBPUgLXgufXJzClnVWQU0ka2v3l82486RpGsvFAVtaE+Sed2zWwUZs7POiv/KWeC1seb7ITp2B2Gc6T+JnGQ2ShmsmfxTUiY=
Received: from MW4PR04CA0223.namprd04.prod.outlook.com (2603:10b6:303:87::18)
 by BYAPR12MB2984.namprd12.prod.outlook.com (2603:10b6:a03:da::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.32; Wed, 7 Apr
 2021 12:50:39 +0000
Received: from CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::f1) by MW4PR04CA0223.outlook.office365.com
 (2603:10b6:303:87::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend
 Transport; Wed, 7 Apr 2021 12:50:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT068.mail.protection.outlook.com (10.13.175.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4020.17 via Frontend Transport; Wed, 7 Apr 2021 12:50:38 +0000
Received: from rsaripalli-Inspiron-5676.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 7 Apr 2021 07:50:37 -0500
From:   Ramakrishna Saripalli <rsaripal@amd.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        Jonathan Corbet <corbet@lwn.net>
CC:     <rsaripal@amd.com>
Subject: [PATCH 5/5] x86/speculation: Add PSF mitigation kernel parameters
Date:   Wed, 7 Apr 2021 07:50:23 -0500
Message-ID: <20210407125024.242491-1-rsaripal@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cdfd7ceb-335e-4dc0-fe2a-08d8f9c3bef3
X-MS-TrafficTypeDiagnostic: BYAPR12MB2984:
X-Microsoft-Antispam-PRVS: <BYAPR12MB29847596D0A50BFC9B5AB9989B759@BYAPR12MB2984.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EbfJmVeAzypJTVCbTJCX9bgdRorXyxytr+qJXQUYj640qNiPmF3edd07UhwssZuZnu5xa5pz1icM7k8iYtNipAAA4tW8sQUBG5p6QjOy22WYL2O5VUecE3pJAYRPiOzLcs+nwUMPzt5bOwhe9I4e1/vX870G2QNbVR7GYVi9qqiSZHJzz3xnKfctFRJOprdQVtX4iCMsiAMNBQx+oO6KvvsoXzLoE3v4hS6dl2Dh/DRoorEZfv9uEJEQu97kPLWbcNEkf3drrXc3VvqojB/Y1hxxtyh8JpqYMF7+v4kBC7MNT/Q4As/hmN7ahP8GNQuNAF1USPrxdxD30tlt3DHj4KzT8cVZZwDXURNtjWHG8mrwGWfe6goXwY2Hy/mHEcCYyVg+Fkzvgn7WqToWDosvEBdKgl2+07fNabeSTonldBfXWaaMkuIVWxWhK2L4SGW+QJH506PQ+/qqnhSWbED72S8kCnyPkG1V82RWZRibCVX5AzyBx8O1VASWCr5LT7BqFtH8wk2hE/Qt1kbUUPCX2fCxnFzNiikyjblNjrVCGNjgjWnmrJSIq0hm8dBGaHhRridYT4rXQ5qn81Qw87p+z86vzm0+bxi82HmjYazQM1jl5jRDmlkxNbwpNYruzpTX/WSKXUkPtzB9ud+4m5/y8cOKgHZLD1XePvulkDFi1IRPMtbAP1QxnnTaFpWY7uFX
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(396003)(39860400002)(36840700001)(46966006)(36860700001)(316002)(82740400003)(336012)(7696005)(16526019)(47076005)(478600001)(83380400001)(8936002)(2616005)(8676002)(1076003)(70586007)(2906002)(6666004)(356005)(36756003)(81166007)(426003)(186003)(70206006)(110136005)(5660300002)(82310400003)(26005)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2021 12:50:38.8916
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cdfd7ceb-335e-4dc0-fe2a-08d8f9c3bef3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2984
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ramakrishna Saripalli <rk.saripalli@amd.com>

PSF mitigation introduces new kernel parameters.

The kernel parameters for PSF mitigation are modeled
after spec_store_bypass_disable.

Signed-off-by: Ramakrishna Saripalli<rk.saripalli@amd.com>
---
 .../admin-guide/kernel-parameters.txt         | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 04545725f187..68dfde77a87d 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2876,6 +2876,7 @@
 					       nospectre_v2 [X86,PPC,S390,ARM64]
 					       spectre_v2_user=off [X86]
 					       spec_store_bypass_disable=off [X86,PPC]
+					       psfd=off [X86]
 					       ssbd=force-off [ARM64]
 					       l1tf=off [X86]
 					       mds=off [X86]
@@ -3243,6 +3244,8 @@
 
 	nohugeiomap	[KNL,X86,PPC,ARM64] Disable kernel huge I/O mappings.
 
+	nopsfd          [HW,X86] Disable mitigation for Predictive Store Forwarding.
+
 	nosmt		[KNL,S390] Disable symmetric multithreading (SMT).
 			Equivalent to smt=1.
 
@@ -4002,6 +4005,48 @@
 			that).
 			Format: <bool>
 
+        psfd=		[HW,X86]
+                        Predictive Store Forwarding Disable control
+
+                        Certain AMD processors feature a new technology called Predictive
+                        Store Forwarding. This feature is designed to improve the
+                        performance of code execution by predicting dependencies
+                        between loads and stores.
+
+                        Modern processors implement techniques to optimize the
+                        execution of a load instruction to an address that was
+                        recently written by a store instruction.
+
+                        PSF expands on the above by speculating on the relationship
+                        between loads and stores without waiting for address
+                        calculation to complete. With PSF, CPU learns over time the
+                        relationship between loads and stores.
+
+                        Incorrect PSF predictions can occur for various reasons.
+                        Please see the AMD PSF whitepaper for more information.
+
+                        All AMD processors that implement PSF also provide ability
+                        to control mitigation of PSF.
+
+                        Following options are provided to control PSF mitigation.
+
+                        The options are:
+                        on      - Unconditionally disable Speculative Store Bypass
+                        off     - Unconditionally enable Speculative Store Bypass
+                        auto    - Kernel detects whether the CPU is vulnerable.
+                                  If the CPU is not vulnerable, off is selected.
+                                  If the CPU is vulnerable, default mitigation is
+                                  KConfig dependent.
+                        prctl   - Control Predictive Store Forwarding per thread
+                                  via prctl. Predictive Store Forwarding is enabled
+                                  per process by default. The state of the control
+                                  is inherited on fork.
+                        seccomp - Same as prctl above but all seccomp threads will
+                                  disable PSF unless they opt out.
+
+                        Default mitigations:
+                        [X86] If CONFIG_SECCOMP=y "seccomp" else "prctl"
+
 	psi=		[KNL] Enable or disable pressure stall information
 			tracking.
 			Format: <bool>
-- 
2.25.1

