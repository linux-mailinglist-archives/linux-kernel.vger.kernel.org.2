Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98FC23EF72B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 03:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237470AbhHRBIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 21:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236061AbhHRBHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 21:07:50 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B148C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 18:07:16 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id q21so1941163ljj.6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 18:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tMEOQb478MirVZ4PNVB8KP4GAWyRowJiqiV9ITepmh8=;
        b=a/mKBpuC+uzUwqMhGIIeCuzlyvBxzuKUtXdHFRJmcEaV0BpWRusszfsY1ZsH9LJCwn
         QCVjz+Yk2SBz/V9YWMprKbPXMoF4fwWIx8rGLGKTN2kj1gj5tJj9B1ijlmb17Rtyy2Lp
         OQJZVfCdH1/C5zJQkp7nWYAGW7Opc87+USiRqGDKo9pXXrtnt7pYKOGEO4WvAiVjJQJ/
         VN7OZ/C3URaacU7DVAnpsq8VD+iR0Rb+Oa89FDKXyn8WUKo8jBVAZhMq/jgV5Rn0xN44
         qRWO7ih5s9d0FUYwh1bZpz7UgYUsclvz+mt+FNw/jLW6ELm6JieCIOYv1K44FDlqJh9h
         V2dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tMEOQb478MirVZ4PNVB8KP4GAWyRowJiqiV9ITepmh8=;
        b=bhUbkpGfFVZdnLPIdUK0uFRr060R/66BSWmpQ9vSdKe6suoVunoq9QbhGe2jxdTEJd
         K+H0YS3xgKXGHNnvltCJXqcP18pFIJvb/2pQNJpGSW9rqSXODeUhnyjWC/Fzj6zGozEV
         rxHBPCx15OvykhYh/p/8m4qxiqECXCKE5jazFKpQL2NokB6onN61uB3AKjfSudKTPoa3
         9gfoUvYC9JLcaXNugJHisHMOQZEGAyzfKRCPZNQDetkSvebV/xx0Z/nzTPUXi5qO8TX+
         fi3G3HcWuPAjIAp6wbOYV7HC5WMTxyM1/r5RKHU20Ka7dTYZYqcENBEu0n+jauqHEuiG
         t5CQ==
X-Gm-Message-State: AOAM533ntJRnwqgR+uMdH4G9L3Oi4zLRofBb3tMYe+Vd1kwUO5Jnpp86
        9sMqZMqV4UlHnpg6Kdx/VG4=
X-Google-Smtp-Source: ABdhPJz4kjAEUt3AFXvHpYee1s2XOWemkmy4SkEZxfoCVKR6CwwpYKoKD4y1dKMuMWu629xn9UUsGQ==
X-Received: by 2002:a2e:bb8f:: with SMTP id y15mr5524661lje.148.1629248834555;
        Tue, 17 Aug 2021 18:07:14 -0700 (PDT)
Received: from kari-VirtualBox.telewell.oy (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id j4sm400245ljh.120.2021.08.17.18.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 18:07:14 -0700 (PDT)
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev, Christoph Hellwig <hch@lst.de>
Cc:     Kari Argillander <kari.argillander@gmail.com>,
        linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>
Subject: [PATCH v3 3/3] fs/ntfs3: Use kcalloc/kmalloc_array over kzalloc/kmalloc
Date:   Wed, 18 Aug 2021 04:06:49 +0300
Message-Id: <20210818010649.412912-4-kari.argillander@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210818010649.412912-1-kari.argillander@gmail.com>
References: <20210818010649.412912-1-kari.argillander@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use kcalloc/kmalloc_array over kzalloc/kmalloc when we allocate array.
Checkpatch found these after we did not use our own defined allocation
wrappers.

Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
---
 fs/ntfs3/bitmap.c  | 2 +-
 fs/ntfs3/file.c    | 2 +-
 fs/ntfs3/frecord.c | 7 +++----
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/ntfs3/bitmap.c b/fs/ntfs3/bitmap.c
index d502bba323d0..2de05062c78b 100644
--- a/fs/ntfs3/bitmap.c
+++ b/fs/ntfs3/bitmap.c
@@ -683,7 +683,7 @@ int wnd_init(struct wnd_bitmap *wnd, struct super_block *sb, size_t nbits)
 	if (!wnd->bits_last)
 		wnd->bits_last = wbits;
 
-	wnd->free_bits = kzalloc(wnd->nwnd * sizeof(u16), GFP_NOFS);
+	wnd->free_bits = kcalloc(wnd->nwnd, sizeof(u16), GFP_NOFS);
 	if (!wnd->free_bits)
 		return -ENOMEM;
 
diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index 8d27c520bec5..6687f3c67450 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -900,7 +900,7 @@ static ssize_t ntfs_compress_write(struct kiocb *iocb, struct iov_iter *from)
 		return -EOPNOTSUPP;
 	}
 
-	pages = kmalloc(pages_per_frame * sizeof(struct page *), GFP_NOFS);
+	pages = kmalloc_array(pages_per_frame, sizeof(struct page *), GFP_NOFS);
 	if (!pages)
 		return -ENOMEM;
 
diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index 33c6b40d8ca7..98bca9f9d8d1 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -2050,7 +2050,7 @@ int ni_readpage_cmpr(struct ntfs_inode *ni, struct page *page)
 	idx = (vbo - frame_vbo) >> PAGE_SHIFT;
 
 	pages_per_frame = frame_size >> PAGE_SHIFT;
-	pages = kzalloc(pages_per_frame * sizeof(struct page *), GFP_NOFS);
+	pages = kcalloc(pages_per_frame, sizeof(struct page *), GFP_NOFS);
 	if (!pages) {
 		err = -ENOMEM;
 		goto out;
@@ -2133,7 +2133,7 @@ int ni_decompress_file(struct ntfs_inode *ni)
 	frame_bits = ni_ext_compress_bits(ni);
 	frame_size = 1u << frame_bits;
 	pages_per_frame = frame_size >> PAGE_SHIFT;
-	pages = kzalloc(pages_per_frame * sizeof(struct page *), GFP_NOFS);
+	pages = kcalloc(pages_per_frame, sizeof(struct page *), GFP_NOFS);
 	if (!pages) {
 		err = -ENOMEM;
 		goto out;
@@ -2705,8 +2705,7 @@ int ni_write_frame(struct ntfs_inode *ni, struct page **pages,
 		goto out;
 	}
 
-	pages_disk = kzalloc(pages_per_frame * sizeof(struct page *),
-			     GFP_NOFS);
+	pages_disk = kcalloc(pages_per_frame, sizeof(struct page *), GFP_NOFS);
 	if (!pages_disk) {
 		err = -ENOMEM;
 		goto out;
-- 
2.25.1

