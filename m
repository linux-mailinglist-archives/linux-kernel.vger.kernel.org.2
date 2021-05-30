Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3968395031
	for <lists+linux-kernel@lfdr.de>; Sun, 30 May 2021 11:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbhE3JFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 May 2021 05:05:38 -0400
Received: from mail-dm6nam11on2044.outbound.protection.outlook.com ([40.107.223.44]:56257
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229580AbhE3JFe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 May 2021 05:05:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AaXC9971y143ivby9E1p/HeQGuEyHJ3bDTTdju4E03NBll7bjgCLd1ItSu5wc2qmEf9d2wrofaAt8MFJu7gp5XGgVvSPZoew0v/Sr5aBzPmmTnENlfXGj622t7yJ+B7ru8odJ+nufR94Tm9l1k5Sy4JOb/EJym4JG/LANQjhKkJKnkbrbLJPqFP8uOYF2BXs6Ub+TC77dspyd3r+EYyaTPWYXsMgpNQRzRMoIM58ocGgA9ml3Ni7IhPQPYJ1mLmuXkVqE1PEQSal4Ev+hkjPVA7hJvrn5tVvZcyeWURJ3WMt2W+vi7DfKJLcTSBozqym5i4B7RkZuBP4BfmaAvM2Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0vC2VAj81c/IDKL1MHGSBYLv6oCng+tyfyxBW1EyKrg=;
 b=OahI9hQEZdku6HZlph0jqkqepnPKY8InN4nc6r+A8IuTi3Xm/xmmrTaj03ILyDYvKMH6Cj8B9VnHfUUIb1nnM7+MQ3bEMPoJKcMl3OOteT5SCONW2MLVYudnag13B0IWB3efPc6yV9CEzdA/cE2I13wDaxtyjc2+X6Bbq7xqhqO1xNriKjH5oe7PegDMuW9md+NLZVpDipCzXefM4NtkoOFiQMHAmTFGQjGr+FMTEIM+n81ZuqZK5NSKL2hWcH+bfGDHlu06jWn/SZM1Vz6svxcDbSX+T5WIXiG1IqC8FNWsr+iOeY8mX2LPeiwUlLxC150TDadMDpjGqqgxF2fkzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.35) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0vC2VAj81c/IDKL1MHGSBYLv6oCng+tyfyxBW1EyKrg=;
 b=H9lEBm9DMtbLCy7ClV2nkSsQgfpVmLnzs6Rh4MtNE5Dvyp2pYWJFYS5AMplNCSRVW7uJDTxP9Vq7r4P28LZ+VPbYxGZx4X6lKqIwviphUejJSqfB9UBHRzmI8I3X+AW6wbQvuPd+Q+4dknhae/Aw4LwvpHauvNsi9gUiMTf/jFKtBMZQOW/OEZb8SrEQl0LHa3KRP2jYSCXaN7UJG6k4rwCsfgMeTHZJvreNl33IQcfd85VB6U1SvOv6fLKUHvRptqlxH3IXLz5eZlO0HgLs7BLIZc5oh3b6mPq192FaUsQUpmjZXQ8vcpQQZbN9+SALyu9cSddglugYsK+lMGodRw==
Received: from DM6PR07CA0084.namprd07.prod.outlook.com (2603:10b6:5:337::17)
 by MN2PR12MB4653.namprd12.prod.outlook.com (2603:10b6:208:1b8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.24; Sun, 30 May
 2021 09:03:55 +0000
Received: from DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:337:cafe::8c) by DM6PR07CA0084.outlook.office365.com
 (2603:10b6:5:337::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21 via Frontend
 Transport; Sun, 30 May 2021 09:03:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.35)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.35 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.35; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.35) by
 DM6NAM11FT042.mail.protection.outlook.com (10.13.173.165) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4150.30 via Frontend Transport; Sun, 30 May 2021 09:03:54 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 30 May
 2021 09:03:54 +0000
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 30 May
 2021 09:03:53 +0000
Received: from vdi.nvidia.com (172.20.145.6) by mail.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 30 May 2021 09:03:52 +0000
From:   Eli Cohen <elic@nvidia.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>,
        <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     <elic@nvidia.com>
Subject: [PATCH v1] vdpa/mlx5: Fix possible failure in umem size calculation
Date:   Sun, 30 May 2021 12:03:49 +0300
Message-ID: <20210530090349.8360-1-elic@nvidia.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 20cc30d7-373a-4c56-c299-08d92349da12
X-MS-TrafficTypeDiagnostic: MN2PR12MB4653:
X-Microsoft-Antispam-PRVS: <MN2PR12MB46539C2557AE580EE41D6721AB209@MN2PR12MB4653.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w6S1TNXlsVAAriZQA6dlQ0PDmundtYQ+Vf/QwJ/1FTXbQBXZ6XN4XsrQVZsI5LBtg1cLDkmwHHMS06HoFvx9uhPQwWOp19pmQ8GL05jR0pJFh2H6+XxNV0EnOWOInlO8v/2eCrDKZRGJ2WQtTI6K5Uo1s+3Vo56CU8q5DimM49fDlJ8VSQABlaVhMJK5oPn3N2Z0nd/ef8CKFtXP/BtFABBXurq25K6E3htBoJxSogRQFK7sfkIn3AtJLBPJ/lK1veXGFdRl/dU8+coPaMiVbbYORwYjUTcRon6WK0cab0KX0rQi5jO/3akU2EtYsU36RSWkKzAkxhR82zRX+3Kt7dup1MZvFX4VCDku7pkziykgYQbavSKb/JqPiOJdavt6MvCAk/GLH2elEJ9501MYyaqgKHFe97E2+pPbmAZ+0C2ZLVoFbvH7f65VtjcnuMTgM0r188HDHEfq3DZpoWlHVTEYBH8qNN5gJF9IaT+tEM1DRwO5pCIWxa5gHIQ5d/iwUAIP7lUfdQay9CbSEm04bMOi+y/Io4p70TgbzuqWBjwEdIa8In5l8Au4sCz4Cg+P1u5H2CYHG2KuMmf2imOf/IVI+6e/yuhzq6hz8GStUi4CqWRT2CTzFo9rcApXQDishsDzW21RuN4BcPESRbBvdA==
X-Forefront-Antispam-Report: CIP:216.228.112.35;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid04.nvidia.com;CAT:NONE;SFS:(4636009)(396003)(39860400002)(346002)(376002)(136003)(36840700001)(46966006)(5660300002)(7636003)(356005)(4326008)(83380400001)(70586007)(6666004)(36756003)(70206006)(36860700001)(8936002)(336012)(426003)(186003)(86362001)(7696005)(478600001)(8676002)(82310400003)(110136005)(316002)(82740400003)(36906005)(2906002)(107886003)(26005)(2616005)(1076003)(47076005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2021 09:03:54.6753
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20cc30d7-373a-4c56-c299-08d92349da12
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.35];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4653
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

umem size is a 32 bit unsigned value so assigning it to an int could
cause false failures. Set the calculated value inside the function and
modify function name to reflect the fact it updates the size.

This bug was found during code review but never had real impact to this
date.

Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")
Signed-off-by: Eli Cohen <elic@nvidia.com>
---
V0 --> V1:
  Add more info in changelog

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

