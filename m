Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F049A420997
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 12:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232807AbhJDK71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 06:59:27 -0400
Received: from mail-bn7nam10on2059.outbound.protection.outlook.com ([40.107.92.59]:6560
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232773AbhJDK7V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 06:59:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fPFNjTDvb5P/agIuL+N/HniJ2eDAuR/UBhMWSHJi0NPp5jEqWCVHMSnKbSm8ZQJesmJim8/uo1dCf+4d68eKHRB0MGfO/F7EtRyMECw9qTUA1IRH+kHDdtopzeuTdNkMh8hqzyQw/+J8T6RHxr7q7I45JGpfUrIgLNi1bpKm/M62Di6hRL2cB99BYXeUND6MG4dbhkbuKdXIBWo3CMTuvJuF4xgGhLmbli6vFkUprcP+qJWe80Ueqx7EP2u7N32aN0OXr0VdpeoOvlBMSVgxE31Llp5Dx2BQCvASOHeYAe7J73hGtn3CAvSmWQWzgMCey2nPVcoX9URZHBoZWcTgrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4TwAxYNDYLbbWJjlM4JvqouBnMcV5qpivcIeZo3SXtA=;
 b=a/Qz3WBJ0FV1sb9btNM3Ed/HoUiAI7XP73myhunVcbfznk1HIndrmb2jHz3WLIJCiOI6ESz/N8xSK1g64gMKZT2QSMRIabHKCyyJo7TgpWEdCzAeHRK+qXKXtqzdsGgDqWfGZ9GHcQdoTsW1/dGdWLkRYN2xY4TbRPgN/9eCxA1y6qJxRTIFHP/WnOWEpW6IpO2DQfHvm2UtLCwLXkymDE1MDqP/I4qVkBKhlNdPHwWT5wIWTB4lAcYOReLN8mW9MMhAicxDCQe/T8IE1J5HhfmZX2W4tO8wzBvCgX1w2cbL/W6kb+rnr7k0q87MvL8HN5VTXD4DsTSaTyKWrukrqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4TwAxYNDYLbbWJjlM4JvqouBnMcV5qpivcIeZo3SXtA=;
 b=lQF+hxhUS5qXkjK2HwPjXFhVRCqvuKMENtYxhf1KmKOitFBVve3NY0xi9ca+Ypp/cyP0ZAJIPTlnuEtRQqpcZKLOeCFOe4hjkrONVwYoYV0cuplv3rgNEGwsXGWHeZfb8SAUeQeJe5hDMXthrRq/8cL1sUqR0j63oZwfT+8SW64=
Received: from MW4PR04CA0152.namprd04.prod.outlook.com (2603:10b6:303:85::7)
 by CH2PR12MB3880.namprd12.prod.outlook.com (2603:10b6:610:2b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.19; Mon, 4 Oct
 2021 10:57:30 +0000
Received: from CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:85:cafe::27) by MW4PR04CA0152.outlook.office365.com
 (2603:10b6:303:85::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.17 via Frontend
 Transport; Mon, 4 Oct 2021 10:57:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT017.mail.protection.outlook.com (10.13.175.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4566.14 via Frontend Transport; Mon, 4 Oct 2021 10:57:29 +0000
Received: from BLR-5CG1133937.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 4 Oct 2021
 05:57:25 -0500
From:   Bharata B Rao <bharata@amd.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <mingo@redhat.com>, <peterz@infradead.org>, <mgorman@suse.de>,
        <riel@redhat.com>, Bharata B Rao <bharata@amd.com>
Subject: [RFC PATCH 4/4] sched/numa: Don't update mm->numa_next_scan from fault path
Date:   Mon, 4 Oct 2021 16:27:06 +0530
Message-ID: <20211004105706.3669-5-bharata@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211004105706.3669-1-bharata@amd.com>
References: <20211004105706.3669-1-bharata@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f6e42387-9a07-461a-2bba-08d98725c29b
X-MS-TrafficTypeDiagnostic: CH2PR12MB3880:
X-Microsoft-Antispam-PRVS: <CH2PR12MB3880A2C1259360425892D826B0AE9@CH2PR12MB3880.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8FrycPpu4s0+RzoAP2hVFBTKd96JsLGldiSmT5TeU0M6Cz0K8kbirLiXlq7Joa1a3IONpoS4Zf3w7w0QePqZopwRBtNS2anlqj5rozKoHl89kLt5UujpO/SUoxD3k/YUDNoEUNJA8FsLtO6LR7QRDbwpiWGsRcCs5HaoCzAyH0pmWDfHOX+x9AWUkffdwqucbH5Fssil0NPmNFYLSb2nr20Qta9s7CnAWomMciqQRCrhpcNHLFfJ+7zx5T/4ht5O13ayi0D2NYtM3j1Ppef4gN9u4wqN7A6ZF8kOHAdHyefLZPpzDEUkDBpu7XdsV3Jz7xOZfZG6rqBcwpWTRIWFj72H1x+vWSQXCLrrFepf35PbUD1CIsFWo5Fcf6VMRfJ/uVLCx9WDiAaXnt81fsPANgaY8xUlT1AMyAFjO5UCU+aRkdRYdvCEeSfFMHxAzitxH+Y0R2Z12TnzW0ydU72UnqrX3SgzuvfA5ayLHfIJ3dhZyy/+TomW4C5bowpY0LFArdmHaIBQ+Nkzt3AMMO1Yn1ZYObbn43crheZV0Mp8nSCM2zeH5kqIDcXHIm9IjnSFVydMz6HiApnRuvLDYoYuL+HiwEc21fpqBf1cd0/115wNap54krojOKGS8dnEv0gec8cBEdNXZw4Dv81psnmAxNXPeuU2I3YxhN783PLCr3Paq07WfSWCrSQ4wb2JfB1iEDmNr798USScqyZigde+UEfweR7U/D/ZLD6NfrGL3Rs=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(82310400003)(8676002)(83380400001)(8936002)(15650500001)(36860700001)(86362001)(70586007)(5660300002)(36756003)(1076003)(6666004)(316002)(4326008)(81166007)(26005)(336012)(6916009)(54906003)(508600001)(47076005)(2906002)(2616005)(426003)(7696005)(186003)(16526019)(70206006)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2021 10:57:29.6685
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6e42387-9a07-461a-2bba-08d98725c29b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3880
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

p->numa_scan_period is typically scaled up or down from
the fault path and mm->numa_next_scan is updated during
scanning from the task_work context using cmpxchg.

However there is one case where the scan period is increased
in the fault path, but mm->numa_next_scan

 - is immediately updated and
 - updated without using cmpxchg

Both of the above don't seem intended and hence remove
the updation of mm->numa_next_scan from the fault path
Updation should happen from task_work context subsequently.

Signed-off-by: Bharata B Rao <bharata@amd.com>
---
 kernel/sched/fair.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ceadb43e927b..3e420e73e265 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2180,9 +2180,6 @@ static void update_task_scan_period(struct task_struct *p,
 		p->numa_scan_period = min(p->numa_scan_period_max,
 			p->numa_scan_period << 1);
 
-		p->mm->numa_next_scan = jiffies +
-			msecs_to_jiffies(p->numa_scan_period);
-
 		return;
 	}
 
-- 
2.25.1

