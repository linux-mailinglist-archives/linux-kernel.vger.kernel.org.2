Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F121645384E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 18:08:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237922AbhKPRLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 12:11:21 -0500
Received: from mail-dm6nam12on2063.outbound.protection.outlook.com ([40.107.243.63]:24096
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229509AbhKPRLU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 12:11:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hfU5jTS9pAFROPqo4DG2KzypuCs4tlRoXZ/scPSltYiwdUduWLSnvHLWLQXMf5W9eImGoJm2+ZtIOjwdUtfRAfBcClONteRf8njfDoKDdocIvYcCqrue747VbnkMAQSpgtsokZIxQK++T16DzG7WgcFpMw7jBzIRFgzwnUeqiUCjFy6XhjMn3uf6akGGJTPAwusPZUR8D08CWsuH9LA69BtITk0Cx9Tzmsns839CbJ1pOM6P5m/Ll0Qx0DWUOqzQyU3jtIIyj9RA/UV09f98xpwzEZpLaYrJ0GOEH2r8aCH8resmcgBuLqTWMsCc3fjBg/bqXGKHs6DO4a2DqzJKjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JEMO162HhfUGCoXdZBPA3Uyy5nfZysD5f2v7E1uyNQA=;
 b=XLlEsABIybiBHIVSvNcutec38rT6tN1fJSAtkIZOcX0XLorfz/x2Q/L1ilK3C4eUfp1wqHYrXr83X3c7VYMx+8HoMNLr9gKiz6G36s1GlUqH6rHRmqlBBKzdUU41GIAH7LOqhBClh2D6S46qyQuJFT8TdLeJ8Rv0Q8SzF+mthf/nPNCS6ixJJVF1p44LJXgfjGBe5b4iizEwFcJz1laJRWv0Snn9DjzJbiSv5tu6o8seWX8Gya4hvaXDqkQRpCswOGI09y9VWSDROOFZgHrrp8VIr8GjgffEl/FmYhYvR8aERm3/q5xwQC4Ig0rEQGHmCHZCIBTlEu4cy53IYIIiNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JEMO162HhfUGCoXdZBPA3Uyy5nfZysD5f2v7E1uyNQA=;
 b=g4BlYzM5fLerBlulCvnQOPR/pNo2JIHaUHlWn8kWfZGitsfE6Gt0r0oaVmylrlwCzOEa8wndvFk//n4UauFqzH1GE1lWsAXLFS0tPpmTCHqS7LmzYHxKgz2YTZSNe9MLDwvwE4cUBbSS/xuBJ8bYJCHt9skbXumwPobjupWjYCc=
Received: from DS7PR03CA0206.namprd03.prod.outlook.com (2603:10b6:5:3b6::31)
 by BYAPR12MB3093.namprd12.prod.outlook.com (2603:10b6:a03:dc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.27; Tue, 16 Nov
 2021 17:08:10 +0000
Received: from DM6NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b6:cafe::f2) by DS7PR03CA0206.outlook.office365.com
 (2603:10b6:5:3b6::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend
 Transport; Tue, 16 Nov 2021 17:08:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT045.mail.protection.outlook.com (10.13.173.123) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.15 via Frontend Transport; Tue, 16 Nov 2021 17:08:05 +0000
Received: from fritz.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 16 Nov
 2021 11:08:02 -0600
From:   Kim Phillips <kim.phillips@amd.com>
To:     Borislav Petkov <bp@alien8.de>, Borislav Petkov <bp@suse.de>,
        "Peter Zijlstra" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, <kim.phillips@amd.com>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH] perf/x86/amd: Use faster rdpmc instruction when waiting for overflow
Date:   Tue, 16 Nov 2021 11:07:54 -0600
Message-ID: <20211116170754.76409-1-kim.phillips@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 66598c6a-7214-4312-4a7e-08d9a923a7ac
X-MS-TrafficTypeDiagnostic: BYAPR12MB3093:
X-Microsoft-Antispam-PRVS: <BYAPR12MB30937BCB009F373C208ACB7187999@BYAPR12MB3093.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: smLFsm+HdzMnreX7HES6R/t3deqEHZo9Q+XkmL2ihf107j4RKqlR+PtV+7FVPuTmZcEOrBiHhTvxUWXlWQ1wk1XP8gEik7XAsU0hBAomUG+FSohof/opNBrO5ohKKZi4P3pEIVz+NhmcsI80VH42hcSIn+T118v9EtgINP1BYdkdbRItvi9Gmx1ZAtLuL8SNCug68yd/TSSQa/qOT9dPQIlvdVBJyFIfPZUV1p1jHdy4LQ4jSGunNym/KYgBVELwTpH8SBY2Ln36dSbqLRNB7g3TFCrly/15ABTBrSSCeaKD974YgAMwU9SCMfQ1n1VWsRxliW+2SPnMkO28RVuki0LWlAnRo2CL5eKLWJTjnbZ18gzuk/6tn+kBDk82UC1iDyieboGnxxPt7bLjA5lVoyvVJD5NEd3Byr7rkibqvAqQ2eCAk+R9AchH2MbU7t97Z9YMgYZoAYmKkQmi885wx4sr/qkA6N1sNAj0Zx5QuYxkou8bKd9DrkuJ0iu5GXLLMABAuOtEE7zDpiDcyN052do49zFjOhEkmJDUP0XaCfK4saj1j2smS8nvpvZT0pop4S1yGWqE2rY5EC+W21VXlk82q1iNLi8MNLUTfK7lsBRhgveVTmNS+1ksgYKp07AZ6b+eI6+9Mt0BnzF2bpsh3mWqatNdkTdEWzfCnPzIm2C/r2yziuAA/975Mn8GWaJDTKqgVDFBEu7RsITE1uLqkJYDoTB/NgY0Pa1cAmSoygo=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(110136005)(4744005)(356005)(26005)(2616005)(82310400003)(508600001)(5660300002)(1076003)(2906002)(83380400001)(8936002)(81166007)(86362001)(44832011)(47076005)(6666004)(4326008)(316002)(36860700001)(8676002)(7696005)(70586007)(426003)(7049001)(16526019)(186003)(70206006)(336012)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2021 17:08:05.0642
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66598c6a-7214-4312-4a7e-08d9a923a7ac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3093
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The relatively new amd_pmu_wait_on_overflow uses rdmsr.
Update it to use the faster rdpmc instruction.

Signed-off-by: Kim Phillips <kim.phillips@amd.com>
---
 arch/x86/events/amd/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 9687a8aef01c..c36cb0c6f9e1 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -587,6 +587,8 @@ static void amd_pmu_cpu_dead(int cpu)
 
 static void amd_pmu_wait_on_overflow(int idx)
 {
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	struct hw_perf_event *hwc = &cpuc->events[idx]->hw;
 	unsigned int i;
 	u64 counter;
 
@@ -596,7 +598,7 @@ static void amd_pmu_wait_on_overflow(int idx)
 	 * forever...
 	 */
 	for (i = 0; i < OVERFLOW_WAIT_COUNT; i++) {
-		rdmsrl(x86_pmu_event_addr(idx), counter);
+		rdpmcl(hwc->event_base_rdpmc, counter);
 		if (counter & (1ULL << (x86_pmu.cntval_bits - 1)))
 			break;
 
-- 
2.32.0

