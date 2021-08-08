Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93A083E3D41
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 01:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbhHHX4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Aug 2021 19:56:41 -0400
Received: from mail-dm6nam12on2066.outbound.protection.outlook.com ([40.107.243.66]:25152
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229662AbhHHX4k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Aug 2021 19:56:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fSxh1SC1eWfNFxdVK+FA//j0T6MWtVAHQOo3XWMVgK8qobe38eUAou3ahAsAHlmfhcg3s7BVpnb7zeQPy559zrP6K627IxU/zNL1Rd44Mn9wY4mQ+HVYa4s6jsWTQNmBVlVuXTbvx58cwBkdvjGYC8Wpz93AgEg362u/Lfmf4V40exH7lGo1VTTbREXDCNdmhQZ5KrmyRYZGHdNJOVAL3lc6kSJXPy/w48MCAUNfMWoE14ewMfp76WiEb07ri1tEyFuqUkGtSnR6HD88Bu8GQfi9W8Ej8epFIgQa7PE4mGDXw8FqqwVdOHPb+JY3bZO9uFiJnLqr5Lojt+oBIHdZZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S+hAT6FQWNFGwLsH49tB8X/14nP2g71qGXxVFtkgw4w=;
 b=af/GzKd+sY/twrr3ncETLW8WrBkj6j4uqOohOpuwEZQXpfGzv4MqjOAHQWCIhU4blnVD1ngjBvJLOjfzLNZ0F0a8Y0Xh79C6r10H2X6iJ049mgd6yh05HL5UDvP+kR6H1M2vu90L77++s27kHe/khZuhLu5DakFzV4WallIYlA9ipUV1ohujTYXQ7GroyEAmJ6+bNkv0ld58XhaO6Iv6ltQXXXVBzLAt5w+nOWv/mYRu883Uy4k+JdKlUrdjHcDqgBZKnfYE9VIih2DQtWOaozwEcDWV+Px36nkayg5UCx3ruGgtKgP1yHMSYg3m3pGzZK+77JrOE2m3/W+fqI5d3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.35) smtp.rcpttodomain=linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=quarantine sp=none pct=100)
 action=none header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S+hAT6FQWNFGwLsH49tB8X/14nP2g71qGXxVFtkgw4w=;
 b=QAjiZNJbUtAHiTAFVuF1e+F78m7qbSzXsdp9h1Rh4LTZqMk1EVmztQPS9tlC0CuJH5t/YB8yAIGcUFa2STc+U14tcMJL34csewzp17mFUwHU6c8fKLKwkDGU6ghT1lNTFl2tupFJmK4rqObjd4axQev/nFUE+57akykIuF+IvEabtCiexEeFh/NXtc2FbXX38PuY9k7TIapA5io3XPzH7ivsvVufc7Dk3K37TCdz0OEICCqMId5449i8eQZqAEz+JfrQonX2Hfs1zjmIZQAyNrjszYKW4tgesVdE0tWA06BeDI02875YE2IX4JTkMXkWn6uk12EPGQTtmVFOKjs2vw==
