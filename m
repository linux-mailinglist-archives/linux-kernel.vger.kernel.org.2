Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8179E3EA63F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 16:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237898AbhHLOKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 10:10:20 -0400
Received: from mail-dm6nam12on2064.outbound.protection.outlook.com ([40.107.243.64]:59497
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235263AbhHLOKS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 10:10:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IedwOr9MbVlhNbXFeTQqRSXI4So5LNc72lrNMt6VWNqvH3zwM2etl+ns1oTZTLbHTBEyjVv3XsV5MMm5SQqp55CtjZhRBXmbwxLym+7pskNGU2XVyCu1yNN6FLGEj8BN5ty4JqL2ONw36NLjqEuWb5X6t04NMRkriD9v0GlqnpjHCv89q2DEMbbxMkwAa2CZlGHey18SfiWc9TeyNSaN61di0WK5dgQAG9zj+tre1kYQcD9gJ8DJU2dxOooiw7LuDbwm+fckriN0GY4DN28gHdv6eb2EyQMfetEOXWRHDR5C/Bd4CDXY6KooqvZqDB2KH52WSPK/4YkuYQNs5E6x3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GfVxD61wTFYE7nHwYd8xx07bdgTsQEMjfyuzp6eEItc=;
 b=SB0WoDXk+kvLB8r9C41n7ouPaRSXX2rQrChIcdkPCJg1QU7jtLSOPcWhsHkjrUYvw3HxuvUnzwWquK7FR2/S7Ki5iENRd8Ow2d1+IRgAPegAEoCK6KB05bIjiR7CzvXcVfUJK0xgzt821qoWJ8Qpng+0acGeknX8uxjkPQnTRzSxq6bZZVbVRy91QoA0mX0pR/CWid38kLzBV/eI840bPG6TWO+9TE7j6fULj7BfJwrj9t2hiJHLgKFZp8LPXwMDpEpqHO6LSOJByQpWoqMFlFziWdlXaqAVANVTbeBglLr2tKS+rFihF/M+ltCUBc/zEZNDMWAlExZ9lLud0VVq9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GfVxD61wTFYE7nHwYd8xx07bdgTsQEMjfyuzp6eEItc=;
 b=qd6SBgoYQqEfY/C8qDGSjDSPyY0cxFiSZ1RhAnsAumXbgmisSxp0VCWp55MLefGGN7luLw6M0/mWlIiVCFOFYPZBMpYJnxsDUaVKjid/h6e2sJhquGqi7GuBNlEsZLOcLj9ja7ryVQfMfFDmv7M8Y2ad5JZTkt0tMJCuQzg/9rk=
Received: from DM5PR19CA0008.namprd19.prod.outlook.com (2603:10b6:3:151::18)
 by BN6PR12MB1506.namprd12.prod.outlook.com (2603:10b6:405:10::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17; Thu, 12 Aug
 2021 14:09:51 +0000
Received: from DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:151:cafe::4) by DM5PR19CA0008.outlook.office365.com
 (2603:10b6:3:151::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.15 via Frontend
 Transport; Thu, 12 Aug 2021 14:09:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT024.mail.protection.outlook.com (10.13.172.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4415.14 via Frontend Transport; Thu, 12 Aug 2021 14:09:50 +0000
Received: from amd-WhiteHaven.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Thu, 12 Aug
 2021 09:09:47 -0500
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
Date:   Thu, 12 Aug 2021 19:39:34 +0530
Message-ID: <20210812140934.87476-1-shirish.s@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e05e9dcf-b620-4f93-ff92-08d95d9ad9d9
X-MS-TrafficTypeDiagnostic: BN6PR12MB1506:
X-Microsoft-Antispam-PRVS: <BN6PR12MB15067AF8D9BCC729B2BD39B9F2F99@BN6PR12MB1506.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:98;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vFOsUC56EO7aW1F1Zu0l7JfSMlL86TztpRp2LuUIKx9hUgc5QtPZf74m5E97GWvzf62irTwdqlA5eoWgOYcRwildar5BDrjGoU87MbklIi75Ujhq4o78k9G3FXmGYVOnCIZqjMI68le6lq+fU5Y00d6n/545+kC6P93OSX8MEdWx+oE9Vj5uO8/a4WH/1cp9Ed8Ee7DOFrpY83pTLCIruEnvRnju2++ZywwWJtuA4He55QfwCCbK+dz/xeRgDxTMnB+1+/UdOsxfYp2V5dAefXJGv/VpQKYzlqrvtZ1J7PlLWlgrPoU9wArKtZBxNumJazrRxpE6+jHjfiYyglXakLAYOt6jr/hHf5vM21ATchY+uWeYkrZ5rBgEIZw0YCrpDupNzq5lFSL1LdIYEN5Uz83yULzQa0WURDNf4Ym8BzJnY+SlAMby/VwYD/wPi2V2pqKaUACACeL4UVVkrUJgZQUuA1pM957eCOuqptxFZfvz1Plv+D48PfZYXZGpNoin5UtoiBuoNapxhPyRQjZ0YCZVqXiI6G+z826Zd7dTjyApfGp59uP670aDgMaXisgPezlny+VEFqqHPt6yw7DqACe8A5Ilqcy9DiQgYsWUlGAYzFXtA+bOs1Dwxd+puLpWwMfVfc7oo76wv1o5Ee4dwPwMIEVhkYUiMrSiUmjHjV8DUrT6s5MUoMZ+WnhhqsdYqK0ktgrdfHeq14Jsy8qes3na6krImGRlab0ggOdWNZ2BGcSat+RSmZP3pzPxeYC+ahlPN21eaLVr4qSZgwqZNw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(396003)(39860400002)(46966006)(36840700001)(81166007)(316002)(83380400001)(36756003)(7696005)(82310400003)(336012)(86362001)(82740400003)(26005)(36860700001)(2906002)(34020700004)(16526019)(47076005)(54906003)(110136005)(2616005)(70206006)(6666004)(8936002)(70586007)(4326008)(356005)(1076003)(186003)(7416002)(478600001)(426003)(8676002)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2021 14:09:50.9935
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e05e9dcf-b620-4f93-ff92-08d95d9ad9d9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1506
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This addition in the debug output shall improve readablitly..
Its not intuitive for users that the pid printed in last column
is of parent process.

Without this patch:
	localhost ~ # dmesg -w &
	localhost ~ # echo w > /proc/sysrq-trigger
	[22148.730225] sysrq: Show Blocked State
	localhost ~ #

With this patch:
	localhost ~ # dmesg -w &
	localhost ~ # echo w > /proc/sysrq-trigger
	[   99.979365] sysrq: Show Blocked State
-->	[   99.983471]   task                        PC stack   pid father
	localhost ~ #

v2: Dropped #ifdef logic
v3: Sample output in commit message

Signed-off-by: Shirish S <shirish.s@amd.com>
Suggested-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/sched/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 20ffcc044134..d9c7014870d5 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8174,6 +8174,9 @@ void show_state_filter(unsigned int state_filter)
 {
 	struct task_struct *g, *p;
 
+	pr_info("  task%*s", BITS_PER_LONG == 32 ? 38 : 46,
+		"PC stack   ppid\n");
+
 	rcu_read_lock();
 	for_each_process_thread(g, p) {
 		/*
-- 
2.17.1

