Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2066D41E356
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 23:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245358AbhI3V0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 17:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239542AbhI3V0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 17:26:43 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8481C06176A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 14:25:00 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id r11-20020a1c440b000000b0030cf0f01fbaso2476869wma.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 14:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FttxoUmTGZqK8PzCdxay9BYvxmAzHNrF7lkmGzarzCY=;
        b=njxNcCgjyJQUMrrZRbJiu4qjthHCE/FIowDL5hOf20zwioPiL+Kay3WRwdFuOy5sRM
         cVnM/19xvaZMY2Mt3iYhMU8yKx4hQN4HcqdOkp2NUI32lBjUbKrgeX2C1w5yhmwnQ6Yr
         NIucB+Yw82guAGarydkwH+87yVfZtlTJGvQjHfL/MHubD2WSN2gRA+aBOyVTzLGgQBSl
         POrGXq9WV1KTJkdPmR1iM0ihNSE3qlWvmah2N9sCzzJKv8eQx9cSxj4kbUNAZwhXhWh8
         fzzhl5C/wI3xpDCKi7mPo6N2rJKTch0nkTgl38Rh565G1a7e6rh1OTs08lK+iDfYIxn2
         zK8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FttxoUmTGZqK8PzCdxay9BYvxmAzHNrF7lkmGzarzCY=;
        b=YiA5oTo1n1fKklL+Mcz9JxNx7S2UiGv3pNcvXrzKhK9/IuIXxiGVFGz+w7haGddjY1
         de3FdERTTZDOdFnL8mt06xjoeXWZMWuxQr03cZRKPJ71btZ28imKdhe4pIbVDNuAir+D
         QKTQqw0jPO+G8mRpJF1dd7UtqkF3PCzDSDnZikyekP2AJpdYC8Zb7mAsOjXf9WJ2XEKW
         8KypjBQWfTs4aLxESExl6J3kf1yH0E8xxv/a45Z1uKiSwYzajB7HzawMZzVxzyrj57bW
         JJMyk+aRJCbNGnjVjwGUDE56EmCSQu5FPDUzLOGlPpXUHA2OYLKEPfqG8s8pwkHnDxXZ
         PRpg==
X-Gm-Message-State: AOAM531Gh/M1Svx2/Un1rI2nZu+vxtkijSUUb4zTDs/r//bdQWG9kZzp
        ah1dd1IkC637jZN0pxczL+s=
X-Google-Smtp-Source: ABdhPJxjifCgfgKQ8tqrkbM+P7BJCC84Al1vDEVZT1tXPJAEeGUp9hlyxqR+ZGc4QWiKwxxmTtg90A==
X-Received: by 2002:a05:600c:198c:: with SMTP id t12mr1206072wmq.128.1633037099136;
        Thu, 30 Sep 2021 14:24:59 -0700 (PDT)
Received: from localhost.localdomain ([197.49.49.194])
        by smtp.googlemail.com with ESMTPSA id f19sm4055478wmf.11.2021.09.30.14.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 14:24:58 -0700 (PDT)
From:   Sohaib Mohamed <sohaib.amhmd@gmail.com>
Cc:     Sohaib Mohamed <sohaib.amhmd@gmail.com>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] fs: 9p: cache.h: cleanup some format warning
Date:   Thu, 30 Sep 2021 23:24:54 +0200
Message-Id: <20210930212455.30047-1-sohaib.amhmd@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Warnings found by checkpatch.pl

Signed-off-by: Sohaib Mohamed <sohaib.amhmd@gmail.com>
---
 fs/9p/cache.h | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/9p/cache.h b/fs/9p/cache.h
index 00f107af443e..14fd222352f3 100644
--- a/fs/9p/cache.h
+++ b/fs/9p/cache.h
@@ -34,7 +34,7 @@ extern int __v9fs_readpage_from_fscache(struct inode *inode,
 extern int __v9fs_readpages_from_fscache(struct inode *inode,
 					 struct address_space *mapping,
 					 struct list_head *pages,
-					 unsigned *nr_pages);
+					 unsigned int *nr_pages);
 extern void __v9fs_readpage_to_fscache(struct inode *inode, struct page *page);
 extern void __v9fs_fscache_wait_on_page_write(struct inode *inode,
 					      struct page *page);
@@ -59,7 +59,7 @@ static inline int v9fs_readpage_from_fscache(struct inode *inode,
 static inline int v9fs_readpages_from_fscache(struct inode *inode,
 					      struct address_space *mapping,
 					      struct list_head *pages,
-					      unsigned *nr_pages)
+					      unsigned int *nr_pages)
 {
 	return __v9fs_readpages_from_fscache(inode, mapping, pages,
 					     nr_pages);
@@ -75,6 +75,7 @@ static inline void v9fs_readpage_to_fscache(struct inode *inode,
 static inline void v9fs_uncache_page(struct inode *inode, struct page *page)
 {
 	struct v9fs_inode *v9inode = V9FS_I(inode);
+
 	fscache_uncache_page(v9inode->fscache, page);
 	BUG_ON(PageFsCache(page));
 }
@@ -115,7 +116,7 @@ static inline int v9fs_readpage_from_fscache(struct inode *inode,
 static inline int v9fs_readpages_from_fscache(struct inode *inode,
 					      struct address_space *mapping,
 					      struct list_head *pages,
-					      unsigned *nr_pages)
+					      unsigned int *nr_pages)
 {
 	return -ENOBUFS;
 }
@@ -129,9 +130,7 @@ static inline void v9fs_uncache_page(struct inode *inode, struct page *page)
 
 static inline void v9fs_fscache_wait_on_page_write(struct inode *inode,
 						   struct page *page)
-{
-	return;
-}
+{}
 
 #endif /* CONFIG_9P_FSCACHE */
 #endif /* _9P_CACHE_H */
-- 
2.25.1

