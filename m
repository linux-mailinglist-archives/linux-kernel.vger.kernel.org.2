Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83D573DAED3
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 00:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232841AbhG2W1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 18:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232169AbhG2W1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 18:27:36 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA4A4C0613C1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 15:27:31 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id mz5-20020a17090b3785b0290176ecf64922so17846643pjb.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 15:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B+QdeEzKa7UGI7quNzIlqUk5zLUPhgyuAsRaG6gQ5IY=;
        b=WMq+7+IlsWHXF4HeIvz63NNsfXkMKCbTTamxqofx03/G8LbaagqbDyseNJVHndzT9Y
         CrPjke5OxZdTR76+IXA9lm8zDJVQSOTMmcX3ijL4Fpk+g8jGLLYg0BAAZT3BSa75EvpQ
         5RbVT4osAxt1WW5wGRyLp4n7AhR6xdlAKBfwZiJibhmbXfhiGs7u3QC5UaLkdONdHKL0
         b8iEv/DyMBUbTrH0QZvnCryG2eMIBptpgAh8Yd3IUB8voSIoRmnri9JcHux2QUOtZ/Zq
         LL4Y2/yBUTguhU12uMuqjyuQd4+TvfaKr0sz3gg1oMmcoKRtekhCYABu0NWrkEeFZwu9
         /RpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B+QdeEzKa7UGI7quNzIlqUk5zLUPhgyuAsRaG6gQ5IY=;
        b=Q2/G+pH+lnd8pz7I5kvi8B5RaLmg7Hg2trQQkVH1W9NXhOaJwf1TSz+ZLgIEGHIlW4
         VLeGBUUgRYqKKL0xe0GttgCtcIpo7o/tlT8sAHd7LmXReP7K0uQtJVLFlDk+pC0XbLRd
         HLCRYn8PBM7RdepehcQdITW6gUHWa0zcQTKuQ2VcozmpHScdFVuDnJjdBQbnplt8CVo8
         uMUNWfrIdhRJYzEvkFD/TMJ3GYwB9PAGbv5WAEnb8D5vHFS6KVrbna90lzyx40jb9pOP
         SbLq0jPR65pSf3keRlwPPS56NBPRjNESsMjnB9L25VzFJKFcTyWTbT7vml+lg3ygtAx/
         nA3g==
X-Gm-Message-State: AOAM533t4klCleKfNqJlpgsseD86y1Js7nqjvvAKGXnz/ZCamdHK2tXP
        3XTkZNtWq7iAOvs8LBCe6Z7/0Q==
X-Google-Smtp-Source: ABdhPJx+Gc8+F5ihI3VBpAYkqcuqCY0quYPQO6lq0gbUrjCef5HWDouQvALe38N+Y6qlDcjHSRiK1w==
X-Received: by 2002:a17:902:ab98:b029:12b:acc0:e18c with SMTP id f24-20020a170902ab98b029012bacc0e18cmr6570044plr.10.1627597651515;
        Thu, 29 Jul 2021 15:27:31 -0700 (PDT)
Received: from sspatil2.c.googlers.com.com (190.40.105.34.bc.googleusercontent.com. [34.105.40.190])
        by smtp.gmail.com with ESMTPSA id 5sm4761989pfp.154.2021.07.29.15.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 15:27:31 -0700 (PDT)
From:   Sandeep Patil <sspatil@android.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sandeep Patil <sspatil@android.com>, torvalds@linux-foundation.org,
        dhowells@redhat.com, gregkh@linuxfoundation.org,
        stable@vger.kernel.org, kernel-team@android.com
Subject: [PATCH 1/1] fs: pipe: wakeup readers everytime new data written is to pipe
Date:   Thu, 29 Jul 2021 22:26:35 +0000
Message-Id: <20210729222635.2937453-2-sspatil@android.com>
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
In-Reply-To: <20210729222635.2937453-1-sspatil@android.com>
References: <20210729222635.2937453-1-sspatil@android.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit '1b6b26ae7053 ("pipe: fix and clarify pipe write wakeup logic")'
changed pipe_write() to wakeup readers only if the pipe was empty.
Prior to this change, threads waiting in epoll_wait(EPOLLET | EPOLLIN)
on non-empty pipes would get woken up on new data.

It meant an applications that,
   1. used pipe + epoll for notifications between threads / processes
   2. Didn't drain the pipe on each epoll wakeup unless the pipe was full
started to experience hang / timeouts in threads stuck in epoll_wait()

So restore the old behavior to wakeup all readers if any new data is
written to the pipe.

Fixes: 1b6b26ae7053 ("pipe: fix and clarify pipe write wakeup logic")
Signed-off-by: Sandeep Patil <sspatil@android.com>
---
 fs/pipe.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index bfd946a9ad01..dda22a316bb3 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -406,7 +406,7 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 	ssize_t ret = 0;
 	size_t total_len = iov_iter_count(from);
 	ssize_t chars;
-	bool was_empty = false;
+	bool do_wakeup = false;
 	bool wake_next_writer = false;
 
 	/* Null write succeeds. */
@@ -429,10 +429,11 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 #endif
 
 	/*
-	 * Only wake up if the pipe started out empty, since
-	 * otherwise there should be no readers waiting.
+	 * Wake up readers if the pipe was written to. Regardless
+	 * of whether it was empty or not. Otherwise, threads
+	 * waiting with EPOLLET will hang until the pipe is emptied.
 	 *
-	 * If it wasn't empty we try to merge new data into
+	 * If pipe wasn't empty we try to merge new data into
 	 * the last buffer.
 	 *
 	 * That naturally merges small writes, but it also
@@ -440,9 +441,8 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 	 * spanning multiple pages.
 	 */
 	head = pipe->head;
-	was_empty = pipe_empty(head, pipe->tail);
 	chars = total_len & (PAGE_SIZE-1);
-	if (chars && !was_empty) {
+	if (chars && !pipe_empty(head, pipe->tail)) {
 		unsigned int mask = pipe->ring_size - 1;
 		struct pipe_buffer *buf = &pipe->bufs[(head - 1) & mask];
 		int offset = buf->offset + buf->len;
@@ -460,6 +460,7 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 			}
 
 			buf->len += ret;
+			do_wakeup = true;
 			if (!iov_iter_count(from))
 				goto out;
 		}
@@ -526,6 +527,7 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 			ret += copied;
 			buf->offset = 0;
 			buf->len = copied;
+			do_wakeup = true;
 
 			if (!iov_iter_count(from))
 				break;
@@ -553,13 +555,12 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 		 * become empty while we dropped the lock.
 		 */
 		__pipe_unlock(pipe);
-		if (was_empty) {
+		if (do_wakeup) {
 			wake_up_interruptible_sync_poll(&pipe->rd_wait, EPOLLIN | EPOLLRDNORM);
 			kill_fasync(&pipe->fasync_readers, SIGIO, POLL_IN);
 		}
 		wait_event_interruptible_exclusive(pipe->wr_wait, pipe_writable(pipe));
 		__pipe_lock(pipe);
-		was_empty = pipe_empty(pipe->head, pipe->tail);
 		wake_next_writer = true;
 	}
 out:
@@ -576,7 +577,7 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 	 * how (for example) the GNU make jobserver uses small writes to
 	 * wake up pending jobs
 	 */
-	if (was_empty) {
+	if (do_wakeup) {
 		wake_up_interruptible_sync_poll(&pipe->rd_wait, EPOLLIN | EPOLLRDNORM);
 		kill_fasync(&pipe->fasync_readers, SIGIO, POLL_IN);
 	}
-- 
2.32.0.554.ge1b32706d8-goog

