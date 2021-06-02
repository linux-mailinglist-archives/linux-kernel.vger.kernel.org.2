Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA4CB39847F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 10:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232805AbhFBItp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 04:49:45 -0400
Received: from mail-bn7nam10on2052.outbound.protection.outlook.com ([40.107.92.52]:21728
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229967AbhFBItl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 04:49:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LEBiPhET14OXOLIQF3ioXK41NkXanxCHsOJZgfZIm2Q5hfYaoS1hzacGrnHjxqscgMNtGe9l2etJanpnpqYAxojRnGsN/z3WsYsbsyz+sBYBDKKpVVfub5lf+DAywsdKFJzdg0KJoQTzkFwjtV49jNimgA66ETcML4EhaC86lvnYdZsqCWP/pX/SvN9AVVYq+aiqKceSQsy6ZaIgAUNi/lM2L2Szn6F4bkxO7HuC4eZrxTR45HuvUh90re4EsmguwAWTJiW1t2zOvkFsjhFKV3PO1enQC5D5e2gVdp8BAsPh/Qiuyq14ZP5PSmIioVg1xQloadQY6BgfEZ/noq8ARg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SM1AeGLPP9rmAZCA8H7refkPrJcT1OVACUSn0U45FPE=;
 b=B5dwm76qLOEnDDFJo37P1W1WZ3UN9bkpBGq+Qbw65rzQrhYSEqKCEKsNDjvEWZMM3vL2ALQrqdCFmEsM81TY/E9VIqbsbYbBMjvHtlZHWM7f+gFfI1bFA8VDsxcVm4vRqeWr+zc/m+3DqJL6RbMYiTXU34Jyo4RyaJpPzrJzFYL1ELwmx0RZg+kIWmEdLyCDPUQG4+fM7N7+59em/Sbt3fDzBrsrZs+wD1BGE1rRiU64Aw6gsKMKJlY0lkvWC2Xb12exOEDesbdbzE/p/+K7YK+fHCUr+avGEuwUXDozRceQ9buRgxSgvZOSumuoa1JZYVWsE4X345bMUxuMmOLgaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.36) smtp.rcpttodomain=kvack.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SM1AeGLPP9rmAZCA8H7refkPrJcT1OVACUSn0U45FPE=;
 b=MgrkfyjiWx/iIwJK+1d/bmZI2ybUJm9xkte8MTVrAyUu/fTR9suXmP8upLXq4XqgSfzfIHuQKkCAFXUx+LCJZHjIPpfX80gk2KjGUeGWCD2ZtRbYUNR58KFwhssASSbyp46FP+2bjoQMXEHnh249K5WmtIzg3qZsfZTpC/v6DVZIUGhYMoUhYM+oy2edTlH2bCo3ibaC0OweHMxLBaqsj2c7pBLSzY03vra0Bqzv48wHH5pAaqvchAP4LtFGqTC0/sJm+dChRL3UrQeLJbFxN2V99BaZIIhkq5O++wsg9ft/kuo2tKIWlGQ1Nc51zT6SNnx2kqovB+tVHj2BbmQ5Vg==
Received: from DM6PR08CA0030.namprd08.prod.outlook.com (2603:10b6:5:80::43) by
 CY4PR1201MB2502.namprd12.prod.outlook.com (2603:10b6:903:da::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.27; Wed, 2 Jun
 2021 08:47:56 +0000
Received: from DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:80:cafe::16) by DM6PR08CA0030.outlook.office365.com
 (2603:10b6:5:80::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Wed, 2 Jun 2021 08:47:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.36)
 smtp.mailfrom=nvidia.com; kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.36; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.36) by
 DM6NAM11FT060.mail.protection.outlook.com (10.13.173.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4150.30 via Frontend Transport; Wed, 2 Jun 2021 08:47:56 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 2 Jun
 2021 08:47:55 +0000
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 2 Jun
 2021 08:47:55 +0000
Received: from r-arch-stor03.mtr.labs.mlnx (172.20.187.5) by mail.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 2 Jun 2021 08:47:53 +0000
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
To:     <akpm@linux-foundation.org>, <linux-mm@kvack.org>
CC:     <pasha.tatashin@soleen.com>, <linux-kernel@vger.kernel.org>,
        <logang@deltatee.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH 1/2] mm,memory_hotplug: align code to fit 80 characters per line
