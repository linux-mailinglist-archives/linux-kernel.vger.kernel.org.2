Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEB7639500B
	for <lists+linux-kernel@lfdr.de>; Sun, 30 May 2021 09:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbhE3H4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 May 2021 03:56:19 -0400
Received: from mail-co1nam11on2071.outbound.protection.outlook.com ([40.107.220.71]:64051
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229671AbhE3H4K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 May 2021 03:56:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lMEKE67a/235gBSPDkhNrjhuJKy2i9Or2ZSOOs5M50xOcf1EK6uVC7XFTOyT0xA15U+VTuthjMPRtuDwInC5NFb5ZU+WTkK6ZzpgPrjsQy3TcLbfFqbmEXJIcrhtf6q98+o/GBwrrAIaoy4FEQxNmvykRjYmWdRFduqLvayWfZTAK5Z1KfK3hXVsRWrzGmotaOPCKfSocT9e8VkhtzOaQqNHDE7VIaudESIhd8oWBNKX2wU2GPeMNmuVBBuLse5C5XBhh6ZUZ9IWlY319xs7b6q/3xpL70i65hxTBQoQbpS0at3Xw+rlszPF/p+k1cCJ4DX/ok347HtMaIXlNum40w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xKFFidBI9Qv1tOe4MnOX/b+w3g3DRg2vNLJo5+BfFm8=;
 b=g5zEtCXXRCjppWw1MMxPKkS8d283NAXfpGm4q9m3SOB/MufIqofy7Y2bDNVcdrQnuMTI5xo4Me/TUcDLGzEKhRoALp/LXGgcV90msPzva1ZWwJqFIADZibMJVK/fVfbhzzHSlM9jT1gHZtmVmbj63FjF27ujIQD3jabgtSlY7oMI/la4wotVwB77g2o4ISqvo6Qst9j5UnDTPJLmstRgwD86Mx9NuhxK3KRahgePeXQYN+dLC8JaKLOMqRT3DyQxBqWearlC5Nht83UM1BKJfDctYstLCWiEFLk9SNPeW3pf51NsLN77QWQEpFpdK6kFBnF0gY7vbnM9mPQQ/wpmNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.32) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xKFFidBI9Qv1tOe4MnOX/b+w3g3DRg2vNLJo5+BfFm8=;
 b=r1GUCboyFpaHsnkcXzB1RbSmgmj0u9fI2WmBzQ/1lKS8AuLCf57+mrJcN26sByGt8ld50rHlTHIsz3+QWsj20EK3ftZ4X85VX5GVXTbKQ025LLVUYjjctSUp3lkPdiicVYBUlA/+v9eGShh04cJN9AlhWlqmH0TbZm6b67NsxGPTnHwYADusJ6yreoxtogCjIsHWs94UNSdBAmKvOHC1ETplPnypwpbdR//B3BCvXlTVlBw9UL+cHRxzAT9F5bHCKubWeJh8606BLltI9D8Zl5QVIZbu5pgBzdod84g3bubAnB2JzSOy/u/+y9Yq/QhOHXwp1Xt50AY0nd4iyTohBg==
Received: from BN6PR1201CA0003.namprd12.prod.outlook.com
 (2603:10b6:405:4c::13) by MN2PR12MB4077.namprd12.prod.outlook.com
 (2603:10b6:208:1da::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Sun, 30 May
 2021 07:54:28 +0000
Received: from BN8NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:4c:cafe::cb) by BN6PR1201CA0003.outlook.office365.com
 (2603:10b6:405:4c::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Sun, 30 May 2021 07:54:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.32)
 smtp.mailfrom=nvidia.com; lists.linux-foundation.org; dkim=none (message not
 signed) header.d=none;lists.linux-foundation.org; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.32 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.32; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.32) by
 BN8NAM11FT035.mail.protection.outlook.com (10.13.177.116) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4150.30 via Frontend Transport; Sun, 30 May 2021 07:54:28 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 30 May
 2021 00:54:27 -0700
Received: from vdi.nvidia.com (172.20.145.6) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 30 May 2021 00:54:25 -0700
From:   Eli Cohen <elic@nvidia.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>,
        <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     <elic@nvidia.com>
