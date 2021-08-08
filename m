Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4486C3E3D3A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 01:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232471AbhHHXur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Aug 2021 19:50:47 -0400
Received: from mail-bn8nam11on2066.outbound.protection.outlook.com ([40.107.236.66]:47201
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230376AbhHHXuo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Aug 2021 19:50:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BHYOd/9kMRcXlzOSbX5CimsADyjsUBjocYOpcsQt5iVh7qVWnzjAhaUwebZ+oLOBfshauricZBIk+LcGJdfhGQ+/oqdqUE7lSfD+fGo9W6t3g0DwNJ30TEUvb/yiMFa/ucHcAlhpsTfLienM0GdwxSf3HAdrAvN2mAY8fV+NGv+/aQOjrFk4AZEcr6iTjJJL3KvyBdusW4ZhYjgpI09LGP0oj375J/Mu4OTg7OOzdNi+zx7Z5WKg025LrJSYyUPH/dfnXUZtzzRQiJ7zHnVS4q4cc0a4Vso+a/4unj1RtorkqFgFyknGTJstEPIV5FrZDNojAzHSkKy47/Km9prkbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+hnCcbovl2L9+z2bTv1WMkOZIiv+nDc+NeQkfcK5JaE=;
 b=UeOSdNVS8KiFkBcWZS2MuenDzqiayMjl53fBbPibiXQB8MTRK6BEIGjkYC9Y1/3fbVUgsouVwtFNOA+R7U7+ye+fnxWlkuHbWfrZXLgn8r9ldX2XgeVe75yXgsTSSRWOz/jkEtbTygpbxoBLXBVpd3kaByu+RHa16sZQTeb2bCT1d7y43whzK4o/X7hPytZmvI0vbtljIiU/4OTEMXqdvtJesFFhXhBiHbknMLtFqMJJlXZsyqhTm/ZWHYFIDHc9D7MOMHh3/EkMvTh/cqcmWnp4JM7V9L3sKVkV4mPONdWJBvNDwF6igHW/oxCvNFyaqyJA1oE9rWlaR/BtL443ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.35) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+hnCcbovl2L9+z2bTv1WMkOZIiv+nDc+NeQkfcK5JaE=;
 b=BrLDfex2m/TGGtrS4FCY22vbeNdpUAna8BlF3LHsoyPB6v34B8Hl+V9KlqAmjJb+njg/lxNDLEA53ZzoCS9Cv50Cu+MOVnIZZvpSGbtuNZKBKYtru95GnAhAsCiuKn8FY5ZR6loTljPEG7jrL7BF3mi78fSSKYo39zkCzVwF2FXIfvFosnK/X7pHEW48saEiCz0OHl9YjcR8ZBrh8lB0e9LnroNBIruFJ1MfQnQiEqA3iUnyQ8IP1DlzU+7BwrMver1/JRBHJdJ0SRXTyUhzv/YUj+JhY1YYAnNb/6DL0SKqArC8T96uwiQ20SeyonAuhh4Mu+3/SmUKPhttAnOrlw==
Received: from DM5PR16CA0046.namprd16.prod.outlook.com (2603:10b6:4:15::32) by
 BL0PR12MB2418.namprd12.prod.outlook.com (2603:10b6:207:4d::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4394.18; Sun, 8 Aug 2021 23:50:23 +0000
Received: from DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:15:cafe::8) by DM5PR16CA0046.outlook.office365.com
 (2603:10b6:4:15::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend
 Transport; Sun, 8 Aug 2021 23:50:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.35)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.35 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.35; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.35) by
 DM6NAM11FT046.mail.protection.outlook.com (10.13.172.121) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4394.16 via Frontend Transport; Sun, 8 Aug 2021 23:50:23 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 8 Aug
 2021 23:50:20 +0000
