Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BABEC43BF44
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 04:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237732AbhJ0CGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 22:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234411AbhJ0CGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 22:06:31 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0DF5C061570
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 19:04:06 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id o12so1121436qtq.7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 19:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rhK2ULnAWsX7Fx7Vd3h0Eahl3TagF58JKrFXTfBQV8s=;
        b=NQqmQIVNDYONphrskpLth8VCqiBDZmC4UF6AXeWoj5W45Xa6aCU4opYu2xKVAMFPtv
         bDQW2TFj8h6kfjxwKmjageW8GpspCSPaG1PqpncVjTtGkXfgl+uNBnsZ7y/IuRIWI9Uu
         dRarVOac/Q2ozMCEJgG76vjwdXr9BnKDn4PdRD2SswwuBtlv50LaVcqW6Zoo5LoupxVG
         xcgyH1iODoZHoFyP5Ol6+l7hZ8gi600dSzNRipld2dUD0DF2MpO1yHcGBLy6ha7zuqG4
         psenbhXRkJwQBQ010mNsBuzC2EfYBOB5PYgj0MvrezzxehBPan2VLKObWyCt7xlIgupH
         Ixdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rhK2ULnAWsX7Fx7Vd3h0Eahl3TagF58JKrFXTfBQV8s=;
        b=KqQhXdJNaQOyRklKzWSBoqRKlAWteFdVNmC0X1FrJixPzk5EePDOBOTuouqzJJysYQ
         mJ8qHj7o36mnv5xjH9ldXjKnHOJMuBz+n4O858SlSBGh9I89Dwx84gFYq7No1xCLvL6Q
         pMcoV4VapyevMN/7qDQNpDx3iggE9wGC9icr6+lg6ev5zZ4h5pJClKF+PvcTh+vlFQZK
         w3wEIciBL5nvDDBFEcpLCJq6VzgouwJ4g84ZL8NbpjU7AHE6CZhQ3a+LE5YWlbYdacMr
         JabTP1tjdFqE+DrjjCa9jjZ8tn/vre4HUqd0eJsvU3thAI5gw2gqdGUNfRV22r4FMP6y
         GTNA==
X-Gm-Message-State: AOAM531yTv4o71Dq8HI3CUWUqBdPHXdX57SBgFsaDZpj6zjqqA3xv8fs
        SRyNyEsOhu36kVh1s4sY0gdp57NQKG0QrFUg
X-Google-Smtp-Source: ABdhPJwMdiTqq+SY7B1faruagcfttHyyDBhH429hTPMkwrglt0EhH36spXmQOhBSnfEOjXaOV9mw9Q==
X-Received: by 2002:ac8:7fcf:: with SMTP id b15mr28249426qtk.363.1635300245777;
        Tue, 26 Oct 2021 19:04:05 -0700 (PDT)
Received: from atari.nover ([189.6.36.155])
        by smtp.gmail.com with ESMTPSA id m17sm12145838qtx.62.2021.10.26.19.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 19:04:05 -0700 (PDT)
From:   Wagner Popov dos Santos <wpopov@gmail.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     wpopov@gmail.com
Subject: [PATCH 1/2] jffs2: solving deadlock between GC and new inodes
Date:   Tue, 26 Oct 2021 23:03:38 -0300
Message-Id: <20211027020339.65303-1-wpopov@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct AB-BA deadlock between the GC kthread and a process
that is creating a new file, symlink, and etc.

Create a new JFFS2 inode state to signalizing that the inode
can't be acquired by the GC because is being created. When this
state happens, the GC releases the alloc_sem, sleep, and then
tries again.

To create a new file, the JFSS2 request a new locked inode
to the Linux's FS layer and then insert inside of some JFFS2's
Erase Block. To finish the creation, the process needs to
acquire the alloc_sem semaphore. Just at the end that the
inode is released by the JFFS2. If the GC starts to process an
Erase Block that contains an inode that is being created, can
occur an AB-BA deadlock if the GC acquires the alloc_sem before
the end of the inode's creation because the CG needs to acquire
all inodes inside the EB to finish the iteration.

This deadlock can occur more frequently with partition mounted
with sync flag (not usual).

Signed-off-by: Wagner Popov dos Santos <wpopov@gmail.com>
---
 fs/jffs2/dir.c       |  4 ++++
 fs/jffs2/gc.c        | 10 ++++++++++
 fs/jffs2/nodelist.h  |  1 +
 fs/jffs2/readinode.c |  1 +
 fs/jffs2/wbuf.c      |  3 ++-
 fs/jffs2/write.c     |  6 +++++-
 6 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/fs/jffs2/dir.c b/fs/jffs2/dir.c
index f20cff1194bb..57299cd8a0d7 100644
--- a/fs/jffs2/dir.c
+++ b/fs/jffs2/dir.c
@@ -210,6 +210,7 @@ static int jffs2_create(struct inode *dir_i, struct dentry *dentry,
 		  f->inocache->pino_nlink, inode->i_mapping->nrpages);
 
 	d_instantiate_new(dentry, inode);
+	jffs2_set_inocache_state(c, f->inocache, INO_STATE_PRESENT);
 	return 0;
 
  fail:
