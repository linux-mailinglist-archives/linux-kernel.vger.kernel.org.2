Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75AAE3985BD
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 11:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbhFBJzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 05:55:49 -0400
Received: from mail-dm6nam10on2060.outbound.protection.outlook.com ([40.107.93.60]:53601
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229571AbhFBJzr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 05:55:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kG36X8EcBTZpARO1+HtkZKOJ9iP0AEb5+aZR9fnMx6I0mluQ744kPN8tbt8fLTs+SbTQ20/11vmWIrwGALksf7gWhO6WASXh+lIe/X9MP+uIuhtT5Hwpyu3th25DsbtxWMQaVNqxZ972snA9tTg8+Fm3YABLuMe5AzG26ixnff7Z3oqTC8LSXWHM+q1wDJCNVZLDrvJHnQRE7QsChbNHEwQBMek+r29JxWJwS1Z90P0cdez1BeRF9ZcyFecu0OoUWf7rHuEE7ltlQY1UXeSpu6KG+whXGDM+O8RN2yVwJjYeT6BliHowcBq63aVscqhUPWhrYw9ewj6g3anmbY1KxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b8FH5KqKqfwgexw/4fD5kGUMreG5v0iDnRHsLM9XkaI=;
 b=VUEHwdx066SeAY1lt27Ia9Is7oH6UkgCB5/jb3n9RO3KB53wNNYb18IHglKW/fHct0QPrgIFk8SwXqmwf6+MuT5zxFn2pmwmA/Ky05eAxvK0JuQT08/TKhrk0GQCw/qQfYIiT0Ldh8Einih3X+Sbm20sKMQSos7WxeUp3noJKK+Nwj7eGVsYiwubASR1IgjzEfhSbxOn2Br9DpmTbsZ4Vq357zbrR6OoPnz+/x+TjgFsOXfH2f1nj0hwZu8fD10g4jA6NtHi/S1B0WNpd2DkmoDOyajmIzTcfSRYW3N/k/FHKYS2WoBSJXObozWJy3HQT+Uz020sjwWihOL3YZh+vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.35) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b8FH5KqKqfwgexw/4fD5kGUMreG5v0iDnRHsLM9XkaI=;
 b=ll3tiUJ6glyVZX8CZ6seGUelDC8uc+bg7pnymb/dSYuuFCh98Ji69pBKSxauTnu3YrAwGODfSx196Hq/TFSDoqi0lwdGAqpsBb3KSbIgnh+iweCbU8/1JQKTSqkvKjTM4UqNQCH3xyBnfiOIyYxfYIgKUArOZX3lL9o/MIb7MNxKl+PTXZ8mY2gqc2qCKaeNWPJMm40lJFOKsYqmE/ngRSQvdIZMe+DCn1O2YlZ9NmgEzrtHnEjK0dFqYLtmcRqrsWseNycwv3v1gr8ma0Nn3TnMUAoTWeAr4TWW6Ha2s98O4ZG0sxz1nq43oVZnm2dE8QM5k2cSVOY70AQDA+dk7Q==
Received: from MW4PR04CA0063.namprd04.prod.outlook.com (2603:10b6:303:6b::8)
 by CH2PR12MB4972.namprd12.prod.outlook.com (2603:10b6:610:69::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Wed, 2 Jun
 2021 09:54:03 +0000
Received: from CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6b:cafe::97) by MW4PR04CA0063.outlook.office365.com
 (2603:10b6:303:6b::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.15 via Frontend
 Transport; Wed, 2 Jun 2021 09:54:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.35)
 smtp.mailfrom=nvidia.com; lists.linux-foundation.org; dkim=none (message not
 signed) header.d=none;lists.linux-foundation.org; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.35 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.35; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.35) by
 CO1NAM11FT033.mail.protection.outlook.com (10.13.174.247) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4150.30 via Frontend Transport; Wed, 2 Jun 2021 09:54:02 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 2 Jun
 2021 09:54:02 +0000
Received: from vdi.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 2 Jun 2021 09:54:00 +0000
From:   Eli Cohen <elic@nvidia.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>,
        <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     <elic@nvidia.com>