Received: from sandstorm.attlocal.net (172.20.187.5) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 8 Aug 2021 23:50:20 +0000
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>
CC:     LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 1/3] mm/gup: documentation corrections for gup/pup
Date:   Sun, 8 Aug 2021 16:50:16 -0700
Message-ID: <20210808235018.1924918-2-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210808235018.1924918-1-jhubbard@nvidia.com>
References: <20210808235018.1924918-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: edaf858b-6fc8-4e59-63f7-08d95ac749f5
X-MS-TrafficTypeDiagnostic: BL0PR12MB2418:
X-Microsoft-Antispam-PRVS: <BL0PR12MB2418D3B113C0FB74E6FB74FEA8F59@BL0PR12MB2418.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a/PC3vxeXTam3Df4g1Oz626L+MOXJ1e5sOU8tqESCw3PXLPSDOJhvqu0hS82uA0h31YTToL0dQSe5ZwtOfIEQLVT9kecvjg6fw7/Ji7ubO9rT7qkBAHgKb6GGRdX1uM1JLzYBpLhpG0oSbNVfK1HHlszruwMvUdTG7MDZ805MwHJV5ONK+qRCoAVCSUD5eUj7JJELk2VjrX45Ej8UhCpaWt/5NVwNLsx/056hGeD053zGaqolk9duo9EBduSKiV7oMZ6i8RqiQ2lYUYOdsBRQReF+IbFU0Jx7HNt/3B/lad/wksXIQvj1Z+he8q8oYBOvJZVfz9vgHOhKg6kyHG4MHdaWUDDlQ6B6SS3Ek1t2I+0qeHny3uzfRooeywHZmMjhbNjPbr4aBYPNojPTt0w6brqzMmk75ornwI4rNU461A3Ojda0rvqu2HWF/MkATppZdz92KEthIp73HoHb8yKt+25JllfiNFdl3FDiUk9c545FdZrzf4U8lG1qhW+vbrsudpfHNvBddUKA86SqZXDIW1PEyiK+pKMKbgPU1HTSLtmDP+g9MV9s+cI7WH6QL37uJs3Ft+Wpi67L7N4c2YVkiezP87OQnpBadRhh4cZuR5bDdAidBG4iE/tosUXP3O+F/EE9YmtMkSA221ZMblSx4BPz302TcdytXBSJf7xlg1BQvIdMQV6f3lFIfRr60cU6msvz3qR9PADyh3bRFvgTg==
X-Forefront-Antispam-Report: CIP:216.228.112.35;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid02.nvidia.com;CAT:NONE;SFS:(4636009)(39860400002)(346002)(396003)(376002)(136003)(36840700001)(46966006)(110136005)(54906003)(2616005)(70586007)(186003)(4326008)(1076003)(107886003)(8676002)(47076005)(5660300002)(6666004)(426003)(478600001)(70206006)(356005)(8936002)(26005)(336012)(316002)(86362001)(36906005)(7636003)(82310400003)(36860700001)(36756003)(2906002)(82740400003)(83380400001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2021 23:50:23.4376
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: edaf858b-6fc8-4e59-63f7-08d95ac749f5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.35];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2418
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The documentation for try_grab_compound_head() and try_grab_page() has
fallen a little out of date. Update and clarify a few points.

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 mm/gup.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 77150624f77a..5cb18b62921c 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -103,8 +103,14 @@ static inline struct page *try_get_compound_head(struct page *page, int refs)
  * same time. (That's true throughout the get_user_pages*() and
  * pin_user_pages*() APIs.) Cases:
  *
- *    FOLL_GET: page's refcount will be incremented by 1.
- *    FOLL_PIN: page's refcount will be incremented by GUP_PIN_COUNTING_BIAS.
+ *    FOLL_GET: page's refcount will be incremented by refs.
+ *
+ *    FOLL_PIN on compound pages that are > two pages long: page's refcount will
+ *        be incremented by refs, and page[2].hpage_pinned_refcount will be
+ *        incremented by refs * GUP_PIN_COUNTING_BIAS.
+ *
+ *    FOLL_PIN on normal pages, or compound pages that are two pages long:
+ *        page's refcount will be incremented by refs * GUP_PIN_COUNTING_BIAS.
  *
  * Return: head page (with refcount appropriately incremented) for success, or
  * NULL upon failure. If neither FOLL_GET nor FOLL_PIN was set, that's
@@ -143,6 +149,8 @@ __maybe_unused struct page *try_grab_compound_head(struct page *page,
 		 *
 		 * However, be sure to *also* increment the normal page refcount
 		 * field at least once, so that the page really is pinned.
+		 * That's why the refcount from the earlier
+		 * try_get_compound_head() is left intact.
 		 */
 		if (hpage_pincount_available(page))
 			hpage_pincount_add(page, refs);
@@ -186,10 +194,8 @@ static void put_compound_head(struct page *page, int refs, unsigned int flags)
  * @flags:   gup flags: these are the FOLL_* flag values.
  *
  * Either FOLL_PIN or FOLL_GET (or neither) may be set, but not both at the same
- * time. Cases:
- *
- *    FOLL_GET: page's refcount will be incremented by 1.
- *    FOLL_PIN: page's refcount will be incremented by GUP_PIN_COUNTING_BIAS.
+ * time. Cases: please see the try_grab_compound_head() documentation, with
+ * "refs=1".
  *
  * Return: true for success, or if no action was required (if neither FOLL_PIN
  * nor FOLL_GET was set, nothing is done). False for failure: FOLL_GET or
-- 
2.32.0

