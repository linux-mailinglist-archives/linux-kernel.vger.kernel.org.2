Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BCF139665F
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 19:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbhEaREw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 13:04:52 -0400
Received: from mail-mw2nam12on2056.outbound.protection.outlook.com ([40.107.244.56]:40161
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233059AbhEaQFx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 12:05:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eMH029IErqAJTOsd0u1LR8rgRtZbd3bNtG4fvP+71OMgDxi6Yi/j/CfYigktPg8uJ3/XGyjPFWCNl7aLIBLlSZKY0HKw5ugz/75M09CWvB0hzID+8S0uxkwGkLNpeRG2mHmkzLK0Ju5eFjsSwZQlMG6TShxgover0wTkuq1Z+5BlHJMxFEpEm8CTqFJsAsgWRvBwlwSZ8mD/yMXTt/4BjfyZdcZdqN8A4IphIdr4cSDzJlYff8VPJjyknUfRyp3VIQSquzkwKmQAzqrhNcXUb6LfaHlcYrV+KuVS4BrGQ4phj/nMmcq5vdStDchR1qzVOrPdDUM3/nB7inwotV3RwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zcIwwEwUqkoCxyFwDM30FQAhuRiD7oqVspCoogaH6wc=;
 b=YjBG9FYaofRAdb4+0F/cBxjHW7CEMbIvAPv5w43lM9zorh++sMRNQOJiGqUkIu9zjIDgHgqg79oM2Sx+wK2gtWdKT/PMuax8uHUUIa8z/h20E6GOUsP+dpMRWyELcr0R24+ZJ5ZIdN2jEv5PD1nru/r7gwrEn6bLikag9GK5SiV3BIuTiuF2t/Yuzjgvsn9eI87WGOFQP470jLl9DYLCamBBk5fyCmh5MPsRyOqa81XHxjKrTiOqVmzPld2W3aPKeptsSz5lunnX87DAb+NEVk6luSY/CNflhM0Z6dhyAu7CdZdpnodMI0/PYheQv+6Aun+/7K5ySq+fHneraacSrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.32) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zcIwwEwUqkoCxyFwDM30FQAhuRiD7oqVspCoogaH6wc=;
 b=hGBrE4TqeMY1Xs1wtEl/o7DmthnKGWxP9fFRQ/y1HZkNqcKUzFiaxfpO0SIsY4vAbq0nbJa9tq4QZ/+GyL/vgtIpfnM2eVcJREz5wRB6Od5FUSQvOcJ2XDKEk8N+PqJIEJ5rJjtdHJ5Uf2Tl84rscS9NMA5LKhVsHbLw+i6XL6hGNptOpDf6W1KZx8tyygBLdqhyvPckbGooTnEczTWibC91sSG3i3EOUz4MbZ9t04zdTsY1lg9i8hrZvZsDkB3ChmjMydrFeBJHZyMBI08tXC62xbzHDGe3+2WcrOQ0ykczN5+z8Xw4/N9s33kdhIXaJXIP/VbkdspSHkBCnXk/Zw==
