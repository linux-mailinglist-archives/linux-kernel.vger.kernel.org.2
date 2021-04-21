Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC716366774
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 11:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237706AbhDUJCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 05:02:12 -0400
Received: from mail-mw2nam12on2086.outbound.protection.outlook.com ([40.107.244.86]:61025
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235469AbhDUJCJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 05:02:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WQ5bYkfvcpJvXxHZr+d14u3+Vo7GbVZvX+7eSq3jAKbskjqiBvNM4mORVC7gSFq2B0Gi/xnwYziiw1PPuNDTzrkh41h+jVTQKzBUHZm7TSw7LhBNqcKbiPTdGhrXNtlRuk8w5YXe5HSgwd3sNA4MV2SjX+SVr7ixHR5JMDsmChcJJwVPpIZIpBGwmE478Q1OBRazzKu9HIQjvKZ0gOGC8C5uKl48Y7FTj6Jz9BhWV2qF0v0nhxmEQmgDKWEJLC1VRM+IHjT0EHHp/3PhhrvfLq/XxGNjDv4IvubMTgRG10qQrWTtZSsCde8kHWS1MPatnW/1EFkdeVdasy/TcEhmvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=umrVA6RnHLQjyrXs/maatltMz76o5bcDf9OVytBdXFM=;
 b=Al0O07ApWQs+EFnqDJdLsKAL47tixbyu8+WeRU1WudEMFwOMuCwoWeKUZTD7YySgez5p+3yruHBZitiSeMnnMk9oMl4o97USWDVjZKtLpxn/LaxzD4ckRUJ0fIFOFRfEp/c0DH9vyjOcVVH9gX1TqJ3SpUc/qPplED2R8Y2DI+Gs5KBmpK+iP0jOXuYv/q7xJ3SzaUEaqlMTbTIBGbUDEBcEsn+X+UC7m9poGjzk2+TRMkXY0aUarQHuFl7jlqQ/EW0I9bnJMQ99YdejxQDXoqvqhoPi39uinUTBhioTjcddNzQv4yVYZGZEjYrS9YYpiuIQ9ShbRo2P/Lv7vcmuOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=umrVA6RnHLQjyrXs/maatltMz76o5bcDf9OVytBdXFM=;
 b=fKGxrMKnuXO3XcDIjpXgc7ZsZCkaKYecGZln2SH245PDFkTE/dd9VBL6voTwcR7dggJlmX0Uf6JXZhfiMkMdRowA2Q4OuY/FWmrqbBibJEX0WbhX0odUDDwgZSSU+73LJ1sM9N+Yi94CVEPozd7AQ0n5N+gi8Oicvv28+Xnae3k=
Received: from CO2PR04CA0193.namprd04.prod.outlook.com (2603:10b6:104:5::23)
 by BL0PR12MB2372.namprd12.prod.outlook.com (2603:10b6:207:4d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.19; Wed, 21 Apr
 2021 09:01:35 +0000
Received: from CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:5:cafe::aa) by CO2PR04CA0193.outlook.office365.com
 (2603:10b6:104:5::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20 via Frontend
 Transport; Wed, 21 Apr 2021 09:01:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT028.mail.protection.outlook.com (10.13.175.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4065.21 via Frontend Transport; Wed, 21 Apr 2021 09:01:34 +0000
Received: from rsaripalli-Inspiron-5676.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Wed, 21 Apr 2021 04:01:32 -0500
From:   Ramakrishna Saripalli <rsaripal@amd.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>
CC:     <bsd@redhat.com>, <rsaripal@amd.com>
Subject: [PATCH 1/4] x86/cpufeatures: Define feature bits to support mitigation of PSF
Date:   Wed, 21 Apr 2021 04:01:14 -0500
Message-ID: <20210421090117.22315-2-rsaripal@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: fb6747ec-c826-4858-fd76-08d904a4107f
X-MS-TrafficTypeDiagnostic: BL0PR12MB2372:
X-Microsoft-Antispam-PRVS: <BL0PR12MB2372B41AFDAEC52580E8904A9B479@BL0PR12MB2372.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +eLpnBpR0Drl7mIjTHZQcM2qt0QXws3Alw0rKvo9ujr6dY9VlkYiVJ4uheqlJUX+v7Dp0bMBo2jEnUUUd2uKIc5oIDWhGu0s1ZYCkhWMKftIYf9XDHOQqukx5Kf/JNuIf/i25S0LSwcCEOO2g9RqgIfdp+w0B0WRbC2VAkO32PrNYpt0ntwgCtFVYvI5Nf7QNAMiRzHTL8DwwAtrkilp2x20/0RNyBR/1CCEKQOyp3Cog4DX79f7rRxAa3/ftpFO9fjexdbToxSunUiyuXf+KzBC0caR94LmDvEB+XmJ1r0N8Ky6A0PqowJMK+ByucK5sdmTp7FiTDj1L1CS3kDN/sTbv32+/BGLIWYyOF4BNiJiuWix3HOVb0tsZt06zIW8iXD2BAaLKD8pBzrVveDSp1wdWWqOmXV/nqkn1FJhcE/2a1PYwqgWnCSGLuRkpz+H201IsRRqO8zNXVMX9DMdlxJHUzBd/GnVTrqu30L/I9GZPRuRPnEIKbg9A51kZZ3v86GXDDxpoxpuVcPKkFtxs3U2Lj+hsYtarAkHXn13MloBkdIn9hYc4R0WaYsNwT2AIq3/WESEUSgA4xZE8MlWqiAPuMhL8kx7ScciwWzMAP6jmOTNpjTrwz2vyQFEPNwSickC522fzr6WQpKa4/AbK02Q36aK/oqKa+woId535+fPHgnqmiljU+3fW+Aemnuq
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(136003)(39860400002)(346002)(396003)(376002)(36840700001)(46966006)(2906002)(336012)(478600001)(83380400001)(82310400003)(5660300002)(36756003)(70206006)(70586007)(6666004)(82740400003)(1076003)(7696005)(81166007)(47076005)(36860700001)(26005)(356005)(2616005)(186003)(4326008)(8676002)(110136005)(16526019)(8936002)(54906003)(426003)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2021 09:01:34.6007
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb6747ec-c826-4858-fd76-08d904a4107f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2372
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ramakrishna Saripalli <rk.saripalli@amd.com>

Certain AMD processors feature a new technology called Predictive Store
Forwarding (PSF).

PSF is a micro-architectural optimization designed to improve the
performance of code execution by predicting dependencies between
loads and stores.

Incorrect PSF predictions can occur due to two reasons.

- It is possible that the load/store pair may have had dependency for
  a while but the dependency has stopped because the address in the
  load/store pair has changed.

- Second source of incorrect PSF prediction can occur because of an alias
  in the PSF predictor structure stored in the microarchitectural state.
  PSF predictor tracks load/store pair based on portions of instruction
  pointer. It is possible that a load/store pair which does have a
  dependency may be aliased by another load/store pair which does not have
  the same dependency. This can result in incorrect speculation.

  Software may be able to detect this aliasing and perform side-channel
  attacks.

These features are being introduced to support mitigation from these attacks.

All CPUs that implement PSF provide one bit to disable this feature.
If the bit to disable this feature is available, it means that the CPU
implements PSF feature and is therefore vulnerable to PSF risks.

The bits that are introduced

X86_FEATURE_PSFD: CPUID_Fn80000008_EBX[28] ("PSF disable")
	If this bit is 1, CPU implements PSF and PSF mitigation is
	supported.

Signed-off-by: Ramakrishna Saripalli<rk.saripalli@amd.com>
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index cc96e26d69f7..078f46022293 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -309,6 +309,7 @@
 #define X86_FEATURE_AMD_SSBD		(13*32+24) /* "" Speculative Store Bypass Disable */
 #define X86_FEATURE_VIRT_SSBD		(13*32+25) /* Virtualized Speculative Store Bypass Disable */
 #define X86_FEATURE_AMD_SSB_NO		(13*32+26) /* "" Speculative Store Bypass is fixed in hardware. */
+#define X86_FEATURE_PSFD		(13*32+28) /* Predictive Store Forward Disable */
 
 /* Thermal and Power Management Leaf, CPUID level 0x00000006 (EAX), word 14 */
 #define X86_FEATURE_DTHERM		(14*32+ 0) /* Digital Thermal Sensor */
-- 
2.25.1

