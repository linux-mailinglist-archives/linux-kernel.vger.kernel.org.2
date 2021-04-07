Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE02356116
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 03:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347839AbhDGBx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 21:53:29 -0400
Received: from server.lespinasse.org ([63.205.204.226]:50997 "EHLO
        server.lespinasse.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347841AbhDGBvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 21:51:53 -0400
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-11-ed;
 t=1617759903; h=from : to : cc : subject : date : message-id :
 in-reply-to : references : mime-version : content-transfer-encoding :
 from; bh=ju1TjADkBaEpCEmd9Uqz5VcWNno1/6nZtl53IX9hdVk=;
 b=/HgvOzN+4gZlXg2dAh/dfK0OJzmp3nnbAfpOyKVZoxCdy/rO8VsbHIDa7Q1uVsUm7LtGD
 bvH0KxRDERX19z8BQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-11-rsa; t=1617759903; h=from : to
 : cc : subject : date : message-id : in-reply-to : references :
 mime-version : content-transfer-encoding : from;
 bh=ju1TjADkBaEpCEmd9Uqz5VcWNno1/6nZtl53IX9hdVk=;
 b=Rcx14jUFCUpobMRsi8OfvXrqjWZOos2yAkHdBv79ZVxOdRacMFpS8AsU3XbW3uHcixZB0
 /TCi7hSxf0Z6Nynm7jE5MjAn5NeNb1Gn/QZTRkp0ETZkiK1cXV4QS0m13vSMNRHM11eblxb
 fSh42ACDbmP4crGwYQmmZGl0TyO87HVPSbgMucCnANko0TsXp7XbIRZ3sNlx2q7DSpjk7It
 9dUw6OVWwxnTC5OfRNzODM+M75isQYJRrL/a1oFedkln0KPu80bmhZro68EOOo0NyCF3V+t
 PBGZA0rAdIUXBGvMRZAqO246iJzXzfXJhxoSZCEnQRoaI+mhig14LMymHUZQ==
Received: from zeus.lespinasse.org (zeus.lespinasse.org [IPv6:fd00::150:0])
        by server.lespinasse.org (Postfix) with ESMTPS id 5048116064D;
        Tue,  6 Apr 2021 18:45:03 -0700 (PDT)
Received: by zeus.lespinasse.org (Postfix, from userid 1000)
        id 42E6D19F31E; Tue,  6 Apr 2021 18:45:03 -0700 (PDT)
From:   Michel Lespinasse <michel@lespinasse.org>
To:     Linux-MM <linux-mm@kvack.org>
Cc:     Laurent Dufour <ldufour@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Paul McKenney <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Rom Lemarchand <romlem@google.com>,
        Linux-Kernel <linux-kernel@vger.kernel.org>,
        Michel Lespinasse <michel@lespinasse.org>
Subject: [RFC PATCH 32/37] f2fs: implement speculative fault handling
Date:   Tue,  6 Apr 2021 18:44:57 -0700
Message-Id: <20210407014502.24091-33-michel@lespinasse.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210407014502.24091-1-michel@lespinasse.org>
References: <20210407014502.24091-1-michel@lespinasse.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We just need to make sure f2fs_filemap_fault() doesn't block in the
speculative case as it is called with an rcu read lock held.

Signed-off-by: Michel Lespinasse <michel@lespinasse.org>
---
 fs/f2fs/file.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index d26ff2ae3f5e..c1cfdc3ec98e 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -37,7 +37,12 @@ static vm_fault_t f2fs_filemap_fault(struct vm_fault *vmf)
 	struct inode *inode = file_inode(vmf->vma->vm_file);
 	vm_fault_t ret;
 
-	down_read(&F2FS_I(inode)->i_mmap_sem);
+	if (vmf->flags & FAULT_FLAG_SPECULATIVE) {
+		if (!down_read_trylock(&F2FS_I(inode)->i_mmap_sem))
+			return VM_FAULT_RETRY;
+	} else {
+		down_read(&F2FS_I(inode)->i_mmap_sem);
+	}
 	ret = filemap_fault(vmf);
 	up_read(&F2FS_I(inode)->i_mmap_sem);
 
@@ -171,6 +176,7 @@ static const struct vm_operations_struct f2fs_file_vm_ops = {
 	.fault		= f2fs_filemap_fault,
 	.map_pages	= filemap_map_pages,
 	.page_mkwrite	= f2fs_vm_page_mkwrite,
+	.speculative	= true,
 };
 
 static int get_parent_ino(struct inode *inode, nid_t *pino)
-- 
2.20.1

