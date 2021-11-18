Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE95545527C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 03:08:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241412AbhKRCLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 21:11:48 -0500
Received: from mail-bn8nam12on2054.outbound.protection.outlook.com ([40.107.237.54]:23264
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241389AbhKRCLr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 21:11:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XC81dGNKS6On2hiLjBzPiQBQ1nvQQGlvDb7rJgxzDobIEe9DpSx5X/OF9rM+lRlkJoSRsSJENbmk4nhFAoZ+ZKAQ9nL5pZwqfS6IJjgtdui9bSklzwH89HLyKusvj0eq1flC07GEyOpuQccttoPPz+2R84OgDlIR2k7NQgjSbk6PYHHPOwddsljsBg3iwuf2Z9tKFqZgXx2l9EPWvo8V21Je6ApLB9dvj7HemD3yi3CmVYl544gpaeJvD4RFoMPdl6sqm2m2ECfhixsdlOo3g75YW9upPdUarB5S/r9ayeITCrmxfHR0wWhzAXdDjHa/DMqEpLhlYLM2woFD5bD3xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sV3hL+C1nkNmVYEaHAboYQB5PljHtwWQygkbY97sosc=;
 b=lg46zkwryCZI7wWKNTdvtnr8Dd9shI8EGhcwVOLOXmGUaNH8vIy8e9T7UmpZ3/qkKu0dig9ZkH1SVf36/9gGKgTLUDpxlKyS7q58aOmNpslMBfNVXW1mQOFzmoSksD+cWQoBb08uclJhShOEEVEvq7PXklMKI5rcuX/lTH/ikv9/E9P6kV0bRwak0nMIQh+NBAnQmFrccSYKtPLJawM7nJIkdyh6sROmH3BtWnb3C7Gz7YKrOHwB8Pf5oeN/jRTkmUXtYdtl6IFgxINSblK8y7vwl9n5PJAg43h5ZFrIND3ZU9fRXdAXLyVGxVD2WQ5HYfKS76PGAzCCF6fEFPp9HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sV3hL+C1nkNmVYEaHAboYQB5PljHtwWQygkbY97sosc=;
 b=IRjgnqskv/U78gskogzrykji5WQcYuMSO9d2hia55wIdlQF6lAwebjvCcHbCcFpPfgbPhQOK1aD8ch6TJEliZlobSYdIEyCexMRFwPC2M/T5IO2n8hsAUdxpAPPWd2QYfcyyyeu4BjvjUOwhK2b6hGgvXidEnSNh/4QuSe0T5OXlvV/Qqw8a/EiyHkQ/QadlgIdekbxRbLypAVqvQv62SDbxmF6Z/wwExGweMysT319EHnfQA6D3aX0nO+nn1uUwXQ1f+xHQQR/2NsIF5kRkamkdlL3PKNs+6DHXZo+T6TMtDrfOpD/oQ3c8gqiHcxhgbOD8vWcmOxIImgd8NyEf4Q==
Received: from BN9P221CA0022.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::14)
 by BN8PR12MB3106.namprd12.prod.outlook.com (2603:10b6:408:45::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26; Thu, 18 Nov
 2021 02:08:44 +0000
Received: from BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10a:cafe::4f) by BN9P221CA0022.outlook.office365.com
 (2603:10b6:408:10a::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend
 Transport; Thu, 18 Nov 2021 02:08:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT030.mail.protection.outlook.com (10.13.177.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4713.20 via Frontend Transport; Thu, 18 Nov 2021 02:08:44 +0000
Received: from localhost (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 18 Nov
 2021 02:08:42 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     <akpm@linux-foundation.org>
CC:     <willy@infradead.org>, <dhowells@redhat.com>, <hughd@google.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <jglisse@redhat.com>, <jgg@nvidia.com>, <rcampbell@nvidia.com>,
        <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>
Subject: [PATCH v4] mm/migrate.c: Rework migration_entry_wait() to not take a pageref
Date:   Thu, 18 Nov 2021 13:07:54 +1100
Message-ID: <20211118020754.954425-1-apopple@nvidia.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 88b962fe-cc76-4e30-4063-08d9aa3859a4
X-MS-TrafficTypeDiagnostic: BN8PR12MB3106:
X-Microsoft-Antispam-PRVS: <BN8PR12MB31069B39DF5BDA8D7EF63286DF9B9@BN8PR12MB3106.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g/d1JvXwQOv19+LlWNqMxgOHk2R9BbZHu5Ao4PvugrE/m9y4kjDfeWK0BTgc1QEniOOqO3x4dlGEuMUOZ2DYok1yrpeKBq7stOcQdnGw4vLQv31+lhFNORXf0LzFIsHK2hhKj1YAqZGpeDE1YMiZ/bmyMIfmsoXfe1/BM/HRLEtH7hK6GsMBu01KwiKNrTHGFZHdgK/5v+zK6AifCYhsxrro6dXWJXBMVLysXiW0oh1r9jRhZMmavfBztiYCeFawHuRB+kpfEn+M5HiNn1Rgh49mly6zEmHsE6Ev5SJCvaVyqGUn6cB5eWcU76NozdDdzW57lQ2zud+f0LBEdBwpOCsCSPBWywWN/dYShuxfN/Fk3IYb4IAyUFxu7lHYjgARRP6gX58FW2JJPtcelKGTo8amjw9Ap4BSBUVHf1F1VV8Jv41yeCoil2YTEcKDuhBQLwS1hvcG8k9hxyngciKKHYvXSOKT0xYKG5rW+L2uF13Yww7ZGlMmtknQcFr7Fvj1aguJEnp/vDOlXrtXTLkWwvjbcWhyJZnTGi2zMIyCamrBHYDi4c43+iQvnGRmwJ6t4BKwOG46abvO/LsOEYsa5e6gn9kwe+Jo3X/y9lkZLPyhyIvsyicskFK6e2ABPsvJq6Rzvx8fCLD/0vQEmZH4IcvW6CtxZnHUy7mmX/0W+5CC8OUFREZX1Tz2VjpbiyvFILUOrAqISp7jCQSH/eykeQ==
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(316002)(4326008)(36906005)(6916009)(107886003)(186003)(16526019)(5660300002)(82310400003)(7636003)(36860700001)(54906003)(83380400001)(2906002)(336012)(2616005)(6666004)(26005)(8936002)(86362001)(47076005)(356005)(36756003)(8676002)(70586007)(508600001)(70206006)(426003)(1076003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2021 02:08:44.6174
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88b962fe-cc76-4e30-4063-08d9aa3859a4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3106
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the FIXME in migrate_vma_check_page().

Before migrating a page migration code will take a reference and check
there are no unexpected page references, failing the migration if there
are. When a thread faults on a migration entry it will take a temporary
reference to the page to wait for the page to become unlocked signifying
the migration entry has been removed.

This reference is dropped just prior to waiting on the page lock,
however the extra reference can cause migration failures so it is
desirable to avoid taking it.

As migration code already has a reference to the migrating page an extra
reference to wait on PG_locked is unnecessary so long as the reference
can't be dropped whilst setting up the wait.

When faulting on a migration entry the ptl is taken to check the
migration entry. Removing a migration entry also requires the ptl, and
migration code won't drop its page reference until after the migration
entry has been removed. Therefore retaining the ptl of a migration entry
is sufficient to ensure the page has a reference. Reworking
migration_entry_wait() to hold the ptl until the wait setup is complete
means the extra page reference is no longer needed.

Signed-off-by: Alistair Popple <apopple@nvidia.com>

---

v4:
 - Fixed compiler warning
 - Updated comments/description missed during page -> folio rebase

v3:
 - Fix a build issue for CONFIG_MMU=n by only building
   migration_entry_wait_on_locked() if CONFIG_MIGRATION=y

v2:
 - Rebase to master with folios
 - Avoid taking a pageref in pmd_migration_entry_wait() as well
---
 include/linux/migrate.h |  2 +
 mm/filemap.c            | 88 +++++++++++++++++++++++++++++++++++++++++
 mm/migrate.c            | 33 ++--------------
 3 files changed, 94 insertions(+), 29 deletions(-)

diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index 4850cc5bf813..54579902ec9f 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -40,6 +40,8 @@ extern int migrate_huge_page_move_mapping(struct address_space *mapping,
 				  struct page *newpage, struct page *page);
 extern int migrate_page_move_mapping(struct address_space *mapping,
 		struct page *newpage, struct page *page, int extra_count);
+void migration_entry_wait_on_locked(struct folio *folio, pte_t *ptep,
+				spinlock_t *ptl);
 void folio_migrate_flags(struct folio *newfolio, struct folio *folio);
 void folio_migrate_copy(struct folio *newfolio, struct folio *folio);
 int folio_migrate_mapping(struct address_space *mapping,
diff --git a/mm/filemap.c b/mm/filemap.c
index daa0e23a6ee6..fa522f11e74d 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -41,6 +41,7 @@
 #include <linux/psi.h>
 #include <linux/ramfs.h>
 #include <linux/page_idle.h>
+#include <linux/migrate.h>
 #include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
 #include "internal.h"
@@ -1426,6 +1427,93 @@ static inline int folio_wait_bit_common(struct folio *folio, int bit_nr,
 	return wait->flags & WQ_FLAG_WOKEN ? 0 : -EINTR;
 }
 
+#ifdef CONFIG_MIGRATION
+/**
+ * migration_entry_wait_on_locked - Wait for a migration entry to be removed
+ * @folio: folio referenced by the migration entry.
+ * @ptep: mapped pte pointer. This function will return with the ptep unmapped.
+ * @ptl: already locked ptl. This function will drop the lock.
+ *
+ * Wait for a migration entry referencing the given page to be removed. This is
+ * equivalent to put_and_wait_on_page_locked(page, TASK_UNINTERRUPTIBLE) except
+ * this can be called without taking a reference on the page. Instead this
+ * should be called while holding the ptl for the migration entry referencing
+ * the page.
+ *
+ * Returns after unmapping and unlocking the pte/ptl with pte_unmap_unlock().
+ *
+ * This follows the same logic as wait_on_page_bit_common() so see the comments
+ * there.
+ */
+void migration_entry_wait_on_locked(struct folio *folio, pte_t *ptep,
+				spinlock_t *ptl)
+{
+	struct wait_page_queue wait_page;
+	wait_queue_entry_t *wait = &wait_page.wait;
+	bool thrashing = false;
+	bool delayacct = false;
+	unsigned long pflags;
+	wait_queue_head_t *q;
+
+	q = folio_waitqueue(folio);
+	if (!folio_test_uptodate(folio) && folio_test_workingset(folio)) {
+		if (!folio_test_swapbacked(folio)) {
+			delayacct_thrashing_start();
+			delayacct = true;
+		}
+		psi_memstall_enter(&pflags);
+		thrashing = true;
+	}
+
+	init_wait(wait);
+	wait->func = wake_page_function;
+	wait_page.folio = folio;
+	wait_page.bit_nr = PG_locked;
+	wait->flags = 0;
+
+	spin_lock_irq(&q->lock);
+	folio_set_waiters(folio);
+	if (!folio_trylock_flag(folio, PG_locked, wait))
+		__add_wait_queue_entry_tail(q, wait);
+	spin_unlock_irq(&q->lock);
+
+	/*
+	 * If a migration entry exists for the page the migration path must hold
+	 * a valid reference to the page, and it must take the ptl to remove the
+	 * migration entry. So the page is valid until the ptl is dropped.
+	 */
+	if (ptep)
+		pte_unmap_unlock(ptep, ptl);
+	else
+		spin_unlock(ptl);
+
+	for (;;) {
+		unsigned int flags;
+
+		set_current_state(TASK_UNINTERRUPTIBLE);
+
+		/* Loop until we've been woken or interrupted */
+		flags = smp_load_acquire(&wait->flags);
+		if (!(flags & WQ_FLAG_WOKEN)) {
+			if (signal_pending_state(TASK_UNINTERRUPTIBLE, current))
+				break;
+
+			io_schedule();
+			continue;
+		}
+		break;
+	}
+
+	finish_wait(q, wait);
+
+	if (thrashing) {
+		if (delayacct)
+			delayacct_thrashing_end();
+		psi_memstall_leave(&pflags);
+	}
+}
+#endif
+
 void folio_wait_bit(struct folio *folio, int bit_nr)
 {
 	folio_wait_bit_common(folio, bit_nr, TASK_UNINTERRUPTIBLE, SHARED);
diff --git a/mm/migrate.c b/mm/migrate.c
index cf25b00f03c8..8d29a7903f9e 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -305,15 +305,7 @@ void __migration_entry_wait(struct mm_struct *mm, pte_t *ptep,
 	page = pfn_swap_entry_to_page(entry);
 	page = compound_head(page);
 
-	/*
-	 * Once page cache replacement of page migration started, page_count
-	 * is zero; but we must not call put_and_wait_on_page_locked() without
-	 * a ref. Use get_page_unless_zero(), and just fault again if it fails.
-	 */
-	if (!get_page_unless_zero(page))
-		goto out;
-	pte_unmap_unlock(ptep, ptl);
-	put_and_wait_on_page_locked(page, TASK_UNINTERRUPTIBLE);
+	migration_entry_wait_on_locked(page_folio(page), ptep, ptl);
 	return;
 out:
 	pte_unmap_unlock(ptep, ptl);
@@ -344,10 +336,7 @@ void pmd_migration_entry_wait(struct mm_struct *mm, pmd_t *pmd)
 	if (!is_pmd_migration_entry(*pmd))
 		goto unlock;
 	page = pfn_swap_entry_to_page(pmd_to_swp_entry(*pmd));
-	if (!get_page_unless_zero(page))
-		goto unlock;
-	spin_unlock(ptl);
-	put_and_wait_on_page_locked(page, TASK_UNINTERRUPTIBLE);
+	migration_entry_wait_on_locked(page_folio(page), NULL, ptl);
 	return;
 unlock:
 	spin_unlock(ptl);
@@ -2484,22 +2473,8 @@ static bool migrate_vma_check_page(struct page *page)
 		return false;
 
 	/* Page from ZONE_DEVICE have one extra reference */
-	if (is_zone_device_page(page)) {
-		/*
-		 * Private page can never be pin as they have no valid pte and
-		 * GUP will fail for those. Yet if there is a pending migration
-		 * a thread might try to wait on the pte migration entry and
-		 * will bump the page reference count. Sadly there is no way to
-		 * differentiate a regular pin from migration wait. Hence to
-		 * avoid 2 racing thread trying to migrate back to CPU to enter
-		 * infinite loop (one stopping migration because the other is
-		 * waiting on pte migration entry). We always return true here.
-		 *
-		 * FIXME proper solution is to rework migration_entry_wait() so
-		 * it does not need to take a reference on page.
-		 */
-		return is_device_private_page(page);
-	}
+	if (is_zone_device_page(page))
+		extra++;
 
 	/* For file back page */
 	if (page_mapping(page))
-- 
2.30.2

