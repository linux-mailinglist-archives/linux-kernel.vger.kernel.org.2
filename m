Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF134502D9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 11:54:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbhKOK47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 05:56:59 -0500
Received: from mail-dm6nam11on2089.outbound.protection.outlook.com ([40.107.223.89]:23392
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230456AbhKOK4x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 05:56:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GezgegJgnPHCZC30WUu7GvrK93ipdHmpJ9J4HcaesjKDaEYf4ywPsTZuHdBvsfMWYGyRdqgkQvB71V2Cg4F3TfyxwmWWwKUeKXtIZmI7s0F6WCCnooUUnrHueHe/s8unyOdyBrUGOhAbKdZkwigKWEuLcl/PfJi9w1F1rUd/H8yjQ06+YQqqVQVB60LOvbyYWYocY4yAq1eQRlo7t9hdTw6ZZzo0ILxJ4Xj5QZ9rKQpfM8oY/Vq1RYMSConPj/ra0nosNt8WaYIetqHE2MluTWFDQgFWjQ1f3S4QWf/Bm/ycm/yI+juC6n6x6pGhR2HQCo/yF50I0NYpX7ZoAP4Wog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dLwqxG/s47Xe6cFir5h4g5HYZSsojzV4EsYzFkH/37k=;
 b=kPKz+OW70b//aqFujXVEWPk/GCLv+X6gmKcT8DdsVu9+nbC83I/Rz3KhtnSpfMLPM/2tmd+7sNCOy4Eqmz5VsLsbZBN1UqSU7o9BwL/eFfjN4myifFSAhiIh/QNjk9ISrJ5Xaon6QDKDX1MfyLlsj318ZmDsgcDI+kZDmxt2tUKxtNJncHIck5cVXapyplis03PSX2zd3jPjBdr+L6DIfImrmGisxrSbSezfKmMYzJ6x/sUlIjIoSH1zeJSz91RSBusJheGxIOmO2cK7Dg0OZ6CPazVnj8WDp+25+yxLrFhE8aZ+DaVyIiOf6rsQBfayBt4+yA2woii4SylvBE8DiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dLwqxG/s47Xe6cFir5h4g5HYZSsojzV4EsYzFkH/37k=;
 b=UeS0TTSgS6vkaf35yrzsvdH/N847wBo7UGPLsckqZ3/y7KMOBRdiS4iUbQhf7xeXkf3p8oRxT+BjPhbwxrGbOwZMKMJ1vGa6i3rpLc7pC+ytK6qy76UAMWHxbMfWoz73LnAp1DZxnfNG6UaxkM01vYfExnXvKY3Sh8J+u2Krj/qzFbB/gw5BCacQNoFvSfSVZ5Gn6Q5xspLb0TM3un4BXFIogg6eOqIdeMe1OeYVErfKrLZ1wGkVWJtxCs14l73FD/oIWFTHyzAiUG551MpAkNJCd/XRpr/EZXFC/nPsIrl5qg8hKAhe1wOOn801XTL9TW+EF+OSX0aKBKHq6lp2Ng==
Received: from BN9PR03CA0233.namprd03.prod.outlook.com (2603:10b6:408:f8::28)
 by BN8PR12MB2914.namprd12.prod.outlook.com (2603:10b6:408:95::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.16; Mon, 15 Nov
 2021 10:53:57 +0000
Received: from BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f8:cafe::79) by BN9PR03CA0233.outlook.office365.com
 (2603:10b6:408:f8::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13 via Frontend
 Transport; Mon, 15 Nov 2021 10:53:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT051.mail.protection.outlook.com (10.13.177.66) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4690.15 via Frontend Transport; Mon, 15 Nov 2021 10:53:55 +0000
Received: from localhost (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 15 Nov
 2021 10:53:54 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     <akpm@linux-foundation.org>
CC:     <willy@infradead.org>, <dhowells@redhat.com>, <hughd@google.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <jglisse@redhat.com>, <jgg@nvidia.com>, <rcampbell@nvidia.com>,
        <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>
Subject: [PATCH v3] mm/migrate.c: Rework migration_entry_wait() to not take a pageref
Date:   Mon, 15 Nov 2021 21:52:22 +1100
Message-ID: <20211115105222.4183286-1-apopple@nvidia.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0af29329-18bb-4913-e06f-08d9a82638e5
X-MS-TrafficTypeDiagnostic: BN8PR12MB2914:
X-Microsoft-Antispam-PRVS: <BN8PR12MB291414D7E894EBE0AC4BB1BEDF989@BN8PR12MB2914.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 55ntjEwDQc8ad5ZnY9GJFRKz9FK05acgu8eNC4UWM4nJcIunU1xPpgptdBmZy+diqNv6gpLkZlW1c7cSkx6xBRx0Tf4ndtu1rraYlIqrCfHxkJhMQY8/TmrZcTiQlUkzlYgOl0B69oF9tOMbXj+3ykru7gD6pi1KVJ5UF6N2tXSlhj7lvzqGH/lJN4KVzx5qrGr9xzHhw1Sit58nxgtql0t5SqzyiTU8PLAmNXYxZxh4s0MUVTLKM9ST8iL7NBLh0Og2xyxPMWV0+Z3neH6Oux8Ilq+KRkcs0FQaeQe/hKWT2At31eH7ji1YFL2qsdRl8QrGgsKGPZqd1x4g5NCDW6Qlo570jEsSI/It7WYqYu7/He7Q8mbcoAOC468lk4C6KEk+cM5g8d7+fPLGQNyDSb2cIT4+7JZyJbfrE+OEc452gQDhtmlTDhI8OM/KSwfKa3OoWkVRhxHIQq8vtotpuDGopdiGiygRZnvCbaLfLaV4IHYhCXDG3YJnJSurnFxc2tfrw1InOjxr47aAUg1MP9GBbbGuG5Ood9eZUdVsw/Qru9nqOCYu92W8gT69jVo2kFgVtnE9D4CK8lM3RvOyX97b+wPHZ+PPpyDQgh2bZlm5OH9w66GHVNCOfusNp2Wsroo6sL558bmJo3AjhpdYfNB5IAACoP++cbRhro3jJgcOKKjTWuRVdJSjdYYsFI+iKz2Yg+Xg2zFAEzdPXf5oEw==
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(70206006)(8936002)(6666004)(8676002)(47076005)(508600001)(16526019)(26005)(186003)(83380400001)(336012)(7636003)(54906003)(1076003)(4326008)(70586007)(5660300002)(356005)(6916009)(86362001)(426003)(82310400003)(36906005)(107886003)(36860700001)(36756003)(316002)(2616005)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2021 10:53:55.9852
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0af29329-18bb-4913-e06f-08d9a82638e5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2914
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

v3:
 - Fix a build issue for CONFIG_MMU=n by only building
   migration_entry_wait_on_locked() if CONFIG_MIGRATION=y

v2:
 - Rebase to master with folios
 - Avoid taking a pageref in pmd_migration_entry_wait() as well
---
 include/linux/migrate.h |  2 +
 mm/filemap.c            | 87 +++++++++++++++++++++++++++++++++++++++++
 mm/migrate.c            | 33 ++--------------
 3 files changed, 93 insertions(+), 29 deletions(-)

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
index daa0e23a6ee6..a812e110df9c 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1426,6 +1426,93 @@ static inline int folio_wait_bit_common(struct folio *folio, int bit_nr,
 	return wait->flags & WQ_FLAG_WOKEN ? 0 : -EINTR;
 }
 
+#ifdef CONFIG_MIGRATION
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

