Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F221366773
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 11:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237331AbhDUJCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 05:02:10 -0400
Received: from mail-bn7nam10on2057.outbound.protection.outlook.com ([40.107.92.57]:59104
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231354AbhDUJCI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 05:02:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aWIcFEl/faffBSegi/XZj0n2+edKiYKP9qpGJGqiC0ki8ILDbURe0QU5SpvRG9M/zQqk2KhxWGr3XceoDTA2Wg3z6ycBki+cClen65Ag1P3efhATGsrO7sz4Nasi4+/quz4wAdUxfhS/sFx1+YFNJVwgF5aSqEdF3/+6m2VVS5ceYRaokQM+32rQic4/nWZraeuCvFhfYaw7KUysF8wPnXCFkAYySo9IUQHOjv8vMgnI3KsTYtaT6rYUT46CWsMm0CEri7tTwN0G4tgcUYRNKtOwWOYTVCVC+cTAXOnrzp+qGDNG04C0OVbp8ABQgJRmGx1B3DansyazYezgMDvKYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SLn3CuWLqCFnZ2cHIXUEcVPbJYeIujRZKusL13NI5Tk=;
 b=aSPy5VhHCpmZbp68lAxzbs65fNbpO+491wBix2xYNHjs7Dg0e6YpzoW+TqOg3ON1Iqro67D8LU1SFJL5rkn5UoGjqsM8Mw/rJUtxNUl639dDVkhh/Acfl5twT5xLW+hmy6gxUKuA2OoUccMiZeSilJQEYlsGoxZCACg9gqVlZ2kgNTnQCZ9HH2suDXixyxoX8aFGjFGbZckv3437LKJ47dFGU/LkxBeeX/LjF/lOPLSxes4kxbCaNEJ9Nij+QhX2i4NdG1CovwR5XM8lXBGoUJVd70QFmStcCtCTNDBbHB756FSVdpG8dGm4XNRQWOrw2R4j9Jra90wDE38TV2ujUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SLn3CuWLqCFnZ2cHIXUEcVPbJYeIujRZKusL13NI5Tk=;
 b=34rnMeVpqggML/3U0gRrNTtXdglNGfgSzSA/nIlneV/Hrpua3/LBvmXS8tGXavhY35g3cTYbShpXQa+K0JZcUz/LGY+iIx4kqocbGWbwPxR0SGahDggzQbthBG0UspkMy5gjeGwmioHyT36r0X0Xsn5ua/OPxB3o9N4YXdoXvLY=
Received: from CO2PR04CA0183.namprd04.prod.outlook.com (2603:10b6:104:5::13)
 by DM4PR12MB5278.namprd12.prod.outlook.com (2603:10b6:5:39e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Wed, 21 Apr
 2021 09:01:34 +0000
Received: from CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:5:cafe::dc) by CO2PR04CA0183.outlook.office365.com
 (2603:10b6:104:5::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21 via Frontend
 Transport; Wed, 21 Apr 2021 09:01:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT028.mail.protection.outlook.com (10.13.175.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4065.21 via Frontend Transport; Wed, 21 Apr 2021 09:01:33 +0000
Received: from rsaripalli-Inspiron-5676.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Wed, 21 Apr 2021 04:01:31 -0500
From:   Ramakrishna Saripalli <rsaripal@amd.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>
CC:     <bsd@redhat.com>, <rsaripal@amd.com>
Subject: [PATCH 0/4] Introduce support for PSF mitigation
Date:   Wed, 21 Apr 2021 04:01:13 -0500
Message-ID: <20210421090117.22315-1-rsaripal@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 93724daf-7fe8-4f15-02c4-08d904a40fac
X-MS-TrafficTypeDiagnostic: DM4PR12MB5278:
X-Microsoft-Antispam-PRVS: <DM4PR12MB5278E2800621881EEBF5553F9B479@DM4PR12MB5278.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vgLUihl/YUlciC5UNDJgG1P0vJPTtGeozNjfYfYrB72z3D7Zk1kgu6241k51CTJqmMJZVvivB7Abl+N9yyePzWfRKpJFdOgRgzXmMUpW+W57g3934m6naskeAUronMvdFlapSVy7axQxq/D7jhbirQ4dnEztttvqg3mwciE44Pz0wa+73L9euWZoN5210MEjf/jtBzVZ2cIecmk4M4uR0FXHuSm8BCMeZ4PPhzekYPYsMQsFrQDSqi4Z7Gr//2lG9xgJPnRCUcOP5YcQeeh6gUmzjIyZJfDcPkEwlsqkTE/Rqii4rZWzumZHzq962qngQXJRwHoCgtxGehUK1inJ0nFXHGjeDMkAMiyjG9aWsVSvs0FrpZV3ubTaUm9IGu66XlbFChEXb5STAj7PEQj01a7CvZ0qrNJykIV9Vo1sqll+vyxASeRiGRmt40DrTFYJGyN8xFMIYPkhF4/A82sqlXgLnTKMwdG3jOtukLHwM6npQ3JvQ7+a3hyUqgFZF9gnocUM82FCmZQmqosHMON76AUou/ynwpm36c9f3vZ75D5PmxzE0ryHVjvap6X7k/vNsmyUBeCh+PNme2VIsfeWfiHRbPfUdUA1VddZaWXfagyTNofDB8bT3z8B9xQWYVhUx9KxtUDl5q3D9+oKiGorKPLkf87kOI0tn1p5Aq3v82P/3MHVKbNpGTkvFhvY6tiyCm4r2f28Dw7M6MtWUnD6VrgD1c60wdtjSS9NOYJZvPmOduvEFrTSW2zw8wwY4DJDdOgPgvRKtudazhKAptBJdw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(136003)(346002)(396003)(376002)(39860400002)(36840700001)(46966006)(82740400003)(54906003)(83380400001)(26005)(478600001)(110136005)(81166007)(4326008)(5660300002)(356005)(426003)(186003)(8936002)(316002)(2616005)(966005)(336012)(70586007)(8676002)(36756003)(16526019)(2906002)(7696005)(6666004)(47076005)(82310400003)(70206006)(1076003)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2021 09:01:33.2115
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93724daf-7fe8-4f15-02c4-08d904a40fac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5278
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

Ramakrishna Saripalli (4):
  x86/cpufeatures: Define feature bits to support mitigation of PSF
  x86/speculation: Introduce SPEC_CTRL_MSR bit for PSFD
  x86/speculation: Implement PSF mitigation support
  x86/speculation: Add PSF mitigation kernel parameters

 .../admin-guide/kernel-parameters.txt         |  5 +++++
 arch/x86/include/asm/cpufeatures.h            |  1 +
 arch/x86/include/asm/msr-index.h              |  2 ++
 arch/x86/kernel/cpu/amd.c                     | 19 +++++++++++++++++++
 4 files changed, 27 insertions(+)


base-commit: 0e16f466004d7f04296b9676a712a32a12367d1f
-- 
2.25.1

