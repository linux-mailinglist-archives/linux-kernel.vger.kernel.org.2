Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB446399C46
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 10:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbhFCINr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 04:13:47 -0400
Received: from mail-bn7nam10on2044.outbound.protection.outlook.com ([40.107.92.44]:19200
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229479AbhFCINq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 04:13:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i8SECFesh8jgQRlSzOX3n//MVNgVC16C2RsENJXRpoYvn/ZM92auKx/CoBey65DlJZ7Fl5xV01GxV6TztaIGeQ/mH1ZHf4OjqxwEMr0Mt7Hd0WV1KXqsJWHOVupa5dpqTlbTGwdYhtKEYb9Z21XxUzXoVHPlgT/OkhtAJg6rbgbRaoGNNuIALxFDJ6QJKp/EsvIqymMUAwEQLhd3IjuW2jCMkFvRqiT8LYZtDRiUN4u0u5EDpGWcFtz/i4utT+YV1qasDJqq08JiIXnb1hbZz4WpUSLhhxRgkxvrp1kYSnJthXs0VqHc4BKaiW0bGl0KK9pC3HO+Mr0hqTLJas2VOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TWDVAIx3NdetDlN0JJwZfKn1SfKX9+fQSXFUQpLy6zE=;
 b=iGyztIxhchNmZIOU/mGIQApdxxyHzv2GvwfP32QAoJnQCE/GOnsg98/KwHDzA3zfMrtC9hGxQh/T89BoOurFxP0zY5YYBUtqwXaM6TVcdd7hU25ZrRxa8apnqJA/73nrp4BTVXD3wfbR3xmxX73VJLvi9zOUNzNecpUW9dCsyoQ5MdDB4cjjYyDQa3ANEaHHpVdka13BdS5NEZWx2T7oy98HFadJ6x/ZwjUfnE7K9EadPwFA9LWAF9HolhYe6L+n9pDsiCqnVYQ5HoC+omMAnnaKgXTUKsR9cLXomASjfCHmy24XLt2tOob92kFW+zcbB/If3l+JM+fmEmGyC6+TPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.36) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TWDVAIx3NdetDlN0JJwZfKn1SfKX9+fQSXFUQpLy6zE=;
 b=mq4jA7/d+7hBJWJZ5rzLbvNUkRmcS01LJE31aKf2biAt2r58n4EPrcLH+H1IC7Gee2WZhr6hlTlwBGg1EyULlNYtG+C+ny57sKn3eUbwdMYrUhUgQVM3oatKW4+WV6shFsT/7UffS2zvDD5z62qfhjuCH7WLTsrO8yGJjgiGTgDRthtmPD813XXhAZ3gOHJr2VLAKqm4Zf557boztBVEh0jNyS6u2+xLvNnxth/x0mZAxGXT3bqhcZ19QcA5lCenqB6htoR7J86moS//dfZiFTnmq5uLX2qCKVBQcqhCPPM3nUqiT6PfcOMjFDpnyzB2OrpH/VzqAM6aMqwLOulLXg==
