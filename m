Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29E713617E9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 04:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236406AbhDPC6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 22:58:18 -0400
Received: from mail-co1nam11on2049.outbound.protection.outlook.com ([40.107.220.49]:43201
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234548AbhDPC6R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 22:58:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Snaw5DM9d03nR61oZ+8aOv1nIlYcEg99zcFcAN+ePoid6dnHOAx43N+7ksCZG3ZxHoo5bQ9h2AXvt5/0VUjuovgyxomFyrEhcxxn0cQSzOKh9r9Mnvr/NeAfZ6tqYDPWxc6g539T+F3MpL67d7iP+ckAU9eOXjzGlx7sbMY7ruNl+epH6qwjvnelqisGKCQPWQSfdaXkA0TWVK2ANmYXunvRAFdXgBq3NKHKhKEExVMBnXt5LaYtRHKAYgx1wocUyNKiFEwbtkn6TcudBaMd5KgCJCn9vN981xP8Zn0DCLgaTQahd9eKyO8BGp5ME4XaBD6jAGrykdtcmEBmVDGFHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZIPKHytiR9Z6OMBBWky13pFcoElsIG9yibQSkT6RgA0=;
 b=R334mThzRNS0XLbxM9s9+VaOOjV3nRR5Sa49i4h7JfIRAxr4QWRyKW8nPnTNomy0nW/yzStumr/feLx1d4hgz1zLKNzNc5JylmxJWa6c5O4NIUhuoYz+K7cXBIg3Ipvf87HnfnYKAJCn/FfxQMOf9ehwXYb7ErgIvoUl0RGhBw2n3Gk3/VK6YmZMlH9jiS4a/lDZiTZrqP/umuGzq4TMyF68lux3eTcGrZv2sP+MxxuEesl61nPLYBw1QEMBFlOHsSgbLgm4KVcESp7U9tx1+Y02RhVAPHyC0gOMI0KedGAIBIQkQHaX+nnOSwnIEMWiFji909CTi6xagvcerywxuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.35) smtp.rcpttodomain=linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZIPKHytiR9Z6OMBBWky13pFcoElsIG9yibQSkT6RgA0=;
 b=ZE++xn3ZSJkz6KEh6Pb8eDKOpYmsroibb1mZOQjruoK8LYJO6Idllm/n8idRbZVRoRPzvI5HRfmaJjtIdhrqHzj56STaUwZvEcSOK4EGTUU++sMTte+Q/MVBli2TyMIKnVr1jVdVm63f40ECy4ThottzHCmgmTFayC/tH6oF7j4r1f9XNIo5fENeihdXmfwaX16VW/T6CKL2SunSUz33NXs2YEMp2NEmKSWZdHCxYDm7yQd7OsP+LKFlEmoTefE6cBOItnNU+2oXv/9ZCtmrNvyI0xM1NnoIIxDGumGRNCWmFdvFJn81TAhipLfAdujctJcWVGnbwakmdx8VZR5U2A==
