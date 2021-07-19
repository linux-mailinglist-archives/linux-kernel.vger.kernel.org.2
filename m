Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9C53CCCA0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 05:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234367AbhGSD1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jul 2021 23:27:52 -0400
Received: from zg8tmty1ljiyny4xntqumjca.icoremail.net ([165.227.154.27]:44404
        "HELO zg8tmty1ljiyny4xntqumjca.icoremail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S234340AbhGSD1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jul 2021 23:27:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fudan.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id; bh=Df5XTAlCuaJdQ6rGXjlHYuHZujtmZHEWENW51vx74yQ=; b=L
        u1TjSxvwo3Xp30o9DHDHtbudKkg4e7tQ5xAw9DkS2+Swcxb65F/97+q7ZOc3dTv/
        VuFurayagSaadDZ01pU5gD3PwffuxBeGyGyy5sV8SXHTcd3B58wzdoq4XVTWkHJA
        /qZvBaYzR9oBSKsNnvsvGHWmfMEoT7Bytn67nmdZe0=
Received: from localhost.localdomain (unknown [10.162.86.133])
        by app1 (Coremail) with SMTP id XAUFCgC3l2hr8PRg5ySIAA--.467S3;
        Mon, 19 Jul 2021 11:24:28 +0800 (CST)
From:   Xiyu Yang <xiyuyang19@fudan.edu.cn>
To:     Anton Altaparmakov <anton@tuxera.com>,
        linux-ntfs-dev@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc:     yuanxzhang@fudan.edu.cn, Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Xin Tan <tanxin.ctf@gmail.com>
Subject: [PATCH] ntfs: Convert from atomic_t to refcount_t on _ntfs_inode->count
Date:   Mon, 19 Jul 2021 11:24:24 +0800
Message-Id: <1626665064-49175-1-git-send-email-xiyuyang19@fudan.edu.cn>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: XAUFCgC3l2hr8PRg5ySIAA--.467S3
X-Coremail-Antispam: 1UD129KBjvJXoW3WF1rGF4fKFykAF1UGF1rWFg_yoW3tF4UpF
        nFkrW7Kws3Xr92kr93ta1DXryYkFy0kF4xWw1akF1xJ3Zaqw1Yqa1FyFy8urWxXFW5Aa4F
        vF4j9rW2va4UXFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvS14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
        F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r
        4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
        648v4I1lc2xSY4AK6svPMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI
        8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AK
        xVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI
        8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Gr0_Zr1lIxAIcVC2z280
        aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43
        ZEXa7VU1c4S5UUUUU==
X-CM-SenderInfo: irzsiiysuqikmy6i3vldqovvfxof0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

refcount_t type and corresponding API can protect refcounters from
accidental underflow and overflow and further use-after-free situations.

Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
---
 fs/ntfs/aops.c  |  2 +-
 fs/ntfs/inode.c |  6 +++---
 fs/ntfs/inode.h |  3 ++-
 fs/ntfs/mft.c   | 36 ++++++++++++++++++------------------
 4 files changed, 24 insertions(+), 23 deletions(-)

diff --git a/fs/ntfs/aops.c b/fs/ntfs/aops.c
index bb0a43860ad2..d52e8b821be4 100644
--- a/fs/ntfs/aops.c
+++ b/fs/ntfs/aops.c
@@ -1272,7 +1272,7 @@ static int ntfs_write_mst_block(struct page *page,
 				tni == base_tni ? "base" : "extent",
 				tni->mft_no);
 		mutex_unlock(&tni->mrec_lock);
-		atomic_dec(&tni->count);
+		refcount_dec(&tni->count);
 		iput(VFS_I(base_tni));
 	}
 	SetPageUptodate(page);
diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
index 4474adb393ca..ee9ac65a4f47 100644
--- a/fs/ntfs/inode.c
+++ b/fs/ntfs/inode.c
@@ -342,7 +342,7 @@ static void ntfs_destroy_extent_inode(ntfs_inode *ni)
 {
 	ntfs_debug("Entering.");
 	BUG_ON(ni->page);
-	if (!atomic_dec_and_test(&ni->count))
+	if (!refcount_dec_and_test(&ni->count))
 		BUG();
 	kmem_cache_free(ntfs_inode_cache, ni);
 }
@@ -371,7 +371,7 @@ void __ntfs_init_inode(struct super_block *sb, ntfs_inode *ni)
 	rwlock_init(&ni->size_lock);
 	ni->initialized_size = ni->allocated_size = 0;
 	ni->seq_no = 0;
-	atomic_set(&ni->count, 1);
+	refcount_set(&ni->count, 1);
 	ni->vol = NTFS_SB(sb);
 	ntfs_init_runlist(&ni->runlist);
 	mutex_init(&ni->mrec_lock);