Subject: [PATCH v1] vdpa/mlx5: Add support for doorbell bypassing
Date:   Wed, 2 Jun 2021 12:53:58 +0300
Message-ID: <20210602095358.83318-1-elic@nvidia.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 825d1298-e190-438b-b96d-08d925ac5a15
X-MS-TrafficTypeDiagnostic: CH2PR12MB4972:
X-Microsoft-Antispam-PRVS: <CH2PR12MB4972D1CECB51A4CC1653F116AB3D9@CH2PR12MB4972.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rZzNl/DdEBmE/+j9pKtSBmfYQ5+YXL6rNkK8ANc66pRqNKZAfqI+Hh95XewDbZ+HwkraLiBSO+fO5NZEojar+JRCXf3wZ7L7SfWXdUXEUmvv2cPGenlyNeqy65HHCf0b58TGHxOu2FSLMkLczYExtKdssLBeYSIxneTBgC1XHPysV/KmBPERN31OARB7VhWLpAo+CHVGHmdi6reiLnkkqvnUhCJn7hBwThXEPwZXgACAhyvDURe0SnkYYtrgt4e4/qKbaR06xOMCaA9b6rtrZMsYshZMbFk3SPpMM/qy+gilBdEfDhDRYiVTTApoT+r8I+qT1L7g88Yyu1gSs8g+zoyVx8zdpAunC4aZcoS5d5uWZxHlraNyBaMeungV7goqcNb7IhUfASFTdxlA+vrvqZQdorVa7AhdkQPewa5F8QhMidrktMvPyfz0nF/Gd3hTJOiphDpLfxuvyj2VZUgV/MMS1ucnCd0Vpjp6LPyU4GxGKEVaDgcafwQC0F0kyrQUfnq3SgIpwPUo2f5t3b6PhGuSTMBkS+YCcaTyM0W64SYA/Hic1PFOJV+AGU06Yi8k8LUNfMw8lzcegsz1bU+monkp80ys9AWn8wL2oOQu2inInFyOGhyVuQGUnACnVVD5r6l0xXN7amfNynNxhlM+C25jzIlVmepeLOabBj8lyoM=
X-Forefront-Antispam-Report: CIP:216.228.112.35;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid04.nvidia.com;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(39860400002)(136003)(46966006)(36840700001)(86362001)(356005)(107886003)(5660300002)(83380400001)(110136005)(36756003)(70586007)(2906002)(4326008)(70206006)(82740400003)(316002)(2616005)(1076003)(7636003)(426003)(8676002)(478600001)(186003)(336012)(47076005)(36906005)(82310400003)(7696005)(26005)(36860700001)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 09:54:02.4432
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 825d1298-e190-438b-b96d-08d925ac5a15
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.35];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4972
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

 drivers/vdpa/mlx5/core/mlx5_vdpa.h |  1 +
 drivers/vdpa/mlx5/core/resources.c |  1 +
 drivers/vdpa/mlx5/net/mlx5_vnet.c  | 17 +++++++++++++++++
 3 files changed, 19 insertions(+)

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
index 5500bcfe84b4..1936039e05bd 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -1871,8 +1871,25 @@ static void mlx5_vdpa_free(struct vdpa_device *vdev)
 
 static struct vdpa_notification_area mlx5_get_vq_notification(struct vdpa_device *vdev, u16 idx)
 {
+	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
 	struct vdpa_notification_area ret = {};
+	struct mlx5_vdpa_net *ndev;
+	phys_addr_t addr;
+
+	/* If SF BAR size is smaller than PAGE_SIZE, do not use direct
+	 * notification to avoid the risk of mapping pages that contain BAR of more
+	 * than one SF
+	 */
+	if (MLX5_CAP_GEN(mvdev->mdev, log_min_sf_size) + 12 < PAGE_SHIFT)
+		return ret;
+
+	ndev = to_mlx5_vdpa_ndev(mvdev);
+	addr = (phys_addr_t)ndev->mvdev.res.phys_kick_addr;
+	if (addr & ~PAGE_MASK)
+		return ret;
 
+	ret.addr = (phys_addr_t)ndev->mvdev.res.phys_kick_addr;
+	ret.size = PAGE_SIZE;
 	return ret;
 }
 
-- 
2.31.1