@@ -430,6 +431,7 @@ static int jffs2_symlink (struct inode *dir_i, struct dentry *dentry, const char
 	jffs2_complete_reservation(c);
 
 	d_instantiate_new(dentry, inode);
+	jffs2_set_inocache_state(c, f->inocache, INO_STATE_PRESENT);
 	return 0;
 
  fail:
@@ -574,6 +576,7 @@ static int jffs2_mkdir (struct inode *dir_i, struct dentry *dentry, umode_t mode
 	jffs2_complete_reservation(c);
 
 	d_instantiate_new(dentry, inode);
+	jffs2_set_inocache_state(c, f->inocache, INO_STATE_PRESENT);
 	return 0;
 
  fail:
@@ -745,6 +748,7 @@ static int jffs2_mknod (struct inode *dir_i, struct dentry *dentry, umode_t mode
 	jffs2_complete_reservation(c);
 
 	d_instantiate_new(dentry, inode);
+	jffs2_set_inocache_state(c, f->inocache, INO_STATE_PRESENT);
 	return 0;
 
  fail:
diff --git a/fs/jffs2/gc.c b/fs/jffs2/gc.c
index 9ed0f26cf023..72090843fa19 100644
--- a/fs/jffs2/gc.c
+++ b/fs/jffs2/gc.c
@@ -208,6 +208,8 @@ int jffs2_garbage_collect_pass(struct jffs2_sb_info *c)
 			spin_unlock(&c->inocache_lock);
 			BUG();
 
+			/* fall through */
+		case INO_STATE_CREATING:
 		case INO_STATE_READING:
 			/* We need to wait for it to finish, lest we move on
 			   and trigger the BUG() above while we haven't yet
@@ -394,6 +396,14 @@ int jffs2_garbage_collect_pass(struct jffs2_sb_info *c)
 		spin_unlock(&c->inocache_lock);
 		BUG();
 
+		/* fall through */
+	case INO_STATE_CREATING:
+		/* We can't process this inode while it is being created
+		 * to avoid a deadlock condition the inode is locked.
+		 * However, to finish the creation we need to unlock the
+		 * alloc_sem() and because we dropped the alloc_sem we must
+		 * return to start again from the beginning.
+		 */
 	case INO_STATE_READING:
 		/* Someone's currently trying to read it. We must wait for
 		   them to finish and then go through the full iget() route
diff --git a/fs/jffs2/nodelist.h b/fs/jffs2/nodelist.h
index 0637271f3770..0033eeee27e4 100644
--- a/fs/jffs2/nodelist.h
+++ b/fs/jffs2/nodelist.h
@@ -192,6 +192,7 @@ struct jffs2_inode_cache {
 #define INO_STATE_GC		4	/* GCing a 'pristine' node */
 #define INO_STATE_READING	5	/* In read_inode() */
 #define INO_STATE_CLEARING	6	/* In clear_inode() */
+#define INO_STATE_CREATING	7	/* Inode locked! GC can't touch */
 
 #define INO_FLAGS_XATTR_CHECKED	0x01	/* has no duplicate xattr_ref */
 #define INO_FLAGS_IS_DIR	0x02	/* is a directory */
diff --git a/fs/jffs2/readinode.c b/fs/jffs2/readinode.c
index 389ea53ea487..3a841645bc86 100644
--- a/fs/jffs2/readinode.c
+++ b/fs/jffs2/readinode.c
@@ -1336,6 +1336,7 @@ int jffs2_do_read_inode(struct jffs2_sb_info *c, struct jffs2_inode_info *f,
 			goto retry_inocache;
 
 		case INO_STATE_READING:
+		case INO_STATE_CREATING:
 		case INO_STATE_PRESENT:
 			/* Eep. This should never happen. It can
 			happen if Linux calls read_inode() again
diff --git a/fs/jffs2/wbuf.c b/fs/jffs2/wbuf.c
index c6821a509481..860fe878c324 100644
--- a/fs/jffs2/wbuf.c
+++ b/fs/jffs2/wbuf.c
@@ -518,7 +518,8 @@ static void jffs2_wbuf_recover(struct jffs2_sb_info *c)
 								      (void *)(buf?:c->wbuf) + (ref_offset(raw) - start));
 			} else if (unlikely(ic->state != INO_STATE_PRESENT &&
 					    ic->state != INO_STATE_CHECKEDABSENT &&
-					    ic->state != INO_STATE_GC)) {
+					    ic->state != INO_STATE_GC &&
+					    ic->state != INO_STATE_CREATING)) {
 				JFFS2_ERROR("Inode #%u is in strange state %d!\n", ic->ino, ic->state);
 				BUG();
 			}
diff --git a/fs/jffs2/write.c b/fs/jffs2/write.c
index cda9a361368e..ec48947ac916 100644
--- a/fs/jffs2/write.c
+++ b/fs/jffs2/write.c
@@ -35,7 +35,11 @@ int jffs2_do_new_inode(struct jffs2_sb_info *c, struct jffs2_inode_info *f,
 	f->inocache = ic;
 	f->inocache->pino_nlink = 1; /* Will be overwritten shortly for directories */
 	f->inocache->nodes = (struct jffs2_raw_node_ref *)f->inocache;
-	f->inocache->state = INO_STATE_PRESENT;
+	f->inocache->state = INO_STATE_CREATING;
+	/* The initial state can't be INO_STATE_PRESENT to avoid a deadlock in
+	 * GC because the new inode is still locked and the GC needs to lock
+	 * the inode to get it.
+	 */
 
 	jffs2_add_ino_cache(c, f->inocache);
 	jffs2_dbg(1, "%s(): Assigned ino# %d\n", __func__, f->inocache->ino);
-- 
2.20.1

