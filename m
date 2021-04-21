Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9B036695F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 12:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237757AbhDUKmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 06:42:50 -0400
Received: from mail-dm6nam12on2060.outbound.protection.outlook.com ([40.107.243.60]:62561
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234361AbhDUKms (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 06:42:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Da63PyB0BLVqo4Mt6nKLEWFPgo85ybNdJuS5vi3IwfFq92vYWFhvfsUaxiCsM3+MinVORkfLa6IJZ05fRKknoCBlpHSH/J5L1BFPr6RFOWZc1IJSNxlHgGF7jw6tOlxpQRXMy6Sz4cooJD/65d6JCUtyv3zjRB/tbCSWU27IMuvKr0Z2btMy+vH/vpZ9BmVflOdbRuMQvFv9tca4hpobX8FoT9dmbWZMUcQhWe2xhA+DM4mHPXbMPQoAtQtv12kdLkm5Ua5JMfAZ82JsI+IB91SaALTbRD/5RAZ1aqxpHZTDxmBIrOUEkvuXoOESrBOwqR7Pztju1UzYqK7z6F6Nfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5MGOaXWDmU02IqgxJoTys0hSGggvrrrANG39SQGPNI4=;
 b=YyeftNg7x7Q7JbE5k7xriaQoSs0+NlZdG6ALcPWITEeM5ZTaSvGwUiumKMIoP91uZ1ecVOpgqHrXuCtNqRtqknhNPNzWRr0Zf8w9Z5eVS8NX7Npn3g/+fUcUvcrz/sHNH0h3RGaz5zJy6miH05oiI4nGGFf91QmZmhNoIa0EQ7Ekn/nAAob3W7Uya7VJBVq4Lo3VC0rBopWeHXR5E4iZEaoIlYCjVPK2gHqSe33xvfOkqyxu9PAmqlogwp2+q95zVByT2micZV+Rqx6TfJZulzYn8B6fG5Ij9BT4jSErN6E890SM1cc0i58NB2CcZguc94qbB9z8i7kQuvoWyIKQJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5MGOaXWDmU02IqgxJoTys0hSGggvrrrANG39SQGPNI4=;
 b=sK/IsJYxAnDMxR1Udhx79Fvkg7JnIHoHFG/kABeDdoAjY3lcPQdKaNhb+5/0x8Dt7nU6C97ZtK/NQczoQvOMQmM2HNGYDjqXFA+yxUuZ1RqUnXdoUsvKFGCeV6XPC2uHvv8hvsdfX6KzA6fthr7hI/Uy4Jnq00kgLky/9ZP6GGy3n70UTElwTnDzXE+eYUJiUC4w8OxE8cPBWW69QsQnZ/N5yVMA3hjr4qId6ElZ2W3ItkXuxhuSkq+MUOundndxZUKnT/k8qHiaTQptqhQklyDenFcWqfdSSAJRGl6N0u+rXXZ1RBfMtDdtCnlNRaxiuY7NFbVimoRZoFuuGWudJg==
Received: from DM6PR01CA0020.prod.exchangelabs.com (2603:10b6:5:296::25) by
 MN2PR12MB4566.namprd12.prod.outlook.com (2603:10b6:208:26a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.20; Wed, 21 Apr
 2021 10:42:14 +0000
Received: from DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:296:cafe::c3) by DM6PR01CA0020.outlook.office365.com
 (2603:10b6:5:296::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20 via Frontend
 Transport; Wed, 21 Apr 2021 10:42:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; lists.linux-foundation.org; dkim=none (message not
 signed) header.d=none;lists.linux-foundation.org; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT063.mail.protection.outlook.com (10.13.172.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4065.21 via Frontend Transport; Wed, 21 Apr 2021 10:42:13 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 21 Apr
 2021 10:42:12 +0000
Received: from vdi.nvidia.com (172.20.145.6) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 21 Apr 2021 10:42:10 +0000
From:   Eli Cohen <elic@nvidia.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>
CC:     <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <elic@nvidia.com>
Subject: [PATCH] vdpa/mlx5: Add support for doorbell bypassing
Date:   Wed, 21 Apr 2021 13:41:45 +0300
Message-ID: <20210421104145.115907-1-elic@nvidia.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e8aebc16-f17d-4aea-2f0c-08d904b21fc8
X-MS-TrafficTypeDiagnostic: MN2PR12MB4566:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4566FDDD1B2A25281CF5BE2FAB479@MN2PR12MB4566.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KOZEHKiQeYB/zfAs8wfmWX9SwBzBja25IECQnj1/1ZvXKVR6u3eLbQTjIZFgD0MbE6EnOym/JKo0YOV1IFmZHDuzyz1RYbEl/JI7fo4sbFHThSppwwhJepIQnukTYjX86IMLXwQcXIpw7CJhkIkaxlhgQcEEYN3KunslLqgbsDosneNWSC5pewKlREQDnqatwH0UqN1I1eb4zxqgHNGCz8mfXC9+SsSa7DTyTXRI1nZOGRy/w8ZrjW/ipDuTPCqn0+6zHgyWorKgTaIDappHqFQJuW3PMkniglzGzXYNTynS4X/iCaP3mAZGsXKHriBYZY33j2JgRAaz/0piH+dBEYTt4DTqZeVRw4NqFT1HNo4TeuZPo618ec4oMFv7oHyokRuMc+AtbufV/tx9C7/HQCN8I5AB23cqaQYMsdzzBcuTMaDeaXCPJpxVO8hpEZEYSjN5r1+lZBb+C9fxs5I8A7mFJ/Ev7UleHZd5i3L9E4HbW2pH0flw3nuGgpI01zLbYZ7Rpl94sn0XGjttWobwYQikIUqwAqIA3f2al1WbEq7ta4gQRvDQryabFjSw89bgaXT55B1Eaxn8oFtUsCeeUmXlujArdsxrxCvOu7m+CTCrObYh9NOY5/bZ0jfKxQr7jpVq5NvMb5Eg0ks2AU70dxoB1bhPirFyFg3i2oEEEjE=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(376002)(136003)(396003)(39860400002)(346002)(36840700001)(46966006)(47076005)(36906005)(186003)(86362001)(316002)(1076003)(4326008)(426003)(70206006)(7696005)(5660300002)(336012)(2616005)(8676002)(82310400003)(107886003)(70586007)(7636003)(356005)(8936002)(36756003)(110136005)(2906002)(6666004)(478600001)(36860700001)(26005)(83380400001)(82740400003)(54906003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2021 10:42:13.2319
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8aebc16-f17d-4aea-2f0c-08d904b21fc8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4566
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement mlx5_get_vq_notification() to return the doorbell address.
Size is set to one system page as required.

Signed-off-by: Eli Cohen <elic@nvidia.com>
---
 drivers/vdpa/mlx5/core/mlx5_vdpa.h | 1 +
 drivers/vdpa/mlx5/core/resources.c | 1 +
 drivers/vdpa/mlx5/net/mlx5_vnet.c  | 6 ++++++
 3 files changed, 8 insertions(+)

diff --git a/drivers/vdpa/mlx5/core/mlx5_vdpa.h b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
index b6cc53ba980c..49de62cda598 100644
--- a/drivers/vdpa/mlx5/core/mlx5_vdpa.h
+++ b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
@@ -41,6 +41,7 @@ struct mlx5_vdpa_resources {
 	u32 pdn;
 	struct mlx5_uars_page *uar;
 	void __iomem *kick_addr;
+	u64 phys_kick_addr;
 	u16 uid;
 	u32 null_mkey;
 	bool valid;
diff --git a/drivers/vdpa/mlx5/core/resources.c b/drivers/vdpa/mlx5/core/resources.c
index 6521cbd0f5c2..665f8fc1710f 100644
--- a/drivers/vdpa/mlx5/core/resources.c
+++ b/drivers/vdpa/mlx5/core/resources.c
@@ -247,6 +247,7 @@ int mlx5_vdpa_alloc_resources(struct mlx5_vdpa_dev *mvdev)
 		goto err_key;
 
 	kick_addr = mdev->bar_addr + offset;
+	res->phys_kick_addr = kick_addr;
 
 	res->kick_addr = ioremap(kick_addr, PAGE_SIZE);
 	if (!res->kick_addr) {
diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 10c5fef3c020..680751074d2a 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -1865,8 +1865,14 @@ static void mlx5_vdpa_free(struct vdpa_device *vdev)
 
 static struct vdpa_notification_area mlx5_get_vq_notification(struct vdpa_device *vdev, u16 idx)
 {
+	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
 	struct vdpa_notification_area ret = {};
+	struct mlx5_vdpa_net *ndev;
+
+	ndev = to_mlx5_vdpa_ndev(mvdev);
 
+	ret.addr = (phys_addr_t)ndev->mvdev.res.phys_kick_addr;
+	ret.size = PAGE_SIZE;
 	return ret;
 }
 
-- 
2.30.1

