Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0513E3D3B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 01:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232483AbhHHXuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Aug 2021 19:50:52 -0400
Received: from mail-dm6nam12on2086.outbound.protection.outlook.com ([40.107.243.86]:13019
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232488AbhHHXut (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Aug 2021 19:50:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jwBGJtvXDERtJynNAKD9mWppTzBtn3uvklGLN5wMrpLFs9Tw3iLjRMlka8yLOkjVsyUbQWd3KgAjgw/TXYXRgR85GgRMuWdzOho6YBEsNXrCfku/gwZ9rj3YzUEO7Gk7bj74M92t1q23Uz5PXILDx80rdQ4/GQmbF1ZWuBwhYurqeWtQofTFbfBaprETCWvmxcVyhRhGB9tlqjCGX0DzxaoN6uS1tJVqRXVOI6fmUO2w1QD64rVICoahA4tGDdYS+gSwuLerCfXP7Hvxr94FCNhOzButN9aH1iBk2qD1CChXTnK5NUNcE/khvDfAS6h+fwTSjRzx12ywUtLzEur6yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pv139OQWFEXxn6Yvz4f7rKpx2Ju29ayURD9QNjFcssc=;
 b=PUosPLtanemu0CeiHk03GhPQu6ciX/UNVPzXq23zXKLMFSd/w+MNjNo3MQr76jv34YFpVHpg5Ij9CBMKq5HYUjILGE/VghYYxhERJ8W89uV4GEsMjXltu4+8D2NU7mmL8vhw6WAkwxcP4cV6r3xuafVOM4OXKVNUdvcTYh7rWYXH10qpwGZWu32jNUx+yo5nhDVHhVDlD2OD+rlukbLBdOai9OmuNQdIDP5W0bDw2SwsJwK8WSVw8gbSCCJJVr5siNDnSmiJvPLvv9j8JKTYcZDUEtwBSeLug2wqtK7UarKb/bRkDUNr/decu5XR5vCqKMFmTCMSuOD3+KotA7sRyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.35) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pv139OQWFEXxn6Yvz4f7rKpx2Ju29ayURD9QNjFcssc=;
 b=rYgkVG5dfsTzvYzlleLunE/U0GJvcIPukmXYyS4P1zUJ2WnqoDcI1sIvLGeh2hkodegB3c0i4A9Z1RInJuGN6jIedW3JA/LeHSr/3d2P51WjmgSRJUMIH5o0Fz2frUQLk0FlMFalu7EObxmRG/QyBiKROKIBsNqPVCEzWvSK34WlCs/amTHjnurwCVIXptsIZHlZHqg1hBQXYAh531jF2YaiOZzLc7JlSCMkF40gDg0/qKXNouc+6S7SzYoP1HbEfLccLOjkNk9/cSwLkg75b0WXZee6xC9iTH3fvhtdf/G7CFBxmC1hc5mwiAdKhp8ORehkuZa7oiBaNucCA1T72g==
Received: from DM5PR05CA0006.namprd05.prod.outlook.com (2603:10b6:3:d4::16) by
 BYAPR12MB4983.namprd12.prod.outlook.com (2603:10b6:a03:102::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.21; Sun, 8 Aug
 2021 23:50:28 +0000
Received: from DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:d4:cafe::28) by DM5PR05CA0006.outlook.office365.com
 (2603:10b6:3:d4::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.5 via Frontend
 Transport; Sun, 8 Aug 2021 23:50:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.35)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.35 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.35; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.35) by
 DM6NAM11FT056.mail.protection.outlook.com (10.13.173.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4394.16 via Frontend Transport; Sun, 8 Aug 2021 23:50:27 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 8 Aug
 2021 23:50:23 +0000
Received: from sandstorm.attlocal.net (172.20.187.5) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 8 Aug 2021 23:50:23 +0000
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>
CC:     LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 2/3] mm/gup: small refactoring: simplify try_grab_page()
Date:   Sun, 8 Aug 2021 16:50:17 -0700
Message-ID: <20210808235018.1924918-3-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210808235018.1924918-1-jhubbard@nvidia.com>
References: <20210808235018.1924918-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d125139b-1070-4410-ceab-08d95ac74c81
X-MS-TrafficTypeDiagnostic: BYAPR12MB4983:
X-Microsoft-Antispam-PRVS: <BYAPR12MB49837D30C44F25C7A099CE37A8F59@BYAPR12MB4983.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FDUOwlYf4350A1x02h+zGBgVZd0HNpA9yPNvNab8cDNQaTYCr2M/mruiILvJG+Hi3Sf+9yjqPRXaVCVV5Yal37mdz0vES/SwY4Dscao5GRfTn48tOiEuYDh/78+yU5vYvnRJHwCSrzgwwKuGszW+j1sRXjwNyFSXmVY5IbaWlFpXSM+tvjOT+FOP73eRimWlgZ2QZuOaNqe4u8gEGcBzQu719rLQzzM5o3/KGcM0BNsLeLONArUrikZFTzMJDYdT1X2UEIteE+nxRudr8UDbwmFys682qlGll8mnqsZZwFziOeElkDj+6Znw+2meSZyYsJ6mz3fS7KJBfiLJSFO7S8xx7bkEVzh7Vav0Bvigl5EBgClkSbirTwE2hnEVNmuVmf9w5sunMgqnb8nSpsNIGw7q8hKdO/qrqWEuBro0HLtNA2Y3zxgs97zEqDymAMnL47SZ8yovLL39B17W5YpHgMYxWveZTc+v39MEuyuEhcDcNxZ3MPQGKqsULPbaSUwQXMBWiIrQlg4KDrcfwNQKegXzxL0ZVkscHvsrgYD+FAIJG+7WUQl9EqTcBHvP+4C+WV/W2mEVLmElEftOABuOqWwCjHX3JQGsvqxJ7CJqlMjAEg3HdQdD0e8v9twod7FfG4NEmlXWGMlXFlWeFqqO3Jn1wCwAqV21Tt4AxSLpRRIffQmg4YuFtF0KMWXOMZ5LG1lxhQSVpfNg0qJYe0O4vA==
X-Forefront-Antispam-Report: CIP:216.228.112.35;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid02.nvidia.com;CAT:NONE;SFS:(4636009)(396003)(39860400002)(136003)(346002)(376002)(36840700001)(46966006)(4326008)(6666004)(8936002)(1076003)(47076005)(36756003)(36860700001)(2906002)(8676002)(478600001)(107886003)(82740400003)(26005)(110136005)(54906003)(70586007)(70206006)(336012)(83380400001)(186003)(356005)(82310400003)(426003)(2616005)(86362001)(7636003)(5660300002)(316002)(36906005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2021 23:50:27.6534
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d125139b-1070-4410-ceab-08d95ac74c81
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.35];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4983
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

