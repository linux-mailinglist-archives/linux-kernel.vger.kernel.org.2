Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4283984CC
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 10:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233022AbhFBJAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 05:00:51 -0400
Received: from mail-dm6nam10on2078.outbound.protection.outlook.com ([40.107.93.78]:35697
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233017AbhFBJAt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 05:00:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CPnWHoAboKVltUHKYWheirI3tBHzj7vFLJTwfkId+kmFgtJ0oaGGUFtjmDnz3BoKXoLLNBwTyyv6DQ7voPmoiwGJkU1IXEJj7sHu+hz8lcdmwQDb4zCeNE2fkwYJmILEWRz3nq2fRPqxGGl3WXURIlTX7iUxdkUDj6xks/c7VzpZxgXKAzJ++hFrb2cHNB9shXNpU0GJJfuPKYIRzWcFgwtWZ5ampjvuBHdX5Kuf1x3ogPd/gxXMgAFbyjHiS+W1iAti6hNcp/cgDXx2ArHqIkgXNV2F6vvPlCXqOI7qHJAuPWhr0pkq0eQZ7CD1+l2W6cTvIcUTTtQOpeErlp9FGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+UfemWRLztxq8AaM7lyteqAAuItu4PTtLaNBTzBoGKI=;
 b=oSw/iWqESqSZqKl4cgWifchwsnWCNLQyQABp7uh67GGI/x2K46/edyw7/5JrIOtpCNkyBFeSO+z/6aLNT6JOPcHpuuDqRWN6i5LtGwYscTl2xjzMJWe1Xo/UG/LRXoU+I4/SjLHzQTMaFk1Gvy/Mr/PMPnf/McbvDK5ZZGasPtRYkyKB7RrEyNACM7YIVQkx6UK7bhIQAz7G3fK8TfAI1HO28JKWajNj7r+u2cbaPMPtouyrbj4LlfLLI5Ylg4ODPNrmD1/LdJO3KH4mMUZ02srGCMrmoebRYHr65q54VetnGzbfgJOzV7XyUlLnG1XGXrHJfbGCM/bHC8Oygqw6Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.35) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+UfemWRLztxq8AaM7lyteqAAuItu4PTtLaNBTzBoGKI=;
 b=OMJOuJ6ijwERG1kIywhTzIlIjyfiSMVv1yTTLko4yzOyOJZ68a1VnKoibrOUPqr3oEXzTNl+0Tno1LiWWd6QfocRO4sAxHfTTxWakFiifls+z+PBX6J6h8IBXjajJFCXaAil8yHpZLnsejCaPnlnR6dsKBAQhZdm1JmEkSphVwv4WjIjgWL7USINdRETUyxFih8OaBC4BeDWisJi3PK1r39jTGAoUQpptJmGaUE80wm5L33yDpYkl5sv1fQC6UMi+L47w0sGj7oxNDIX/JSVFdFL8nbiQL1k63edcSjLPxyx2efHGAyADZeSV1D+wUEI9fi7e5/0adzPk17yMcwq5w==