@@ -2275,7 +2275,7 @@ void ntfs_evict_big_inode(struct inode *vi)
 		}
 	}
 	BUG_ON(ni->page);
-	if (!atomic_dec_and_test(&ni->count))
+	if (!refcount_dec_and_test(&ni->count))
 		BUG();
 	return;
 }
diff --git a/fs/ntfs/inode.h b/fs/ntfs/inode.h
index 6f78ee00f57f..cbfff078b216 100644
--- a/fs/ntfs/inode.h
+++ b/fs/ntfs/inode.h
@@ -11,6 +11,7 @@
 #define _LINUX_NTFS_INODE_H
 
 #include <linux/atomic.h>
+#include <linux/refcount.h>
 
 #include <linux/fs.h>
 #include <linux/list.h>
@@ -38,7 +39,7 @@ struct _ntfs_inode {
 				   See ntfs_inode_state_bits below. */
 	unsigned long mft_no;	/* Number of the mft record / inode. */
 	u16 seq_no;		/* Sequence number of the mft record. */
-	atomic_t count;		/* Inode reference count for book keeping. */
+	refcount_t count;		/* Inode reference count for book keeping. */
 	ntfs_volume *vol;	/* Pointer to the ntfs volume of this inode. */
 	/*
 	 * If NInoAttr() is true, the below fields describe the attribute which
diff --git a/fs/ntfs/mft.c b/fs/ntfs/mft.c
index 0d62cd5bb7f8..eda8c78ce850 100644
--- a/fs/ntfs/mft.c
+++ b/fs/ntfs/mft.c
@@ -148,7 +148,7 @@ MFT_RECORD *map_mft_record(ntfs_inode *ni)
 	ntfs_debug("Entering for mft_no 0x%lx.", ni->mft_no);
 
 	/* Make sure the ntfs inode doesn't go away. */
-	atomic_inc(&ni->count);
+	refcount_inc(&ni->count);
 
 	/* Serialize access to this mft record. */
 	mutex_lock(&ni->mrec_lock);
@@ -158,7 +158,7 @@ MFT_RECORD *map_mft_record(ntfs_inode *ni)
 		return m;
 
 	mutex_unlock(&ni->mrec_lock);
-	atomic_dec(&ni->count);
+	refcount_dec(&ni->count);
 	ntfs_error(ni->vol->sb, "Failed with error code %lu.", -PTR_ERR(m));
 	return m;
 }
@@ -209,7 +209,7 @@ void unmap_mft_record(ntfs_inode *ni)
 
 	unmap_mft_record_page(ni);
 	mutex_unlock(&ni->mrec_lock);
-	atomic_dec(&ni->count);
+	refcount_dec(&ni->count);
 	/*
 	 * If pure ntfs_inode, i.e. no vfs inode attached, we leave it to
 	 * ntfs_clear_extent_inode() in the extent inode case, and to the
@@ -246,7 +246,7 @@ MFT_RECORD *map_extent_mft_record(ntfs_inode *base_ni, MFT_REF mref,
 	ntfs_debug("Mapping extent mft record 0x%lx (base mft record 0x%lx).",
 			mft_no, base_ni->mft_no);
 	/* Make sure the base ntfs inode doesn't go away. */
-	atomic_inc(&base_ni->count);
+	refcount_inc(&base_ni->count);
 	/*
 	 * Check if this extent inode has already been added to the base inode,
 	 * in which case just return it. If not found, add it to the base
@@ -260,17 +260,17 @@ MFT_RECORD *map_extent_mft_record(ntfs_inode *base_ni, MFT_REF mref,
 				continue;
 			ni = extent_nis[i];
 			/* Make sure the ntfs inode doesn't go away. */
