Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B777B3A9123
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 07:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbhFPF11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 01:27:27 -0400
Received: from mail-dm6nam10on2063.outbound.protection.outlook.com ([40.107.93.63]:3904
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229476AbhFPF1X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 01:27:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BW5gWDfF1XVJcanAxLjF2fuIhmE3JajVHtTUdSQHNryBqmeC4XOiu/HTVkvtgHw8KMzerxp0lC0Cx21OGGYxVrwNg0PINWvLlQ0DZRenEIFiQPO4kgMz3cd5uAXx/+ZA3uv9fIjFsKWp7n+gfeNeGXAdrRfs1dfcvrg4FqAJbKDYYcM27Zl5qDpU1Yvvx7xMoKUTxKKy4jQuP0ryaa5W/oBtsfTjza5DI8yLeb1Zg1ELtTfVu7034ySTB2apDVKoc67JQpA34Q5D0i6fr58pp/+mjsMydZpavDlcN55rCQQ8GF2Ls089oDKfD/uFgMBATslnzhBsFr7TEUFzoTv8rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8HgBnigdiSbZWti1wm1iwwPXC6H7edtJGeTaI2ddXBk=;
 b=hfM5Y+xJzj3F6j2ObBd2zsXwPcDu8rh32XQcVrXx6KTe4VFIFsKDoflmdURPYqdRQa0oAMZE7KEDayKssI5JPoxJiGyVyalQ+k7dvHpw1FDgO6yRRHSglgtYibBrOKP6XRWJDAOwl1cdvCqFS+bORMTrguvHmSDaadIN3EXgGvbogv6paloUBsVUOUgUD0rdqlptNd1wS/U/mw/3BKcO6KaFP9AJAqU80Zueqp2QtDV0t/q7fUnDKFGCQ/XV/upazse9GSDGGiLSjWChShzRLM6dnwMuO+3teOmM2Kqx1PsP2WPxTc+owVOqtPQ32/r2KM1MKP3IbsIoVYXMtfP9Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8HgBnigdiSbZWti1wm1iwwPXC6H7edtJGeTaI2ddXBk=;
 b=BEXuG2LtAqAshX3twGno2xCfIbebLEpOoHyh9hZ2ehA2It7XAlbHMIVCbI1JY6KjtLFK48GKKrqgimrH+ZrWuXgs7tq3giRBiJ4HF1w/HbuY0WNDZRzKNitP4ZNAzhS9JxuGdIrcU2YSImdoNbBmY7wJCpO40pVK+z0QK2zkW+0=
Received: from DM6PR06CA0015.namprd06.prod.outlook.com (2603:10b6:5:120::28)
 by DM6PR12MB4545.namprd12.prod.outlook.com (2603:10b6:5:2a3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.24; Wed, 16 Jun
 2021 05:25:14 +0000
Received: from DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:120:cafe::24) by DM6PR06CA0015.outlook.office365.com
 (2603:10b6:5:120::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend
 Transport; Wed, 16 Jun 2021 05:25:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT028.mail.protection.outlook.com (10.13.173.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4242.16 via Frontend Transport; Wed, 16 Jun 2021 05:25:14 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 16 Jun
 2021 00:25:13 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 16 Jun
 2021 00:25:13 -0500
Received: from weisheng-Pro-E800-G4-WS950T.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4
 via Frontend Transport; Wed, 16 Jun 2021 00:25:11 -0500
From:   Wesley Sheng <wesley.sheng@amd.com>
To:     <kbusch@kernel.org>, <axboe@fb.com>, <hch@lst.de>,
        <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <logang@deltatee.com>, <wesleyshenggit@sina.com>,
        <wesley.sheng@amd.com>
Subject: [PATCH] nvme.h: add missing nvme_lba_range_type endianness annotations
Date:   Wed, 16 Jun 2021 13:25:08 +0800
Message-ID: <20210616052508.78970-1-wesley.sheng@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8b5eda6f-4a47-4998-192f-08d930871ec9
X-MS-TrafficTypeDiagnostic: DM6PR12MB4545:
X-Microsoft-Antispam-PRVS: <DM6PR12MB45450B544097CCC5664711CD950F9@DM6PR12MB4545.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: irDcOAb3hdju8Z+ikIb/xpy9xgAwA5Z7J3cMYysbqG2nvmjvt3s7YDi07JWdksZqZ87Lnxs3vLi+P9Ul3HOThInfoTrNG6VPIKGg1XQcz8McXSmtB4lfcM99iMD15WP/IIncAVUrkD43e3HgwXs2Zsgrx6X+Lfs3cN85KMrGxBlcuWyx92wJyhmPZmPi1ZSpuVYvdama4hIfUDfZU8cfzx7nqER9GLCQFJyZmYgQB7bhB/z3mx94xEyrkhKprDuqXI48lFwBAvbc4sYbRz7TNBZ3ZmfRPgokkFuF1fDPxWI2zBexS+1sCYD+SDfecGpU4vcLrhXwMDgA1evTx3fz8JMjRTMJkmLBy1vIUZm/y+ieCqMQGjP93Xhg3NpN4FONRXuIxiR4mKTSCh1hrI2j/xd+ensERKs7a//XC7riP5NpBK6xoJwGpod0JboU0cZO0ZqmJWMIhzO0SUQxMdFRVXSByWhINWc824TBptUNcncpEQ9ilaJpQZ2m6y8urCXTlBQ5TMD2QFfopcIXvE6Vwl7QCPUWkMGBtMwc2QhmpUkTULrLSitlbeEMmiKj9kyfJiy9tEeQj6UXG/uxVttxO46QH4R4xTzjQ07q5WFZhI4ZgFFzxySpW+KVxBiwUkXFu/yLhYldld4gh/rQ8nxKWNK5MV4Br5CLg5L8cH7bSwlvoxpXfNo38+gZBcc63L5DkKZTkpv95+HuT5zlDCKI8A==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(396003)(39860400002)(36840700001)(46966006)(54906003)(110136005)(4744005)(186003)(36756003)(478600001)(2616005)(7696005)(5660300002)(81166007)(356005)(83380400001)(86362001)(44832011)(336012)(8676002)(316002)(426003)(8936002)(1076003)(47076005)(36860700001)(2906002)(82740400003)(4326008)(26005)(70586007)(6666004)(82310400003)(70206006)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2021 05:25:14.3860
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b5eda6f-4a47-4998-192f-08d930871ec9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4545
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Wesley Sheng <wesley.sheng@amd.com>
---
 include/linux/nvme.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index edcbd60b88b9..378140e16225 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -636,8 +636,8 @@ struct nvme_lba_range_type {
 	__u8			type;
 	__u8			attributes;
 	__u8			rsvd2[14];
-	__u64			slba;
-	__u64			nlb;
+	__le64			slba;
+	__le64			nlb;
 	__u8			guid[16];
 	__u8			rsvd48[16];
 };
-- 
2.25.1

