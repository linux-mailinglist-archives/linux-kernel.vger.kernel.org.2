Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6F15349E96
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 02:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbhCZBUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 21:20:53 -0400
Received: from mail-bn7nam10on2078.outbound.protection.outlook.com ([40.107.92.78]:43534
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230238AbhCZBUs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 21:20:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fw3ECI7W77bApciRKsHky2pLqVLxIYNpvkJ6PAXa/TXnVGgkK5ReNloPkkHhPO3S1dZOEVk10V1BMUl/YqpEG/QSl6xNq5LrzcxCEZDtvchtGl7Ye+7GBjUeEk5nF8+XIso6WjNZfTZn4q2s4AZGfo0/eh0WiAjZkIIyMBCm/iOIFWbxJt+nNHQd6xrGUZRnWqNRw5j5K8KCLsbCwAicDjZKZkr3fvj5NbwsxJhqUe7oH2oUm7bj1A3Tm36xuGusgLBm1Ln6mAYtZCR97BA8HrPDEdN6ayr6NKCcKVoTy0xM1S41yO83ab8jtDW/Qsfbn/L0gLPgwZ58eI/DiPva/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DJq2Zg2O8My+c3kEy9shm4bjAPIOXDlvdNrXJDVN7KI=;
 b=O0XjfDAul73As/VSWvdvF0l5iroWv5n2oyTP9tSk5queNChjsYc8DaBLClD6p97yXlj2swsj/H5ZrWs7mfTzJNERvfg/fyn3AlzdZsLB6iWpTkSdbH5oJrmSNZGnZWHxpW/uE0DTYvT7MGIY0DhX1Hn9VXwbQ2FKzEC9HrtINbmPBh69vAmd0Yli6yqSW8H4VItkxdNL7j93Xz6jWcW9VgC/k/xsfnTlDoWze2Q+EDqgLU3YOXu2jvzhY5zWyKMyOp1yQnv6aGrQ7OTLO22zj/1FqiBl53YMcInu0/0Jovw/wbQJveEyniQa+NmTPt0kWLGPZaclk8ICANRLzAHsJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DJq2Zg2O8My+c3kEy9shm4bjAPIOXDlvdNrXJDVN7KI=;
 b=P66MAcAr2keQfD3JhtEptyB1eARjggm+xVPNob65VOy0aH3NUs6aG6ctOVvrhHNWrsDigKBmgLwOejCg3uiueXTiMlE4y6D0OabUAmbxe7/xJBJ/rS54izTekhxgnnASccvyPK8GAUzK/52499fqvG7vQCSuZKP6g9IofU4f3il3ekROIxqKshkQtrVhfQ4qbSackorprTuHNYmMGARYzsi5Gr/0d0OpDV2swtKnq0kHmAxAR0naEHAXiXDlo3K7EZoQ6WTBfYXSqHo8lscvbckDfCr39P3TZH5ryiCKbXbjW6I/cC8jTCnGWEpwbAKaoeG0D18LKHho4ZYO+AetRA==
Received: from CO1PR15CA0048.namprd15.prod.outlook.com (2603:10b6:101:1f::16)
 by MW3PR12MB4348.namprd12.prod.outlook.com (2603:10b6:303:5f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26; Fri, 26 Mar
 2021 01:20:46 +0000
Received: from CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:101:1f:cafe::52) by CO1PR15CA0048.outlook.office365.com
 (2603:10b6:101:1f::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24 via Frontend
 Transport; Fri, 26 Mar 2021 01:20:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT052.mail.protection.outlook.com (10.13.174.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3955.18 via Frontend Transport; Fri, 26 Mar 2021 01:20:46 +0000
Received: from localhost (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 26 Mar
 2021 01:20:45 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <akpm@linux-foundation.org>, <david@redhat.com>,
        <daniel.vetter@ffwll.ch>, <dan.j.williams@intel.com>,
        <gregkh@linuxfoundation.org>, <jhubbard@nvidia.com>,
        <jglisse@redhat.com>, <linux-mm@kvack.org>,
        "Alistair Popple" <apopple@nvidia.com>
Subject: [PATCH v2] kernel/resource: Fix locking in request_free_mem_region
Date:   Fri, 26 Mar 2021 12:20:35 +1100
Message-ID: <20210326012035.3853-1-apopple@nvidia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4688ee6c-f1cc-4f81-5b34-08d8eff56205
X-MS-TrafficTypeDiagnostic: MW3PR12MB4348:
X-Microsoft-Antispam-PRVS: <MW3PR12MB434869145DADB7F4F9AEDB5DDF619@MW3PR12MB4348.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 27iThwzc36U4UiMUx/alW3tImzWF2WuqxB2apDGOu+UVCHq0Ga9TuLl2A/LUmObXYfmz76L7/k3YPBOKefVyWh0KvXkEo+zcj1jEYcVXCR4Ui7CFH1dht84CbAcDnzxWWR6PdaueKZvBfzo4DTu4FBqt0P4PjSt75u6/2yf3hoHh/RS/vIt+k0Z4d5okWZGeIygbkBzApNhkkXg1TtUYDsgaLYID+kPnTer04o1PuOYWiC1wCHE8GhNPvzM4PAEIFMEH6nvaf8Wl/FUJJVm0Fe6at0oL6totViCPJeHaVDzdiHmLwb55C7q0iPuSpj8X1TytcxybimrsHCBiPx4NkKHxbdAjIeMGNR390xJh/lI0rxFN+ibfn38ViE6YK9hVywDOuJ2Bi2XfNPsparsPDBFSLJVIhM2cu26kYQCrypWzon/0tDt+R8bbN5/ueiH7bwTTw67ZFicyHE7hiEXBNOxYZHFUsTOBSD3UuN2vcxNEImsh+yxQw1yC+8mZwY/ctK/q9hZG8YrYHi9k4O7niyFeKr4xLiyNMz7vTuqq0qw6mX/6/o5DVjBUyhJAShpZZ3PqbfgRfKZ7ToBubehuYo+16SMplRuWvBoUee0h7ndKDYBf08CfMF7bTTN5bgq8Xuhv+IIrG//tirjoapj2kajvrlBQlyjJveZShSMaOzI=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(376002)(39860400002)(346002)(396003)(136003)(46966006)(36840700001)(316002)(6666004)(5660300002)(7636003)(47076005)(16526019)(426003)(478600001)(107886003)(8676002)(1076003)(186003)(36906005)(8936002)(2616005)(356005)(54906003)(83380400001)(4326008)(82740400003)(336012)(2906002)(70586007)(70206006)(86362001)(6916009)(36860700001)(26005)(82310400003)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2021 01:20:46.2470
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4688ee6c-f1cc-4f81-5b34-08d8eff56205
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4348
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

---

v2:
 - Added Fixes tag

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