Received: from BN0PR02CA0022.namprd02.prod.outlook.com (2603:10b6:408:e4::27)
 by BN6PR1201MB0004.namprd12.prod.outlook.com (2603:10b6:404:ac::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Mon, 31 May
 2021 16:04:12 +0000
Received: from BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e4:cafe::54) by BN0PR02CA0022.outlook.office365.com
 (2603:10b6:408:e4::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Mon, 31 May 2021 16:04:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.32)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.32 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.32; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.32) by
 BN8NAM11FT061.mail.protection.outlook.com (10.13.177.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4150.30 via Frontend Transport; Mon, 31 May 2021 16:04:12 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 31 May
 2021 09:04:11 -0700
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 31 May
 2021 16:04:10 +0000
Received: from vdi.nvidia.com (172.20.145.6) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 31 May 2021 16:04:06 +0000
From:   Eli Cohen <elic@nvidia.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>,
        <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     <elic@nvidia.com>
Subject: [PATCH v1 1/2] vdpa/mlx5: Support creating resources with uid == 0
Date:   Mon, 31 May 2021 19:04:04 +0300
Message-ID: <20210531160404.31368-1-elic@nvidia.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 60507f26-d2c8-47f5-0fa5-08d9244dbb53
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0004:
X-Microsoft-Antispam-PRVS: <BN6PR1201MB00040A5A93103E5EA04B0467AB3F9@BN6PR1201MB0004.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dy6wH/eLjRJyLFeEnT7Qi3+/QOyrOBaAoIB6Sf9Q2Nvxq+ZIbld0dpZg8qI21P4Ho9gK1BURtgfDoi9B1JNyzhGB54QMHL4oWQqfoEylEMonpVO6kL4rwaHT+d/sNwuNkLlxMFvi7wEGvbu6rnx4hk0dlvfoNOXZNcwGUp94EEC8GiV7I0Wrha/4zEgRUFFXtr+S8bu/Ulr+AebuQw4C/8PzAX/eOgMcCafxe2KURoMIjGhui5mq5oYk9w9w6fHziJvHV8sVpQ7bDeG4P42JdqZ2qAhDD7kNv7ZynGCiLnzQCVC1ICPWlRtI8EBck77KJn3g6KrsGzSyY2ibjpdRCwl8eslQ5Ao8+fXzR9sVxmQ4OWNnqzNQ1O+QZWGcXJSHXwDAVATkhscqWc2148vpJmFH6hri/DcfCCU9s2St6OycIAbr03y5gyJiQzf++y9LwW0R5RaPlBSUA7DlwTVlyElwzT5B+ZzIEhArTks8rExmWX/lpXpqwb97OqmbhmdjKyI9sm+3hLRIF8RxAUthSvBmCJHrCBtkl5snKWRCaPHf9rfMIR4ToAoW5kdBpU71elAeR3ufiv/frtfmvCjrOAhvvJ6OLvGuWjTxYDmTgj1w0dUri7P74jENR9x4Ugj4yXZMYKEi60vws2pHsAWzg/AT9j0QHGyT6PBNqWUvTf8=
X-Forefront-Antispam-Report: CIP:216.228.112.32;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid01.nvidia.com;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(39860400002)(396003)(46966006)(36840700001)(83380400001)(5660300002)(336012)(426003)(186003)(1076003)(70586007)(356005)(82310400003)(70206006)(107886003)(2616005)(2906002)(26005)(316002)(110136005)(7696005)(36756003)(36860700001)(86362001)(47076005)(8676002)(4326008)(8936002)(7636003)(478600001)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2021 16:04:12.1681
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60507f26-d2c8-47f5-0fa5-08d9244dbb53
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.32];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0004
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently all resources must be created with uid != 0 which is essential
when userspace processes are allocating virtquueue resources. Since this
is a kernel implementation, it is perfectly legal to open resources with
uid == 0.

In case firmware supports, avoid allocating user context.

Signed-off-by: Eli Cohen <elic@nvidia.com>
---
v0 --> v1:
  Fix typo and modify phrasing

 drivers/vdpa/mlx5/core/resources.c | 6 ++++++
 include/linux/mlx5/mlx5_ifc.h      | 4 +++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/mlx5/core/resources.c b/drivers/vdpa/mlx5/core/resources.c
index 6521cbd0f5c2..836ab9ef0fa6 100644
--- a/drivers/vdpa/mlx5/core/resources.c
+++ b/drivers/vdpa/mlx5/core/resources.c
@@ -54,6 +54,9 @@ static int create_uctx(struct mlx5_vdpa_dev *mvdev, u16 *uid)
 	void *in;
 	int err;
 
+	if (MLX5_CAP_GEN(mvdev->mdev, umem_uid_0))
+		return 0;
+
 	/* 0 means not supported */
 	if (!MLX5_CAP_GEN(mvdev->mdev, log_max_uctx))
 		return -EOPNOTSUPP;
@@ -79,6 +82,9 @@ static void destroy_uctx(struct mlx5_vdpa_dev *mvdev, u32 uid)
 	u32 out[MLX5_ST_SZ_DW(destroy_uctx_out)] = {};
 	u32 in[MLX5_ST_SZ_DW(destroy_uctx_in)] = {};
 
+	if (!uid)
+		return;
+
 	MLX5_SET(destroy_uctx_in, in, opcode, MLX5_CMD_OP_DESTROY_UCTX);
 	MLX5_SET(destroy_uctx_in, in, uid, uid);
 
diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index 9c68b2da14c6..606d2aeacad4 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -1487,7 +1487,9 @@ struct mlx5_ifc_cmd_hca_cap_bits {
 	u8         uar_4k[0x1];
 	u8         reserved_at_241[0x9];
 	u8         uar_sz[0x6];
-	u8         reserved_at_250[0x8];
+	u8         reserved_at_248[0x2];
+	u8         umem_uid_0[0x1];
+	u8         reserved_at_250[0x5];
 	u8         log_pg_sz[0x8];
 
 	u8         bf[0x1];
-- 
2.31.1

