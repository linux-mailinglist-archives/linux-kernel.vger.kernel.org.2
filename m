Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0182E35925B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 05:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233052AbhDIDBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 23:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232692AbhDIDBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 23:01:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8CF1C061760
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 20:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=O2eTkki9P7U2y9pWkWyd/0uAVAQODaOCKzJQlnNy91w=; b=svrtOuGNme+DJCnlaw4+OSJUmV
        UtpwZzIB6yhmS/UXpepTW32N6tQEmrB1srhaR7IB2pgn7pusyddnjgZhpfnHfvYKfEaC5w0nfrkc8
        qG0uawEoyBdr03rfViQDNjGeu7stAZrRJ//ULkWdfwewcI07HAVCxBz4tAYhvik6Lyvb7mVSj/2bw
        Y7QOtiQdXUaKOSbOr9oeGZXwhgn6cpH4FER9xgn/0/wKu5MnWIEKG8wCgwj62EEEkPl8BrPOuo8Rk
        578eTql5KXRRdWSv9PBviCZOT9cobtjW0YluBA5mZ1+dBE9erkRIDKpKd71LLqwWUpob4R2FNAio/
        goxhxsfQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lUhMU-00HGvC-KS; Fri, 09 Apr 2021 02:59:31 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     neilb@suse.de, peterz@infradead.org, mingo@redhat.com,
        will@kernel.org, longman@redhat.com, boqun.feng@gmail.com,
        tglx@linutronix.de, bigeasy@linutronix.de
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 13/17] jbd2: Add jbd2_jh_lock
Date:   Fri,  9 Apr 2021 03:51:27 +0100
Message-Id: <20210409025131.4114078-14-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210409025131.4114078-1-willy@infradead.org>
References: <20210409025131.4114078-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow lockdep to track the journal bit spin locks.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/jbd2/journal.c    | 18 ++++++++++--------
 include/linux/jbd2.h | 10 ++++++----
 2 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 2dc944442802..9c5f4b99157b 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -2733,6 +2733,8 @@ static void journal_free_journal_head(struct journal_head *jh)
  *	jbd2_journal_put_journal_head(jh);
  */
 
+static DEFINE_SPLIT_LOCK(jbd2_jh_lock);
+
 /*
  * Give a buffer_head a journal_head.
  *
@@ -2747,7 +2749,7 @@ struct journal_head *jbd2_journal_add_journal_head(struct buffer_head *bh)
 	if (!buffer_jbd(bh))
 		new_jh = journal_alloc_journal_head();
 
-	jbd_lock_bh_journal_head(bh);
+	jbd_lock_bh_journal_head(bh, &jbd2_jh_lock);
 	if (buffer_jbd(bh)) {
 		jh = bh2jh(bh);
 	} else {
@@ -2756,7 +2758,7 @@ struct journal_head *jbd2_journal_add_journal_head(struct buffer_head *bh)
 			(bh->b_page && bh->b_page->mapping));
 
 		if (!new_jh) {
-			jbd_unlock_bh_journal_head(bh);
+			jbd_unlock_bh_journal_head(bh, &jbd2_jh_lock);
 			goto repeat;
 		}
 
@@ -2769,7 +2771,7 @@ struct journal_head *jbd2_journal_add_journal_head(struct buffer_head *bh)
 		BUFFER_TRACE(bh, "added journal_head");
 	}
 	jh->b_jcount++;
-	jbd_unlock_bh_journal_head(bh);
+	jbd_unlock_bh_journal_head(bh, &jbd2_jh_lock);
 	if (new_jh)
 		journal_free_journal_head(new_jh);
 	return bh->b_private;
@@ -2783,12 +2785,12 @@ struct journal_head *jbd2_journal_grab_journal_head(struct buffer_head *bh)
 {
 	struct journal_head *jh = NULL;
 
-	jbd_lock_bh_journal_head(bh);
+	jbd_lock_bh_journal_head(bh, &jbd2_jh_lock);
 	if (buffer_jbd(bh)) {
 		jh = bh2jh(bh);
 		jh->b_jcount++;
 	}
-	jbd_unlock_bh_journal_head(bh);
+	jbd_unlock_bh_journal_head(bh, &jbd2_jh_lock);
 	return jh;
 }
 
@@ -2831,16 +2833,16 @@ void jbd2_journal_put_journal_head(struct journal_head *jh)
 {
 	struct buffer_head *bh = jh2bh(jh);
 
-	jbd_lock_bh_journal_head(bh);
+	jbd_lock_bh_journal_head(bh, &jbd2_jh_lock);
 	J_ASSERT_JH(jh, jh->b_jcount > 0);
 	--jh->b_jcount;
 	if (!jh->b_jcount) {
 		__journal_remove_journal_head(bh);
-		jbd_unlock_bh_journal_head(bh);
+		jbd_unlock_bh_journal_head(bh, &jbd2_jh_lock);
 		journal_release_journal_head(jh, bh->b_size);
 		__brelse(bh);
 	} else {
-		jbd_unlock_bh_journal_head(bh);
+		jbd_unlock_bh_journal_head(bh, &jbd2_jh_lock);
 	}
 }
 
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 99d3cd051ac3..bf32cee8b1e2 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -348,14 +348,16 @@ static inline struct journal_head *bh2jh(struct buffer_head *bh)
 	return bh->b_private;
 }
 
-static inline void jbd_lock_bh_journal_head(struct buffer_head *bh)
+static inline void jbd_lock_bh_journal_head(struct buffer_head *bh,
+		struct split_lock *sl)
 {
-	bit_spin_lock(BH_JournalHead, &bh->b_state);
+	bit_spin_lock(BH_JournalHead, &bh->b_state, sl);
 }
 
-static inline void jbd_unlock_bh_journal_head(struct buffer_head *bh)
+static inline void jbd_unlock_bh_journal_head(struct buffer_head *bh,
+		struct split_lock *sl)
 {
-	bit_spin_unlock(BH_JournalHead, &bh->b_state);
+	bit_spin_unlock(BH_JournalHead, &bh->b_state, sl);
 }
 
 #define J_ASSERT(assert)	BUG_ON(!(assert))
-- 
2.30.2

