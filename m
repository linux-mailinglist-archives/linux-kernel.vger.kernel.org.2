Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6186339CD77
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 07:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbhFFFd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 01:33:29 -0400
Received: from mail-dm3nam07on2062.outbound.protection.outlook.com ([40.107.95.62]:60288
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229465AbhFFFdZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 01:33:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iF7iV8Lbbzm037nC9VrprzoVanhZFDJE/R48//YY3OS89ZrzA88rTAc9mTjVFXuWwX6CBYaGe13g3Wlkm8rQOGb9Qwp+DgN7HvcJavWQYyNg+oJean3Y5/8CN06Xq8eLNlDdVq2E3bqQfKOiBrOHLybxoH5zz/RYvhFL0yymp1S572HLVWIr0Qwxqtn3pdOM1G5nNIhZ817Rkm5cMYdD/dsCqNoM6MwNpDA4K0CpmOcWjA0g6lmAlMErXF0nbsZRgi0oc+UHJmEgmWQdGo5yi8t+X6Gl9unq33JyiYWoyAbT1li43G5ukAj0/pijDNg4cInr4MgJW5/8xzHH5faIEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HyENZwr/a0QJqp1mCo23OR/Z3AdkA0I2JoyD3iPLOaw=;
 b=FreYJy5sEtYPmdGFuCOTpum9q5HVpa1TEp9+FgKLUgdbzpFyg6FJeISD72gT0rnqWmLuhi0OpUq7r6O1kKe5fUDKLWtyMknm77sSzDGlLAot3uwTpPvR94SPa7PYMMSAe2nGAm0/1URUeJwb0e8vBPXC0FmK8BiOs5wK7BtRvLetZJiLyDOvkOKbg1c7ukAsLepeZcPO4IH19WuDGQMrZ1Bxqp3RxlEGZrNoZSex6XMsWc8qVUcLaZGA/ZxQD9dl5rquAPrOCYbOARvSWj/JEbhjjPj4ub805hiiMMdpLceF0L/L2OqjZXD7WHzn14CKFcyiubmut29aTQhLeo/ryw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.35) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HyENZwr/a0QJqp1mCo23OR/Z3AdkA0I2JoyD3iPLOaw=;
 b=RiP1VUbpnPQN5z0aIvtQHpWWH/vrInfLFTYigHSgG+XCDHKkwjZneUG8Qy0BX4aZOYKlP3+fvWUNkJOoXrx42g/Ewb9Sc1eiqaaEDX3aP25a8rdN+YWqaT2IJODhRrHfl9LOkdgUsRClZSXDwGFlTUUlVMUnDgOYIN+/vSAi3DOQVryhgiTU6Cu7nO+KOWG9DQG9IHVwwdwFTDXJTpfFgZlOc/LH0oz8SW226QqGFy6T/k/mA+iLVliSylFfq0ypLPe1p7Uv+Vb5lALQb/CvtIUaOiKUhjdoJNL6NMnAi3+uD0oSy21llBiN6W/VrT83LMlhoLn17FIxXTy1hgUazQ==
