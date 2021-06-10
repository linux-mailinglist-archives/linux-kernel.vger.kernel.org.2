Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD2093A2329
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 06:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbhFJETY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 00:19:24 -0400
Received: from mail-co1nam11on2045.outbound.protection.outlook.com ([40.107.220.45]:25376
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229529AbhFJETV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 00:19:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EcZOO6GuiphTrhWYOTv9r7IkEX37dhikqoXvKvMoeBYtZXcOh3tudTKSXPT3ghHzEKDMFXAteVStBpFiA7m4GKpWPKZ7yTELrZelWYopwgXG/E7yklsJrys6rfPf36zkOGZFsv9U8vBBJCpB+cJ0hcPItdzXd/6wTkpqwDGWQbAN6lT5OxGLYtzvD201BQsmSOsV0/Z7DXn4ouKAAUPT5b1tPbM8kPp/08GIsQC6qMPnehh/8hp6XDPVc1UiSe85uqgfvprD/l+Yp3vR1lU9CcX9evGef5n2XKcaZdG2R+CxVq+QVCGe4mIFCgFoN8oGGYuA1JpQ2IOgkHohNVVWTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AAJyeRVqgL7ONMDAasXb4kStbGZl9qNmY9+wgLZLA3E=;
 b=QzGMDE7Pylsnl+m6ftvBAq6b2DDR7UxW1zTUTcVY6i6zVxfie+3UWvTzG8JHgp/3+Dn8ZodZbW8PdQSLwwoO5HQ+mHOECt8qPhPoVddW3ZuMytC0C0C0MWrxh0sk36GkBIk+4wi7yBWZMvZuUvFIOuwXk7cT1qEalxevAiY2Uw+5gCbnM6d0F9tucB6cKEmrGz0Ms/ntdHK+1r3pntfAOhUQV4GszvaSp10+DFaWUeK82yKECTtBTrX5AVWCFfPy/cV5kTm3nEV+mA2inWzePHOvXGvpjWxo6PQr2rtqicc/xq7m1aZb84HOPzz45yeTUtsUjqR11MLoQ3adIXhdnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.35) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AAJyeRVqgL7ONMDAasXb4kStbGZl9qNmY9+wgLZLA3E=;
 b=iAzxqzwtsX/WcH4/OgGvbPgbQNZlcR0h5gjBU27sL+Dtc/Y28AvZgindonnyplEs0p/S+oehZqvNsazVZrttJ18tkBgKrfQQ6HSoZLJpzDIj2hZlzdTiehUAp1lApANscIc4kpfVkuCZY7W6dKQEdLNjFNC1hadm5EpR+pfVaMwzEDb4UhuxH2xzsYyIPuFYj8M8HazyqrHkypBzmXz6IgnXgyIa2XaukX+zg3Cu1UzK5gpKRC59tXsbX30xoIj4YQsF6CMdaJ/7EnAUT6hYCv+wfgFgFVQ/oUgTD92SzfUJVbB3IoiO0MveAi4chiQCnCUqzhuY7a/4+RfYfyW/9g==
