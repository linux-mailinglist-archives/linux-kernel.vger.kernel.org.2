Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9874C3767CD
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 17:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235255AbhEGPUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 11:20:46 -0400
Received: from mail-eopbgr750075.outbound.protection.outlook.com ([40.107.75.75]:60973
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234986AbhEGPU0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 11:20:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DQ7XLuMLoftgSHV1Io/DGeTyVeV97j8YJS6PbyqIKPt2BFF/PSmdITERCkJ105yCAwtCZZoi72bBQa2BmXG4NjOFltaC45golirogmNEQuB9PXNB8nE6ppXqE5+Rt2z7V324aFpbZIabNrsLLB87EVtkMYL9lgCqaiC/lIGjTaHELip372XNDU303UWuIUzC3SFWtmfu/EiOjjKDvqUGpnRp0tyqg33ygKw3NzVn2rtgeDGu340iRP2RkFFkDrZm9Nt9noWQzgTaDq7mAWGJtSOggTPn9vVNJDVpeFw/SXnYxp4k0ZVdEbi2uD8oGWOcvobi+7VEvj5Ma9o9gDtwDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GbEZz2n+tapIljuUc48Fxgac9r6ElzY36Em4ewmIaxU=;
 b=QUN+AgT+qvIkm+rEwei/pjM6yF81gp6aV4cAOBf/UDAfSt+NXKpVWNl97GEP9g6cIaMRARQjwz6iMOYthgnjPmFN2oafW22BzczXZxLXxV0TfMl0MWSME3EUF+q3AsOgKLjomWt+u9KMYu1A93UBxXnSp5YOdobiBNp5/82dJeAnuIicGLVXG4+gokxNUrFzkYKUFbtWUX4Vp7eTUEmHfb3n+5bQOxR08RXQzLDPPafShZ80qUsxTbRGh1VUGGW50wuqerAsfBpX3Py7DjTLWFz6LP1pBL3sKGvoxeZKuGvz86CpKFaO5Dmawg14pQVObaMBl5SyxkCbMD4fDYSxqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.32) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GbEZz2n+tapIljuUc48Fxgac9r6ElzY36Em4ewmIaxU=;
 b=uWUgdvky1zW1mmkaF2O6SjWtCZ1KT2ATQglTvxU1v0jZM+T3lW4V8yO/rKKNcA9CGMYmm5NEpD9A0j0n3iDGFuqHzc6XuEuj7mftfqU6aUCfYKS0Kbt50lXIz00hiRRTXaw0wWXRBjM03OnXJ5DGbJyKqlBamdOpCDzwuAUeR7NLCNjVXq/IQwM2otHRDFQuWUQYStga2LuBpkxzwg2GlSy41poL6cDmcIwBSTFYh9OreArrzeuyzCfCZd6nsLTD6yharIsBzfOVjuqdtOQXOR7wWpIPi5GlrvAnC1tvJcoaLfTrSO3T4M8CQOjFHerrzsJ4YbdbjyM9J5HDav3v1A==
