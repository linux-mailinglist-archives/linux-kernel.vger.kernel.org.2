Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 409A0396660
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 19:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232509AbhEaRFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 13:05:08 -0400
Received: from mail-bn1nam07on2067.outbound.protection.outlook.com ([40.107.212.67]:57226
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231903AbhEaQGu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 12:06:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I8yJjqL7Lf3X6bu7TOD2poVu8dnIIZZttWU43mcOkYiBZxO4E/tuEQyxJ4bUUlPsNDKqvwbPmUIF9QOnpihm+FsiKHZzBaB/5ncCW376RolNsB3LFnLn/fKjFKE27VcbBBJBwWUexzTpa/WgzG+pz2urjeAwuMs048HFVHJg+gWoJmhYEscNguogVMrj8cO6nS1pVnPewv7HXS+mT/FGf94X9e6d6U3u9SXvP1wm026EXFarh2r545Uwc4EUmeJO23JJkHZYlPkOdosHHhk0A9JywQaF/jFRNRDrHitFaiDFXkUlqTJDDeuv/M9/GAY6x4FGQMLuoIl0qyBX+yXPWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vtm5f+loWC4cBuyM9eGmuMBzcABGq4++Uhcb3FKNDVI=;
 b=Uz8DvftbZuRoc8Pbx4jvuZibcDnzqcjkcQEMmDWv6Id6chXyp562vZ1Fv4V/16+VUS9CLA49xTjnAnAf64wYy19Pw16TQUdl/8HrCNUdSY85B/Vjh/AvQVxcQou814Oe1NKb8CDK4qmBBzaf4TK5ZaojPtI23WdD0pwmh6c0ukui/74NHJ7aA5yzhVMAv2EQLNDMPXoQC0PM6BrQT5Q+kScTJ/kSel1MAZe0Hx+C0KZ1ITwsx8Vf+O7dNK9WQ3bHMQWTiSgf+tuQtnDv15ee2PIuY56y83vIlwNQDg2+icFKisy5KqPkh29Sztebp3BbMX7vObayzcWIRcL+tHvVbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.32) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vtm5f+loWC4cBuyM9eGmuMBzcABGq4++Uhcb3FKNDVI=;
 b=tOhGqI8SlhoOuWFH4np1DOAkzT6bPqGGeVZEgGBjTgY9jvpehD5s5M8rv59IveGQNxXKgOp7ZnS2a1KrgKwNpJxKohWhRWt1S+9oGoa5N3avnib/ULEqM/ecB4IBNcQf4VESwh+7G+CHEzjUfWhjJDzjjIYYUry5kVSVAvpZh8w+LvCTdwu3NBPb6H6VNGpx31r/GcwV65TvC4bT48la6eq8mIPZAaULdmzaUF/As/SVAO1iy3DOGh+x2ayVIfq3mxmessPgIIeJyN+3o6vi971aIKohZ+7xWhuMEwqSruJIWzsmqxTL7j2Ms7VIPMeDOdOhn1LW75FywCTJORit0Q==