-			atomic_inc(&ni->count);
+			refcount_inc(&ni->count);
 			break;
 		}
 	}
 	if (likely(ni != NULL)) {
 		mutex_unlock(&base_ni->extent_lock);
-		atomic_dec(&base_ni->count);
+		refcount_dec(&base_ni->count);
 		/* We found the record; just have to map and return it. */
 		m = map_mft_record(ni);
 		/* map_mft_record() has incremented this on success. */
-		atomic_dec(&ni->count);
+		refcount_dec(&ni->count);
 		if (!IS_ERR(m)) {
 			/* Verify the sequence number. */
 			if (likely(le16_to_cpu(m->sequence_number) == seq_no)) {
@@ -293,7 +293,7 @@ MFT_RECORD *map_extent_mft_record(ntfs_inode *base_ni, MFT_REF mref,
 	ni = ntfs_new_extent_inode(base_ni->vol->sb, mft_no);
 	if (unlikely(!ni)) {
 		mutex_unlock(&base_ni->extent_lock);
-		atomic_dec(&base_ni->count);
+		refcount_dec(&base_ni->count);
 		return ERR_PTR(-ENOMEM);
 	}
 	ni->vol = base_ni->vol;
@@ -304,7 +304,7 @@ MFT_RECORD *map_extent_mft_record(ntfs_inode *base_ni, MFT_REF mref,
 	m = map_mft_record(ni);
 	if (IS_ERR(m)) {
 		mutex_unlock(&base_ni->extent_lock);
-		atomic_dec(&base_ni->count);
+		refcount_dec(&base_ni->count);
 		ntfs_clear_extent_inode(ni);
 		goto map_err_out;
 	}
@@ -339,14 +339,14 @@ MFT_RECORD *map_extent_mft_record(ntfs_inode *base_ni, MFT_REF mref,
 	}
 	base_ni->ext.extent_ntfs_inos[base_ni->nr_extents++] = ni;
 	mutex_unlock(&base_ni->extent_lock);
-	atomic_dec(&base_ni->count);
+	refcount_dec(&base_ni->count);
 	ntfs_debug("Done 2.");
 	*ntfs_ino = ni;
 	return m;
 unm_err_out:
 	unmap_mft_record(ni);
 	mutex_unlock(&base_ni->extent_lock);
-	atomic_dec(&base_ni->count);
+	refcount_dec(&base_ni->count);
 	/*
 	 * If the extent inode was not attached to the base inode we need to
 	 * release it or we will leak memory.
@@ -965,12 +965,12 @@ bool ntfs_may_write_mft_record(ntfs_volume *vol, const unsigned long mft_no,
 		/* The inode is in icache. */
 		ni = NTFS_I(vi);
 		/* Take a reference to the ntfs inode. */
-		atomic_inc(&ni->count);
+		refcount_inc(&ni->count);
 		/* If the inode is dirty, do not write this record. */
 		if (NInoDirty(ni)) {
 			ntfs_debug("Inode 0x%lx is dirty, do not write it.",
 					mft_no);
-			atomic_dec(&ni->count);
+			refcount_dec(&ni->count);
 			iput(vi);
 			return false;
 		}
@@ -979,7 +979,7 @@ bool ntfs_may_write_mft_record(ntfs_volume *vol, const unsigned long mft_no,
 		if (unlikely(!mutex_trylock(&ni->mrec_lock))) {
 			ntfs_debug("Mft record 0x%lx is already locked, do "
 					"not write it.", mft_no);
-			atomic_dec(&ni->count);
+			refcount_dec(&ni->count);
 			iput(vi);
 			return false;
 		}
@@ -1075,14 +1075,14 @@ bool ntfs_may_write_mft_record(ntfs_volume *vol, const unsigned long mft_no,
 	ntfs_debug("Extent inode 0x%lx is attached to its base inode 0x%lx.",
 			mft_no, na.mft_no);
 	/* Take a reference to the extent ntfs inode. */
-	atomic_inc(&eni->count);
+	refcount_inc(&eni->count);
 	mutex_unlock(&ni->extent_lock);
 	/*
 	 * Found the extent inode coresponding to this extent mft record.
 	 * Try to take the mft record lock.
 	 */
 	if (unlikely(!mutex_trylock(&eni->mrec_lock))) {
-		atomic_dec(&eni->count);
+		refcount_dec(&eni->count);
 		iput(vi);
 		ntfs_debug("Extent mft record 0x%lx is already locked, do "
 				"not write it.", mft_no);
@@ -2695,7 +2695,7 @@ ntfs_inode *ntfs_mft_record_alloc(ntfs_volume *vol, const int mode,
 		 * Manually map, pin, and lock the mft record as we already
 		 * have its page mapped and it is very easy to do.
 		 */
-		atomic_inc(&ni->count);
+		refcount_inc(&ni->count);
 		mutex_lock(&ni->mrec_lock);
 		ni->page = page;
 		ni->page_ofs = ofs;
@@ -2795,7 +2795,7 @@ int ntfs_extent_mft_record_free(ntfs_inode *ni, MFT_RECORD *m)
 	mutex_lock(&base_ni->extent_lock);
 
 	/* Make sure we are holding the only reference to the extent inode. */
-	if (atomic_read(&ni->count) > 2) {
+	if (refcount_read(&ni->count) > 2) {
 		ntfs_error(vol->sb, "Tried to free busy extent inode 0x%lx, "
 				"not freeing.", base_ni->mft_no);
 		mutex_unlock(&base_ni->extent_lock);
-- 
2.7.4

