Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 113923828EB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 11:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236269AbhEQJ5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 05:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236199AbhEQJ5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 05:57:20 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56CFDC06138A
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 02:56:04 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id w1so1915319pfu.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 02:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b2jCEx8mi3vXgkJ9kkatzIPCmNDeaAe/ogyF3BNTwbw=;
        b=BIAa64R4y9k3Eg3WHj2S666iigdAlamttMFasFKl0/os5LVtgYGUotdFoSEHugW/Eu
         bPRzaxAW284e8L8yo2K3DDL0/T8tA/l8wgLVMmAmo6+IhFLW/GYToPaLLl355N+97G5L
         XexcA5aHvM9w2PGt9fWa2k/dVGxtVldmNsYPnqawOun42Yk2znLlV60hSNjDq7IYxrSR
         /MfnGeT4tFvQVkSyH11nQ65tEhzqJ/jZPaGxLuLbESIf2R6H7QaYs485JdPrsXqE7dOf
         I4DwWEpiBqfQ6lw4Z+Sbeqdk137WXiyVzbQGXwJPtZ+TTYkfwjFV4U35eCpK8JW0Dmto
         ErvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b2jCEx8mi3vXgkJ9kkatzIPCmNDeaAe/ogyF3BNTwbw=;
        b=A8NtECui75sEI429ldeklrvQ6p2ZZzz7jTbPH7yYDPOqR7ht3sLqBM9fbwUeSWSjim
         cUSl7Bc1cWSi4UQWtn+ljTylZ/LunDLSO3hWyRkiMEZMv4NCueMtkaZyibjHG5tyGUN+
         IfLz4s/jkbZYiO/1X5233ctUZ9lFqFaAkAerx2pAiy2U5QXxjykuv6QoedO1vh7S/3Kl
         GGZOTAaWjtETfNJavZRS2bMhg/pq/ACte51+fpSIP6WMBnT2fXDJvvn0lp9IGP0ssJOM
         4NrfuzwBgaPV9T8BZ/nXBPwwXtYr9DiHgpctSm7s2OsktCYU8mmuqyD9uAJ9TqtKsY3h
         eGFA==
X-Gm-Message-State: AOAM533K1g0i/+k3nxAKKh5n1UaXSkfnx9EeWwkJU37PXku2+KWVYOLj
        QFw4ocrDJpwQcxXjA3tcFume
X-Google-Smtp-Source: ABdhPJxMHtpizSq6PPRichE5BBR0ifuwPYTxOEXD/Wu/CUyxhwu/aKM7AbIbvC3ahRVJo9npK3SCVw==
X-Received: by 2002:a63:d45:: with SMTP id 5mr1321436pgn.72.1621245363924;
        Mon, 17 May 2021 02:56:03 -0700 (PDT)
Received: from localhost ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id gz18sm8486949pjb.19.2021.05.17.02.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 02:56:03 -0700 (PDT)
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
Subject: [PATCH v7 02/12] file: Export receive_fd() to modules
Date:   Mon, 17 May 2021 17:55:03 +0800
Message-Id: <20210517095513.850-3-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210517095513.850-1-xieyongji@bytedance.com>
References: <20210517095513.850-1-xieyongji@bytedance.com>
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
index f633348029a5..ef4da2eaf25b 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -1135,6 +1135,12 @@ int __receive_fd(int fd, struct file *file, int __user *ufd, unsigned int o_flag
 	return new_fd;
 }
 
+int receive_fd(struct file *file, unsigned int o_flags)
+{
+	return __receive_fd(-1, file, NULL, o_flags);
+}
+EXPORT_SYMBOL_GPL(receive_fd);
+
 static int ksys_dup3(unsigned int oldfd, unsigned int newfd, int flags)
 {
 	int err = -EBADF;
diff --git a/include/linux/file.h b/include/linux/file.h
index 225982792fa2..4667f9567d3e 100644
--- a/include/linux/file.h
+++ b/include/linux/file.h
@@ -94,6 +94,9 @@ extern void fd_install(unsigned int fd, struct file *file);
 
 extern int __receive_fd(int fd, struct file *file, int __user *ufd,
 			unsigned int o_flags);
+
+extern int receive_fd(struct file *file, unsigned int o_flags);
+
 static inline int receive_fd_user(struct file *file, int __user *ufd,
 				  unsigned int o_flags)
 {
@@ -101,10 +104,6 @@ static inline int receive_fd_user(struct file *file, int __user *ufd,
 		return -EFAULT;
 	return __receive_fd(-1, file, ufd, o_flags);
 }
-static inline int receive_fd(struct file *file, unsigned int o_flags)
-{
-	return __receive_fd(-1, file, NULL, o_flags);
-}
 static inline int receive_fd_replace(int fd, struct file *file, unsigned int o_flags)
 {
 	return __receive_fd(fd, file, NULL, o_flags);
-- 
2.11.0

