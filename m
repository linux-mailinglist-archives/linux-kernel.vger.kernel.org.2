Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74D0A36DCA3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 18:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234507AbhD1QEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 12:04:54 -0400
Received: from mail-co1nam11on2070.outbound.protection.outlook.com ([40.107.220.70]:17025
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233027AbhD1QEw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 12:04:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IMhLsY6BZQGPHZlsngbBhnp9jxUA1L4riTxhiZ8BgC3gYTgiHl83v/toRQ2x49HlP8xtiWbHsQJU17C0f/GL1XYZQQ1yAvW9e7Kb2KjEQVey7FZzLM02RfY/gSbLzUGdy0M+ZEorQDNCOwvWgsfN5xyImzNpjXWbmuPcNmf9a4JS8qFDPWU4GlxoMu8QQZ+gDLW5NYldW5xm36AJDjyb4oAm4ncv/rhMyW3zpCN339fUV8+VgMHAy848EaieSjOGUdXivBqwDqXV5nLEPtnsUKAt5ArnjOf66jLkqgeIix/3jIm2+g2jA9kY0gKUJRdUV+Q4o6iUPYkj+CERYQhMXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d8wy6hMAheANJ+sN/HAxmxIwIcVzaMz/SiMzcF8sqRQ=;
 b=Y2kVgtVHoLhOo4bGVTgfyg4XY+NYhWPYz5Odwc8Qta4asXeT20TYgZDXA2PMawWK8427zI8Z5aRdU1XZmk7qgG+JScFXmcrEAS7d/5LpADE1NDFfFV5/CAaAUj9aDbCG1fZuqopClGH2j4rWtpvxC9KLUbvrP6hkPn0m4dM9Nq96k5iOljUqmRXHFjY9phSptqNEuNBQZrb6AHWddcpBHGEKb6SelQoapWtZEpQEP2KEF/7aILGshSRuFaZHwNzbCQmJASU2v1HIusPdjSgE8bB4FQ/Fd8HnVzNieVdwS0s9n7VKvpGCD/N/Vy6lXXNTuXyACBL79dlTwJlmLkpdWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d8wy6hMAheANJ+sN/HAxmxIwIcVzaMz/SiMzcF8sqRQ=;
 b=VH5KzTztNaUBNt0QsY2FLVXBioA0nQ+eNX1B/OCa+HbYa8bPyU8HZqCOX+oOaNOgojQomvFlUVmZpiG6/Nr+sggl7asf+JdvpSvS48ZNoNQaxzuCWad15CJN6JS8UUpkxyme7qY7FHf59XLfkQWJpi2TZO46uHETeyyOGFjCHYM=
Received: from BN0PR03CA0052.namprd03.prod.outlook.com (2603:10b6:408:e7::27)
 by BN7PR12MB2593.namprd12.prod.outlook.com (2603:10b6:408:25::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Wed, 28 Apr
 2021 16:04:03 +0000
Received: from BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e7:cafe::3a) by BN0PR03CA0052.outlook.office365.com
 (2603:10b6:408:e7::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25 via Frontend
 Transport; Wed, 28 Apr 2021 16:04:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT041.mail.protection.outlook.com (10.13.177.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4065.21 via Frontend Transport; Wed, 28 Apr 2021 16:04:03 +0000
Received: from rsaripalli-Inspiron-5676.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Wed, 28 Apr 2021 11:04:02 -0500
From:   Ramakrishna Saripalli <rsaripal@amd.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <hpa@zytor.com>
CC:     <bsd@redhat.com>, <rsaripal@amd.com>
Subject: [v3 0/1] Introduce support for PSF control.
Date:   Wed, 28 Apr 2021 11:03:48 -0500
Message-ID: <20210428160349.158774-1-rsaripal@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e94e2a82-d080-41ac-3e9d-08d90a5f3e4a
X-MS-TrafficTypeDiagnostic: BN7PR12MB2593:
X-Microsoft-Antispam-PRVS: <BN7PR12MB2593A0B4CE3FEA4D435D34ED9B409@BN7PR12MB2593.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sfPv5C94pYuvoIDdA4m5PZj8X6GMR8nPtpIuzc/s6mbBt0MCHMSWCUzjX7ZZ8h5fBDVw7KBsJp+Nu3gfazU5acysw97RuPImcMG6g3sspob/fU/SDN+e+Kin7UvQU8Jtzt/tgPGjUhWYRERWOKA3Qo6aIs8oCP7gSiu/jay4Jmpm2ibtZDD3WhYf3TfyB7sudvLhvzjrFHU7uZXPw5qKRrO+VxhA9A+F79MEI4YNv80ES15IDvFc+slFhZzjxNzv/bype+uph9jOq4JCr7ebQxwl8E4sD7firXxYVMpv+qudyyHJXGBzuVOz/s9antLtOcGmXoBcOrd49NBYMZtsAn/xDeCb1DW9NrwwrF+4ABK2sESyOuBVXQS/GiAmztg/G1sLZw/2EzzTfoOx3FZHxxhTn3r9Mf904dMuPkqBVn/AdNiso3WeTwlFIIYa+Fqv7mObLV0md2SZgZUhrB3RSyPu2lKVxontB95W2RKQd3yOINhcZKuxdyMABeULaDJESXLmTXXPjAKfJHxlmziVsPJNjaEQDOgEAUGFbrwqnNiGHgpHO+PAZuR6Osz8aBhSwC4v0V3eDMVU5eTU7JUasxC57vkgGCON5gxm60LCKpikBJFYmndqEe9onfSNE7EsU0Di31Ael4Aeg+jKRnRWrc0ZwomtB2r+wtl/Cdk1SMLSxCye8FSLmkPHQkpdFoIdft1g12HUs9CiFlka2cjAaCl+EJ8YVx78ESCz02k64iIk6gTSXUz+KHKgKneP9mkbfGy5BKD79Wc/f4SpXhzOsA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(39860400002)(346002)(136003)(376002)(396003)(36840700001)(46966006)(6666004)(82310400003)(2906002)(83380400001)(82740400003)(7696005)(966005)(16526019)(26005)(336012)(47076005)(316002)(36756003)(81166007)(1076003)(426003)(186003)(2616005)(478600001)(4326008)(70206006)(54906003)(70586007)(8936002)(36860700001)(8676002)(5660300002)(110136005)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2021 16:04:03.2420
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e94e2a82-d080-41ac-3e9d-08d90a5f3e4a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2593
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

Testing notes:
- Tested on Milan processor with the following kernel parameters
    - [spec_control_bypass_disable = {off,on}] with 
       [predict_spec_fwd={off,on}]
      and verified SPEC_CTRL_MSR value (0x48) on all CPUs is the same
      and reflects the kernel parameters

      Modified kernel to not set STIBP unconditionally (Bit 1) and 
      verified the SPEC_CTRL_MSR with the same kernel parameters

- Tested on Rome systems (PSF feature is not supported)
    Verified SPEC_CTRL_MSR MSR value on all logical CPUs.

Ramakrishna Saripalli (1):
  x86/cpufeatures: Implement Predictive Store Forwarding control.

 .../admin-guide/kernel-parameters.txt         |  5 +++++
 arch/x86/include/asm/cpufeatures.h            |  1 +
 arch/x86/include/asm/msr-index.h              |  2 ++
 arch/x86/kernel/cpu/amd.c                     | 20 +++++++++++++++++++
 4 files changed, 28 insertions(+)


base-commit: eb4fae8d3b9ed65099eea96665aa4a11e4862ac4
-- 
2.25.1

