Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 954F7394FD9
	for <lists+linux-kernel@lfdr.de>; Sun, 30 May 2021 08:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbhE3Gdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 May 2021 02:33:33 -0400
Received: from mail-bn7nam10on2073.outbound.protection.outlook.com ([40.107.92.73]:7232
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229495AbhE3Gdc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 May 2021 02:33:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QI/Vr4YWhLQUyRvgVGdXKgFojesq3PL/chB1VsJtPZ0gKL/rqcpWVbPi1UTRMQ5GgvxSeLt/jo9xnKMEyH/tfRzng2LoPPOTBYRd4yfs5Khxn61r3Zd7BQ6sn81h5DgVeAIU3OOW6WsqSCfCSGY6F4WHcxwvNzYYSje1cwDwCpc8sSw/30mB1gOGk7OH31H7fP5eC4UQqiERi6HXZ5oJIwWxuftJqJ+PZHVS9vXMdM2WPlp+lZxLhrZw4xzq+fINkLk9xj4eeeZqoEdSrHEw3xeZV6HkDrmUb06xSbHtIxx8XYf7zhgVtnfmRMIswL8d0L79Mg6r0g/ezKk9ew/fZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lGouTY72CJXRZCkfCUk01GjDXoUufEU3CTIh5tKAI1Y=;
 b=SmVLzs0HEsv6hjuBZWa9UTXwkiN3CmMQZxGP1sDGYUPZrRRqsaXlkj7z+bs5kfGcuRqS351Ly8RYclchT/2gvF18JFkRLxnhd00+C8fyjr+zU+yE7hIciml79mpiBlioVu4l1XGWmZSgiimdjUaYU+JWIR48oRXqmipl5FSIwjD3l/1dmUhTVmWJfWDjnYW0qlxQjxQkQW/zhBfwBVSaNl7pETdCiKoj5MMnWC+DYpoj14X2jtdS3MIYIkWdlCnlKo6ZaTLiA1Apm87QHI3KROMsQe3XdxEzR3RNyMp/DUYIqbH738CZgY/PdsmfAlOHzM+zodnkZ0yR89bgU3htbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.36) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lGouTY72CJXRZCkfCUk01GjDXoUufEU3CTIh5tKAI1Y=;
 b=FJfwIRDGIiBRMo6DmV51LD3GWvXzfA9CI9WJS/XXwmoXsKQ+d9vKPRBFecdGe0Mc8EmDIBqwNjjew9ftwtrL8IXoPPhAkjWR1RtHmdWx3Vec+ME22NpbvSRzZLQrYXQBHlTZqSVqKMab8QhDF0Tlg5UDNYfPCu6hEwBA8oUCSLuOpiQeCvoWzybXL0BFb/KwDCrd30syPpbmANc4XBTleFfaIOEWENzCuBL4PLlFgk5HbzA8Pzjcq26XZLd0ChCcE+trlTgWUPPztsG7jR8/sHvYHOOsa0FwI4r6kKlrAxopkbj+lubI3HGL3diQBLI6eSAwvzFwhDBzqpH7Ih+p3A==
Received: from BN6PR13CA0069.namprd13.prod.outlook.com (2603:10b6:404:11::31)
 by BL1PR12MB5363.namprd12.prod.outlook.com (2603:10b6:208:317::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Sun, 30 May
 2021 06:31:54 +0000
Received: from BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:11:cafe::bb) by BN6PR13CA0069.outlook.office365.com
 (2603:10b6:404:11::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.9 via Frontend
 Transport; Sun, 30 May 2021 06:31:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.36)
 smtp.mailfrom=nvidia.com; lists.linux-foundation.org; dkim=none (message not
 signed) header.d=none;lists.linux-foundation.org; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.36; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.36) by
 BN8NAM11FT064.mail.protection.outlook.com (10.13.176.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4150.30 via Frontend Transport; Sun, 30 May 2021 06:31:52 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 30 May
 2021 06:31:51 +0000
Received: from vdi.nvidia.com (172.20.145.6) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 30 May 2021 06:31:50 +0000
From:   Eli Cohen <elic@nvidia.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>,
        <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     <elic@nvidia.com>
Subject: [PATCH 1/2] vdpa/mlx5: Fix umem sizes assignments on VQ create
Date:   Sun, 30 May 2021 09:31:28 +0300
Message-ID: <20210530063128.183258-1-elic@nvidia.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: edb75d86-23ce-4614-62d1-08d923349d00
X-MS-TrafficTypeDiagnostic: BL1PR12MB5363:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5363AF691C8DBBBCCE224A1AAB209@BL1PR12MB5363.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9cyHWHyUHhpn3y7GXtjTji+w15D7YDGJVZPow04PBG+oHTeGiiHz+uzKVoirwtZaVoP6+ZBo5YftpoJKhz8uAZaSHfWwhbdomPRvG71jErig2TkW08KH7ZK6x2myMOdOMiWpxDkAY1mo97VFurCmLyI4yCxKCUMZqWwtStkJTYsAW2kV5eowg+oKb+3GWOAwEVFS64JNT9FG/VTO9Bp/rAA4iLKDasd7sRaLYThKi6jv1hujMuHAg2t6xbag0l3vRGwXAq4/XOrxGlHPSAl4FHCEH7GQ3+d49LSVT5C2+i1XqXNqYYaGJH1R9bm3s9ulbDL4z0W29vr7wz2Ywoah5mcU8hNL5K8zSECJJKlRsJUwVnEq6wOLhvN2UchYFQi/ZhdZIObOp9mBo+Wg4kaZc/O+zKexoG/vOGDQZiJKTJdyYPx7zIhF0z0Qle4YxW8yGS9eAfBdinLSgyvv3RwgPzFsNSWr0V9bHSmK4sfJO9BfJWbFnxAZVWi7O7cOIRTO+GABpcKuqmH3gyqg7bAYv84Whp5pFKH2wBHt8NhYmCWgdnsc6fTacNr3M5Z6I/gCvEhDt+s9brQvK6YKT6CXUTNmIChifaHn/4wq13Se3YuneYfSjrFdq0wd9t1OY0Zw/yHx1YMA3U9AQjznJyZs9/FPQDzLgc9JiXPzpfiT0DM=
X-Forefront-Antispam-Report: CIP:216.228.112.36;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid05.nvidia.com;CAT:NONE;SFS:(4636009)(376002)(39860400002)(346002)(136003)(396003)(46966006)(36840700001)(2616005)(426003)(478600001)(86362001)(336012)(107886003)(36756003)(8936002)(70206006)(82310400003)(82740400003)(6666004)(110136005)(316002)(1076003)(36906005)(36860700001)(26005)(83380400001)(186003)(47076005)(4326008)(7636003)(5660300002)(70586007)(356005)(8676002)(7696005)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2021 06:31:52.7186
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: edb75d86-23ce-4614-62d1-08d923349d00
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.36];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5363
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix copy paste bug assigning umem1 size to umem2 and umem3.

Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")
Signed-off-by: Eli Cohen <elic@nvidia.com>
---
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

