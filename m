Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F706427AF9
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 16:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234324AbhJIOxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Oct 2021 10:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233799AbhJIOxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Oct 2021 10:53:24 -0400
Received: from valentin-vidic.from.hr (valentin-vidic.from.hr [IPv6:2001:470:1f0b:3b7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A504C061570
        for <linux-kernel@vger.kernel.org>; Sat,  9 Oct 2021 07:51:26 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at valentin-vidic.from.hr
Received: by valentin-vidic.from.hr (Postfix, from userid 1000)
        id 5DB0E72A3; Sat,  9 Oct 2021 16:51:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=valentin-vidic.from.hr; s=2020; t=1633791081;
        bh=yVlefyeDH+D/5PeIPTT7a5+sV1r59yr5znbK3b7L6jQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a7UZ7dzkDs8Jo2KfCz4KbH9h3PO31qMl0qU+7oi8nbkOG1dBjrGkb4noAb9wddmRT
         B8YxwV5/dshfdxEf/naci7lrwBvQB9RV/lhbZcW6w7MOkWbi5RJdiR8Kis8wytIAKR
         2os7EMP1cMozW/HsDmjgAl+5ERWTqE1TcU2kWUdPUCv0EZE/B46PIIfTjXlPgP1YdO
         i+bszK/XFzrjQstxSwfPUPvpxOUXHElAwvTnY4sPIwbHbeDEBNuqzREIQTrvF+ELGA
         tqLT5crUfx6Mo27RqFWdIMlxCOnzIBoKkROodWg619OfbXubpEq+p//5UqG/UHtYbG
         t+zSC68v5eWl81wAZ5xSAna9NN2cuqWkOXQCIeqXV7KkssZ+eaCOM4jyX5vAN5yFFp
         LUd03FrmgEpwnRI3wD7DqRcoav70JphSYMRPlUFOJK6BxwbzA+szc1keL4ANBu40/P
         ce/3BlP9L/l4UbxJPoduqgp77kNNxkovCdrTJmt184BsSwphCdGKPdGzKMAai58A0k
         EyoHylAJK5v/yP6SM9vDZmGqS+TDlvx+F2lYY9/PB6DVf9AOLXVQ7/EjZhrFNVdqre
         Dm46Otko0FV0LmmI7FO4PXYOgDq6G9iJbABsQnwr2ykc4rX1G1ISYGFA2+NiEcxE91
         329Pk1h1XEwI2jjVhUpvSFZU=
From:   Valentin Vidic <vvidic@valentin-vidic.from.hr>
To:     Joseph Qi <joseph.qi@linux.alibaba.com>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>, ocfs2-devel@oss.oracle.com,
        linux-kernel@vger.kernel.org
Cc:     Valentin Vidic <vvidic@valentin-vidic.from.hr>
Subject: [PATCH v2] ocfs2: cleanup journal init and shutdown
Date:   Sat,  9 Oct 2021 16:50:06 +0200
Message-Id: <20211009145006.3478-1-vvidic@valentin-vidic.from.hr>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <faceeac2-7419-e500-12ba-ab11b915e660@linux.alibaba.com>
References: <faceeac2-7419-e500-12ba-ab11b915e660@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allocate and free struct ocfs2_journal in ocfs2_journal_init and
ocfs2_journal_shutdown. Init and release of system inodes references
the journal so reorder calls to make sure they work correctly.

Signed-off-by: Valentin Vidic <vvidic@valentin-vidic.from.hr>
---
v2: use osb->journal and cleanup commented up_write call

 fs/ocfs2/inode.c   |  4 ++--
 fs/ocfs2/journal.c | 26 +++++++++++++++++++++-----
 fs/ocfs2/journal.h |  3 +--
 fs/ocfs2/super.c   | 40 +++-------------------------------------
 4 files changed, 27 insertions(+), 46 deletions(-)

diff --git a/fs/ocfs2/inode.c b/fs/ocfs2/inode.c
index bc8f32fab964..6c2411c2afcf 100644
--- a/fs/ocfs2/inode.c
+++ b/fs/ocfs2/inode.c
@@ -125,7 +125,6 @@ struct inode *ocfs2_iget(struct ocfs2_super *osb, u64 blkno, unsigned flags,
 	struct inode *inode = NULL;
 	struct super_block *sb = osb->sb;
 	struct ocfs2_find_inode_args args;
-	journal_t *journal = OCFS2_SB(sb)->journal->j_journal;
 
 	trace_ocfs2_iget_begin((unsigned long long)blkno, flags,
 			       sysfile_type);
@@ -172,10 +171,11 @@ struct inode *ocfs2_iget(struct ocfs2_super *osb, u64 blkno, unsigned flags,
 	 * part of the transaction - the inode could have been reclaimed and
 	 * now it is reread from disk.
 	 */
-	if (journal) {
+	if (osb->journal) {
 		transaction_t *transaction;
 		tid_t tid;
 		struct ocfs2_inode_info *oi = OCFS2_I(inode);
+		journal_t *journal = osb->journal->j_journal;
 
 		read_lock(&journal->j_state_lock);
 		if (journal->j_running_transaction)
diff --git a/fs/ocfs2/journal.c b/fs/ocfs2/journal.c
index 4f15750aac5d..b9c339335a53 100644
--- a/fs/ocfs2/journal.c
+++ b/fs/ocfs2/journal.c
@@ -810,19 +810,34 @@ void ocfs2_set_journal_params(struct ocfs2_super *osb)
 	write_unlock(&journal->j_state_lock);
 }
 
-int ocfs2_journal_init(struct ocfs2_journal *journal, int *dirty)
+int ocfs2_journal_init(struct ocfs2_super *osb, int *dirty)
 {
 	int status = -1;
 	struct inode *inode = NULL; /* the journal inode */
 	journal_t *j_journal = NULL;
+	struct ocfs2_journal *journal = NULL;
 	struct ocfs2_dinode *di = NULL;
 	struct buffer_head *bh = NULL;
-	struct ocfs2_super *osb;
 	int inode_lock = 0;
 
-	BUG_ON(!journal);
+	/* initialize our journal structure */
+	journal = kzalloc(sizeof(struct ocfs2_journal), GFP_KERNEL);
+	if (!journal) {
+		mlog(ML_ERROR, "unable to alloc journal\n");
+		status = -ENOMEM;
+		goto done;
+	}
+	osb->journal = journal;
+	journal->j_osb = osb;
 
-	osb = journal->j_osb;
+	atomic_set(&journal->j_num_trans, 0);
+	init_rwsem(&journal->j_trans_barrier);
+	init_waitqueue_head(&journal->j_checkpointed);
+	spin_lock_init(&journal->j_lock);
+	journal->j_trans_id = 1UL;
+	INIT_LIST_HEAD(&journal->j_la_cleanups);
+	INIT_WORK(&journal->j_recovery_work, ocfs2_complete_recovery);
+	journal->j_state = OCFS2_JOURNAL_FREE;
 
 	/* already have the inode for our journal */
 	inode = ocfs2_get_system_file_inode(osb, JOURNAL_SYSTEM_INODE,
@@ -1028,9 +1043,10 @@ void ocfs2_journal_shutdown(struct ocfs2_super *osb)
 
 	journal->j_state = OCFS2_JOURNAL_FREE;
 
-//	up_write(&journal->j_trans_barrier);
 done:
 	iput(inode);
+	kfree(journal);
+	osb->journal = NULL;
 }
 
 static void ocfs2_clear_journal_error(struct super_block *sb,
diff --git a/fs/ocfs2/journal.h b/fs/ocfs2/journal.h
index d158acb8b38a..8dcb2f2cadbc 100644
--- a/fs/ocfs2/journal.h
+++ b/fs/ocfs2/journal.h
@@ -167,8 +167,7 @@ int ocfs2_compute_replay_slots(struct ocfs2_super *osb);
  *  ocfs2_start_checkpoint - Kick the commit thread to do a checkpoint.
  */
 void   ocfs2_set_journal_params(struct ocfs2_super *osb);
-int    ocfs2_journal_init(struct ocfs2_journal *journal,
-			  int *dirty);
+int    ocfs2_journal_init(struct ocfs2_super *osb, int *dirty);
 void   ocfs2_journal_shutdown(struct ocfs2_super *osb);
 int    ocfs2_journal_wipe(struct ocfs2_journal *journal,
 			  int full);
diff --git a/fs/ocfs2/super.c b/fs/ocfs2/super.c
index 5c914ce9b3ac..1286b88b6fa1 100644
--- a/fs/ocfs2/super.c
+++ b/fs/ocfs2/super.c
@@ -1894,8 +1894,6 @@ static void ocfs2_dismount_volume(struct super_block *sb, int mnt_err)
 	/* This will disable recovery and flush any recovery work. */
 	ocfs2_recovery_exit(osb);
 
-	ocfs2_journal_shutdown(osb);
-
 	ocfs2_sync_blockdev(sb);
 
 	ocfs2_purge_refcount_trees(osb);
@@ -1918,6 +1916,8 @@ static void ocfs2_dismount_volume(struct super_block *sb, int mnt_err)
 
 	ocfs2_release_system_inodes(osb);
 
+	ocfs2_journal_shutdown(osb);
+
 	/*
 	 * If we're dismounting due to mount error, mount.ocfs2 will clean
 	 * up heartbeat.  If we're a local mount, there is no heartbeat.
@@ -2016,7 +2016,6 @@ static int ocfs2_initialize_super(struct super_block *sb,
 	int i, cbits, bbits;
 	struct ocfs2_dinode *di = (struct ocfs2_dinode *)bh->b_data;
 	struct inode *inode = NULL;
-	struct ocfs2_journal *journal;
 	struct ocfs2_super *osb;
 	u64 total_blocks;
 
@@ -2197,33 +2196,6 @@ static int ocfs2_initialize_super(struct super_block *sb,
 
 	get_random_bytes(&osb->s_next_generation, sizeof(u32));
 
-	/* FIXME
-	 * This should be done in ocfs2_journal_init(), but unknown
-	 * ordering issues will cause the filesystem to crash.
-	 * If anyone wants to figure out what part of the code
-	 * refers to osb->journal before ocfs2_journal_init() is run,
-	 * be my guest.
-	 */
-	/* initialize our journal structure */
-
-	journal = kzalloc(sizeof(struct ocfs2_journal), GFP_KERNEL);
-	if (!journal) {
-		mlog(ML_ERROR, "unable to alloc journal\n");
-		status = -ENOMEM;
-		goto bail;
-	}
-	osb->journal = journal;
-	journal->j_osb = osb;
-
-	atomic_set(&journal->j_num_trans, 0);
-	init_rwsem(&journal->j_trans_barrier);
-	init_waitqueue_head(&journal->j_checkpointed);
-	spin_lock_init(&journal->j_lock);
-	journal->j_trans_id = (unsigned long) 1;
-	INIT_LIST_HEAD(&journal->j_la_cleanups);
-	INIT_WORK(&journal->j_recovery_work, ocfs2_complete_recovery);
-	journal->j_state = OCFS2_JOURNAL_FREE;
-
 	INIT_WORK(&osb->dquot_drop_work, ocfs2_drop_dquot_refs);
 	init_llist_head(&osb->dquot_drop_list);
 
@@ -2404,7 +2376,7 @@ static int ocfs2_check_volume(struct ocfs2_super *osb)
 						  * ourselves. */
 
 	/* Init our journal object. */
-	status = ocfs2_journal_init(osb->journal, &dirty);
+	status = ocfs2_journal_init(osb, &dirty);
 	if (status < 0) {
 		mlog(ML_ERROR, "Could not initialize journal!\n");
 		goto finally;
@@ -2513,12 +2485,6 @@ static void ocfs2_delete_osb(struct ocfs2_super *osb)
 
 	kfree(osb->osb_orphan_wipes);
 	kfree(osb->slot_recovery_generations);
-	/* FIXME
-	 * This belongs in journal shutdown, but because we have to
-	 * allocate osb->journal at the start of ocfs2_initialize_osb(),
-	 * we free it here.
-	 */
-	kfree(osb->journal);
 	kfree(osb->local_alloc_copy);
 	kfree(osb->uuid_str);
 	kfree(osb->vol_label);
-- 
2.30.2

