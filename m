Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C08B3CD5F6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 15:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240011AbhGSNDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 09:03:47 -0400
Received: from mail-mw2nam12on2049.outbound.protection.outlook.com ([40.107.244.49]:46297
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239959AbhGSNDp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 09:03:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QuDf5mixclf8zO8MzmPFbRlOmBeke7MOqtzJXhe1qcsyEfVgyP0ssFoR3iCvvM8eYmojuEotbeB9/eEI8WXTtXCpvzs9+m03D+SPRgCEosHaa/f7QB+t7qhfMJAYH+gjU59ogP4l45wF+fwWEAV0FRjdQwVyLMqD4b1JBKgm7DaNL3rKAE0eBgUhYxKxs94m8x27fwieo9BaTd2goWqfDJpKeTf3AYp2RTI7oPY2tN53fdjS7A1lMwvorkwFQAc14LFCDYIs2eDBeZJBU3digd6eCvNDUfYY8R6dfrhmCiAMqDabcgUyX3L9QlQ2lPOUAgijnnk3lHWnQRckk2Ai+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1v19/5Gv1fG719jqlg4uoR1E+dfC5fo4bFzThSh2vaM=;
 b=LzLTq8wOPbaN/a/5aSxr9CpawnuKygzhaaTQ6hAVTm85VIPqhR01Al8h1n7gejBfls+M5hsFsyv0ypeNpLzub3BEfrGpBxgqGpVf/zgUe0fWUnvvBeQPmatsi8ZKUWQWrRxoUpr5R8pW3hbp7uSx/GvtgRIQG7HbykLBmxJN4H/pYfFTfAr3nfULVAisRwqhogsJ+1xBellGTEcIYHwNYY2Bi9EplCoHLthKCcCaPgsZkoBUtgvhjYQQhp8+KmWsQ5QLP9f7YyR4W8kpjgcXppGAufve4mPn8aqe90tC8n218SupKXk+FPUIA7SHu9fnWnOBuPmfSaUjOXpeaSv+/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.32) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1v19/5Gv1fG719jqlg4uoR1E+dfC5fo4bFzThSh2vaM=;
 b=IRa6I66tC0LF0I6KEn9JdKK6FyZ5zkJW2rM6VtXrJ2qYuMXMP1NSvPNA64VCe2IsI9qLbrBOrt6o3AfE/On3HCHXp4nXL//qcKIJDMZjXOrmAqm5LATGemR20a6z0WkWoLXvtB3IHnLtj5NZVlxDvr1G/o1/UUfQ0fFNvMUYwYFZvDG+CBQeHxiK/5DXf/5Ia2PuPmu7BsOSNQnXXpvDc8JhE/QrPoG16SovL6YDw30iEvSgZ0EosbwdHi+qbnGex7sQs/r/Gxf2OtneKaa0uXYBOgSBOTKX1D5nBAxX8+FKsalBRxcgqBhBYHqexxrob72/6Hrw/ppJBiz/vS0t6g==
Received: from BN6PR18CA0004.namprd18.prod.outlook.com (2603:10b6:404:121::14)
 by DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.30; Mon, 19 Jul
 2021 13:44:23 +0000
Received: from BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:121:cafe::c3) by BN6PR18CA0004.outlook.office365.com
 (2603:10b6:404:121::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend
 Transport; Mon, 19 Jul 2021 13:44:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.32)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.32 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.32; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.32) by
 BN8NAM11FT041.mail.protection.outlook.com (10.13.177.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4331.21 via Frontend Transport; Mon, 19 Jul 2021 13:44:23 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 19 Jul
 2021 06:44:22 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 19 Jul
 2021 13:44:22 +0000
Received: from vdi.nvidia.com (172.20.187.6) by mail.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 19 Jul 2021 13:44:20 +0000
From:   Eli Cohen <elic@nvidia.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>, <sgarzare@redhat.com>,
        <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     <elic@nvidia.com>
Subject: [PATCH] vdpa/vdpa_sim: Use the negotiated features when calling vringh_init_iotlb
Date:   Mon, 19 Jul 2021 16:44:07 +0300
Message-ID: <20210719134407.175884-1-elic@nvidia.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 86cd09bc-2692-4bd1-2e9d-08d94abb518f
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:
X-Microsoft-Antispam-PRVS: <DM6PR12MB266738DB447E35C0E7B6076FABE19@DM6PR12MB2667.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q4ZBFi9DC32zxwlPvQh4jH0zKT00BR9zBO1ccJGnUIV10NQivVYoBDGjzZ4dTt8ZxUrrejHsXZmM8cwB6xt0nQT1kVOGhe2lmjKYvQfEV9P0Y/6XWfTvtp4+u5jksMP71/RbCuvRiPcR6CCzElj04dnkE1VOXZP0d0rTCcnsMBoC5T/sWGLlSZCXRReuLniqm2EEsWs7W6coAsHoUoqGQwTCIVOY9lEBbl1Nn9qjfxmUklNkGM4XJt0r6T2BKmSOMNPGIUF2iJ6JImp//wqKT79TFBz2d5sAlydk1zpWpnMg/Xy8hKqDj0dcSY0H2nfPyFDqKhyDxIBZ94INZ9Ddn/muXW7KG8OSmx8cV/Et0AAHwhXdRLDi4mCSf3OJXGzsVromptIBkvnT0QCWw9CMIrSG36gLtOWIHdrmsiWmr/xHRrxy9QRQjwfZRMi3CAxrxCUJlm+eMnD6KhSvOs2KaFLzOoRBptJPVTND3P9roiUQszqmk7MjXeKZzq1KN9ixGbAFgpegj5LtPssLEqTkij1GDxoBDhrEuRXRAwuV+hyzKjjHY3kCva9P1W2G2EGlTpdHuy2bVf6V1cUSRZFECxNVn1jUsSVSws8zBZwyJd2teS17/4NFJdNdaRWJ7cGMwsATmPNU9AgqQLCNL4pbG/cf2MVsK1PwEzpudR34JZ1OUJejBY9dsVWL4x29waxnOg0Vg+C2eslldO4kYCgv6Q==
X-Forefront-Antispam-Report: CIP:216.228.112.32;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid01.nvidia.com;CAT:NONE;SFS:(4636009)(39860400002)(376002)(346002)(396003)(136003)(46966006)(36840700001)(8936002)(478600001)(26005)(83380400001)(7696005)(70586007)(186003)(70206006)(36756003)(4326008)(2616005)(6666004)(336012)(426003)(107886003)(110136005)(86362001)(2906002)(47076005)(1076003)(5660300002)(316002)(82740400003)(82310400003)(7636003)(356005)(36860700001)(8676002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2021 13:44:23.5684
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86cd09bc-2692-4bd1-2e9d-08d94abb518f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.32];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2667
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When calling vringh_init_iotlb(), use the negotiated features which
might be different than the supported features.

Fixes: 011c35bac5ef ("vdpa_sim: add supported_features field in vdpasim_dev_attr)
Signed-off-by: Eli Cohen <elic@nvidia.com>
---
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

