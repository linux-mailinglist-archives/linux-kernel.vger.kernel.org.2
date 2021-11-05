Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDA654460A5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 09:28:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232712AbhKEIak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 04:30:40 -0400
Received: from mail-bn8nam12on2070.outbound.protection.outlook.com ([40.107.237.70]:50624
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232408AbhKEIai (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 04:30:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KCz2YIgLPmP3D9CJ3OdWmNSAkf5p+HCVdtaZKC9Q/89hKO9aBgKzDq9vm/pAhmw/IKcDLpdUQt/U0sBTRnH7SgCzzDVulZ3t0XImzJQWx7tUayCq0lL3rrxfTpvEaWQhKF80o8J2DKbzQbw8gtmxn6lPmXEHcMGfBMjwfevi/JvhHehj3+7E25uMPCHRl7mtBfe5haQSi5luTCXMIEltqcjQ0JNLX3fGqFpDZx+eRHEP0FG0KLiqNVHTrJ0iTVNSBdAIr5YAZ07pecWTDgnhI6SsAUVq0OrgNoZAzYpOY+isX52tGxDo3p9UaqYerxdUMxt8Fqhd8vcZ6MyDIB2IZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7vL1WJB9GFGAI+ae8MSx3UwYEEppsayqrnBit3sO9gI=;
 b=Ik2iA6c9LhH1U6Z2pM+zGtU4eQYtKj74LWT7mA/DRydR1kxTQ/nBkJNfhRv3lj6sAOPpBAVCEldl1Jxf92aqOy6t1PfkYfmbG6TsVPWEa+kPK0jg03Sf/c3Q943UyngnXhgwyrJXRgv8l7TeM7rRPw2f9P6Pcs486d1kWMOCrCrJTyHd1cwVHRDHcMZQaQqfgryAzMldCDFFOr+y8p3tNBeT1sWJ5oV59FBxgjO5nRM+6tVyFICnztmEKql6rNzfUCx+HgigJ6+HJuCWVsTAnu37SSTYj/4TuTx+YO0SznMkRwRClVHXRdCOmwCh0EA8es5m8ZHX6kfh4ZDDDCofWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7vL1WJB9GFGAI+ae8MSx3UwYEEppsayqrnBit3sO9gI=;
 b=BC/F9YlMheUdb4IoQ/CBpuHD8KalezPS8fq4F2fbBx04aaYbXDVeqCPymL4YjpvsiaMfCGgkIh1LLP0WI7Y+rztKaE7QcSXnVYn6pl3QSiDHwqFKjc2cSfVs1GYhw3e3UeejsDb163C5oCp20wvMgpleWJdkmeiL0P23GF7RcQLveZE/Qy5xMEQl5go+LDsrQcx2NJ/BlYQ3AxtPrSJT9eB8+UeOw61TqzVkJBmlF8MVE7W7AUn830NeZA7ZuZHJLhnKPhHb/W9H1ouFwcc8Lzpt0/o2vnBC473azmhqYO7CKmtlz2MurDR/1cZnIKXAnEem3i1XmwUqCEA7VUK5hw==
Received: from BN0PR04CA0180.namprd04.prod.outlook.com (2603:10b6:408:eb::35)
 by CH2PR12MB4295.namprd12.prod.outlook.com (2603:10b6:610:a7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Fri, 5 Nov
 2021 08:27:57 +0000
Received: from BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:eb:cafe::ac) by BN0PR04CA0180.outlook.office365.com
 (2603:10b6:408:eb::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10 via Frontend
 Transport; Fri, 5 Nov 2021 08:27:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT040.mail.protection.outlook.com (10.13.177.166) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4669.10 via Frontend Transport; Fri, 5 Nov 2021 08:27:56 +0000
Received: from localhost (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Fri, 5 Nov
 2021 08:27:09 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     <akpm@linux-foundation.org>
CC:     <willy@infradead.org>, <dhowells@redhat.com>, <hughd@google.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <jglisse@redhat.com>, <jgg@nvidia.com>, <rcampbell@nvidia.com>,
        <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>
Subject: [PATCH v2] mm/migrate.c: Rework migration_entry_wait() to not take a pageref
Date:   Fri, 5 Nov 2021 19:26:21 +1100
Message-ID: <20211105082621.1586993-1-apopple@nvidia.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5ee99873-9a36-43f1-7365-08d9a0362bb1
X-MS-TrafficTypeDiagnostic: CH2PR12MB4295:
X-Microsoft-Antispam-PRVS: <CH2PR12MB4295AF2581633481758BE651DF8E9@CH2PR12MB4295.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7nGFxKxjuQaxIi8nQWRqrhOQMTAJ92CiJYR7033TJXuG2AgU8S6KNPwT4OzGwABudq1wgs1e9oducD48N9yU/bhUItXiZvCwfzIxpoWtnl8EOmyKgKP9gVIvO5gH53h1WY6I0b8NAGqglwOzDaW70OfvjYbAWmUqtgl2G/BnZUyNb2X1lgl8aqZUuaAfmR8y06WUPpX+vwrbmdcefT/ErC9ojhIx0Gt1H8furKfXHN9fjsFhTzhnjxMuyB2eBhM5zJMGO1uaqLj/Ogrp66HOm2j/x4qELlr5R52bkf81DLITmYQrEdEwhI7syVq7l4k9RxmwH2hSnHg0LMoMFBsHtq49WiG5z34iyd7biIabAefap3UDjMe81Sj70/bpX4jW2gjhxly8NWmJCqGrxm53e86yXE50D6RnxQbxbcZaETFU1hw3VOqdgi4ruq7WPod14F/HRDzqeJSFiQcTcgUYIncZl3hYLZY16eAaFSA/vwtu+B4pl4PsrDwUBxRvnGA/G2bj5HLF+U2KmqKkly4VAhrXhpRY5u/64psJ0ac2JWwRyWETqVYKRO/Ersq6XOjXqU/Tx48lfbMiwSq7ocMKT4KBYGejrWdnwGDjSN+NUR5OhGVmbnwVhlHhgzGIPZuhxGYY6Eu7NBxRIeVWGDJKr5F5MEeWoW7e5tAqJ27e0B9lQ/e3Gmk7ki8NvKlydrBIf1agIJZqe+aC2S519ZpDHA==
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(16526019)(508600001)(70206006)(70586007)(186003)(4326008)(82310400003)(26005)(5660300002)(86362001)(107886003)(7636003)(2906002)(426003)(36906005)(54906003)(6666004)(47076005)(336012)(316002)(6916009)(2616005)(8676002)(83380400001)(1076003)(36756003)(356005)(36860700001)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2021 08:27:56.9024
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ee99873-9a36-43f1-7365-08d9a0362bb1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4295
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes a FIXME in migrate_vma_check_page().

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

Trying to refactor some of folio_wait_bit_common() into common functions
didn't seem to end up making things simpler so I've left it as a manual
inline into migration_entry_wait_on_locked() for now.

The only change needed to folio_wait_bit_common() is a behaviour that
replaces folio_put() with pte_unmap_unlock(). I think adding the extra two
arguments (ptep and ptl) to folio_wait_bit_common() is a bit messy, however
it's borderline and I could go either way so happy to do that if others
disagree.

v2:
 - Rebase to master with folios
 - Avoid taking a pageref in pmd_migration_entry_wait() as well

---
 include/linux/pagemap.h |  2 +
 mm/filemap.c            | 85 +++++++++++++++++++++++++++++++++++++++++
 mm/migrate.c            | 33 ++--------------
 3 files changed, 91 insertions(+), 29 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index db2c3e3eb1cf..b5a3cf4ab143 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -769,6 +769,8 @@ static inline int wait_on_page_locked_killable(struct page *page)
 	return folio_wait_locked_killable(page_folio(page));
 }
 
+void migration_entry_wait_on_locked(struct folio *folio, pte_t *ptep,
+				spinlock_t *ptl);
 int put_and_wait_on_page_locked(struct page *page, int state);
 void wait_on_page_writeback(struct page *page);
 void folio_wait_writeback(struct folio *folio);
diff --git a/mm/filemap.c b/mm/filemap.c
index bfcef6ff7a27..68302ebcc310 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1411,6 +1411,91 @@ static inline int folio_wait_bit_common(struct folio *folio, int bit_nr,
 	return wait->flags & WQ_FLAG_WOKEN ? 0 : -EINTR;
 }
 
+/**
+ * migration_entry_wait_on_locked - Wait for a migration entry to be removed
+ * @page: page referenced by the migration entry.
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
+
 void folio_wait_bit(struct folio *folio, int bit_nr)
 {
 	folio_wait_bit_common(folio, bit_nr, TASK_UNINTERRUPTIBLE, SHARED);
diff --git a/mm/migrate.c b/mm/migrate.c
index efa9941ebe03..098f0f87b919 100644
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
@@ -2488,22 +2477,8 @@ static bool migrate_vma_check_page(struct page *page)
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