Received: from BN9PR03CA0249.namprd03.prod.outlook.com (2603:10b6:408:ff::14)
 by BL0PR12MB2417.namprd12.prod.outlook.com (2603:10b6:207:45::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Wed, 2 Jun
 2021 08:59:05 +0000
Received: from BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ff:cafe::13) by BN9PR03CA0249.outlook.office365.com
 (2603:10b6:408:ff::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.15 via Frontend
 Transport; Wed, 2 Jun 2021 08:59:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.35)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.35 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.35; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.35) by
 BN8NAM11FT026.mail.protection.outlook.com (10.13.177.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4150.30 via Frontend Transport; Wed, 2 Jun 2021 08:59:05 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 2 Jun
 2021 08:59:05 +0000
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 2 Jun
 2021 08:59:04 +0000
Received: from vdi.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 2 Jun 2021 08:59:02 +0000
From:   Eli Cohen <elic@nvidia.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>,
        <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     <elic@nvidia.com>
Subject: [PATCH v2] vdpa/mlx5: Add support for running with virtio_vdpa
Date:   Wed, 2 Jun 2021 11:58:54 +0300
Message-ID: <20210602085854.62690-1-elic@nvidia.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca48814d-768b-4530-dda2-08d925a4acbd
X-MS-TrafficTypeDiagnostic: BL0PR12MB2417:
X-Microsoft-Antispam-PRVS: <BL0PR12MB2417D86DAC25D1D5803138FFAB3D9@BL0PR12MB2417.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kkPu3bqD7RJT4PX+d40Nn97rzZTfy2l8Qut93euwQpDNGppuHqrZuV5hTlPPnzfV5OW45XMd10W4jDsASKYmcVbaVHc9t//XNwXiYlb5/eCYKjN9jgvQRqeQXv8+/jygXsu/Vl0/38pZiyRIzH1QWdOhaD0hGWVmJISLO+qEqBjPz4QJFcgpceuO/XO0RO7gg2RIoGlth4+4hnPiZlbFcNBNDz4cESgCKaFNlwH4QsiusMxQudy1RZiSl4+Kz89cD1SkrbKGdlYefWGL0pxXEooP63SwYhAmi3+u3tjJ+gTKdNIDLKr7SStssOSRuWNlI4xhBPme7X1TQFF605F1b7G2XEoCekNQRoKeCUUh0qpEDoQfVxi0KVZKJJWHRNVnLvHbJ5l6E9k5274OaxCx6F18aorR8TejSc8ZOvmrswfDSxu99SCJY+972XEUImUQFFnp9rdA2hf1smKfnpXKPKrV6AFNHo/vVDXXeOJYNdpuvhR0Mb17+gIuPsYeGWmpwzJ40TLmT9uksM5D5EUAMuDqAsUMBQG/tlHUpwrwqbDUqJJEzKr1AhIMPWD9F56phCZZCFNEQD6col6zVaq1ILKFYugjH9nV+ArapNLDzc7MbVdDeuBXIbLb5lES3m9Noziw2VE63gEsTi0aegdmM/CnxmUiz7GBFx5rW9GB5zg=
X-Forefront-Antispam-Report: CIP:216.228.112.35;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid02.nvidia.com;CAT:NONE;SFS:(4636009)(136003)(376002)(346002)(39860400002)(396003)(46966006)(36840700001)(8676002)(110136005)(107886003)(4326008)(83380400001)(6666004)(26005)(47076005)(7696005)(36756003)(86362001)(186003)(336012)(2906002)(82310400003)(36906005)(426003)(2616005)(36860700001)(1076003)(478600001)(356005)(5660300002)(70586007)(70206006)(8936002)(316002)(82740400003)(7636003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 08:59:05.0945
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca48814d-768b-4530-dda2-08d925a4acbd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.35];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2417
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to support running vdpa using vritio_vdpa driver, we need  to
create a different kind of MR, one that has 1:1 mapping, since the
addresses referring to virtqueues are dma addresses.

We create the 1:1 MR in mlx5_vdpa_dev_add() only in case firmware
supports the general capability umem_uid_0. The reason for that is that
1:1 MRs must be created with uid == 0 while virtqueue objects can be
created with uid == 0 only when the firmware capability is on.

If the set_map() callback is called with new translations provided
through iotlb, the driver will destroy the 1:1 MR and create a regular
one.

Signed-off-by: Eli Cohen <elic@nvidia.com>
---
v0 --> v1:
    1. Clear user_mr after successful creation of DMA MR
    2. Check return code of mlx5_vdpa_create_mr() and emit warning
       if failed.

v1 --> v2:
    Only set mr->initialized if successful

 drivers/vdpa/mlx5/core/mlx5_vdpa.h |  1 +
 drivers/vdpa/mlx5/core/mr.c        | 86 +++++++++++++++++++++++++-----
 drivers/vdpa/mlx5/net/mlx5_vnet.c  | 15 +++++-
 3 files changed, 87 insertions(+), 15 deletions(-)

diff --git a/drivers/vdpa/mlx5/core/mlx5_vdpa.h b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
index b6cc53ba980c..09a16a3d1b2a 100644
--- a/drivers/vdpa/mlx5/core/mlx5_vdpa.h
+++ b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
@@ -35,6 +35,7 @@ struct mlx5_vdpa_mr {
 
 	/* serialize mkey creation and destruction */
 	struct mutex mkey_mtx;
+	bool user_mr;
 };
 
 struct mlx5_vdpa_resources {
diff --git a/drivers/vdpa/mlx5/core/mr.c b/drivers/vdpa/mlx5/core/mr.c
index 800cfd1967ad..f0b89b62de36 100644
--- a/drivers/vdpa/mlx5/core/mr.c
+++ b/drivers/vdpa/mlx5/core/mr.c
@@ -360,7 +360,7 @@ static int add_direct_chain(struct mlx5_vdpa_dev *mvdev, u64 start, u64 size, u8
  * indirect memory key that provides access to the enitre address space given
  * by iotlb.
  */
-static int _mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb *iotlb)
+static int create_user_mr(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb *iotlb)
 {
 	struct mlx5_vdpa_mr *mr = &mvdev->mr;
 	struct mlx5_vdpa_direct_mr *dmr;
@@ -374,9 +374,6 @@ static int _mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb
 	int err = 0;
 	int nnuls;
 
-	if (mr->initialized)
-		return 0;
-
 	INIT_LIST_HEAD(&mr->head);
 	for (map = vhost_iotlb_itree_first(iotlb, start, last); map;
 	     map = vhost_iotlb_itree_next(map, start, last)) {
@@ -414,7 +411,7 @@ static int _mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb
 	if (err)
 		goto err_chain;
 
-	mr->initialized = true;
+	mr->user_mr = true;
 	return 0;
 
 err_chain:
@@ -426,33 +423,94 @@ static int _mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb
 	return err;
 }
 
-int mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb *iotlb)
+static int create_dma_mr(struct mlx5_vdpa_dev *mvdev, struct mlx5_vdpa_mr *mr)
+{
+	int inlen = MLX5_ST_SZ_BYTES(create_mkey_in);
+	void *mkc;
+	u32 *in;
+	int err;
+
+	in = kzalloc(inlen, GFP_KERNEL);
+	if (!in)
+		return -ENOMEM;
+
+	mkc = MLX5_ADDR_OF(create_mkey_in, in, memory_key_mkey_entry);
+
+	MLX5_SET(mkc, mkc, access_mode_1_0, MLX5_MKC_ACCESS_MODE_PA);
+	MLX5_SET(mkc, mkc, length64, 1);
+	MLX5_SET(mkc, mkc, lw, 1);
+	MLX5_SET(mkc, mkc, lr, 1);
+	MLX5_SET(mkc, mkc, pd, mvdev->res.pdn);
+	MLX5_SET(mkc, mkc, qpn, 0xffffff);
+
+	err = mlx5_vdpa_create_mkey(mvdev, &mr->mkey, in, inlen);
+	if (!err)
+		mr->user_mr = false;
+
+	kfree(in);
+	return err;
+}
+
+static void destroy_dma_mr(struct mlx5_vdpa_dev *mvdev, struct mlx5_vdpa_mr *mr)
+{
+	mlx5_vdpa_destroy_mkey(mvdev, &mr->mkey);
+}
+
+static int _mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb *iotlb)
 {
 	struct mlx5_vdpa_mr *mr = &mvdev->mr;
 	int err;
 
-	mutex_lock(&mr->mkey_mtx);
+	if (mr->initialized)
+		return 0;
+
+	if (iotlb)
+		err = create_user_mr(mvdev, iotlb);
+	else
+		err = create_dma_mr(mvdev, mr);
+
+	if (!err)
+		mr->initialized = true;
+
+	return err;
+}
+
+int mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb *iotlb)
+{
+	int err;
+
+	mutex_lock(&mvdev->mr.mkey_mtx);
 	err = _mlx5_vdpa_create_mr(mvdev, iotlb);
-	mutex_unlock(&mr->mkey_mtx);
+	mutex_unlock(&mvdev->mr.mkey_mtx);
 	return err;
 }
 
