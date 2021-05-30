Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 494F039501F
	for <lists+linux-kernel@lfdr.de>; Sun, 30 May 2021 10:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbhE3Ihl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 May 2021 04:37:41 -0400
Received: from mail-mw2nam10on2052.outbound.protection.outlook.com ([40.107.94.52]:53888
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229500AbhE3Ihj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 May 2021 04:37:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=amNulxwXjW5uIDcm1d/FuqShINcjy3K3wjUy889Xrh1vxEmyUw4TIzsJLDulJxVW1jXJKL+1CFJAIKgfc02OFX4dnvn/Pc/cTPP50vPPrFV8HQBdxJQpUR+0SC/cZmyyEvNdXUn/DGV+EiHkvKx7A7v8FmfS39l6VXX0Yr9lHa5bLI6t0S7jqtvkmrQ/I0vf7HDHcf9QhQBmEWXM2M2yaopb4X6s9GsqD3qIMaWxs8YRw9dOlTIC8yu0fnkZV/9jEHd+m6qZRT5AxtEuwD0rdihSQOnl12mYhg/iRXD0Ps1+7j3UCYsRi9D62GOe1qUKmzXP1By1nlp9FlEAZXx2iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vJfHbYaRbVgi9MqboKuwkI/WtSGyW53PR5DJYKt7wKs=;
 b=RjuFIi2n9PYGX4GTHie0FuOqA/vjSKKPK9sqpMEYA3SzWEFLgIW1OzXy1OzmPuska+ROiGpthlNulXOLEhaX5YEgVF94VkhsdoWkPmR1/QjEt25IwjBL6KhmrLumDTb9s7UvexlS1Hfx9KV8m/BowKYZ4Ylr8jGYuK6FyNsFHf3inF/qWNBPhcMN/uA4hmNBZXbw3jIYEwFLpwKejShfEc/CCSyhxRH5hdljNLYRf5lFEUa5HERjED/dSvYdfgJVE7DXSTxzEbXo1Zh7UFSNOYfF70Ur5JKRBsEXgfqlpY77VZ7enPfxt0zMhZRGaAFkeCkLReTIlA+RoVKdTlnHAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vJfHbYaRbVgi9MqboKuwkI/WtSGyW53PR5DJYKt7wKs=;
 b=qlNcYd6tnMgnOT8U0o2N7Esj7Shha3pAyPovveB2UMTvZNuRGfyrMNHNDywp10TAJOqpsPA8DR3crCXGhFYePK7e1fm1gi+RQEeymcc7jGk/k2q+measFzbLVFbwx/X5cve/BGvqWUjUvXJk9yv/8muvGPnhIEtbAXcjJp5cPRri2jOs1fhiRw8Z1BYAbWpfC8QyOREKune3mBIctJJfPu3O9MIj/bXTyeFHX+r7fQoZrX7TvWGaIGEn4ROC+MU3kL9jOY6xP2jBsOIuW7GcJGA+yjAacS9MO2CYC5Ra8GqlPZ2a28+v65T1XluNBeADKtg7rS65tFsIyAKtOsu00w==
Received: from DM6PR18CA0013.namprd18.prod.outlook.com (2603:10b6:5:15b::26)
 by BN6PR1201MB0100.namprd12.prod.outlook.com (2603:10b6:405:59::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Sun, 30 May
 2021 08:36:00 +0000
Received: from DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:15b:cafe::dd) by DM6PR18CA0013.outlook.office365.com
 (2603:10b6:5:15b::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Sun, 30 May 2021 08:36:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; lists.linux-foundation.org; dkim=none (message not
 signed) header.d=none;lists.linux-foundation.org; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT010.mail.protection.outlook.com (10.13.172.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4150.30 via Frontend Transport; Sun, 30 May 2021 08:35:59 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 30 May
 2021 08:35:59 +0000
Received: from vdi.nvidia.com (172.20.145.6) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 30 May 2021 08:35:57 +0000
From:   Eli Cohen <elic@nvidia.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>,
        <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     <elic@nvidia.com>
Subject: [PATCH v1] vdpa/mlx5: Fix umem sizes assignments on VQ create
Date:   Sun, 30 May 2021 11:35:48 +0300
Message-ID: <20210530083548.6545-1-elic@nvidia.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e38ebf6d-e894-4841-9cad-08d92345f3a7
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0100:
X-Microsoft-Antispam-PRVS: <BN6PR1201MB0100D88026D1BEAC54BB38B8AB209@BN6PR1201MB0100.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:556;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g8lwX0jp9ehgq2fTwrcs8tGLdeE9tm8odGrXn1CTPZPF8hUxuSAAKTEIvHm5Yk0suOmvT17SNaZ+6V7JWOOPmwEJ92AcNMVu17f0uFo/u+taptH+Vtv7XQWujUc+ZsCwkexbNXuaeRofvxoH/9QhI/Ihc5dgy8sCDFjyILEDVrclyMS31iHkaPcKybTwPp3dekw+oTY7O3IVRcDAkPvE7l8jKK9Uz9r0kvYRcX66K5Kv90FrAy03mBNJLD5KpntXrJmQgrM6nCZEsLirBi9nJVykyGplunlD8B7v54CCzC7iChX1JDnoPDySkrbvw9cuFBTGd+2BiAG3HiY1jwwoOeI1MFe5RBYjLfAfEUDJDICERUWoDUoL7fchoHfaQPUg5LfgG+xYZTpqDo2D1C4hoRyAfNKVv7N4CwVXJ3kJlCBRIcuyJTJw9obYgtN0jMIR4BvfPdLxyENg1aSl2iof1S5mnlgKSiElegEOsnkvc0o1oVEVIVRzY3A1YqeBzH7ZuXuyex/SH74gfjL5iHIV2V/5P8kS2adH6IPL2oLWo5BUpLKC2Bxw9whKTExevYXpFnDEd+FYisy3ePQfNXup101VyzXmN0Hpd+Ixlj0SDcFp4736kvn5OiLubn3fYTvHD65u+mdn2VRg6WZGKYjvFeIlQVULID1jZhHlUKWCW4Y=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(396003)(346002)(376002)(136003)(39860400002)(46966006)(36840700001)(47076005)(186003)(2906002)(36860700001)(70206006)(26005)(70586007)(4326008)(82740400003)(86362001)(336012)(82310400003)(7636003)(5660300002)(36756003)(356005)(2616005)(1076003)(7696005)(8936002)(107886003)(110136005)(478600001)(6666004)(8676002)(316002)(83380400001)(426003)(36906005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2021 08:35:59.6210
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e38ebf6d-e894-4841-9cad-08d92345f3a7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0100
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix copy paste bug assigning umem1 size to umem2 and umem3. The issue
was discovered when trying to use a 1:1 MR that covers the entire
address space where firmware complained that provided sizes are not
large enough. 1:1 MRs are requied to support virtio_vdpa.

Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")
Signed-off-by: Eli Cohen <elic@nvidia.com>
---
V0 --> V1:
Add more information in changelog

 drivers/vdpa/mlx5/net/mlx5_vnet.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 189e4385df40..53312f0460ad 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -828,9 +828,9 @@ static int create_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtque
 	MLX5_SET(virtio_q, vq_ctx, umem_1_id, mvq->umem1.id);
 	MLX5_SET(virtio_q, vq_ctx, umem_1_size, mvq->umem1.size);
 	MLX5_SET(virtio_q, vq_ctx, umem_2_id, mvq->umem2.id);
-	MLX5_SET(virtio_q, vq_ctx, umem_2_size, mvq->umem1.size);
+	MLX5_SET(virtio_q, vq_ctx, umem_2_size, mvq->umem2.size);
 	MLX5_SET(virtio_q, vq_ctx, umem_3_id, mvq->umem3.id);
-	MLX5_SET(virtio_q, vq_ctx, umem_3_size, mvq->umem1.size);
+	MLX5_SET(virtio_q, vq_ctx, umem_3_size, mvq->umem3.size);
 	MLX5_SET(virtio_q, vq_ctx, pd, ndev->mvdev.res.pdn);
 	if (MLX5_CAP_DEV_VDPA_EMULATION(ndev->mvdev.mdev, eth_frame_offload_type))
 		MLX5_SET(virtio_q, vq_ctx, virtio_version_1_0, 1);
-- 
2.31.1

