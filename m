Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B066395030
	for <lists+linux-kernel@lfdr.de>; Sun, 30 May 2021 11:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbhE3JFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 May 2021 05:05:20 -0400
Received: from mail-mw2nam10on2079.outbound.protection.outlook.com ([40.107.94.79]:46021
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229580AbhE3JFR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 May 2021 05:05:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fvMw1SrEGDiKAePNV+cWjG1Ay1YMoP2x2/U5CGM7asY98d3LwF/iOA9XC7uZgbQn2u2zukVem7c3D6vA+9XLP7/3OeYJuwJ2kehshXoXJxf9ZDSuKAKSfxOcGBjB/y9v3TrnVUhoiptAw4jtqaTh94KdmR8hcHrdHdYvKOpY/WgHuaVzk9z7KWqpC2mtig6rt5aYBepGuH8vPiKuohhPT2zhMn6SsuMho4HOkdzjymdygEqKk9cQR0o4Fnp3vmT/UpU3Mdsjy/I/LWCCrBF34eXCClrBqYSMeFoVxfkJw+eanIwNE4kfOVXAmsN7K2/esXw3phy0BOJlCCr+ALoBOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QQazc6H8TN7bmUPj2qgWE2NLKR+H3PKkLSJGRDnbjFo=;
 b=bO6HmNm36bZvj/yUeVrOxykhO8VUqsCp26Dm3zZpK9v+zIY+PPi3kbzNE6NTV5kEydud/N9xuqdwUBCvx430pMASNM/M2ClllXPqovpyV2YevcrnnQD5tU32jxLFET2BKGobW4l+Kh+vhP1+Npej089xt/58vQJRcn44avzQJWM6VcH+65/0vjsdoMK93ao+DVRW0pCgCRn/MYQlXpalYj64CUV/MEjqDZ8QwI1to54ZYF+dbGl6jR7+DBcx/o7YnSI2TuOD+yxmlwwsNoQLqSAHEzSkLmUCo5AnsVSaSe31JoSuY6YjINAQWncfl7mgh/ihMJNebNqzeHVaUItbsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.36) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QQazc6H8TN7bmUPj2qgWE2NLKR+H3PKkLSJGRDnbjFo=;
 b=WPvb8cGsjgLB7kbl6PtUq8CpVnlqitnYOo0rSZ+ot0dBayau5H5SHQTeDBFFeXJ99RzTmvFFj856xJX5fCt5I8quxf32xHijhBVOnQvZfBtwf2Q5+XyXb6zU97By1vUFhr9rm1Gjp6Ado9gowrDYOein/W8ZIo3QBGbdqPZm6JanskLCtbz1I0iG20z+qJgJ98SOXalVuUGwkhWgBqJ9Jm3uPD6dsZh8iMgGNQkY4qBRBqY4982UaLhM0Hi9Do1j2Gp2aYpxSlsJpxX3Lovfdflw26CQYE4VManbaolX6PtiCG9F4tcbFzs10ZPdHiHOwQu+LbwaJpeknqStnbQs0Q==
Received: from DM5PR13CA0050.namprd13.prod.outlook.com (2603:10b6:3:117::12)
 by BL0PR12MB2482.namprd12.prod.outlook.com (2603:10b6:207:4a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.24; Sun, 30 May
 2021 09:03:33 +0000
Received: from DM6NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:117:cafe::18) by DM5PR13CA0050.outlook.office365.com
 (2603:10b6:3:117::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.10 via Frontend
 Transport; Sun, 30 May 2021 09:03:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.36)
 smtp.mailfrom=nvidia.com; lists.linux-foundation.org; dkim=none (message not
 signed) header.d=none;lists.linux-foundation.org; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.36; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.36) by
 DM6NAM11FT040.mail.protection.outlook.com (10.13.173.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4150.30 via Frontend Transport; Sun, 30 May 2021 09:03:32 +0000
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 30 May
 2021 09:03:32 +0000
Received: from vdi.nvidia.com (172.20.145.6) by mail.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 30 May 2021 09:03:30 +0000
From:   Eli Cohen <elic@nvidia.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>,
        <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     <elic@nvidia.com>
Subject: [PATCH v2] vdpa/mlx5: Fix umem sizes assignments on VQ create
Date:   Sun, 30 May 2021 12:03:17 +0300
Message-ID: <20210530090317.8284-1-elic@nvidia.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d5994596-ff21-46fe-75d2-08d92349cce7
X-MS-TrafficTypeDiagnostic: BL0PR12MB2482:
X-Microsoft-Antispam-PRVS: <BL0PR12MB24824F20E2D7918C1E778C4AAB209@BL0PR12MB2482.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:639;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7P2WaQHz3WC0puGWjPvtF8W/CoCr/JH/GGy3ckmymaS0F0AeOhZOEd5LwCG6nkCtG5Mzuz0SDCSvwfRi4F3z8mNdKyTJP1BtADzo0w0kwXQ1Q2TDPy1EEsfK1lpSq2SsM48Ez8syC5q1pZa0yfew23hDHh4fVstiAfohJMHA4xE45ID9bcORTXBLjRM8DFq+pw6AMPaCecB1TOU4kXdXYy/la4GcQOkxzvkEbwl5245s7XViuFR/kD3qYW8SJktNCGEqVMCwmNVZOpO/5qL0+iqaCIOF+RiBP6LjT9nHXG8oGfO/vAaqnORTgrODNQGx8syLd1pCfMUDlHNjjTALupmOyCyigvdvu+s/gmscArVtgz7FLwzCJ1u8b7IWzXGB7q4DOOkfZtCeurPWzTI4yNKeO/siPiwyhGA6a6dP/Sd5e8UldOkYhlwQXjfjtEFsDY19w6B5hjYC+plvh8XNplN7+dGnx1z2xJaSn7VCcmJyj/HBWdPB+ky4t2IUBfyCTJiX+8IpH8fCeL4vhf0DZmLZPqoJxtpGT1DXunfOh+GBGqHlmpkZO6h1Unzx6s5gogEkwBOtFugqcgCrRDt8VN8H/SIr79U4iVQ35//pfad741ZnMpuLpup2crUlU5du5N48UU9xvYYBlGsI9W5edAuKJzsS3LmrNXgr1RDPzWU=
X-Forefront-Antispam-Report: CIP:216.228.112.36;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid05.nvidia.com;CAT:NONE;SFS:(4636009)(39860400002)(396003)(346002)(376002)(136003)(36840700001)(46966006)(5660300002)(36860700001)(7696005)(70586007)(110136005)(7636003)(356005)(86362001)(82740400003)(36906005)(316002)(26005)(36756003)(82310400003)(186003)(83380400001)(8936002)(70206006)(8676002)(478600001)(6666004)(4326008)(107886003)(2906002)(2616005)(1076003)(426003)(336012)(47076005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2021 09:03:32.4912
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5994596-ff21-46fe-75d2-08d92349cce7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.36];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2482
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix copy paste bug assigning umem1 size to umem2 and umem3. The issue
was discovered when trying to use a 1:1 MR that covers the entire
address space where firmware complained that provided sizes are not
large enough. 1:1 MRs are required to support virtio_vdpa.

Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")
Signed-off-by: Eli Cohen <elic@nvidia.com>
---
V0 --> V1:
Add more information in changelog

V1 --> V2:
Fix typo in changelog

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

