Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B172139665E
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 19:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235088AbhEaREr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 13:04:47 -0400
Received: from mail-dm3nam07on2048.outbound.protection.outlook.com ([40.107.95.48]:11873
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233299AbhEaQGQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 12:06:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jcFBdU8YZFt7uHtM+G41+atHFOsHSVW65aCvnWl1QfB+VL8WTl5Fve3QLjbGPwfLPc5BD6G5fIg3ZdHtM1bG0l3iyEB7at/NLDUz2NmpRITaWdToI+9MARUDZNFaBGPiJ51853rc7f0KfonRQhLd+y79s2J7U5cDAQzeBrmGt/y2EUNeXdeHNwG9v3TKqFlV4/AWeun+cjrbxZgAs80rnDfe7OugJLTSK6gZvf1ac65y88yF8hP5D0B9608uQATC7w1TDIGJ+q+6x2ZX7q65WiQlcd7eBa1zblCUVbcrVikEsUBgqmJr9Fwh5NrhelaNl+E71Ig/jtma09gtgYEa+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TwZQHZwAkrIt84BfJJbcdC6wLt70DptQGNfCoTqZWII=;
 b=V8L7+awXBWRXY0hcg60QZjbcmZHppxIwwbQvoHJDkSEgH3NlDutA6NKlzsgjXN6GGmp0iGyM0gUa+rZeJFL1pkr7ON/sEsRCI1kHnZp6zmRSQj6bqkpNDT2hmVVmV5HHL3DH7t5pp5Ebq6SUt5ZqPk6UVT7mEIW5huRdwLe/4ZKmFOnCdglRiElQDVNk87Un5K/9u5chm0jSq2CEu/g24xBsVz0xKngbP0C22+ygQKu4VrlA1ftMcF1gf6q0suAL/pFpGQufU3b4rbK6r8yovp5dyVR0aOTtoy2gkrIrqwHfLCZkJvh3UAm3+3legU99lfRxQx1plG+Ivcoy5m1XiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.36) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TwZQHZwAkrIt84BfJJbcdC6wLt70DptQGNfCoTqZWII=;
 b=Diew2QXPEqySwuDx2eM4CKhhAXnLeVYMpGwLeTdQU8h08EYzEaTPVeTrYdJ50haqSaYJPxejktBwTp+lT0cUFBJgYmfsEXoMjP7a08jmu0GGMlSxMgY87Khqi3aE3+MHczx7ynBhdtkVArsNqGSaSmVHHLZEO7z/mZEvcL7uxyZt7SCr0tyltIIT3Z/mXjUdNyBHypSEsjhU/3NZ9+q7inqgAFgtrXycGdOPDNWxVOoWKibeOt/8q0buyXpM1Np6qDnfASuHZvDOZNZRKy+wz+oXI03xHD1KQ6633HuTPnCbBPcpZD/cpFaKTF8UEaJN5s34FobxhwVt2rpofBEmog==
Received: from DM5PR07CA0138.namprd07.prod.outlook.com (2603:10b6:3:13e::28)
 by MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.24; Mon, 31 May
 2021 16:04:35 +0000
Received: from DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:13e:cafe::d) by DM5PR07CA0138.outlook.office365.com
 (2603:10b6:3:13e::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.24 via Frontend
 Transport; Mon, 31 May 2021 16:04:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.36)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.36; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.36) by
 DM6NAM11FT012.mail.protection.outlook.com (10.13.173.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4150.30 via Frontend Transport; Mon, 31 May 2021 16:04:34 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 31 May
 2021 16:04:34 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 31 May
 2021 16:04:33 +0000
Received: from vdi.nvidia.com (172.20.145.6) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 31 May 2021 16:04:30 +0000
From:   Eli Cohen <elic@nvidia.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>,
        <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     <elic@nvidia.com>
Subject: [PATCH v1] vdpa/mlx5: Add support for running with virtio_vdpa
Date:   Mon, 31 May 2021 19:04:28 +0300
Message-ID: <20210531160428.31454-1-elic@nvidia.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b6e3137d-a357-429c-5cd2-08d9244dc8c9
X-MS-TrafficTypeDiagnostic: MN2PR12MB3775:
X-Microsoft-Antispam-PRVS: <MN2PR12MB377584C832292F0990047319AB3F9@MN2PR12MB3775.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cstHaxs7vyFi+/VypJskTxZajMJBxS9ZG/xyPbrj+65WifP43AvczdKeoPaOa+9OWtKqgRq/OSSeGVV3Rb3UPRycH3WtqKNRXgfJR60tKxANzGzgTkezfApG3TXRAPCXQmNU5lxDfQSaWFI4fR8nW0bPWyfOJzXR44/ff1wTY2R0MDTWIoEZu1bAnJ+7hkNFDApj5JNfChO7B05SuiWDpZpEJlFWA6T+nvoleBfup47TD4DOXa+IfO8guiFkMdPy973xl1hz+yWK+/jo3gATY0GPQGSHxcAAjMN9sV0cSnaZc1Pv5dp+MyRTTON+5tFZ4SZ7+EpdWI6eJnioelg99giXHBYOvuNZ0VBUjGpkIrwGLJtlS3ZTUly6ZwX3ONQPyUSc7j0zjIme2N05o9L5ia8Cgagg0Uc3WLdDuAxMWGxzJEmE9F7lJRUbHIDTolX4XDq1SBby+PrddcNQLDUo6aYP9Gu1le7H0+jND88NClPjrhhF8cApOuuIINx9HApl53CSW+L18e0IKD+Cf9mp83pYgjzpzwjPHVw+zF/RBF9uj33tNJOYwsb+NtzpX3HTMfumSjwxUMUrlYRlijYwSQ3h5dxknvE7dlfkh87u/0tbhzQ0RFsNdtC0D1j6iaKEBa4VkSNHhW+EG37HMu4Kq15/Eqy+y3D5p5yq82zFfTQ=
X-Forefront-Antispam-Report: CIP:216.228.112.36;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid05.nvidia.com;CAT:NONE;SFS:(4636009)(136003)(396003)(376002)(346002)(39860400002)(46966006)(36840700001)(8676002)(1076003)(426003)(82310400003)(83380400001)(2616005)(7696005)(86362001)(8936002)(478600001)(356005)(70206006)(70586007)(107886003)(7636003)(47076005)(316002)(110136005)(36906005)(336012)(82740400003)(5660300002)(186003)(26005)(36756003)(36860700001)(2906002)(4326008);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2021 16:04:34.8317
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6e3137d-a357-429c-5cd2-08d9244dc8c9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.36];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3775
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
  2. Check return code of mlx5_vdpa_create_mr() and emit warning if
     failed.

 drivers/vdpa/mlx5/core/mlx5_vdpa.h |  1 +
 drivers/vdpa/mlx5/core/mr.c        | 84 +++++++++++++++++++++++++-----
 drivers/vdpa/mlx5/net/mlx5_vnet.c  | 15 +++++-
 3 files changed, 85 insertions(+), 15 deletions(-)

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
index 800cfd1967ad..3c6c1d846f5e 100644
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
@@ -426,33 +423,92 @@ static int _mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb
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
+	mr->initialized = true;
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

