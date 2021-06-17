Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED1A3ABD6E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 22:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232184AbhFQUc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 16:32:58 -0400
Received: from mail-bn8nam12on2081.outbound.protection.outlook.com ([40.107.237.81]:60225
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231602AbhFQUc6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 16:32:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yk0R7+qrenRefTFuvHjid5aOUKSNOu4jXqxbtRUf42cgNwk9aDTwk+JfLizywCLkdadBsSrHJZLB0PUvVsXknChDb7iWlPKmWJQggqtQI79gwX7xnYFJkwCdJ/Z191GxFIvFrce5ZHJaLPyyF1Yxy3LsKc7zZqFMHYRT/yjCxTJ3Ysv0D41VfmQ2E2LBnlIg4HI+1WOKi6qbWQK+azCiPaI++cAPwHHDEPo1Yip+lGRhwkTBro6HBde6vkRDfwGm5VGW+ukugAYh/gDl5KDdPcAu1RQexHODCY6mD8JyJ302VbKXqI1ljVOWY7xWuz18tVaG+o4d0fEnM2RqOBhqLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rn8CSVHKOlRTt3xBmj3wmLVjOeJZ3/1aue75xqsymdY=;
 b=eG7Fo32iRNMACxEImmbtoGXFs6f1TwGOoLw9GrmtNrHQ7aMyeFq/OlUKdKybd467c+ZGlxOelgvk44BmKin/X1S4AMHxoZS/RStnFy3HQXE+hmQpfI+GxR/qMdlnwALX0Be614xHsviGH5bRhDRxX0RIpaa4nKqQESHOeMUC3YnEYRlW+UsnqHX06OYRJ2kn/e1RQ++ZyBzuhuMLgHE2Mztlg3tvdgk5neyPyvlG60QX1pMF6i0sKko9lAuH2Hzmo+lgVU8MJf7qB/d3sPjIdK8dmpoeNHNVXLCwxpCAkXKbnVcqXocKdIDQJWd7ZUCinYwFJK//3DGqCXmf376srw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.35) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rn8CSVHKOlRTt3xBmj3wmLVjOeJZ3/1aue75xqsymdY=;
 b=TOTdLKW1xJPZ384Uf7Sgf67Nxxkpby2EqQMcAfNXkdxk1kFLgPU6KRzXvJveADny4h3IFAF+FK9EqAYAu/P8DSDy529NZ9sEnULjdlCJdclZSvCFTgWrGStCQrXhzw8Wbto9VQ0M8Q3NP/uI/IIljFiU58URrKmFqrG7P6maBf46AgukirWzKVEC72SwnKm1lQNUDQ4ivfPNUO/Q98cmFjgd575Uxs+vX2mjdBu8g+i5fP2mUUcsyJ0J8ezQ7C/9OTS5LZ6o8K+XBW5DrLb7chKhVKU8In+qrTX2z1q165zh80okfVipAarudV4N2B7yOHazaJicsni0KZr9LCWVng==
Received: from DS7PR03CA0191.namprd03.prod.outlook.com (2603:10b6:5:3b6::16)
 by DM6PR12MB4316.namprd12.prod.outlook.com (2603:10b6:5:21a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18; Thu, 17 Jun
 2021 20:30:48 +0000
Received: from DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b6:cafe::b0) by DS7PR03CA0191.outlook.office365.com
 (2603:10b6:5:3b6::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19 via Frontend
 Transport; Thu, 17 Jun 2021 20:30:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.35)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.35 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.35; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.35) by
 DM6NAM11FT049.mail.protection.outlook.com (10.13.172.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4242.16 via Frontend Transport; Thu, 17 Jun 2021 20:30:47 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 17 Jun
 2021 20:30:47 +0000
Received: from amhetre.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 17 Jun 2021 20:30:45 +0000
From:   Ashish Mhetre <amhetre@nvidia.com>
To:     <amhetre@nvidia.com>, <robin.murphy@arm.com>, <will@kernel.org>,
        <vdumpa@nvidia.com>
CC:     <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [Patch V2 0/2] iommu/arm-smmu: Fix races in iommu domain/group creation
Date:   Fri, 18 Jun 2021 02:00:35 +0530
Message-ID: <1623961837-12540-1-git-send-email-amhetre@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e28b6231-7706-4443-1018-08d931ceca80
X-MS-TrafficTypeDiagnostic: DM6PR12MB4316:
X-Microsoft-Antispam-PRVS: <DM6PR12MB431668792A7BE7B91D6C7890CA0E9@DM6PR12MB4316.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PGfnHwEkRMG+pmiWlixVLbq34nmEFMfHelYL8V0r+NUJEWrTqAIaOry8psB6ZjTjQZoah6O7HalwjqpfW1uwPImBmqONMNQ0sa14FNtDZ1RmbHfjq0WjAKJimLNafQitA/3CyRNVPFHv25d5TiVYhOp8/aPxqlrCNNtqDdu66X62xksV6um7qLtLHhVGiV1uKbTWp74trupSiP9zNt6eQ9tIz11OGFpJEyNbj2cU4+wERZ4it4zeA7r9cnMqRyNczYb5spbHThj9pmG61W8kmumdaLpVAR2q94gvmKR/rPtpniR9QdwX5csKU72txV3172DbgsvQQ+/60Ya+0xiJ+ZJi7nq9JDnScdmoH/QA9OYfUd6ywG3wjphsKhwbTupzNzb/VYhCbD16ggI3Eo94I1/E0jCqiQpBN7CWNN1D+yk0mzI111pzWVBToktHZKGFytkhs9c3wJuxs4u88oz2OHAsGdX33fTsHNu1aegnu31OZ/NBxIJCNFth7TZcRTMLdMxqkv2ovkTkWDPS14sWPD4TXMAQvN3FE/dPPw2WGF6BGUZTsquqY2f9FCxgZiVb4rIlPzEjX2J8dzoT++J8/lmfHrJzH8e5l4XF9gbTD4xPH7m4VlsTBrNeA8iBaBUsb5jygWou1SraWh0XhlU+madDIIj4xAmeksHqZcs2IIQ=
X-Forefront-Antispam-Report: CIP:216.228.112.35;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid02.nvidia.com;CAT:NONE;SFS:(4636009)(396003)(346002)(39860400002)(136003)(376002)(46966006)(36840700001)(2906002)(8676002)(70206006)(70586007)(82310400003)(4744005)(6636002)(356005)(82740400003)(5660300002)(8936002)(83380400001)(7636003)(7696005)(4326008)(36906005)(316002)(36756003)(6666004)(36860700001)(110136005)(86362001)(2616005)(54906003)(336012)(426003)(478600001)(26005)(186003)(47076005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 20:30:47.9010
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e28b6231-7706-4443-1018-08d931ceca80
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.35];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4316
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Multiple iommu domains and iommu groups are getting created for the devices
sharing same SID. It is expected for devices sharing same SID to be in same
iommu group and same iommu domain.
This is leading to context faults when one device is accessing IOVA from
other device which shouldn't be the case for devices sharing same SID.
Fix this by protecting iommu domain and iommu group creation with mutexes.

Ashish Mhetre (1):
  iommu: Fix race condition during default domain allocation

Krishna Reddy (1):
  iommu/arm-smmu: Fix race condition during iommu_group creation

 drivers/iommu/arm/arm-smmu/arm-smmu.c | 6 +++++-
 drivers/iommu/iommu.c                 | 2 ++
 2 files changed, 7 insertions(+), 1 deletion(-)

-- 
2.7.4