-void mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev)
+static void destroy_user_mr(struct mlx5_vdpa_dev *mvdev, struct mlx5_vdpa_mr *mr)
 {
-	struct mlx5_vdpa_mr *mr = &mvdev->mr;
 	struct mlx5_vdpa_direct_mr *dmr;
 	struct mlx5_vdpa_direct_mr *n;
 
-	mutex_lock(&mr->mkey_mtx);
-	if (!mr->initialized)
-		goto out;
-
 	destroy_indirect_key(mvdev, mr);
 	list_for_each_entry_safe_reverse(dmr, n, &mr->head, list) {
 		list_del_init(&dmr->list);
 		unmap_direct_mr(mvdev, dmr);
 		kfree(dmr);
 	}
+}
+
+void mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev)
+{
+	struct mlx5_vdpa_mr *mr = &mvdev->mr;
+
+	mutex_lock(&mr->mkey_mtx);
+	if (!mr->initialized)
+		goto out;
+
+	if (mr->user_mr)
+		destroy_user_mr(mvdev, mr);
+	else
+		destroy_dma_mr(mvdev, mr);
+
 	memset(mr, 0, sizeof(*mr));
 	mr->initialized = false;
 out:
diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index fdf3e74bffbd..02a05492204c 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -1780,6 +1780,10 @@ static void mlx5_vdpa_set_status(struct vdpa_device *vdev, u8 status)
 		ndev->mvdev.status = 0;
 		ndev->mvdev.mlx_features = 0;
 		++mvdev->generation;
+		if (MLX5_CAP_GEN(mvdev->mdev, umem_uid_0)) {
+			if (mlx5_vdpa_create_mr(mvdev, NULL))
+				mlx5_vdpa_warn(mvdev, "create MR failed\n");
+		}
 		return;
 	}
 
@@ -1859,6 +1863,7 @@ static void mlx5_vdpa_free(struct vdpa_device *vdev)
 	ndev = to_mlx5_vdpa_ndev(mvdev);
 
 	free_resources(ndev);
+	mlx5_vdpa_destroy_mr(mvdev);
 	mlx5_vdpa_free_resources(&ndev->mvdev);
 	mutex_destroy(&ndev->reslock);
 }
@@ -2023,9 +2028,15 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name)
 	if (err)
 		goto err_mtu;
 
+	if (MLX5_CAP_GEN(mvdev->mdev, umem_uid_0)) {
+		err = mlx5_vdpa_create_mr(mvdev, NULL);
+		if (err)
+			goto err_res;
+	}
+
 	err = alloc_resources(ndev);
 	if (err)
-		goto err_res;
+		goto err_mr;
 
 	mvdev->vdev.mdev = &mgtdev->mgtdev;
 	err = _vdpa_register_device(&mvdev->vdev, 2 * mlx5_vdpa_max_qps(max_vqs));
@@ -2037,6 +2048,8 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name)
 
 err_reg:
 	free_resources(ndev);
+err_mr:
+	mlx5_vdpa_destroy_mr(mvdev);
 err_res:
 	mlx5_vdpa_free_resources(&ndev->mvdev);
 err_mtu:
-- 
2.31.1

