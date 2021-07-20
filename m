Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAACB3CF3EF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 07:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240926AbhGTEpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 00:45:16 -0400
Received: from mail-bn1nam07on2064.outbound.protection.outlook.com ([40.107.212.64]:15228
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236395AbhGTEpM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 00:45:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oeokJ1z4/RYjlgiFTrN6Aa0bm2ccf99FFeaYvqNtG9QyG8YTDD3cAumrM3TDRspySWfQa/IFKQSTXtzDbOnzaqWSqIL5EA6H8ZlbLdL1h2M7lRpTT3wPrRb2jvsDgLrxCxWAx2u9zWJHWNs39ps44V/56fXNKmhlvlrEWr6hp6irIXAp/lJF7wxoB9UZmsq/V3URgibPBdRjYE4ZoTDHDXbfLc8xL6BpxG1hvlV18QCr4HCuq+a8k8UOLkTUDsNiQxrh9zCqqiy3J80bnERUCUVqi9C82G3osVI9tl9dOIibGgSgtzlP5ZPZxTFOEle0YrXmfIJZomJrGmxID2FyiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ju4iQmgLGpgbaLoRjVnrjnGsdXKVnrWlfLuIZsAqqWw=;
 b=W9JlFpUOEl/p9ZC1sNOor0QHgcATHcG9Wk4AvOPwHOcL8Cvbomamhhbhn0BhBcNJuiTG7eAtiKYCg+n10hKM3OOZIgeVTToFSZJGNhW0zmpRIzVFSoR1B9ka2eRnRD9JmggCitRUFDpiZ7dRfQla4/K8SAq1BK2X0UJJJQYCdJ++terlHs0j7Y1PUKZQPHVDZmOoIzrWl1JsnL24IukYWFFzwqiO9Sb9yyURa1H84PhK2vc0mMsYYKglMzQGOQqC24Cu5EgFWu8c2Rl61Ouwoc2AorVr/EcwWptew2X/xFN/bO+j+oE4jpkHSTv/JGneSA7NJrwK53pvbG367c+nnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=quarantine sp=none pct=100)
 action=none header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ju4iQmgLGpgbaLoRjVnrjnGsdXKVnrWlfLuIZsAqqWw=;
 b=g9YuYuyygk3CrKJFEYrP5uqLUuW0Nt6y2jAEuKkK25exC/tN6IRloyt6PhQ91HVR+xy6s9uNbMm30OlJxSBM9LeALP7JZYnLMH9himySlMZL2/85ww8xg0x8oGPuYRX8SU3a4CBc5ZOHow3V9hgfafDYsBhbBAl3M6Y0YZQMgnlfl25w2TrWVJBcu6zFIafIUhyIJ7xLKnCxrYGx1HlIUZFHIv7rPHF2tvTUgYBMs94gpk/9wXktTfgeKuDlXd+kw0YWHCcoMPxvRz92UyXCxr3rb0QvPt7mbj9JhL/eg2YbaXvUVDcpJCmvGd5CCvRm4w7M0yZBhUERJKvmWR4MDA==
