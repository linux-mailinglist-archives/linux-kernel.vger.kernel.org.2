Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2F8430F66
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 06:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbhJRE6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 00:58:08 -0400
Received: from mail-mw2nam12on2060.outbound.protection.outlook.com ([40.107.244.60]:32480
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229481AbhJRE6H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 00:58:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EKp5LD13LoovNA06+AhMHKFyv83UFZ2Himc/yZPmOZq+ZrIiq327A/fmNRxWoliI/JuLPqA2F+oIeBgJ5R9Ye3rP3ar/4iablUKkOZS+H5Ei7OOh+901pGcHCZGkERPmem8OGSTtc+65KfK/9rqG2kFm4OsMRQaYsTPtoavPyB+7D7N7Bd7ED/eQEBFqYYTesN1EvajvFcnhpwu2s+EqKHsn8ilFHyPc6J+m3XWG9ks7+VYaSzxJ54FwJn7Wthdod+NpemE2LejAFqQwAZJvQdcQud0Pcn8oo9Vq97mf/ZNBiLG/UCWIqS+WHq8CkgA75o3OhhJswU/6LmjVrAbYzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bbye1nzo2652wgMAuaPvp1Dv0qBpyHX1EF0F40dxTm4=;
 b=lP06eXYDS55tbsbqUt7dlLloPITmda2SZyVplkEVCaP5RpQ7g0nLpz1esJWDrH3ZVCra3UqnKIhhBcSJ/TTz8wL1BO8zlolaDhY5mdNDqFGhjOuvQBItNuRfX7lsRlVIIpgZF+nCGO+Dfb6ZdxlFi7DwqGMCjb50o3WKQCmFqDn47xmNWxxGMGz+LGdSVA5UxaI9+LkGBYpOlpAKz9W3H5ep9FIsvC4ahaEl+vr2v5h/sKaAl7xfEqnD++5BMrLi9x9hn9Mxv0i8bLqzfmVL99SyeXdN1IlCGwRi/VzGsnlbvB026AiG7AIeLeLFL5eGxulIgqUUkW6BLEUomnS/7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bbye1nzo2652wgMAuaPvp1Dv0qBpyHX1EF0F40dxTm4=;
 b=cTp+RBAqOZbOrJFlmi8dAQmT3kDqiA6hgXWfHFMxcMkWWbbjx/cqwF2Ed9aypt7Z+BS6H6LC2FJiPB2dXblHGGcre2NHyfZqZf3c89u+pc9qlrSU89VXnKwp6rMgYL8nVdx1r5yhRZsU2ov4ZFFrhu8/PcwAPWAVvk5mJhXr8z0e9QeYRiM8uqFwfiKGnaui4hqhdmNhBU1V/GyBbLsJbQsjNHFdvmuiYf0USvH3X7YRPwR1eymhWLO8J0oEMhnw+EUTmz4RHY6n2GkOtJMklLiu230wCJclEBhFcytBSq5sE8raaL/aFXO9wopcvVuZYgd218cl60bzz55k3vTD0Q==
Received: from DM5PR06CA0030.namprd06.prod.outlook.com (2603:10b6:3:5d::16) by
 DM5PR1201MB0265.namprd12.prod.outlook.com (2603:10b6:4:58::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.18; Mon, 18 Oct 2021 04:55:55 +0000
Received: from DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:5d:cafe::fa) by DM5PR06CA0030.outlook.office365.com
 (2603:10b6:3:5d::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend
 Transport; Mon, 18 Oct 2021 04:55:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT029.mail.protection.outlook.com (10.13.173.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4608.15 via Frontend Transport; Mon, 18 Oct 2021 04:55:55 +0000
Received: from localhost (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 18 Oct
 2021 04:55:54 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     <linux-mm@kvack.org>, <akpm@linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, <rcampbell@nvidia.com>,
        <jhubbard@nvidia.com>, <jglisse@redhat.com>,
        Alistair Popple <apopple@nvidia.com>
Subject: [PATCH] mm/rmap.c: Avoid double faults migrating device private pages
Date:   Mon, 18 Oct 2021 15:52:47 +1100
Message-ID: <20211018045247.3128058-1-apopple@nvidia.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: afddb031-84bb-47ec-e4b9-08d991f39199
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0265:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB026576D107A0F60E28A35354DFBC9@DM5PR1201MB0265.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g5Tc5tksbDNcXIzqbZjsckTlmsROMwKwX3pU26XZCTguZR3IdmMK2uJC/LIDFPwvGsEVUobp4RBXrjNrh+JH2ziBmHbMfEIDMqtYHiw5HEiASgh72YkO/LVoQw5VG5FxYg4c3sz3F1MRdG9w6w3CIUNONsViXDTT7nF6aBZgR2ZV7/ksn7TPMCSVYbEaf+eW2KMsnWjlP83x68N3gHPUKwLnnEP6Qyvc+PGPziEXO9E4IYipr40Ww/mp9KSeddJ/fP3PyMdsRGFLWGGlz77lK+Zobamhyo0snr0uinqAWOs5PxJ5JqU3AzHHHM3jxDHkjgmpQ29+jfHpVln9kZIogZk16lDUC6N6DFbz+cx3liitaaFaSGFE6tjfTpxEGmoon8C7Jszgkw8OdgH8h+/tFQBvT5D2QOBaAl3gBJ0X/Nn0zHjDjKZ0YS4Po3zo5YScwxVE62dCsWP8aN3MYI9ArSPmE6ZNsM6EpAqzhhNXMyyRYLHtNw2/H2CEuAodpEZY2J6l/CKXdVdH0vdx6yOC2oiaFOjry0cXPRcGemNcKT43kIAELSrqCfstTK0ytcg07w9audEjLznW8q6+HFqZGF9AMF3IoTPx4VHMWvcAFv7S3/RcG+KYKCa07lTWI0lIThfG29T+J8/6TNc9prozRZsO2E03OfgIeoIZwcmec61hiugvdiDQgRn5lx6fB5p/bhLxo5g5ra6pWkhH/lfLcA==
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(336012)(86362001)(2616005)(426003)(2906002)(107886003)(36756003)(6666004)(316002)(5660300002)(54906003)(36906005)(110136005)(70206006)(70586007)(4326008)(8676002)(508600001)(8936002)(186003)(16526019)(36860700001)(83380400001)(47076005)(26005)(1076003)(356005)(7636003)(82310400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2021 04:55:55.4488
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: afddb031-84bb-47ec-e4b9-08d991f39199
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0265
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During migration special page table entries are installed for each page
being migrated. These entries store the pfn and associated permissions
of ptes mapping the page being migarted.

Device-private pages use special swap pte entries to distinguish
read-only vs. writeable pages which the migration code checks when
creating migration entries. Normally this follows a fast path in
migrate_vma_collect_pmd() which correctly copies the permissions of
device-private pages over to migration entries when migrating pages back
to the CPU.

However the slow-path falls back to using try_to_migrate() which
unconditionally creates read-only migration entries for device-private
pages. This leads to unnecessary double faults on the CPU as the new
pages are always mapped read-only even when they could be mapped
writeable. Fix this by correctly copying device-private permissions in
try_to_migrate_one().

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Reported-by: Ralph Campbell <rcampbell@nvidia.com>
---
 mm/rmap.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index b9eb5c12f3fe..271de8118cdd 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1804,6 +1804,7 @@ static bool try_to_migrate_one(struct page *page, struct vm_area_struct *vma,
 		update_hiwater_rss(mm);
 
 		if (is_zone_device_page(page)) {
+			unsigned long pfn = page_to_pfn(page);
 			swp_entry_t entry;
 			pte_t swp_pte;
 
@@ -1812,8 +1813,11 @@ static bool try_to_migrate_one(struct page *page, struct vm_area_struct *vma,
 			 * pte. do_swap_page() will wait until the migration
 			 * pte is removed and then restart fault handling.
 			 */
-			entry = make_readable_migration_entry(
-							page_to_pfn(page));
+			entry = pte_to_swp_entry(pteval);
+			if (is_writable_device_private_entry(entry))
+				entry = make_writable_migration_entry(pfn);
+			else
+				entry = make_readable_migration_entry(pfn);
 			swp_pte = swp_entry_to_pte(entry);
 
 			/*
-- 
2.30.2

