Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03200398480
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 10:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232828AbhFBItw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 04:49:52 -0400
Received: from mail-dm6nam12on2068.outbound.protection.outlook.com ([40.107.243.68]:45473
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231245AbhFBItm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 04:49:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S5Fck2Bqj0Oo1W7AjSfp5SZH5+nypH+2/2utGp1jdC2k4zV7rwIHHvBwxGQacYE4pveCM/YoQnhwqSsOd3eQAotsgex2oYYhK9+n8wJIPscwwv4Nl+cd56Onn5J9AKcrwWIe/CTRB47H8ugZnup/ld4TMaFIej7eeO2RrIVOjUCvhHMsmjwj5q+pybIBjX0M7ukHunC6Kfv806lhjCgcGhw6wZ+I34AcBGii3zsT3p68zldetvJz6BLHrPvwVs0WRl2zDpXBpVBK0CdhMHH/b7gGxRJLbfTtaJu1VsJ4nW1OrdNgp8Ta1s9HxlnZ3sHLsJXoEvDORG8nDI/kLjQeOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=unpTT5AzW4kx8Noa2GJKHL0P1eSGGi+4NS7bPEUMWdM=;
 b=SCzx0UYpqbRyQlFlM3aQaMN14ncHQ7mlEro6aUDb9AET24UnM7wVrT524N7a34tB9clR1t65oWql7yhBlvQ7OXroHMk+Y1fk5sznLXt+5vP3mZKLTrJfJS67dD9IrsAlL/Z4OT8jws8D6LZwFaRj1Bir84PdwMJkg/DfQiqeCCDa7W0cAWqV4UQ8YGxnE1Qt0VcrUjdh7PsmwWM8FFkdLsrr/iJJtnv9pJtWTZCEI0JZwkyQEdjqsypl55pZBwHcZCuF8dWymmBBcBscrz65AS3bWYYh4Tcp3ZE7ajfyBpbbjFd5T9G/0u0sHWA3f4XEB+bmDeZY7CRmFg7MaH07bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.35) smtp.rcpttodomain=kvack.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=unpTT5AzW4kx8Noa2GJKHL0P1eSGGi+4NS7bPEUMWdM=;
 b=SR263X261GT/qRCl53CHXAagdkRs91N4GPz7ze9lxKcd/65/ogJuV8ThNgs+Eac4hFEVsKq+1Z5Avwe+n4bN+mlyi2TenoQa7AwXIPlG4F3UIgZgKzmmrCzU2bBaL/U2SzuZh3F7FJmRULT9NurIYOGkGzBUhucTo31kKcpB+dOlF9RsLVdt1xDEmd5HwdszTTU8UftBD3ZWZGkICxM20Zq4GHcwtYUKvNOze9Mk+akkZK/V7yIp8X5chGTLYKfKdq9wVddC4M8X7Z+0fpn1ivG4++85zwnyjsPqR/svejemhI0grOfmlu6lUqYcV0zBJsgYVTdKdQCwE9GLsp8XQg==
Received: from BN8PR03CA0012.namprd03.prod.outlook.com (2603:10b6:408:94::25)
 by BN8PR12MB3332.namprd12.prod.outlook.com (2603:10b6:408:66::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.26; Wed, 2 Jun
 2021 08:47:58 +0000
Received: from BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:94:cafe::5) by BN8PR03CA0012.outlook.office365.com
 (2603:10b6:408:94::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.15 via Frontend
 Transport; Wed, 2 Jun 2021 08:47:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.35)
 smtp.mailfrom=nvidia.com; kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.35 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.35; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.35) by
 BN8NAM11FT054.mail.protection.outlook.com (10.13.177.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4150.30 via Frontend Transport; Wed, 2 Jun 2021 08:47:58 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 2 Jun
 2021 08:47:58 +0000
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 2 Jun
 2021 08:47:57 +0000
Received: from r-arch-stor03.mtr.labs.mlnx (172.20.187.5) by mail.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 2 Jun 2021 08:47:56 +0000
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
To:     <akpm@linux-foundation.org>, <linux-mm@kvack.org>
CC:     <pasha.tatashin@soleen.com>, <linux-kernel@vger.kernel.org>,
        <logang@deltatee.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH 2/2] mm,memory_hotplug: print the min alignment in check_pfn_span
