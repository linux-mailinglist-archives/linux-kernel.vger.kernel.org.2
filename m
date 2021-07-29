Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD6443DAEC2
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 00:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234482AbhG2WTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 18:19:00 -0400
Received: from mail-dm6nam11on2050.outbound.protection.outlook.com ([40.107.223.50]:7009
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230078AbhG2WS4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 18:18:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O41WgeT3J44OcHRtiKKeHo8u5vSvedEg95X8Nh1ALvFH3fJ3WYnH02PfACRrT6EAOO6KGOVuIHn+ARUblQXggP0El806IAUJQI0LV00xb53PhVpxAj8zFfxFlkmQWChPsYz1dJ2G01kfTYVF2a4b73pBahOFJo4movp8t38fmnwyeEehwXJwVwJh475qRsweM4MxvWEB2bc4ncyB/7qnND5efdrHh2JqhGL7zCT91Tn1j9dk6izFDO07DEpQJ6nCwqcuCg59npXsVbWoT7rR+zJ0ZIjEq+nZ6+7UTCXfeVkBtGodW/JhMvmREF0JXCm0C99dN4bbeOg7l2n+3yHHZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BnTydLjnjReWvHdz45QphlLCCwIebFeux7qnl1YzIwY=;
 b=mnYvutovtuDlbgZ9zg5bH2rhA2aiUMwnOu2NWkjZigyg1SdrcYCQGgMS7WYJVXKwPlaFJ8Al0THa8rIFZrBT5WR/3+3b5rDZBpLCM8iU1G8SeCYGVcU/qaxffjfEdFE9D5Owymrw+8+SN2gDGqZeRUHnDGv57L+cTR0WMRnu41kMIsM6LW+5YwXHbN339ZDE4Ghsx+J9Lt5VBHDDMEyeAShbEX7+o2HETD5rWNR14FsRyHUDAYu5+2ld7nvJGc/TDaf1RMpU2QxmzrFbMqwXD6Px7Tf6zy6bG1tjlMTWcreWAszrqDKcqqkioYT1kls2t1I0NuG6GRhoxXcgucKqJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.32) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BnTydLjnjReWvHdz45QphlLCCwIebFeux7qnl1YzIwY=;
 b=bY7N4ONoeWFm6LV+GWOq3ywnMqydB1OgpXDJjt5wRjenY2hqPVjHa/BJNVP3bl5UpXUY40p5jYMiwX/+kbl+vn/cvORbhvM1T1gBdDAQlk+7+kd0eftXZiWYtCJIJdpkonSslAUuUN1CxalYTqMr6RpxfXhyA1xUlQ384L1Tzj7LrqjQTTEVUJeZ8NQAto+IoYMDy62v4nnArbyNIfSa021jg6gsIfni64Kl6IQRwpAV8z/6rtrbWPRmAIhkIEtMNJ5PBNBfKOZGZGU/adC9QM79XSouLDzKv8cGhi1yW8IIkOzzJ/qlyEJhCEY9uni72t4xQn2KUKPdHKOLAW6+FA==