Received: from CO2PR04CA0156.namprd04.prod.outlook.com (2603:10b6:104::34) by
 CY4PR12MB1445.namprd12.prod.outlook.com (2603:10b6:910:11::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4195.24; Sun, 6 Jun 2021 05:31:34 +0000
Received: from CO1NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:0:cafe::ee) by CO2PR04CA0156.outlook.office365.com
 (2603:10b6:104::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20 via Frontend
 Transport; Sun, 6 Jun 2021 05:31:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.35)
 smtp.mailfrom=nvidia.com; lists.linux-foundation.org; dkim=none (message not
 signed) header.d=none;lists.linux-foundation.org; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.35 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.35; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.35) by
 CO1NAM11FT004.mail.protection.outlook.com (10.13.175.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4195.22 via Frontend Transport; Sun, 6 Jun 2021 05:31:34 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 6 Jun
 2021 05:31:33 +0000
Received: from vdi.nvidia.com (172.20.187.6) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 6 Jun 2021 05:31:32 +0000
From:   Eli Cohen <elic@nvidia.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>,
        <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     <elic@nvidia.com>
Subject: [PATCH v2] vdpa/mlx5: Clear vq ready indication upon device reset
Date:   Sun, 6 Jun 2021 08:31:28 +0300
Message-ID: <20210606053128.170399-1-elic@nvidia.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bde78953-d072-4de5-ac21-08d928ac58fb
X-MS-TrafficTypeDiagnostic: CY4PR12MB1445:
X-Microsoft-Antispam-PRVS: <CY4PR12MB1445FC4B360DF6776F597266AB399@CY4PR12MB1445.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5WHalWzU7Tgpth1IsXM3pJOX/lef5E2FWBSU8AiQAOykIzw2fj8rkGBcEDwFD255/D6niNtu9jv8bY0NWqoNLnNy62Gxi3owAgerRlcLVzOB4OLhN+w2PJY3UTFPkaIh8x99MTSjmC9lyyC9smbymScmWNMn2V3vu57TbNhoZ6GlNVK1EN6TFohIg0epaEHTRqKh3VdTcDpME2KCmx//MajK74MCXe0nAbf2oSQ2HICzDdo3F6MH4cPPdMiuSAeU/OX3y2ACoak3Bl5wT277/SgFpPxy4Mdossyyk4TgSoxLGAj22EKS9k1YvcnCaaf77ANSjyG7+okpVCi2+6F0jxTzTUX5wjavnj2+A1vPet4E4EaR9Ri/3rXRxDp+dIVErSjkmDDQ45lziT0U+0srscqsM2S5+7A8AkbHFaWQyoDpa3u4TJS/4gCTAINFrvejJe3+eNbJV+Mo1jKbvEy3daFRDHbhslqTlP4BN4tbM25qr4xLawbHmpRAz/YRrngrGKDcbNF6QkSetlq6DNu0/LoHdvCJCVW9tkoe79AAwmvS7ewBrpiC4vhsj2YWkyBFaMymQZnZorGAtxF3kDhKmoOGdr2v0FO+WcDzcocvr3CIc/maa9kcgWadp+tlDA8IAbQufjy+He7/2Sh1jqgLooPUu81iXUQj0xyndpyyDjs=
X-Forefront-Antispam-Report: CIP:216.228.112.35;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid02.nvidia.com;CAT:NONE;SFS:(4636009)(396003)(39860400002)(346002)(376002)(136003)(46966006)(36840700001)(82310400003)(4326008)(7696005)(426003)(8936002)(5660300002)(6666004)(7636003)(47076005)(86362001)(8676002)(70206006)(82740400003)(26005)(186003)(70586007)(36756003)(83380400001)(316002)(110136005)(478600001)(336012)(107886003)(1076003)(36860700001)(2616005)(36906005)(356005)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2021 05:31:34.0941
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bde78953-d072-4de5-ac21-08d928ac58fb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.35];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1445
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After device reset, the virtqueues are not ready so clear the ready
field.

Failing to do so can result in virtio_vdpa failing to load if the device
was previously used by vhost_vdpa and the old values are ready.
virtio_vdpa expects to find VQs in "not ready" state.

Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")
Signed-off-by: Eli Cohen <elic@nvidia.com>
---
v0 --> v1:
   Make sure clear of ready is done only in reset flow
v1 --> v2:
   use ascending loop iterator to avoid confusion

 drivers/vdpa/mlx5/net/mlx5_vnet.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 02a05492204c..a42db592e7bb 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -1766,6 +1766,14 @@ static void teardown_driver(struct mlx5_vdpa_net *ndev)
 	mutex_unlock(&ndev->reslock);
 }
 
+static void clear_vqs_ready(struct mlx5_vdpa_net *ndev)
+{
+	int i;
+
+	for (i = 0; i < ndev->mvdev.max_vqs; i++)
+		ndev->vqs[i].ready = false;
+}
+
 static void mlx5_vdpa_set_status(struct vdpa_device *vdev, u8 status)
 {
 	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
@@ -1776,6 +1784,7 @@ static void mlx5_vdpa_set_status(struct vdpa_device *vdev, u8 status)
 	if (!status) {
 		mlx5_vdpa_info(mvdev, "performing device reset\n");
 		teardown_driver(ndev);
+		clear_vqs_ready(ndev);
 		mlx5_vdpa_destroy_mr(&ndev->mvdev);
 		ndev->mvdev.status = 0;
 		ndev->mvdev.mlx_features = 0;
-- 
2.31.1

