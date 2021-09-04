Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE4F64008D7
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 03:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350732AbhIDAnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 20:43:31 -0400
Received: from mail-bn1nam07on2041.outbound.protection.outlook.com ([40.107.212.41]:51496
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241254AbhIDAna (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 20:43:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ILQOrY5cMue+xUytpsQ8e78tXr7Y4iqOravX18/NmsFfgvIIN7rpagYpxHO1Y+x2y64LPSJ/0iUG1GTC1FuX1BiPZMpcUGhwDLJRxzB6woBpyYDzrRKxsZ90TMGfUHlaQZXqlMpkq+Pncd2D7h/REh0L/3kg3AxQWVS88sU4eYmNKobDzXW+Yi9cMXQRy9lcZGmUGeRNzWT+XhRV3PUcQGk7caa5oCvlQj84qGZOrik42J2c8R76s2LBOrOix8GUUfsSQKebYWb1ETD9iCWST+deZCxv2ypoYsRvpp8qvhZN6ZMkNyOhtfM4Gop2LriWrbVmVtVq/ofAK/UmwYJSbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=qIC8K2bSxX+KxEWcUl+HhIrMSIUejaJm7ZH7n+OLY4M=;
 b=ZIYjTu43/yPTclCa1lcPp02vDPiVbmWwfyT7G2KDcuMVVqUqB5LpIcToJVvupj+An7KSSf7iEDThwmX7G9gVjeT5vnmbmJ3Q5QkZlBMdSnoFOR2JmgoMd10d3tGHfv5+vl/Z0nzCvLodYNEeMXwG6AZdWk8XnfBNIDk9jDtuEWzoZ3/AbDKNUC1sHCM2UX3Mh8JSOpJS6z8fVJA/Gl4ZFUwYvu16G/njVJDUkzFY1ki0QxNczSd5tiNuJp8vuWYuwPaRfainUpmf5s+kjHxyZAWGemSbZysUwCkspMEF+R8XkmDmGH4fuGXRgGVKtcGiLSEbvqdH6pRYsgsH7QQEjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.35) smtp.rcpttodomain=linux.ibm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qIC8K2bSxX+KxEWcUl+HhIrMSIUejaJm7ZH7n+OLY4M=;
 b=fzkDV72poGoqETU5B+8QbvStAZneFczfJ0rV84f4w81TuzhlDwizt2iGGk20etiF2mWv+M7mevvRRh8pSOIRgvxR+6VNwZc814LIrSRE19XNHJBwpYS/R89RxSR8kz+NrrU8Rb/Rq+e4x6SauZwfxn7IS2EhARsTgkFG6NTQfaTzFXb9qUelNNJ5zA3jXGiVkQYtZh8xy+e8xrUZBgO5mSwHv7va7zG58nX31Owu28OPymnuXFppy79E69IJejPX7I6W14NEaDkQYtXK05kJipQxAE0kz9t4esngZLMVdTXXYazUoOHYPamuonPbhGlCCHfF3P7RxdUxQ9tusyhhdQ==
Received: from BN9PR03CA0900.namprd03.prod.outlook.com (2603:10b6:408:13c::35)
 by BN8PR12MB3364.namprd12.prod.outlook.com (2603:10b6:408:40::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.21; Sat, 4 Sep
 2021 00:42:27 +0000
Received: from BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13c:cafe::58) by BN9PR03CA0900.outlook.office365.com
 (2603:10b6:408:13c::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.21 via Frontend
 Transport; Sat, 4 Sep 2021 00:42:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.35)
 smtp.mailfrom=nvidia.com; linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.35 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.35; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.35) by
 BN8NAM11FT029.mail.protection.outlook.com (10.13.177.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4478.19 via Frontend Transport; Sat, 4 Sep 2021 00:42:27 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Sat, 4 Sep
 2021 00:42:26 +0000
Received: from sandstorm.attlocal.net (172.20.187.5) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Fri, 3 Sep 2021 17:42:26 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Miaohe Lin" <linmiaohe@huawei.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        "Jan Kara" <jack@suse.cz>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH] mm/gup: further simplify __gup_device_huge()
Date:   Fri, 3 Sep 2021 17:42:24 -0700
Message-ID: <20210904004224.86391-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d09d61d3-81eb-496c-d313-08d96f3cde8f
X-MS-TrafficTypeDiagnostic: BN8PR12MB3364:
X-Microsoft-Antispam-PRVS: <BN8PR12MB3364ED5C55C3CA112A37AD77A8D09@BN8PR12MB3364.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:249;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: USp2r4crTdT20/AIzkeNtXpMVhWhpbNlqYdZZA61IzMS/Oy//28t2Bd/86+XYQV9kkDnyqarXKn6rC1NfwrlMO8pCfFlGqnonBw/TPxTGPcInV9IvHS5+QJUN3cA75Znn+Matyw66yqFIUMD7+PtEk27qyWvSZZgYB0+NHn2+WKWJPlU39dp1H3+/Su9Kuv1nRyQ34ZFRGv3pfa0du5Ny6GYqhiMVeftlJmRqIr8Vs6fHEGaywSfVRjHNMKSDTTXp00bg2WUOmNHJG1HvcovTLQ76xbScJ/wM/uekIHbBblyGzYP2lCYW8vIIsX/c2wTKEcb5YS3inb6TZ2AXtH38y4+0oGDYb+PoDF+64e3VrojwNF6C5q99xkWVW4prU9X53ed51FY718x5eN0HM1gEntZ4tNc/TarqTwH1OMp639ubbxNJ87si3r94SMnT2BC/uEQIin49U4FK/CGavrd4m75wHZ6BHvvO7zKB4uy08ps+ZWuzukcNn4d4xYbMRI+R/NjC4sDvizIANlOGmt6cog9aLBITu/imKkUfwFtc9yy471+MBW88bVH1G52t39Lr+iJOLc4rDoOvoeJyj4Cf5jhs2bo5p8x/CIXT//6wCTlNKjVil3dcu4m7HealmWaoGsg7bjv89J2Lzg8buNVpifttFFsHlVfYto2LtX/ivvMOaq5uLtI773e4BhkqPRM6CR9IZtTce6XPTVLPp8wl0As9ElFg6Ehqbgs1x7shn+aG2DdGljoyVRBWRG6lx9SLM0vhiB3/JhddS7CSaB5YPT18RE1Bmm66hHwdRBGhzg=
X-Forefront-Antispam-Report: CIP:216.228.112.35;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid04.nvidia.com;CAT:NONE;SFS:(4636009)(376002)(396003)(39860400002)(346002)(136003)(36840700001)(46966006)(36756003)(1076003)(7636003)(2616005)(8936002)(5660300002)(54906003)(83380400001)(316002)(336012)(966005)(4326008)(356005)(8676002)(426003)(36906005)(47076005)(6916009)(82740400003)(86362001)(186003)(70586007)(70206006)(2906002)(26005)(36860700001)(478600001)(82310400003)(14583001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2021 00:42:27.0617
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d09d61d3-81eb-496c-d313-08d96f3cde8f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.35];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3364
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 6401c4eb57f9 ("mm: gup: fix potential pgmap refcnt leak in
__gup_device_huge()") simplified the return paths, but didn't go quite
far enough, as discussed in [1].

Remove the "ret" variable entirely, because there is enough information
already available to provide the return value.

[1] https://lore.kernel.org/r/CAHk-=wgQTRX=5SkCmS+zfmpqubGHGJvXX_HgnPG8JSpHKHBMeg@mail.gmail.com

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Miaohe Lin <linmiaohe@huawei.com>
Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: Jan Kara <jack@suse.cz>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 mm/gup.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 9935a4480710..6e62f1518c1f 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2241,7 +2241,6 @@ static int __gup_device_huge(unsigned long pfn, unsigned long addr,
 {
 	int nr_start = *nr;
 	struct dev_pagemap *pgmap = NULL;
-	int ret = 1;
 
 	do {
 		struct page *page = pfn_to_page(pfn);
@@ -2249,14 +2248,12 @@ static int __gup_device_huge(unsigned long pfn, unsigned long addr,
 		pgmap = get_dev_pagemap(pfn, pgmap);
 		if (unlikely(!pgmap)) {
 			undo_dev_pagemap(nr, nr_start, flags, pages);
-			ret = 0;
 			break;
 		}
 		SetPageReferenced(page);
 		pages[*nr] = page;
 		if (unlikely(!try_grab_page(page, flags))) {
 			undo_dev_pagemap(nr, nr_start, flags, pages);
-			ret = 0;
 			break;
 		}
 		(*nr)++;
@@ -2264,7 +2261,7 @@ static int __gup_device_huge(unsigned long pfn, unsigned long addr,
 	} while (addr += PAGE_SIZE, addr != end);
 
 	put_dev_pagemap(pgmap);
-	return ret;
+	return addr == end;
 }
 
 static int __gup_device_huge_pmd(pmd_t orig, pmd_t *pmdp, unsigned long addr,
-- 
2.33.0

