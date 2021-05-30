Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A00E1394FDA
	for <lists+linux-kernel@lfdr.de>; Sun, 30 May 2021 08:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbhE3Ge1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 May 2021 02:34:27 -0400
Received: from mail-dm6nam08on2084.outbound.protection.outlook.com ([40.107.102.84]:55073
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229581AbhE3GeA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 May 2021 02:34:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZCPvw+TUKQ53VsdI+rbDwtwOXUsvIPt7oLDa+vw9PnAKGL7px9nqBEmFnchhZ9qhxoRzHimRBMUZW5L0/o9tvB/3rA65Ge/hcmF4UtZKR3SxkOc4cDStUNlzUsJOfmexi+XgsOqllLc1GrZdrluOHM5+xR29VnagltwqNgRENcACdaJ8nwQL5Sm2Tz2x/y0yYlzehdKLRoe0oNfxsR5h5HNQ0Sc85AWupdpbRUKkuIWI3Q4l2GX48YA5ZRSlVkvgKaPO5PkI8prkz8hAvoB++fm60PuWryjOItkyvl8oxa9+Jy9N0W1IeCeS64zEBa7MbIi8H32BUu/AYLNcmNQ8gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DMIXW/FGiKzhEqGcpNvxktm4G7fC4dSsJJInNdcoWzA=;
 b=gQYlzsJavYJciOWAffJtiwjvRjbqggo4h/+/AvYyMwE1RFZgczyqynCbjRcFzFYgBd3sk+ffl+ilRXWOSnhQY+/sgZfQN0kAFqNZnTNzNpZXQAsEOnZU/p/vB3lk8XysSpYdLcVNHZySmSAwkccjnQ/p+/h31BptSip1mQDXfD5g8e3eUTrrry562IiodvynCMQzw3mf3sJou9gAt88M6W871etTyoR5LVY81xRmyKX65fqL96dA5j0yzJcJjDds1hxk3svFM9HbUdRIvQLygvs85J+VcOBNgGZtZO2M/Oca3OW8g11ODxU5RJ/sydz01x+Lv3DIJ/HihGYzttXOJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.36) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DMIXW/FGiKzhEqGcpNvxktm4G7fC4dSsJJInNdcoWzA=;
 b=Hn+YCFtYBz7tb/8JeH+f/RJlWsywOiS71wdrovBLM8GuO3mE0sf6605Bd6D3ydv3PCNlqJpNv3w+mwuT406E4yqFyMUkb2qn4guneuqYCB2QU8P1L8cEapQVObkP2QeX6gojw+NjpoCR9H7fgOGXNSZC29NIWeLawlY+r/e1W3Sc/y1p99kx828ml3EJkg17QX48Vbl5qjRWxNPoInHvqd237e8s6DI60A58PvFU8EO0QZS9iAIR6CGmqlkUHHSPgg2+XlETWpxEvNtlJFFJ1EHWHa3UjZJCZL9XMLkYjO+SVeA1YZ/Fxxsx4LIFo8fqY+rRvjhuqG/It+x6eayfVw==
