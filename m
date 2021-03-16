Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8063733D123
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 10:50:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236342AbhCPJuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 05:50:12 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:59443 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236330AbhCPJtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 05:49:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1615888186; x=1647424186;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=Bdv4AWMzINQWXCqWNH2A+ni0wM6jP0NbcmnsluplFJ8=;
  b=WdJ9PsCKq85lDQRz3X386R+a8TPNS4aZrjNrCleZ9pm6C5bCYaEULi5/
   1Og1/qMMxN7ON5RELRuHBQPpbqfzqJnQ1T16y/jSpf0j8Gy+y1jwA9smL
   OI3934Kiyevpl/U7pLGszXo31p+Yv9Tv59IxnipJfcCVBFyxZB7Jw4dc5
   k=;
X-IronPort-AV: E=Sophos;i="5.81,251,1610409600"; 
   d="scan'208";a="97705161"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1d-2c665b5d.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 16 Mar 2021 09:49:38 +0000
Received: from EX13D31EUA001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-1d-2c665b5d.us-east-1.amazon.com (Postfix) with ESMTPS id D2C82A18A1;
        Tue, 16 Mar 2021 09:49:35 +0000 (UTC)
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.162.239) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 16 Mar 2021 09:49:31 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <akpm@linux-foundation.org>
CC:     <hughd@google.com>, <axelrasmussen@google.com>, <amit@kernel.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        SeongJae Park <sjpark@amazon.de>
Subject: [PATCH] mm/shmem: Enclose shmem_mcopy_atomic_pte() with 'CONFIG_USERFAULTFD'
Date:   Tue, 16 Mar 2021 10:49:10 +0100
Message-ID: <20210316094910.23827-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.239]
X-ClientProxiedBy: EX13D19UWA003.ant.amazon.com (10.43.160.170) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

Commit 49eeab03fa0a ("userfaultfd: support minor fault handling for
shmem") introduced shmem_mcopy_atomic_pte().  The function is declared
in 'userfaultfd_k.h' when 'CONFIG_USERFAULTFD' is defined, and defined
as 'BUG()' if the config is unset.  However, the definition of the
function in 'shmem.c' is not protected by the '#ifdef' macro.  As a
result, the build fails when the config is not set.  This commit fixes
the problem.

Fixes: 49eeab03fa0a ("userfaultfd: support minor fault handling for shmem")
Signed-off-by: SeongJae Park <sjpark@amazon.de>

cr https://code.amazon.com/reviews/CR-47204463
---
 mm/shmem.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/shmem.c b/mm/shmem.c
index 547df2b766f7..c0d3abefeb3f 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2359,6 +2359,7 @@ static struct inode *shmem_get_inode(struct super_block *sb, const struct inode
 	return inode;
 }
 
+#ifdef CONFIG_USERFAULTFD
 int shmem_mcopy_atomic_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
 			   struct vm_area_struct *dst_vma,
 			   unsigned long dst_addr, unsigned long src_addr,
@@ -2492,6 +2493,7 @@ int shmem_mcopy_atomic_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
 	shmem_inode_unacct_blocks(inode, 1);
 	goto out;
 }
+#endif
 
 #ifdef CONFIG_TMPFS
 static const struct inode_operations shmem_symlink_inode_operations;
-- 
2.17.1




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879