Received: from BN6PR14CA0001.namprd14.prod.outlook.com (2603:10b6:404:79::11)
 by BN8PR12MB3075.namprd12.prod.outlook.com (2603:10b6:408:67::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.24; Thu, 3 Jun
 2021 08:12:01 +0000
Received: from BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:79:cafe::20) by BN6PR14CA0001.outlook.office365.com
 (2603:10b6:404:79::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.15 via Frontend
 Transport; Thu, 3 Jun 2021 08:12:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.36)
 smtp.mailfrom=nvidia.com; lists.linux-foundation.org; dkim=none (message not
 signed) header.d=none;lists.linux-foundation.org; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.36; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.36) by
 BN8NAM11FT021.mail.protection.outlook.com (10.13.177.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4195.22 via Frontend Transport; Thu, 3 Jun 2021 08:12:00 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 3 Jun
 2021 08:12:00 +0000
Received: from vdi.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 3 Jun 2021 08:11:57 +0000
From:   Eli Cohen <elic@nvidia.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>,
        <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     <elic@nvidia.com>
Subject: [PATCH v2] vdpa/mlx5: Add support for doorbell bypassing
Date:   Thu, 3 Jun 2021 11:11:53 +0300
Message-ID: <20210603081153.5750-1-elic@nvidia.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b234dc3e-3df2-4a6d-aec7-08d9266743d0
X-MS-TrafficTypeDiagnostic: BN8PR12MB3075:
X-Microsoft-Antispam-PRVS: <BN8PR12MB30758C929E192446E3A93D29AB3C9@BN8PR12MB3075.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nukgw+S6YHHldxuuTID7iAc9/b+GuQEFCGGXGt+Nxcat97v6a6f5CkQpuYY73bSSCRhjoo7GCgnCUV6RsU2j4/uMWu+7UzliNsYkE4edz9HHpKfnuWHCY9r13NNCHU8ecz98h34YPiXZlPkTP6ysAxb0yFRfQlIl3nuWf9pJL+M7K6ivZlLALM7rlDaUayIAk818qcUpPBiV0/Do3hCeW2Il/0pJnsADwjbT8sl8E3rBra1dc6c847dlguDyLSOe8OywpC+Zxfk4yXhM5cF+F4iUVxJMlXchp84ZJXchXKL01q4mUnpq4C6AalDZ0lgFxyGJkJzBU2+kFeMki9fexQhL/P0qoHEJiM9ACp45iRki+FiSKglh6hVNXRU3Srtf4Cg83m92Cg2aki7nsQDfkNDMciKnkq4CAV2ml1I7BDwafzvs6Yv2SY+Au4XGN+hsiIPK7gUZdBXkmoR1Y/WBjiXAPpKAX1saYTkj3fns6DXrlQzcSHpcm1YkeTgreodb0I11WInJr5R8QlqKe9unn5rlyjlvkCu8JvLr+FdVIYbo7UGKP4bvUmInfNX58O20Bws2WXQCRS5C4d+p9oaAOTkvIlD3qg5YsKMdDUchcxQePMMBrktkJsF4SIQHlkhrqvh1eqylraX6JZSoSgl9255kXexlcSow5cqBlkfFtzo=
X-Forefront-Antispam-Report: CIP:216.228.112.36;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid05.nvidia.com;CAT:NONE;SFS:(4636009)(346002)(39860400002)(396003)(136003)(376002)(46966006)(36840700001)(110136005)(26005)(7636003)(82740400003)(8936002)(356005)(478600001)(7696005)(316002)(4326008)(36860700001)(2906002)(36906005)(83380400001)(70206006)(36756003)(336012)(47076005)(70586007)(186003)(6666004)(426003)(107886003)(5660300002)(82310400003)(1076003)(2616005)(8676002)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2021 08:12:00.9203
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b234dc3e-3df2-4a6d-aec7-08d9266743d0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.36];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3075
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement mlx5_get_vq_notification() to return the doorbell address.
Since the notification area is mapped to userspace, make sure that the
BAR size is at least PAGE_SIZE large.

Signed-off-by: Eli Cohen <elic@nvidia.com>
---
v0 --> v1:
  Make sure SF bar size is not smaller than PAGE_SIZE
v1 --> v2:
  Remove test on addr alignment since it's alrady done by the caller.

 drivers/vdpa/mlx5/core/mlx5_vdpa.h |  1 +
 drivers/vdpa/mlx5/core/resources.c |  1 +
 drivers/vdpa/mlx5/net/mlx5_vnet.c  | 14 ++++++++++++++
 3 files changed, 16 insertions(+)

diff --git a/drivers/vdpa/mlx5/core/mlx5_vdpa.h b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
index 09a16a3d1b2a..0002b2136b48 100644
--- a/drivers/vdpa/mlx5/core/mlx5_vdpa.h
+++ b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
@@ -42,6 +42,7 @@ struct mlx5_vdpa_resources {
 	u32 pdn;
 	struct mlx5_uars_page *uar;
 	void __iomem *kick_addr;
+	u64 phys_kick_addr;
 	u16 uid;
 	u32 null_mkey;
 	bool valid;
diff --git a/drivers/vdpa/mlx5/core/resources.c b/drivers/vdpa/mlx5/core/resources.c
index 836ab9ef0fa6..d4606213f88a 100644
--- a/drivers/vdpa/mlx5/core/resources.c
+++ b/drivers/vdpa/mlx5/core/resources.c
@@ -253,6 +253,7 @@ int mlx5_vdpa_alloc_resources(struct mlx5_vdpa_dev *mvdev)
 		goto err_key;
 
 	kick_addr = mdev->bar_addr + offset;
+	res->phys_kick_addr = kick_addr;
 
 	res->kick_addr = ioremap(kick_addr, PAGE_SIZE);
 	if (!res->kick_addr) {
diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 689d3fa61e08..bc33f2c523d3 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -1879,8 +1879,22 @@ static void mlx5_vdpa_free(struct vdpa_device *vdev)
 
 static struct vdpa_notification_area mlx5_get_vq_notification(struct vdpa_device *vdev, u16 idx)
 {
+	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
 	struct vdpa_notification_area ret = {};
+	struct mlx5_vdpa_net *ndev;
+	phys_addr_t addr;
 
+	/* If SF BAR size is smaller than PAGE_SIZE, do not use direct
+	 * notification to avoid the risk of mapping pages that contain BAR of more
+	 * than one SF
+	 */
+	if (MLX5_CAP_GEN(mvdev->mdev, log_min_sf_size) + 12 < PAGE_SHIFT)
+		return ret;
+
+	ndev = to_mlx5_vdpa_ndev(mvdev);
+	addr = (phys_addr_t)ndev->mvdev.res.phys_kick_addr;
+	ret.addr = addr;
+	ret.size = PAGE_SIZE;
 	return ret;
 }
 
-- 
2.31.1

