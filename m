Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33BF6399C44
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 10:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbhFCING (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 04:13:06 -0400
Received: from mail-dm6nam11on2077.outbound.protection.outlook.com ([40.107.223.77]:50496
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229479AbhFCINF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 04:13:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jeorWffFRsvULQDhFdyRXqX1ycgNO6/NwN59dwYTnGYq0+7UJvuu2zSem2NWzzCyUURcwLMcPYDhC9jjhZ70uXr6e3PJk7NmgoPSt65SOnLKXHT4NCdc3zgJx42GoFvnBa1tPkjnr/lGwyVMkFRgEplMHWNTyY/YGCvy5lLw4sGubMcqNlCni+9RSFRS/+etZpWaxDeIg9SpXXHMA56CP26Bu4EMgH4YINUBSzcN3cUJDbtehgfAHj8cBYyREWpR1zlyJYG1Ns420RLukRr3m0sTaf6nPL1rVNamF0ZDnshTGv+tcxJEYaDX3Wke8nw0ZjiO2QzqfUHH87Audb22hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GMgDGv8iAzg1ayPwcwScPgFLZubGdGNsDC1F0UGpssc=;
 b=cbGntgiTFw6/VVhEY9iJA9gcXeoyYEgod5wkuXL1u3Az08ZUSIW8V8xNhvJDv3QQsnPqDe3A3mcuNbycy2uUTdJ+35qWkXAUEhg47wa/kAIHY7/Jz/GYE4hPM0w0d5dH8domNOkXy0aizvawBdBZTbVSzNlNJVUS5FGftc/MfN9utFRho+OUEPAInuvJ9gK+GO5jYHauKwI/WCEggkWVOX262dWHWNviQK5DbbLjq4Dgh8G0GSo88G+8uFReEcqd04cS1VS2IjU1+CM9zRfhuTBsER/CPoJ0gbfNbrLBr1QWrfWst22U2uG0y20wo3XbmY74q27L2koGyALTnkCOeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GMgDGv8iAzg1ayPwcwScPgFLZubGdGNsDC1F0UGpssc=;
 b=WA8l0BKdN3d64Giat+rkM86/uGugYlo8lpCK37MewyQwSHZd6cDH6YQQW7feDjdQmdhEjcNrOMAq5BcfEFUFDlUM3jtWWjPy6wP4o2trxqn6p2cJgufRpHoWlxbpdn+ugJQzpJyEVQeQVtn9valfsvWPFWc5FfhVUP1Dj3KDXZ55WKQaf3kO3jg+WIDu0wH/e2NREZYFuz5Iz7u1QeViQVOew8fWQK+fHZSTUiYMxJwflKizFSOMjPTbtMppv24MiVc+v2OCZf0EZin0Vk76cethpyk0qsMuT3j0b9nkcfdKo95q8noBIBPCHH4P6DL/VvyWAkqvTxNye9AdcOMr8w==
Received: from BN9PR03CA0358.namprd03.prod.outlook.com (2603:10b6:408:f6::33)
 by BN6PR12MB1858.namprd12.prod.outlook.com (2603:10b6:404:fe::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Thu, 3 Jun
 2021 08:11:17 +0000
Received: from BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f6:cafe::ad) by BN9PR03CA0358.outlook.office365.com
 (2603:10b6:408:f6::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.21 via Frontend
 Transport; Thu, 3 Jun 2021 08:11:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; lists.linux-foundation.org; dkim=none (message not
 signed) header.d=none;lists.linux-foundation.org; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT024.mail.protection.outlook.com (10.13.177.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4195.22 via Frontend Transport; Thu, 3 Jun 2021 08:11:17 +0000
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 3 Jun
 2021 08:10:32 +0000
Received: from vdi.nvidia.com (172.20.187.6) by mail.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 3 Jun 2021 08:10:29 +0000
From:   Eli Cohen <elic@nvidia.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>,
        <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     <elic@nvidia.com>
Subject: [PATCH v1] vdpa/mlx5: Clear vq ready indication upon device reset
Date:   Thu, 3 Jun 2021 11:10:26 +0300
Message-ID: <20210603081026.5640-1-elic@nvidia.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c7e3da92-11d6-4804-ad66-08d926672a02
X-MS-TrafficTypeDiagnostic: BN6PR12MB1858:
X-Microsoft-Antispam-PRVS: <BN6PR12MB1858B9C163B4F3E8654A1864AB3C9@BN6PR12MB1858.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sodAOInBbc4LKrTx7p9+CiwfSiS0QQGMARqE9eArVsRpgQIGsuHh20wPzJMpspVj3qoZm5fQ2iOII8FoxD/IdesNAtFM/OYBWlxqHTn3UmHYAJws+QUwZ/rpc1XkE0/J8C6bvB6+AcVFK/BL7l2G+u/toWLqBN+/9wb1LHfB5fup0VzvYc4fGj/oXiH/YLYPpVo+uaEgPhoEVAeUER4MiibCkxvUTLjOsipS4urheTRm7QWe03fK0Y2kbAUF7x3tiW+NL1c3ivoObCzswu0ODVUcV3oMwFJNuns+grOZGErn3ySuX0WrTQ8v/ZJlw8fBE2Wqgg2ZdZ/1c048CoLuCnNJZwz59MNzaI7HYkSY0t9kmuCyDuW/m3Uk5oeVI/8d6F3r/B+gZqq9h0PTEl3pf6OYxTiwKZqWmlLjNmyd7t8/vboufnrq7B4kSreihDbkdFfyizH9dj8kH7NjG24oWrbIz+mD7V/i510OvWPQs6WN3WfFcPn2dv0UeCOZCTqHAyV4uHYp3YRu/VIi+O1c/Uc/RPtjAa9OJhIT3EiMQUs0tV7gGx7niTIOGSu4d5tmJk+w+dvtf1IDmSoKZ/7lVVpSFIC/cn7Z4XhUx7HmzAHHMmaBHeighQOMmmMH3S9vrpbnPhtbc1ZUtQwXgb8VSPI+kXvRRHRNAy0Zf5BUhWs=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(39860400002)(376002)(346002)(136003)(396003)(36840700001)(46966006)(26005)(1076003)(7696005)(186003)(70586007)(70206006)(83380400001)(110136005)(36906005)(426003)(6666004)(36860700001)(8936002)(82740400003)(47076005)(107886003)(478600001)(336012)(5660300002)(4326008)(36756003)(2616005)(7636003)(82310400003)(86362001)(8676002)(2906002)(316002)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2021 08:11:17.6182
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7e3da92-11d6-4804-ad66-08d926672a02
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1858
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

 drivers/vdpa/mlx5/net/mlx5_vnet.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 02a05492204c..eaeae67e0ff0 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -1766,6 +1766,14 @@ static void teardown_driver(struct mlx5_vdpa_net *ndev)
 	mutex_unlock(&ndev->reslock);
 }
 
+static void clear_vqs_ready(struct mlx5_vdpa_net *ndev)
+{
+	int i;
+
+	for (i = ndev->mvdev.max_vqs - 1; i >= 0; i--)
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

