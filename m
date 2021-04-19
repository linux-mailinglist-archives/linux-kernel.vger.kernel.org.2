Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 962CA363C0E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 09:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237470AbhDSHEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 03:04:06 -0400
Received: from mail-bn8nam11on2081.outbound.protection.outlook.com ([40.107.236.81]:28128
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229473AbhDSHEE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 03:04:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E8XWuWp8sdB9Nzxcf993fzetHAg8XEkITt0ORmbSYgYNHwhUecrEsLjs0k3ulW8ESVzLS+DTEwQA/bGntEJtuqzfFEgVHknNlu5lOdJjwMbWevI6lhQrugj1XNLJqVW+EqkBLI6Ce1cKifbOE7yOwT/dKj7AylirusoYpPqKba1f6xSMnTDDa89TwBVvXpj95qGso3vj2+zzD1V7a2Q8PwtKs87ocQqLyGz4XbK7i++rh+H5CK52tWhbOl2w5/cFRGnyQtuRhJcaUwJr6QOYSNC4a4a+30AQMZXcJLk7I5rJqaL+obd8NzhFjunyhuGmZJ6ObUrx1WZubgoRifeyPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p8A6Z9kMia+E0KTGAkh5tS+kpS/5a4xPvE7sGXaxdpo=;
 b=ZLvEE7dzU2Y4MP79SSCDci3NkDy1/zPoKx/rIpuR1mYrz6wK/oqlSUjXP//5ByS7XBuGgi+d3CmSEbRgQHkozcgxAcux07Ld9sDkx2xgT3DyZYOwzG9+WovhyGECSplvoK3Xi16AdVPSQGvgBQT9inqW+szKxlgIgZmtm1uheMw6yV79fvOYkrQ8UL2d6rxbdDhrVPdu/EFzZY5lwAaRHJwEMDF6ENrlx37IDwCqugAg2050U6EjzrMKBsO3lUQGuTt+mn8K7+4vUzEhGAcMEOKCbxmWJMu8JxezY0GxBhEsZusTey3/XFL+avkPKZgYnanCCUqnmhYzd7U5GMx2hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p8A6Z9kMia+E0KTGAkh5tS+kpS/5a4xPvE7sGXaxdpo=;
 b=ilNE5z/h2h9i38K/qksmo44uxyhpRxZR8fFP0swc1+SWlI/0IrnkjlE5wt4bMcaMUeXJa3x+gdBZUFQC2hVtD+Plo76mj+jM1+htj/Z8+dEwzz9NVfyFNbDtyz2U96R12FihY705EWHY9+jznTz7upT57cMvE4o7e52zqG8ZoIZyChM7CfP/APJxVfOGjkH9TRbQgCTw3GS9lTHiH+WRMXSa64uel0pU/EpHyJHSO8MhpdPwkO+JWJ4cwatup2niTz82pXfiwhey5WEEJFormfxpiMcdhANmVGEdpchG+GmoaGn2DY/IpuHLYRcqKkwNcSizvRQmM40LEHN4AVFYxQ==
Received: from DM6PR06CA0095.namprd06.prod.outlook.com (2603:10b6:5:336::28)
 by BYAPR12MB3352.namprd12.prod.outlook.com (2603:10b6:a03:a8::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.23; Mon, 19 Apr
 2021 07:03:33 +0000
Received: from DM6NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:336:cafe::1f) by DM6PR06CA0095.outlook.office365.com
 (2603:10b6:5:336::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend
 Transport; Mon, 19 Apr 2021 07:03:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT026.mail.protection.outlook.com (10.13.172.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4042.16 via Frontend Transport; Mon, 19 Apr 2021 07:03:33 +0000
Received: from localhost (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 19 Apr
 2021 07:03:32 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <david@redhat.com>, <daniel.vetter@ffwll.ch>,
        <dan.j.williams@intel.com>, <gregkh@linuxfoundation.org>,
        <jhubbard@nvidia.com>, <jglisse@redhat.com>,
        <bsingharora@gmail.com>, <smuchun@gmail.com>,
        Alistair Popple <apopple@nvidia.com>
Subject: [PATCH v5 1/3] kernel/resource: Allow region_intersects users to hold resource_lock
Date:   Mon, 19 Apr 2021 17:01:07 +1000
Message-ID: <20210419070109.4780-1-apopple@nvidia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9396d341-e55b-4a38-3349-08d903013ec4
X-MS-TrafficTypeDiagnostic: BYAPR12MB3352:
X-Microsoft-Antispam-PRVS: <BYAPR12MB33521F68C69F10EC0B18F905DF499@BYAPR12MB3352.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q/muba61SW+g4y8LaeM+U1tQ/Rdv0rTZ3pZkeffigDqshi758vmTq5ms5bPbRWNmEavSPgFx+0NOPxzZP2831IQ9r15haco0t2zCGi55r+UIxER1KcqdiuTAaAuFS/+ol3XVQ5n7PLLtLcpeJHq4HOmpFCHLO7rWAaNWJxLIC3lk8eEO9b8vvl6zr9cna2nsNhXU0bIRaXufub9ZozPeJmkbF2GPd1zvjD+5S2aWiapNMQ4ZpTaPk/2cVuDvupS3Kf0hUTpyBSAhNQYdrywwCGlFifraW9ZYs4Gxadtlr8p6i30mqMvGkbhp6vX9fUvbAYPLCdvggtCMTyQ5v78M/rEL1KQKMrk3oYkLymq0qZ7q1d8LH+tyYAdAZjMKCjHbBSlChkmuzZ4KjUzGBmtYH8/dTxTmUey3WHfxLudVv/nS3JAcnXqRyuvZO+SiuBnSsoRDfDki6LJQHMMzA4j0h+lY1/3HToILGlA3YXRM4FMTHImv9wDmFAu1PToNS+HxfTx1+I4MafLHatzPCMj1z1Un2+0AEnO81CSUzsQyOR2TBKJdzJ2Tt6YwArEbCZHkzb5CoAe4bfDeDXzTsQPZrl9diG56elHkpXjmzWFYPYvx5HqKuOLcSF45msE47FSYiCe/7WGNLN3W89MnP9q5IwdX5N81uxRFpqfXsWAPYc4=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(396003)(136003)(39860400002)(346002)(376002)(36840700001)(46966006)(70586007)(70206006)(426003)(16526019)(186003)(54906003)(316002)(1076003)(2906002)(8676002)(356005)(82740400003)(2616005)(478600001)(5660300002)(7636003)(107886003)(83380400001)(47076005)(8936002)(82310400003)(4326008)(6916009)(336012)(7416002)(36860700001)(26005)(86362001)(36756003)(6666004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2021 07:03:33.0673
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9396d341-e55b-4a38-3349-08d903013ec4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3352
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a version of region_intersects() that can be called with the
resource_lock already held. This is used in a future fix to
__request_free_mem_region().

Signed-off-by: Alistair Popple <apopple@nvidia.com>
---
 kernel/resource.c | 52 ++++++++++++++++++++++++++++-------------------
 1 file changed, 31 insertions(+), 21 deletions(-)

diff --git a/kernel/resource.c b/kernel/resource.c
index 627e61b0c124..736768587d2d 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -523,6 +523,34 @@ int __weak page_is_ram(unsigned long pfn)
 }
 EXPORT_SYMBOL_GPL(page_is_ram);
 
+int __region_intersects(resource_size_t start, size_t size, unsigned long flags,
+			unsigned long desc)
+{
+	struct resource res;
+	int type = 0; int other = 0;
+	struct resource *p;
+
+	res.start = start;
+	res.end = start + size - 1;
+
+	for (p = iomem_resource.child; p ; p = p->sibling) {
+		bool is_type = (((p->flags & flags) == flags) &&
+				((desc == IORES_DESC_NONE) ||
+				 (desc == p->desc)));
+
+		if (resource_overlaps(p, &res))
+			is_type ? type++ : other++;
+	}
+
+	if (type == 0)
+		return REGION_DISJOINT;
+
+	if (other == 0)
+		return REGION_INTERSECTS;
+
+	return REGION_MIXED;
+}
+
 /**
  * region_intersects() - determine intersection of region with known resources
  * @start: region start address
@@ -546,31 +574,13 @@ EXPORT_SYMBOL_GPL(page_is_ram);
 int region_intersects(resource_size_t start, size_t size, unsigned long flags,
 		      unsigned long desc)
 {
-	struct resource res;
-	int type = 0; int other = 0;
-	struct resource *p;
-
-	res.start = start;
-	res.end = start + size - 1;
+	int ret;
 
 	read_lock(&resource_lock);
-	for (p = iomem_resource.child; p ; p = p->sibling) {
-		bool is_type = (((p->flags & flags) == flags) &&
-				((desc == IORES_DESC_NONE) ||
-				 (desc == p->desc)));
-
-		if (resource_overlaps(p, &res))
-			is_type ? type++ : other++;
-	}
+	ret = __region_intersects(start, size, flags, desc);
 	read_unlock(&resource_lock);
 
-	if (type == 0)
-		return REGION_DISJOINT;
-
-	if (other == 0)
-		return REGION_INTERSECTS;
-
-	return REGION_MIXED;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(region_intersects);
 
-- 
2.20.1

