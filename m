Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4C6424787
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 21:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239406AbhJFTw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 15:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbhJFTwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 15:52:54 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4806C061746
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 12:51:01 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id e6-20020a0cb446000000b0037eeb9851dfso3550106qvf.17
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 12:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=MHNhaL2DhBIuWauDT+vtiCzNM89DP5+QrC3jaOOyiBk=;
        b=lfwJqX8cqAa7haAscR+/jA/gMlLMc6ZzbrNcb7IGffT2S2ilBqvEpTf5Wyls7a3fvX
         Itt6ZdQhhQB/kmP25gyo5s8spF+oQ4yalSQQhZiIHgNnLjUwYaRp0/aTpEJReTWervAc
         l7czNl7BHdlTjgJLobOfMv5ImWxrLcGrDWnfTy8tm/zODh0FxWSSKO1IKKqcp2mH9vvl
         xbQpX6BbL8ONk7/oDTQUXgnoLkzXPVD60RJUzmaAU10+5pQi3rhsnIrApiDM46PxtsqT
         gNnyTYTpM9Rwjz34lGTCyLxij6elj9Dhw9VmcvF9aXc93cVkOKO9ChOKpvJ45+PSyWPP
         cXNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=MHNhaL2DhBIuWauDT+vtiCzNM89DP5+QrC3jaOOyiBk=;
        b=2QAREaX1lMIzj0FXplr/w0KZ2lu8eazYZVhS0BSES2ubjYaXbRiG1MdbEr8oeDkv7S
         SCyq8eNeSzcWhs/9/4K6wxqky2R5P/ULBWnGRdV333cl9BmVJdX8WkW61xuxfc6UYbo1
         8UGLaJXvgrQUXlCuqOznOr8K+gOKf4hHKKLWFILZBYfLJvLa2nc3cPb8JHa4lO8tJv/8
         HCjU9Rt/hIlTdJxAKim8W66Icb0FhgyuIMUycGpf5uxNqIRKz+3vWux5M7tJL0dBCdhj
         sqBcjcfiakww4ou9HOXuDK4xldxyACxDsDPw3ssMMy8Z/ZXc8N5GdurL9mWBJiAj+/33
         nSKQ==
X-Gm-Message-State: AOAM532ScC0bI6XKJOCIYmzhQ6NKdvd/Tk0Zz7K9yzosJi5mJ15HGEjT
        hL6imieTx00LHz699oJH26d+OdDzaCO6VZU=
X-Google-Smtp-Source: ABdhPJw5D7IIy6F7bebRd9XmMqbRLXvN0obnA6CCI/+0rNwfiD2DZ6KoyuHo+S1HESRhrU9T6rqFFhpwLEq0lO8=
X-Received: from ramjiyani.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2edd])
 (user=ramjiyani job=sendgmr) by 2002:ac8:cf:: with SMTP id
 d15mr85681qtg.416.1633549860871; Wed, 06 Oct 2021 12:51:00 -0700 (PDT)
Date:   Wed,  6 Oct 2021 19:50:29 +0000
Message-Id: <20211006195029.532034-1-ramjiyani@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
Subject: [PATCH v2] aio: Add support for the POLLFREE
From:   Ramji Jiyani <ramjiyani@google.com>
To:     arnd@arndb.de, viro@zeniv.linux.org.uk, bcrl@kvack.org
Cc:     hch@lst.de, kernel-team@android.com, linux-aio@kvack.org,
        linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        oleg@redhat.com, Ramji Jiyani <ramjiyani@google.com>,
        Jeff Moyer <jmoyer@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit f5cb779ba163 ("ANDROID: binder: remove waitqueue when thread
exits.") fixed the use-after-free in eventpoll but aio still has the
same issue because it doesn't honor the POLLFREE flag.

Add support for the POLLFREE flag to force complete iocb inline in
aio_poll_wake(). A thread may use it to signal it's exit and/or request
to cleanup while pending poll request. In this case, aio_poll_wake()
needs to make sure it doesn't keep any reference to the queue entry
before returning from wake to avoid possible use after free via
poll_cancel() path.

The POLLFREE flag is no more exclusive to the epoll and is being
shared with the aio. Remove comment from poll.h to avoid confusion.

This fixes a use after free issue between binder thread and aio
interactions in certain sequence of events [1].

[1] https://lore.kernel.org/all/CAKUd0B_TCXRY4h1hTztfwWbNSFQqsudDLn2S_28csgWZmZAG3Q@mail.gmail.com/

Signed-off-by: Ramji Jiyani <ramjiyani@google.com>
Reviewed-by: Jeff Moyer <jmoyer@redhat.com>
---
Changes since v1:
- Removed parenthesis around POLLFREE macro definition as per review.
- Updated description to refer UAF issue discussion this patch fixes.
- Updated description to remove reference to parenthesis change.
- Added Reviewed-by
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
2.33.0.800.g4c38ced690-goog

