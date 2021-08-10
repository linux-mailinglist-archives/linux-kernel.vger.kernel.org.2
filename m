Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0AA3E526C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 06:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237450AbhHJEot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 00:44:49 -0400
Received: from mail-bn7nam10on2045.outbound.protection.outlook.com ([40.107.92.45]:25725
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234780AbhHJEoj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 00:44:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N7TkkNavvIViL1gInEUzuVjclU0TEkZFIy1x6cti5onkigAjUIOlczebZaFopnnveRBgKKaIUe0TERGk7p66EhMIC8/cBwcNnZGEUbmacKPh2YFfOEmkZ0/zXJXI7XA3ldEOUn8+z5KEw1nj3Q96gM5gAm+DSyk4OcsNPT0Udhvv4eC6RXk/psfL1WEEcJPo9umRoC5pgho+AyF6JEufGRVybEFavueb9BnTk9yD0d8CuruGC1f2uozcQKgWRiitBfBXIlVPqU/IvqoHGX3f+FZzkU+xkd10ewdb5Mia61SbKv54caEJUQWleL61V2wtzCmnf7oQhV9QoDO8+uTAWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lR46JoGEZke9JXnF+4oFi7ZYoZeS/I7xlF4nQxXsmVU=;
 b=nIX1ElYRi9Ma++gooQfTCTTagLcsM6S7Ngzy7DKQuk6w84XdqX/msWF6Dx7C9chDgper4rntuvcbolJsAEFE3nChBfXfkboVNQ3iHHXttJQTib6c70VhJwovStB04JMudRbM4V2LEtZdlAZYeosIwSXqqnFqlpOv9B/+KImfVayUuQGBG9Z0MV8eLLazoPy+WYxq4PsfNk4cBwS1vUO7VLR09aL/CjKn+cpf+j6fmZw2w7aK/dAqdYbF+aowYZHfxZf64APARuRFYr2TTFwFrtytBAf/hYZRCtPH+3GuuqYtIdKctD/lN0ALicD3/18MDg15naI69T80sfhgTJh/uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.36) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lR46JoGEZke9JXnF+4oFi7ZYoZeS/I7xlF4nQxXsmVU=;
 b=HR3Ctb1Kn4cs43g6sAPpXQkw+HfD5rwggvP8DAi1vjn+7M14y7DoUZmjo28YeTW0nrAaSzkbfAcdH9fk3w5ekTYEYlvU3YIoEfCfLa8E5Gha1ZcImlsJdzP0Ub2B2jkrzJj0s/9VLK3RmA/s6knSIX7qGfYQWNph6qjfgz0pUF+MowhJdo0itB71G4sSvVJ1VUMgB44EYNxDD7R9q/bWHqmj4D2s2yQf7uZ5GZTzROH5Aqh1b8rIsQxCS7m+YA2NcIhWXUocv7cScj5V0DxR1HIZDrLt9jwEZXddKjVnA0oeZJn2OdECmDhhDALoyMxij+dQkOmf8pzuk8M5XwBGrA==
Received: from MWHPR13CA0021.namprd13.prod.outlook.com (2603:10b6:300:16::31)
 by DM5PR1201MB2537.namprd12.prod.outlook.com (2603:10b6:3:eb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.19; Tue, 10 Aug
 2021 04:44:16 +0000
Received: from CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:16:cafe::51) by MWHPR13CA0021.outlook.office365.com
 (2603:10b6:300:16::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.5 via Frontend
 Transport; Tue, 10 Aug 2021 04:44:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.36)
 smtp.mailfrom=nvidia.com; arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.36; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.36) by
 CO1NAM11FT037.mail.protection.outlook.com (10.13.174.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4394.16 via Frontend Transport; Tue, 10 Aug 2021 04:44:16 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 10 Aug
 2021 04:44:16 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 10 Aug
 2021 04:44:15 +0000
Received: from amhetre.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 10 Aug 2021 04:44:13 +0000
From:   Ashish Mhetre <amhetre@nvidia.com>
To:     <amhetre@nvidia.com>, <robin.murphy@arm.com>, <will@kernel.org>,
        <vdumpa@nvidia.com>
CC:     <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [Patch V3 1/2] iommu: Fix race condition during default domain allocation
Date:   Tue, 10 Aug 2021 10:14:00 +0530
Message-ID: <1628570641-9127-2-git-send-email-amhetre@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1628570641-9127-1-git-send-email-amhetre@nvidia.com>
References: <1628570641-9127-1-git-send-email-amhetre@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 436a7218-c48b-4c99-ce10-08d95bb9826d
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2537:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB2537CDF513325A09A1DF4C99CAF79@DM5PR1201MB2537.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DHU6LZKkhHI1NlEMe034UgfhrubKfH0PAs4hqWnzYTo+K78rltYtP6ylH4oW2gRqXhDOzS641U6DmnoQRo9rUIXmfCp4QTBtEdSOkl6GtQ4OegGpr7XzRsXFRG75BT6u6pYT/6Cf8ymDTQ38hD9iV0C8CPiyJY1eYlaoAKCVWdQId4asQ8NlzjtbQ0XqbjQsT3G+Uw6AOOh6kgUcUWSgXmT0MFZVNoW0OMG1f4rQIqcNrNuw4IBD4qKrgmLpQ8ibVpSMsQDSMmJJUwF1Pexv+z08NxomHp48UE2OHYDK+gJQZmy0gRejXPDxrFtfPzQ3T7kfh6vovJOmSO7kUar3sacjllz/FLsAlsJna6vd1orFSKTngOAGg7OKr+9Hsx0cv+pLB/5bkr65Rmt3TO1a2vw9hDF3laOR8BqxXaUQ2AcT19i8r4LXhEMTCZOzQMadvJHLizGsZmCwr0o6xLwyLU2TG8eWfZiYQNdXhmctsuLN5V9tnbKCCdZrt0RF+n2DtacIMOlzKYn50SDkNXfvoJvYqo0PoDmEa2XvlB1MnfMYVEXioaDFINERH7bmitlkFfUsrq8vQEZBO+C30FiouB+cGUMicfo+33z7tIZG+fcRXcnwOaAXcaIOwfQBiBxzs38etMJD+Ymv6VpYipQHvtoydyFgZi21zmFyX5qIq3i/Zp+5ryOIP+d+kqCVN1lrIsucM93U7FYwELJLEGQsDQ==
X-Forefront-Antispam-Report: CIP:216.228.112.36;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid05.nvidia.com;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(39860400002)(136003)(36840700001)(46966006)(36860700001)(2616005)(4326008)(6636002)(82310400003)(86362001)(7636003)(478600001)(82740400003)(2906002)(26005)(186003)(316002)(36906005)(336012)(8676002)(110136005)(36756003)(83380400001)(70586007)(356005)(70206006)(54906003)(8936002)(5660300002)(47076005)(426003)(7696005)(6666004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2021 04:44:16.3768
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 436a7218-c48b-4c99-ce10-08d95bb9826d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.36];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2537
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When two devices with same SID are getting probed concurrently through
iommu_probe_device(), the iommu_domain sometimes is getting allocated more
than once as call to iommu_alloc_default_domain() is not protected for
concurrency. Furthermore, it leads to each device holding a different
iommu_domain pointer, separate IOVA space and only one of the devices'
domain is used for translations from IOMMU. This causes accesses from other
device to fault or see incorrect translations.
Fix this by protecting iommu_alloc_default_domain() call with group->mutex
and let all devices with same SID share same iommu_domain.

Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
---
 drivers/iommu/iommu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 5419c4b..80c5a1c 100644
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

