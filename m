Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3314F3C6C55
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 10:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234896AbhGMIu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 04:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234867AbhGMIuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 04:50:22 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0BF7C06178C
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 01:47:30 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id h4so20997529pgp.5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 01:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x7lCOA+2uHcoDlHpnAPiyr08qHLnKknrRwhD42bW14c=;
        b=drxf3oJhygPSsqt71Ess67rxf+ndIQUhAGvJBQ7FfJc0EFN26/FzOtRTtC7PVm1UpN
         kQbh6cvZeXqEDwoNx0CPkFun1o95KcC72J/BrRHyWrL8j1ckCdBhsQrNaMArojnrxTDL
         EmSaEel9rQLb9Sl4sGu/b4+LJvaPa8chJvARj9AOwsZWRs4OZF+vghBIiQsIsYm4M9Ea
         tM/aLM4LHw9LpWwiWBNz+lg0l70CKpTeZGSiDnx8VQaiPHKV/RYUAN0tySvpbSXIWg/n
         CsQiMon3tJMRQHkqUdGOISGCwJp1P5f62r4sA52w48rVbKC6WaqVP0H4fqQAmdZ4e0TS
         niRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x7lCOA+2uHcoDlHpnAPiyr08qHLnKknrRwhD42bW14c=;
        b=mMfZQXBc3OCF/K/7mjIIryrPzXwhhhuJA+1nEFSxa79m7jRyX0DD3iXQkJSfpteH9z
         Xzzs9imAOBTxq5F8XnjCVSTbRqapfdmLzZJtiV+t8t2+QIlYsXQEG70TsilAFIoTrGZL
         WBI3eHeSleRPCvcKEyXvY98GHzRNruz0jvd2MthH95gVOPzsgOARuJO7U+17GcX5XRJj
         NioWYf27qN/lKRTqF27+5cham4I8YKQJFcf2I/qjiqQShjt/XZNsYGU1ulczWQKOUte3
         PjPEie+Uzf5+esyRv4bHT4kzIUXMNiGCgrJDAO2pfvCwJIRGshmwhXBvIPxSnb0V5Pbu
         tw7w==
X-Gm-Message-State: AOAM532Nci+wUvmOESdkFamKkWLz/5xiaby0uWPYn1nkEH1SRV08WCo+
        KAalYYo8gHWhob29IpvtsDA+
X-Google-Smtp-Source: ABdhPJwdRaHRXTGGcq8TKcIstM4ONkFGUJKEp5Fy9XmDOpn7i0jIsKMl/HA/2cyBqJh1EcfH1oJiyQ==
X-Received: by 2002:a63:5802:: with SMTP id m2mr3270429pgb.171.1626166050321;
        Tue, 13 Jul 2021 01:47:30 -0700 (PDT)
Received: from localhost ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id z12sm15702430pjd.39.2021.07.13.01.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 01:47:29 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        sgarzare@redhat.com, parav@nvidia.com, hch@infradead.org,
        christian.brauner@canonical.com, rdunlap@infradead.org,
        willy@infradead.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
        bcrl@kvack.org, corbet@lwn.net, mika.penttila@nextfour.com,
        dan.carpenter@oracle.com, joro@8bytes.org,
        gregkh@linuxfoundation.org, zhe.he@windriver.com,
        xiaodong.liu@intel.com
Cc:     songmuchun@bytedance.com,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH v9 02/17] file: Export receive_fd() to modules
Date:   Tue, 13 Jul 2021 16:46:41 +0800
Message-Id: <20210713084656.232-3-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210713084656.232-1-xieyongji@bytedance.com>
References: <20210713084656.232-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export receive_fd() so that some modules can use
it to pass file descriptor between processes without
missing any security stuffs.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 fs/file.c            | 6 ++++++
 include/linux/file.h | 7 +++----
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index 86dc9956af32..210e540672aa 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -1134,6 +1134,12 @@ int receive_fd_replace(int new_fd, struct file *file, unsigned int o_flags)
 	return new_fd;
 }
 
+int receive_fd(struct file *file, unsigned int o_flags)
+{
+	return __receive_fd(file, NULL, o_flags);
+}
+EXPORT_SYMBOL_GPL(receive_fd);
+
 static int ksys_dup3(unsigned int oldfd, unsigned int newfd, int flags)
 {
 	int err = -EBADF;
diff --git a/include/linux/file.h b/include/linux/file.h
index 2de2e4613d7b..51e830b4fe3a 100644
--- a/include/linux/file.h
+++ b/include/linux/file.h
@@ -94,6 +94,9 @@ extern void fd_install(unsigned int fd, struct file *file);
 
 extern int __receive_fd(struct file *file, int __user *ufd,
 			unsigned int o_flags);
+
+extern int receive_fd(struct file *file, unsigned int o_flags);
+
 static inline int receive_fd_user(struct file *file, int __user *ufd,
 				  unsigned int o_flags)
 {
@@ -101,10 +104,6 @@ static inline int receive_fd_user(struct file *file, int __user *ufd,
 		return -EFAULT;
 	return __receive_fd(file, ufd, o_flags);
 }
-static inline int receive_fd(struct file *file, unsigned int o_flags)
-{
-	return __receive_fd(file, NULL, o_flags);
-}
 int receive_fd_replace(int new_fd, struct file *file, unsigned int o_flags);
 
 extern void flush_delayed_fput(void);
-- 
2.11.0

