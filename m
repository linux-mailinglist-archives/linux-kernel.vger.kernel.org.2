Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D50B363C10
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 09:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237611AbhDSHEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 03:04:14 -0400
Received: from mail-dm6nam11on2047.outbound.protection.outlook.com ([40.107.223.47]:60928
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237527AbhDSHEL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 03:04:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LN0PVBmDNWV1Nvbb63xP+ifHm9wP80j5dOUhIBbW/3aK9jOIxihK4LiJRr9Mk06tekUIipTLxWve+CDLQadBwJi0YGwK3Z+9tlOiQsdZdlbSTUPxZGE1k9dKQndcuO5g10W1/mclQmAe/B3z5UvdrqZGNVVp1T8U9Tv/Ry+ajxqqAnbrYVqpJzt3/COvjSO5x6a3EHZOwtEBCp+ZLeIK7MihRvm2ZvYafsTyQ1umM0YMBd445NYfXxuGzA7ZYiNkkVhPJ3iisDxYNq/qYWmncFWcn7V8Q/vm278SYjoKC6D9nbR9XipjNKuG6o+ZjJzRlJi9wfx5j5YJGXEbM2BVfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fz5Jl18ipxfKlZkLstgAzMwTuJm/W5tPC8M5dUd3aDs=;
 b=M76/+aNBalHLje2s/jh8HjMivqS2sgX+C3a8S778BN3QzIArE6roSZsOc2YN8u6Uk8wsCSqQja9tB5zm70IxM1PZUWwGiST8L1GxF6uSyU8pNgYgQ1QzjmSbzJtMprIXTSdG15k4DqFHgsMGE+9/82EdflxGKZ5hrO48g1NB892OOz2i36lWsYqtfHvx5PkNXxA3fLz8etxfPgbD2SvFRf9YGPQHKTWcCAvbxWHBanPY82s31JOjVk7CBeLYp+Sp/jdqyocuo8AhTJdsKKuuP34bBlKgKg5hLyvPIOPDja/W9hcoWunGHKsVB3Crm0I8ye+Bzykr9Wjnl5bTfpj8GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fz5Jl18ipxfKlZkLstgAzMwTuJm/W5tPC8M5dUd3aDs=;
 b=nMMLVaXxjldQxg7O9Y67RfcB7EoLzFm9fDjfzEs4M805RfKJ67xTvbEo2tvh2P8WLBeF29YpfJNIP9CkWxNdF9EVN97qC6CUGzEJD+NJyAkL8pR6YD0GbEAhkbWSDMXYhrjrTXbuQmmnhnevoqXPgfrAIxS//lzBjvrcVsZk1/hGn7KksS2iTRzhkoZ84/prLciVX4Uo0W12K+oOpOBl+3dTriMI5stnJWhu6F6A9uckZHXpuRmIP0wFWMsd8dDQVcShyoRpdB+N+Zvb5rxD1wn7aGYtTF/Xi6Lr/FtVxhnBh8yssb9gUrxKHzxMhY88lsLZO5K+/F2a6EwKY0qBlg==
Received: from DM5PR21CA0022.namprd21.prod.outlook.com (2603:10b6:3:ac::32) by
 BN8PR12MB2868.namprd12.prod.outlook.com (2603:10b6:408:9c::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3999.29; Mon, 19 Apr 2021 07:03:39 +0000
Received: from DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ac:cafe::3c) by DM5PR21CA0022.outlook.office365.com
 (2603:10b6:3:ac::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.7 via Frontend
 Transport; Mon, 19 Apr 2021 07:03:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT062.mail.protection.outlook.com (10.13.173.40) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4042.16 via Frontend Transport; Mon, 19 Apr 2021 07:03:39 +0000
Received: from localhost (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 19 Apr
 2021 07:03:38 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <david@redhat.com>, <daniel.vetter@ffwll.ch>,
        <dan.j.williams@intel.com>, <gregkh@linuxfoundation.org>,
        <jhubbard@nvidia.com>, <jglisse@redhat.com>,
        <bsingharora@gmail.com>, <smuchun@gmail.com>,
        Alistair Popple <apopple@nvidia.com>
Subject: [PATCH v5 3/3] kernel/resource: Fix locking in request_free_mem_region
Date:   Mon, 19 Apr 2021 17:01:09 +1000
Message-ID: <20210419070109.4780-3-apopple@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210419070109.4780-1-apopple@nvidia.com>
References: <20210419070109.4780-1-apopple@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 54cc4a17-7bb2-4bbe-7b2d-08d903014271
X-MS-TrafficTypeDiagnostic: BN8PR12MB2868:
X-Microsoft-Antispam-PRVS: <BN8PR12MB2868CFD306D5261B8DEC3296DF499@BN8PR12MB2868.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RT2EPy7i+xKmRZOPedLj7dJFH9bg3XPl2ak7lKIuEf1+yzdhxXTD4OLcNRSj4RVndNtksNnwHAQB9fim8vZC6MmvWTKc30MDm+aefx8FvzIpFIkew8VVtFedJdjKNBZMnYcCTR4DlETML1+FhUCSQP5u1L89AcqZX3DZMnMbnabuFbGk7EbNk6ghWo+KhzWSFhJ6c/pNHng/GQESggzPJMc5KXkF7smipjrQoGvbbCTX3pXw59MuLescS+OMqioQBeyBUjLu0RxOqd6Hje+P7gyNbLtQ7Qzt6d5QWwdsBsrlcVHuy6tAQK4GVUL2a7DvObeHyCR8XLbBI5YeTwgwqRXgRQRrbKld/jgF1zi7V4Y3nrqOmTonxKz5nh+mvW+1EXQvnn2UuEkMoHpT9ymvoDiJcu4pWBneE15kUFjsDiPh+NbEQF4Yba1zPX0TeKFI0fH+7m5XrMrYhtA9A9oltPTMLoHv23G0kpXMYP7XxpYlH8sOaThXe0l5si+DQsROSgWoKsvlOlTRDVL28Kyf8qhGKttU9+9kidGdyHFt3By3QKFfPJdBNQAOaUiYr7Ccu2J2t8I2VBhLHm7Nucfc7+mq1C7A+1zsoCiwXuL4CtNG/kraSJ7mSpyuHqiCmKuX8m4bdxGX0CR7f8/i9LQFNUVdd1jXoXtz06nWXiRkizY=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(136003)(396003)(39860400002)(376002)(346002)(46966006)(36840700001)(70586007)(36860700001)(70206006)(8676002)(4326008)(5660300002)(356005)(6916009)(26005)(83380400001)(47076005)(316002)(2906002)(6666004)(7416002)(82740400003)(107886003)(478600001)(8936002)(54906003)(1076003)(7636003)(16526019)(2616005)(426003)(86362001)(36756003)(82310400003)(186003)(336012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2021 07:03:39.3200
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54cc4a17-7bb2-4bbe-7b2d-08d903014271
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2868
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

request_free_mem_region() is used to find an empty range of physical
addresses for hotplugging ZONE_DEVICE memory. It does this by iterating
over the range of possible addresses using region_intersects() to see if
the range is free before calling request_mem_region() to allocate the
region.

However the resource_lock is dropped between these two calls meaning by the
time request_mem_region() is called in request_free_mem_region() another
thread may have already reserved the requested region. This results in
unexpected failures and a message in the kernel log from hitting this
condition:

        /*
         * mm/hmm.c reserves physical addresses which then
         * become unavailable to other users.  Conflicts are
         * not expected.  Warn to aid debugging if encountered.
         */
        if (conflict->desc == IORES_DESC_DEVICE_PRIVATE_MEMORY) {
                pr_warn("Unaddressable device %s %pR conflicts with %pR",
                        conflict->name, conflict, res);

These unexpected failures can be corrected by holding resource_lock across
the two calls. This also requires memory allocation to be performed prior
to taking the lock.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
---
 kernel/resource.c | 45 ++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 38 insertions(+), 7 deletions(-)

diff --git a/kernel/resource.c b/kernel/resource.c
index 75f8da722497..e8468e867495 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -1801,25 +1801,56 @@ static struct resource *__request_free_mem_region(struct device *dev,
 {
 	resource_size_t end, addr;
 	struct resource *res;
+	struct region_devres *dr = NULL;
 
 	size = ALIGN(size, 1UL << PA_SECTION_SHIFT);
 	end = min_t(unsigned long, base->end, (1UL << MAX_PHYSMEM_BITS) - 1);
 	addr = end - size + 1UL;
 
+	res = alloc_resource(GFP_KERNEL);
+	if (!res)
+		return ERR_PTR(-ENOMEM);
+
+	if (dev) {
+		dr = devres_alloc(devm_region_release,
+				sizeof(struct region_devres), GFP_KERNEL);
+		if (!dr) {
+			free_resource(res);
+			return ERR_PTR(-ENOMEM);
+		}
+	}
+
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
+		if (!__request_region_locked(res, &iomem_resource, addr, size,
+						name, 0))
+			break;
+
+		if (dev) {
+			dr->parent = &iomem_resource;
+			dr->start = addr;
+			dr->n = size;
+			devres_add(dev, dr);
+		}
+
 		res->desc = IORES_DESC_DEVICE_PRIVATE_MEMORY;
+		write_unlock(&resource_lock);
+
+		/*
+		 * A driver is claiming this region so revoke any mappings.
+		 */
+		revoke_iomem(res);
 		return res;
 	}
+	write_unlock(&resource_lock);
+
+	free_resource(res);
+	if (dr)
+		devres_free(dr);
 
 	return ERR_PTR(-ERANGE);
 }
-- 
2.20.1

