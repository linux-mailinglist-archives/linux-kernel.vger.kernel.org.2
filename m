Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6743828EE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 11:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236232AbhEQJ5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 05:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236239AbhEQJ5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 05:57:25 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C3FC061343
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 02:56:08 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id j12so4279571pgh.7
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 02:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b7apvPbQfTG1FYg2uNsocmvMG/QdC7c4RuzNmrGKxtc=;
        b=lXRHbHSIsb1KADw2tX2zKstf7SBlVEY4DtJnDMFT3EHKIWMje067JnmjgrkNReUxPn
         I0z2aIAyJGaL9m4k2OpOD29iaKpNcW4xfR7d14dIuNrPK0hQOvA8kl9rxSPc6f69Mm6p
         R0F2LeWEZA0PPqOKTYoBW3+9nQSkYxFKNz5WUEn2djE6598CZ00wKdFzTggwdy8opqtd
         +LicmUYFz5R2JqJ3r3lQ/vDv0gKToNlIKrKEdVnqYs5TGR2EJsU3XPEKupH3aVQAL9FE
         3exCZ90aL2Cb7tTVwr9v8iYtnhbog2Qo9fEaKaJOYYh61niFj77C/LAndUBtJYYe86bM
         nS5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b7apvPbQfTG1FYg2uNsocmvMG/QdC7c4RuzNmrGKxtc=;
        b=QtIKGfOW8dvZW/wzEJ9JbYjBDaPkWYxy7TAzuQdHI61wzihOoiXDrplD3Vb7l/Tmr5
         2vqpRHJTDMTpaHTImuDB0q4r08fnLAVIDLruCgtsJncsaIsd3y7N8p2iFRi75uxjf+0o
         RLJ5WCpyPyDDHJgd3hH5+pcXlxMZutTcf94Xagot5Pa0iOVPvFpSO+kEfs0fLppcJbYW
         P3AjY9lX9iWoTVw9eCS6JXl+fdhpjafLpH52F3focT0BDTn40BOUxglHTo4ZhQRbskHE
         0KdjRl0B15UbRF4kmlVx6Dlv3P9Lv1OYFw7oYYmniC0BGs/os3IErRYx02XiUpuB22Xo
         N9Ww==
X-Gm-Message-State: AOAM531/l786lKBiNgtHLFLXyefHr1g0Rig/4SWwF+PD5uDkPVjdGd87
        N0fK7XBm39CXebAa9rv12Jx8
X-Google-Smtp-Source: ABdhPJwO1N2BTDcGIAdEBE1GwKwtKYl5hxzWv7M8ro+LthKkIXN/GYpMnfpVi6rAWoY6mIGZm1TWzA==
X-Received: by 2002:a63:741e:: with SMTP id p30mr61016414pgc.68.1621245368362;
        Mon, 17 May 2021 02:56:08 -0700 (PDT)
Received: from localhost ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id 24sm10063099pgz.77.2021.05.17.02.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 02:56:07 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        sgarzare@redhat.com, parav@nvidia.com, hch@infradead.org,
        christian.brauner@canonical.com, rdunlap@infradead.org,
        willy@infradead.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
        bcrl@kvack.org, corbet@lwn.net, mika.penttila@nextfour.com,
        dan.carpenter@oracle.com, joro@8bytes.org
Cc:     virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 03/12] eventfd: Increase the recursion depth of eventfd_signal()
Date:   Mon, 17 May 2021 17:55:04 +0800
Message-Id: <20210517095513.850-4-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210517095513.850-1-xieyongji@bytedance.com>
References: <20210517095513.850-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Increase the recursion depth of eventfd_signal() to 1. This
is the maximum recursion depth we have found so far, which
can be triggered with the following call chain:

    kvm_io_bus_write                        [kvm]
      --> ioeventfd_write                   [kvm]
        --> eventfd_signal                  [eventfd]
          --> vhost_poll_wakeup             [vhost]
            --> vduse_vdpa_kick_vq          [vduse]
              --> eventfd_signal            [eventfd]

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 fs/eventfd.c            | 2 +-
 include/linux/eventfd.h | 5 ++++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/eventfd.c b/fs/eventfd.c
index e265b6dd4f34..cc7cd1dbedd3 100644
--- a/fs/eventfd.c
+++ b/fs/eventfd.c
@@ -71,7 +71,7 @@ __u64 eventfd_signal(struct eventfd_ctx *ctx, __u64 n)
 	 * it returns true, the eventfd_signal() call should be deferred to a
 	 * safe context.
 	 */
-	if (WARN_ON_ONCE(this_cpu_read(eventfd_wake_count)))
+	if (WARN_ON_ONCE(this_cpu_read(eventfd_wake_count) > EFD_WAKE_DEPTH))
 		return 0;
 
 	spin_lock_irqsave(&ctx->wqh.lock, flags);
diff --git a/include/linux/eventfd.h b/include/linux/eventfd.h
index fa0a524baed0..886d99cd38ef 100644
--- a/include/linux/eventfd.h
+++ b/include/linux/eventfd.h
@@ -29,6 +29,9 @@
 #define EFD_SHARED_FCNTL_FLAGS (O_CLOEXEC | O_NONBLOCK)
 #define EFD_FLAGS_SET (EFD_SHARED_FCNTL_FLAGS | EFD_SEMAPHORE)
 
+/* Maximum recursion depth */
+#define EFD_WAKE_DEPTH 1
+
 struct eventfd_ctx;
 struct file;
 
@@ -47,7 +50,7 @@ DECLARE_PER_CPU(int, eventfd_wake_count);
 
 static inline bool eventfd_signal_count(void)
 {
-	return this_cpu_read(eventfd_wake_count);
+	return this_cpu_read(eventfd_wake_count) > EFD_WAKE_DEPTH;
 }
 
 #else /* CONFIG_EVENTFD */
-- 
2.11.0

