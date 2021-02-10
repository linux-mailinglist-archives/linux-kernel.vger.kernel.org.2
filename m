Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0E4315E2F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 05:28:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbhBJE0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 23:26:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbhBJE0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 23:26:15 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF90C061574;
        Tue,  9 Feb 2021 20:25:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=nczYoTsCTLNgeall4U40h6M+4Wuvi16K00s3tJbpTCI=; b=hs50JRPMhgQGPBW4LBVFmKwKSZ
        plN+dVooFpZ3WLykFO/nqLgzidEUbeuFJ8MfkzDSQbSMINnxf+Wtwa74O3rjxcyJFUvJ5zbjd4TGB
        fAItj4V2pPefTyHy2JxQpQZwCIKokRrLv9rl64MmnNWHMDjdtZYK70GJm7ohph5t4EiQoyCwiBehZ
        Bk/WAyhTVsBkbCXNARqJSPi3Es8gVVnQ2UUxj9Tt1PIui97jQal85uNOwePBFdt9MN9Xe2jMn2ID0
        YaahDehmqJ/HbDASetLBMGGOGXMkfaCY+13tAFUE6eVocJ5d06XOpeM9XeWW6cNDUZKZz0BIKetPY
        KuvweGwA==;
Received: from [2601:1c0:6280:3f0::cf3b] (helo=merlin.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l9h4E-0001Fi-L9; Wed, 10 Feb 2021 04:25:31 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 1/2] fs: eventpoll: fix comments & kernel-doc notation
Date:   Tue,  9 Feb 2021 20:25:25 -0800
Message-Id: <20210210042526.23174-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the documented kernel-doc format for function Return: descriptions.
Begin constant values in kernel-doc comments with '%'.

Remove kernel-doc "/**" from 2 functions that are not documented with
kernel-doc notation.

Fix typos, punctuation, & grammar.

Also fix a few kernel-doc warnings:

../fs/eventpoll.c:1883: warning: Function parameter or member 'ep' not described in 'ep_loop_check_proc'
../fs/eventpoll.c:1883: warning: Excess function parameter 'priv' description in 'ep_loop_check_proc'
../fs/eventpoll.c:1932: warning: Function parameter or member 'ep' not described in 'ep_loop_check'
../fs/eventpoll.c:1932: warning: Excess function parameter 'from' description in 'ep_loop_check'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
---
Jon: Al says that he is OK with one of you merging this fs/
     (only comments) patch.

 fs/eventpoll.c |   52 +++++++++++++++++++++++------------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

--- linux-next-20210205.orig/fs/eventpoll.c
+++ linux-next-20210205/fs/eventpoll.c
@@ -366,8 +366,8 @@ static inline struct epitem *ep_item_fro
  *
  * @ep: Pointer to the eventpoll context.
  *
