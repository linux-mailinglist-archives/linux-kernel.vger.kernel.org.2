Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F63537B6F8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 09:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbhELHhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 03:37:07 -0400
Received: from mail-co1nam11on2045.outbound.protection.outlook.com ([40.107.220.45]:22112
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229850AbhELHhG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 03:37:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IwmKsDDSUJxIhKijwz16gog9bCBk5XRpaQn5jFNsCzWzBow4xKODFHSEVOyfVcPAMoDOjFfwaXhfhmRFRPNrCHJCUt0yTQKDYMHKIxBOn9HpAkwPr6YKoUDFTnwt5NocqEul6pK0+nMFsDMRJSHdaVlYzr+6LzByCA/fbhrb5aAPp6czmLS4hcfdAZOMnPeN+aJ20V0O+MqGIjxE1CenqqksWXacWgqMwDEPDUsVveQcPVef1CBa12zPZmkct8b2P3zmpJa/8S2HZdZEZy9eamDvaaLvfLQs3fG7SB0Cm5BZNBljUWkIQt0BqM8tFCUP+qIXX9wOIAufo/NCAGYlmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CGyigBNROctUvUXCdR71NdP+Tk1iH/z3j7lDKm3TTGs=;
 b=foGFvOlXfkEN4Skibl8t9bK+2Wk6mdR7BIUmY0IhRM6BzfwMyg6Q+waJfAZ0O0VIKHPQdrQFY78W0vSTatA77qiRSM22hjTpFvbbOREtW4AcJdfFGJylf6Rz0BAuJJNjN29er9WAoksx1JNbcCrp9E/T/pHByXng7hnNfFA/68IlAWUeX1oBIxXcRVmGwpKsvoPzQ528/Jm8hEPIIDXtSRsh2lbWJ0bdz0NCCAcJEvqTRquY1jU+5D0xOO0t4Kaxd6GNYzV5Kt2ngtCvD57q6soy7kiLLVKTdm0YTxHmfKiU12DdPCda/+FSgKkpPdZfUMmbZbc2fau+oLc/X7jFcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=kvack.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CGyigBNROctUvUXCdR71NdP+Tk1iH/z3j7lDKm3TTGs=;
 b=WbnUgN48DFxGG2OHymORPhvhX4ckNyWCke2o6JKpZhvxabh+Ew2/1/cKS73TkDLeAyG9RjSuUzYUholv7e5YXdzwEt94f/nZvlxNkPt8MkOP7cmqJu3HARpnhaE5swF11fknl64a8Y2HPMj4stONOlr9UkHKakG5W67qBSd37Pld7zpy5VpIeCGFTnI5Jvx87mzbrh/fvAZV8xXgVjRCCGXkl1gA0BMbm44Yz5k10lj0nN9uPenFEWPXSWcTCQ88PozmL5Wit7B0Sewe1BJHLMERkNK1aFDcXQiwNEIJ6R4AM5YlaqqAxSa0sMBJy9QPmW7gLRZUSpAh/tVLsw8O+A==
Received: from MW4PR04CA0062.namprd04.prod.outlook.com (2603:10b6:303:6b::7)
 by DM5PR1201MB0185.namprd12.prod.outlook.com (2603:10b6:4:55::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Wed, 12 May
 2021 07:35:56 +0000
Received: from CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6b:cafe::6) by MW4PR04CA0062.outlook.office365.com
 (2603:10b6:303:6b::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend
 Transport; Wed, 12 May 2021 07:35:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT043.mail.protection.outlook.com (10.13.174.193) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4129.25 via Frontend Transport; Wed, 12 May 2021 07:35:54 +0000
Received: from localhost (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 12 May
 2021 07:35:54 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     <akpm@linux-foundation.org>
CC:     <bsingharora@gmail.com>, <dan.j.williams@intel.com>,
        <daniel.vetter@ffwll.ch>, <david@redhat.com>,
        <gregkh@linuxfoundation.org>, <jglisse@redhat.com>,
        <jhubbard@nvidia.com>, <linux-mm@kvack.org>, <smuchun@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        Alistair Popple <apopple@nvidia.com>,
        kernel test robot <oliver.sang@intel.com>
Subject: [PATCH] kernel/resource: Fix return code check in __request_free_mem_region
Date:   Wed, 12 May 2021 17:35:28 +1000
Message-ID: <20210512073528.22334-1-apopple@nvidia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b49507a6-36e5-45dc-9ebf-08d915189381
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0185:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB018579210DC1B0AFF6C4E313DF529@DM5PR1201MB0185.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1060;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O8/jaAf+nF5cmIVuNIDliaSMKbgsfqyhYhH18LJ6F4HshtRcCLNJo7+6ECIYG7jY7CUMmZiVFxCYZlAWF0KtXRxgrHAbCVEGOP0k6c5f8DvtC2KSdlaCj6L6djUx+P3FXTjU5fujX53QKYpa15z9aWWrXTvdv8C6pkUAozfIVanS7p3wldj4U9CvCeYWkSkLeqFYxISrBq7X2mn6nxONP0xHolrjsXR1dCWDA2MKENXbAfy4xUDX9w/kV8N3i92A3YtgDMbKj8XiqsY3HfP2z1jo173TFSqtlrsYdHJEFT9lWvJGLft628geEa0EESKMwo1KdcPQVhmel7Cd1FUMzpQJkrgEzFSFfCdBZOjyHHDhCqhl43XeJhviwnYywTa+hqy5I1b6mLT/cmXWdZJ/V1KHyegzKqjwbs6L1cizw9cwuM6wpJTwQx5PMr6ZYNJHDva7PpKuhG2QoO/V9xuw7mhBrSI8ivkmhjzTC7a+YV4h/vG5ehkUueaIcUGS/7GLgkRH6tUwmQbgLe6OUKnHLMHtrJ8FauvPQzFT9puGDEghpahR4FcykPc2InI/U1vmA6IDHe08F+bRk6qxdNSEbFiB0GqUp4e/2JudEMoQYSF/kUtSJRqgckf2zMg8lSK4NNn/MuRtmk5mUlr2TC3MSQeicm5oyKiJn/Hqx6m0+nU=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(396003)(136003)(39850400004)(376002)(346002)(46966006)(36840700001)(316002)(36906005)(83380400001)(54906003)(6666004)(1076003)(356005)(7416002)(6916009)(82740400003)(36756003)(86362001)(7636003)(478600001)(426003)(336012)(2616005)(2906002)(16526019)(5660300002)(186003)(26005)(36860700001)(8936002)(8676002)(70586007)(70206006)(47076005)(4326008)(82310400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2021 07:35:54.6760
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b49507a6-36e5-45dc-9ebf-08d915189381
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0185
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Splitting an earlier version of a patch that allowed calling
__request_region() while holding the resource lock into a series of
patches required changing the return code for the newly introduced
__request_region_locked().

Unfortunately this change was not carried through to a subsequent
commit 56fd94919b8b ("kernel/resource: fix locking in
request_free_mem_region") in the series. This resulted in a
use-after-free due to freeing the struct resource without properly
releasing it. Fix this by correcting the return code check so that the
struct is not freed if the request to add it was successful.

Reported-by: kernel test robot <oliver.sang@intel.com>
Fixes: 56fd94919b8b ("kernel/resource: fix locking in request_free_mem_region")
Signed-off-by: Alistair Popple <apopple@nvidia.com>
---
 kernel/resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/resource.c b/kernel/resource.c
index 028a5ab18818..ca9f5198a01f 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -1805,7 +1805,7 @@ static struct resource *__request_free_mem_region(struct device *dev,
 				REGION_DISJOINT)
 			continue;
 
-		if (!__request_region_locked(res, &iomem_resource, addr, size,
+		if (__request_region_locked(res, &iomem_resource, addr, size,
 						name, 0))
 			break;
 
-- 
2.20.1

