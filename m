Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A733D3FB5E0
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 14:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236854AbhH3MSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 08:18:25 -0400
Received: from mail-dm6nam08on2080.outbound.protection.outlook.com ([40.107.102.80]:23373
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230423AbhH3MSX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 08:18:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XcKYcint4q3NkGvgOPZLrgunoQdpZKJMnjA0VO3EgIb6c1IDZ+ZyRQaRmA5NcO429E7j31aDw25SWYNnHIwxFpOVq2ClF1aWs3vSp0aff9/2/6Lo6mqPCvLAt+P0O7n+fbCpr3iOHA4K+NExjMkj20EWgYUR2/MQNE93hnJcmlcqxd68qu8Hah6GXUIUxJjvzVUkaLRGbmLKfWpQDBebOjD6QmAOzuJH6NAUOND9Z4MSap1JXdfOy1WnttVR/JCN1z41v/Skgp+riI9/yd3b9621HFQcy8Ms7LQL5ZIUeF8Ez3RffHLBf8IDdGhtUgzvPnRnt64Pn+Q8nbzFK8i8mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7KkWRmJLc26ex/L1Bl++8XB4VDjVpzxY69ZXX9lL58Q=;
 b=n5g5WDgJgjTCtZGt6sy5tbVs25A37+vW0goZ/l3JyUYuRsvvsQumE/rqz1UsSusL7IMZac3GqJ0QEGyjcmNnZtjKVdPC0KacGQYNta9NEc8uZiq/tPXmNyk5R5aCaOExP3MRF6cAlepjrYHDKWh4OTy9KuJjt9DAxlu23zha/zEiLFuIOib8Rd7nfaVOWn61fP6l4Z09S8wmQIAdhUgnTpsecBPIZDSzaNrU+U6gB7bqEg8t0XD75Ih7svZDIddsja4y5bUfjKK91nvsBoZV88WDKkgt7BBvwXR+ara/qmyJyJjUCoxUl8bHCLgw03vok1mIXn9y8d4fncf37/vRNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kvack.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7KkWRmJLc26ex/L1Bl++8XB4VDjVpzxY69ZXX9lL58Q=;
 b=YlDC7bMnc6yNTOSjZ4BYGQTyrDxR4KIM7Jeb09FBn0p5McQsbUqzgXMhrglEh9kEl6TC2qdrOVXbxKV2prWknNkgQtCdGOAYzCBfatupPuJmgVs32XxyTzWfBWWR4fcyZ5vHwHpqhjH0SAtbdDeHAGL21yWil8ybc6hYLaCiFKQ=
Received: from BN6PR2001CA0038.namprd20.prod.outlook.com
 (2603:10b6:405:16::24) by MN2PR12MB3901.namprd12.prod.outlook.com
 (2603:10b6:208:16c::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.20; Mon, 30 Aug
 2021 12:17:27 +0000
Received: from BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:16:cafe::ce) by BN6PR2001CA0038.outlook.office365.com
 (2603:10b6:405:16::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.20 via Frontend
 Transport; Mon, 30 Aug 2021 12:17:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT032.mail.protection.outlook.com (10.13.177.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4457.17 via Frontend Transport; Mon, 30 Aug 2021 12:17:26 +0000
Received: from BLR-5CG1133937.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Mon, 30 Aug
 2021 07:17:23 -0500
From:   Bharata B Rao <bharata@amd.com>
To:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
CC:     <akpm@linux-foundation.org>, <kamezawa.hiroyu@jp.fujitsu.com>,
        <lee.schermerhorn@hp.com>, <mgorman@suse.de>,
        <Krupa.Ramakrishnan@amd.com>, <Sadagopan.Srinivasan@amd.com>,
        Bharata B Rao <bharata@amd.com>
Subject: [FIX PATCH 1/2] mm/page_alloc: Print node fallback order
Date:   Mon, 30 Aug 2021 17:46:02 +0530
Message-ID: <20210830121603.1081-2-bharata@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210830121603.1081-1-bharata@amd.com>
References: <20210830121603.1081-1-bharata@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 02fa91d7-f892-49bc-6d38-08d96bb02174
X-MS-TrafficTypeDiagnostic: MN2PR12MB3901:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3901243F2419C7A2D1972709B0CB9@MN2PR12MB3901.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ejtZ9jFSY2MFGqQT9tLv4Bx4WPqV56cCk/tJ03t7f7Zb+wh5p3yJY9dBU9yi8drAduhxsncy0gfEjoGAx5XXbIlNCK5yng7ujTWpC+qPp5SyWqquV/JxCxhvJ1evXVJGlLUaOncrNBw7wJJsj6ND9FKvxhInLcV+7NeQHKLh0DIFVVqyUVEDvEp7+CQwCNlEg/TuIA/rN/GXs1vB0TgogAAEqr8x7z5nLdFXHFbEi3oiDgQwxM2/ovwwHO+b4EKZgB9kpMPI2DodxpQCw4YDD46e/DWlbDaqmvQ5ANykYa6Y1wrYBCLszGGWMp2aKeQaKY4LpUGyQQzWfateMwQ80ykr3bPxS0+8hnKNZOLBJJ0PAzM/f0LBw7rcDElR5oyYbFJjukLKLBEJoIyfPgEr6tsfObjiPui/1O+zZYheMG1x7CRCAYHnIhh12Ar9dCHrdWf0pwXdJDBYot6RQvWaCejw4lpVPJGf/boa4hdkGXUN9CkHQJ5mr2OyXT2ym7lvy3G53dUjUGgxfj5DJbrn1fmYiobqA5FMqdrqKfgJ1k3rZQpN8+sdM/k90kAt9w0vuBMAVUdDZoOkJ9GDJKSfXa7nwF21SFluytDEKv+JgLGgHUCkj1P8YSrVuH9yRvGNm44VN0yEwDd/Ea2k0vyreJrH/Zg2JDnqEQHAnhxp4tSm9bV1gnttSdeycJWHGt4KlB732o/kul5xViZObwoYjqRo6FUcEneZuPQyPatpHz+uv05pMdiWDpoBCMhhFbqu
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(136003)(39860400002)(396003)(346002)(376002)(36840700001)(46966006)(186003)(16526019)(4744005)(83380400001)(6666004)(336012)(4326008)(86362001)(2906002)(2616005)(36756003)(7696005)(47076005)(26005)(110136005)(54906003)(82740400003)(1076003)(8676002)(81166007)(478600001)(36860700001)(82310400003)(70586007)(426003)(5660300002)(70206006)(316002)(8936002)(356005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2021 12:17:26.8900
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02fa91d7-f892-49bc-6d38-08d96bb02174
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3901
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Print information message about the allocation fallback order
for each NUMA node during boot.

No functional changes here. This makes it easier to illustrate
the problem in the node fallback list generation, which the
next patch fixes.

Signed-off-by: Bharata B Rao <bharata@amd.com>
---
 mm/page_alloc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index eeb3a9cb36bb..22f7ad6ec11c 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6277,6 +6277,10 @@ static void build_zonelists(pg_data_t *pgdat)
 
 	build_zonelists_in_node_order(pgdat, node_order, nr_nodes);
 	build_thisnode_zonelists(pgdat);
+	pr_info("Fallback order for Node %d: ", local_node);
+	for (node = 0; node < nr_nodes; node++)
+		pr_cont("%d ", node_order[node]);
+	pr_cont("\n");
 }
 
 #ifdef CONFIG_HAVE_MEMORYLESS_NODES
-- 
2.25.1