Received: from BN9PR03CA0732.namprd03.prod.outlook.com (2603:10b6:408:110::17)
 by DM5PR12MB2374.namprd12.prod.outlook.com (2603:10b6:4:b4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Mon, 31 May
 2021 16:05:09 +0000
Received: from BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:110:cafe::8c) by BN9PR03CA0732.outlook.office365.com
 (2603:10b6:408:110::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21 via Frontend
 Transport; Mon, 31 May 2021 16:05:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.32)
 smtp.mailfrom=nvidia.com; lists.linux-foundation.org; dkim=none (message not
 signed) header.d=none;lists.linux-foundation.org; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.32 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.32; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.32) by
 BN8NAM11FT031.mail.protection.outlook.com (10.13.177.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4150.30 via Frontend Transport; Mon, 31 May 2021 16:05:08 +0000
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 31 May
 2021 09:05:07 -0700
Received: from vdi.nvidia.com (172.20.145.6) by mail.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 31 May 2021 16:05:04 +0000
From:   Eli Cohen <elic@nvidia.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>,
        <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     <elic@nvidia.com>
Subject: [PATCH 3/3] virtio/vdpa: Clear the available index during probe
Date:   Mon, 31 May 2021 19:05:02 +0300
Message-ID: <20210531160502.31610-1-elic@nvidia.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 23aec531-67b3-4305-2b2c-08d9244ddd24
X-MS-TrafficTypeDiagnostic: DM5PR12MB2374:
X-Microsoft-Antispam-PRVS: <DM5PR12MB23745C5169BE1051BD0864B2AB3F9@DM5PR12MB2374.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2dtiorrDuLO5yA+GoDTPozsguAGWMm9RdowG2vErK24vJysstyyNFZY6Gdpp9W2hHZpaXp/Xc06o4mHn1nGt44fkl3VSXgXZHQW7JZaVI9RNitofFw8DFC4FQCKSvIb6XZG/4ypN5HEVDSyiGM/alZNoY7HyhxQAsthws3iy7odETDl0OAp0WJgs+B04GARfHDrEOuYujNT8CnShOfQ3qxVIPt6jg2/r+WPrBfENhymQQgdh4t0V7WnFydvEN0rZXjRcMZ1WGFr1NdHuYmAFl0ZGyBaUtyRHkVn6ybHjEY1ogDpvqhtR1ToY65DLx5I4D/Og+RbBGnXRhJeCWVJPetXC3Nqlfbel1N85fAKxXtBwijqsDx4ZToz4GJLatdQsXTgWTjk0unPsAoR1czD3JQsx6Xyir4+m0u9ETjpdRz64KHs2X1TmRirfoODRTtVc8zA7oeP5+qhXGUCpyqVTWug8VsxX9YJnmNuikoqv07RUrpv2bwAL3eGW1Dme4vqzEvvcLWiDVKqRv9mW+Q/mChOtkP3lthpQ3pAhkz7lDj93q3Y+BUokluAHl9+iyjv/kt3ewTk7PEd0jrxTVI0MyOuEwxEB7lMSiFJB4WYQ/CTfqa4uoOE1v1zNagLs3lov7t2aCYztqdDBTnJBcv8okUN333p/e0gxLGJ34Chw3guvSfhXReABJaB8n8xEyv9v
X-Forefront-Antispam-Report: CIP:216.228.112.32;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid01.nvidia.com;CAT:NONE;SFS:(4636009)(376002)(346002)(39860400002)(136003)(396003)(46966006)(36840700001)(47076005)(4326008)(478600001)(36860700001)(7636003)(186003)(2616005)(36756003)(82740400003)(2906002)(426003)(107886003)(70206006)(8676002)(316002)(82310400003)(5660300002)(26005)(110136005)(86362001)(336012)(8936002)(7696005)(356005)(1076003)(70586007)(131093003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2021 16:05:08.9033
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23aec531-67b3-4305-2b2c-08d9244ddd24
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.32];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2374
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clear the available index as part of the initialization process to
clear and values that might be left from previous usage of the device.
For example, if the device was previously used by vhost_vdpa and now
probed by vhost_vdpa, you want to start with indices.

Fixes: c043b4a8cf3b ("virtio: introduce a vDPA based transport")
Signed-off-by: Eli Cohen <elic@nvidia.com>
---
 drivers/virtio/virtio_vdpa.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
index e28acf482e0c..32fb121a6ec4 100644
--- a/drivers/virtio/virtio_vdpa.c
+++ b/drivers/virtio/virtio_vdpa.c
@@ -142,6 +142,7 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
 	struct vdpa_callback cb;
 	struct virtqueue *vq;
 	u64 desc_addr, driver_addr, device_addr;
+	struct vdpa_vq_state state = {0};
 	unsigned long flags;
 	u32 align, num;
 	int err;
@@ -191,6 +192,11 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
 		goto err_vq;
 	}
 
+	/* reset available index */
+	err = ops->set_vq_state(vdpa, index, &state);
+	if (err)
+		goto err_vq;
+
 	ops->set_vq_ready(vdpa, index, 1);
 
 	vq->priv = info;
-- 
2.31.1