Date:   Wed, 2 Jun 2021 11:47:52 +0300
Message-ID: <20210602084752.3534-2-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20210602084752.3534-1-mgurtovoy@nvidia.com>
References: <20210602084752.3534-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0638f399-a647-4c94-693a-08d925a31f6f
X-MS-TrafficTypeDiagnostic: BN8PR12MB3332:
X-Microsoft-Antispam-PRVS: <BN8PR12MB3332B62CA96CAA3865EA854DDE3D9@BN8PR12MB3332.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:175;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I5iLUjkm1+L6pdO7VnLmYnULH0Ke1KD5qs5heK134Vjf1X2LFOHyJglR9HYM3DxCoseIFk7lZRcAjFJgLVc/d1iBNPKT/XE5yoo1cfq6Ald646qQg6FpNyCIErExuo6pWe0uJYIP8Qw3Obq4yzJ0lXF3XAqL3R3mf3GK56aPy3ZSKVT9tLFM1YBr9Cx7YHQ4SjZVX/vCvPdZxs3cLMvLDzYObTIt495Sm3+N9agfpKwj4dsbRBCfNVYHSvTH4hABb3iALjAOjcqIK5j+x6D6PZn9ACd3AQgMi9wgZjKy7OcqA17B1nTwuDXZkQlW4DeI7TjXZSlAhR8LHuyRPLS8wRDg0YNzqVRRZJ4BVyHXjFCs4A1p2tGdoDvfJ6QIaIY6YOiQjyshrEE0DK9fUqRmoIAX/tMq4GVC7zI+rhSXEuOHGegi9jAkldvNJV+/ay2uHcJM1IgP67p6pZ7+d1eWLk+tqu0cmKInE9tjJdin46j69g64Z4HfnhBO3cSc+P8eN+oRvYGmLE1cFZjxcrxeRyqmTp5fpp74lY6xCFAG7llDIQJKdJYavpJry3pVJuoJBm/KkU9A0IQuq7Z1askJ3DRrg8ahCtEcYRunwBUae0hlEY5hDdfHXznueX0b8hr8iWS4ZClGM1u0EwhH4zv0Ug==
X-Forefront-Antispam-Report: CIP:216.228.112.35;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid04.nvidia.com;CAT:NONE;SFS:(4636009)(346002)(39860400002)(376002)(136003)(396003)(36840700001)(46966006)(8676002)(36906005)(4744005)(1076003)(186003)(26005)(426003)(8936002)(7636003)(356005)(82310400003)(5660300002)(70206006)(36756003)(54906003)(83380400001)(70586007)(107886003)(110136005)(86362001)(82740400003)(6666004)(47076005)(478600001)(2906002)(4326008)(336012)(316002)(36860700001)(2616005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 08:47:58.5118
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0638f399-a647-4c94-693a-08d925a31f6f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.35];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3332
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The warning only prints the start and end pfns. Add min_align to the
warning print to add more info regarding the failure.

Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 mm/memory_hotplug.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 8c3b423c1141..9e86e9ee0a10 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -289,8 +289,8 @@ static int check_pfn_span(unsigned long pfn, unsigned long nr_pages,
 	else
 		min_align = PAGES_PER_SECTION;
 	if (!IS_ALIGNED(pfn, min_align) || !IS_ALIGNED(nr_pages, min_align)) {
-		WARN(1, "Misaligned __%s_pages start: %#lx end: %#lx\n",
-		     reason, pfn, pfn + nr_pages - 1);
+		WARN(1, "Misaligned __%s_pages min_align: %#lx start: %#lx end: %#lx\n",
+		     reason, min_align, pfn, pfn + nr_pages - 1);
 		return -EINVAL;
 	}
 	return 0;
-- 
2.18.1

