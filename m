Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAA3833D7CF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 16:40:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbhCPPkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 11:40:17 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:52656 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbhCPPkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 11:40:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1615909201; x=1647445201;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=KqzASXGhrTuQ3KDFC8H+v0fbPkS9czuEH52WiGTsxDU=;
  b=lcGNSFbl+vPjuht6ALtz3D3bUg/G0DZBAlLicWe+SeV96+8/en9+4Mq0
   XHXjrfoNF5T9lc8vhsF8Xx6sS2lH6NDs1hlqYLeeZypzIyMvjNk8MjgsY
   4kiCYkmFesGYGA9ehTVOrLpSGWkRIw1TXyHXr2lFn33X8UFx/Rx4Os50U
   Y=;
X-IronPort-AV: E=Sophos;i="5.81,251,1610409600"; 
   d="scan'208";a="120908366"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1a-67b371d8.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 16 Mar 2021 15:39:54 +0000
Received: from EX13D31EUA001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-1a-67b371d8.us-east-1.amazon.com (Postfix) with ESMTPS id 15EF9A1EC3;
        Tue, 16 Mar 2021 15:39:51 +0000 (UTC)
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.162.213) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 16 Mar 2021 15:39:47 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <akpm@linux-foundation.org>
CC:     <hughd@google.com>, <axelrasmussen@google.com>, <amit@kernel.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        SeongJae Park <sjpark@amazon.de>
Subject: [PATCH v2] mm/shmem: Enclose shmem_mcopy_atomic_pte() with 'CONFIG_USERFAULTFD'
Date:   Tue, 16 Mar 2021 16:39:30 +0100
Message-ID: <20210316153930.29827-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210316094910.23827-1-sjpark@amazon.com>
References: <20210316094910.23827-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.213]
X-ClientProxiedBy: EX13D40UWA003.ant.amazon.com (10.43.160.29) To
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
---

Changes from v1
- Remove unnecessary internal code review URL

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



