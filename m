Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 660183C7CEF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 05:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237774AbhGNDaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 23:30:15 -0400
Received: from mail-mw2nam10on2075.outbound.protection.outlook.com ([40.107.94.75]:12577
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237486AbhGNDaO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 23:30:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FWHwNgxxuFylmCFGFAEtSuUp4myLziNbXYYN0B77R03KGwlDtsSOMQEYLV7tNtC8aw9+1Zip81QLbNCpem4VoCfZfu9GqNHGetN1A6519aPwAwqkVAngIsLn5y+A/a4S81b7CE21m3FpOD3wa5ynNNeftRgwNxdAwgBG+z1PWbO9E8pfNObOHPWfDO8usMhmC9DcxEA3KCG3borqyKPcfizejl8hISmHETlxt7XmvpCK8u8byujbkd2aSXKBwnp8MOYpLXlwJuL9O+/dMfv3fyKx7FOj/dGopZUMNlv2oqP8sd//7hyJ/UgMDgruUhq8jT4soqEmJ5+OyNU706C5og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ovs3+ufsST1Jcf/WTbj+oKuZ43UGzlNlBGZuPKLZ5B8=;
 b=W/8w7+wORp5uDZJUdRNHYjcfZru7332RGw3Ac+Nz7nTKpb5tbUYwWMXpmRvg4jsCCY70j+ah3H3AkCiFxG3Uq4ZldyqDmOyc0+7iVR/2W57n2HRL954s8dIrysBo+0lH2YVc6x+0qCHAy9qjukmKnS/nbkCaZIKTvWVlon1mS7LhruroDFjjD44DXN8VNlIFGSITJZYR/TaMEwsPW4xDBWNfYSx704b/ApPClX6yr/+8n6CBtQmLlXpvLhrLcih9rAdsSW6u8TgBjM5eH3rMLp9Kyxk5H/7PQSHhdlSPNdII4DPRxRZAR44OLjj+iP8wVajKm2ajqyW5dd+PyrAJ5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ovs3+ufsST1Jcf/WTbj+oKuZ43UGzlNlBGZuPKLZ5B8=;
 b=msi+SImoZdbmRuYwk7INwUly7DNgxVTHFkzXtgg0PtYQMhoD/gnBzuOEDZn5ZmINijD0p3GijolsBfng0s4RcWQr0dNI0ufplZQagsll6eiq/S75pBho9jHnmMiMAQVRiAsfHPB6nBco5OfVql7cHZgPEGxnT0kirWG3s44K2jw=
Received: from BN0PR02CA0008.namprd02.prod.outlook.com (2603:10b6:408:e4::13)
 by MN2PR12MB2941.namprd12.prod.outlook.com (2603:10b6:208:a9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.23; Wed, 14 Jul
 2021 03:27:21 +0000
Received: from BN8NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e4:cafe::47) by BN0PR02CA0008.outlook.office365.com
 (2603:10b6:408:e4::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend
 Transport; Wed, 14 Jul 2021 03:27:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT044.mail.protection.outlook.com (10.13.177.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4331.21 via Frontend Transport; Wed, 14 Jul 2021 03:27:21 +0000
Received: from amd-WhiteHaven.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 13 Jul
 2021 22:27:18 -0500
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
Subject: [PATCH] sched/debug: print column titles of show_state_filter()[V2]
Date:   Wed, 14 Jul 2021 08:57:05 +0530
Message-ID: <20210714032705.79726-1-shirish.s@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 83acc3e5-b933-4cf6-8439-08d946774a8e
X-MS-TrafficTypeDiagnostic: MN2PR12MB2941:
X-Microsoft-Antispam-PRVS: <MN2PR12MB29410D5213991C216029B8A4F2139@MN2PR12MB2941.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:494;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RGnW/yvJnRke4kVDvNUsf4vjWQWjT2oB3jFacypm3wP31bG98qsMMV0peZKAv0EGYBoDJGVy7FdVnGoXzrhnZT1mNT4+LmclfbdExhiw4Ot8y08ZrM8qhGVHi+kIhaNSHH1qHVaOZ0UItRnbGTVdhjZlLZuVO0qpFV4iyAkTdq9Tw7DeYUa7bDeXUvchoH9uq36m9hQ5+4p8W3aisdDvJpybvBC552ugU4YwN5XQbyTRYAYWV5kmrXtC0XtsFbboNY81ArZHL2QCLUS1Fvb3M0OtdHHAOk1KVSuyz+Yo+AacQiRUl7Jqy77/onenzeHInz1752o03cdhJPYUBUWJ9MGWxfjheJ5DiYS8EgV7qDwDEUJ4aWTr/J0KesmDWKXcuMxaCCugvMjQHeT9vbt0Cey35rh7YMSnLBAWSkkRzK4eAsXpnuyF3ctZLyWobH+Y+fTcJxu2KvKDidy/aIH0Fs4EWKTCJjs8GXCwYUE2iIReOkVkB4rA114Fc/10zJkALAKqjHJ2fIkPT9FqlTiBXw9bzcEhf7xyK9zL7SesHM20QkNF+OWrQbG8FMCjzHKY9iC2JK8Qm/8rpDwyqM6JENlEh4Mr2bV3DoTwshdid54Ms2NAvhN75vr+gbnccbR7sw0MYjLPrSmBp60QuNaSW71QTm6pIeOcd4gnJiOMSF9oT0ikU2LL0kZm3yyBjdGVEulsm6COGdG0773hXLK/nal1qGsJqIVyoH/1cU8Ro84=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(396003)(376002)(39860400002)(136003)(346002)(36840700001)(46966006)(6666004)(5660300002)(356005)(1076003)(54906003)(110136005)(426003)(82310400003)(4744005)(186003)(36860700001)(4326008)(83380400001)(16526019)(7696005)(26005)(316002)(8676002)(86362001)(36756003)(70206006)(8936002)(81166007)(82740400003)(70586007)(7416002)(2906002)(2616005)(336012)(47076005)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2021 03:27:21.5022
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83acc3e5-b933-4cf6-8439-08d946774a8e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2941
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This addition in the debug output shall improve readablitly..
Its not intuitive for users that the pid printed in last column
is of parent process.

v2: Dropped #ifdef logic

Signed-off-by: Shirish S <shirish.s@amd.com>
Suggested-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/sched/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2d9ff40f4661..22cee4c0f4b1 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8194,6 +8194,9 @@ void show_state_filter(unsigned int state_filter)
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

