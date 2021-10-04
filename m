Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB540420995
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 12:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232772AbhJDK7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 06:59:17 -0400
Received: from mail-bn1nam07on2070.outbound.protection.outlook.com ([40.107.212.70]:2626
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232741AbhJDK7O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 06:59:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nJKGhqYV9pY2ZOKuuDMM6j+2G+kUE/c7Ti/jFsRH4Dr+hPZlHk5XJJIN2J5Ox6AvY/RjmEhUjcRzU6UBITgtzwQTLtFrIXJgdzkTeaEq7VpnDynW+L8X4v6vzBrXklAXQD2WfgQpjcQwRpan0kR1OdxC7RfiyLr0t42aQMV2xJ+arbLusXiWnDR2SZi6rxLG6GA8V8VxY3yQ+JhUQEYPy9CfAoKI6xR5X09sn+epHHn/YDJ2R1IsydThnhgQfiKhMbAp9EO/Ewj9T4PrSkqCj5aGBdHlxoQX4P+YKaiPTMeZltydowR30zjvPP6itd5yc59ES0svXiNK5HBeb8Tj8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0PNse0Gi/8cPWZge81I4T1tLfFlSXo7BhxXz0pjTLpE=;
 b=AQgI7N8J0jtvPXQ2C1ewo4mGWQsVV7aajkTaxLPmNpf5C/3dnJpTdhNOOwL0ZA11vNtWDTtjuKepf7BSY25Xh3MqMq4d7YlrOV4B1Z3q1FkcdVMpKKZB380YR8neU0oNPh3d3lO6bu2zQj/aUiTn+LRHZB0QjnyJ0X3+XmP5zQrneIx04hwVcsJg+P9QKIeLCTHifvdOCAL03h/gDfD0dA8yQxTlG9Bpnq87GeEaloePJ8alFk2ejrRQ6xJrZIQFaTuHd8xk52PbxFxtnKygi04GX2JjdZRGIPupKfu3K/bKrUjnRsPTpqgztDWYD7n9DdjYTmDpwg0JT8XJflIlQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0PNse0Gi/8cPWZge81I4T1tLfFlSXo7BhxXz0pjTLpE=;
 b=DSGCehK0JsiZgOgyUry5K8NmRbwFzKnN853KLPjv0/N+enki7DkbfA/HKniSL17v0mHt8EZWMzbEjkPTdcjhraT2/wP+saO2L9vc3/7mhawUH4QvzY/nQ64A8cPGlOo64CIXm/UvLE8eVevPplGp4YIpCHWXWKmk7QwRjgsU7tg=
Received: from MW3PR05CA0012.namprd05.prod.outlook.com (2603:10b6:303:2b::17)
 by CO6PR12MB5473.namprd12.prod.outlook.com (2603:10b6:303:13e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Mon, 4 Oct
 2021 10:57:23 +0000
Received: from CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::7b) by MW3PR05CA0012.outlook.office365.com
 (2603:10b6:303:2b::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.9 via Frontend
 Transport; Mon, 4 Oct 2021 10:57:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT052.mail.protection.outlook.com (10.13.174.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4566.14 via Frontend Transport; Mon, 4 Oct 2021 10:57:23 +0000
Received: from BLR-5CG1133937.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 4 Oct 2021
 05:57:20 -0500
From:   Bharata B Rao <bharata@amd.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <mingo@redhat.com>, <peterz@infradead.org>, <mgorman@suse.de>,
        <riel@redhat.com>, Bharata B Rao <bharata@amd.com>
Subject: [PATCH 2/4] sched/numa: Remove the redundant member numa_group::fault_cpus
Date:   Mon, 4 Oct 2021 16:27:04 +0530
Message-ID: <20211004105706.3669-3-bharata@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: c35a6b70-382b-48e2-b323-08d98725bed0
X-MS-TrafficTypeDiagnostic: CO6PR12MB5473:
X-Microsoft-Antispam-PRVS: <CO6PR12MB5473896161845D991F463565B0AE9@CO6PR12MB5473.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:519;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LVHW2t+/WhI7Rm2Czbxj6G99vWwKbg2HzdHtfFZdTZTpeUuZTLti29ldjpY5CBETovVWlQ9Vxc3XnfgCDwXmFa8IllR8kWdOdIw5FdMYxqu9shbxU/60Xd0BEYjjPMjY80MXnr61nQcX0TnR9NOgv5tYz6cioyrM+MFbG9SDBn1F3KwveovfQuGdmxToIStllQn2rhzylU9rczxk1TQUwzsca+e8gPYQOI8sZux+t8ANmS7TVbqWsP03m+eQvPOfK6u7oGLvkMjNs14rax+qXvzYaY2QmN232UTxNX0eSW9qXTFtviGBzmyzGqPijTVl1wsvRVhWIWvAFue2Gmu3gS4HzUxdvGKpC+Zlx19tkuSi0FygDVXCSjUn+9b1VTzDIGC0uvMKgV/AOLXY0Drq0JDJD6Wv3fdnrLdPFGZ6zlccPLCGihVHzN8G6RbgwvRUSgWmEBV/CABbpb356xDJh6kYhquD/Za0shGm1LQrVGsQMHBw/dE5ryZleNjhJQu9hXgkcnx2aOrgv/JmEBWf3lQX6AIpx+hNESOecrPo6ZM/QjN8s4K5y38PSTb2sjMBdc9CjpnM7N1JM1bNhzqnVnufu+YIYtmCUZsVlhsakZwNT6+qLz0aatHShXVeyABJFG0y3sI4PCYOhT4IpYxeB3LszHB7p5KiZewIrh0nJwQ2fWpDQ76/JUOVsiHC2aHRq478Ac/KQy0M3QHiKAPRa32QVo3nVCRF3NpWfawSILg=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(508600001)(4326008)(82310400003)(2616005)(6916009)(81166007)(26005)(1076003)(356005)(336012)(5660300002)(70206006)(70586007)(83380400001)(426003)(86362001)(16526019)(8676002)(8936002)(54906003)(316002)(36860700001)(36756003)(186003)(2906002)(7696005)(47076005)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2021 10:57:23.3074
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c35a6b70-382b-48e2-b323-08d98725bed0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5473
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

numa_group::fault_cpus is actually a pointer to the region
in numa_group::faults[] where NUMA_CPU stats are located.

Remove this redundant member and use numa_group::faults[NUMA_CPU]
directly like it is done for similar per-process numa fault stats.

There is no functionality change due to this commit.

Signed-off-by: Bharata B Rao <bharata@amd.com>
---
 kernel/sched/fair.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e8a696fd713d..3471c8ef0659 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1081,11 +1081,12 @@ struct numa_group {
 	unsigned long total_faults;
 	unsigned long max_faults_cpu;
 	/*
+	 * faults[] array is split into two regions: faults_mem and faults_cpu.
+	 *
 	 * Faults_cpu is used to decide whether memory should move
 	 * towards the CPU. As a consequence, these stats are weighted
 	 * more by CPU use than by memory faults.
 	 */
-	unsigned long *faults_cpu;
 	unsigned long faults[];
 };
 
@@ -1259,8 +1260,8 @@ static inline unsigned long group_faults(struct task_struct *p, int nid)
 
 static inline unsigned long group_faults_cpu(struct numa_group *group, int nid)
 {
-	return group->faults_cpu[task_faults_idx(NUMA_MEM, nid, 0)] +
-		group->faults_cpu[task_faults_idx(NUMA_MEM, nid, 1)];
+	return group->faults[task_faults_idx(NUMA_CPU, nid, 0)] +
+		group->faults[task_faults_idx(NUMA_CPU, nid, 1)];
 }
 
 static inline unsigned long group_faults_priv(struct numa_group *ng)
@@ -2427,7 +2428,7 @@ static void task_numa_placement(struct task_struct *p)
 				 * is at the beginning of the numa_faults array.
 				 */
 				ng->faults[mem_idx] += diff;
-				ng->faults_cpu[mem_idx] += f_diff;
+				ng->faults[cpu_idx] += f_diff;
 				ng->total_faults += diff;
 				group_faults += ng->faults[mem_idx];
 			}
@@ -2493,9 +2494,6 @@ static void task_numa_group(struct task_struct *p, int cpupid, int flags,
 		grp->max_faults_cpu = 0;
 		spin_lock_init(&grp->lock);
 		grp->gid = p->pid;
-		/* Second half of the array tracks nids where faults happen */
-		grp->faults_cpu = grp->faults + NR_NUMA_HINT_FAULT_TYPES *
-						nr_node_ids;
 
 		for (i = 0; i < NR_NUMA_HINT_FAULT_STATS * nr_node_ids; i++)
 			grp->faults[i] = p->numa_faults[i];
-- 
2.25.1