- * Returns: Returns a value different than zero if ready events are available,
- *          or zero otherwise.
+ * Return: a value different than %zero if ready events are available,
+ *          or %zero otherwise.
  */
 static inline int ep_events_available(struct eventpoll *ep)
 {
@@ -1023,7 +1023,7 @@ struct file *get_epoll_tfile_raw_ptr(str
 }
 #endif /* CONFIG_CHECKPOINT_RESTORE */
 
-/**
+/*
  * Adds a new entry to the tail of the list in a lockless way, i.e.
  * multiple CPUs are allowed to call this function concurrently.
  *
@@ -1035,10 +1035,10 @@ struct file *get_epoll_tfile_raw_ptr(str
  *         completed.
  *
  *        Also an element can be locklessly added to the list only in one
- *        direction i.e. either to the tail either to the head, otherwise
+ *        direction i.e. either to the tail or to the head, otherwise
  *        concurrent access will corrupt the list.
  *
- * Returns %false if element has been already added to the list, %true
+ * Return: %false if element has been already added to the list, %true
  * otherwise.
  */
 static inline bool list_add_tail_lockless(struct list_head *new,
@@ -1076,11 +1076,11 @@ static inline bool list_add_tail_lockles
 	return true;
 }
 
-/**
+/*
  * Chains a new epi entry to the tail of the ep->ovflist in a lockless way,
  * i.e. multiple CPUs are allowed to call this function concurrently.
  *
- * Returns %false if epi element has been already chained, %true otherwise.
+ * Return: %false if epi element has been already chained, %true otherwise.
  */
 static inline bool chain_epi_lockless(struct epitem *epi)
 {
@@ -1105,8 +1105,8 @@ static inline bool chain_epi_lockless(st
  * mechanism. It is called by the stored file descriptors when they
  * have events to report.
  *
- * This callback takes a read lock in order not to content with concurrent
- * events from another file descriptors, thus all modifications to ->rdllist
+ * This callback takes a read lock in order not to contend with concurrent
+ * events from another file descriptor, thus all modifications to ->rdllist
  * or ->ovflist are lockless.  Read lock is paired with the write lock from
  * ep_scan_ready_list(), which stops all list modifications and guarantees
  * that lists state is seen correctly.
@@ -1335,8 +1335,8 @@ static int reverse_path_check_proc(struc
  *                      paths such that we will spend all our time waking up
  *                      eventpoll objects.
  *
- * Returns: Returns zero if the proposed links don't create too many paths,
- *	    -1 otherwise.
+ * Return: %zero if the proposed links don't create too many paths,
+ *	    %-1 otherwise.
  */
 static int reverse_path_check(void)
 {
@@ -1734,7 +1734,7 @@ static struct timespec64 *ep_timeout_to_
 }
 
 /**
- * ep_poll - Retrieves ready events, and delivers them to the caller supplied
+ * ep_poll - Retrieves ready events, and delivers them to the caller-supplied
  *           event buffer.
  *
  * @ep: Pointer to the eventpoll context.
@@ -1747,7 +1747,7 @@ static struct timespec64 *ep_timeout_to_
  *           until at least one event has been retrieved (or an error
  *           occurred).
  *
- * Returns: Returns the number of ready events which have been fetched, or an
+ * Return: the number of ready events which have been fetched, or an
  *          error code, in case of error.
  */
 static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
@@ -1774,9 +1774,9 @@ static int ep_poll(struct eventpoll *ep,
 
 	/*
 	 * This call is racy: We may or may not see events that are being added
-	 * to the ready list under the lock (e.g., in IRQ callbacks). For, cases
+	 * to the ready list under the lock (e.g., in IRQ callbacks). For cases
 	 * with a non-zero timeout, this thread will check the ready list under
-	 * lock and will added to the wait queue.  For, cases with a zero
+	 * lock and will add to the wait queue.  For cases with a zero
 	 * timeout, the user by definition should not care and will have to
 	 * recheck again.
 	 */
@@ -1869,15 +1869,15 @@ static int ep_poll(struct eventpoll *ep,
 
 /**
  * ep_loop_check_proc - verify that adding an epoll file inside another
- *                      epoll structure, does not violate the constraints, in
+ *                      epoll structure does not violate the constraints, in
  *                      terms of closed loops, or too deep chains (which can
  *                      result in excessive stack usage).
  *
- * @priv: Pointer to the epoll file to be currently checked.
+ * @ep: the &struct eventpoll to be currently checked.
  * @depth: Current depth of the path being checked.
  *
- * Returns: Returns zero if adding the epoll @file inside current epoll
- *          structure @ep does not violate the constraints, or -1 otherwise.
+ * Return: %zero if adding the epoll @file inside current epoll
+ *          structure @ep does not violate the constraints, or %-1 otherwise.
  */
 static int ep_loop_check_proc(struct eventpoll *ep, int depth)
 {
@@ -1919,14 +1919,14 @@ static int ep_loop_check_proc(struct eve
 
 /**
  * ep_loop_check - Performs a check to verify that adding an epoll file (@to)
- *                 into another epoll file (represented by @from) does not create
+ *                 into another epoll file (represented by @ep) does not create
  *                 closed loops or too deep chains.
  *
- * @from: Pointer to the epoll we are inserting into.
+ * @ep: Pointer to the epoll we are inserting into.
  * @to: Pointer to the epoll to be inserted.
  *
- * Returns: Returns zero if adding the epoll @to inside the epoll @from
- * does not violate the constraints, or -1 otherwise.
+ * Return: %zero if adding the epoll @to inside the epoll @from
+ * does not violate the constraints, or %-1 otherwise.
  */
 static int ep_loop_check(struct eventpoll *ep, struct eventpoll *to)
 {
@@ -2074,8 +2074,8 @@ int do_epoll_ctl(int epfd, int op, int f
 	ep = f.file->private_data;
 
 	/*
-	 * When we insert an epoll file descriptor, inside another epoll file
-	 * descriptor, there is the change of creating closed loops, which are
+	 * When we insert an epoll file descriptor inside another epoll file
+	 * descriptor, there is the chance of creating closed loops, which are
 	 * better be handled here, than in more critical paths. While we are
 	 * checking for loops we also determine the list of files reachable
 	 * and hang them on the tfile_check_list, so we can check that we
@@ -2113,7 +2113,7 @@ int do_epoll_ctl(int epfd, int op, int f
 	}
 
 	/*
-	 * Try to lookup the file inside our RB tree, Since we grabbed "mtx"
+	 * Try to lookup the file inside our RB tree. Since we grabbed "mtx"
 	 * above, we can be sure to be able to use the item looked up by
 	 * ep_find() till we release the mutex.
 	 */
