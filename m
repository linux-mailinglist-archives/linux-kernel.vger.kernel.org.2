Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 298BE445EE9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 04:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbhKEDzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 23:55:41 -0400
Received: from mail-dm6nam12on2064.outbound.protection.outlook.com ([40.107.243.64]:12192
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231628AbhKEDzk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 23:55:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P3yAmpt5iRZfEbS/HT49XoqvcWKsbtXS8FbinkenehTi1ZHfS7Uod4W02INAMWeer1zr6oLsLVWJ5NLtZzdA2jMyRjxkMg8wrfiUaa8tkWDW9L75smGbLsi6xWsdPxBWS46QQTO2D3obVTVoYkzXJl5R56elektKqLxXddn01KBqUWfGmpUjfX0RkSLMzcuBzTu6GFT54BF6vF3jEoOcOMZhV1LeI5jht6Yv+dq25xBK191mvnAqoPsbE4bnMP9z9tYK1qAVkrghjUzAho27mrgCMQ2rMCDD0yGoJsv/TefVIPPBXu3OMKW85fgXh5J6F+nzNrQwts/F4VSvy98W4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tsOkFORlY8eZ/TjZezj/gnJFtuXBqAL5cqPyqMmBswo=;
 b=St5hI+COW3eFT4wppuXreN0UXFdyyiLzvHuRlyHZ5E1pL8C5LeCMCrqL2g9gCvG3UuqJjveo23hz00CM0oh7Offe+8Vl/oZRbN3JKK/HEu2+7X+QUCTdUf9zx2hmWNtBOEcueaERRdLusKkJZxknGEcogXNbHPkRIAjq1OOe4AWYLXK3BgPT7gpq6swhWOZjbzYRz41IUSkAnskLJkLOSz8KgT4Y9VsqYwZr3gVZ27mSu9PiNt6ZypiN3RBt/Wth67yoYLqbIzv0OpbwNUIPvtxU3zztjCVNxtAzPL570RKNASR/9g+10ty5Hjax/9DnsttR8UJaHyF60m5fosD/Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kvack.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tsOkFORlY8eZ/TjZezj/gnJFtuXBqAL5cqPyqMmBswo=;
 b=K+WsauXdHBHOdhRG7OM1LbDpRWw3+9g57jJtmznT97iQ6kqfk3yKOp10tAARHm6Czj18FDecACi8MYtSrke4DsoG08lFK/AOrC5uJ3Y4vWot2WNMfRgYPxWAvLDmiUuI7OPUvQ+L3kvpdKuX+TsoyVSIAVUcrPK4sweR27pN4Uo=
Received: from DM6PR07CA0100.namprd07.prod.outlook.com (2603:10b6:5:337::33)
 by CH2PR12MB3654.namprd12.prod.outlook.com (2603:10b6:610:22::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Fri, 5 Nov
 2021 03:52:59 +0000
Received: from DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:337:cafe::ad) by DM6PR07CA0100.outlook.office365.com
 (2603:10b6:5:337::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10 via Frontend
 Transport; Fri, 5 Nov 2021 03:52:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT016.mail.protection.outlook.com (10.13.173.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4669.10 via Frontend Transport; Fri, 5 Nov 2021 03:52:58 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 4 Nov
 2021 22:52:56 -0500
From:   Lang Yu <lang.yu@amd.com>
To:     <linux-mm@kvack.org>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        <linux-kernel@vger.kernel.org>, Lang Yu <lang.yu@amd.com>
Subject: [PATCH] mm/kmemleak: Avoid scanning potential huge holes
Date:   Fri, 5 Nov 2021 11:52:41 +0800
Message-ID: <20211105035241.1239751-1-lang.yu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a2e141a0-f979-40b3-d82b-08d9a00fc196
X-MS-TrafficTypeDiagnostic: CH2PR12MB3654:
X-Microsoft-Antispam-PRVS: <CH2PR12MB365426095CEDE2DDBE9E1396FB8E9@CH2PR12MB3654.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H7uP6jY3/lcVq5WVGJzRJRy6pYm1xeA+uwfI/DGZeS3oF7JGwYbr0jxKZB6IqKc8UYw9QmSM8U6hfFneVwG54X3WjK6VchAidRG8Vi7WlZmGmeOk0yX6tPeSgqyJNE6Clh3WiTcJqv42AR6oBiwsAdaKNQC1qa8hp5HodKSPLpumw/WTstaaG9q6xshj9mK+2Hf2ELx91zNnKm9JKZi+oNHJ3GAorytAhMe3ub5Vu12pePntAeugE64aAcpQaw1dLkB0gX6MRVBXtdnzSNmr59qoc+ebB/8+0DpJyY5wZGysDIg0VUF+geK4eITx7QONHSBf9EdYmFNxsvSRkGXHeXQ+Dp7G5vD4iMCK8skc+rZSahg3HF4orvcvxdvCnXCGmV5ytxvm1u5LcDOOQyodIVek3DNrPjASigju0Y/NTnxok54+bPiBkQeYZ7DaV2kZoA4yFkRktYyEkQ1G0pLzlmngrBgRtQC7RNyr5UdzvnV2hU46cgxWpnWt2h4X7ziJ4tlG/oUQdOM15rhot6A9YJlVSdYYoUklx46+rmucwDFqfQPkqi2+Lh/Ot8naI5ECU9zEmMyq3QneB0IsWsGUyxdU5IBOQ9f81PKqm2D0gAbYcW7jzfTPWeKotPafyy2h07PzbXDARxglsVmwE8bytpZp8N2WW02z9MKiY6sLR+IZlqYF3hvumsv5Y9Idf7i24X7FVXUAdsm2hDMJni04HWeRXK4/oFKlCnnPdzVXBBBn7pGeJY6QxIeQYwVizYrB4oPs9chfSegCq0Cj9so3bA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(8676002)(70586007)(86362001)(2616005)(7696005)(5660300002)(4326008)(36756003)(70206006)(44832011)(26005)(36860700001)(1076003)(356005)(6916009)(186003)(82310400003)(316002)(83380400001)(508600001)(336012)(8936002)(47076005)(426003)(54906003)(16526019)(2906002)(81166007)(6666004)(14583001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2021 03:52:58.1628
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2e141a0-f979-40b3-d82b-08d9a00fc196
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3654
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using devm_request_free_mem_region() and
devm_memremap_pages() to add ZONE_DEVICE memory, if requested
free mem region pfn were huge(e.g., 0x0x400000000 ,we found
on some amd apus, amdkfd svm will request a such free mem region),
the node_end_pfn() will be also huge(see move_pfn_range_to_zone()).
It creates a huge hole between node_start_pfn() and node_end_pfn().

In such a case, following code snippet acctually was
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

Signed-off-by: Lang Yu <lang.yu@amd.com>
---
 mm/kmemleak.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index b57383c17cf6..d07444613a84 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -1403,6 +1403,7 @@ static void kmemleak_scan(void)
 {
 	unsigned long flags;
 	struct kmemleak_object *object;
+	struct zone *zone;
 	int i;
 	int new_leaks = 0;
 
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
@@ -1455,7 +1456,7 @@ static void kmemleak_scan(void)
 				continue;
 
 			/* only scan pages belonging to this node */
-			if (page_to_nid(page) != i)
+			if (page_to_nid(page) != zone_to_nid(zone))
 				continue;
 			/* only scan if page is in use */
 			if (page_count(page) == 0)
-- 
2.25.1

