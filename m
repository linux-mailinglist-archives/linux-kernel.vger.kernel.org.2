Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5C2239CD78
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 07:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbhFFFdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 01:33:47 -0400
Received: from mail-bn1nam07on2070.outbound.protection.outlook.com ([40.107.212.70]:29495
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229465AbhFFFdq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 01:33:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VauwEKaUe1wm3UH+TgkY40BPAoelr6FIKgK8hcYXZ3cq2GnWgu/Fu073aBwqLrKaB+P7yVcVbngcs/4sSNa7adE/EANyjdI/nVssNSFfDklYTtK6GHICJSX+dkXl6+wzsxCUR5wQRDp15e5E2SmD8zP8FZztLkDiyY5V8PyHrkRNGEVLUx07KtkXTo3pX1uAyY+v8NAascXXc2p2yULbtOOG+3Ckr/vJ0xpZ6j8kx3TPTRCTh2ofkQKpZTrkGF/IIbkbZikfcMt16hGoQs3prsu25LFJu22IneEeGKwnn9q9UExJ8yCfG7kBJDqNUhNMVsvYm57CtkOkq4PPNJILJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+2Iqi/4bY8KVjUp8KSNA4BPu278ONFcMXNTlq5+PJWc=;
 b=fOXdM6rdXJFMv4TekqjU01mIMsjjTM4lVchF5TVVRjUB8gtVrq7xEaekXj6W79tQ7Ln5HpogqBIAx1S6C33tBRrAOBh9wIayh8WPMV+ursmNKaW9YAfWNJNgS6rJDAji0mfB8SlEviSSe8/KSXb1Y4gNAtqY0n4f1Tb4EFsnpKbybO53r3mTNrJsHrOa5tis/Rpf7EpS7IZkkFrVChX1cNzOPXqd5OHi+7mnYWKIAmqcBkmE40fmgI8VgxJkOVbJ9J5+w3Zf3FimYlnzPb75diY50d0tH/Hp3aspS6aPICDxzmCPnLmW+o4C79FyM9a7B839Fl9hy46S/FJaQ3b0IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.35) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+2Iqi/4bY8KVjUp8KSNA4BPu278ONFcMXNTlq5+PJWc=;
 b=gtbasUDDB9CXDKSmlifmbZ2ni4P/nv4Ko8R84Dqx6qRGHBW44oLKtKPYEQoHPVXvu0rICOq01L2OTUPv9CdgG1noF2Rtig1Ha2RVz8ZalmygE0JRPgj32XdMCTTyYFk1BpKbKsRXtwZ9nJdIHLQTIngk6CUcqs9xjJgAf0B/EehurubZZi1KxK4w4pO1GxZYcy7CD19H37YnRM203l7++RjrjDMcFtxRECUIs3InTsRF/qDJxqU4Ua9Doe+T4YwPU4fOPX+AXrvQ5STKtpYC7dcXH5ziGSW7HqHEMv/Iw1ohJeVvk2Iu6RLgapYFh7X4YEJDk16EdRwd1eNoGT4Nbg==
Received: from MWHPR18CA0058.namprd18.prod.outlook.com (2603:10b6:300:39::20)
 by BL0PR12MB4722.namprd12.prod.outlook.com (2603:10b6:208:8c::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Sun, 6 Jun
 2021 05:31:55 +0000
Received: from CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:39:cafe::57) by MWHPR18CA0058.outlook.office365.com
 (2603:10b6:300:39::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.21 via Frontend
 Transport; Sun, 6 Jun 2021 05:31:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.35)
 smtp.mailfrom=nvidia.com; lists.linux-foundation.org; dkim=none (message not
 signed) header.d=none;lists.linux-foundation.org; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.35 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.35; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.35) by
 CO1NAM11FT051.mail.protection.outlook.com (10.13.174.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4195.22 via Frontend Transport; Sun, 6 Jun 2021 05:31:55 +0000
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 6 Jun
 2021 05:31:54 +0000
Received: from vdi.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 6 Jun 2021 05:31:53 +0000
From:   Eli Cohen <elic@nvidia.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>,
        <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     <elic@nvidia.com>
Subject: [PATCH v1] vdp/mlx5: Fix setting the correct dma_device
Date:   Sun, 6 Jun 2021 08:31:50 +0300
Message-ID: <20210606053150.170489-1-elic@nvidia.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0adec6e0-b46f-42bd-6db2-08d928ac6598
X-MS-TrafficTypeDiagnostic: BL0PR12MB4722:
X-Microsoft-Antispam-PRVS: <BL0PR12MB472255BE0C21638DE7F6A316AB399@BL0PR12MB4722.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:245;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3f8XfqcCjUChKgFgnafm1budQQJDlkviHdAwLxUc2ezx0W4mvyedIsYxwIqImH4wYp+IZarp69mQWD43FktfJ7QqT6mYHzZwHngWWVCxNqy/a6JpqaifOEQjQR8b+ku311FMQm5TT0FOgMviFGH3XqNpjWGlipweDzd+zWx155DFC8c/N3cu4gSK+CxJrYQ0v6NOjWORizHt15LuRctcJCEf1fSJmEwOlS89DFLaBYyS9mhjzLkznd1nqF1hAB7YkWFua+eIvL1hgbSnTzcpceqz2mHFqQhmu8P8rKuMfYC/fqpQCxC2DzMGXa9KGZlqiPztRXoMuV/SDGDpVppghmrVKdj5E01i6iq02ieinG8rdshk2nIJMbuGv0/Hu4r90FSZfMrEOd3WwTI5WU6FGCGWpcLEBqdNxB3Gr8gmFA6TARQ1Iv87JEHv3hnhHqHBi5kt8QNhpgY/H6RkxwLWmtOjavJu+Bv5yaDa24/2PkiI/zVMAj6nP0svgW1gCLvkfjBRZDnBHj9oSho/VXaGUX+qVdy3uDzF14i5jDOC+d88qpPLNyBE1Adb8+vNP6aJ1zzsrevrxMdHdoY95IXVLa7J6+DDL35xA0Lnfy1EcAqfl/NwwfR2n0LAHFFXMIXrh2rM/NEkYl3JeYyYoft0PXXctK8f2h1ME/hV2fYvUzM=
X-Forefront-Antispam-Report: CIP:216.228.112.35;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid04.nvidia.com;CAT:NONE;SFS:(4636009)(376002)(136003)(396003)(39860400002)(346002)(36840700001)(46966006)(82310400003)(4326008)(7696005)(426003)(2616005)(47076005)(5660300002)(7636003)(36906005)(82740400003)(70206006)(26005)(70586007)(186003)(36756003)(83380400001)(1076003)(336012)(478600001)(8936002)(316002)(107886003)(8676002)(110136005)(36860700001)(2906002)(356005)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2021 05:31:55.2620
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0adec6e0-b46f-42bd-6db2-08d928ac6598
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.35];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4722
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before SF support was introduced, the DMA device was equal to
mdev->device which was in essence equal to pdev->dev.

