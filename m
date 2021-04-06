Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2292E35587B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 17:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345994AbhDFPuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 11:50:35 -0400
Received: from mail-mw2nam10on2067.outbound.protection.outlook.com ([40.107.94.67]:5984
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231710AbhDFPue (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 11:50:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JzDnvaScEaGD7we+po8WdjF0N4wtCp0v8/nutYcCaPsxXaK7C7H2csYidZRFzOKydDqq3i0e7SmUY8qWsTwAGfGsFti+ls8usuCz6xWD01MxnVKSovwMXG2ve9vHSpglr2c4CRhZJQ3dnPX3CWGlsb+Y8uR/8Nflih6ySmF+vLjAZ/0I7E4WG0d1p9CWuXEKOKCrRAZ4ulGkLmZRlRaRgDOaFhB9IAgjWX4dKP1dcFBo7ynJFwhRLzunUse1wVtbRtLbPNlZozSbFZUVeNwiRPzqqM4wCXFQ+K+S7sxFTXjwD3qU3w+a/r4KzsfchkghmLhFFRc8pANWzn/FBNkqHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z6um7c7pHjIzsiTciVgK1DNwuElSmKCPSX4+VGrT268=;
 b=IGgXbbok93MAW0VGGCtCOmzzcacZZTcO3lUCZcSpV6xZustgxbIbG0fYhugdZYvAZQyJzLRLwwpDoXfB813IHYbql0ioxj3Gx5MqBPlW5pvoP7krVSwB+dqh26m6xpmPh9EluRBxfTCCJEFM7UL5R9jmIGMyBRZyB/KwxoMNpsINu3nzJsQ2z6kLbitlPm35jg+2OmoTt6eI5coe5NkjWf0aDK7wyWHz0jh359cnWIlJvxH4SqJSdqgyBLjXb3RNF6MkgRMLEpAdsZXM1ji4lxiHVeAj8Rtlmnx7elNrFif46hE5DJNz07OhLT9sMzd7Sk7J9BjzdyujTUEmreeZiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z6um7c7pHjIzsiTciVgK1DNwuElSmKCPSX4+VGrT268=;
 b=e5cagcgHk4lQPTZKa6Wh4GYM/dZJ7c4s5YKbrD7n4++IgN/04+X92oOtsObl9arkfWy2ab1t+gj+V7b55p/CI/cc3/PFTzfbOwS0KgVp0cPLRBxPMD1/sW0yoozdbBx2LTDaEzkYU25dtnU1Xhlt8LD1F0xTZqpgGsmauEuO+IU=
Received: from MWHPR12CA0042.namprd12.prod.outlook.com (2603:10b6:301:2::28)
 by MN2PR12MB3310.namprd12.prod.outlook.com (2603:10b6:208:aa::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.32; Tue, 6 Apr
 2021 15:50:25 +0000
Received: from CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:2:cafe::ca) by MWHPR12CA0042.outlook.office365.com
 (2603:10b6:301:2::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend
 Transport; Tue, 6 Apr 2021 15:50:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT015.mail.protection.outlook.com (10.13.175.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3999.28 via Frontend Transport; Tue, 6 Apr 2021 15:50:24 +0000
Received: from rsaripalli-Inspiron-5676.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 6 Apr 2021 10:50:23 -0500
From:   Ramakrishna Saripalli <rsaripal@amd.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC:     <rsaripal@amd.com>
Subject: [PATCH 0/5] Introduce support for PSF mitigation
Date:   Tue, 6 Apr 2021 10:49:59 -0500
Message-ID: <20210406155004.230790-1-rsaripal@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b73a9b7c-2947-4c6c-5cb3-08d8f913b115
X-MS-TrafficTypeDiagnostic: MN2PR12MB3310:
X-Microsoft-Antispam-PRVS: <MN2PR12MB33107BA65DE198EF5F487DDA9B769@MN2PR12MB3310.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JGKN3qdM6vEcvDvXCPjvAV7AKO4hqG3l92pOr1mWyku115pl64hBNdTPWGJRkbltasN4IYf+PmLx1jNW5TfsRbHmmvbTQNOxYbYx92tHmQZ0pjLsaoQN7HjWtRPzw6hlQOtUg+N9+DdEoUYhrRT3ZsrC1aXP67TrM71/dGITGZ9wOFrCTgw20YzKk/SlQ0MmiMh8mwM0TjF5ZTGgAp0WzKwrsBMVC2e7c0csANsVVRP5YQlpWSqD/+1NoJa30+OLX6H7ypIuOoT6u3BwyZc0N9Y1s+psVQ6zsbslDMb0dEAfowelmVaBegGfROQxXK1olIDvDPtuMp4KiO8RtcEBhvv7HT//AFzFqsfBxWKaLxT61M2W2k0Y2m4ePHAdBWgziG66cKNGW5MiWWBIsVFlRrpDlurf6mZAD552TPj/TeiAUx/Lh31pCVNZYQYyMfLWwfxg7133JPOkARJpjYgnOpI5LnDrc/agskizrjKBMbztrCP+pZ9fyYhpYyxTVnGHXu8daS2CyBBB/W0dLs4GeNZ8Xzfja0JeYmVn69w/Hr5BaYkd0uBo8ujwhhgy7ZXvVyqNhYdNsxXKeEWjhY/Y/WA+U/Mwbjf9XjE9leorvtL32vAqsi4lhZ9E/5v7UQEq/n4SwrsB0Ore9jJvLjya/HqjC7oE2KebVSMmM7X7aeafmXZP5ERE/Smiselv1XB4
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(396003)(136003)(376002)(346002)(39860400002)(36840700001)(46966006)(36756003)(2616005)(110136005)(5660300002)(478600001)(8936002)(7696005)(16526019)(26005)(186003)(82310400003)(70206006)(82740400003)(336012)(316002)(81166007)(1076003)(2906002)(36860700001)(70586007)(83380400001)(4326008)(8676002)(356005)(6666004)(47076005)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2021 15:50:24.1998
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b73a9b7c-2947-4c6c-5cb3-08d8f913b115
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3310
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ramakrishna Saripalli <rk.saripalli@amd.com>

Predictive Store Forwarding:
AMD Zen3 processors feature a new technology called
Predictive Store Forwarding (PSF).

<TODO:Insert link to AMD PSF whitepaper>

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

