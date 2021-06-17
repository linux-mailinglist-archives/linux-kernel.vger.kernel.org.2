Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E96643ABD74
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 22:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232563AbhFQUdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 16:33:37 -0400
Received: from mail-dm6nam12on2072.outbound.protection.outlook.com ([40.107.243.72]:9600
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232251AbhFQUde (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 16:33:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fKowWPj+X5SCBsXtEsUue1nQ6ArE0zKF0F364tmDO5wg80cyRLX1pWdRFbdk6w0NencnBzn0THOlYxrd3ysYh15j1OO0FCn4lpX7vcWegxb0Xo4bryP1/qaX/TJu7SOwI/aMEl5+GOgWteESzj4y8dQDGUftlmGuIdl5E9jMHYxzRpicUxojSuTd3IO34aZ6phMRfk2qHL8yDxv6KiKDWCBWRCHWe3pGC9pQm+fdlmAMBFIMTyTjPKrM4cgEvS+7KkP+qNdCvB1C/KGP7tiHdl+/inyV9LR2pYCuh8b2s+Za+QDz1+xcR3vdD5MqXhhPjcDaJMNy9zlL5dOprV+ZWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=puKPBezRT9fUIkMFIvM/G+KDl1JuGQcndOZbFsIBBN0=;
 b=dvOmRiRJfjD7eZu36dC4mlOljCQEbu4sbsm9B3AhplRsOLyNaPeu8Kgbo/P5FR3NDJzbiHb+Mo4fyVsY5cL5npxl2A+geNB6vjVpmRfz74l/ivY4txtDljTbi0JrfIjPSneo1r504W6Lz09hwYEg5YxIHxz4D3sb09q1mxYnA4vmYDR+JZR6aLiF6FCNxks6ZbD5zMb8jSa1R6Ybq4LKvOENwLHy5XK8eBKJBTWeHCm2Wqo6cYT6Vk0VV0hyr05DwxfDG1qdGo45PdtT4rSdVxoqmobArNzniFQ9pn3UYQTPnXZhW6YaCMSNScS4XjGCnh9UUBJhsPwRYjJclINT9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=puKPBezRT9fUIkMFIvM/G+KDl1JuGQcndOZbFsIBBN0=;
 b=AwLSENYK7iezsklqqs45QfnUOZgAh6ik7BHcjAx+7Arw6k11FwclRxlFb1yCF3UOguECxKQgyYBRlNn+nQ3AcKQM6ESIycyJ94gKapksHrKsmW1ThBVUl1ktlGipiATdhxMCoj2stNo+XRF4GoYsSCw8aHkC2XmPzU7HZgZwK9xkz9Ib2IPXBqtlQGn/5rVEr3o1+bs9Q3W+uOFSo7Ol1dMbzKnQXyrWzonQ+dVmAeQbpgHvJmzAsX4e7pUbWiZJ6o1vjmdRVHaWGAnt2AQCOLITV4BwmydsWLXxjv8njmaHUijVG9Qf3oD3ut5nMXx4iVm64wEmp1fBRdT7MXQMOA==
Received: from DM6PR17CA0017.namprd17.prod.outlook.com (2603:10b6:5:1b3::30)
 by DM6PR12MB3001.namprd12.prod.outlook.com (2603:10b6:5:116::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Thu, 17 Jun
 2021 20:31:25 +0000
Received: from DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b3:cafe::af) by DM6PR17CA0017.outlook.office365.com
 (2603:10b6:5:1b3::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16 via Frontend
 Transport; Thu, 17 Jun 2021 20:31:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT012.mail.protection.outlook.com (10.13.173.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4242.16 via Frontend Transport; Thu, 17 Jun 2021 20:31:24 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 17 Jun
 2021 20:31:13 +0000
Received: from amhetre.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 17 Jun 2021 20:31:10 +0000
From:   Ashish Mhetre <amhetre@nvidia.com>
To:     <amhetre@nvidia.com>, <robin.murphy@arm.com>, <will@kernel.org>,
        <vdumpa@nvidia.com>
CC:     <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [Patch V2 1/2] iommu: Fix race condition during default domain allocation
Date:   Fri, 18 Jun 2021 02:00:36 +0530
Message-ID: <1623961837-12540-2-git-send-email-amhetre@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1623961837-12540-1-git-send-email-amhetre@nvidia.com>
References: <1623961837-12540-1-git-send-email-amhetre@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9ff37436-257d-49c3-2613-08d931cee099
X-MS-TrafficTypeDiagnostic: DM6PR12MB3001:
X-Microsoft-Antispam-PRVS: <DM6PR12MB300166633265E6A1BB8B8FB3CA0E9@DM6PR12MB3001.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AY4p4tTAEP70XUoC/nbI4y6rv1DFBwX0dWJpKkxCaYvpiMvqddFGOmxsnHmWurIGVEoICJnfjtt7DKA9o+lz7/0bsqALtYEg16X6c6nsatayFJq4UINVZU2BRAYznANoyq6xIj6TdxC9khbWrpO5tF4KWeD8XI79qH1en9pR6TrYfapWYe9iWwBSDTiJx7zAe7efkG4m8OnzVFxyu/A2IECny9UHY8izLyfpqybQ79IE9x3x+9LERZwIj7u07oS7Sg4LZShpR0YSehybDrKlDJHUaZD1CZ85YvqgNHdtLyajYwY8iQCj/zaVytaqMkKTDrIG6s6KE6Gmh+A5xJkg6XKbVvfuMqRbrYsWX54y156P76413wDCt1+K8YLWlOeaXbE28e22znLMZ5dXrWmCYCY1VDnc9ierOnNo3WQxyO5W+jb7dpXubM+AqTyDXTTzxVHs9mJnK0Z6Wfdr2Vn1zzbBvmLaUB5De6r8z/h1hN1uP5BLmHrm2/T8G/eKXDjLhXsAWhpBZ+gO9IHFLlPq96kaZ/6Mqzcq1wWqSTImzl29z+CDhn1tgouFHGnqKFKe+CIdQwSH+/octUuBfz4CCasooIouoPfj1Ae9AguJmX3Sl8Qjc+pcSfjo+Hk+aPs1u4+7FzRJ3duTLcBDwZUPRkE66IWC0a8NFQer34u6wnE=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(136003)(39860400002)(346002)(376002)(396003)(46966006)(36840700001)(336012)(86362001)(36906005)(6636002)(316002)(82740400003)(6666004)(36756003)(478600001)(2616005)(36860700001)(426003)(70586007)(70206006)(5660300002)(83380400001)(8936002)(4326008)(26005)(186003)(82310400003)(54906003)(7636003)(2906002)(7696005)(110136005)(8676002)(47076005)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 20:31:24.8144
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ff37436-257d-49c3-2613-08d931cee099
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3001
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Domain is getting created more than once during asynchronous multiple
display heads(devices) probe. All the display heads share same SID and
are expected to be in same domain. As iommu_alloc_default_domain() call
is not protected, it ends up in creating two domains for two display
devices which should ideally be in same domain.
iommu_alloc_default_domain() checks whether domain is already allocated for
given iommu group, but due to this race the check condition is failing and
two different domains are getting created.
This is leading to context faults when one device is accessing the IOVA
mapped by other device.
Fix this by protecting iommu_alloc_default_domain() call with group->mutex.
With this fix serialization will happen only for the devices sharing same
group. Also, only first device in group will hold the mutex till group is
created and for rest of the devices it will just check for existing domain
and then release the mutex.

Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
---
Changes since V1:
- Update the commit message per Will's suggestion

 drivers/iommu/iommu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 808ab70..2700500 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -273,7 +273,9 @@ int iommu_probe_device(struct device *dev)
 	 * support default domains, so the return value is not yet
 	 * checked.
 	 */
+	mutex_lock(&group->mutex);
 	iommu_alloc_default_domain(group, dev);
+	mutex_unlock(&group->mutex);
 
 	if (group->default_domain) {
 		ret = __iommu_attach_device(group->default_domain, dev);
-- 
2.7.4

