Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8064399FB5
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 13:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbhFCLYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 07:24:10 -0400
Received: from mail-bn8nam11on2068.outbound.protection.outlook.com ([40.107.236.68]:56321
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229697AbhFCLYJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 07:24:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Va4LdVrPCdcFLxiK5Z+gSftODal9aGDAMoBx4cRL8MSOxfR28q9k00/k/8nPG2vS6q6+D3thr6lM4FaucEJ8I3HGqcSf+O9mLeETOcC1eR5DdYXCu5mm5mcilRMTvSho9uHRS1rcPhXMVVDlR48k1KCh5APcV7jihGb52doHgWM3DizBi1XVk1VXwj9eIdvgKEEK440rEYF8fAX6OMYfkFX6ArroWvMvmNSR8theKYjkxvkT65UCG46UKR+AzdsHcGn5qDskrnwZni5vGDgflKtFSkWmX2qvsqRh+uRUz6VlFj9x5nwXjdAoeNXEsr6YqyDgbrP2CCLvktWy9K/gPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zv7mJOjMIEfWV0ImF5ivkfGZ3h6K5Oidn7XkcGitRrQ=;
 b=X7/gepQC9/BAd5e2qNruiGJm2jsxKwvkztxtHYmYPgHs+ZQoQWl+fwh3N7AIbtN5U5sZnjmEFztwxGlCIPHrYBprFiPBq78V9TNX1gOSOU8bucLead2lVgCZ366wkSbZFJi5VOLHuUWVbOl4f/RXOhK6QKBH/mgN9mS2Uxq7h+pHZhXDzhHDxnz3woW8VI/PSDDtCiDkfbpv3a4hS37rrRe0yUqBajYxSqb/iBYcAk7SMAcjmtM6ElnSZEyQUb412TJEaCtrXCMMfcgx8kdFYuBR8G1MtbXu5PtxpSG1fex12SnwebVTmOxqFuJXHEYEno6dDbTjg4beStapPch1JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zv7mJOjMIEfWV0ImF5ivkfGZ3h6K5Oidn7XkcGitRrQ=;
 b=sY6uq8bxTx7oe1NkCl50lsA1r2yxnSUDAO7pjo7b98vjfX1HYM9pUfvSJJSRVrUsjXrlAj/I1wM/6c+p7H7UXssLHKQFvHMwgMAeAnpzJg+YXKqXIdU+GBHcrBm2qAC2cRrogvtNwNmewo4keNFco7uhPLtU9RQlVeV3xAAHc+HbdrP5HzaoZ0HU9av8hcLAimOd88KnQndk3GVN+cIUaQKMo6ZDyuZ4SeQB4jTIB0i1li3Anf/D/5ocxbH23XYBTR/mN0Y74T+TZFGnzAuSf09eX7yYL4ETnSe19C5oSpnkseRR76n73D9ZFam2IitzU4oSS/Oc57KQMPxMhNh7Vg==
Received: from BN6PR19CA0090.namprd19.prod.outlook.com (2603:10b6:404:133::28)
 by DM5PR12MB2487.namprd12.prod.outlook.com (2603:10b6:4:af::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Thu, 3 Jun
 2021 11:22:24 +0000
Received: from BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:133:cafe::18) by BN6PR19CA0090.outlook.office365.com
 (2603:10b6:404:133::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.21 via Frontend
 Transport; Thu, 3 Jun 2021 11:22:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT050.mail.protection.outlook.com (10.13.177.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4195.22 via Frontend Transport; Thu, 3 Jun 2021 11:22:23 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 3 Jun
 2021 11:22:22 +0000
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 3 Jun
 2021 11:22:21 +0000
Received: from vdi.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 3 Jun 2021 11:22:19 +0000
From:   Eli Cohen <elic@nvidia.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>,
        <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     <elic@nvidia.com>
Subject: [PATCH] vdp/mlx5: Fix setting the correct dma_device
Date:   Thu, 3 Jun 2021 14:22:15 +0300
Message-ID: <20210603112215.69259-1-elic@nvidia.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ea2c6bd1-2a03-4aac-c643-08d92681dc52
X-MS-TrafficTypeDiagnostic: DM5PR12MB2487:
X-Microsoft-Antispam-PRVS: <DM5PR12MB2487C3B829AE2A47C3C2BA0CAB3C9@DM5PR12MB2487.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AzkJsSLIipexTdVLEW6vXoXNg2BknIx8IDtey4v+2PS4kttXVpOTZH01cPpmJnqQiYPah7aLtuGEIrlnJEjijfbjeKKMSLV54FDtpJw8rI6xHR23PhTx1hUTIK3vaU6Ceb6Xw6UM08tNi+FOZzvBloruUZCZFuKOEyOvyAnXm2DKGgaFBaSl1diY+eYrur3dxGIVkQdfmk6X+/1GsXtunJfmYz1v3xxeq88Q+gp2hZRSOjxwSTle510ZC1qW0+e+DrkhKEVndiOfDIv63JF+ISI3/uDkBTY1pWbgNBFrnG34s4PrSRnMwmezIHyJYRNV49DU+dhDDZejcIs+9KRYU06GCwDWqPE68pOjTD4aN593AQihHDXJU134PMzvsZOfZENM81EiKVSGxELVCZ6TBPf9Jl9a0VPylt0sZUfERKGU205T/75pO3uU2knzQQ2daAKnnaf6GqWUdNnfaPyFchqyoKiRE5O/OaajYTNGAw5z94xLF3/A6lsK0Nfk2fCXtLembybEysx5cd/QcUZMk1HuCB59JyCAmmtjvQJIytALqa6hYBGzkgnbIrKGiWZiVupw5tV8YCgrfmhn8yf6P+9MQevLW0CUpmRFZVxaV2SORJVt125QtEnBuT0ENs8mS/GzRC+FLbEhstGz8yhHck+ffgIW/Cv4UvZAbA+gLm8=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(396003)(39860400002)(136003)(346002)(376002)(46966006)(36840700001)(36756003)(478600001)(426003)(2616005)(186003)(36906005)(316002)(4326008)(6666004)(82740400003)(70586007)(2906002)(36860700001)(86362001)(7636003)(82310400003)(83380400001)(7696005)(356005)(5660300002)(1076003)(26005)(8676002)(336012)(70206006)(8936002)(107886003)(47076005)(110136005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2021 11:22:23.6885
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea2c6bd1-2a03-4aac-c643-08d92681dc52
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2487
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before SF support was introduced, the DMA device was equal to
mdev->device which was in essence equal to pdev->dev;
With SF introduction this is no longer true. It has already been
handled for vhost_vdpa since the reference to the dma device can from
within mlx5_vdpa. With virtio_vdpa this broke. To fix this we set the
real dma device when initializing the device.

Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")
Signed-off-by: Eli Cohen <elic@nvidia.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index bc33f2c523d3..a4ff158181e0 100644
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