With SF introduction this is no longer true. It has already been
handled for vhost_vdpa since the reference to the dma device can from
within mlx5_vdpa. With virtio_vdpa this broke. To fix this we set the
real dma device when initializing the device.

In addition, for the sake of consistency, previous references in the
code to the dma device are changed to vdev->dma_dev.

Fixes: d13a15d544ce5 ("vdpa/mlx5: Use the correct dma device when registering memory")
Signed-off-by: Eli Cohen <elic@nvidia.com>
---
v0 --> v1:
   Change blamed commit and modify references to the dma device

 drivers/vdpa/mlx5/core/mr.c       | 9 ++-------
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 2 +-
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/vdpa/mlx5/core/mr.c b/drivers/vdpa/mlx5/core/mr.c
index f0b89b62de36..dcee6039e966 100644
--- a/drivers/vdpa/mlx5/core/mr.c
+++ b/drivers/vdpa/mlx5/core/mr.c
@@ -219,11 +219,6 @@ static void destroy_indirect_key(struct mlx5_vdpa_dev *mvdev, struct mlx5_vdpa_m
 	mlx5_vdpa_destroy_mkey(mvdev, &mkey->mkey);
 }
 
-static struct device *get_dma_device(struct mlx5_vdpa_dev *mvdev)
-{
-	return &mvdev->mdev->pdev->dev;
-}
-
 static int map_direct_mr(struct mlx5_vdpa_dev *mvdev, struct mlx5_vdpa_direct_mr *mr,
 			 struct vhost_iotlb *iotlb)
 {
@@ -239,7 +234,7 @@ static int map_direct_mr(struct mlx5_vdpa_dev *mvdev, struct mlx5_vdpa_direct_mr
 	u64 pa;
 	u64 paend;
 	struct scatterlist *sg;
-	struct device *dma = get_dma_device(mvdev);
+	struct device *dma = mvdev->vdev.dma_dev;
 
 	for (map = vhost_iotlb_itree_first(iotlb, mr->start, mr->end - 1);
 	     map; map = vhost_iotlb_itree_next(map, start, mr->end - 1)) {
@@ -298,7 +293,7 @@ static int map_direct_mr(struct mlx5_vdpa_dev *mvdev, struct mlx5_vdpa_direct_mr
 
 static void unmap_direct_mr(struct mlx5_vdpa_dev *mvdev, struct mlx5_vdpa_direct_mr *mr)
 {
-	struct device *dma = get_dma_device(mvdev);
+	struct device *dma = mvdev->vdev.dma_dev;
 
 	destroy_direct_mr(mvdev, mr);
 	dma_unmap_sg_attrs(dma, mr->sg_head.sgl, mr->nsg, DMA_BIDIRECTIONAL, 0);
diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 7e0d1b8ae3d3..a5163d8a4828 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -2046,7 +2046,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name)
 	if (err)
 		goto err_mtu;
 
-	mvdev->vdev.dma_dev = mdev->device;
+	mvdev->vdev.dma_dev = &mdev->pdev->dev;
 	err = mlx5_vdpa_alloc_resources(&ndev->mvdev);
 	if (err)
 		goto err_mtu;
-- 
2.31.1