Received: from DM5PR2001CA0006.namprd20.prod.outlook.com (2603:10b6:4:16::16)
 by MN2PR12MB4319.namprd12.prod.outlook.com (2603:10b6:208:1dc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Tue, 20 Jul
 2021 05:25:49 +0000
Received: from DM6NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:16:cafe::be) by DM5PR2001CA0006.outlook.office365.com
 (2603:10b6:4:16::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend
 Transport; Tue, 20 Jul 2021 05:25:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; lists.linux-foundation.org; dkim=none (message not
 signed) header.d=none;lists.linux-foundation.org; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT038.mail.protection.outlook.com (10.13.173.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4331.21 via Frontend Transport; Tue, 20 Jul 2021 05:25:49 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 20 Jul
 2021 05:25:48 +0000
Received: from vdi.nvidia.com (172.20.187.6) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 20 Jul 2021 05:25:46 +0000
From:   Eli Cohen <elic@nvidia.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>, <sgarzare@redhat.com>,
        <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     <elic@nvidia.com>
Subject: [PATCH v1] vdpa/vdpa_sim: Use the negotiated features when calling  vringh_init_iotlb
Date:   Tue, 20 Jul 2021 08:25:33 +0300
Message-ID: <20210720052533.415991-1-elic@nvidia.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 87417a1e-75aa-40ab-be3d-08d94b3ed5bb
X-MS-TrafficTypeDiagnostic: MN2PR12MB4319:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4319A27EBD4E2B93F873F221ABE29@MN2PR12MB4319.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1060;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XV61B+y4fPY58DwnbEGc+K9/2svIBHp6iqeimyzr14vAc7y1jJY263f/Amv0iiZB4fgqlqAUOTNbvTe8isQCXF6wmHnVn7UhKhr3CRr4zMIDporIdrVe+cV8ZIziXbHlpNGDEqYDieDooWrnes2iT6kYuMNV2xibVymXvZMtDHmV9NZxmRnjgbAZDwrMbJ94A7gK4fXuWahWNfMFab4DTkNZEm4uOu5SOEwYpeB5ZvpSal7Jfvrk8keHJ1qBtsOCMA69i9d8lc8V8E5boyefNKiuJnT/Br1kjmyAIZlK8iFCGmUn3nRGJjMTZ25r800dK6y3T4VqHJRbBzoDk9DTeXzViXL5WNr0U4qOl1v8ApPc6zk4TvmSYAivTG6jaEGZ2gLHYSU2txenzQq1t5ejQjICJEehmjCXYaK3nzVqxrGA1DSpPEUgk98CM+q9zt+SmeexWukv/sbyhP43ZJvf74u7Hm6Le3xtHbmxpU7/0FZ9Hqvm4f+M6ib/HrnO29f+cEkJdTKRh8Cjn+imDmjy7jjsrTehtbCmRR1FbH8FBbAdTzd6gX99VQHt2lA4hyRvHvpMWTCO2ByTK0z/HLSq5oPk4DPuM3jxtr4mcuVLwAMWaV1vZkShbGJRQSKbIKIIeBWH+FKCExr0BFoQLUM2ruL153jXkIWIvFlv4oDvkRyeyLkynmJF0N2xuuNjhhFlVOqo7QtGsZxvSiLCVDRdfg==
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(396003)(39860400002)(376002)(136003)(346002)(36840700001)(46966006)(316002)(47076005)(186003)(336012)(4326008)(2616005)(70586007)(70206006)(36906005)(426003)(86362001)(36860700001)(8676002)(5660300002)(8936002)(26005)(7696005)(82310400003)(2906002)(110136005)(7636003)(356005)(83380400001)(36756003)(478600001)(107886003)(6666004)(1076003)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2021 05:25:49.4502
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87417a1e-75aa-40ab-be3d-08d94b3ed5bb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4319
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When calling vringh_init_iotlb(), use the negotiated features which
might be different than the supported features.

Fixes: 2c53d0f64c06f ("vdpasim: vDPA device simulator")
Signed-off-by: Eli Cohen <elic@nvidia.com>
---
v0 --> v1:
Update "Fixes" line

 drivers/vdpa/vdpa_sim/vdpa_sim.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index 14e024de5cbf..89a474c7a096 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -66,7 +66,7 @@ static void vdpasim_queue_ready(struct vdpasim *vdpasim, unsigned int idx)
 {
 	struct vdpasim_virtqueue *vq = &vdpasim->vqs[idx];
 
-	vringh_init_iotlb(&vq->vring, vdpasim->dev_attr.supported_features,
+	vringh_init_iotlb(&vq->vring, vdpasim->features,
 			  VDPASIM_QUEUE_MAX, false,
 			  (struct vring_desc *)(uintptr_t)vq->desc_addr,
 			  (struct vring_avail *)
@@ -86,7 +86,7 @@ static void vdpasim_vq_reset(struct vdpasim *vdpasim,
 	vq->device_addr = 0;
 	vq->cb = NULL;
 	vq->private = NULL;
-	vringh_init_iotlb(&vq->vring, vdpasim->dev_attr.supported_features,
+	vringh_init_iotlb(&vq->vring, vdpasim->features,
 			  VDPASIM_QUEUE_MAX, false, NULL, NULL, NULL);
 
 	vq->vring.notify = NULL;
-- 
2.30.1

