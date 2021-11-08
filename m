Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0BEA4480B4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 15:01:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240160AbhKHODn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 09:03:43 -0500
Received: from mail-bn8nam11on2083.outbound.protection.outlook.com ([40.107.236.83]:10400
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235902AbhKHODm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 09:03:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K3Ll3DbVHOZGJMWx8M4qD8az3T8qZIkkMdLUBspqSD9Bvx1jgDJgktIMCrkqQ7yBI+7WQXZ6mjCnK84ZhLZhfalHT4jQnDL2TUvVXl6y/YgxqgSutvcgQidFgsOLt6QU5cftfsymZWRcvtxl1aLd5UYItdKvGG8KFvpzKxsywPY03oyKTakB4FHlYOqTvFMR3zZY63ueKzYsXcBy45gufH08foNPQ8G9FPq9fARRXPTPmw+Pa+7/+9p4KBoHxKTiLOvYdVB4ma6JQwbzbHS8XMDUapbp4NCbQn4lutEdwJkAVciPI/+WkrU85Psgq4RsJFkpv4SmZpiFAwO75FxAOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6BXd8/eh2BE0zSJlU14zD6i3wpm0sYlv1mr5fEUIgDE=;
 b=LuId4n0/W/3pPVxwQe/+aCCd+nVwmp+fu19PlBaIExvh2hy8aULPPQXIf3U5k/YFLTXNnyR24lASAQJW2CziUDO307Et4V1/dQG8WXJd8w3O1w8AqGgMWBmyNjrKUblaS1VmdWG2xlLOoqTAw2s2S4Rl6AdcD6JastDAZV+s3FwXtGUm5cc9qcrpCTvVBJbqkA8odmL7dxw7juUVzdH7SNgIhOXDt8FWEGpIcljDYRJsTeximoG1xecARkQceKe7YtGVZmxIQ8EZeR9JTYzmdzRrZZzPCarpo2y+leYE0OQRibUT1TDNdMgezf1l1Aq3yvjESM/G0tYUH+xQFWVwTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kvack.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6BXd8/eh2BE0zSJlU14zD6i3wpm0sYlv1mr5fEUIgDE=;
 b=Dvxn/ZaSsRoIIZEpVhBsI9167uaJhuWjhLnBN9D8ja8A1E+3pbrpTaCTRVjDOMFHLDmEkSbLb7ERfB/pIj6CtVyThGgiMNiudtuHHCeeRjkN/657/IyfaW/nKOb2ELiF0wAuvDZ8omekfXUvcfpezW83JReZNpWY16yLZo5usyg=
Received: from MW4PR03CA0212.namprd03.prod.outlook.com (2603:10b6:303:b9::7)
 by CH0PR12MB5185.namprd12.prod.outlook.com (2603:10b6:610:b8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Mon, 8 Nov
 2021 14:00:49 +0000
Received: from CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b9:cafe::10) by MW4PR03CA0212.outlook.office365.com
 (2603:10b6:303:b9::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend
 Transport; Mon, 8 Nov 2021 14:00:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT044.mail.protection.outlook.com (10.13.175.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4669.10 via Frontend Transport; Mon, 8 Nov 2021 14:00:48 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 8 Nov 2021
 08:00:45 -0600
From:   Lang Yu <lang.yu@amd.com>
To:     <linux-mm@kvack.org>, David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>
CC:     <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lang Yu <lang.yu@amd.com>
Subject: [PATCH v2] mm/kmemleak: Avoid scanning potential huge holes
Date:   Mon, 8 Nov 2021 22:00:29 +0800
Message-ID: <20211108140029.721144-1-lang.yu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a98439d-5299-492b-e61d-08d9a2c02ae4
X-MS-TrafficTypeDiagnostic: CH0PR12MB5185:
X-Microsoft-Antispam-PRVS: <CH0PR12MB5185B7EFDC2DAD2CF8939B0DFB919@CH0PR12MB5185.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Tb3YOZlzLyJtMCPcpxOzCk7fWvFcltefBq4idSvXMCfg40ezHPglVnXsK4uOj8FtLr8L34TTRxJAwl1CK9iWHwJ686jz5dJItmpvUpxldvHLsbv9EMC0KTfsVGObkkv0yOid3Jxzq3KZgchnD8iSazhu1SKpFypdCmIMx4MX1bWe10dgSWMyEmT6NP3xZZwGoxyarIA/lCuv0kDiwMKAiBQHy5UqPPlMPNrCGodyQNrfKa0C7+JVSJa5Pc+Bb0rADmL2K/ZmQtIBHsMBgwYcnP3kBbysuOFUZsHlkTFbGRCSUE3ad6UQHQE2TvIPL/5HnqqRC8us44pUXDmKZh+Q27fqfPjOIBMo5KCLkK2NBc+0nRe9JztWRhCRI7y7nbw7sJrQlY1l4SMGcOZqRvci+nKjeMBJLcJQfgpH/Lg09d0MNskn0vwNQl+0DrPRfZIrAtbTVR+lp2Pz+15SIy5eDlM+m3Hzqtq4yZKw15t50QEIMhKgpVRL1uSxuDCQveZ9MPxTwnOsHmO7dq6IaAcQEoLFy38/rYCyO5s+kIMTmkrOKmNwIhGyh6OqTh9W1VOEFeS4LBaaOoOGzGRhJUllAJIBbcjboHDxd/Kue9BhHNV//Csx4o3wIREvMjMflJqXGMsihIndPVoyi2+pSd4udEcvdYHwppUWIx67f9JxUguBkXbg0PLAwrYR93ShWlS8s+lPQVaUrJP9KN31HTKlcnuJfjzDW5bEdWNH6mnjIZmSWJE7UrNjDUG3kLt/dxt/Yu3JIv1n0vkJlGsLSRxcEw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(47076005)(8676002)(36756003)(8936002)(110136005)(2906002)(2616005)(44832011)(4326008)(83380400001)(81166007)(54906003)(316002)(7696005)(356005)(70586007)(26005)(186003)(508600001)(426003)(70206006)(336012)(16526019)(86362001)(5660300002)(36860700001)(82310400003)(1076003)(6666004)(14583001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2021 14:00:48.5041
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a98439d-5299-492b-e61d-08d9a2c02ae4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5185
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using devm_request_free_mem_region() and devm_memremap_pages()
to add ZONE_DEVICE memory, if requested free mem region's end pfn
were huge(e.g., 0x400000000), the node_end_pfn() will be also huge
(see move_pfn_range_to_zone()). Thus it creates a huge hole between
node_start_pfn() and node_end_pfn().

We found on some AMD APUs, amdkfd requested such a free mem region
and created a huge hole. In such a case, following code snippet was
just doing busy test_bit() looping on the huge hole.

for (pfn = start_pfn; pfn < end_pfn; pfn++) {
	struct page *page = pfn_to_online_page(pfn);
		if (!page)
			continue;
	...
}

So we got a soft lockup:

watchdog: BUG: soft lockup - CPU#6 stuck for 26s! [bash:1221]
CPU: 6 PID: 1221 Comm: bash Not tainted 5.15.0-custom #1
RIP: 0010:pfn_to_online_page+0x5/0xd0
Call Trace:
  ? kmemleak_scan+0x16a/0x440
  kmemleak_write+0x306/0x3a0
  ? common_file_perm+0x72/0x170
  full_proxy_write+0x5c/0x90
  vfs_write+0xb9/0x260
  ksys_write+0x67/0xe0
  __x64_sys_write+0x1a/0x20
  do_syscall_64+0x3b/0xc0
  entry_SYSCALL_64_after_hwframe+0x44/0xae

I did some tests with the patch.

(1) amdgpu module unloaded

before the patch:

real    0m0.976s
user    0m0.000s
sys     0m0.968s

after the patch:

real    0m0.981s
user    0m0.000s
sys     0m0.973s

(2) amdgpu module loaded

before the patch:

real    0m35.365s
user    0m0.000s
sys     0m35.354s

after the patch:

real    0m1.049s
user    0m0.000s
sys     0m1.042s

v2:
- Only scan pages belonging to the zone.(David Hildenbrand)
- Use __maybe_unused to make compilers happy.

Signed-off-by: Lang Yu <lang.yu@amd.com>
---
 mm/kmemleak.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index b57383c17cf6..adbe5aa01184 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -1403,7 +1403,8 @@ static void kmemleak_scan(void)
 {
 	unsigned long flags;
 	struct kmemleak_object *object;
-	int i;
+	struct zone *zone;
+	int __maybe_unused i;
 	int new_leaks = 0;
 
 	jiffies_last_scan = jiffies;
@@ -1443,9 +1444,9 @@ static void kmemleak_scan(void)
 	 * Struct page scanning for each node.
 	 */
 	get_online_mems();
-	for_each_online_node(i) {
-		unsigned long start_pfn = node_start_pfn(i);
-		unsigned long end_pfn = node_end_pfn(i);
+	for_each_populated_zone(zone) {
+		unsigned long start_pfn = zone->zone_start_pfn;
+		unsigned long end_pfn = zone_end_pfn(zone);
 		unsigned long pfn;
 
 		for (pfn = start_pfn; pfn < end_pfn; pfn++) {
@@ -1454,8 +1455,8 @@ static void kmemleak_scan(void)
 			if (!page)
 				continue;
 
-			/* only scan pages belonging to this node */
-			if (page_to_nid(page) != i)
+			/* only scan pages belonging to this zone */
+			if (page_zone(page) != zone)
 				continue;
 			/* only scan if page is in use */
 			if (page_count(page) == 0)
-- 
2.25.1

