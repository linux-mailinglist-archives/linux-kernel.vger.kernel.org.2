Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2E1D39668E
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 19:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbhEaRKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 13:10:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50939 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232784AbhEaRDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 13:03:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622480503;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JcuatMd87L9fCdp8lwImF5akoS3qK1D+UhqbImbeNZA=;
        b=SW7qTAVmA/Q78gkmzgc8VfNl97lJvbHADQ+6K4gf7LrzCeMNdUDgxl1ZUx/TMQjSZrPff+
        61946s708DyrVDn528U5Sv0inx+rt2/DrJYisaNT0iOhptjrsTH+vvJIGwc1XW30qQ7+jJ
        QjRML3ZSxdRtLC+T/NMtzmMaXmbvbHo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-58-TuML07xeMH-2SmhghoKr7g-1; Mon, 31 May 2021 13:01:42 -0400
X-MC-Unique: TuML07xeMH-2SmhghoKr7g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BD5F1801B19;
        Mon, 31 May 2021 17:01:40 +0000 (UTC)
Received: from max.com (unknown [10.40.192.80])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1A33E5B4A0;
        Mon, 31 May 2021 17:01:38 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>
Subject: [RFC 4/9] gfs2: Fix mmap + page fault deadlocks (part 1)
Date:   Mon, 31 May 2021 19:01:18 +0200
Message-Id: <20210531170123.243771-5-agruenba@redhat.com>
In-Reply-To: <20210531170123.243771-1-agruenba@redhat.com>
References: <20210531170123.243771-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the buffer passed to a read or write system call is memory mapped
to the same file, a page fault can occur in filemap_fault.  In that
case, the task will already be holding the inode glock, and trying to
take the same lock again will result in a BUG in add_to_queue().

Fix that by recognizing the self-recursion case.  Either skip the lock
taking (when the glock is held in a compatible way), or fail the
operation.

Likewise, a request to un-share a copy-on-write page can *probably*
happen in similar situations, so treat the locking in gfs2_page_mkwrite
in the same way.

A future patch will handle these case more gracefully by retrying
operations instead of failing them, along with addressing more complex
deadlock scenarios.

Reported-by: Jan Kara <jack@suse.cz>
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/file.c | 40 ++++++++++++++++++++++++++++++----------
 1 file changed, 30 insertions(+), 10 deletions(-)

diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index 6d77743f11a4..7d88abb4629b 100644
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -423,6 +423,7 @@ static vm_fault_t gfs2_page_mkwrite(struct vm_fault *vmf)
 	struct page *page = vmf->page;
 	struct inode *inode = file_inode(vmf->vma->vm_file);
 	struct gfs2_inode *ip = GFS2_I(inode);
+	struct gfs2_holder *outer_gh = gfs2_glock_is_locked_by_me(ip->i_gl);
 	struct gfs2_sbd *sdp = GFS2_SB(inode);
 	struct gfs2_alloc_parms ap = { .aflags = 0, };
 	u64 offset = page_offset(page);
@@ -436,10 +437,18 @@ static vm_fault_t gfs2_page_mkwrite(struct vm_fault *vmf)
 	sb_start_pagefault(inode->i_sb);
 
 	gfs2_holder_init(ip->i_gl, LM_ST_EXCLUSIVE, 0, &gh);
-	err = gfs2_glock_nq(&gh);
-	if (err) {
-		ret = block_page_mkwrite_return(err);
-		goto out_uninit;
+	if (likely(!outer_gh)) {
+		err = gfs2_glock_nq(&gh);
+		if (err) {
+			ret = block_page_mkwrite_return(err);
+			goto out_uninit;
+		}
+	} else {
+		if (!gfs2_holder_is_compatible(outer_gh, LM_ST_EXCLUSIVE)) {
+			/* We could try to upgrade outer_gh here. */
+			ret = VM_FAULT_SIGBUS;
+			goto out_uninit;
+		}
 	}
 
 	/* Check page index against inode size */
@@ -540,7 +549,8 @@ static vm_fault_t gfs2_page_mkwrite(struct vm_fault *vmf)
 out_quota_unlock:
 	gfs2_quota_unlock(ip);
 out_unlock:
-	gfs2_glock_dq(&gh);
+	if (likely(!outer_gh))
+		gfs2_glock_dq(&gh);
 out_uninit:
 	gfs2_holder_uninit(&gh);
 	if (ret == VM_FAULT_LOCKED) {
@@ -555,6 +565,7 @@ static vm_fault_t gfs2_fault(struct vm_fault *vmf)
 {
 	struct inode *inode = file_inode(vmf->vma->vm_file);
 	struct gfs2_inode *ip = GFS2_I(inode);
+	struct gfs2_holder *outer_gh = gfs2_glock_is_locked_by_me(ip->i_gl);
 	struct gfs2_holder gh;
 	vm_fault_t ret;
 	u16 state;
@@ -562,13 +573,22 @@ static vm_fault_t gfs2_fault(struct vm_fault *vmf)
 
 	state = (vmf->flags & FAULT_FLAG_WRITE) ? LM_ST_EXCLUSIVE : LM_ST_SHARED;
 	gfs2_holder_init(ip->i_gl, state, 0, &gh);
-	err = gfs2_glock_nq(&gh);
-	if (err) {
-		ret = block_page_mkwrite_return(err);
-		goto out_uninit;
+	if (likely(!outer_gh)) {
+		err = gfs2_glock_nq(&gh);
+		if (err) {
+			ret = block_page_mkwrite_return(err);
+			goto out_uninit;
+		}
+	} else {
+		if (!gfs2_holder_is_compatible(outer_gh, state)) {
+			/* We could try to upgrade outer_gh here. */
+			ret = VM_FAULT_SIGBUS;
+			goto out_uninit;
+		}
 	}
 	ret = filemap_fault(vmf);
-	gfs2_glock_dq(&gh);
+	if (likely(!outer_gh))
+		gfs2_glock_dq(&gh);
 out_uninit:
 	gfs2_holder_uninit(&gh);
 	return ret;
-- 
2.26.3