Received: from BN6PR16CA0018.namprd16.prod.outlook.com (2603:10b6:404:f5::28)
 by CH0PR12MB5027.namprd12.prod.outlook.com (2603:10b6:610:e2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Sun, 30 May
 2021 06:32:21 +0000
Received: from BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:f5:cafe::4f) by BN6PR16CA0018.outlook.office365.com
 (2603:10b6:404:f5::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Sun, 30 May 2021 06:32:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.36)
 smtp.mailfrom=nvidia.com; lists.linux-foundation.org; dkim=none (message not
 signed) header.d=none;lists.linux-foundation.org; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.36; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.36) by
 BN8NAM11FT030.mail.protection.outlook.com (10.13.177.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4150.30 via Frontend Transport; Sun, 30 May 2021 06:32:20 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 30 May
 2021 06:32:19 +0000
Received: from vdi.nvidia.com (172.20.145.6) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 29 May 2021 23:32:18 -0700
From:   Eli Cohen <elic@nvidia.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>,
        <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     <elic@nvidia.com>
Subject: [PATCH 2/2] vdpa/mlx5: Fix possible failure in umem size calculation
Date:   Sun, 30 May 2021 09:32:14 +0300
Message-ID: <20210530063214.183335-1-elic@nvidia.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f21ebca7-9bd0-4be4-4d38-08d92334ad5c
X-MS-TrafficTypeDiagnostic: CH0PR12MB5027:
X-Microsoft-Antispam-PRVS: <CH0PR12MB50272279AEEA01595EAE3F9AAB209@CH0PR12MB5027.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q8dHkXrDsZzqa6XXaP+HimvAXdg4pQHauxjYIcq/6SH1hxJFwnLH3slVq02WEnlM0Zx8j7l5qWfufMGspuqQb8V79o5W7wP4+cAbXMZ01VPE3szhIE9abOyzi83D2Oig2qNj5aoDrLvNdk2cDAif66qTXm5gPXdASjYu1KqbaiMJp8Ckk8GzHGSSGPk11AacgQ5umnb0Ew3uSiCZ24dFkBDwXcn4sPFXY6wOwJ3EipSMF6AIyH5y9Lr8MwoNkKHBKXkqPuQtR8Hp3WiwRvzz/QrB0vUMO0msVA7BeOe2asBUUz82ZzDMaelAACy9ckrJFE5cmSLMZxmkU4wzYaVymaQperC6U0oFwcKqLGL7krOeg/FFBaoqKfXnOgkjCIWUCjPodMYGfIL/sotVboKs1lb3SzfI29VDyjTKZAXEiMqljbrU9IEnEsB+6kjCRGd4Av60snHFoWDtPKJd9fj3UmZeCLVCqOe66Nwms5MqH/hBd2LSK+orPf9uFMJMOfvYPF2gm8lC8CQUkEssB6uSvABusyJHR0B9hjXuKZ7LrAWuDyJh0WaZLT4nvZlJDgjMj+MnzlPW7QAwPfvuZzLpkaV9Z5//SyQKwZUWGjhBSZWJs2u47n+lT+7OPK2zHGZxIEcYIJ1JN6D5MiR6QK22gA==
X-Forefront-Antispam-Report: CIP:216.228.112.36;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid05.nvidia.com;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(39860400002)(396003)(36840700001)(46966006)(5660300002)(2906002)(26005)(36906005)(8676002)(356005)(36756003)(107886003)(186003)(336012)(86362001)(2616005)(70206006)(1076003)(316002)(8936002)(70586007)(36860700001)(7636003)(82740400003)(426003)(110136005)(478600001)(7696005)(6666004)(82310400003)(47076005)(83380400001)(4326008);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2021 06:32:20.1735
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f21ebca7-9bd0-4be4-4d38-08d92334ad5c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.36];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5027
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

umem size is a 32 bit unsigned value so assigning it to an int could
cause false failures. Set the calculated value inside the function and
modify function name to reflect the fact it updates the size.

Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")
Signed-off-by: Eli Cohen <elic@nvidia.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 53312f0460ad..fdf3e74bffbd 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -610,8 +610,8 @@ static void cq_destroy(struct mlx5_vdpa_net *ndev, u16 idx)
 	mlx5_db_free(ndev->mvdev.mdev, &vcq->db);
 }
 
-static int umem_size(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq, int num,
-		     struct mlx5_vdpa_umem **umemp)
+static void set_umem_size(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq, int num,
+			  struct mlx5_vdpa_umem **umemp)
 {
 	struct mlx5_core_dev *mdev = ndev->mvdev.mdev;
 	int p_a;
@@ -634,7 +634,7 @@ static int umem_size(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq
 		*umemp = &mvq->umem3;
 		break;
 	}
-	return p_a * mvq->num_ent + p_b;
+	(*umemp)->size = p_a * mvq->num_ent + p_b;
 }
 
 static void umem_frag_buf_free(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_umem *umem)
@@ -650,15 +650,10 @@ static int create_umem(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *m
 	void *in;
 	int err;
 	__be64 *pas;
-	int size;
 	struct mlx5_vdpa_umem *umem;
 
-	size = umem_size(ndev, mvq, num, &umem);
-	if (size < 0)
-		return size;
-
-	umem->size = size;
-	err = umem_frag_buf_alloc(ndev, umem, size);
+	set_umem_size(ndev, mvq, num, &umem);
+	err = umem_frag_buf_alloc(ndev, umem, umem->size);
 	if (err)
 		return err;
 
-- 
2.31.1

