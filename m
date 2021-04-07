Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2682356C95
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 14:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352419AbhDGMuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 08:50:19 -0400
Received: from mail-bn8nam11on2073.outbound.protection.outlook.com ([40.107.236.73]:31584
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1343920AbhDGMuP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 08:50:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Km89rdp0K9nEUaCJwSrIMNjriOhYTslxIFzKwQIBjxRRy8aDjVZRQgUaguTdB8MDC0aanzfvOtWUy5vk4QXMb1Jfc7vvn9NEItOj9VrBOW/BlZye/fXKMpdpT5n6fX9NP0lM8WHA4BsSIP79eatsYDzXB/g7GG+3BNmU3w5pMghvyAaOTTkWFwD/GUppzRaSlunJtygzVk8gitlZqBfjCRs3lpplneoiJWUhv4ERXJ6Kpbdd/uSY2hsWs6ojITL5u/I9zfYsuuMeg3SJa2X26N6+pVvWje12CgwrIzDTHsFLlseXBQ1u89ie9r1GPAecYteCt/Eb8qaTqNf6jYSUgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/VrO8xp+i0su5qodG3FinSt7GM9KMgHaQ4EQJCO6+Ys=;
 b=Lr9I3H5AizlaQVpogjiJjz1tEu6ym498Rn/b74+vUg25BlkY8abCa9Awfmf654zVK+sgV83sUc/iJJoA5ZYddtnlJ9kyXCNQ4swYtlUidCuQb4K0IPxDtBIvGpBhzjSkho6Nz+9u18IxvLcs3okmOGECiAWT9CGd5HuQxHZD8fTMX+R4bAu+cARg/8Ty0sQuEyuqP2j7J+SQDca9C7cx12NxpkB6F+I0icN9ZIo4U8As5zcDd3GEcmJrP5LG6/vYyuW/IWM3MxIB4BiW+Y17QRlR/FxgoMR5Tv4+iebSCAmNiJY4mMub28ujiDlevbOt2o+BM6aqUZrC42j+h4olvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/VrO8xp+i0su5qodG3FinSt7GM9KMgHaQ4EQJCO6+Ys=;
 b=ApBIBRX2Ky+lJ7KusZ37/rg0bijcKR89/GQa5RNmGGQQf6SvbDDb8v8zZ0BChp1g8rJ50N8uJCTJNqg+4Osu3hk/y9AsucrLiLjxtgS2sT/I/ramS6wEyiZzoJtWEfPmgesws+YdMdo72b8K6vHmzfiG7b01FBlp7TOgzU2sdVI=
Received: from MWHPR21CA0058.namprd21.prod.outlook.com (2603:10b6:300:db::20)
 by BL0PR12MB2371.namprd12.prod.outlook.com (2603:10b6:207:3e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Wed, 7 Apr
 2021 12:50:04 +0000
Received: from CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:db:cafe::18) by MWHPR21CA0058.outlook.office365.com
 (2603:10b6:300:db::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.4 via Frontend
 Transport; Wed, 7 Apr 2021 12:50:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT041.mail.protection.outlook.com (10.13.174.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4020.17 via Frontend Transport; Wed, 7 Apr 2021 12:50:03 +0000
Received: from rsaripalli-Inspiron-5676.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 7 Apr 2021 07:50:01 -0500
From:   Ramakrishna Saripalli <rsaripal@amd.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>
CC:     <rsaripal@amd.com>
Subject: [PATCH 0/5] Introduce support for PSF mitigation
Date:   Wed, 7 Apr 2021 07:49:48 -0500
Message-ID: <20210407124948.242399-1-rsaripal@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1e8696e3-782f-4c22-1844-08d8f9c3a9a3
X-MS-TrafficTypeDiagnostic: BL0PR12MB2371:
X-Microsoft-Antispam-PRVS: <BL0PR12MB23714F439520AB437F11246B9B759@BL0PR12MB2371.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zDqP7dvrypVHoVo4CxIWCMbsJ+CmWFGlvZfPFfRkOt7x775YioLM4VgG7ekkS+bHdll9my+L/9UWkZvsCZxq+vkW5mjrIz0hB59+jVfh3VmJpN396jysaygHjGim9eHQNju/TigNMk6T7kbR3zAR4YP5oxC5wCnB9U1hX//XrLYQPHC4ceeDnuTK+p4Q/i5sYxO9q9HpkuCHi5QLB3sr7UOx8JNFpgADWlVWiHooWzqWqEyKrDC2ZQyqoVWp+VngbMH62UHzyhnL935ikn0cRxD4VvTx0juljTcpXl2Z5TsfsUWl84IU7mdbWVZaSBoaDlg9zeuPxhf4v1df61ozzqp6emqB+YO1fh0E/Y+RCq9z1UCfcaPKFryWUbVqckZvAs+ZT/XCFZEAgn356jYnUBqpsFHY9pm9O1YH+86qjbhmYzMpuwsBroMi0vl4Bm825as2owQILfMGVd1jv7v3mL42nsYrnaCYMagID94u5neWO+80b4xFkmcgdWsb/NTUg2rCfOZbBQIRUcU/mL8jLDhDjRLbbY1MpYZMEmPS5W6Jdivb1teqcK4x8CNv9+r9hgC4QFdtwry5u/hFu2vfQGLp3k5O9D845/H2fZx9a1o4oyzratTyu2AENJwB+CWPURmcCJTno3P9kiDjArKu7q0XHsGW1+ae+InBppiVLWRFuvG0CjoHqYAQD11t/NmJzOYHXXMBo7BtuzqUCtjUnFJ1dht8DDCesBu+TK/qqMn5kiHh3PXtF393hhwHQjemFQ3fpicbi70qZAwtyvWb7A==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(376002)(136003)(39860400002)(396003)(346002)(36840700001)(46966006)(82310400003)(70586007)(110136005)(36756003)(16526019)(426003)(6666004)(83380400001)(81166007)(966005)(186003)(5660300002)(478600001)(356005)(2906002)(316002)(1076003)(36860700001)(4326008)(26005)(7696005)(2616005)(82740400003)(336012)(47076005)(8676002)(70206006)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2021 12:50:03.0303
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e8696e3-782f-4c22-1844-08d8f9c3a9a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2371
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ramakrishna Saripalli <rk.saripalli@amd.com>

Predictive Store Forwarding:
AMD Zen3 processors feature a new technology called
Predictive Store Forwarding (PSF).

https://www.amd.com/system/files/documents/security-analysis-predictive-store-forwarding.pdf

PSF is a hardware-based micro-architectural optimization designed
to improve the performance of code execution by predicting address
dependencies between loads and stores.

How PSF works:

It is very common for a CPU to execute a load instruction to an address
that was recently written by a store. Modern CPUs implement a technique
known as Store-To-Load-Forwarding (STLF) to improve performance in such
cases. With STLF, data from the store is forwarded directly to the load
without having to wait for it to be written to memory. In a typical CPU,
STLF occurs after the address of both the load and store are calculated
and determined to match.

PSF expands on this by speculating on the relationship between loads and
stores without waiting for the address calculation to complete. With PSF,
the CPU learns over time the relationship between loads and stores.
If STLF typically occurs between a particular store and load, the CPU will
remember this.

In typical code, PSF provides a performance benefit by speculating on
the load result and allowing later instructions to begin execution
sooner than they otherwise would be able to.

Causes of Incorrect PSF:

Incorrect PSF predictions can occur due to two reasons.

First, it is possible that the store/load pair had a dependency for a
while but later stops having a dependency.  This can occur if the address
of either the store or load changes during the execution of the program.

The second source of incorrect PSF predictions can occur if there is an
alias in the PSF predictor structure.  The PSF predictor tracks
store-load pairs based on portions of their RIP. It is possible that a
store-load pair which does have a dependency may alias in the predictor
with another store-load pair which does not.

This can result in incorrect speculation when the second store/load pair
is executed.

Security Analysis:

Previous research has shown that when CPUs speculate on non-architectural
paths it can lead to the potential of side channel attacks.
In particular, programs that implement isolation, also known as
‘sandboxing’, entirely in software may need to be concerned with incorrect
CPU speculation as they can occur due to bad PSF predictions.

Because PSF speculation is limited to the current program context,
the impact of bad PSF speculation is very similar to that of
Speculative Store Bypass (Spectre v4)

Predictive Store Forwarding controls:
There are two hardware control bits which influence the PSF feature:
- MSR 48h bit 2 – Speculative Store Bypass (SSBD)
- MSR 48h bit 7 – Predictive Store Forwarding Disable (PSFD)

The PSF feature is disabled if either of these bits are set.  These bits
are controllable on a per-thread basis in an SMT system. By default, both
SSBD and PSFD are 0 meaning that the speculation features are enabled.

While the SSBD bit disables PSF and speculative store bypass, PSFD only
disables PSF.

PSFD may be desirable for software which is concerned with the
speculative behavior of PSF but desires a smaller performance impact than
setting SSBD.

Support for PSFD is indicated in CPUID Fn8000_0008 EBX[28].
All processors that support PSF will also support PSFD.

Ramakrishna Saripalli (5):
  x86/cpufeatures: Define feature bits to support mitigation of PSF
  x86/speculation: Implement support for PSFD detection and reporting
  x86/speculation: Introduce SPEC_CTRL_MSR bit for PSFD
  x86/speculation: Implement PSF mitigation support
  x86/speculation: Add PSF mitigation kernel parameters

 .../admin-guide/kernel-parameters.txt         |  45 +++++
 arch/x86/include/asm/cpufeatures.h            |   4 +-
 arch/x86/include/asm/msr-index.h              |   2 +
 arch/x86/include/asm/nospec-branch.h          |   8 +
 arch/x86/include/asm/spec-ctrl.h              |  12 ++
 arch/x86/include/asm/thread_info.h            |   2 +
 arch/x86/kernel/cpu/bugs.c                    | 191 ++++++++++++++++++
 arch/x86/kernel/cpu/common.c                  |   6 +
 arch/x86/kernel/process.c                     |  23 +++
 include/linux/sched.h                         |  15 ++
 include/uapi/linux/prctl.h                    |   2 +
 11 files changed, 309 insertions(+), 1 deletion(-)


base-commit: 0e16f466004d7f04296b9676a712a32a12367d1f
-- 
2.25.1

