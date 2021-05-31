Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F85139668F
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 19:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232516AbhEaRLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 13:11:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43376 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234505AbhEaRDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 13:03:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622480496;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gaHdrvpmmOVrjQevrTVT6eL2VxwhnkzNH+FVs8VrVxc=;
        b=Me9AdAqB8EVxzGhwZxgNPM/rxsvwhVhoD3d4LzLH1Ro5Wb0sT716SjrarHQdSMVXjkVXzK
        mHzKAu0cnOx4MTxKs3CKMAPpKZpQICP4pfprAr523JS0T4c4rxlkTbi3gDDx9uCnQTyh5y
        pQ+fH5wbyTdkCLzFDa2VhagPTBqM6YM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-wbFrSOZrOB-hJuQubl1WcQ-1; Mon, 31 May 2021 13:01:33 -0400
X-MC-Unique: wbFrSOZrOB-hJuQubl1WcQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1AB2E107ACC7;
        Mon, 31 May 2021 17:01:32 +0000 (UTC)
Received: from max.com (unknown [10.40.192.80])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6BE8A6062C;
        Mon, 31 May 2021 17:01:30 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>
Subject: [RFC 1/9] gfs2: Clean up the error handling in gfs2_page_mkwrite
Date:   Mon, 31 May 2021 19:01:15 +0200
Message-Id: <20210531170123.243771-2-agruenba@redhat.com>
In-Reply-To: <20210531170123.243771-1-agruenba@redhat.com>
References: <20210531170123.243771-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We're setting an error number so that block_page_mkwrite_return
translates it into the corresponding VM_FAULT_* code in several places,
but this is getting confusing, so set the VM_FAULT_* codes directly
instead.  (No change in functionality.)

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/file.c | 63 ++++++++++++++++++++++++++++++++------------------
 1 file changed, 40 insertions(+), 23 deletions(-)

diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index 8a35a0196b6d..0eb235728098 100644
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -427,22 +427,25 @@ static vm_fault_t gfs2_page_mkwrite(struct vm_fault *vmf)
 	struct gfs2_alloc_parms ap = { .aflags = 0, };
 	u64 offset = page_offset(page);
 	unsigned int data_blocks, ind_blocks, rblocks;
+	vm_fault_t ret = VM_FAULT_LOCKED;
 	struct gfs2_holder gh;
 	unsigned int length;
 	loff_t size;
-	int ret;
+	int err;
 
 	sb_start_pagefault(inode->i_sb);
 
 	gfs2_holder_init(ip->i_gl, LM_ST_EXCLUSIVE, 0, &gh);
-	ret = gfs2_glock_nq(&gh);
-	if (ret)
+	err = gfs2_glock_nq(&gh);
+	if (err) {
+		ret = block_page_mkwrite_return(err);
 		goto out_uninit;
+	}
 
 	/* Check page index against inode size */
 	size = i_size_read(inode);
 	if (offset >= size) {
-		ret = -EINVAL;
+		ret = VM_FAULT_SIGBUS;
 		goto out_unlock;
 	}
 
@@ -469,24 +472,30 @@ static vm_fault_t gfs2_page_mkwrite(struct vm_fault *vmf)
 	    !gfs2_write_alloc_required(ip, offset, length)) {
 		lock_page(page);
 		if (!PageUptodate(page) || page->mapping != inode->i_mapping) {
-			ret = -EAGAIN;
+			ret = VM_FAULT_NOPAGE;
 			unlock_page(page);
 		}
 		goto out_unlock;
 	}
 
-	ret = gfs2_rindex_update(sdp);
-	if (ret)
+	err = gfs2_rindex_update(sdp);
+	if (err) {
+		ret = block_page_mkwrite_return(err);
 		goto out_unlock;
+	}
 
 	gfs2_write_calc_reserv(ip, length, &data_blocks, &ind_blocks);
 	ap.target = data_blocks + ind_blocks;
-	ret = gfs2_quota_lock_check(ip, &ap);
-	if (ret)
+	err = gfs2_quota_lock_check(ip, &ap);
+	if (err) {
+		ret = block_page_mkwrite_return(err);
 		goto out_unlock;
-	ret = gfs2_inplace_reserve(ip, &ap);
-	if (ret)
+	}
+	err = gfs2_inplace_reserve(ip, &ap);
+	if (err) {
+		ret = block_page_mkwrite_return(err);
 		goto out_quota_unlock;
+	}
 
 	rblocks = RES_DINODE + ind_blocks;
 	if (gfs2_is_jdata(ip))
@@ -495,27 +504,35 @@ static vm_fault_t gfs2_page_mkwrite(struct vm_fault *vmf)
 		rblocks += RES_STATFS + RES_QUOTA;
 		rblocks += gfs2_rg_blocks(ip, data_blocks + ind_blocks);
 	}
-	ret = gfs2_trans_begin(sdp, rblocks, 0);
-	if (ret)
+	err = gfs2_trans_begin(sdp, rblocks, 0);
+	if (err) {
+		ret = block_page_mkwrite_return(err);
 		goto out_trans_fail;
+	}
 
 	lock_page(page);
-	ret = -EAGAIN;
 	/* If truncated, we must retry the operation, we may have raced
 	 * with the glock demotion code.
 	 */
-	if (!PageUptodate(page) || page->mapping != inode->i_mapping)
+	if (!PageUptodate(page) || page->mapping != inode->i_mapping) {
+		ret = VM_FAULT_NOPAGE;
 		goto out_trans_end;
+	}
 
 	/* Unstuff, if required, and allocate backing blocks for page */
-	ret = 0;
-	if (gfs2_is_stuffed(ip))
-		ret = gfs2_unstuff_dinode(ip, page);
-	if (ret == 0)
-		ret = gfs2_allocate_page_backing(page, length);
+	if (gfs2_is_stuffed(ip)) {
+		err = gfs2_unstuff_dinode(ip, page);
+		if (err) {
+			ret = block_page_mkwrite_return(err);
+			goto out_trans_end;
+		}
+	}
+	err = gfs2_allocate_page_backing(page, length);
+	if (err)
+		ret = block_page_mkwrite_return(err);
 
 out_trans_end:
-	if (ret)
+	if (ret != VM_FAULT_LOCKED)
 		unlock_page(page);
 	gfs2_trans_end(sdp);
 out_trans_fail:
@@ -526,12 +543,12 @@ static vm_fault_t gfs2_page_mkwrite(struct vm_fault *vmf)
 	gfs2_glock_dq(&gh);
 out_uninit:
 	gfs2_holder_uninit(&gh);
-	if (ret == 0) {
+	if (ret == VM_FAULT_LOCKED) {
 		set_page_dirty(page);
 		wait_for_stable_page(page);
 	}
 	sb_end_pagefault(inode->i_sb);
-	return block_page_mkwrite_return(ret);
+	return ret;
 }
 
 static vm_fault_t gfs2_fault(struct vm_fault *vmf)
-- 
2.26.3

