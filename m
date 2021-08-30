Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A32EC3FB801
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 16:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237289AbhH3OXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 10:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237209AbhH3OW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 10:22:58 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47161C061764
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 07:22:05 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id 18so12300920pfh.9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 07:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CkhRtVDUgb41zlq5OfgVAHJFRMwL0PptQO/kVg6fccA=;
        b=PtF0MmvzQ3aNxBPG1DhD6uEui9rZ2X7xOJKS7RoGdzb1WNZ0Paezvg4hjgjTDi9L9E
         tmINiWUlulvd8FBlNdqzf3yLgsPpaaYvV2hHbRT1Tx4U2t05e3QTUFQ9c+Bc9xPI9u1M
         LV16Rw80XJKCMtLWBy4cKOIoXoGf3lTmhWNH3JHXNwHB7TmPcEtrur4lP4dijYAMj5de
         LCFrSj/HHwcU+Tx1Se/wO+59+ogmNHkzjq4KZIpC9+LnJH68BtyEw00md2A0eqqSwOM2
         GwirGPhAkMn1fhn6zl9S8XW5A8HJ0NynS8yR0T6sVGuPh4JuNKRlokpKqEh8eIQQatSJ
         UtMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CkhRtVDUgb41zlq5OfgVAHJFRMwL0PptQO/kVg6fccA=;
        b=hS3jiF0ZVnYti8iteShAg0wQ35WEcLT+mL05QthWHR4lstkNZex31MmSQHC4xlKLGq
         LLz2aogW4GT2ZhiQOF9ozM5s02OhseDEbGgCZ0Lb0OqSDyEWHqLN0LwBpl5rJHcEdhP3
         MwXqdG2/U9vtUhW6U072TORieocqDpbcbPVbWsK8t0XY+0oBgMMAbeCXYNjKK962yYxJ
         dorH7NctTvs3qU9ESKrdPayw2+IeQUV5asAjCh8canOpVemBSWnp0Unkvqr1Oc2G+G9+
         9VKZUDsBuOS6yuDYcwLn8evkwa+i/VvL+TmqF61TLDLjRK4bfoi9/B1PZyM3WUdys3XK
         lrXA==
X-Gm-Message-State: AOAM5321gj5FKqXAfYLiH5QpEL2SkLkh4rhhmeif+Yvx8fnsDW6Srkv3
        0IWRLNzEO7DY+/I2txBYcroW
X-Google-Smtp-Source: ABdhPJxm7cudNHvI9FsL63eCLI5rNFAX3FYOQEJSl53ZSWaAz0jzpso6pnHbFXng3EkPeZB4X8SZQA==
X-Received: by 2002:aa7:83d0:0:b029:3c6:7261:ecb with SMTP id j16-20020aa783d00000b02903c672610ecbmr23747850pfn.61.1630333324827;
        Mon, 30 Aug 2021 07:22:04 -0700 (PDT)
Received: from localhost ([139.177.225.237])
        by smtp.gmail.com with ESMTPSA id i14sm14892396pfd.112.2021.08.30.07.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 07:22:04 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        sgarzare@redhat.com, parav@nvidia.com, hch@infradead.org,
        christian.brauner@canonical.com, rdunlap@infradead.org,
        willy@infradead.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
        bcrl@kvack.org, corbet@lwn.net, mika.penttila@nextfour.com,
        dan.carpenter@oracle.com, joro@8bytes.org,
        gregkh@linuxfoundation.org, zhe.he@windriver.com,
        xiaodong.liu@intel.com, joe@perches.com, robin.murphy@arm.com,
        will@kernel.org, john.garry@huawei.com
Cc:     songmuchun@bytedance.com,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH v12 03/13] file: Export receive_fd() to modules
Date:   Mon, 30 Aug 2021 22:17:27 +0800
Message-Id: <20210830141737.181-4-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210830141737.181-1-xieyongji@bytedance.com>
References: <20210830141737.181-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export receive_fd() so that some modules can use
it to pass file descriptor between processes without
missing any security stuffs.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
Acked-by: Jason Wang <jasowang@redhat.com>
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

