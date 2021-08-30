Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB2193FBD2B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 21:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233758AbhH3Tww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 15:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231185AbhH3Twv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 15:52:51 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CECEC061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 12:51:57 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id dv7-20020ad44ee7000000b0036fa79fd337so1275876qvb.6
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 12:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=vlmH2FPTCreu/0JhtoQw1RSxIqcHbMmpEsPhqtnkEpI=;
        b=Hu5Qb9P9tv4nw3UP2XEOSG1qwsgzvImOwJ97Q4XzlftJCvz42sL/HihtDA1evQXqp1
         h6mioNwzuqarhT+QBmliJrncaKOzPfFD9VpEt1Ajr+0CIFpSLS13XTsDg1fpKUWMITZc
         O2IJrwk9UdL4PsbiqBUIMIwGcnLIbhDmiCVaJCQ0bOXykhK2OhYOTA2wNyMkRx/u0Bji
         7Rmi1se2ZguU7bH9XeycQ+aZBMGN/AAOwk25z4V68ObbBaQ0m/P3Ta5Rg5cqHbv8M9ql
         6vytI4T9+jBnG+il60fClEX3juvtWDQniUUcHrwt5vOriDipNeI5DuQ4SxL4XGXAt3Ev
         dO+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=vlmH2FPTCreu/0JhtoQw1RSxIqcHbMmpEsPhqtnkEpI=;
        b=K4753+5+VlbHm1CGwiOExdSpJ/tNOv+oHTe0mXKAuj4IQRbUhi8yJ3m9GAa755kAFK
         AxrpHWv4zzB6dwYyb4jFwJ3bB7SMYLrXFabFLuloxgsc+gCyCiv7OB5lHFjctWGnRnYu
         /NyouMSWqdvZi+FaL8uriwWrHqG+RBhPIWRDOLpE//Tqq8dmGfkRD0git02kZ1nLUZ79
         uvNXU9O8AnXDldMu4LMPu4bQqJgI0GKrjVLUrSNaeIUWevzAaL39UuLkz40URav/tML+
         IPggfx3/rgF1EzXIeWsPVTT/1piVYYjf+QWKxZLtQy9JrvNg5ZUGl/WvbPjotWOssd7u
         1Hyw==
X-Gm-Message-State: AOAM532tfGXA6HVHt90sjnH8Dr8cMbd8Wjy9dQygvgq02iM4Yy0yBfti
        irc0aJr5i8HlhtMH/4Vtdqev9s8tvg==
X-Google-Smtp-Source: ABdhPJxypQStTHSuW+vYuUUGWnGVDGQv9PYEyN8B0RtmipOSC5YYG5ph1LGaqiJUYg1AwithU+Q625lwIw==
X-Received: from ava-linux2.mtv.corp.google.com ([2620:15c:211:200:371e:b5b3:7633:f5cd])
 (user=tkjos job=sendgmr) by 2002:a0c:ff4b:: with SMTP id y11mr25342076qvt.50.1630353116285;
 Mon, 30 Aug 2021 12:51:56 -0700 (PDT)
Date:   Mon, 30 Aug 2021 12:51:46 -0700
Message-Id: <20210830195146.587206-1-tkjos@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.259.gc128427fd7-goog
Subject: [PATCH] binder: make sure fd closes complete
From:   Todd Kjos <tkjos@google.com>
To:     tkjos@google.com, gregkh@linuxfoundation.org, christian@brauner.io,
        arve@android.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, maco@google.com
Cc:     joel@joelfernandes.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During BC_FREE_BUFFER processing, the BINDER_TYPE_FDA object
cleanup may close 1 or more fds. The close operations are
completed using the task work mechanism -- which means the thread
needs to return to userspace or the file object may never be
dereferenced -- which can lead to hung processes.

Force the binder thread back to userspace if an fd is closed during
BC_FREE_BUFFER handling.

Signed-off-by: Todd Kjos <tkjos@google.com>
---
 drivers/android/binder.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index bcec598b89f2..c2823f0d588f 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -1852,6 +1852,7 @@ static void binder_deferred_fd_close(int fd)
 }
 
 static void binder_transaction_buffer_release(struct binder_proc *proc,
+					      struct binder_thread *thread,
 					      struct binder_buffer *buffer,
 					      binder_size_t failed_at,
 					      bool is_failure)
@@ -2011,8 +2012,16 @@ static void binder_transaction_buffer_release(struct binder_proc *proc,
 						&proc->alloc, &fd, buffer,
 						offset, sizeof(fd));
 				WARN_ON(err);
-				if (!err)
+				if (!err) {
 					binder_deferred_fd_close(fd);
+					/*
+					 * Need to make sure the thread goes
+					 * back to userspace to complete the
+					 * deferred close
+					 */
+					if (thread)
+						thread->looper_need_return = true;
+				}
 			}
 		} break;
 		default:
@@ -3105,7 +3114,7 @@ static void binder_transaction(struct binder_proc *proc,
 err_copy_data_failed:
 	binder_free_txn_fixups(t);
 	trace_binder_transaction_failed_buffer_release(t->buffer);
-	binder_transaction_buffer_release(target_proc, t->buffer,
+	binder_transaction_buffer_release(target_proc, NULL, t->buffer,
 					  buffer_offset, true);
 	if (target_node)
 		binder_dec_node_tmpref(target_node);
@@ -3184,7 +3193,9 @@ static void binder_transaction(struct binder_proc *proc,
  * Cleanup buffer and free it.
  */
 static void
-binder_free_buf(struct binder_proc *proc, struct binder_buffer *buffer)
+binder_free_buf(struct binder_proc *proc,
+		struct binder_thread *thread,
+		struct binder_buffer *buffer)
 {
 	binder_inner_proc_lock(proc);
 	if (buffer->transaction) {
@@ -3212,7 +3223,7 @@ binder_free_buf(struct binder_proc *proc, struct binder_buffer *buffer)
 		binder_node_inner_unlock(buf_node);
 	}
 	trace_binder_transaction_buffer_release(buffer);
-	binder_transaction_buffer_release(proc, buffer, 0, false);
+	binder_transaction_buffer_release(proc, thread, buffer, 0, false);
 	binder_alloc_free_buf(&proc->alloc, buffer);
 }
 
@@ -3414,7 +3425,7 @@ static int binder_thread_write(struct binder_proc *proc,
 				     proc->pid, thread->pid, (u64)data_ptr,
 				     buffer->debug_id,
 				     buffer->transaction ? "active" : "finished");
-			binder_free_buf(proc, buffer);
+			binder_free_buf(proc, thread, buffer);
 			break;
 		}
 
@@ -4107,7 +4118,7 @@ static int binder_thread_read(struct binder_proc *proc,
 			buffer->transaction = NULL;
 			binder_cleanup_transaction(t, "fd fixups failed",
 						   BR_FAILED_REPLY);
-			binder_free_buf(proc, buffer);
+			binder_free_buf(proc, thread, buffer);
 			binder_debug(BINDER_DEBUG_FAILED_TRANSACTION,
 				     "%d:%d %stransaction %d fd fixups failed %d/%d, line %d\n",
 				     proc->pid, thread->pid,
-- 
2.33.0.259.gc128427fd7-goog