Received: from BN9PR03CA0083.namprd03.prod.outlook.com (2603:10b6:408:fc::28)
 by CH2PR12MB4296.namprd12.prod.outlook.com (2603:10b6:610:af::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.20; Thu, 29 Jul
 2021 22:18:51 +0000
Received: from BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fc:cafe::27) by BN9PR03CA0083.outlook.office365.com
 (2603:10b6:408:fc::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend
 Transport; Thu, 29 Jul 2021 22:18:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.32)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.32 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.32; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.32) by
 BN8NAM11FT031.mail.protection.outlook.com (10.13.177.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4373.18 via Frontend Transport; Thu, 29 Jul 2021 22:18:51 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 29 Jul
 2021 15:18:50 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 29 Jul
 2021 22:18:50 +0000
Received: from sandstorm.attlocal.net (172.20.187.6) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 29 Jul 2021 15:18:50 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Mel Gorman <mgorman@suse.de>, Rik van Riel <riel@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric B Munson <emunson@mgebm.net>,
        Eric Paris <eparis@redhat.com>,
        James Morris <jmorris@namei.org>,
        Mike Christie <michaelc@cs.wisc.edu>,
        Neil Brown <neilb@suse.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Sebastian Andrzej Siewior <sebastian@breakpoint.cc>,
        Trond Myklebust <Trond.Myklebust@netapp.com>,
        Xiaotian Feng <dfeng@redhat.com>,
        Mark Salter <msalter@redhat.com>
Subject: [PATCH] mm: delete unused get_kernel_page()
Date:   Thu, 29 Jul 2021 15:18:47 -0700
Message-ID: <20210729221847.1165665-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8613fbc0-7878-454a-afb6-08d952ded844
X-MS-TrafficTypeDiagnostic: CH2PR12MB4296:
X-Microsoft-Antispam-PRVS: <CH2PR12MB4296FFED72CADB3B5D8841B0A8EB9@CH2PR12MB4296.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bKIy4JjGmHk5SfYLdPmeNrV9c9/TT+UxgWcHXlhGASmyZz59RP+qkXKcFo878kFUTyiBA60SNI2IVy0zj/7AKrJUHqWPujIeshPLBoRa/1gNj1JT+SDzDd6HO6QqFy0xVjnydqJ3Rw6NIHcxdr60aSuomxfsxULjsc1TSYeO3XBSvPs76x27VKWowr6M6bBFyL2GCPlWRTlZf8Msu6zc5I+thax0aJuxlQBu2gAOMFvvbhwrO3MveN6f3q6nAS939xFayiQrG6EtWg+lEg1++YFqLWr2ypi+BII9DEevuUk//sSwQgTpF5fwzRZw6Tk5XagZUsCWvnMW5RVT+0374VlpIZqSk+COJnUUqMKb8tDH9cEo+7Q9ehLNLHgeGS9xM3q9a9EsoKJgE/JGlv011ccHKERrG0k9lGg3kwUaArwPmZAjSJBWLLtZuAz8i82wMEjfNWsYUW/Qa7qkWZ0T8Pu+UitN59DJvHXKD7cw8sOjWe2iKn1Ab5675hodhh5EDSpH5nEuH57bCabmvqMDb60Uv+JFxq5NOV3qVfZ+H/V+Zbspt86eSKgdsLzBHRSJoTSU6XZMkT4/iB/1SRVRo+OjEfBp+UktYfOXiamTfEUgKQ35WpB5FHTUnYb6Ml54XU7aRNem+1j1KXYgDaXxyA79DtgimpkqLgm326cevTYW8mcgsU+kxd0pzGftHlrB05U6sHhlZ8plChzqjIeqxg==
X-Forefront-Antispam-Report: CIP:216.228.112.32;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid01.nvidia.com;CAT:NONE;SFS:(4636009)(376002)(346002)(136003)(396003)(39860400002)(36840700001)(46966006)(26005)(1076003)(36860700001)(54906003)(86362001)(82310400003)(47076005)(5660300002)(186003)(316002)(36756003)(8936002)(336012)(478600001)(7636003)(6916009)(7416002)(6666004)(83380400001)(70586007)(70206006)(2616005)(82740400003)(4326008)(356005)(2906002)(8676002)(426003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2021 22:18:51.2444
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8613fbc0-7878-454a-afb6-08d952ded844
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.32];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4296
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

get_kernel_page() was added in 2012 by [1]. It was used for a while for
NFS, but then in 2014, a refactoring [2] removed all callers, and it has
apparently not been used since.

Remove get_kernel_page() because it has no callers.

[1] commit 18022c5d8627 ("mm: add get_kernel_page[s] for pinning of
    kernel addresses for I/O")
[2] commit 91f79c43d1b5 ("new helper: iov_iter_get_pages_alloc()")

Cc: Mel Gorman <mgorman@suse.de>
Cc: Rik van Riel <riel@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: David S. Miller <davem@davemloft.net>
Cc: Eric B Munson <emunson@mgebm.net>
Cc: Eric Paris <eparis@redhat.com>
Cc: James Morris <jmorris@namei.org>
Cc: Mike Christie <michaelc@cs.wisc.edu>
Cc: Neil Brown <neilb@suse.de>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Cc: Trond Myklebust <Trond.Myklebust@netapp.com>
Cc: Xiaotian Feng <dfeng@redhat.com>
Cc: Mark Salter <msalter@redhat.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---

Hi,

Just a minor decluttering: I ran across this while looking for something
else entirely, and then noticed that it's been orphaned for quite a long
time. It seems like only the plural form of this function is needed
these days, and probably in the coming days as well.

thanks,
John Hubbard
NVIDIA

 include/linux/mm.h |  1 -
 mm/swap.c          | 22 ----------------------
 2 files changed, 23 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 7ca22e6e694a..ab6d7280be5b 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1847,7 +1847,6 @@ int __account_locked_vm(struct mm_struct *mm, unsigned long pages, bool inc,
 struct kvec;
 int get_kernel_pages(const struct kvec *iov, int nr_pages, int write,
 			struct page **pages);
-int get_kernel_page(unsigned long start, int write, struct page **pages);
 struct page *get_dump_page(unsigned long addr);
 
 extern int try_to_release_page(struct page * page, gfp_t gfp_mask);
diff --git a/mm/swap.c b/mm/swap.c
index 19600430e536..897200d27dd0 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -179,28 +179,6 @@ int get_kernel_pages(const struct kvec *kiov, int nr_segs, int write,
 }
 EXPORT_SYMBOL_GPL(get_kernel_pages);
 
-/*
- * get_kernel_page() - pin a kernel page in memory
- * @start:	starting kernel address
- * @write:	pinning for read/write, currently ignored
- * @pages:	array that receives pointer to the page pinned.
- *		Must be at least nr_segs long.
- *
- * Returns 1 if page is pinned. If the page was not pinned, returns
- * -errno. The page returned must be released with a put_page() call
- * when it is finished with.
- */
-int get_kernel_page(unsigned long start, int write, struct page **pages)
-{
-	const struct kvec kiov = {
-		.iov_base = (void *)start,
-		.iov_len = PAGE_SIZE
-	};
-
-	return get_kernel_pages(&kiov, 1, write, pages);
-}
-EXPORT_SYMBOL_GPL(get_kernel_page);
-
 static void pagevec_lru_move_fn(struct pagevec *pvec,
 	void (*move_fn)(struct page *page, struct lruvec *lruvec))
 {
-- 
2.32.0