Date:   Wed, 2 Jun 2021 11:47:51 +0300
Message-ID: <20210602084752.3534-1-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 22719209-84be-4b12-9d64-08d925a31e1a
X-MS-TrafficTypeDiagnostic: CY4PR1201MB2502:
X-Microsoft-Antispam-PRVS: <CY4PR1201MB250268D27F4F1A4317F0338FDE3D9@CY4PR1201MB2502.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:156;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AoLzi5lzToG4BchglU1vZwyXVMChU8TIpKHp1NOeScjLYCnbKW6fvnQsasGCjtA1Hx2Ok8VA7dosq57WRL8mvdZGmyx8Na1AN+Nt9GRMAVw6xi2VfpB5ZUNnjDSFhabQ/OLPglKND0XoPQspoubNZRwnWgP//lJcRAQiUuMCx3RPUr5p6tB2RHz2gskBJ91YAx6vml2eDkrAw90WHk8721wGGUhhvWFPIhZg7sbntwaHcRUy5rC7AaVwjtCyd/mnPwIFZ772gqxcxKuOc0a0Dvw8e3XQEhhx3q1Z2bZ65SiRzEUhFDWJQIC1BUAxZcebkAFTtuYhOKSqUATa6JyRym2ZsswOSxPpAYty5rBqmCSlB4kkrUULJkO4i8vncYaour4xFFiHtjpJ+zdev9w/XFjO6e+ly0t0BTemPTSvFD5FVrxOHlwALvbn26bvLs2DwJDiu8rYBQWuqg/bGO6zSLl5VfPpfiYt7FzdyVPI9+v8EaLgYXm0YBA5JjE8gxCMR9cNvpiO8fteKxAQMd6Jm73/4DoSAUdm9i21mAGhY/d1r0DQp9IoQ88J4TrkQoNubntFO5tJqZX7BpuOXDUMx0B9byQK4PJwxn43kj6LX44pF+SrGzyoUiFLFJJsA0zo3saSvnZKVl1+TfiucFsvvc+jVKGtrGXEOnAIS13gIwg=
X-Forefront-Antispam-Report: CIP:216.228.112.36;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid05.nvidia.com;CAT:NONE;SFS:(4636009)(39860400002)(346002)(136003)(376002)(396003)(36840700001)(46966006)(110136005)(186003)(316002)(36906005)(356005)(5660300002)(54906003)(86362001)(82740400003)(336012)(82310400003)(4744005)(26005)(70206006)(2616005)(2906002)(426003)(4326008)(36860700001)(70586007)(1076003)(83380400001)(478600001)(107886003)(47076005)(7636003)(8936002)(8676002)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 08:47:56.2864
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22719209-84be-4b12-9d64-08d925a31e1a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.36];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2502
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "if" clause can fit to one line. Also while we're here, fix the end
pfn print (use %#lx instead of #%lx).

Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 mm/memory_hotplug.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 70620d0dd923..8c3b423c1141 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -288,10 +288,9 @@ static int check_pfn_span(unsigned long pfn, unsigned long nr_pages,
 		min_align = PAGES_PER_SUBSECTION;
 	else
 		min_align = PAGES_PER_SECTION;
-	if (!IS_ALIGNED(pfn, min_align)
-			|| !IS_ALIGNED(nr_pages, min_align)) {
-		WARN(1, "Misaligned __%s_pages start: %#lx end: #%lx\n",
-				reason, pfn, pfn + nr_pages - 1);
+	if (!IS_ALIGNED(pfn, min_align) || !IS_ALIGNED(nr_pages, min_align)) {
+		WARN(1, "Misaligned __%s_pages start: %#lx end: %#lx\n",
+		     reason, pfn, pfn + nr_pages - 1);
 		return -EINVAL;
 	}
 	return 0;
-- 
2.18.1

