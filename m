Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 821C23D2B54
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 19:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbhGVRD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 13:03:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:56346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229514AbhGVRDy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 13:03:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AEB5061001;
        Thu, 22 Jul 2021 17:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626975869;
        bh=+1VtaWnpu+/vg0Zu7lXitOvQJPQ5sE29/Tcbn/mDaJw=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=u9loRPsvhcfjzmctIAYBGzicMdiPmZqpfANrWNV1BIb+tJZ1mV4+NfLphNTnNOjFw
         0fYVzaBKoTyQQdm1nepJPpgg1xgGlAEim3ygYRtMdpm4LC47XBlBlKHkpWkurwviqD
         iWfDT6PVBKnQz5kIaf5V0fuLFxoV9JQl15oyGAMA0VtnzCoBsjsZWVFqoS/dYDERT7
         cE0XlVtO7R9hpOf7hNdIddYQsD9t1tsA/djWeL7ANoy0SEnSlbyvBpWhuB/AwiRPjW
         Zfe5RBXrWFHJ0ngUsedMe0z6+sQS7Q5shV+pn1bs2Vwc+s0N37xXeNfg68L3eb6imB
         eTNrgs0SpkPUw==
Date:   Thu, 22 Jul 2021 10:44:28 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v2] f2fs: don't sleep while grabing nat_tree_lock
Message-ID: <YPmufPvn9FJXfcip@google.com>
References: <20210722014149.525166-1-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210722014149.525166-1-jaegeuk@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This tries to fix priority inversion in the below condition resulting in
long checkpoint delay.

f2fs_get_node_info()
 - nat_tree_lock
  -> sleep to grab journal_rwsem by contention

                                     checkpoint
                                     - waiting for nat_tree_lock

In order to let checkpoint go, let's release nat_tree_lock, if there's a
journal_rwsem contention.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 Change log from v1:
  - drop rwlock but take retry logic to reduce lock-holding time

 fs/f2fs/node.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 0be9e2d7120e..c60ba4179bb2 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -552,7 +552,7 @@ int f2fs_get_node_info(struct f2fs_sb_info *sbi, nid_t nid,
 	int i;
 
 	ni->nid = nid;
-
+retry:
 	/* Check nat cache */
 	down_read(&nm_i->nat_tree_lock);
 	e = __lookup_nat_cache(nm_i, nid);
@@ -564,10 +564,16 @@ int f2fs_get_node_info(struct f2fs_sb_info *sbi, nid_t nid,
 		return 0;
 	}
 
-	memset(&ne, 0, sizeof(struct f2fs_nat_entry));
+	/*
+	 * Check current segment summary by trying to grab journal_rwsem first.
+	 * This sem is on the critical path on the checkpoint requiring the above
+	 * nat_tree_lock. Therefore, we should retry, if we failed to grab here.
+	 */
+	if (!down_read_trylock(&curseg->journal_rwsem)) {
+		up_read(&nm_i->nat_tree_lock);
+		goto retry;
+	}
 
-	/* Check current segment summary */
-	down_read(&curseg->journal_rwsem);
 	i = f2fs_lookup_journal_in_cursum(journal, NAT_JOURNAL, nid, 0);
 	if (i >= 0) {
 		ne = nat_in_journal(journal, i);
-- 
2.32.0.432.gabb21c7263-goog