Received: from MW4PR03CA0086.namprd03.prod.outlook.com (2603:10b6:303:b6::31)
 by MN2PR12MB4064.namprd12.prod.outlook.com (2603:10b6:208:1d3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.16; Sun, 8 Aug
 2021 23:56:19 +0000
Received: from CO1NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b6:cafe::f5) by MW4PR03CA0086.outlook.office365.com
 (2603:10b6:303:b6::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.16 via Frontend
 Transport; Sun, 8 Aug 2021 23:56:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.35)
 smtp.mailfrom=nvidia.com; linux-foundation.org; dkim=none (message not
 signed) header.d=none;linux-foundation.org; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.35 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.35; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.35) by
 CO1NAM11FT010.mail.protection.outlook.com (10.13.175.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4394.16 via Frontend Transport; Sun, 8 Aug 2021 23:56:19 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 8 Aug
 2021 23:56:18 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 8 Aug
 2021 23:50:26 +0000
Received: from sandstorm.attlocal.net (172.20.187.5) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 8 Aug 2021 23:50:26 +0000
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>
CC:     LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 3/3] mm/gup: refactor and simplify try_get_page()
Date:   Sun, 8 Aug 2021 16:50:18 -0700
Message-ID: <20210808235018.1924918-4-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210808235018.1924918-1-jhubbard@nvidia.com>
References: <20210808235018.1924918-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c67cdf41-6ee7-4d3c-a6ea-08d95ac81e07
X-MS-TrafficTypeDiagnostic: MN2PR12MB4064:
X-Microsoft-Antispam-PRVS: <MN2PR12MB406419F167D281B891B6C7E9A8F59@MN2PR12MB4064.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jvoHdzl8g7E2qD6ggvVGggWwDiPoU9OvqstLB4WIHiKN8sqiXVL7Orajc1zY+0p7suBu3kHrFhewccIG0FA3ONt8cSdFdH8eNO7PsW3ubr1x5DyIHeOA52zDQa8N6q30w0mhGH3ysgmBsVu7ZPncUVNm9PHQjmrIodbRjhgZCoxnOtDAcKtNo3YrwIc4AagEeHG8YIND4kluJhnA2jrNMWyEodF6g3+iVvGoukP2ZyCpf5EpujvmuAjJSP9w8f87QDzA/b2jbfZKUPoDlWeYaR+L3BkVd8iaOkqMwIIwsZVNj/tAdA8DCwAh6jEO75vDJ0w65+ENYtBIY9R3DZ6tNdqueG4ZizrLzjfQcb771CUhB5HtQVRsDJH5Ff7hz8SyPWeldTYDBUpgoRUqcSWlOlZkd/Bn3hdzRamNMrzQOZBEpFlPPAIpWhP1A05dO2Zm+4JZnq8qlilKNyrL59NXFnvPIcKOixSWk2iBm8V9EbWIP4BginrQvCOrOtDC11evR2pqGHzXX5y3htrxk62mzN19p23r0kRHebNuLJxQMCh+A2jCU8sHe9+9ZuyhKkfJ36VwksoZQkZjgX0lK+5xD13aTYoOrd/Ai5oh5uuD+Jdu2OKNTf0AVH2DJWQZLRasuWfrIDrKUhRnm8R6MGrexsMEW+20FlRQOX26Bgp6kuKWhmVgX8AI/EcraQnkW4ewzrQWKogN/JFW3l1eyDQojg==
X-Forefront-Antispam-Report: CIP:216.228.112.35;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid02.nvidia.com;CAT:NONE;SFS:(4636009)(396003)(376002)(346002)(39860400002)(136003)(36840700001)(46966006)(356005)(36756003)(83380400001)(82310400003)(8676002)(86362001)(7636003)(36860700001)(336012)(36906005)(478600001)(186003)(82740400003)(2906002)(316002)(110136005)(70586007)(70206006)(26005)(4326008)(8936002)(6666004)(54906003)(47076005)(5660300002)(1076003)(107886003)(426003)(2616005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2021 23:56:19.2383
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c67cdf41-6ee7-4d3c-a6ea-08d95ac81e07
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.35];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4064
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

try_get_page() is very similar to try_get_compound_head(), and in fact
try_get_page() has fallen a little behind in terms of maintenance:
try_get_compound_head() handles speculative page references more
thoroughly.

Change try_get_page() so that it is implemented in terms of
try_get_compound_head(), but without changing try_get_page()'s API
contract.

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 include/linux/mm.h | 11 ++++++-----
 mm/gup.c           |  2 +-
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index ce8fc0fd6d6e..92d3b37357d5 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1207,14 +1207,15 @@ bool __must_check try_grab_page(struct page *page, unsigned int flags);
 __maybe_unused struct page *try_grab_compound_head(struct page *page, int refs,
 						   unsigned int flags);
 
+struct page *try_get_compound_head(struct page *page, int refs);
 
+/*
+ * This has the same functionality as try_get_compound_head(), just with a
+ * slightly different API.
+ */
 static inline __must_check bool try_get_page(struct page *page)
 {
-	page = compound_head(page);
-	if (WARN_ON_ONCE(page_ref_count(page) <= 0))
-		return false;
-	page_ref_inc(page);
-	return true;
+	return try_get_compound_head(page, 1) != NULL;
 }
 
 /**
diff --git a/mm/gup.c b/mm/gup.c
index 4be6f060fa0b..ba75906ba7f7 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -66,7 +66,7 @@ static void put_page_refs(struct page *page, int refs)
  * Return the compound head page with ref appropriately incremented,
  * or NULL if that failed.
  */
-static inline struct page *try_get_compound_head(struct page *page, int refs)
+struct page *try_get_compound_head(struct page *page, int refs)
 {
 	struct page *head = compound_head(page);
 
-- 
2.32.0