Subject: [PATCH 2/2] vdpa/mlx5: Add support for running with virtio_vdpa
Date:   Sun, 30 May 2021 10:54:15 +0300
Message-ID: <20210530075415.4644-3-elic@nvidia.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210530075415.4644-1-elic@nvidia.com>
References: <20210530075415.4644-1-elic@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a7c5c7e8-183d-4ea3-12a2-08d9234026c2
X-MS-TrafficTypeDiagnostic: MN2PR12MB4077:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4077B106BDEB03CD309F9739AB209@MN2PR12MB4077.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8r8BoD6iiLIoScwJegvEd/ZxvkOB6HwxgpgZ77N1Ci0LtYfZjFNYFCgrDo4qwUuDgCPJ3aiYle0BfjE95aFBuLpJIMm9AIu/TSBx/hiOAz1XwQsOkpjkDmtdWFjH1JsACluGz0pWdf1yt9IhWpqZKd/5cJmtkr3nwfCNmaavC8gPqXuSfxX1Gv6PBQjMFr2YQSDAEt2QYFMOnnA2virs6M3ujV5LtJEyPypANQxlNbBTFaJKm+QHZfJtEFYMVVJketdR9JFESKn7KSNmue0n7xDtPf1SfD3Yf6m9M8d8wSmnmjgBKJqRhiS37woebYiFnn2veDCax+RAMgVyNcsDlchpFksJ77sCT9szaqUZb9i9tuXnzcZvu6SgyMSJWaKjg0n2oIf6GZk9010q2tOBsTrILjuzyyBE0jkJKDNYipc1PBjSkEDDKlh/M+XwVbEQZC6AB2WFixEacVGIE3JArH7ec3uF9LVigbx3u6Ff88Gs5zbaqU06S0qHG3VMKjgWODOoQheIfs9ChKvzlgYuiczJC8+IT2pryhMZnIt2RDYy5AJTGMkcZRRZPdMCYNNXShVzvkkwS7ugMU0h37BkSLXmnDWU/3K1rA4FE+hr1wkcI8F8FDMZ+AoZY2dag87yDdaGe+b8h8uzoCa/2J+BtbDcpDYFDPdL5t4txkOfrdQ=
X-Forefront-Antispam-Report: CIP:216.228.112.32;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid01.nvidia.com;CAT:NONE;SFS:(4636009)(396003)(39860400002)(136003)(376002)(346002)(46966006)(36840700001)(82310400003)(5660300002)(1076003)(186003)(426003)(2906002)(316002)(4326008)(82740400003)(47076005)(36756003)(107886003)(356005)(110136005)(70586007)(478600001)(8676002)(336012)(70206006)(83380400001)(6666004)(2616005)(7696005)(36860700001)(26005)(8936002)(86362001)(7636003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2021 07:54:28.2986
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7c5c7e8-183d-4ea3-12a2-08d9234026c2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.32];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4077
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
 drivers/vdpa/mlx5/core/mlx5_vdpa.h |  1 +
 drivers/vdpa/mlx5/core/mr.c        | 81 ++++++++++++++++++++++++------
 drivers/vdpa/mlx5/net/mlx5_vnet.c  | 13 ++++-
 3 files changed, 80 insertions(+), 15 deletions(-)

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
index 800cfd1967ad..020c0ce4d203 100644
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
@@ -426,33 +423,89 @@ static int _mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb
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
index fdf3e74bffbd..f16756661c19 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -1780,6 +1780,8 @@ static void mlx5_vdpa_set_status(struct vdpa_device *vdev, u8 status)
 		ndev->mvdev.status = 0;
 		ndev->mvdev.mlx_features = 0;
 		++mvdev->generation;
+		if (MLX5_CAP_GEN(mvdev->mdev, umem_uid_0))
+			mlx5_vdpa_create_mr(mvdev, NULL);
 		return;
 	}
 
@@ -1859,6 +1861,7 @@ static void mlx5_vdpa_free(struct vdpa_device *vdev)
 	ndev = to_mlx5_vdpa_ndev(mvdev);
 
 	free_resources(ndev);
+	mlx5_vdpa_destroy_mr(mvdev);
 	mlx5_vdpa_free_resources(&ndev->mvdev);
 	mutex_destroy(&ndev->reslock);
 }
@@ -2023,9 +2026,15 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name)
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
@@ -2037,6 +2046,8 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name)
 
 err_reg:
 	free_resources(ndev);
+err_mr:
+	mlx5_vdpa_destroy_mr(mvdev);
 err_res:
 	mlx5_vdpa_free_resources(&ndev->mvdev);
 err_mtu:
-- 
2.31.1