Received: from BN9PR03CA0391.namprd03.prod.outlook.com (2603:10b6:408:111::6)
 by CO6PR12MB5457.namprd12.prod.outlook.com (2603:10b6:5:355::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Fri, 7 May
 2021 15:19:23 +0000
Received: from BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:111:cafe::37) by BN9PR03CA0391.outlook.office365.com
 (2603:10b6:408:111::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend
 Transport; Fri, 7 May 2021 15:19:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.32)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.32 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.32; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.32) by
 BN8NAM11FT060.mail.protection.outlook.com (10.13.177.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4108.25 via Frontend Transport; Fri, 7 May 2021 15:19:23 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 7 May
 2021 08:19:22 -0700
Received: from vdi.nvidia.com (172.20.145.6) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 7 May 2021 15:19:21 +0000
From:   Liming Sun <limings@nvidia.com>
To:     Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Vadim Pasternak <vadimp@mellanox.com>
CC:     Liming Sun <limings@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>
Subject: [PATCH v1 1/1] platform/mellanox: mlxbf-tmfifo: Fix a memory barrier issue
Date:   Fri, 7 May 2021 11:19:14 -0400
Message-ID: <177d12443460bc613aa495fbdbabbbeef43ba7ff.1620400475.git.limings@nvidia.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d6f82deb-a9ed-4505-a652-08d9116b7eec
X-MS-TrafficTypeDiagnostic: CO6PR12MB5457:
X-Microsoft-Antispam-PRVS: <CO6PR12MB5457AD4DD29212452672F25BD3579@CO6PR12MB5457.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:556;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eyl1t4kpJQiJY9L+E/7hr7sW+4MlR8PfXVuqd1p8qNfJJSFBqc560vPXdCoExQ3/iIUUbpgK0FP4Ji2bI+GWY6tcGXlwZyd5TT6f3a9wsEw3G3JOzZ2kf0pTRQQ7Zon3C/P2OlmmSRIp9Bj4SWFU2wqLlKzfqVAhfa9nklhZUGanBMy/D1w4HHbqzewrhKB8xAk5EU7NvxHj/QW97cH1xmMQhL6QtGP/hy7KJC6dYq+tGfKuMXI3RWLqrDLDt3vfq9ZFU+GARAVx6dutC7hfc2kMXf0bn6dYFDoYXOyW/x22jVzQRM/I/n1fougdUm1hBYDpGBU5Iu6/QD2o1JgcA0NwPpAmwkULRONfsOF76NTzzbydWMt9f4ftzGYFynuK+EiCimjkM2+9g+LxGLJnBM8jBFwWkqFv/712pFnsZJnD9lB7MKqfMAUThJbf7UXk7alaIfRSYpd/ac16NBo4e2nbs1nkdjAD9ULJWVWMr8M1+ABNqkdUbw3EtLomskkJBpRvPf/HFC7C5rKDVtD3sYoD4sWa4k3S92AS7KcCr1/BeXB3ObMyFIn9OUiHy9CV6JhK1HA4pjxSp/48kbTPPjZNych21ZhtmymW9bY6AVB5o9Kqrkpsy5Yr/jpIopnYAHC4kJdAoz2BR5+me82Tow==
X-Forefront-Antispam-Report: CIP:216.228.112.32;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid01.nvidia.com;CAT:NONE;SFS:(4636009)(39860400002)(346002)(136003)(376002)(396003)(36840700001)(46966006)(86362001)(47076005)(5660300002)(8936002)(82310400003)(70206006)(2616005)(54906003)(70586007)(82740400003)(426003)(83380400001)(110136005)(36756003)(316002)(7636003)(36860700001)(6666004)(336012)(26005)(4326008)(7696005)(186003)(8676002)(2906002)(478600001)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2021 15:19:23.6148
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6f82deb-a9ed-4505-a652-08d9116b7eec
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.32];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5457
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The virtio framework uses wmb() when updating avail->idx. It
guarantees the write order, but not necessarily loading order
for the code accessing the memory. This commit adds a load barrier
after reading the avail->idx to make sure all the data in the
descriptor is visible. It also adds a barrier when returning the
packet to virtio framework to make sure read/writes are visible to
the virtio code.

Signed-off-by: Liming Sun <limings@nvidia.com>
---
 drivers/platform/mellanox/mlxbf-tmfifo.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/mellanox/mlxbf-tmfifo.c b/drivers/platform/mellanox/mlxbf-tmfifo.c
index bbc4e71..38800e8 100644
--- a/drivers/platform/mellanox/mlxbf-tmfifo.c
+++ b/drivers/platform/mellanox/mlxbf-tmfifo.c
@@ -294,6 +294,9 @@ static irqreturn_t mlxbf_tmfifo_irq_handler(int irq, void *arg)
 	if (vring->next_avail == virtio16_to_cpu(vdev, vr->avail->idx))
 		return NULL;
 
+	/* Make sure 'avail->idx' is visible already. */
+	virtio_rmb(false);
+
 	idx = vring->next_avail % vr->num;
 	head = virtio16_to_cpu(vdev, vr->avail->ring[idx]);
 	if (WARN_ON(head >= vr->num))
@@ -322,7 +325,7 @@ static void mlxbf_tmfifo_release_desc(struct mlxbf_tmfifo_vring *vring,
 	 * done or not. Add a memory barrier here to make sure the update above
 	 * completes before updating the idx.
 	 */
-	mb();
+	virtio_mb(false);
 	vr->used->idx = cpu_to_virtio16(vdev, vr_idx + 1);
 }
 
@@ -733,6 +736,12 @@ static bool mlxbf_tmfifo_rxtx_one_desc(struct mlxbf_tmfifo_vring *vring,
 		desc = NULL;
 		fifo->vring[is_rx] = NULL;
 
+		/*
+		 * Make sure the load/store are in order before
+		 * returning back to virtio.
+		 */
+		virtio_mb(false);
+
 		/* Notify upper layer that packet is done. */
 		spin_lock_irqsave(&fifo->spin_lock[is_rx], flags);
 		vring_interrupt(0, vring->vq);
-- 
1.8.3.1

