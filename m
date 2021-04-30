Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC36E36FB58
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 15:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbhD3NSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 09:18:39 -0400
Received: from mail-mw2nam12on2085.outbound.protection.outlook.com ([40.107.244.85]:16480
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230020AbhD3NSi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 09:18:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=it3EiCwvYu4b3s40Obt7s4r8g2h3vISZbkD0ZtgOxOBtNuLbJyhz5DtJP31KK+mz5tvJNKg+MKiuoOqGxDiq5knkV0R5NJdJKhZUx+5vuJvVkoqkCCO1bgrjAkmyn5HTNw5wFvRfmVcIpkqOemtBkjAlYMP5rrBQVaBmYBxk2kUDeo6+YBtsJSfB6TZHxdEDzHJ5pQGdr9XdHSL8taDDxJHonMleI9ko3MQG/+WUede8jenr5oV/mtEDO1zqP+H1H/maZNXA6A6J7XDGUpMq3y/MAmOMHIDFJtt4Pq5Xi+/fU4AIVNm6+s01b5pgkrWrznzLlpGz0sVXhgMsqnOidw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dl8dHxADWCvprDQ9KpcRDxvGR+0tQskyBGXM/xqB7Ug=;
 b=fWYzAbZyNefVMeXBLBQz6Q9JqrbK7wJzoiOPPPVDaPer9KZFQM3zaFtoiDGzHKQ9w8cqp9CUC8cwC+6O7xvGWgJcrH2nxa+rFL1UZZFsX1b2QN6j7XRnmcjHFgb+CuzdVMRp/LMwYILlOqRz/3RoMzu4Fify8zLWK1XWhfD8TR40o9Gvux+mpnh3pAHeyxQ78pkT/OvE/cKUL3H/yo5DglXH9tVaH4vamDJVaIHHE9aTtMVHPNw6YhgY6UtkqtHRic4Cgmt4OrEMBHThulxYsm3MlbIwu8XVlBvsmWyzkfMarSKzD502RVd5A9uXDnFF1G41kaRdU05CNsgngmP6GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dl8dHxADWCvprDQ9KpcRDxvGR+0tQskyBGXM/xqB7Ug=;
 b=toKa1h+h1W0XbKY4dYP1fnIVueZbONifAzkZGP7rZUfqowJ7vjr5E28CZCrNrU8NRTapdg4ptbgHWiT8a2ivdvPNdy5kjYCXKeMAh7Tmmy8MJkCUPLvMgGiS/D8f9Jx9CMpPswXvcrZhHMvjuR/4rocE8qnueY4F3ud12srATbw=
Received: from MW2PR2101CA0025.namprd21.prod.outlook.com (2603:10b6:302:1::38)
 by BN9PR12MB5161.namprd12.prod.outlook.com (2603:10b6:408:11a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Fri, 30 Apr
 2021 13:17:47 +0000
Received: from CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:302:1:cafe::bd) by MW2PR2101CA0025.outlook.office365.com
 (2603:10b6:302:1::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.2 via Frontend
 Transport; Fri, 30 Apr 2021 13:17:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT043.mail.protection.outlook.com (10.13.174.193) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4087.27 via Frontend Transport; Fri, 30 Apr 2021 13:17:47 +0000
Received: from rsaripalli-Inspiron-5676.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Fri, 30 Apr 2021 08:17:45 -0500
From:   Ramakrishna Saripalli <rsaripal@amd.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <hpa@zytor.com>
CC:     <bsd@redhat.com>, <rsaripal@amd.com>
Subject: [PATCH v4 0/1] Introduce support for PSF control.
Date:   Fri, 30 Apr 2021 08:17:32 -0500
Message-ID: <20210430131733.192414-1-rsaripal@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2381a98d-d82c-4b1e-0ede-08d90bda58ff
X-MS-TrafficTypeDiagnostic: BN9PR12MB5161:
X-Microsoft-Antispam-PRVS: <BN9PR12MB5161C96D284162536DCE49859B5E9@BN9PR12MB5161.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vi7ZewzQLGU4KEaMcWEKD0nYErfmSNe0DtCBwVR7wM0LUh3X+G+GIDtiXqpCjsgLQPWtUDKOHvrzxdAC2i5DW8S0KRRIxqVdbSD2xkIQYI09DIZixxihDYZN+1plTDC5soMZa+SBDsB/3rHZb0iyvuA/3PgbI3ZHzZjVrNyChKtstULgc8fMmUnsPDfib3A3RlGK6w2WE/dN5HfbQxrShRKhCK8zi/fQtm7Ek5qD+po24AJ1iIyG+9Jo6rbVaRE+siHJ6FMEra6UJmGhi16YJ3uIGCjGyksEKoZfhxVhh7dHj2t9+ne88Pol31sgJbX3J775bQiFk7RfYyXlLFDgVoNOIPAVDb0qyKjlhhzHP9zMj1Ct+J9EARpvZU+MqCZMZ6X/oYvTwMhwsaLfNyqUZ0AucWe3EDY9hKfuoeDV8D+os1LnR2MeJ/SS1wAu/fSYaCrHXtXsotyNkGHnTbvZePheyLsOcaeHgh8TNl84BYfhk7czW6QY55MGGwQIKbaJhvaT9M7HHj/9ka7UfKNoFkzN5OUjU/IS2A6BAnATqfZCUmHetMp6GqsyYmbyuKITlJLrvGmKeNBUDd2E220eUNH+TZ/N2DQ6gdDVEkl/yAVasVXUFkALhjJqTgR23gky9OA0yKtncTTdvDGroFARG6uO/+hZhHU4SfH4hKCFSSu0thSeWfPplvz8i8lunilHtJ33qoba4g8/ZkWPPewbwp87vY9DQvYX8u7DiUgIh3dp01w5QOMwiLx2G0iDVgzExNhUdYWmqVOLCSea6D3Avg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(396003)(136003)(376002)(39860400002)(346002)(46966006)(36840700001)(356005)(8676002)(83380400001)(81166007)(7696005)(82740400003)(336012)(16526019)(54906003)(36860700001)(426003)(2616005)(110136005)(36756003)(47076005)(6666004)(5660300002)(186003)(2906002)(8936002)(478600001)(4326008)(26005)(82310400003)(966005)(70206006)(1076003)(316002)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2021 13:17:47.1933
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2381a98d-d82c-4b1e-0ede-08d90bda58ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5161
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
      
      Disabled all features that write to MSR_IA32_SPEC_CTRL and toggled
      predict_store_fwd. Verified MSR_IA32_SPEC_CTRL and x86_spec_ctrl_base
      are set properly

- Tested on Rome systems (PSF feature is not supported)
    Verified SPEC_CTRL_MSR MSR value on all logical CPUs.

ChangeLogs:
    V4->V3:
     	  Write to MSR_IA32_SPEC_CTRL properly
     	     Read MSR, modify PSFD bit based on kernel parameter and
     	     write back to MSR.
     	     
	     Changes made in psf_cmdline() and check_bugs().
    V3->V2:
          Set the X86_FEATURE_SPEC_CTRL_MSR cap in boot cpu caps.
          Fix kernel documentation for the kernel parameter.
          Rename PSF to a control instead of mitigation.

    V1->V2:
        - Smashed multiple commits into one commit.
        - Rename PSF to a control instead of mitigation.

    V1:
        - Initial patchset.
        - Kernel parameter controls enable and disable of PSF.

Ramakrishna Saripalli (1):
  x86/cpufeatures: Implement Predictive Store Forwarding control.

 .../admin-guide/kernel-parameters.txt         |  5 ++++
 arch/x86/include/asm/cpufeatures.h            |  1 +
 arch/x86/include/asm/msr-index.h              |  2 ++
 arch/x86/kernel/cpu/amd.c                     | 23 +++++++++++++++++++
 arch/x86/kernel/cpu/bugs.c                    |  6 ++++-
 5 files changed, 36 insertions(+), 1 deletion(-)


base-commit: 0e16f466004d7f04296b9676a712a32a12367d1f
-- 
2.25.1

