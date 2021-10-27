Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F53F43BEF0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 03:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237311AbhJ0BVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 21:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237058AbhJ0BVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 21:21:44 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F30C061767
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 18:19:19 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id 13-20020ac8560d000000b0029f69548889so716288qtr.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 18:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=tXBF8IPHrXnSIr0GZNWDZAEr0MXQPNCBVCwEca8TIMo=;
        b=GU4Dsa3aUhwed3l5u1ByKWWvqupTtfJDlxC2YsdgHB6f0pBuk4ypKJa0/BG7tQ0RCc
         E0E3RsmDa3L48jL0xzc+0JbNw8zOvjwzTu888jZOCDnw7DFG9987Ij5sYAtn4DoREO9V
         w2EchOQ30pqD9rqHESWGMZWPSLKBP+0bkBZqBdY+y3qu4YzVKbfobOdI2CyvykQItDIs
         sfgJK11oQeCuuSYxVDRzEjToiK5pO4E55kOvqaJLLinUGbHVTlxKmec6y1TqochwE9Cb
         h1W6s1d8MBQRTQPHu6YmnrD1ZDhwylcziXIU4pwpvSoaSKzB0xZG4GXyxtsmzgbiGCwb
         SyKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=tXBF8IPHrXnSIr0GZNWDZAEr0MXQPNCBVCwEca8TIMo=;
        b=mIMxf3kcnaYsYn1AM0j93Czc52ycM/NhgPK7zDqo5TFxwT5mF2iQsowADyqd9dQQzl
         VcSgWoj1oE9f64Ce+pvSB+PHoOZPnNnC2AYOq7rx6R49taqk5KJ8UYvfhiu9E+UL0/dU
         tEagdCI6xRb1QyUGhp5Aiwept7yORYfANdoyX3TP2epee6gl3rpHErNq0nia4zUZvK4e
         lC6mPG8CKtICqvgL+LCkbZpkCPC41EpM5yd4u7xoXp0IcCgMwajBD33LDI5LsxW/tLVW
         y6PlZkH1e21sa/tVbMBaipc5EnzRyKkg+2Y5X5UrOJL+HbN1HdRb72eX5JdXMdxGLvDy
         /8Pw==
X-Gm-Message-State: AOAM533YFVuDsE2dZ9YAlqvHBiDTbdqzHB1mbBZ0+FQ9V151E8chgGpM
        XRCISrGiKuoAUYMZOJBt6Ie35595Gpfrpro=
X-Google-Smtp-Source: ABdhPJyzttHnj9zHmxZU6jm7klx3kEHjC4Jg/LsIuYnI614jmLZSGY9gei/2uiOZloZGh2hKapyF4uQoS76nWmM=
X-Received: from ramjiyani.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2edd])
 (user=ramjiyani job=sendgmr) by 2002:ac8:5b8e:: with SMTP id
 a14mr28502874qta.391.1635297558699; Tue, 26 Oct 2021 18:19:18 -0700 (PDT)
Date:   Wed, 27 Oct 2021 01:18:34 +0000
Message-Id: <20211027011834.2497484-1-ramjiyani@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH v5] aio: Add support for the POLLFREE
From:   Ramji Jiyani <ramjiyani@google.com>
To:     arnd@arndb.de, viro@zeniv.linux.org.uk, bcrl@kvack.org
Cc:     hch@lst.de, kernel-team@android.com, linux-aio@kvack.org,
        linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, oleg@redhat.com, ebiggers@kernel.org,
        Ramji Jiyani <ramjiyani@google.com>,
        Jeff Moyer <jmoyer@redhat.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the POLLFREE flag to force complete iocb inline in
aio_poll_wake(). A thread may use it to signal it's exit and/or request
to cleanup while pending poll request. In this case, aio_poll_wake()
needs to make sure it doesn't keep any reference to the queue entry
before returning from wake to avoid possible use after free via
poll_cancel() path.

UAF issue was found during binder and aio interactions in certain
sequence of events [1].

The POLLFREE flag is no more exclusive to the epoll and is being
shared with the aio. Remove comment from poll.h to avoid confusion.

[1] https://lore.kernel.org/r/CAKUd0B_TCXRY4h1hTztfwWbNSFQqsudDLn2S_28csgWZmZAG3Q@mail.gmail.com/

