Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64A9539500A
	for <lists+linux-kernel@lfdr.de>; Sun, 30 May 2021 09:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbhE3H4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 May 2021 03:56:14 -0400
Received: from mail-dm6nam08on2066.outbound.protection.outlook.com ([40.107.102.66]:8065
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229668AbhE3H4G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 May 2021 03:56:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fwwyK7UV1nf4S4BcLBeruqa+HnxWlwyGP63qnpK2Piw6ckAz6NwuJONI7kGHQundHJ4ABC5xeWdesEYjFDf3+aldRrvoBpBdw7ANmVZl8Dx+OUnHzdXHSctTwYQ5jr1sQrx27gu9F+6+cXWjZrhn7IYWJYXOzDY5/Zo3I1KoRn0k9lgwjIX6C/Mz3ncNY/ITqeSLAcHXsCH/C/5jZTNtA27SroI3uku146nCvIcZUsQVW/L3YaFd49jy3w5R++o8EM6gwprnTRQTSjYTad8htvzolcd3rxnUcQEnzlMcyIZWrr0XWPh6lS2tua0m4PxpDmNdyxjg3ZX7SABCy2ulyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gZ3q15l6ylX746SHCfgbDyMGwfcyjJDnJNmXM2tr2Uo=;
 b=T15JUKHcfSr+NWE1mswR2Ts06tUQs/zbnDlmITvs6AtcltCgl74hYvoJMlstl4s3uAxMKmb1hRRjgMLir5R7Xlk1RvIIqtfz72bREMIOdgVRRzxciL2FDqOHZMyuoP+4hcbv81JkXMzCbF6efGC6GgfHDQ3mamaLxC6624eVFPRRH5ATc041zqmVW9OiI1SbK/5v0rC4G0lQjMSCQk13FzzPppYvfKsdZ4iDqx/hFakmYyuuE7Db9RBHem6CxUVACDUhhJeWYql2kRH4Sj4FL2j4LaN6eZ6ViDBMNWGrIrPv4KO2kJEdujK+GGPnAXdh6Vxc2x07zJIOK3F1JIMS8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gZ3q15l6ylX746SHCfgbDyMGwfcyjJDnJNmXM2tr2Uo=;
 b=qaGvkauo9lACnqsP2o6wcXIToJw0A2tBefKikuolLhGfn2zbfOgRPWjFoRx5sEF4EM2hg3b2lcgV/N5G/LAgfdXBki6gHOK/7uICVwkbADsL9UH9EK0tAII18QSc7M9+yqQsL+sI3p/7ixtsYyATzRIxIgH+6xDVglLIMUqMHKVL8niUCJ30+YXSytjBIdFeiH6IEHfdOdvlRwa8+fOVKSOqV1/Ag6GZH9jHjckL3b8uiGTBUDrAG6WnEqApOwGfTMxTeQ/A2Y+0Dm694k5hS6jtzGvYtIM9nsrLXX3IBskvGRGQySMJoE0LEU+U+Op3dbNis2ZjCW/24NksnSpHXA==
Received: from CO1PR15CA0101.namprd15.prod.outlook.com (2603:10b6:101:21::21)
 by PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Sun, 30 May
 2021 07:54:27 +0000
Received: from CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:101:21:cafe::8) by CO1PR15CA0101.outlook.office365.com
 (2603:10b6:101:21::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Sun, 30 May 2021 07:54:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; lists.linux-foundation.org; dkim=none (message not
 signed) header.d=none;lists.linux-foundation.org; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT041.mail.protection.outlook.com (10.13.174.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4150.30 via Frontend Transport; Sun, 30 May 2021 07:54:26 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 30 May
 2021 07:54:25 +0000
Received: from vdi.nvidia.com (172.20.145.6) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 30 May 2021 00:54:24 -0700
From:   Eli Cohen <elic@nvidia.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>,
        <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     <elic@nvidia.com>
Subject: [PATCH 1/2] vdpa/mlx5: Support creating resources with uid == 0
Date:   Sun, 30 May 2021 10:54:14 +0300
Message-ID: <20210530075415.4644-2-elic@nvidia.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210530075415.4644-1-elic@nvidia.com>
References: <20210530075415.4644-1-elic@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d3dd3ed5-172b-4d03-4aff-08d9234025d4
X-MS-TrafficTypeDiagnostic: PH0PR12MB5481:
X-Microsoft-Antispam-PRVS: <PH0PR12MB5481D093A9C73FA34832E8CAAB209@PH0PR12MB5481.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4TG94+BWzJVMph7IOQHYrzq7pdC8mrl+R9r+B4/kzS/SgNxym8OQ1i8gFWPh3u2I2kqb0JwtoRcVsvAisnty17XLNyvKLA0rxdgP8GpGCPJsqpJk8bb6KKhJ5pbyhKeC9L1FLuHXbNt/xxZXumpCn0akiKDIRPUoatVW5V8Luz+CiZP3uc/XFD3BzUy0AAA8N5VJRWVmTOXR9++6E2hf421CFaDrvBUxedd/md5C2NKYFCCeAH5XmVdni3YrFZWLT6LTLXCw23XGDfFwEziNp5aMwW7BiP0PmWDqgGkEYOCX3xGNJ/U+56vVlcJ8N99vaDMYjjYGTZ75OnNRb/nKd3Po5JzoDt8qhJgIuJEdrNQszy/lga9/psv9pzEa+xjONMFuWJhf4HE8klLMjIUiWqDcEibkrnwJ74koIPOb96RMt9o1rubecdR7+/VJwMs2s1zzWFjkOXW9FrRKEiBVC3HLRF8YohSnC/qoPzfYuzYSIZKTXy1G4XF1sFobFaHP+cJ9IzoYyjV37xjYQCnhI0Vk+kKWloA/JLgvJLy2tKvTijXCUyH7SsWZQi9ADg6y943b3tVb09avz4bDTKM+M+QFhiKvj5ltMir3CZ3/9asiHhk1Gszx/yLaGQcnEH/Feb10LO53+lmDW5ruF0MwU44eHwvrtrC7vMaKgC1E4cU=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(376002)(346002)(39860400002)(396003)(136003)(46966006)(36840700001)(7696005)(36860700001)(82310400003)(26005)(110136005)(478600001)(336012)(2616005)(356005)(82740400003)(426003)(8676002)(1076003)(7636003)(36906005)(83380400001)(47076005)(316002)(36756003)(8936002)(5660300002)(107886003)(6666004)(4326008)(70586007)(70206006)(86362001)(186003)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2021 07:54:26.7975
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3dd3ed5-172b-4d03-4aff-08d9234025d4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5481
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently all resources must be created with uid != 0 which is essential
userspace processes allocating virtquueue resources. Since this is a
kernel implementation, it is perfectly legal to open resources with
uid == 0.

In case frimware supports, avoid allocating user context.

Signed-off-by: Eli Cohen <elic@nvidia.com>
---
 drivers/vdpa/mlx5/core/resources.c | 6 ++++++
 include/linux/mlx5/mlx5_ifc.h      | 4 +++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/mlx5/core/resources.c b/drivers/vdpa/mlx5/core/resources.c
index 6521cbd0f5c2..836ab9ef0fa6 100644
--- a/drivers/vdpa/mlx5/core/resources.c
+++ b/drivers/vdpa/mlx5/core/resources.c
@@ -54,6 +54,9 @@ static int create_uctx(struct mlx5_vdpa_dev *mvdev, u16 *uid)
 	void *in;
 	int err;
 
+	if (MLX5_CAP_GEN(mvdev->mdev, umem_uid_0))
+		return 0;
+
 	/* 0 means not supported */
 	if (!MLX5_CAP_GEN(mvdev->mdev, log_max_uctx))
 		return -EOPNOTSUPP;
@@ -79,6 +82,9 @@ static void destroy_uctx(struct mlx5_vdpa_dev *mvdev, u32 uid)
 	u32 out[MLX5_ST_SZ_DW(destroy_uctx_out)] = {};
 	u32 in[MLX5_ST_SZ_DW(destroy_uctx_in)] = {};
 
+	if (!uid)
+		return;
+
 	MLX5_SET(destroy_uctx_in, in, opcode, MLX5_CMD_OP_DESTROY_UCTX);
 	MLX5_SET(destroy_uctx_in, in, uid, uid);
 
diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index 9c68b2da14c6..606d2aeacad4 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -1487,7 +1487,9 @@ struct mlx5_ifc_cmd_hca_cap_bits {
 	u8         uar_4k[0x1];
 	u8         reserved_at_241[0x9];
 	u8         uar_sz[0x6];
-	u8         reserved_at_250[0x8];
+	u8         reserved_at_248[0x2];
+	u8         umem_uid_0[0x1];
+	u8         reserved_at_250[0x5];
 	u8         log_pg_sz[0x8];
 
 	u8         bf[0x1];
-- 
2.31.1

