Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44742349DC4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 01:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbhCZA1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 20:27:36 -0400
Received: from mail-bn8nam12on2047.outbound.protection.outlook.com ([40.107.237.47]:37101
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229695AbhCZA1M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 20:27:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ewc9kXGQlOzA25PXL70qTSItlk0Y0RR3tq0OrekP21mWg4ErJKReUNABZDq0dOd20LfzrgPifLMydaPodf1izo3kjTev/5OnZgrQRh35BKxRYnmeugKm72K5D1fOtjwoRzrP/TPtmfN0ZqqvUTw3p+HuCswviKi5HWCDfQzwi6jV1VnGVQn1UR0DWDWbF3YmNTQf4VYwN9hdw6rg4vqPryiM9QQIor9Vrz/WE2+nnbL+ASrFvjRGa5LAx1p5xuIQkOf6SG85X1sYN7r+whUrK75alUOQWWtLaDFUMIgAVZRYRm3d0n5IMUvLQEyrxuccNCvfnnrzJOilOaPBzfK/Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S5c77yfT08P+tcKf4sD72z7R90T5zxfE/oli4naVWX8=;
 b=W5WATuWFjrapruShEtZYV+a/tNYtU3t75xzQSvP7Rhi/rcQLTNUJsK/E4SW5wlznP+Pq7PtQiaHsbOIQMNRdegfdlxUzkgPnqmDq3vpxK0KPHLXv8vXUGTrc2B5yFyvUsMipUijYxXOydXO4YFkqPQrfgU8uLWY8K4CCZpDcGmO/Id4djgIPmJpdCL1h7glfdx9QWFUv/SfiqMobcht/M/1xx4oFEXEikf609SacExafk6wyl2HgqHdZj0/Hd+pBI0rDMjk9yyud90ieim3ganRPAxdhzQ9CbQI5fl5keGTqUiIiDNkhfVmWEfIjGe8FSbBEChF+ykHKgZPVgExL3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S5c77yfT08P+tcKf4sD72z7R90T5zxfE/oli4naVWX8=;
 b=lH7DUoCBqfGSq2z0/5RkKBXR6MVoYybpcDUGPCmzm2xJ77pkoFUOt4HH5JiSUwwCqSAG9gRVmpx9XXzzNSNklrOjn4qoEvR3do5v+FPUECabfX2Ss0tKZmZxKKZVrjmI+4nCO65lMuZ8SkdhHq1P3+ZSE0bxUTzNv2Tl1OSoy6iAc9cb3W29nqevc9aJFMD9MV2wJ5uAOJEpHoub3D+lRlIP5AW0e1A+38jPfNolM1rK7wnWdgVUjIL+UGT2D3+TA7laCtAWjzCOyy/nmJmO61OpRK6SawDlZ/t3Z/tX9fldiJtwKV7XcceJ3qF4hrSJJGNEvMngQXeEfFSoNnFp5w==
Received: from MW4PR04CA0184.namprd04.prod.outlook.com (2603:10b6:303:86::9)
 by MN2PR12MB3053.namprd12.prod.outlook.com (2603:10b6:208:c7::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.29; Fri, 26 Mar
 2021 00:27:11 +0000
Received: from CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:86:cafe::ef) by MW4PR04CA0184.outlook.office365.com
 (2603:10b6:303:86::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25 via Frontend
 Transport; Fri, 26 Mar 2021 00:27:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; ffwll.ch; dkim=none (message not signed)
 header.d=none;ffwll.ch; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT037.mail.protection.outlook.com (10.13.174.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3955.18 via Frontend Transport; Fri, 26 Mar 2021 00:27:10 +0000
Received: from localhost (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 26 Mar
 2021 00:27:09 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <akpm@linux-foundation.org>, <david@redhat.com>,
        <daniel.vetter@ffwll.ch>, <dan.j.williams@intel.com>,
        <gregkh@linuxfoundation.org>, Alistair Popple <apopple@nvidia.com>
Subject: [PATCH] kernel/resource: Fix locking in request_free_mem_region
Date:   Fri, 26 Mar 2021 11:26:27 +1100
Message-ID: <20210326002627.2940-1-apopple@nvidia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a389eab-8f5e-4f33-d4ae-08d8efede56e
X-MS-TrafficTypeDiagnostic: MN2PR12MB3053:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3053339C828BD8033DB961A7DF619@MN2PR12MB3053.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b9f+HOoNAsnVOw6wlZUymzJesmJvhMtUtjCe0DmxpXP6GXgQRh0BIymfey+FIFeDckjGCQndvCf/H1LG2ZJN6AypeYnYOm/IuRAQdUZahtLNvTeThg1/wrFSv1zzEgt1jTVgwxumxDIMLJ6u+APL95HPny4BFjSbBKEF/6WeYW+8+A+pgJlFRAwX7SBDK6R/L/sXZrJab/Dr72kgbB8XXQ/iCr5E+FoefHiam6Dcs96VNpaWvPVDuOKuEvvKUybgdKH5ray2eFi1NeJnDd3M/bCbTFvv/XNYy7U8zp/XalE/bHszzy2NRTvXCDV8vVr9lVFH1C4hNO6ifammP8sSmyQwOoY+jBGu1fHjnQeirLlukxo/Oy9n5FkpEcTlYb030ibikIwWMF4U2G31fWnoeakwNvrwM/UXlFn3mEBYGlyVJjDEOPUP45RXyYZZg8tRpJ9SCgYa5dw3xt0HbgD2J0hn7crYL/XMuy8jfVr9jvvVsQVBebyA3O8peffz0v3pvFUf77SClRK6lOq6g79RRwp/+BpaHaGS753ls6zHIq+n6lpB1MRwhHh0nACx3mn2Q1RazKu+97kntDOPPCaVxTbaDgDFhv6cgonHLayZ1Qy8P70KwQ2yWbfFVnAmg/tqnYLJyp9wFOYjjMJBFFOpdHkyjCcicuA4s7oouAvslR4=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(376002)(346002)(39860400002)(136003)(396003)(36840700001)(46966006)(82740400003)(8676002)(8936002)(1076003)(7636003)(6666004)(36756003)(336012)(6916009)(36860700001)(86362001)(82310400003)(47076005)(478600001)(426003)(316002)(36906005)(107886003)(2906002)(54906003)(70206006)(83380400001)(70586007)(5660300002)(26005)(186003)(356005)(16526019)(2616005)(4326008);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2021 00:27:10.7359
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a389eab-8f5e-4f33-d4ae-08d8efede56e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3053
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

request_free_mem_region() is used to find an empty range of physical
addresses for hotplugging ZONE_DEVICE memory. It does this by iterating
over the range of possible addresses using region_intersects() to see if
the range is free.

region_intersects() obtains a read lock before walking the resource tree
to protect against concurrent changes. However it drops the lock prior
to returning. This means by the time request_mem_region() is called in
request_free_mem_region() another thread may have already reserved the
requested region resulting in unexpected failures and a message in the
kernel log from hitting this condition:

        /*
         * mm/hmm.c reserves physical addresses which then
         * become unavailable to other users.  Conflicts are
         * not expected.  Warn to aid debugging if encountered.
         */
        if (conflict->desc == IORES_DESC_DEVICE_PRIVATE_MEMORY) {
                pr_warn("Unaddressable device %s %pR conflicts with %pR",
                        conflict->name, conflict, res);

To fix this create versions of region_intersects() and
request_mem_region() that allow the caller to take the appropriate lock
such that it may be held over the required calls.

Instead of creating another version of devm_request_mem_region() that
doesn't take the lock open-code it to allow the caller to pre-allocate
the required memory prior to taking the lock.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
---
 kernel/resource.c | 146 +++++++++++++++++++++++++++++-----------------
 1 file changed, 94 insertions(+), 52 deletions(-)

diff --git a/kernel/resource.c b/kernel/resource.c
index 627e61b0c124..2d4652383dd2 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -523,6 +523,34 @@ int __weak page_is_ram(unsigned long pfn)
 }
 EXPORT_SYMBOL_GPL(page_is_ram);
 
+static int __region_intersects(resource_size_t start, size_t size,
+			       unsigned long flags, unsigned long desc)
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
@@ -546,31 +574,12 @@ EXPORT_SYMBOL_GPL(page_is_ram);
 int region_intersects(resource_size_t start, size_t size, unsigned long flags,
 		      unsigned long desc)
 {
-	struct resource res;
-	int type = 0; int other = 0;
-	struct resource *p;
-
-	res.start = start;
-	res.end = start + size - 1;
+	int rc;
 
 	read_lock(&resource_lock);
-	for (p = iomem_resource.child; p ; p = p->sibling) {
-		bool is_type = (((p->flags & flags) == flags) &&
-				((desc == IORES_DESC_NONE) ||
-				 (desc == p->desc)));
-
-		if (resource_overlaps(p, &res))
-			is_type ? type++ : other++;
-	}
+	rc = __region_intersects(start, size, flags, desc);
 	read_unlock(&resource_lock);
-
-	if (type == 0)
-		return REGION_DISJOINT;
-
-	if (other == 0)
-		return REGION_INTERSECTS;
-
-	return REGION_MIXED;
+	return rc;
 }
 EXPORT_SYMBOL_GPL(region_intersects);
 
@@ -1171,31 +1180,17 @@ struct address_space *iomem_get_mapping(void)
 	return smp_load_acquire(&iomem_inode)->i_mapping;
 }
 
-/**
- * __request_region - create a new busy resource region
- * @parent: parent resource descriptor
- * @start: resource start address
- * @n: resource region size
- * @name: reserving caller's ID string
- * @flags: IO resource flags
- */
-struct resource * __request_region(struct resource *parent,
-				   resource_size_t start, resource_size_t n,
-				   const char *name, int flags)
+static bool request_region_locked(struct resource *parent,
+				    struct resource *res, resource_size_t start,
+				    resource_size_t n, const char *name, int flags)
 {
-	DECLARE_WAITQUEUE(wait, current);
-	struct resource *res = alloc_resource(GFP_KERNEL);
 	struct resource *orig_parent = parent;
-
-	if (!res)
-		return NULL;
+	DECLARE_WAITQUEUE(wait, current);
 
 	res->name = name;
 	res->start = start;
 	res->end = start + n - 1;
 
-	write_lock(&resource_lock);
-
 	for (;;) {
 		struct resource *conflict;
 
@@ -1230,16 +1225,39 @@ struct resource * __request_region(struct resource *parent,
 			write_lock(&resource_lock);
 			continue;
 		}
-		/* Uhhuh, that didn't work out.. */
-		free_resource(res);
-		res = NULL;
-		break;
+		return false;
 	}
-	write_unlock(&resource_lock);
 
 	if (res && orig_parent == &iomem_resource)
 		revoke_iomem(res);
 
+	return true;
+}
+
+/**
+ * __request_region - create a new busy resource region
+ * @parent: parent resource descriptor
+ * @start: resource start address
+ * @n: resource region size
+ * @name: reserving caller's ID string
+ * @flags: IO resource flags
+ */
+struct resource *__request_region(struct resource *parent,
+				  resource_size_t start, resource_size_t n,
+				  const char *name, int flags)
+{
+	struct resource *res = alloc_resource(GFP_KERNEL);
+
+	if (!res)
+		return NULL;
+
+	write_lock(&resource_lock);
+	if (!request_region_locked(parent, res, start, n, name, flags)) {
+		/* Uhhuh, that didn't work out.. */
+		free_resource(res);
+		res = NULL;
+	}
+	write_unlock(&resource_lock);
 	return res;
 }
 EXPORT_SYMBOL(__request_region);
@@ -1779,26 +1797,50 @@ static struct resource *__request_free_mem_region(struct device *dev,
 {
 	resource_size_t end, addr;
 	struct resource *res;
+	struct region_devres *dr = NULL;
+
+	res = alloc_resource(GFP_KERNEL);
+	if (!res)
+		return ERR_PTR(-ENOMEM);
+
+	if (dev) {
+		dr = devres_alloc(devm_region_release, sizeof(struct region_devres),
+				  GFP_KERNEL);
+		if (!dr) {
+			free_resource(res);
+			return ERR_PTR(-ENOMEM);
+		}
+	}
 
 	size = ALIGN(size, 1UL << PA_SECTION_SHIFT);
 	end = min_t(unsigned long, base->end, (1UL << MAX_PHYSMEM_BITS) - 1);
 	addr = end - size + 1UL;
 
+	write_lock(&resource_lock);
 	for (; addr > size && addr >= base->start; addr -= size) {
-		if (region_intersects(addr, size, 0, IORES_DESC_NONE) !=
+		if (__region_intersects(addr, size, 0, IORES_DESC_NONE) !=
 				REGION_DISJOINT)
 			continue;
 
-		if (dev)
-			res = devm_request_mem_region(dev, addr, size, name);
-		else
-			res = request_mem_region(addr, size, name);
-		if (!res)
-			return ERR_PTR(-ENOMEM);
+		if (!request_region_locked(&iomem_resource, res, addr,
+						   size, name, 0))
+			break;
+
 		res->desc = IORES_DESC_DEVICE_PRIVATE_MEMORY;
+		if (dev) {
+			dr->parent = &iomem_resource;
+			dr->start = addr;
+			dr->n = size;
+			devres_add(dev, dr);
+		}
+
+		write_unlock(&resource_lock);
 		return res;
 	}
 
+	write_unlock(&resource_lock);
+	free_resource(res);
+
 	return ERR_PTR(-ERANGE);
 }
 
-- 
2.20.1

