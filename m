Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2A8C356110
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 03:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348022AbhDGBxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 21:53:09 -0400
Received: from server.lespinasse.org ([63.205.204.226]:36601 "EHLO
        server.lespinasse.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347833AbhDGBvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 21:51:51 -0400
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-11-ed;
 t=1617759903; h=from : to : cc : subject : date : message-id :
 in-reply-to : references : mime-version : content-transfer-encoding :
 from; bh=2b40fHZOymmhGJxI0G3GGByTYESRQj8MqQXnbVkgf4k=;
 b=rXM4NzWSzWcgaoFSX84ZUtXtVSmb0ie4Dv/LeHHqXZgS+oSmJL5ZAZWqJxRFBNKpvDTpg
 /KFSj6xdLkApTLYDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-11-rsa; t=1617759903; h=from : to
 : cc : subject : date : message-id : in-reply-to : references :
 mime-version : content-transfer-encoding : from;
 bh=2b40fHZOymmhGJxI0G3GGByTYESRQj8MqQXnbVkgf4k=;
 b=E6lEMweRaJ8ikAuN3ggqOm/+deuwAvAe4/+tRAmlHrlqKXySUlRlCu4mnDsXMira74kqQ
 8QZkmrF5S2O6hHxn043dWyoXl1FkgpudzojALP7Fr/J+FQsR/a1Bq9ZafuU6i9afr9EhOXC
 Q/BIDlLVeje/Sd6UVGnP17Brbqh1c6PHPBbTxiWFAVICNivtw7Nj1qfKu4aEtzkKi3wWNX3
 eyfrL1t+Ac82SzSaY0g93MQ43iLQLa2ruFPUKGXDb1s81im1za7WVMUbqGQ4JJp2HjRGcJD
 xdYooB7fsmS6ZvdnMWfRTCRi226A6A8mLMHOLViq2SWrn32gTzX5x84wB82Q==
Received: from zeus.lespinasse.org (zeus.lespinasse.org [10.0.0.150])
        by server.lespinasse.org (Postfix) with ESMTPS id 4B721160565;
        Tue,  6 Apr 2021 18:45:03 -0700 (PDT)
Received: by zeus.lespinasse.org (Postfix, from userid 1000)
        id 3B94A19F31D; Tue,  6 Apr 2021 18:45:03 -0700 (PDT)
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
Subject: [RFC PATCH 31/37] ext4: implement speculative fault handling
Date:   Tue,  6 Apr 2021 18:44:56 -0700
Message-Id: <20210407014502.24091-32-michel@lespinasse.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210407014502.24091-1-michel@lespinasse.org>
References: <20210407014502.24091-1-michel@lespinasse.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We just need to make sure ext4_filemap_fault() doesn't block in the
speculative case as it is called with an rcu read lock held.

Signed-off-by: Michel Lespinasse <michel@lespinasse.org>
---
 fs/ext4/file.c  | 1 +
 fs/ext4/inode.c | 7 ++++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 194f5d00fa32..546b9d4aa9d7 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -742,6 +742,7 @@ static const struct vm_operations_struct ext4_file_vm_ops = {
 	.fault		= ext4_filemap_fault,
 	.map_pages	= filemap_map_pages,
 	.page_mkwrite   = ext4_page_mkwrite,
+	.speculative	= true,
 };
 
 static int ext4_file_mmap(struct file *file, struct vm_area_struct *vma)
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 0948a43f1b3d..370484403c71 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -6192,7 +6192,12 @@ vm_fault_t ext4_filemap_fault(struct vm_fault *vmf)
 	struct inode *inode = file_inode(vmf->vma->vm_file);
 	vm_fault_t ret;
 
-	down_read(&EXT4_I(inode)->i_mmap_sem);
+	if (vmf->flags & FAULT_FLAG_SPECULATIVE) {
+		if (!down_read_trylock(&EXT4_I(inode)->i_mmap_sem))
+			return VM_FAULT_RETRY;
+	} else {
+		down_read(&EXT4_I(inode)->i_mmap_sem);
+	}
 	ret = filemap_fault(vmf);
 	up_read(&EXT4_I(inode)->i_mmap_sem);
 
-- 
2.20.1

