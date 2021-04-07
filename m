Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 311C035610F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 03:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243027AbhDGBxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 21:53:03 -0400
Received: from server.lespinasse.org ([63.205.204.226]:51811 "EHLO
        server.lespinasse.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347832AbhDGBvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 21:51:51 -0400
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-11-ed;
 t=1617759903; h=from : to : cc : subject : date : message-id :
 in-reply-to : references : mime-version : content-transfer-encoding :
 from; bh=VhmmiWl9tNNsyaupBkysTD3lPGnrlR57ucyCgOq4BOY=;
 b=R8Xr3EA9fRzTQ5E7xJ3qTkjA4Fwi0FWi+flPvc3/ZT6JmH9ecOXHL6K3KPSeyNY0xgklD
 XN0oTjWBXkv5ndiDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-11-rsa; t=1617759903; h=from : to
 : cc : subject : date : message-id : in-reply-to : references :
 mime-version : content-transfer-encoding : from;
 bh=VhmmiWl9tNNsyaupBkysTD3lPGnrlR57ucyCgOq4BOY=;
 b=ehDI2OUmefmW+R59iI9a+gz+Lhtzi+v/Tw6YpiAyesjZ+F8w8BC+0MdbGiUlJxQE3JVB2
 S/bICvdAoX/UzTViHaMGpYaHFbslTfPYlB/eUpSOGs3WUstZ9I/SO8ktT5Q9qKrgLXkzaWs
 NE0zT6JBjV/EmRjAXMMj2r0152f4F9ruuwOwGMUqBPwtohhiKGb2NRJIMlIA50ZKDw/yjYj
 tiC23Y4IEei9FBG+ZSz2PG4SY9SQdXAmzE9IuiQsciMJRCnxVO3k/TfawOvAtzCzHJVfYsP
 k7mCPPMT2uCiGlkhSASBWUk7K3HNi9R/opVjU+DbRN3FOdDL6eNhg6VddV8Q==
Received: from zeus.lespinasse.org (zeus.lespinasse.org [IPv6:fd00::150:0])
        by server.lespinasse.org (Postfix) with ESMTPS id 3BCCA160555;
        Tue,  6 Apr 2021 18:45:03 -0700 (PDT)
Received: by zeus.lespinasse.org (Postfix, from userid 1000)
        id 2DD8119F31E; Tue,  6 Apr 2021 18:45:03 -0700 (PDT)
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
Subject: [RFC PATCH 29/37] fs: list file types that support speculative faults.
Date:   Tue,  6 Apr 2021 18:44:54 -0700
Message-Id: <20210407014502.24091-30-michel@lespinasse.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210407014502.24091-1-michel@lespinasse.org>
References: <20210407014502.24091-1-michel@lespinasse.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a speculative field to the vm_operations_struct, which indicates if
the associated file type supports speculative faults.

Initially this is set for files that implement fault() with filemap_fault().

Signed-off-by: Michel Lespinasse <michel@lespinasse.org>
---
 fs/btrfs/file.c    | 1 +
 fs/cifs/file.c     | 1 +
 fs/fuse/file.c     | 1 +
 fs/nfs/file.c      | 1 +
 fs/ubifs/file.c    | 1 +
 fs/vboxsf/file.c   | 1 +
 include/linux/mm.h | 7 +++++++
 mm/filemap.c       | 1 +
 8 files changed, 14 insertions(+)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 0e155f013839..b31851271e51 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2293,6 +2293,7 @@ static const struct vm_operations_struct btrfs_file_vm_ops = {
 	.fault		= filemap_fault,
 	.map_pages	= filemap_map_pages,
 	.page_mkwrite	= btrfs_page_mkwrite,
+	.speculative	= true,
 };
 
 static int btrfs_file_mmap(struct file	*filp, struct vm_area_struct *vma)
diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index 042e24aad410..a0d5fbb25c62 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -4116,6 +4116,7 @@ static const struct vm_operations_struct cifs_file_vm_ops = {
 	.fault = filemap_fault,
 	.map_pages = filemap_map_pages,
 	.page_mkwrite = cifs_page_mkwrite,
+	.speculative = true,
 };
 
 int cifs_file_strict_mmap(struct file *file, struct vm_area_struct *vma)
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 8cccecb55fb8..c4874240d157 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2354,6 +2354,7 @@ static const struct vm_operations_struct fuse_file_vm_ops = {
 	.fault		= filemap_fault,
 	.map_pages	= filemap_map_pages,
 	.page_mkwrite	= fuse_page_mkwrite,
+	.speculative	= true,
 };
 
 static int fuse_file_mmap(struct file *file, struct vm_area_struct *vma)
diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 16ad5050e046..e653c6bc23ca 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -588,6 +588,7 @@ static const struct vm_operations_struct nfs_file_vm_ops = {
 	.fault = filemap_fault,
 	.map_pages = filemap_map_pages,
 	.page_mkwrite = nfs_vm_page_mkwrite,
+	.speculative = true,
 };
 
 static int nfs_need_check_write(struct file *filp, struct inode *inode,
diff --git a/fs/ubifs/file.c b/fs/ubifs/file.c
index 0e4b4be3aa26..3d97f1c3e9c7 100644
--- a/fs/ubifs/file.c
+++ b/fs/ubifs/file.c
@@ -1598,6 +1598,7 @@ static const struct vm_operations_struct ubifs_file_vm_ops = {
 	.fault        = filemap_fault,
 	.map_pages = filemap_map_pages,
 	.page_mkwrite = ubifs_vm_page_mkwrite,
+	.speculative = true,
 };
 
 static int ubifs_file_mmap(struct file *file, struct vm_area_struct *vma)
diff --git a/fs/vboxsf/file.c b/fs/vboxsf/file.c
index c4ab5996d97a..e0a6a3af9cb9 100644
--- a/fs/vboxsf/file.c
+++ b/fs/vboxsf/file.c
@@ -146,6 +146,7 @@ static const struct vm_operations_struct vboxsf_file_vm_ops = {
 	.close		= vboxsf_vma_close,
 	.fault		= filemap_fault,
 	.map_pages	= filemap_map_pages,
+	.speculative	= true,
 };
 
 static int vboxsf_file_mmap(struct file *file, struct vm_area_struct *vma)
diff --git a/include/linux/mm.h b/include/linux/mm.h
index f26490aff514..b4c0c10e434e 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -641,6 +641,13 @@ struct vm_operations_struct {
 	 */
 	struct page *(*find_special_page)(struct vm_area_struct *vma,
 					  unsigned long addr);
+	/*
+	 * speculative indicates that the vm_operations support
+	 * speculative page faults. This allows ->fault and ->map_pages
+	 * to be called with FAULT_FLAG_SPECULATIVE set; such calls will
+	 * run within an rcu read locked section and with mmap lock not held.
+	 */
+	bool speculative;
 };
 
 static inline void vma_init(struct vm_area_struct *vma, struct mm_struct *mm)
diff --git a/mm/filemap.c b/mm/filemap.c
index d496771749e6..b83040c672d3 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3226,6 +3226,7 @@ const struct vm_operations_struct generic_file_vm_ops = {
 	.fault		= filemap_fault,
 	.map_pages	= filemap_map_pages,
 	.page_mkwrite	= filemap_page_mkwrite,
+	.speculative	= true,
 };
 
 /* This is used for a general mmap of a disk file */
-- 
2.20.1

