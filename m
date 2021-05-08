Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80FBD376DDD
	for <lists+linux-kernel@lfdr.de>; Sat,  8 May 2021 02:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbhEHAce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 20:32:34 -0400
Received: from mail-dm6nam12on2083.outbound.protection.outlook.com ([40.107.243.83]:57440
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231396AbhEHAbR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 20:31:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wb4Essvv5JYEN6c9lLQca2AgVOdzwstJ4lzkDqdk9Rsyi1dRtMIAQ8+IhpgLxVtiSfyreOzyNzTlXJQ2/SjPhK8og4hBA7xgnL0u2xlRaW+Pz5Upoj4o53y3THeoYIve3KhOl5s82uomNfIfKqCOSK2/7iP2hw7TZ1Uy7rmG3uhe1caCN/pYuVGRcnXYwK4l+aZ3qqtk5gymkMpB9ZumeVFKn60eo8BEy1mp303BHf4sVyuciQo1Xddc61yGtkUqon1tlHKgLEYi1VV44z/Ur0b9XA+M3LHfjanWQ8XKAssRJIcbLvB0LMsknjyiL3Lb2oTEXsm6Xn0b2jzPiPpZ1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dBzeHmEa0rACwzkbn1Pjo4FgmihouGO5M9XYT+VJLlg=;
 b=IsyGntmDar7e9Pd+G3Yx1WTfWexzToiHjVesUqEENWicpMza66HGP01YLBM2b2D/5zIMT36n/iQ+bD0zPaEaNFMUaNZ6Y4i9C7Q3fwA5Qnt+aCOUbist4ZNhDJMSv+sM+Wr94JZTqxDt5uVJbZkKwXuBjFVyRhQjIummy3SD1gqigfDpSiMWViNKwkeDlH/DnhLv8QIlsB3iuALP4WJ1qQgMGhEyoDJ6RaKqlAXs/ne907OHovvFCuQK5g9eqIIyEbPNhpGilq0vYRYn7onEgl0mhE0QH7vTIX0Sezqm/r4xmukAu78kSYdc6qTxj4GpF4eFZFAmxOk1RAwolxzrOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.32) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dBzeHmEa0rACwzkbn1Pjo4FgmihouGO5M9XYT+VJLlg=;
 b=BcSZl3UYk/K6kvquAfCygGQWmW8ZoIgcwkcVZqfreOCfYPcsjYcq1woz4OoxC1SEV78TR6FPtHez5Bvh7ATVJAhZcLhuSKC4Ple6+zKEwtDQ4A1yAvnvwl/mQTp74gDz+soh8aaGrBW1VeS0KVGsk3NP7YkOjnvB/cKKmjU4uV+RDIusbKqld+A7FfOUNE3f2/pogXLaceFLLjuYhfKYZt2VNw0g0umcfj36zmOpEtcnm0WMmGMEGQjsDnt6eYR+TPgUR0Hep8SJ6d0IZ0C+Mo55G5czUx/VbN4R2qot84CZ08cVpk+taUA48ErlApMMlNiIYJ/9e/tovk9tIRb2bg==
Received: from BN8PR15CA0044.namprd15.prod.outlook.com (2603:10b6:408:80::21)
 by MN2PR12MB3021.namprd12.prod.outlook.com (2603:10b6:208:c2::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.27; Sat, 8 May
 2021 00:30:15 +0000
Received: from BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:80:cafe::f5) by BN8PR15CA0044.outlook.office365.com
 (2603:10b6:408:80::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend
 Transport; Sat, 8 May 2021 00:30:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.32)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.32 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.32; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.32) by
 BN8NAM11FT030.mail.protection.outlook.com (10.13.177.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4108.25 via Frontend Transport; Sat, 8 May 2021 00:30:15 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 7 May
 2021 17:30:15 -0700
Received: from vdi.nvidia.com (172.20.145.6) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 8 May 2021 00:30:14 +0000
From:   Liming Sun <limings@nvidia.com>
To:     Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Vadim Pasternak <vadimp@mellanox.com>
CC:     Liming Sun <limings@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>
Subject: [PATCH v2] platform/mellanox: mlxbf-tmfifo: Fix a memory barrier issue
Date:   Fri, 7 May 2021 20:30:12 -0400
Message-ID: <1620433812-17911-1-git-send-email-limings@nvidia.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <177d12443460bc613aa495fbdbabbbeef43ba7ff.1620400475.git.limings@nvidia.com>
References: <177d12443460bc613aa495fbdbabbbeef43ba7ff.1620400475.git.limings@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e623302f-fb39-4bfa-7f32-08d911b8737a
X-MS-TrafficTypeDiagnostic: MN2PR12MB3021:
X-Microsoft-Antispam-PRVS: <MN2PR12MB302157FEE11815206AF0904AD3569@MN2PR12MB3021.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:556;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zbcj9DapSXw/gzDfbbV0r4g1+ANPFnXmb21qjfHt4M+dVIUuIwBKPYGWL24kY7epiJhYjabE/Kvm2nFP7nGZPOteI3EnsLK8JnYy9/iqiXQYL849U/ftlKeDUn10FUATI2GdeiLpUWNt3u7WEldfcDJ+2XgLmr7kPIii0ziAD4VdaLjTOY5I82zVXCsI/P6VzK31PynsKLMfd1UL1q8+u+FPZcYIzaQyytoh3umomU48X5bj7DWTC8ZDw4tD7KWs7pirbA4oaNo/6jH2OI06PppmZFusjq4EngSWk0bNC91P5pYiTcvLr3e13OJ/e4N//0QHCbIGgg6IOqrNfevX0nbzQH6mAe5JFl6b3l76PGNzImAHpq3YPghLaWDdGbg2JQQVAcXeNa16P1Iyjl6mi8GUIaOQI0cPf/HY0qyviJ5ZJCbASlRjN27OUouexk81VVoW4Q7hEHEuuqnWYGYxF9sQXHLRRuW6nGKSDCKjoQkt/muWcVYIu7sBfjxCAdOD2sulsMWqXgcqDV0SXPlK28kFPujl6/tKWYQcuEhxOyTDN9dYoRpfp/fRHPs42BnNroTo2UPTn5EllmjWzGAJTsqThcOEuM+b299EehN8wEepS2JALNdyVv+YRBuAWHa9++YQmkFi3InXvHJJGQPq9g==
X-Forefront-Antispam-Report: CIP:216.228.112.32;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid01.nvidia.com;CAT:NONE;SFS:(4636009)(39860400002)(396003)(376002)(136003)(346002)(46966006)(36840700001)(70206006)(8676002)(70586007)(26005)(8936002)(4326008)(478600001)(54906003)(186003)(82740400003)(5660300002)(2616005)(47076005)(336012)(110136005)(426003)(7636003)(316002)(86362001)(36756003)(356005)(2906002)(36860700001)(83380400001)(7696005)(82310400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2021 00:30:15.6889
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e623302f-fb39-4bfa-7f32-08d911b8737a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.32];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3021
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

Fixes: 1357dfd7261f ("platform/mellanox: Add TmFifo driver for Mellanox BlueField Soc")
Signed-off-by: Liming Sun <limings@nvidia.com>
---
v1->v2:
  Updates for Vadim's comments:
  - Add the 'Fixes' field in the commit message.
v1: Initial version
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

