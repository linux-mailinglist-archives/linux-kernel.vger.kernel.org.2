Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7032445195
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 11:34:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbhKDKg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 06:36:28 -0400
Received: from mail-mw2nam10on2071.outbound.protection.outlook.com ([40.107.94.71]:48769
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229809AbhKDKg1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 06:36:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ABMvJKmkW92mry0fWvhM7HsBxyN7ytROhbcrHBI/kZHIKqRD4WfA43HTgiwDaB9bW/SXEm7dxqxVRkDs4iSj/C8mfWDApHcznkIEQz7raNZbAyi46o5hlitv3MqDHoSyB9/3WrLIhsaLBGZRA+AoctVOWja0eBfxqAoVvKtALu1JnQ3I9GU6TdZVCpdL5sChtiF39lXX5MCE0JsxNWtP96ws+ECY25NlaUrrEQ+8J/q5bHvFzjeaILj9V6je6bH5iPLIvD/5ojlfuSpVP44SN5ltSRNsI0eqxBfuhDaY8RFQB2meWWx0cO4N2MfQYGDX6awxnFFhiHmafAQZmrPvJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TKa9i6uE4JOdaSAWu5popNl9tR3ilfrVa5IH2sMjgfA=;
 b=KHO1D+7y2kr4IDa67YUNbwCHlexs5qH0FDqjQe9fkwDaZgkmbmdihA2l2W6bCmHkDEoqgRclUUHMqWJhUkbOlHJAbpXviFqc8CsT5TEcpZUrUIK469WZXvQNw01najjlBtTto5c4GUfoRlo3br9vYY08rqHOihCj2NR3H0wHUeOVjghi2jq5dreYa8Ksu+31Eut0oU6obXq5ve42ENEpamavT9YrhJ6OhgNutYej+PyRm5MzVKicsUYaPZepvyOZEMFBPD1QpBm9veyBQjcnfeHMkflAu6RYucCwMak3agPAwxENqbU25F53V62zbTQmvy9aIm2j9DV2HRUL6d34SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TKa9i6uE4JOdaSAWu5popNl9tR3ilfrVa5IH2sMjgfA=;
 b=AY/Gt4MZElVDXTXktYmoT7h+6D6N5zKxmV7ZE4b/EL/PvySlHdcpVyarwM44xJIVr3E2zlYtMbUnHtBSV1OPfTJq0TXHv4EnTkPAxYEe5j0UIbDG8HRQ6xjxHvL9y7L37n/n/DUOY3P5W3Iu5ayyoMgNt9ntsViPuGFUPXI1wJ0Hqd/8psZuv6v7GbfhFyAIL14VbgSr05AEjSZRzDPRFbLKSYNKW+uPRYLJWc7MgPAlhZ2qQiDT6kzu3ETe1jUgzxJ/81wHsr8dTXkw+AJvY0v4mRutmyuvBbr5FzH3qZoFXlHghLzzR2vocSDfkAibQHhajHrnfG495ElEuIVpUw==
Received: from MW4PR04CA0217.namprd04.prod.outlook.com (2603:10b6:303:87::12)
 by MN2PR12MB4256.namprd12.prod.outlook.com (2603:10b6:208:1d2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10; Thu, 4 Nov
 2021 10:33:47 +0000
Received: from CO1NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::ef) by MW4PR04CA0217.outlook.office365.com
 (2603:10b6:303:87::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend
 Transport; Thu, 4 Nov 2021 10:33:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT004.mail.protection.outlook.com (10.13.175.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4669.10 via Frontend Transport; Thu, 4 Nov 2021 10:33:47 +0000
Received: from localhost (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 4 Nov
 2021 10:33:42 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     <akpm@linux-foundation.org>
CC:     <willy@infradead.org>, <dhowells@redhat.com>, <hughd@google.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <jglisse@redhat.com>, <jgg@nvidia.com>, <rcampbell@nvidia.com>,
        <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>
Subject: [PATCH] mm/migrate.c: Rework migration_entry_wait() to not take a pageref
Date:   Thu, 4 Nov 2021 21:33:38 +1100
Message-ID: <20211104103338.891258-1-apopple@nvidia.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 01638cfb-dc90-4d29-375b-08d99f7e958c
X-MS-TrafficTypeDiagnostic: MN2PR12MB4256:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4256F80C0B00E1712A0CE101DF8D9@MN2PR12MB4256.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H3andjl6/uEEX41V07ok4/goezhmaGZBWJ0+vgeg0Bbdt/GhQsxlv1GcbufLXX3lgEjfL3JIu2rJbRKu6bw0xKzFTagWncCRnXE6epstz6JBf1VRJ3do4+nwBvJWh7OzRfh+TEyavxHfgp05nLni7j6r40mkikmIrieskXE42UzEBuhweZPmQTu9/cUyAQ21wwepu8/H9Epf+QZK7FJbvxbwn9GmChuXjgMDb3jBU9iAkQTLoHzsGd96uF9K2rz4W9tAVjaQ5tVGlHuf7uVOB45Lv85ZYxS3V5b0apz+QAJL+0rjWrLpyezoA6YnRCX3CTAMVHXRwGMp0GQNOic+U7aBFZvdoPUHcjRs5BYhjwUoajX2BtKxH9cj8mMR6cBqgwyR4OpQkv9kCn9wEN2nhyOOV6wVWgPjmB+lLUpAQhlnxjElTdtBcpztBhFpXw0n48n5RiEyxzqneOd8Ax/tb3Rl9bnVC2J3tFyP0qfJ25BIZUTd/MaOEC+RCAP45TgGJX0Z3NpFYSrQyALOubEnYFAaB4G7K3TuX01Gz/ZPK/cFBfqRaN4kcJSrjcMr5SXOHpKX6YgkTa3JX+iFIM8iZ2qREBF52O7k7m1vMNbuiu8WW1qksNLaur/FZKjQQvGm6VjKfrbK8AEhHRFUxxZGe5ilutL/NHcLJJZGFTNcxJTRLTPU++knSzP7mEAlCjBxcRXg/Tm6CxgBOCcsv7pp1g==
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(82310400003)(54906003)(70586007)(26005)(86362001)(70206006)(356005)(107886003)(8676002)(47076005)(508600001)(6916009)(83380400001)(186003)(16526019)(2616005)(7636003)(36860700001)(5660300002)(316002)(36756003)(4326008)(1076003)(6666004)(336012)(2906002)(426003)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2021 10:33:47.1357
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01638cfb-dc90-4d29-375b-08d99f7e958c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4256
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
 include/linux/pagemap.h |  2 +
 mm/filemap.c            | 82 +++++++++++++++++++++++++++++++++++++++++
 mm/migrate.c            | 28 ++------------
 3 files changed, 87 insertions(+), 25 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index ed02aa522263..00e4cbde6ec5 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -696,6 +696,8 @@ static inline int wait_on_page_locked_killable(struct page *page)
 	return wait_on_page_bit_killable(compound_head(page), PG_locked);
 }
 
+void migration_entry_wait_on_locked(struct page *page, pte_t *ptep,
+				spinlock_t *ptl);
 int put_and_wait_on_page_locked(struct page *page, int state);
 void wait_on_page_writeback(struct page *page);
 int wait_on_page_writeback_killable(struct page *page);
diff --git a/mm/filemap.c b/mm/filemap.c
index d1458ecf2f51..53fa8f8576fd 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1356,6 +1356,88 @@ static inline int wait_on_page_bit_common(wait_queue_head_t *q,
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
+void migration_entry_wait_on_locked(struct page *page, pte_t *ptep,
+				spinlock_t *ptl)
+{
+	struct wait_page_queue wait_page;
+	wait_queue_entry_t *wait = &wait_page.wait;
+	bool thrashing = false;
+	bool delayacct = false;
+	unsigned long pflags;
+	wait_queue_head_t *q;
+
+	q = page_waitqueue(page);
+	if (!PageUptodate(page) && PageWorkingset(page)) {
+		if (!PageSwapBacked(page)) {
+			delayacct_thrashing_start();
+			delayacct = true;
+		}
+		psi_memstall_enter(&pflags);
+		thrashing = true;
+	}
+
+	init_wait(wait);
+	wait->func = wake_page_function;
+	wait_page.page = page;
+	wait_page.bit_nr = PG_locked;
+	wait->flags = 0;
+
+	spin_lock_irq(&q->lock);
+	SetPageWaiters(page);
+	if (!trylock_page_bit_common(page, PG_locked, wait))
+		__add_wait_queue_entry_tail(q, wait);
+	spin_unlock_irq(&q->lock);
+
+	/*
+	 * If a migration entry exists for the page the migration path must hold
+	 * a valid reference to the page, and it must take the ptl to remove the
+	 * migration entry. So the page is valid until the ptl is dropped.
+	 */
+	pte_unmap_unlock(ptep, ptl);
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
 void wait_on_page_bit(struct page *page, int bit_nr)
 {
 	wait_queue_head_t *q = page_waitqueue(page);
diff --git a/mm/migrate.c b/mm/migrate.c
index 7e240437e7d9..2218f65b01c4 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -304,15 +304,7 @@ void __migration_entry_wait(struct mm_struct *mm, pte_t *ptep,
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
+	migration_entry_wait_on_locked(page, ptep, ptl);
 	return;
 out:
 	pte_unmap_unlock(ptep, ptl);
@@ -2406,22 +2398,8 @@ static bool migrate_vma_check_page(struct page *page)
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

