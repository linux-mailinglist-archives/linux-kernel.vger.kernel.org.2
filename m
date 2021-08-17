Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91F9A3EF2B9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 21:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233676AbhHQTkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 15:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233583AbhHQTkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 15:40:01 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48D6C061764
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 12:39:27 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id u22so12346944lfq.13
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 12:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6354OG+8/r7z+Sh1NXFncFEfnvHG3iqSsWKERHJBAYk=;
        b=ppkqjmj7fZjJlRw8+9/JcSSdsaD+nmi9q/yUQyEwYRDYUaau8gQkpkq8ERBelcPAs8
         QmhKm8bLcjTMHWHiabN7iWSvvyiha49Is3V7rqMMtuqujY+g+A0VV3U5ILG+9iRqzKj7
         ZK109xaV5xVCLb1E+yKYssGmgoD4IweenAdGb5tHVUc+YFjRuDg6QozVb0RDsumXqECo
         BbQaDtOTIQ/GPd4gS32w+YS+P+3J/6pGTj9wM5baC0+Wx8fiAp9kLmV6FcWOjV6yPsT9
         Z4yx8uPsOBUCDgK8YW4JPQKk0qOxvPMPAV2j6Xn7IQAhemB3Q4xWlqC/qIFaspRM7zTu
         kmhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6354OG+8/r7z+Sh1NXFncFEfnvHG3iqSsWKERHJBAYk=;
        b=D5syvvrUvRwDAV/yKU/fWI85SbziipbjPeW19xtBDupV+fDxP5AFdDg6TH3+vmFTV5
         MBi/3+Km6U/BzS1PyYPwoF2RsdV/bWldBE/9dZB+SDXizT5Od4ymMd06eRaMbswwtuDy
         OG03psRnkXaFoZAdf6k4MF4NjHLxxkPHYWI3RlFN1MBGh5icG+tf39eFCeUhauj4AmyP
         MnQSZrq5yVtn+eAQKNSNvtVlBOJtjkolP5IwgZRU0wq5GIEF3oIrg3AWt1+jE6G4s6qW
         L4910lVNYaI6LAotTdtuVPuHQZzNHWU+ZfZkLKDwF2CHnXdddKo54AxDW87hUAbVYjEY
         +Zdg==
X-Gm-Message-State: AOAM533b7rnXT1214tlevhbzhDDacndeDpidXGUK4qND+7owZxKVP9ir
        f8Uo0OVJl9MqhnxpEwBM7YA=
X-Google-Smtp-Source: ABdhPJzrTeLQM00GE0MvodLlN4ciqivDSDY+Z0BUDCSBKp9ujwdhalRsRKg0P5jkoj1wDWGB2hME0A==
X-Received: by 2002:a19:f713:: with SMTP id z19mr3613798lfe.238.1629229166083;
        Tue, 17 Aug 2021 12:39:26 -0700 (PDT)
Received: from kari-VirtualBox.telewell.oy (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id o28sm99697lfg.238.2021.08.17.12.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 12:39:25 -0700 (PDT)
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev, Christoph Hellwig <hch@lst.de>
Cc:     Kari Argillander <kari.argillander@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] fs/ntfs3: Use kcalloc/kmalloc_array over kzalloc/kmalloc
Date:   Tue, 17 Aug 2021 22:38:15 +0300
Message-Id: <20210817193815.307182-4-kari.argillander@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210817193815.307182-1-kari.argillander@gmail.com>
References: <20210817193815.307182-1-kari.argillander@gmail.com>
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
index 8d27c520bec5..e0f7992484c3 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -900,7 +900,7 @@ static ssize_t ntfs_compress_write(struct kiocb *iocb, struct iov_iter *from)
 		return -EOPNOTSUPP;
 	}
 
-	pages = kmalloc(pages_per_frame * sizeof(struct page *), GFP_NOFS);
+	pages = kcalloc(pages_per_frame, sizeof(struct page *), GFP_NOFS);
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