Received: from BN8PR04CA0048.namprd04.prod.outlook.com (2603:10b6:408:d4::22)
 by BN9PR12MB5116.namprd12.prod.outlook.com (2603:10b6:408:119::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20; Thu, 10 Jun
 2021 04:17:23 +0000
Received: from BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:d4:cafe::b8) by BN8PR04CA0048.outlook.office365.com
 (2603:10b6:408:d4::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20 via Frontend
 Transport; Thu, 10 Jun 2021 04:17:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.35)
 smtp.mailfrom=nvidia.com; 8bytes.org; dkim=none (message not signed)
 header.d=none;8bytes.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.35 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.35; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.35) by
 BN8NAM11FT011.mail.protection.outlook.com (10.13.176.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4219.21 via Frontend Transport; Thu, 10 Jun 2021 04:17:23 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 10 Jun
 2021 04:17:22 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 10 Jun
 2021 04:17:22 +0000
Received: from amhetre.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 9 Jun 2021 21:17:19 -0700
From:   Ashish Mhetre <amhetre@nvidia.com>
To:     <amhetre@nvidia.com>, <joro@8bytes.org>, <will@kernel.org>,
        <robin.murphy@arm.com>, <vdumpa@nvidia.com>
CC:     <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 1/2] iommu: Fix race condition during default domain allocation
Date:   Thu, 10 Jun 2021 09:46:53 +0530
Message-ID: <1623298614-31755-2-git-send-email-amhetre@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1623298614-31755-1-git-send-email-amhetre@nvidia.com>
References: <1623298614-31755-1-git-send-email-amhetre@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0c7d48a7-13c9-4625-141c-08d92bc6a5ab
X-MS-TrafficTypeDiagnostic: BN9PR12MB5116:
X-Microsoft-Antispam-PRVS: <BN9PR12MB511696C6D17D7FAE0B5A6C79CA359@BN9PR12MB5116.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dPqjowtCTeWXsAiQ7vCo2heojgm0zEWaGfaAH92yVq8XBJ2xfAoxZaSl3zwgbBgjUWSD/pqyYd2UFjPvB/hCUnaMExNaej4ngkB3fA1hnA3nm82xVzInj5P9JvAYnuAZZyBO73HnCF+QMwIYZ6ZLlYybpT1idA9yYbe9Ao6cXbbW21KqtioA6p/Kd8FQ9fjFaI0J3+sZDtjm57sHTgPyDsNZ1I/qgwexEXopH1G2S5xcTHaG0ZQFETioqSTUYNzYxGtYTElupwtlvVqv9cQfEkgXNAb9GBK4nqxN6ztZxHVQEq/GmHBSV6WhF+Qyh1Oku9fvRiPaJol+y/d3kx3t4zObcWePk5uQnRtn6jyV7eTboGjHL1i8cAYDzSyTUDnzOiKscPCKCx4VCh1aIYueFgqPetEf0QCidnqq5yicVWFg1q5Y4gG485WlG7oVD4a38rWv7WulIVxSNFth6OSI/KwpB/yesWjwY5sWu+Py5fw/8CtzpMx8gj7a6Nw0wQW8i/abQ9bggcQc4oyyQlrahgY9SdIh2b95gnkPUPpc9UfZHNuFJQeVrUPTQw+DfITnsiCrvS8HIQZqsjDufF4hmrNz3gaFWtLlS0iG7KDMGNhM93gBEUtagdmsppEv8vx5n6xQiGD/HGvQ6yLNnRy/DYecbBt4JVzUe/Nafg2x7Fw=
X-Forefront-Antispam-Report: CIP:216.228.112.35;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid04.nvidia.com;CAT:NONE;SFS:(4636009)(396003)(346002)(376002)(136003)(39860400002)(36840700001)(46966006)(82740400003)(7636003)(26005)(4326008)(6666004)(336012)(2616005)(8936002)(8676002)(36756003)(70586007)(83380400001)(70206006)(426003)(36860700001)(47076005)(86362001)(186003)(82310400003)(5660300002)(36906005)(2906002)(7696005)(478600001)(54906003)(356005)(316002)(6636002)(110136005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2021 04:17:23.0868
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c7d48a7-13c9-4625-141c-08d92bc6a5ab
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.35];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5116
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Domain is getting created more than once during asynchronous multiple
display heads(devices) probe. All the display heads share same SID and
are expected to be in same domain. As iommu_alloc_default_domain() call
is not protected, the group->default_domain and group->domain are ending
up with different domains and leading to subsequent IOMMU faults.
Fix this by protecting iommu_alloc_default_domain() call with group->mutex.

Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
---
 drivers/iommu/iommu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 808ab70..2700500 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -273,7 +273,9 @@ int iommu_probe_device(struct device *dev)
 	 * support default domains, so the return value is not yet
 	 * checked.
 	 */
+	mutex_lock(&group->mutex);
 	iommu_alloc_default_domain(group, dev);
+	mutex_unlock(&group->mutex);
 
 	if (group->default_domain) {
 		ret = __iommu_attach_device(group->default_domain, dev);
-- 
2.7.4

