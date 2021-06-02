Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6CD3984CD
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 10:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbhFBJBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 05:01:19 -0400
Received: from mail-bn8nam11on2057.outbound.protection.outlook.com ([40.107.236.57]:6016
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233002AbhFBJBP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 05:01:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ojs0yURDAvKZt+o4u1eL3/ucVWYA2AHn7vhEcB81t3+eGN5RWclAYWIbbGUlOMhTZ83QuTy+GFlF+0KoD2Q3vif2g6yJ547rrspPAHIJAdDgmc6no6lkgmshiwZdA+8JIGNkOpJTqACGPIrRNQf6jUOurJyOOAHRA7nlZpqCp3EgRmenG7pZZ/9bvZq4ebV9YB1nKkV240LDrus7RP9izNl1AZAKbyK//2inHypbwSLEOP7ffxdWtWBmzTlMTCJVaWxhrxNrAwbZ3ywlgrV6ABN1uMfwdQ3n9ceWHSOCx9reXrs1U1IFs5aCLXiTLXXiDJDbxlvMML1jmEZwvJ9aDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4gdjz3Jyl9de9nMt+3kn3lxOXcNuMjoQ451MIf87lMg=;
 b=mUAYKlI2VsZkdxD//oLhDhTtmXo+6w8JA4pH1rM5nUTQi3waoSeg4zbkdAJt7q7qrQXhLzu6ckaipIZJwsPqS/3gxPApvMMQ10o9u77gQ0MVIi4y1e4ITSuDdM5RWPRGX0k1xj+Q8gyInqjkjN9sZ+4L2J6Fl8IvA1/JZpClAE+uNEVtZ2Bd6WNKgFM3a254Z8fUJnvUdMjCN/mHRTQtEuyrKWEUAm92yMZe1i8xS33MYk0BZ48lX7Zf8Y03ed0ZCgnVYYYtTsstRkiZghVdg4CzkhMDYlaR/IqtDmqvG9VOsn2/sdfRhNkUhenSGt7foyKC1rOLPiWdfNy56qwUOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.36) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4gdjz3Jyl9de9nMt+3kn3lxOXcNuMjoQ451MIf87lMg=;
 b=Mtr6AYpKI4k6uzBKhMuOmRW5BJ88R4AFMjLE+FxfCfWWlKp42FqhUoEz2UlWgm/KC7zNPuIjemgAVWOLFrX0Z8C06jXOrI1f3t2yulHORgXDYT1oX4VQjrRr01k8QMkvf8zaqAu4czSpRDe+Nzh+hAJLcgAd+XiePJ0DyXyMUvydatzjjJmfEvO6sAAepsYSo+VewAuTP302yDTmJ5ectrnRSt+NuvXfpWyAziXXWuf5cuQkV8MzM0SFV62R2ZO8XqSlUW3ytdsmQHHUAXHq3QwnImRqXOco8e/FkayvC2jt22YplBvWSr1xizNO6X+XIhb3MQ6UOiIgbe0sERrU0Q==
Received: from MW4PR03CA0262.namprd03.prod.outlook.com (2603:10b6:303:b4::27)
 by MN2PR12MB2989.namprd12.prod.outlook.com (2603:10b6:208:c4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Wed, 2 Jun
 2021 08:59:30 +0000
Received: from CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b4:cafe::74) by MW4PR03CA0262.outlook.office365.com
 (2603:10b6:303:b4::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22 via Frontend
 Transport; Wed, 2 Jun 2021 08:59:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.36)
 smtp.mailfrom=nvidia.com; lists.linux-foundation.org; dkim=none (message not
 signed) header.d=none;lists.linux-foundation.org; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.36; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.36) by
 CO1NAM11FT048.mail.protection.outlook.com (10.13.175.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4150.30 via Frontend Transport; Wed, 2 Jun 2021 08:59:30 +0000
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 2 Jun
 2021 08:59:29 +0000
Received: from vdi.nvidia.com (172.20.187.6) by mail.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 2 Jun 2021 08:59:27 +0000
From:   Eli Cohen <elic@nvidia.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>,
        <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     <elic@nvidia.com>
Subject: [PATCH] vdpa/mlx5: Clear vq ready indication upon device reset
Date:   Wed, 2 Jun 2021 11:59:24 +0300
Message-ID: <20210602085924.62777-1-elic@nvidia.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cd890afc-20e3-427f-4bd8-08d925a4bba7
X-MS-TrafficTypeDiagnostic: MN2PR12MB2989:
X-Microsoft-Antispam-PRVS: <MN2PR12MB2989F507588B0F9289B6889CAB3D9@MN2PR12MB2989.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iUKHwQppHXZs3RjO/v/VLi4Zkr0rIQPcYVF8bq621elKM7yiRjZu9sdVWdssma7A9zPkrp/gJ0ErTXA2EuaAUZNaObx4GWBdnZU0lKEk80PHYICoAewZXPa959Q8khOMSHIa1SiaoDztNKqanfe7kXMMvHiGm0eh2VWDZ9pt5waTZ18jn+EfcaaK/d1of8fK6xYqL3tb75+lx9PnNdk6/F6Qawp3D/IOSXk9krJz5YMpcoUyoYHO3zRD12CZ6a/Oz0Ok3r1OW/KAtx+taguz/Fd7tpi1wr0bXpj1arPlFFamRJuS5nfulXcQSMwlixGzu8c4uojcnCW4ZZTGw1dpEW47WY/wQJza0U5gJxWUONheobnPwdWoHeWfmprJHVEduzvCOjyhC268UTzASea2gOsk8ksi19boRAz9yyM7/k4hEWrFNgjxdXc9wzOJ11B03+B1ZkZGW7ANVbglnse8FrSz+e6Bikq/DgaouHJr8rU0GJJTk5K6YGxlSoEoxKAK5ac8t/CP3N2ccBAgYliH6WQQyZBWVI5Qrv+dBdrd8CThO+FZD2/En2ueRs5JJYg38nR0tLVjKmIcDKZUnVNiu/WHmtCgFDMg69sRjCq2FvK0FjJu/Z6vTGotP725dr9uX30+c62gcmAdHr4v4Epl2QjIxilvXCKITlYGfCNMFP0=
X-Forefront-Antispam-Report: CIP:216.228.112.36;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid05.nvidia.com;CAT:NONE;SFS:(4636009)(39860400002)(396003)(346002)(376002)(136003)(46966006)(36840700001)(82740400003)(86362001)(1076003)(2906002)(82310400003)(8676002)(4326008)(6666004)(36860700001)(70586007)(7636003)(356005)(36906005)(186003)(316002)(5660300002)(336012)(36756003)(4744005)(26005)(7696005)(2616005)(70206006)(110136005)(8936002)(47076005)(107886003)(426003)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 08:59:30.1843
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd890afc-20e3-427f-4bd8-08d925a4bba7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.36];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2989
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
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 02a05492204c..e8bc0842b44c 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -862,6 +862,7 @@ static void destroy_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtq
 		return;
 	}
 	umems_destroy(ndev, mvq);
+	mvq->ready = false;
 }
 
 static u32 get_rqpn(struct mlx5_vdpa_virtqueue *mvq, bool fw)
-- 
2.31.1

