Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ADE041B7BC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 21:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242563AbhI1Tqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 15:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242539AbhI1Tqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 15:46:54 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F98C061746
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 12:45:14 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id q17-20020a25b591000000b005a07d27bbdaso139031ybj.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 12:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=0asOvLyaIQidtaf+APJitxjeC5t6EzgqSyv0pg+UdAU=;
        b=oo+4dH0tmRYRu3ihXVqY8P4fx0PEAUQCYZqvytcW0mJnDZZhOsxWgnftB4Qm0yiQfO
         K3cu53AfTC8BvblOGKuoRWtb2RKVyJCF4YiAK8cePqBFJapNCYrsthov4irYC6OuejP5
         9hM+YxA5AaueYCMD4zeWjjNlXOBfZnVYQ2uWmvf1f+NDxMV6qvrwCf+KcpRCMQMa8ZCE
         m1TfsVcFiEMp0aBSFUEuWgLJyK/Y0foEPCAXtTzIV40Q0JAG2XYDsQV65pq2g7PAOQyk
         dhyBIz0iQRzG/AkqJ/SZD3LOixm9lVN9lzNRDSji+Xk3Sr1nNFGX7XUzQeZq1JD6igVJ
         ln9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=0asOvLyaIQidtaf+APJitxjeC5t6EzgqSyv0pg+UdAU=;
        b=hmpxr6n3/LSgz+jZpXcepd/zqos0djJTdr2eaN1IM9pdPuIUCaSPiFn7VowNcVLKET
         cNph6PDEsSONaJtP1/nX7b7HXyxfIS3Xe0yq73e0zHtRGPJAtE8zR85xKGYJT+oVQK08
         5yDtc1MEowLXylMRf3RwQnUhDgaCeAPp1mzpA6pHOu9QvAAYQ+emo6xgQT31AflhWJLu
         1YJf5ZUecqtp/XhGDb3hTKNfIlrczM38QcV0HsIQNiIlWgzLJKZHcmtseEfbhhMAe+wM
         ibv5L2R7sEkuIPXOU8ewFyHxKRqI36dbtEIpO/ojDwgzhdLmHfxRcFSQwhpY6fK8R00E
         YWSA==
X-Gm-Message-State: AOAM533QSsi8UrF9eUtPR+LcPWlTiM8RgSTChl7AXUKIIcTe+B000JzT
        0qAwbxffrEqX1DzcI2GhkLSMtgXOX/cpPMk=
X-Google-Smtp-Source: ABdhPJzyvV1I7IuAvJ14k/hSlbEmdhT+ANufpfkpujJTOMmzp36i4I++jCbNBHsDaNuXpEOWS8uMtCp298nZWho=
X-Received: from ramjiyani.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2edd])
 (user=ramjiyani job=sendgmr) by 2002:a25:acd1:: with SMTP id
 x17mr8429840ybd.51.1632858313987; Tue, 28 Sep 2021 12:45:13 -0700 (PDT)
Date:   Tue, 28 Sep 2021 19:45:08 +0000
Message-Id: <20210928194509.4133465-1-ramjiyani@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
Subject: [RESEND PATCH] aio: Add support for the POLLFREE
From:   Ramji Jiyani <ramjiyani@google.com>
To:     Benjamin LaHaise <bcrl@kvack.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Ramji Jiyani <ramjiyani@google.com>, kernel-team@android.com,
        linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
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
Also enclosed the POLLFREE macro definition in parentheses to fix
checkpatch error.

Signed-off-by: Ramji Jiyani <ramjiyani@google.com>
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
index 41b509f410bf..35b1b69af729 100644
--- a/include/uapi/asm-generic/poll.h
+++ b/include/uapi/asm-generic/poll.h
@@ -29,7 +29,7 @@
 #define POLLRDHUP       0x2000
 #endif
 
-#define POLLFREE	(__force __poll_t)0x4000	/* currently only for epoll */
+#define POLLFREE	((__force __poll_t)0x4000)
 
 #define POLL_BUSY_LOOP	(__force __poll_t)0x8000
 
-- 
2.33.0.685.g46640cef36-goog

