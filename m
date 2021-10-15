Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B700742FEF1
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 01:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235740AbhJOXkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 19:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232515AbhJOXkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 19:40:23 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17A3DC061570
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 16:38:16 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id t7-20020a258387000000b005b6d7220c79so12863980ybk.16
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 16:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=LgZx2gyU7+brRv5aiN0oii+nN50bf2cC7za5oQ9rp8U=;
        b=PLYjtcfo6gK6CFeWjXpE8xbQDQwDhU9poRm7tfVdSwucK14C58F2qlAJyifG2TETMZ
         xCS1MK+g2ziKWxjBBndKXROcdahBsjMq+l4zuSCs4zQUpcbMQtptwde/OjouuJc08DMX
         NmyE7hX5uj+KcQqMH2F9IyRGnc7exCPAAMrBmVYbdvm8Rd/kHHa3XzFvZQ89nQQndkmW
         1pREFIuxdM+StPhYs7Oeu3/0GIMoLw5dC8ENcbYzk5soyfpJLgTP7yrFL96S7qhiS6La
         dSHtJE/cC6IIqlQ5mvUerca3ClSj+4jcrptvTKP6FjlXA/PJF9eYIN1shNGZQSugbFAz
         OWkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=LgZx2gyU7+brRv5aiN0oii+nN50bf2cC7za5oQ9rp8U=;
        b=LRPj/5AqDpKqBUtAWWSaFFc6XNidb8739myN1cqNrpdAd2fKYmO60rqHWKN28XGcCy
         kb8MQjTmTZrwBtJaejj4rikAhupoN5lkCjykDNAhuUOpZGdiNUVSoFmfIkdjwDSh6icu
         fel4Rei0VvuPEi9X+LJGcXKrZuHOIMxv3ccCWbGpKJblBae8y9ZZlw+qR3rR9zLF5W92
         u0dPI1kWy4JoVR1mYDWNO1QARDmfzKGLiUhD7YdI5+uDy1R5WECDlKrWj62ZtfVDdrEu
         bhBX0PQtEmGIniAOpqdLoKB0YmAI4x7ot62fVEVD7UZQun80CI7KPp2/uD1AkQdaTQul
         0I8Q==
X-Gm-Message-State: AOAM533v3JtswcvIik1HfcB83DOus5pyivB3O4EVltH8RBXiSEjV2OXp
        qRyWJNsWA69JKdw3EnDiG3vDJYh2bQ==
X-Google-Smtp-Source: ABdhPJxEDGdVVMenm/sX8xOmG9IFsHUV1PDfzHRM1HesKJwF9WfDiTdctWGq2QGDt8ymMQeubkzAlrcVoA==
X-Received: from ava-linux2.mtv.corp.google.com ([2620:15c:211:200:b298:286b:4728:da92])
 (user=tkjos job=sendgmr) by 2002:a25:6150:: with SMTP id v77mr15450286ybb.530.1634341095202;
 Fri, 15 Oct 2021 16:38:15 -0700 (PDT)
Date:   Fri, 15 Oct 2021 16:38:11 -0700
Message-Id: <20211015233811.3532235-1-tkjos@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH] binder: don't detect sender/target during buffer cleanup
From:   Todd Kjos <tkjos@google.com>
To:     tkjos@google.com, gregkh@linuxfoundation.org, christian@brauner.io,
        arve@android.com, jannh@google.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, maco@google.com
Cc:     joel@joelfernandes.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When freeing txn buffers, binder_transaction_buffer_release()
attempts to detect whether the current context is the target by
comparing current->group_leader to proc->tsk. This is an unreliable
test. Instead explicitly pass an 'is_failure' boolean.

Detecting the sender was being used as a way to tell if the
transaction failed to be sent.  When cleaning up after
failing to send a transaction, there is no need to close
the fds associated with a BINDER_TYPE_FDA object. Now
'is_failure' can be used to accurately detect this case.

Fixes: 44d8047f1d87 ("binder: use standard functions to allocate fds")
Signed-off-by: Todd Kjos <tkjos@google.com>
---
 drivers/android/binder.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 9edacc8b9768..fe4c3b49eec1 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -1870,7 +1870,7 @@ static void binder_transaction_buffer_release(struct binder_proc *proc,
 		binder_dec_node(buffer->target_node, 1, 0);
 
 	off_start_offset = ALIGN(buffer->data_size, sizeof(void *));
-	off_end_offset = is_failure ? failed_at :
+	off_end_offset = is_failure && failed_at ? failed_at :
 				off_start_offset + buffer->offsets_size;
 	for (buffer_offset = off_start_offset; buffer_offset < off_end_offset;
 	     buffer_offset += sizeof(binder_size_t)) {
@@ -1956,9 +1956,8 @@ static void binder_transaction_buffer_release(struct binder_proc *proc,
 			binder_size_t fd_buf_size;
 			binder_size_t num_valid;
 
-			if (proc->tsk != current->group_leader) {
+			if (is_failure) {
 				/*
-				 * Nothing to do if running in sender context
 				 * The fd fixups have not been applied so no
 				 * fds need to be closed.
 				 */
@@ -3185,6 +3184,7 @@ static void binder_transaction(struct binder_proc *proc,
  * binder_free_buf() - free the specified buffer
  * @proc:	binder proc that owns buffer
  * @buffer:	buffer to be freed
+ * @is_failure:	failed to send transaction
  *
  * If buffer for an async transaction, enqueue the next async
  * transaction from the node.
@@ -3194,7 +3194,7 @@ static void binder_transaction(struct binder_proc *proc,
 static void
 binder_free_buf(struct binder_proc *proc,
 		struct binder_thread *thread,
-		struct binder_buffer *buffer)
+		struct binder_buffer *buffer, bool is_failure)
 {
 	binder_inner_proc_lock(proc);
 	if (buffer->transaction) {
@@ -3222,7 +3222,7 @@ binder_free_buf(struct binder_proc *proc,
 		binder_node_inner_unlock(buf_node);
 	}
 	trace_binder_transaction_buffer_release(buffer);
-	binder_transaction_buffer_release(proc, thread, buffer, 0, false);
+	binder_transaction_buffer_release(proc, thread, buffer, 0, is_failure);
 	binder_alloc_free_buf(&proc->alloc, buffer);
 }
 
@@ -3424,7 +3424,7 @@ static int binder_thread_write(struct binder_proc *proc,
 				     proc->pid, thread->pid, (u64)data_ptr,
 				     buffer->debug_id,
 				     buffer->transaction ? "active" : "finished");
-			binder_free_buf(proc, thread, buffer);
+			binder_free_buf(proc, thread, buffer, false);
 			break;
 		}
 
@@ -4117,7 +4117,7 @@ static int binder_thread_read(struct binder_proc *proc,
 			buffer->transaction = NULL;
 			binder_cleanup_transaction(t, "fd fixups failed",
 						   BR_FAILED_REPLY);
-			binder_free_buf(proc, thread, buffer);
+			binder_free_buf(proc, thread, buffer, true);
 			binder_debug(BINDER_DEBUG_FAILED_TRANSACTION,
 				     "%d:%d %stransaction %d fd fixups failed %d/%d, line %d\n",
 				     proc->pid, thread->pid,
-- 
2.33.0.1079.g6e70778dc9-goog

