Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A51543A827A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 16:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbhFOOTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 10:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbhFOORb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 10:17:31 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A7CCC061150
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 07:14:07 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id n12so11540899pgs.13
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 07:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b7apvPbQfTG1FYg2uNsocmvMG/QdC7c4RuzNmrGKxtc=;
        b=teEC3X5118RCoqRjDpVinxrBxb/ZnCm6ryA5hTE///DNJNJIJ7ry41IlzLM/WQ5RZi
         5rM29Gvy1WbJsWL0k3ucFdrxybEvdyBmK744/4SAfTdXMBCd9dtjzdV6h4lNYp1H3YAe
         RaY/wxthVmrWQYX778EfdTQbqgDLnqWYzbbAUF0xXFFqFVkE4KxZ564GQjL0iwdHK9zR
         QipmY/L7g/sua/MKoU4gAbpjYDQ8XMk0LrElfchchmEY96U4NRRm7211KAJCMtvD/tLG
         2zK0nUfsHKDTzh/XdBfdvD4OZrzHRQtNECYGSoQtBcAELiDzP1QZt2UELiaroy3e2M1k
         QF/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b7apvPbQfTG1FYg2uNsocmvMG/QdC7c4RuzNmrGKxtc=;
        b=sS8RWWmKtWjUessV8j6yMF4/xeXsG6MARUeyszgQsMILo6rc6V4SEw8KQtzfIfaQ4v
         CuSOEr6gILvz4rzZtu8qiNOkgIzwEq1DnPrIhbbqO4xrWn3bxQAeFAvEKN+mencGSFuy
         XVa36qU67sccsxeI6As9SbQ4EXV1CLuOTO84gg1vyYGrrlE62b4O4PbIYJCW7JGISETZ
         +SfzTj/cnnLtWFXkNSKsutYFXVCJnqHhhVakp8EqKdlzTiCYktkv0uImRLhMq5v/xQoV
         CubXOkOlJ2hoHRUOzoa56RTdHR0QG6Uf3BK7S5rdd79fpWaxR6nRXMWHiX/tzbdGNFFE
         cmYA==
X-Gm-Message-State: AOAM531o/YYjIrvtu3zA9dMOxKdE/oTw3o+lH4Kt1Np/wHvL/G7lNzLC
        6WPhP1E0E2bJ1LiGb1Jsdg+r
X-Google-Smtp-Source: ABdhPJzJT+1d1E8F4L3uwEMXEuWS3/RAonqjFcnOvR03YvpVA7eJh794mNzTaDsLprM6LBC/PxXhrA==
X-Received: by 2002:a63:9302:: with SMTP id b2mr3039614pge.277.1623766446912;
        Tue, 15 Jun 2021 07:14:06 -0700 (PDT)
Received: from localhost ([139.177.225.241])
        by smtp.gmail.com with ESMTPSA id d8sm16097026pfq.198.2021.06.15.07.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 07:14:06 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        sgarzare@redhat.com, parav@nvidia.com, hch@infradead.org,
        christian.brauner@canonical.com, rdunlap@infradead.org,
        willy@infradead.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
        bcrl@kvack.org, corbet@lwn.net, mika.penttila@nextfour.com,
        dan.carpenter@oracle.com, joro@8bytes.org,
        gregkh@linuxfoundation.org
Cc:     songmuchun@bytedance.com,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 03/10] eventfd: Increase the recursion depth of eventfd_signal()
Date:   Tue, 15 Jun 2021 22:13:24 +0800
Message-Id: <20210615141331.407-4-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210615141331.407-1-xieyongji@bytedance.com>
References: <20210615141331.407-1-xieyongji@bytedance.com>
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

