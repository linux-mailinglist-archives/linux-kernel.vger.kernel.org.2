Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3677F3A8275
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 16:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbhFOOTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 10:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbhFOOR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 10:17:27 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F80C0613A3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 07:14:02 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id g24so11858911pji.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 07:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x7lCOA+2uHcoDlHpnAPiyr08qHLnKknrRwhD42bW14c=;
        b=Q98Ihm2Nik3q5vdP0zcSt08K34vWS/rvAoSEN52J/uuTlzvnsiNq88Z5ucJKY0yf4T
         WFJOezngtVgbaHQTYK9IFHEeP7OPorUcohm0GpwG5OPARKnRlnDiuj+ZSJdIkZhENFhP
         Vq0P8aiksUKM/urNGX/K/vS0M5QV+Ai6ruEHeoTG1ZqikOBMRgtepe++5r/KmuRM0Wp7
         fQBL37D40now9tM5jNX9bzTs/tFtUeKXIWuG8uRaMPZOawdA+TREx5a2jmwy7Z5WlYma
         oneZ7pit7q6XulGSMFYPI+9TNvoTTQj76XvP+orlujxi0oRlAXS8GnDtyHjoFs7/bu4w
         pIwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x7lCOA+2uHcoDlHpnAPiyr08qHLnKknrRwhD42bW14c=;
        b=hh9NtZpvlP+6NomE7ITBMbo1JF6TUTP5qU+bl2OphZoX7tBqCVQIV9taRF2iCe0J8J
         8puRobmjIqXUKsLtYSuBZ7E+1XQ74LZzSjJrxLSPMs9W6p8ROVxhVcKVh8HvyDxbn3Wn
         p1MMmFkwZS/WAtRm7kTNWoNj4uOrLschIlP+Tw3YEeBnBLEA10+yXl34i3J0Dg7vEIIa
         Btxu/4ihKYeaZ7DvcUU7KeXsz2/NJId0FT+8fgk3xRcP1DFr9RcNHNQR86Ec/FjnqhBv
         FmGEfPcbpXbTFxk/z47rKOotfDLakEXnOGeRYasb5gAM/+x/eMQezYt2uJYCAjhOfjv1
         Z/DA==
X-Gm-Message-State: AOAM533FDNjMCdIkMk6KRfHnkT05hWT8/9nzDmhkeo9m2kpac/0WhDKa
        MnkwqCloI+hlqE/TY8YHq4ka
X-Google-Smtp-Source: ABdhPJyMTsqXCPkyBqwNtnh8NXZihbFI2JopRQ8BKBQqq64DywQJiFaJ/V9M6qRN7G+4EeFFkHyAjg==
X-Received: by 2002:a17:90b:b18:: with SMTP id bf24mr25002261pjb.220.1623766442317;
        Tue, 15 Jun 2021 07:14:02 -0700 (PDT)
Received: from localhost ([139.177.225.241])
        by smtp.gmail.com with ESMTPSA id u13sm16031239pga.64.2021.06.15.07.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 07:14:01 -0700 (PDT)
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
Subject: [PATCH v8 02/10] file: Export receive_fd() to modules
Date:   Tue, 15 Jun 2021 22:13:23 +0800
Message-Id: <20210615141331.407-3-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210615141331.407-1-xieyongji@bytedance.com>
References: <20210615141331.407-1-xieyongji@bytedance.com>
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

