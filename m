Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4570B3FB5E2
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 14:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236967AbhH3MSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 08:18:33 -0400
Received: from mail-dm6nam11on2076.outbound.protection.outlook.com ([40.107.223.76]:25089
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236926AbhH3MS2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 08:18:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ep0e/HtT+RrsuybBonwRQBkXjTOJFyrNaCJPCrfDegh+wIpjiNBTyyA+JbkgjhQIAfFAfpAI+lQQHan7J4Sgd61GCPoW6+EiZ+Dw9uoTmfON0nt6YOIDvV4h4mKW3cSp7yQJHdrqeI75tFu4RAuk2UERAPMa1PBW+lKicITaDmESgKlgNu4J9UTY27Q6J+Cgjf7UjmXe5Qzh433mQZOun7uebXFTJcCCJK2ipAadPWyoK2X2m1P6MNgV/i0+RNZQbqCgnuUfBdEduq13ArxNjyq0Y4OXbZDYFyy8mm84XhIl6SwqOKziHBBZmBskomFGKzQcls9Pw8i/7ibGCVhLmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RUKRkq6F7C9gF40itm41ekCRKHZ9Su5VxHNqJ/+nNgI=;
 b=R+ZsXxiJD12VAP74QjPVQoZJ1w/1p5Os/NMq4aeYwfmiTqiadj3zjRtfSLjalxmuiLxiUSk2T/utVwzxZhhlCi/D0hPZngIbSDA3IkTGi9WqnwFdTYg5/LC5SBzz08b/KgEzril42RAU4nhXjuPnYAoh9hvtfQwsGnwhkWacWlLZHNq7steCtU/h/YYdzgQ9K5yuVJ0tdJl0DrHKqVGWBycUyYw7WGjKxF8uFqrGYjrwADyS7SIKx7YdJgx9loNG2lx/rpPvAKnqXcAUl10TjX7r0FMsFAJkiX2SCZWo5DpzeQ1BpqlPhbIHs1UKGIsvIyjFR+gOQ9UWWWV/NWhYaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kvack.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RUKRkq6F7C9gF40itm41ekCRKHZ9Su5VxHNqJ/+nNgI=;
 b=ZuDO4l2uD9e53zw4ekz01EnzUp+xjTMf+acOLAS930Pj5rJ8oXTJBgMo3FhIp5fM+UYd4m3vYWikzeqRmXXaSPIpcUb2cyS+KrKazUMnWWNI+iiWVPBl8IbOd/i25c8lMasuLcwiEE2ge3tj4B6AlEzNxkNOIRn8jokiarO3RII=
Received: from BN6PR1101CA0014.namprd11.prod.outlook.com
 (2603:10b6:405:4a::24) by CH2PR12MB4296.namprd12.prod.outlook.com
 (2603:10b6:610:af::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.19; Mon, 30 Aug
 2021 12:17:30 +0000
Received: from BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:4a:cafe::87) by BN6PR1101CA0014.outlook.office365.com
 (2603:10b6:405:4a::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17 via Frontend
 Transport; Mon, 30 Aug 2021 12:17:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT050.mail.protection.outlook.com (10.13.177.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4457.17 via Frontend Transport; Mon, 30 Aug 2021 12:17:30 +0000
Received: from BLR-5CG1133937.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Mon, 30 Aug
 2021 07:17:26 -0500
From:   Bharata B Rao <bharata@amd.com>
To:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
CC:     <akpm@linux-foundation.org>, <kamezawa.hiroyu@jp.fujitsu.com>,
        <lee.schermerhorn@hp.com>, <mgorman@suse.de>,
        <Krupa.Ramakrishnan@amd.com>, <Sadagopan.Srinivasan@amd.com>,
        Krupa Ramakrishnan <krupa.ramakrishnan@amd.com>,
        Bharata B Rao <bharata@amd.com>
Subject: [FIX PATCH 2/2] mm/page_alloc: Use accumulated load when building node fallback list
Date:   Mon, 30 Aug 2021 17:46:03 +0530
Message-ID: <20210830121603.1081-3-bharata@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: c2b733ee-5c78-4320-d230-08d96bb02398
X-MS-TrafficTypeDiagnostic: CH2PR12MB4296:
X-Microsoft-Antispam-PRVS: <CH2PR12MB429694CA5A19236967B29C46B0CB9@CH2PR12MB4296.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:285;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JKoPbtHIVF9Ejp9ww/UYs5/QUet7Nt2gS1MEd3tlosZB0H/GFrBNpTiBslsttUFKO9MWUP09b6g5tuNySWt5ppFoSl9zZDDwbbdrpLoqDPdVeZBhgzXyrvw7gFkopgg4NcO9SU9Dvk586gXiBsAAIsibfgLOk8z1cV47pMNeV4PqaN8Fsq+Y2GRbgF1YIaQCVo65+BagCZbDwWis7lGvOkW8tvhSuOpvT4FR9oVyE7DkJZLzeD/8tc+iaqng7EgsxmZ2kvUKPUGY4+rTp8U9nNfXVupx9Y/FO8QzKoDtI+qAgiuFJKmd8dj7zIWpTd+2DCWsHLVkKzEBShL0N47GCxmT9+HUTB3ffhuHDbOwJ4T4pN7274eleAm5GT3NwmB0Vd3frffQfFwXZ2Ht57B8hvuJFbu5ErQYNT6ME1FozGfA/tnf4Kx34NjEbQp+avHHA6NsJhMU/y6Setu/AVzEuz7GCd2dSwy0RVqnYNGwCTwHpHuRCFNpKXR/agcFJ271EjUPPL6JMemvsOVD7z6Q6AwOoAuOCqd4/6cl0CN9KK73gUjdCqvgLK9vV0mra/6RQJTAOSqkz22Qx9boHfgW/RG3e4N8VfnhmXZBqKLNQjhnCogApS1DSwJ4ZN9Uqpynjdks28ppxZ8ynDusibFIWiTLamSnb4D/fIbp9O3iO3O4t0dmAP9uOw2YayYbfWudLNOhF/c3TGXkNEGionDNh4DmJlicpN72/xk6XQqIW7rBks3jxsH69lWwlFbd3mcC
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(39860400002)(396003)(346002)(376002)(136003)(46966006)(36840700001)(186003)(83380400001)(426003)(82310400003)(2906002)(16526019)(336012)(26005)(47076005)(6666004)(86362001)(8936002)(2616005)(1076003)(8676002)(7696005)(36756003)(478600001)(70586007)(70206006)(4326008)(5660300002)(54906003)(110136005)(356005)(316002)(36860700001)(81166007)(82740400003)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2021 12:17:30.4850
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2b733ee-5c78-4320-d230-08d96bb02398
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4296
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Krupa Ramakrishnan <krupa.ramakrishnan@amd.com>

In build_zonelists(), when the fallback list is built for the nodes,
the node load gets reinitialized during each iteration. This results
in nodes with same distances occupying the same slot in different
node fallback lists rather than appearing in the intended round-
robin manner. This results in one node getting picked for allocation
more compared to other nodes with the same distance.

As an example, consider a 4 node system with the following distance
matrix.

Node 0  1  2  3
----------------
0    10 12 32 32
1    12 10 32 32
2    32 32 10 12
3    32 32 12 10

For this case, the node fallback list gets built like this:

Node	Fallback list
---------------------
0	0 1 2 3
1	1 0 3 2
2	2 3 0 1
3	3 2 0 1 <-- Unexpected fallback order

In the fallback list for nodes 2 and 3, the nodes 0 and 1
appear in the same order which results in more allocations
getting satisfied from node 0 compared to node 1.

The effect of this on remote memory bandwidth as seen by stream
benchmark is shown below:

Case 1: Bandwidth from cores on nodes 2 & 3 to memory on nodes 0 & 1
	(numactl -m 0,1 ./stream_lowOverhead ... --cores <from 2, 3>)
Case 2: Bandwidth from cores on nodes 0 & 1 to memory on nodes 2 & 3
	(numactl -m 2,3 ./stream_lowOverhead ... --cores <from 0, 1>)

----------------------------------------
		BANDWIDTH (MB/s)
    TEST	Case 1		Case 2
----------------------------------------
    COPY	57479.6		110791.8
   SCALE	55372.9		105685.9
     ADD	50460.6		96734.2
  TRIADD	50397.6		97119.1
----------------------------------------

The bandwidth drop in Case 1 occurs because most of the allocations
get satisfied by node 0 as it appears first in the fallback order
for both nodes 2 and 3.

This can be fixed by accumulating the node load in build_zonelists()
rather than reinitializing it during each iteration. With this the
nodes with the same distance rightly get assigned in the round robin
manner. In fact this was how it was originally until the
commit f0c0b2b808f2 ("change zonelist order: zonelist order selection
logic") dropped the load accumulation and resorted to initializing
the load during each iteration. While zonelist ordering was removed by
commit c9bff3eebc09 ("mm, page_alloc: rip out ZONELIST_ORDER_ZONE"),
the change to the node load accumulation in build_zonelists() remained.
So essentially this patch reverts back to the accumulated node load
logic.

After this fix, the fallback order gets built like this:

Node Fallback list
------------------
0    0 1 2 3
1    1 0 3 2
2    2 3 0 1
3    3 2 1 0 <-- Note the change here

The bandwidth in Case 1 improves and matches Case 2 as shown below.

----------------------------------------
		BANDWIDTH (MB/s)
    TEST	Case 1		Case 2
----------------------------------------
    COPY	110438.9	110107.2
   SCALE	105930.5	105817.5
     ADD	97005.1		96159.8
  TRIADD	97441.5		96757.1
----------------------------------------

The correctness of the fallback list generation has been verified
for the above node configuration where the node 3 starts as
memory-less node and comes up online only during memory hotplug.

[bharata@amd.com: Added changelog, review, test validation]

Fixes: f0c0b2b808f2 ("change zonelist order: zonelist order selection
logic")
Signed-off-by: Krupa Ramakrishnan <krupa.ramakrishnan@amd.com>
Co-developed-by: Sadagopan Srinivasan <Sadagopan.Srinivasan@amd.com>
Signed-off-by: Sadagopan Srinivasan <Sadagopan.Srinivasan@amd.com>
Signed-off-by: Bharata B Rao <bharata@amd.com>
---
 mm/page_alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 22f7ad6ec11c..47f4d160971e 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6268,7 +6268,7 @@ static void build_zonelists(pg_data_t *pgdat)
 		 */
 		if (node_distance(local_node, node) !=
 		    node_distance(local_node, prev_node))
-			node_load[node] = load;
+			node_load[node] += load;
 
 		node_order[nr_nodes++] = node;
 		prev_node = node;
-- 
2.25.1

