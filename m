Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 719FC3C6F1D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 13:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235761AbhGMLIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 07:08:30 -0400
Received: from mail-bn8nam11on2074.outbound.protection.outlook.com ([40.107.236.74]:38977
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231838AbhGMLI3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 07:08:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ESuLIDOE12V6tQiuk8XvhqPkQHzcnrt6lCrMmz/wXWgvpRvQt8tvlGLOxfVHKToY3R5azuONXH1StVXOhrYKiuCSVyBJSHPYl8zs86XwB6pVy49wTJyDCKXXYFpRZ3xdSW8CXTODvH66g71OcQFx9A4ONoAT85ugP5j6AXo8bgTaOzVuRj1aT/9CXDnCdMzk4wqF302RumJvC1sauIMQAOfuPepR0XvuNQyZK8LpWb7TmDmshYCDddBKSHppWwdlZny8riG9IMMo0UqbGX3IO7AVM4HN4Ka0UbZ0kd+smdodhst8lbxpH0MUmdU5pGslc15rheMBT1tAszpyWEvE3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iDWblUW8p3Epy6k7TpleMS+0XEm3sH932aDgM8KGsOc=;
 b=lFr5l2ie4moMLJygLACBFymZ1UfuoBMPJYlOf3Hg5LTWqnNiSMEsAl6fGFKs+Lecy92vn7B2Q1wUePJlvwukwLcX4uIiBsdbKZ6f+jOgSvanq269tM33qZEFTOWQB4U1SzXtBj/xC8NbPx2UcpXWfN4Uc71vK4T6mTPqsGDP8ReokP8EAjRUpTNs5ijrf7AOoSm/49+b4kUATURNkKHmO9rkwDfVPtNns8nUxqKC92KShFLtypZmlD2HhOZO+8SYYb3cw6VSKUwo8Fcd/adwwdwlR7IBoegubanzH0FwcMTOMU524uHdjBUusSmEcjfAtU5e4XypSqN/VA28EoJ4Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iDWblUW8p3Epy6k7TpleMS+0XEm3sH932aDgM8KGsOc=;
 b=ij5iXxi7hE5YIiYxj6IgUgQX1bVuJn2JLDPYu8wQ4wDAx4xYXdrXUj+Rnhjm0ozB0ayyoL59CVsu4Vz7rC/4URVpxhypPFCBQ0i5zzymxbKEdTNWbrcF/9MuZvHFQu9Q7lAQ15erIUtcDQCHGs9BN0FIMiNNG898V9pBu19/4ww=
Received: from DM5PR10CA0024.namprd10.prod.outlook.com (2603:10b6:4:2::34) by
 CH2PR12MB4859.namprd12.prod.outlook.com (2603:10b6:610:62::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4308.22; Tue, 13 Jul 2021 11:05:37 +0000
Received: from DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:2:cafe::2f) by DM5PR10CA0024.outlook.office365.com
 (2603:10b6:4:2::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend
 Transport; Tue, 13 Jul 2021 11:05:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT008.mail.protection.outlook.com (10.13.172.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4308.20 via Frontend Transport; Tue, 13 Jul 2021 11:05:37 +0000
Received: from amd-WhiteHaven.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 13 Jul
 2021 06:05:33 -0500
From:   Shirish S <shirish.s@amd.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        "Mel Gorman" <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, Shirish S <shirish.s@amd.com>
Subject: [PATCH] sched/debug: print column titles of show_state_filter()
Date:   Tue, 13 Jul 2021 16:35:18 +0530
Message-ID: <20210713110518.52243-1-shirish.s@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 57a0db6f-c845-4d45-1e4c-08d945ee2511
X-MS-TrafficTypeDiagnostic: CH2PR12MB4859:
X-Microsoft-Antispam-PRVS: <CH2PR12MB4859CDD0E49F8F8500A3D067F2149@CH2PR12MB4859.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DyuuJvOpjKZJb3/woUm3rNvwnGpIn2VzDO0EqXC/PpVj12Seo7VUXH3KlJgBzNKCJnS5FzDNg8Sq28+Odm+4+JsLyVUrRd5Bs4Lc4OmGbgJ0qJKBFfN1dvkqXZ38DjM0DSjXhRRTUg9uB2+JbaCXvPhfBPLtvBgXSBrS4w37VFZHulrz7l7gDPyWnCUPqRufQHXQJ0MP6NKUtuLtGRVB5xoyJqbhIB/40dxg833CSEJeXmD+ybCiF+9rHAUmW2u4QXPLbOgJT73GMrdEASBTRR5XBJstT/NcSiZLNmb3CIpjgg0efl9J7jhoZEki1DzCzxD/OJ50AQEj8pN5QXacXhK2ZAtHeh8cNtOx4iCmHO+B2KSfJzSIhLl3VMGOewLc27L6bEs/h1+i1/MlmrCBki54HxOWh3K9sW9JVahNSF087H46/vqmegoxmH8OUlHKz/XsYrRQ+XyTP/CVH9iI8GKvaxKT0kfMr2IenOHja0jZp3FfdHpJ3OvmMF+zZvYRjGTBeEgYZy6UxxG7AOIDMmYJmqwf1bazPMjYmtaVmtoekSAV72NBhmkmvlFJMZbL6YRn4SdMIvxaFd6crFkwzI1hrURm6m2r+Wsj/i1SqQsnD+3elPLqR40XnmhSFYTrxEHOauO5TyS0CsnBZP6edUM4+sHvysr5fUT6ZHIvW16GyMBMOHLlQ16qRXRKPnjahnYKfKKfG5fKETD5srge+QdKDHAmLjRefaCanuftfjk=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(396003)(39860400002)(46966006)(36840700001)(5660300002)(47076005)(8676002)(70586007)(4326008)(4744005)(36756003)(336012)(81166007)(8936002)(70206006)(186003)(356005)(83380400001)(54906003)(110136005)(6666004)(478600001)(426003)(7416002)(16526019)(82310400003)(316002)(26005)(7696005)(36860700001)(1076003)(86362001)(2906002)(2616005)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2021 11:05:37.5068
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57a0db6f-c845-4d45-1e4c-08d945ee2511
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4859
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This addition in the debug output shall improve readablitly..
Its not intuitive for users that the pid printed in last column
is of parent process.

Signed-off-by: Shirish S <shirish.s@amd.com>
---
 kernel/sched/core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2d9ff40f4661..d95d46a89e7e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8194,6 +8194,11 @@ void show_state_filter(unsigned int state_filter)
 {
 	struct task_struct *g, *p;
 
+#if BITS_PER_LONG == 32
+	pr_info("  task                PC stack   pid father\n");
+#else
+	pr_info("  task                        PC stack   pid father\n");
+#endif
 	rcu_read_lock();
 	for_each_process_thread(g, p) {
 		/*
-- 
2.17.1

