Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4C6D34DD1A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 02:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbhC3Aj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 20:39:27 -0400
Received: from mail-mw2nam12on2063.outbound.protection.outlook.com ([40.107.244.63]:27968
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229557AbhC3AjB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 20:39:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fGi4UhdsxBMUgw6sPUYROcQesmTXnGCoXNQiZbCkg1X2pY8QkIA3AD0UsPzw/dybRDbo147WA+PZESvwLZijVW60yHynQECtixBspYDfx7/Zs4w+ij7JADVJ5sT0BsH2ebUa/dMSS4FS53W15rpWlC2jFfzm/y5r78mzQ9bkHRFxbBHZT2ZVA6OQdp12kxxeEogNliJt2X4EYqAVr9f9OeTVo/YrM5rLaYsmPIVK6DSvAyL+wQ6kCACQ5JCApvQQryp2mkqwcdnfFVIiCs1MXhrZzmkm+t4e+hOzKat7SgZ7tyvdmn2N02hLi9NQeasQQSjgjo5J/zpABPDlorSgkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RvhHPX1m2DBKMDvc8kiOgCSfq9poiJAO1pmRNCdpqUA=;
 b=KYVtwDTfTZy2qXhY1AGCss5KEL7n+YgwKuDj4Z2swLMajQ+nDS8OX08mkEYvkgp71mMyb0ZifZSSbzzn4q9Nm33Uj/m6f+XZ7lBoU/b9PFy2uPxfIoHz3LwICotDKK4wcPNC5hdqsch4r8SBFKprMe04khlU7xR43osgrDvzH4yH5u1TVDRf/9tChVTmGWz2kdx8I0B87NGXsB7PdwpuwwRV9ZgbHJMRAcrefTTclcQgRBN7rL1U7NxIE53mqYctvaR0ObwuRsx0vtAVlhHtkiCMUkCi7+iuArfYvJbis40jTDGmWSZA1x/6dVfcsSN0OpJocWfFxDblqbbEyvtaYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RvhHPX1m2DBKMDvc8kiOgCSfq9poiJAO1pmRNCdpqUA=;
 b=ETdH81D59OYLiS0oafhGl9iS+KMg9rK3l2DJS1A9EWfgWHBt5PwQAIIcjwVEADMMsmcJHWdkCCyl9l2R8pfkje4gNHS414ZTAsR1kBDfDfFQackNNOsLDKD4qvXR50SQV4ZnfWR3HvmFebFDFCJC6NdRFsWmrg7SWv72s9SBF4wmpOaRBB7KUv1SeOFp3j/x/MeFU5YZeArTBAgrOHLyjCGpDC6J/Bj3bIn1ycgK/4FOmMEac00RTreJMLx4Btu1gIDQJk9KQM9Ny3nArobq//EmYZ5+oQtNri/83OJMhPPi5xHqcQxRZO552S/D1IIpbUE9nRUZe/Fet/pR24xtWQ==
Received: from BN9PR03CA0431.namprd03.prod.outlook.com (2603:10b6:408:113::16)
 by MWHPR12MB1952.namprd12.prod.outlook.com (2603:10b6:300:114::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Tue, 30 Mar
 2021 00:38:59 +0000
Received: from BN8NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:113:cafe::12) by BN9PR03CA0431.outlook.office365.com
 (2603:10b6:408:113::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24 via Frontend
 Transport; Tue, 30 Mar 2021 00:38:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT033.mail.protection.outlook.com (10.13.177.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3955.18 via Frontend Transport; Tue, 30 Mar 2021 00:38:59 +0000
Received: from localhost (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 30 Mar
 2021 00:38:57 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <david@redhat.com>, <daniel.vetter@ffwll.ch>,
        <dan.j.williams@intel.com>, <gregkh@linuxfoundation.org>,
        <jhubbard@nvidia.com>, <jglisse@redhat.com>,
        <bsingharora@gmail.com>, Alistair Popple <apopple@nvidia.com>,
        "kernel test robot" <oliver.sang@intel.com>
Subject: [PATCH v3] kernel/resource: Fix locking in request_free_mem_region
Date:   Tue, 30 Mar 2021 11:38:42 +1100
Message-ID: <20210330003842.18948-1-apopple@nvidia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 45070697-4b22-43da-6e4e-08d8f3143554
X-MS-TrafficTypeDiagnostic: MWHPR12MB1952:
X-Microsoft-Antispam-PRVS: <MWHPR12MB19524BFB6300E9346D852D07DF7D9@MWHPR12MB1952.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hkAt10ewZ9D28Mg4zwfl3IB3Z8/+KP1xu19PLtd2ubWgSD0QxIqz4ARbZN9op5+VCNI1BUBIevlgtdu0+2wRoNgTmLsAGStxuWuoFbvRABrYkzja+z6dCND0aHaUHIdPhLMvtTHvypuJlDkogfMDhNeQxafAHuJQsgvFNE+v06wRXQ9HwbeV85ST84PICXBSVRiJFh9fLDjgCifS9jnTjJBwPTBULb7GfzGIXx9kh2jtXfqZPBZT2Hy0U84M0c9qe94/daY37ZWGCCpsBjFtnXwWptecZY6gQbEIvL5mmDcPcNFH3pCocBhUpj6ZrKYHRdGJJetoLF9aBREjZ9XyafydGEvrXng/5X7lXr1RvPo5x0DY+8TZu64oPxyNc5Z0irWQYdz363EOEbeCKWwFKeUdiY8NZQsrHQWvaiPgZbQJMFfeR3q6+xuVfAGqfYft0yQEJ4Y1us6YWfJZdi6btqZg7NSg9zn6/hOHo3a+nxPQqWtm9TmOI3tZ4c6MpEg8A0JUto4RhZdAQcecrjm8/tPdXYhQyVxeFpNhFVLHg3qdVwwRFPBjiMHrITlmPIDEBJARmjL6isL0XUxlvkeqBvbDfqtyAa32MgZRf/ybGQ/gV/U26K28vZP0P8RAUEZh0ITNZL/ZkNEUeW6kri3FrfCHvBnf3nob2rd14DtSyTk=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(396003)(346002)(136003)(376002)(39860400002)(46966006)(36840700001)(86362001)(82310400003)(478600001)(1076003)(7416002)(83380400001)(36906005)(47076005)(26005)(70586007)(8936002)(426003)(5660300002)(2616005)(6666004)(82740400003)(7636003)(4326008)(16526019)(186003)(2906002)(336012)(6916009)(8676002)(54906003)(36860700001)(356005)(36756003)(70206006)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 00:38:59.0857
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45070697-4b22-43da-6e4e-08d8f3143554
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1952
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

Fixes: 0c385190392d8 ("resource: add a not device managed request_free_mem_region variant")
Fixes: 0092908d16c60 ("mm: factor out a devm_request_free_mem_region helper")
Fixes: 4ef589dc9b10c ("mm/hmm/devmem: device memory hotplug using ZONE_DEVICE")
Signed-off-by: Alistair Popple <apopple@nvidia.com>
Acked-by: Balbir Singh <bsingharora@gmail.com>
Reported-by: kernel test robot <oliver.sang@intel.com>

---

Hi Andrew,

This fixes a boot issue reported by the kernel test robot with the
previous version of the patch on x86 with CONFIG_IO_STRICT_DEVMEM=y.
This was due to the platform specific implementation of
devmem_is_allowed() creating a recursive lock which I missed. I notice
you have put v2 in mmtom so apologies for the churn but can you please
use this version instead? Thanks.

 - Alistair
---
 kernel/resource.c | 142 ++++++++++++++++++++++++++++++----------------
 1 file changed, 92 insertions(+), 50 deletions(-)

diff --git a/kernel/resource.c b/kernel/resource.c
index 627e61b0c124..7061b9f903ca 100644
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
 
@@ -1171,31 +1180,16 @@ struct address_space *iomem_get_mapping(void)
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
 	DECLARE_WAITQUEUE(wait, current);
-	struct resource *res = alloc_resource(GFP_KERNEL);
-	struct resource *orig_parent = parent;
-
-	if (!res)
-		return NULL;
 
 	res->name = name;
 	res->start = start;
 	res->end = start + n - 1;
 
-	write_lock(&resource_lock);
-
 	for (;;) {
 		struct resource *conflict;
 
@@ -1230,14 +1224,37 @@ struct resource * __request_region(struct resource *parent,
 			write_lock(&resource_lock);
 			continue;
 		}
+		return false;
+	}
+
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
 		/* Uhhuh, that didn't work out.. */
 		free_resource(res);
 		res = NULL;
-		break;
 	}
 	write_unlock(&resource_lock);
-
-	if (res && orig_parent == &iomem_resource)
+	if (res && parent == &iomem_resource)
 		revoke_iomem(res);
 
 	return res;
@@ -1779,26 +1796,51 @@ static struct resource *__request_free_mem_region(struct device *dev,
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
+		revoke_iomem(res);
 		return res;
 	}
 
+	write_unlock(&resource_lock);
+	free_resource(res);
+
 	return ERR_PTR(-ERANGE);
 }
 
-- 
2.20.1