try_grab_page() does the same thing as try_grab_compound_head(...,
refs=1, ...), just with a different API. So there is a lot of code
duplication there.

Change try_grab_page() to call try_grab_compound_head(), while keeping
the API contract identical for callers.

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 mm/gup.c | 29 ++---------------------------
 1 file changed, 2 insertions(+), 27 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 5cb18b62921c..4be6f060fa0b 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -203,33 +203,8 @@ static void put_compound_head(struct page *page, int refs, unsigned int flags)
  */
 bool __must_check try_grab_page(struct page *page, unsigned int flags)
 {
-	WARN_ON_ONCE((flags & (FOLL_GET | FOLL_PIN)) == (FOLL_GET | FOLL_PIN));
-
-	if (flags & FOLL_GET)
-		return try_get_page(page);
-	else if (flags & FOLL_PIN) {
-		int refs = 1;
-
-		page = compound_head(page);
-
-		if (WARN_ON_ONCE(page_ref_count(page) <= 0))
-			return false;
-
-		if (hpage_pincount_available(page))
-			hpage_pincount_add(page, 1);
-		else
-			refs = GUP_PIN_COUNTING_BIAS;
-
-		/*
-		 * Similar to try_grab_compound_head(): even if using the
-		 * hpage_pincount_add/_sub() routines, be sure to
-		 * *also* increment the normal page refcount field at least
-		 * once, so that the page really is pinned.
-		 */
-		page_ref_add(page, refs);
-
-		mod_node_page_state(page_pgdat(page), NR_FOLL_PIN_ACQUIRED, 1);
-	}
+	if (flags & (FOLL_GET | FOLL_PIN))
+		return try_grab_compound_head(page, 1, flags) != NULL;
 
 	return true;
 }
-- 
2.32.0

