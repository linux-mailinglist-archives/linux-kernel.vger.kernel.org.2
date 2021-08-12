Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59AF63EA343
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 13:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236740AbhHLLG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 07:06:26 -0400
Received: from mail-bn8nam11on2084.outbound.protection.outlook.com ([40.107.236.84]:50847
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236724AbhHLLGV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 07:06:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YKOJ0QxcTfZk+elrMchVGBCg5ZuG+HDU2hsS1eJyzze7EI22MjFFfTwIxeMtKEDRZ/FeRZNNWCy1WdJOfYZLWdW2sUUnIEpsR40BH+fX2IUfLZ4VBXiEX/mEp4AhfqML1FVPqBLOQbZu/gHIxsk14nI/sJoDyX3EDAg+Vi263JfhYIXWX6GJe0imcq4D9IZvpYTVmcwpxugfTdd9znYmKqKH4oN+1s//2DtDJCLSs1TxvJyj/RFTVLTVyVSfH3YnDkbUGHClvLwezeMgmUZ5bfd3v8DfoXh6tTJw3UY7ounpteq4FTiZK/9r1kTwYFxmZzP0KOQybRMGOruTFnWFKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zKasV50qbqEEUntPn32BZYY3Xw+97ssBN/VR7RK1qaM=;
 b=g4XnX/3J0P3acTa1bM2Jh5wzMSzaBlvwzHSHiiAMiRA5f+ne3JJSqk2l8WRJgvflG46WftHrwr8XIZUSyj2FHxYVp5Y3hFgKyjabq5XEAij7EaCAFxdLidpYxlXLE2vicVrj/rPLNxLJo/+oaIqrzdRTDN8wrpIVwg1K5vkOVl5YqrMxvr8mIi3XyW7PEjCG6Utkr8lGIiMGi5QpBjJmMbeCcH4KlSI7haDo8D1m5h++vLwdgt9Zc+Hhljp1IKDghM4qwvWdqb6XrdoWlfkqWMsnvBCxMjiUatFHtNFGzoqac1fGm5kDW+CSmf+UNzoEtg+K8GPzun3VviM8OnRvvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zKasV50qbqEEUntPn32BZYY3Xw+97ssBN/VR7RK1qaM=;
 b=NfV3NvAkHcNkVrLJTlKXvZdV+1PHOC7Vul+EHoS7ppcLSDiAl4q738S40a83QWfIIe5/f3pBWjwwma02mjbEZT8k3ZUYqo4DzhQiRpxmzB/yhhfUp/+hII2jssWUJc1GljnRkGDuJSJxU2qIokfHBs1z70q7Kq3ejZmrfhtUTRs=
Received: from MWHPR08CA0041.namprd08.prod.outlook.com (2603:10b6:300:c0::15)
 by MN2PR12MB4336.namprd12.prod.outlook.com (2603:10b6:208:1df::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.15; Thu, 12 Aug
 2021 11:05:54 +0000
Received: from CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:c0:cafe::d9) by MWHPR08CA0041.outlook.office365.com
 (2603:10b6:300:c0::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.13 via Frontend
 Transport; Thu, 12 Aug 2021 11:05:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT068.mail.protection.outlook.com (10.13.175.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4415.16 via Frontend Transport; Thu, 12 Aug 2021 11:05:54 +0000
Received: from amd-WhiteHaven.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Thu, 12 Aug
 2021 06:05:50 -0500
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
Date:   Thu, 12 Aug 2021 16:35:34 +0530
Message-ID: <20210812110534.82349-1-shirish.s@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 29f68e9f-df6f-4a37-7ced-08d95d81276b
X-MS-TrafficTypeDiagnostic: MN2PR12MB4336:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4336C84D85F1B8D299672566F2F99@MN2PR12MB4336.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:98;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U+o31Bf1QeRagWWamcW6dbwvRL2VmumfuOGs0xHYQ/0QH3SvpqY21atbcW1pZjCfidxxQV7Q3J5c1re6zDNXYa6QN/ehT6+P7Kjw1d17VbaUT3b5DrJdwFBsVUFK1BcdAGmu3iBlYsUWAq3SPHtzJmU2/Uo29r/nC2noBGlB5OrpHv/9BdS/1SXAWD+WakQXrcw2WSTIxxvGmPYFgdBUxActISBu8/ToCfnaMygvInUjlZZR9ix7siEuD5eqOoDYVSHnt/ggy+apBptmlY7fGYeiLgtUvjoAujJnRMIMYoMTvLvB6PZBAwbYBrhREsyggGmvKo9UOhPLm+DZLEP90vk6QqxYi+Q8auFfLf0+InjUOa+x9zpgZznOMA7OB8ye1ymDvaNpExpQIGKKtMxZKZ4c5D/l72xZCRDZzLwBWvASC5lo+Ehw59xRQwUMfb1h5pRYgfTUYrlPK10ZDPd/VtMq7UDIFA0suc8IdKGUBAIOa7K/QPoNzCL7f8Y5BM80hdb5ihS5kLAYKOE0FnikQ6Ib4+vd4TWrJBebpyXBoNayDYP8YrsrvLlQR9Ufu1JdsFQ2lgRDsSB7X6E7D00Cfsi3n2NkgV0DcXfezgcWmmaXwDw5xmWh/bH5s8OAQ7NiBeN1wzA2U0rI1n4E7WDiGoUik8QNPLE1+EAS8QzM+spOFJUpe5iDKor7dpQNj5J3t69TkEEpSdkpQ5bNzlHzW+hKh9+vHT5NEWuV/4FHo0J/Leaobv69xCMWwuYQRqnnXwc1oChZ7F9C91czTUQfNw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(346002)(396003)(376002)(39860400002)(136003)(36840700001)(46966006)(336012)(82310400003)(81166007)(1076003)(2616005)(6666004)(83380400001)(70586007)(36756003)(34020700004)(5660300002)(7416002)(2906002)(4326008)(356005)(70206006)(186003)(16526019)(8936002)(82740400003)(110136005)(54906003)(7696005)(8676002)(426003)(316002)(36860700001)(26005)(478600001)(47076005)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2021 11:05:54.1466
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29f68e9f-df6f-4a37-7ced-08d95d81276b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4336
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
index 20ffcc044134..1c7ea3ef5a9f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8174,6 +8174,9 @@ void show_state_filter(unsigned int state_filter)
 {
 	struct task_struct *g, *p;
 
+	pr_info("  task%*s", BITS_PER_LONG == 32 ? 38 : 46,
+		"PC stack   pid father\n");
+
 	rcu_read_lock();
 	for_each_process_thread(g, p) {
 		/*
-- 
2.17.1

