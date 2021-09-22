Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D912741405B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 06:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbhIVETn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 00:19:43 -0400
Received: from mail-co1nam11on2076.outbound.protection.outlook.com ([40.107.220.76]:63328
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229495AbhIVETl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 00:19:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BZ1f50D7Z8SNFn3BQbF/kcuEXAuzchww8nu1wC4si02qqaFtv5vHFI1EcGff0iMop5bBqrg2LN0Bu23HvVOTnkEDgpF4CMI9VDG5dnz6/wjiEpFB03tGb1xUDOTgcxqGN93z9IkvE2pRzWEUxuSjaJbvneVCxxRSzf8zkjbrm3FD5XzindeUTVaAxET4BgYnPy6xKt8MKjLjJcIAtbvl3GZ4ZPJLqq9gt7WwVpJ7UV8TZRqesdWl1Hdhvs1xHZg28bVKVz+JBlQBK+ay2izwy7JdI+3Jl9Q6slERvQ+7+h2+KYb31BjhpG3x9NGpWf+PBpK2q75vR3tPTS+mlRyXGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Xtwuq+Q9u+B/2e+C7AkO0NL3vEY1c4KM7CbuBb29cfs=;
 b=E8ose+9iaSN49NjB1jRQZtSrxIEPl0gS2WZCbtXrJH+uu61g//9FHV5MaEg680AKeNvzFZd8fSJKEAsy+BJe5mde5m+NXnaEZ8YSFv0nqybnA3I3RYVH1zDuVupCiVmu4tIgfhJAE+CEuFkYt+gh9ffpZFsKO+nltxPbq7hSjaq5GwLY+dSV5N5O7x6jU67xeaepccEd0UiWseJH8I2G9S5uCDFhWAcWIJJNXXpUSPhb/+rbdki+qmqa8q3ScjrvbalLxqgipSepXojub4weejvsWv5ukfnF92ET9nDaEi3B3ggLUvfq5BD7UmZdCbYaOqEr1NCAzKfWvyXHnlBmjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.36) smtp.rcpttodomain=soleen.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xtwuq+Q9u+B/2e+C7AkO0NL3vEY1c4KM7CbuBb29cfs=;
 b=hCDxEAFRsJpQGSBa4MLrJLwH2sFC5/2aZxMgmfN/iyrVuL1HOdcoIX/QKWnpX1DUJGcIjj+NzFY8MtJotdxyuJbElDVYgjsRC2N1eWcfpoJ49xDbS4o92H9jmLZcuRk5m/NVl+j0AIgHGKnqfsCbRh9HlaOEN06H0tD8eUbxMhD8NqG0PhBUd6xSi3AeeCoGyKQaH3eVP4Ux9zRNL4FolkZx7DljQSdNT9IHd/lsnXU5tV7G7JU9M07f7HTf9hLMiNhph/Pauhkr3zkcxSHLHu6NknAvmN+GH+S9rmzn3XNqbSUutg6ias2RuQAiNk/FK7veMzLw9yNhbI5RpbGEfg==
Received: from BN9PR03CA0488.namprd03.prod.outlook.com (2603:10b6:408:130::13)
 by MN2PR12MB3901.namprd12.prod.outlook.com (2603:10b6:208:16c::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Wed, 22 Sep
 2021 04:18:09 +0000
Received: from BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:130:cafe::c3) by BN9PR03CA0488.outlook.office365.com
 (2603:10b6:408:130::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16 via Frontend
 Transport; Wed, 22 Sep 2021 04:18:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.36)
 smtp.mailfrom=nvidia.com; soleen.com; dkim=none (message not signed)
 header.d=none;soleen.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.36; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.36) by
 BN8NAM11FT034.mail.protection.outlook.com (10.13.176.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4544.13 via Frontend Transport; Wed, 22 Sep 2021 04:18:09 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 22 Sep
 2021 04:18:08 +0000
Received: from sandstorm.attlocal.net (172.20.187.6) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Tue, 21 Sep 2021 21:18:08 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     <o451686892@gmail.com>
CC:     <akpm@linux-foundation.org>, <almasrymina@google.com>,
        <dave.hansen@linux.intel.com>, <jhubbard@nvidia.com>,
        <khandual@linux.vnet.ibm.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <mhocko@suse.com>, <minchan@kernel.org>,
        <osalvador@suse.de>, <pasha.tatashin@soleen.com>,
        <weixugc@google.com>, <willy@infradead.org>,
        <yang.shi@linux.alibaba.com>, <ying.huang@intel.com>,
        <ziy@nvidia.com>
Subject: [PATCH 1/1] mm/migrate: de-duplicate migrate_reason strings
Date:   Tue, 21 Sep 2021 21:17:55 -0700
Message-ID: <20210922041755.141817-2-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210922041755.141817-1-jhubbard@nvidia.com>
References: <20210922041755.141817-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 34fa18d5-eee9-4133-5631-08d97d7ffc37
X-MS-TrafficTypeDiagnostic: MN2PR12MB3901:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3901E03236741806A1B9A20FA8A29@MN2PR12MB3901.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9nPnDEp94VuvgpyDTdI8Iog/AJrWc1PPLzmMY/zdjWB58OmdXOi4kSw1R1wIKBhtKVECszMDCm8By8PTdIm0c2oPoWH2Te6fcPk4Ev4X1Xk99w9FnYmVS0mFNiD+9R3HoSgGDju3SHHS7rgRYZKAkJ+AUidAbr3wCAsvG/4VWM6Zsl2rb1bXoYOWKVht3kZ7HawOjeFxMu0txVASbh48POzzH6t47C0gXW3Q0UToiFRJ2HK3S+HYyZ7A0e13DzgXw2Qi0+tlbFqyJCvQWYIYkjVxDlMawYnLh4BzdNFDOlTwBWp5yMXoacH3CmfvL0ftwU3aE0rGTypWHNo1Z7x93fEE/hYq6kPi/gBqVTEWiAlSTAAAmnruJQmHFy0ZzYJbVjRaUNHks/7C8lh8cIbOWBIsVuapaTIFA8L6crL9fhVYWHVSfGFlSamaqupqHugU/uMXvLDk+WTI3YjhZe2/39qOKPFXj89k/t+H0yAt2VAU6HYPYLWNWumVBxqLquqEwtXB+LtesN9I6vOfN1zhSfq68S0VNU9xzvp6j5dW9ycWUebp9dhfkHD7NDA1wU77xiUGmGY9g9UFvdQsri3MhnplgG4neSI24qQiJcZ7K7OBJcywICL3jo4USmZ7ybQoAdZu9UmCah22BsCegI7B1Fzz3RD2HZacuj9HpCJvQt7Ru0RglFAiTlY+gFozH0PGEXSMte/jxKSs/VAhKj6Ugg==
X-Forefront-Antispam-Report: CIP:216.228.112.36;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid05.nvidia.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(36756003)(1076003)(70586007)(7636003)(70206006)(356005)(83380400001)(508600001)(2616005)(36906005)(5660300002)(86362001)(7416002)(4326008)(107886003)(336012)(54906003)(47076005)(426003)(6916009)(186003)(2906002)(6666004)(316002)(82310400003)(8676002)(8936002)(26005)(36860700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2021 04:18:09.3780
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34fa18d5-eee9-4133-5631-08d97d7ffc37
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.36];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3901
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to remove the need to manually keep three different files in
synch, provide a common definition of the mapping between enum
migrate_reason, and the associated strings for each enum item.

1. Use the tracing system's mapping of enums to strings, by redefining
and reusing the MIGRATE_REASON and supporting macros, and using that to
populate the string array in mm/debug.c.

2. Move enum migrate_reason to migrate_mode.h. This is not strictly
necessary for this patch, but migrate mode and migrate reason go
together, so this will slightly clarify things.

Cc: Weizhao Ouyang <o451686892@gmail.com>
Cc: "Huang, Ying" <ying.huang@intel.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 include/linux/migrate.h      | 19 +------------------
 include/linux/migrate_mode.h | 13 +++++++++++++
 mm/debug.c                   | 20 +++++++++++---------
 3 files changed, 25 insertions(+), 27 deletions(-)

diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index c8077e936691..3d154fe03c96 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -19,24 +19,7 @@ struct migration_target_control;
  */
 #define MIGRATEPAGE_SUCCESS		0
 
-/*
- * Keep sync with:
- * - macro MIGRATE_REASON in include/trace/events/migrate.h
- * - migrate_reason_names[MR_TYPES] in mm/debug.c
- */
-enum migrate_reason {
-	MR_COMPACTION,
-	MR_MEMORY_FAILURE,
-	MR_MEMORY_HOTPLUG,
-	MR_SYSCALL,		/* also applies to cpusets */
-	MR_MEMPOLICY_MBIND,
-	MR_NUMA_MISPLACED,
-	MR_CONTIG_RANGE,
-	MR_LONGTERM_PIN,
-	MR_DEMOTION,
-	MR_TYPES
-};
-
+/* Defined in mm/debug.c: */
 extern const char *migrate_reason_names[MR_TYPES];
 
 #ifdef CONFIG_MIGRATION
diff --git a/include/linux/migrate_mode.h b/include/linux/migrate_mode.h
index 883c99249033..f37cc03f9369 100644
--- a/include/linux/migrate_mode.h
+++ b/include/linux/migrate_mode.h
@@ -19,4 +19,17 @@ enum migrate_mode {
 	MIGRATE_SYNC_NO_COPY,
 };
 
+enum migrate_reason {
+	MR_COMPACTION,
+	MR_MEMORY_FAILURE,
+	MR_MEMORY_HOTPLUG,
+	MR_SYSCALL,		/* also applies to cpusets */
+	MR_MEMPOLICY_MBIND,
+	MR_NUMA_MISPLACED,
+	MR_CONTIG_RANGE,
+	MR_LONGTERM_PIN,
+	MR_DEMOTION,
+	MR_TYPES
+};
+
 #endif		/* MIGRATE_MODE_H_INCLUDED */
diff --git a/mm/debug.c b/mm/debug.c
index fae0f81ad831..4333b6784a20 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -16,17 +16,19 @@
 #include <linux/ctype.h>
 
 #include "internal.h"
+#include <trace/events/migrate.h>
+
+/*
+ * Define EM() and EMe() so that MIGRATE_REASON from trace/events/migrate.h can
+ * be used to populate migrate_reason_names[].
+ */
+#undef EM
+#undef EMe
+#define EM(a, b)	b,
+#define EMe(a, b)	b
 
 const char *migrate_reason_names[MR_TYPES] = {
-	"compaction",
-	"memory_failure",
-	"memory_hotplug",
-	"syscall_or_cpuset",
-	"mempolicy_mbind",
-	"numa_misplaced",
-	"contig_range",
-	"longterm_pin",
-	"demotion",
+	MIGRATE_REASON
 };
 
 const struct trace_print_flags pageflag_names[] = {
-- 
2.33.0