Fixes: af5c72b1fc7a ("Fix aio_poll() races")
Signed-off-by: Ramji Jiyani <ramjiyani@google.com>
Reviewed-by: Jeff Moyer <jmoyer@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Cc: stable@vger.kernel.org # 4.19+
---
Changes since v1:
- Removed parenthesis around POLLFREE macro definition as per review.
- Updated description to refer UAF issue discussion this patch fixes.
- Updated description to remove reference to parenthesis change.
- Added Reviewed-by from Jeff Moyer

Changes since v2:
- Added Fixes tag.
- Added stable tag for backporting on 4.19+ LTS releases

Changes since v3:
- Updated patch description
- Updated Fixes tag to issue manifestation origin

Changes since v4:
- Added Reviewed-by from Christoph Hellwig
---
 fs/aio.c                        | 45 ++++++++++++++++++---------------
 include/uapi/asm-generic/poll.h |  2 +-
 2 files changed, 26 insertions(+), 21 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 51b08ab01dff..5d539c05df42 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1674,6 +1674,7 @@ static int aio_poll_wake(struct wait_queue_entry *wait, unsigned mode, int sync,
 {
 	struct poll_iocb *req = container_of(wait, struct poll_iocb, wait);
 	struct aio_kiocb *iocb = container_of(req, struct aio_kiocb, poll);
+	struct kioctx *ctx = iocb->ki_ctx;
 	__poll_t mask = key_to_poll(key);
 	unsigned long flags;
 
@@ -1683,29 +1684,33 @@ static int aio_poll_wake(struct wait_queue_entry *wait, unsigned mode, int sync,
 
 	list_del_init(&req->wait.entry);
 
-	if (mask && spin_trylock_irqsave(&iocb->ki_ctx->ctx_lock, flags)) {
-		struct kioctx *ctx = iocb->ki_ctx;
+	/*
+	 * Use irqsave/irqrestore because not all filesystems (e.g. fuse)
+	 * call this function with IRQs disabled and because IRQs have to
+	 * be disabled before ctx_lock is obtained.
+	 */
+	if (mask & POLLFREE) {
+		/* Force complete iocb inline to remove refs to deleted entry */
+		spin_lock_irqsave(&ctx->ctx_lock, flags);
+	} else if (!(mask && spin_trylock_irqsave(&ctx->ctx_lock, flags))) {
+		/* Can't complete iocb inline; schedule for later */
+		schedule_work(&req->work);
+		return 1;
+	}
 
-		/*
-		 * Try to complete the iocb inline if we can. Use
-		 * irqsave/irqrestore because not all filesystems (e.g. fuse)
-		 * call this function with IRQs disabled and because IRQs
-		 * have to be disabled before ctx_lock is obtained.
-		 */
-		list_del(&iocb->ki_list);
-		iocb->ki_res.res = mangle_poll(mask);
-		req->done = true;
-		if (iocb->ki_eventfd && eventfd_signal_allowed()) {
-			iocb = NULL;
-			INIT_WORK(&req->work, aio_poll_put_work);
-			schedule_work(&req->work);
-		}
-		spin_unlock_irqrestore(&ctx->ctx_lock, flags);
-		if (iocb)
-			iocb_put(iocb);
-	} else {
+	/* complete iocb inline */
+	list_del(&iocb->ki_list);
+	iocb->ki_res.res = mangle_poll(mask);
+	req->done = true;
+	if (iocb->ki_eventfd && eventfd_signal_allowed()) {
+		iocb = NULL;
+		INIT_WORK(&req->work, aio_poll_put_work);
 		schedule_work(&req->work);
 	}
+	spin_unlock_irqrestore(&ctx->ctx_lock, flags);
+	if (iocb)
+		iocb_put(iocb);
+
 	return 1;
 }
 
diff --git a/include/uapi/asm-generic/poll.h b/include/uapi/asm-generic/poll.h
index 41b509f410bf..f9c520ce4bf4 100644
--- a/include/uapi/asm-generic/poll.h
+++ b/include/uapi/asm-generic/poll.h
@@ -29,7 +29,7 @@
 #define POLLRDHUP       0x2000
 #endif
 
-#define POLLFREE	(__force __poll_t)0x4000	/* currently only for epoll */
+#define POLLFREE	(__force __poll_t)0x4000
 
 #define POLL_BUSY_LOOP	(__force __poll_t)0x8000
 
-- 
2.33.0.1079.g6e70778dc9-goog

