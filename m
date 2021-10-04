Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B998C420996
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 12:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232832AbhJDK7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 06:59:23 -0400
Received: from mail-mw2nam12on2043.outbound.protection.outlook.com ([40.107.244.43]:10081
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232777AbhJDK7S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 06:59:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NatBt/bvjtxc8xqyBqVh6JAY9obZhW1/C1xWDAVUeJ59/+aQiAczqJD47LyovD0yYF2kCfubgkuff3sK3mOOG09S6whERg+EBFGB5avrWCcznljsNkekPEbGJOhA7IOWqw0ChuDtvjnhbQvR5P1vUhwfLOKaYNTxfuCPeqdSfbe9fEBWJNJR3Xt9gTMnmUqdPj8WQiHn5VR2R/RX2c23yPHR/yYc8I0LmYjM0X+egFlJTy1xVvsUhbXQgVD6p+snGrD3XIqyKqZbo1nHorGg2Bs5AhdZHzx95CuelpJIo4kwhNepzfyNu87ew9sADUcNaS5FAySjEsfjRR/Tv27IsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a04hBBRal6DbmHCjSOGJLqkR+/dFzclCODhlu8vjvXA=;
 b=dNQ1bQqddmwkPFg+wlY8pGSSTUfbsCP/GXvz+SdpWkmfW6/IyKrKFALBAZise4EOLd8kh17RWKJaCmoBJrKQtl1T1ljhsGX8gbgY+3m2muhTHpBY0e6WIwF0uEQxmLxyzl1CFA1oV7yAcB7PxSuiQ+IvNMQZ2yJmW0TxDIV/sfAAWgP4lrr0SpAo9dJhs3Fz+ORSgz3wUh7OTaVEDHlGwUifgVffHbYUA1n4NPmIL29Ulz6maLgukA04jfCb3Y+dX0VYgd/LeqhbomC0P6xWTsctR+x2igoanlM9zUNcdAmtmGnltGK+JxmJ3RymkSZZUpD+hwY54LZ8Gsfq/M95vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a04hBBRal6DbmHCjSOGJLqkR+/dFzclCODhlu8vjvXA=;
 b=wv/6fm0nGx5b7TZbggMMF447qTfqWzJlbW1R7HVmRTjoUuoyyqMyZ8hvzpnQeMJCo6xW6mh4hK9O8ULrbpW6MfAvsRtNKUJvJWvAzr75rOVVqUt8ERA1z+p3WB6Q0glYlIrZgmJGPKrKlwAVuGlkRtxEDvnQ45aZQADX+FpMG08=
Received: from MW4P221CA0028.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::33)
 by BY5PR12MB4920.namprd12.prod.outlook.com (2603:10b6:a03:1d3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.13; Mon, 4 Oct
 2021 10:57:26 +0000
Received: from CO1NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::d1) by MW4P221CA0028.outlook.office365.com
 (2603:10b6:303:8b::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend
 Transport; Mon, 4 Oct 2021 10:57:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT029.mail.protection.outlook.com (10.13.174.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4566.14 via Frontend Transport; Mon, 4 Oct 2021 10:57:26 +0000
Received: from BLR-5CG1133937.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 4 Oct 2021
 05:57:23 -0500
From:   Bharata B Rao <bharata@amd.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <mingo@redhat.com>, <peterz@infradead.org>, <mgorman@suse.de>,
        <riel@redhat.com>, Bharata B Rao <bharata@amd.com>
Subject: [PATCH 3/4] sched/numa: Fix a few comments
Date:   Mon, 4 Oct 2021 16:27:05 +0530
Message-ID: <20211004105706.3669-4-bharata@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: fa76dba1-2b1b-4263-a046-08d98725c090
X-MS-TrafficTypeDiagnostic: BY5PR12MB4920:
X-Microsoft-Antispam-PRVS: <BY5PR12MB49206CD62DEEFAEFFE820CACB0AE9@BY5PR12MB4920.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uqlewGm0gU7U1JctqVVQ/BJhMyin++zXpKvdILGCg5VA0GFjDm9JY467qUwejUvWDgheYsQs1IdIc2yqtcouGUgyYSOAVGEjdFBbluKCluVyUazldFBA9tdxWDeKkpofgCWSNSHH3F0XUiRyyp8Zqd0lpiBid/oqZ3zScJ/VNZB3ykyepA5vYuUirl6z9cMh8+Vp6jEtSweAIQZWxB0+MiQXppd+35m25F2A0RjXUq80L4glny0DYaQx3X75kGERy6VtdgH4AVL76wi3zgztj0Lyfyu0cgtHBuxWyUgMbR3ZUQw0tOQb35ZJzDcKMiPXjK9sOIAvL4etOh8B+/353n/UzhIzlyoZPg6OqqUopv0Yqd33UFo0SP/MTKw99ScnQkicQYS8wDOkC1aueXITqsVdB/q2DO6SGBkl1v5EvrJVvCoNVbD/vTUCu8IsCab8WhP+aod5Cmp4hXYHxePJwh271wceqgpvGz6vSCJsI/SeCapPY8/TK7bHxVRccrGk84vYt2UE3dkVwx1xN98ww1WGLoxPEerZyyupHtzc237g+cpkiBEhSL3NwPkLhPJvdtmAKe176TDyUUh5yLlZdkCSxj7eIc6ReztQ+srwJlGCMZW/olFbT6TPELStnpISn1Z/lIQI0RSMMGmZt/XvOvuXUTPzn1nnbTqSY3Ylotg34zCsglsiWIwJBHe5CGZ62BY9Q8XWecBvHxl+7iosofo14G3Z7ZbLp+qlnt2H81I=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(426003)(86362001)(81166007)(16526019)(83380400001)(54906003)(26005)(2616005)(508600001)(316002)(47076005)(4326008)(186003)(2906002)(356005)(8936002)(7696005)(36756003)(5660300002)(82310400003)(336012)(70586007)(36860700001)(6666004)(8676002)(70206006)(1076003)(6916009)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2021 10:57:26.2421
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa76dba1-2b1b-4263-a046-08d98725c090
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4920
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a few comments to help understand them better.

Signed-off-by: Bharata B Rao <bharata@amd.com>
---
 kernel/sched/fair.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3471c8ef0659..ceadb43e927b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2117,7 +2117,7 @@ static void numa_migrate_preferred(struct task_struct *p)
 }
 
 /*
- * Find out how many nodes on the workload is actively running on. Do this by
+ * Find out how many nodes the workload is actively running on. Do this by
  * tracking the nodes from which NUMA hinting faults are triggered. This can
  * be different from the set of nodes where the workload's memory is currently
  * located.
@@ -2171,7 +2171,7 @@ static void update_task_scan_period(struct task_struct *p,
 
 	/*
 	 * If there were no record hinting faults then either the task is
-	 * completely idle or all activity is areas that are not of interest
+	 * completely idle or all activity is in areas that are not of interest
 	 * to automatic numa balancing. Related to that, if there were failed
 	 * migration then it implies we are migrating too quickly or the local
 	 * node is overloaded. In either case, scan slower
-- 
2.25.1

