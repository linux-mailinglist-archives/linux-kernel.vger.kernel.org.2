Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C239366778
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 11:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237847AbhDUJCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 05:02:21 -0400
Received: from mail-dm6nam12on2055.outbound.protection.outlook.com ([40.107.243.55]:41574
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237699AbhDUJCL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 05:02:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZpXav6PBtEY9DUhR4pzXCL1KmzgFixsjlzePBOfioOjU2qeT0FtaV3y+JRztsGs2pv+C9up83Kt5F4LntinTwwSwwBv3xcEn6IKocYVBGhmzfcyIcW7z7xP3D+O2kfXOlr11wS1zadgaiixyY3aay19C8J/JoACtvOfutCE9wPfSuZI4FFMU/DVoXty+bjuYKDK3kMVqoFM5DJpGGcKon2+LEeeGpqRVEenyTnaxe6jLooR/w6YSK1hSVM3aKBmzkFPxCQ+aFsIwXN/JBB6Q40jyyz+M41LNWGykyiOJ9VNHvHo7JgMyscPYEQiWPe+XQJCLCOJ7CAeGro+E+Z48oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DuA1w0t1mxBB2cNbBmjm6Vzp6+qJHiRAVSFcULjBicM=;
 b=i5qMNwhtahBQizj6gNqVbbNRymeS8RNtNTOR2tNRt91iSkDFko0lAzeWHHyfl4TIgh73NEkx6YlFfzSLM7nLxVKPDcMC697HnEWuztqH9RwPkdowpZn2KJWtEpw4MHPJb9gY2mh0iNMWvSY6vxijNYMkS5H5FeKP+m9NmEED2A1UEm9g8rQV83UHtxZ8wDBA8e+aww013/UmYFLiiAcRyjpHD766tKVTUhP/zzl/ppTd6QBpK8lQnsnxPDFo/RmoY6wT4P3ifM/fdsmwUH3ugwRAoMwoM1UpgrdCfPRe1XHsLo6uhh7NQdYQV6JHqlvIqCL5BZGcoocl6xUVdE0v5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DuA1w0t1mxBB2cNbBmjm6Vzp6+qJHiRAVSFcULjBicM=;
 b=3HH2TikspKEC2xoG91IyRNeXqhbVbobQWqeJSwu9mLLb/+lChA1vgnECiT3q/SWkbXYcwl79WL7AiY2IJMjpHtp76GuIqyvCFvMA00AuSE/zvC4RRikqerPZXykEVQEoMJhZD85wq5f92C08dLq7uaeXYj06o3KLSIYwavrx5YQ=
Received: from CO2PR04CA0184.namprd04.prod.outlook.com (2603:10b6:104:5::14)
 by MN2PR12MB3630.namprd12.prod.outlook.com (2603:10b6:208:cc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.22; Wed, 21 Apr
 2021 09:01:36 +0000
Received: from CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:5:cafe::63) by CO2PR04CA0184.outlook.office365.com
 (2603:10b6:104:5::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20 via Frontend
 Transport; Wed, 21 Apr 2021 09:01:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT028.mail.protection.outlook.com (10.13.175.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4065.21 via Frontend Transport; Wed, 21 Apr 2021 09:01:36 +0000
Received: from rsaripalli-Inspiron-5676.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Wed, 21 Apr 2021 04:01:34 -0500
From:   Ramakrishna Saripalli <rsaripal@amd.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>
CC:     <bsd@redhat.com>, <rsaripal@amd.com>
Subject: [PATCH 3/4] x86/speculation: Implement PSF mitigation support
Date:   Wed, 21 Apr 2021 04:01:16 -0500
Message-ID: <20210421090117.22315-4-rsaripal@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3c03ae0f-78a4-4b38-a4fd-08d904a4115e
X-MS-TrafficTypeDiagnostic: MN2PR12MB3630:
X-Microsoft-Antispam-PRVS: <MN2PR12MB363088466E91592E2DE2B8809B479@MN2PR12MB3630.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VwYq+sMNLyHq8lku/eny3bf/HzTfMnBQaWOewITiY8q8uiVfCFHqbZsmTZxYwXdrpJAiEICbmfwNX1mRun4/WZ2AqSHqSvpcEWUEQAfmduFq5P9WVSJnbeBfFYtik1A1YWYVOBzlAFxPTPVcGkUfIWP4GOzGGSq0ruGr24N5cVEnRIANRv+GlxbgYg59w/unRWIUxbGL2RU/dLgHrpOeXndQ/IEn+eUBLJ521uPFoqIRd+ZhAfyHb+F089V8Y4Gorxi38GYbNmSlw0vUvPm3oniOtO/8NzH079A1gze/PrI9ys1fXGT7dnN9aKOgqOw7UThku+9kSyfFZqYhulWoWdupFQHindlyAGI1juBAUT1gJOxHJcHsT0h/2hzocszsFQq2MuP35YMyU6pKEnBcMDbPd3+dRmrZq//DVPENZASoa9evgVdNK96VF5RvUz5S/si2GxBuELNyAgZ0OE6vEpeHGVVsa8U0pHWO1qKANfyG905n7DrjDL3Hvgk36dVrrwj8uynCbuDbsE2Mzgk8cos8tG81S9EkOXq66DVV7D29EWbwZg2dGEEKKQLPGpg/GDU8d//6KviE15SEYn+ret+Gg1NsA4Gdk9wlAE6jcWz1dMqDbCSxyjNJyqtLF02vO01y53OEwu2HTp2a86oSPEf6BkmXNDR4l47QZ1g0zFIx5DptcLhRfNMn58iyZ8xd
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(396003)(346002)(136003)(39860400002)(376002)(36840700001)(46966006)(1076003)(8676002)(110136005)(316002)(47076005)(5660300002)(2616005)(8936002)(83380400001)(4326008)(478600001)(6666004)(70206006)(7696005)(70586007)(82740400003)(54906003)(2906002)(82310400003)(426003)(16526019)(336012)(36860700001)(26005)(186003)(81166007)(36756003)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2021 09:01:36.0599
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c03ae0f-78a4-4b38-a4fd-08d904a4115e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3630
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ramakrishna Saripalli <rk.saripalli@amd.com>

Implement support for PSF mitigation via a kernel parameter.

Kernel parameter predict_store_fwd has the following values

- off. PSF mitigation is enabled which means the feature is disabled.

- on. PSF mitigation is not enabled. This is also the default behavior.

Signed-off-by: Ramakrishna Saripalli<rk.saripalli@amd.com>
---
 arch/x86/kernel/cpu/amd.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 347a956f71ca..88aac52eeb1b 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -1170,3 +1170,22 @@ void set_dr_addr_mask(unsigned long mask, int dr)
 		break;
 	}
 }
+
+static int __init psf_cmdline(char *str)
+{
+	if (!boot_cpu_has(X86_FEATURE_PSFD))
+		return 0;
+
+	if (!str)
+		return -EINVAL;
+
+	if (!strcmp(str, "off")) {
+		x86_spec_ctrl_base |= SPEC_CTRL_PSFD;
+		wrmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);
+		setup_clear_cpu_cap(X86_FEATURE_PSFD);
+	}
+
+	return 0;
+}
+
+early_param("predict_store_fwd", psf_cmdline);
-- 
2.25.1

