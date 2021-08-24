Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EFAA3F559D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 04:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233655AbhHXCFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 22:05:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35917 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229742AbhHXCFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 22:05:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629770699;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=kmJ4Cp9OxOwl2BxLAFuB9E8EAUuqTy9HyIUcCks/28U=;
        b=QZXTNzyumFWWNyqHWWDhKOEPiCCvVFZElPIATcCnz/6d1BAUOOIPBt30mk7269RO0ysv0g
        JvGNZw7v0aV6RYgY9FvFWsjNCyGgxwKfk5Sa4e/sRDOs2yUTQg3erqRpWLOIyITKAY433W
        cYvSdST7+wWPiDUaT90czNKnPcI6f+A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-f-iUdOyCO9GzRnO_nOccLQ-1; Mon, 23 Aug 2021 22:04:57 -0400
X-MC-Unique: f-iUdOyCO9GzRnO_nOccLQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2A960107ACF5;
        Tue, 24 Aug 2021 02:04:56 +0000 (UTC)
Received: from madcap2.tricolour.com (unknown [10.3.128.14])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 251F15D6AD;
        Tue, 24 Aug 2021 02:04:45 +0000 (UTC)
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Richard Guy Briggs <rgb@redhat.com>, Jan Kara <jack@suse.cz>,
        Will Deacon <will@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Seiji Nishikawa <snishika@redhat.com>
Subject: [ghak-trim PATCH v1] audit: move put_tree() to avoid trim_trees refcount underflow and UAF
Date:   Mon, 23 Aug 2021 22:04:09 -0400
Message-Id: <caba6f2509ce8eedb6c904e9b0e13ca676bd7d61.1629770243.git.rgb@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AUDIT_TRIM is expected to be idempotent, but multiple executions resulted in a
refcount underflow and use-after-free.

git bisect fingered commit fb041bb7c0a918b95c6889fc965cdc4a75b4c0ca (2019-11)
	("locking/refcount: Consolidate implementations of refcount_t")
but this patch with its more thorough checking that wasn't in the x86 assembly
code merely exposed a previously existing tree refcount imbalance in the case
of tree trimming code that was refactored with prune_one() to remove a tree
introduced in commit 8432c70062978d9a57bde6715496d585ec520c3e (2018-11)
	("audit: Simplify locking around untag_chunk()")

Move the put_tree() to cover only the prune_one() case.

Passes audit-testsuite and 3 passes of "auditctl -t" with at least one
directory watch.

Fixes: 8432c7006297 ("audit: Simplify locking around untag_chunk()")
Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
Cc: Jan Kara <jack@suse.cz>
Cc: Will Deacon <will@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Seiji Nishikawa <snishika@redhat.com>
---
 kernel/audit_tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/audit_tree.c b/kernel/audit_tree.c
index b2be4e978ba3..2cd7b5694422 100644
--- a/kernel/audit_tree.c
+++ b/kernel/audit_tree.c
@@ -593,7 +593,6 @@ static void prune_tree_chunks(struct audit_tree *victim, bool tagged)
 		spin_lock(&hash_lock);
 	}
 	spin_unlock(&hash_lock);
-	put_tree(victim);
 }
 
 /*
@@ -602,6 +601,7 @@ static void prune_tree_chunks(struct audit_tree *victim, bool tagged)
 static void prune_one(struct audit_tree *victim)
 {
 	prune_tree_chunks(victim, false);
+	put_tree(victim);
 }
 
 /* trim the uncommitted chunks from tree */
-- 
2.27.0

