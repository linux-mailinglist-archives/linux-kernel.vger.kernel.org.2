Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3624420994
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 12:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232730AbhJDK7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 06:59:14 -0400
Received: from mail-dm6nam12on2046.outbound.protection.outlook.com ([40.107.243.46]:53728
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232664AbhJDK7M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 06:59:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g7WJslPUEfdR5uxZCDFt9CsfDnrVwlsW7P/ATvodKLZcLUipLTxCmhfCMTL68/rYEm4l9ghaoKkQg02GaNdinCsgTfiaJTX/Wh3jNozbJ91MibURunzQ9GaTyR9a0bOtH7nytznRqFpS9aGnD2xdoNtkhkLFwE3gQEx/kjg/f3LwOlQdQOqR9lm4LjxENE1toGJrszYY5+m7+q4fq0TUMXD3gxRevAXLu4F8Pu31bAYVS1dJqZsgQKcZd2WEm8x6SXv8thnseRTfuRXR8CXIZ14IFV1sHfuK3ya1om6iMh4k8yuI6m3hTkUlIdVWomtpSuf/mBlTS15sFfXnxoLaIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UOXnQSWEdZ2Vkm6U7LX2ukUZKaDay6cWlWXaNNkkoMA=;
 b=nlunUTzDdnAV7sHoiEfX6AEZUu3Nd0lISYA9TYjbAjCvo/h7zoSDQXBp7ilKqxF/J2jcEkKEYc+QxVatGMF3qXL2onHKYg5unSIMlPz4Bvh2jdSSlZa0OfWFJgLffjtAgh6v894Sbl3JCuTSD40tW3WwwQqwtBugD8dYXH02vfchUdr3flggd4z6fH0ZlMMbMKsKbTZqBKwmssz0AnSjvrnnXenRkMUkp1Z+Wzf0o1bfkV3+4r4WNB2bHpFvtAsKu6Q/PYvSENkvfHp0BQnuKZpHyCBTqLYF2M7jMOIr9A8F0OgumvGKyhXhfvTj4eJ8RoSYvlRvGP5OdEeTwW3EDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UOXnQSWEdZ2Vkm6U7LX2ukUZKaDay6cWlWXaNNkkoMA=;
 b=OCdzu/iyf/bCceG9ETJgHSDarkzI0DzFhV5c9CNuEtS7V02j0Ub5ROIQ6Z3VtBjvJtDVq/M197SGjNUkma7Cvp9zQgprGzVnXPYCMxYB0lhxm2V6Y4+nVCZPaF4YTqv8TD6nKDjG9ek5fH6PwhQtFklm5BDzymjuxT+A0ok+QL8=
Received: from MW3PR05CA0016.namprd05.prod.outlook.com (2603:10b6:303:2b::21)
 by BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.13; Mon, 4 Oct
 2021 10:57:21 +0000
Received: from CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::ce) by MW3PR05CA0016.outlook.office365.com
 (2603:10b6:303:2b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.7 via Frontend
 Transport; Mon, 4 Oct 2021 10:57:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT052.mail.protection.outlook.com (10.13.174.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4566.14 via Frontend Transport; Mon, 4 Oct 2021 10:57:21 +0000
Received: from BLR-5CG1133937.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 4 Oct 2021
 05:57:18 -0500
From:   Bharata B Rao <bharata@amd.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <mingo@redhat.com>, <peterz@infradead.org>, <mgorman@suse.de>,
        <riel@redhat.com>, Bharata B Rao <bharata@amd.com>
Subject: [PATCH 1/4] sched/numa: Replace hard-coded number by a define in numa_task_group()
Date:   Mon, 4 Oct 2021 16:27:03 +0530
Message-ID: <20211004105706.3669-2-bharata@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3d700143-14ab-460e-a234-08d98725bd96
X-MS-TrafficTypeDiagnostic: BL1PR12MB5157:
X-Microsoft-Antispam-PRVS: <BL1PR12MB51574DA5FBCA4D17281D90C2B0AE9@BL1PR12MB5157.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:159;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kSQxSvADGWqtP7PR4bDI+r/jYfID7pgsn7r4WoJqYfAFxBFSHVU3f6/MQ6OIcx4r3J+t+RzUIBCyYE2RfjTRZbgLSUGUDBz4HOSzjN29GyyGz41B9obrzKDRRbjN7zp90LzSVpX8jbnaFs94ULP8ULj1wZE2QN0rcygy070fr9my8ksHCCS+Vh1jAiSp8RV5ivBrfIL7ssfbD5ukLWbOs5Q88BIsLJOwA/ixqm01+Ky/PyDahDLPsDa7k61aXI22+ce+Y+VHqSSQFz8mB/9ZdP/yI28grZpDFcFmTDqnt5yUju+YSW6aDDzqleFd8ZdgUXIFbrm+762qskt6T9FuvPLzLtmQK0conrpcwOdxAf140kmwaWy54ZGFzp87+gIaIgeerH1v/2RWZgrgIE0L5aRJKspmM31QFHg1/8U3m44KduiypHA5wA7rx/uwhUvCpqJl+WaptgrNrdvFmpuQWwTTeevmoxXAHdkE2fn0pkPHEovHuQOD7GOsnMadBYFoWgVP2i4aMUvWwjCNlNXor5yWRVCijn16vKx3VaMFsAdnKA79XtIuodsvJRpFyS6vq24xxpxtJRd/izpRijBpUE7WTq37RKYhq5aJWR7aY6y4gi8TMtx0JGB7kX/XKEykRfdqJ8DbFJZkKEfKp9idxej6MoT2D4IfWeER8XgU2D+SLiVZiYnWExEVLo6z0KUae2IlQ4eUbI1pZwVD6uogxHBlYcSwVRRMzpP0c6yVMiU=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(36756003)(426003)(82310400003)(83380400001)(70206006)(5660300002)(2616005)(336012)(8676002)(26005)(2906002)(36860700001)(47076005)(70586007)(54906003)(6666004)(186003)(1076003)(508600001)(8936002)(4326008)(316002)(7696005)(16526019)(81166007)(4744005)(356005)(86362001)(6916009)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2021 10:57:21.2502
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d700143-14ab-460e-a234-08d98725bd96
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5157
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While allocating group fault stats, task_numa_group()
is using a hard coded number 4. Replace this by
NR_NUMA_HINT_FAULT_STATS.

No functionality change in this commit.

Signed-off-by: Bharata B Rao <bharata@amd.com>
---
 kernel/sched/fair.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ff69f245b939..e8a696fd713d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2481,7 +2481,8 @@ static void task_numa_group(struct task_struct *p, int cpupid, int flags,
 
 	if (unlikely(!deref_curr_numa_group(p))) {
 		unsigned int size = sizeof(struct numa_group) +
-				    4*nr_node_ids*sizeof(unsigned long);
+				    NR_NUMA_HINT_FAULT_STATS *
+				    nr_node_ids * sizeof(unsigned long);
 
 		grp = kzalloc(size, GFP_KERNEL | __GFP_NOWARN);
 		if (!grp)
-- 
2.25.1

