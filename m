Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAC1235587F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 17:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346016AbhDFPuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 11:50:50 -0400
Received: from mail-bn7nam10on2055.outbound.protection.outlook.com ([40.107.92.55]:65504
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1346010AbhDFPui (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 11:50:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TwT5a4oiseok7v5M0v9da3wG0aZSMKQFsdOOR12oaWuKLWaIVIyxr/Nx1rumv3Dltdy9fg9lqkNb0n9qL3Flb9M9PSwuGknVeGZqa8P3FAX+YGaJ+oub6lxQP5rsnbu2tk3IUT4tgWCTA1VXBbWu+b/O5kV/lJ4MxWcbXvQkBuBfhPjY/IShHYAEkP3MAzAKX+GODZ/qHAajrnTIZe7Kq4A5WGbjtFQWE2ibyjZb+IV7TaT++2Cdn1XuHx+B/w7K5zWJMqW8Nppse0vcDlL+dU07a025tfdkhutKupAaRedxtfr/FSpvXRuLCv3EhKcFgQwSU4suZq7Dw3bHWZ6xpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Jq/38YBFGqAxVQItBx421hIk/hEUAgkVWEuzEvOg5s=;
 b=nhjssz6X6r2DWOD6XA8b73G/h9/LBGpyBj7a19K3z6txDDHIkS0RUuUKqo1E/HOUu2EJ0Tz7ULR/63Y0/OLiNE7tbxNDTUtFoDAJKI3KDF90NOh3cXZTSU5v6AfgL3/fNoGoVBeMPV4qj0ibU5Vfi/tFrg5b/7EB0h/tEhclYp7YZlE8BYIsV9hUpHOeeTuQfABA2us2YoPwYsSoaHJ0fS4Z2Nsx56fl90SnB7If2fAuUd/odqTRSptMuw5CxLrcNwjH0lZ4NvomOWtEhJOD+0WLF8iFcLo7aMpHqsEeme97Zh3Rq4TUwAlxCU56ou3hu/MnFQzI4Gi9/6K9yQp18w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Jq/38YBFGqAxVQItBx421hIk/hEUAgkVWEuzEvOg5s=;
 b=c5F4wMRv+EQTa6ivxu1qNuT8Dj1mz/WDRpmzLQMz2ZnsjWzqtjj2s3tKNOlGCuoE6tLY9lQClGZEewRJzurfLwxgTQhN1IYnBju5vrpjEB43dM/eHP2nX+ZMs/OQGYyyH+sAAIKUXGAtV/TSJvH3YOorIk8VitGTaC4QtnRNsUY=
Received: from MWHPR12CA0039.namprd12.prod.outlook.com (2603:10b6:301:2::25)
 by BN6PR1201MB2483.namprd12.prod.outlook.com (2603:10b6:404:a6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.32; Tue, 6 Apr
 2021 15:50:29 +0000
Received: from CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:2:cafe::e0) by MWHPR12CA0039.outlook.office365.com
 (2603:10b6:301:2::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.32 via Frontend
 Transport; Tue, 6 Apr 2021 15:50:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT015.mail.protection.outlook.com (10.13.175.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3999.28 via Frontend Transport; Tue, 6 Apr 2021 15:50:28 +0000
Received: from rsaripalli-Inspiron-5676.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 6 Apr 2021 10:50:26 -0500
From:   Ramakrishna Saripalli <rsaripal@amd.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
CC:     <rsaripal@amd.com>
Subject: [PATCH 5/5] x86/speculation: Add PSF mitigation kernel parameters
Date:   Tue, 6 Apr 2021 10:50:04 -0500
Message-ID: <20210406155004.230790-6-rsaripal@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 32f82fb5-1aae-4b50-9db7-08d8f913b3e7
X-MS-TrafficTypeDiagnostic: BN6PR1201MB2483:
X-Microsoft-Antispam-PRVS: <BN6PR1201MB24837F217E283BBABEA9EF3D9B769@BN6PR1201MB2483.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vpsVpjP1sQ6fHsV7skR0pv3R0xzXHZ53poPVB0NlSgbLagOH/WhGTQYe8//TSBY6z+i5q5rerwjTY+s2aZx6pAn5Tr6vUwHXK7OgtCFPUcddRVdOivHqWR6kcUzNHqosRe6sW3ZFkkUAlVluMUltdMWirDZE92oqmseJ/RncH3yeEPX6qeL0Ci1HOsgFbQdVU7n95fqc4pyRJJqP1qAZMvzo8shh4uWY292QmM6d1+iKIs3LBZjvFrcf17sOeSXQYELnSF3aTtWIOrIIHnIxucKEWQhSdKuetOuZrloqHVeO2XEdRQFgYvDeB2fYeW7MGGKI/DS+GUnUcd6fygV5yMdXaDp7ostPio2XOcYv5IgWxK2/ZOGJWy4su3D8zHLZzrlm59lY2IDt9UNxIZ2bZRhvWYnkV+JdCkKQfTWLa1zK4mt/oISNcjROQAg+tKsqVZbKcgyfI1aiPfzrdF/WTraeAUbwlPbrwVi27uHTs+HaZt8do4g5kkzi0no4oPu+roq+/oPgq7ZZgdor1h8civKhphrB5lfdybO432C7wRnEFNGyhyVXEjZqW9Sd5FKoqJM3rQdY23UBt75VLDRr3/wm+UXCFKQmOgf+zIQsM1XoHf0hLSmsA1o22OSaoiA77zC3owu+q6EoCmEZWq+mTL+FtnzG4bkUc10vWTm3fPHIhU37tt9gRx2+WnpaLtHb
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(136003)(396003)(376002)(39860400002)(346002)(46966006)(36840700001)(7696005)(36756003)(110136005)(81166007)(356005)(336012)(426003)(82740400003)(1076003)(316002)(16526019)(2616005)(47076005)(5660300002)(6666004)(8936002)(70206006)(4326008)(2906002)(82310400003)(36860700001)(83380400001)(478600001)(186003)(26005)(8676002)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2021 15:50:28.8852
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32f82fb5-1aae-4b50-9db7-08d8f913b3e7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB2483
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