Received: from BN9PR03CA0277.namprd03.prod.outlook.com (2603:10b6:408:f5::12)
 by MN2PR12MB3086.namprd12.prod.outlook.com (2603:10b6:208:c7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Fri, 16 Apr
 2021 02:57:51 +0000
Received: from BN8NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f5:cafe::9) by BN9PR03CA0277.outlook.office365.com
 (2603:10b6:408:f5::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.18 via Frontend
 Transport; Fri, 16 Apr 2021 02:57:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.35)
 smtp.mailfrom=nvidia.com; linux-foundation.org; dkim=none (message not
 signed) header.d=none;linux-foundation.org; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.35 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.35; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.35) by
 BN8NAM11FT042.mail.protection.outlook.com (10.13.177.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4042.16 via Frontend Transport; Fri, 16 Apr 2021 02:57:51 +0000
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 16 Apr
 2021 02:57:50 +0000
Received: from localhost (172.20.145.6) by DRHQMAIL107.nvidia.com (10.27.9.16)
 with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 16 Apr 2021 02:57:50
 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <david@redhat.com>, <daniel.vetter@ffwll.ch>,
        <dan.j.williams@intel.com>, <gregkh@linuxfoundation.org>,
        <jhubbard@nvidia.com>, <jglisse@redhat.com>,
        <bsingharora@gmail.com>, <smuchun@gmail.com>,
        Alistair Popple <apopple@nvidia.com>,
        kernel test robot <oliver.sang@intel.com>
Subject: [PATCH v4] kernel/resource: Fix locking in request_free_mem_region
Date:   Fri, 16 Apr 2021 12:57:45 +1000
Message-ID: <20210416025745.8698-1-apopple@nvidia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 64eca62e-18ca-42ef-9745-08d900836cf0
X-MS-TrafficTypeDiagnostic: MN2PR12MB3086:
X-Microsoft-Antispam-PRVS: <MN2PR12MB30861080C4779EEA84F75B46DF4C9@MN2PR12MB3086.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1443;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8df7rxsLk5IAGGeE5K6TSzeBLA6hAovSwWsnSCjoGmO6NpTw6Q8Sdo1fzAHTlYJ6DbZj3PYbWcQ55NJJZiE/PKMLYr58Cel/HGIaerTUg646fWm/hMWhHwFVPLCDNxIEXKcKxeLlQ16CheRlSzNEyJDmagg23OeudmrVFUYbrIYUEiolNKhiTkIhnFb8o/IrErb3B1vhvUy4vf5KEaNl+n+APhvWVuCqHl+VS5HYaGGJKf/dRgEcuen0Bfa0R1mIjD87Z1O0v3q45ej5bq2IkYraHHTziqpTO1AB4WZqh/d/DyFW3ll53CMJu7Y39K98LRAaVJo3JIf4pZ928e/K39lkAiQqVzW+QM3bJqUj7T35ZdoaZRz8SNY1Qs6A1LBHQBC53Wg1K4gQHteyVJkCwsp1n0J3s7++QxEukD0W0654OU1361Q4PraStU93CvQNOHHJIVSfe6B79hZPEjA9+LlidGfljoZc869WKddWRoPORBSMeUygRK8FodEH7EaAAEGB/8ssikdvtky3VbiJ+t/+olzjtKTTwKclXmFjnxXoF8VLkaFgE9JJoDOB087TkbGl2BaI2nvgI1i5v46ekfcoyAvB9zqMmzNsVfuM6pi7iXYpPx9s2hlochCHXB669kNG1Dyl0RFcXrDk/pXhXT+wrDQoXDIkRLjYYcgqtd8=
X-Forefront-Antispam-Report: CIP:216.228.112.35;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid02.nvidia.com;CAT:NONE;SFS:(4636009)(346002)(136003)(39860400002)(376002)(396003)(36840700001)(46966006)(36906005)(26005)(70206006)(6916009)(316002)(336012)(426003)(2906002)(36756003)(36860700001)(86362001)(70586007)(7636003)(83380400001)(186003)(16526019)(54906003)(5660300002)(47076005)(7416002)(478600001)(82310400003)(82740400003)(1076003)(6666004)(4326008)(8936002)(8676002)(2616005)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2021 02:57:51.6239
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64eca62e-18ca-42ef-9745-08d900836cf0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.35];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3086
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

On some architectures and kernel configurations revoke_iomem() also
calls resource code so cannot be called with the resource lock held.
Therefore call it only after dropping the lock.

Fixes: 4ef589dc9b10c ("mm/hmm/devmem: device memory hotplug using ZONE_DEVICE")
Signed-off-by: Alistair Popple <apopple@nvidia.com>
Acked-by: Balbir Singh <bsingharora@gmail.com>
Reported-by: kernel test robot <oliver.sang@intel.com>

---

Changes for v4:

- Update commit log
- Moved calling revoke_iomem() to before devres_add(). This shouldn't
  change anything but it maintains the original ordering.
- Fixed freeing of devres in case of failure.
- Rebased onto linux-next
---
 kernel/resource.c | 144 ++++++++++++++++++++++++++++++----------------
 1 file changed, 94 insertions(+), 50 deletions(-)

diff --git a/kernel/resource.c b/kernel/resource.c
index 7e00239a023a..f1f7fe089fc8 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -502,6 +502,34 @@ int __weak page_is_ram(unsigned long pfn)
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
@@ -525,31 +553,12 @@ EXPORT_SYMBOL_GPL(page_is_ram);
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
 
@@ -1150,31 +1159,16 @@ struct address_space *iomem_get_mapping(void)
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
 
@@ -1209,14 +1203,37 @@ struct resource * __request_region(struct resource *parent,
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
@@ -1758,26 +1775,53 @@ static struct resource *__request_free_mem_region(struct device *dev,
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
+		write_unlock(&resource_lock);
+		revoke_iomem(res);
 		res->desc = IORES_DESC_DEVICE_PRIVATE_MEMORY;
+		if (dev) {
+			dr->parent = &iomem_resource;
+			dr->start = addr;
+			dr->n = size;
+			devres_add(dev, dr);
+		}
+
 		return res;
 	}
 
+	write_unlock(&resource_lock);
+	free_resource(res);
+	if (dev)
+		devres_free(dr);
+
 	return ERR_PTR(-ERANGE);
 }
 
-- 
2.20.1

