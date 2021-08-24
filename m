Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF7813F6922
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 20:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233953AbhHXSiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 14:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233688AbhHXSiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 14:38:13 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D3AC061757
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 11:37:28 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id j12so24845104ljg.10
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 11:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gFsJKfS9ug3vI9Yk3/qdv2qYBDtrSy662nmOAGHYkqU=;
        b=IqZWAn/Xx6vV3cy2qy2Q6Do3I0oamzhZYncY9aLSK9O7/Zvyt2ZtQnjEWFGLHg2FVX
         kzDCeyp91cJ7U8Emjz5/OVTZKL6GUqVkasEVjxMzxiKXStlRKYI5HnbwhDGfCS+SehAU
         wLiR97bPt+OuQqlumab6F+/7vJCXFHjBvAv2CBgYLtdiylPZd6hUgvv1Ayqs7naFbKbH
         mVQu6uCiMwtFTRfLLin3X4awmi3bS1benkJAbEFrJ8dkSmfPu73zmZ/CXWxO2DR74ywO
         cHVsZeja6xHKGPm+qn/4l9HyqDLYOZ/LF2S0BMwkDgwv8isOwoob+MKa7iJACyIw8lXc
         vjZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gFsJKfS9ug3vI9Yk3/qdv2qYBDtrSy662nmOAGHYkqU=;
        b=XYkxg3q47ikEGXqKD3kI5DJJRfXkTM0WQUz36W86uC8wZ5DUQ2nPbpM8IWv67lZqnr
         QMps5xikL/DdVEBn0autCpFBroBbO7gmYowTkxxWxoCklRcD6p9GFDscSmIva1izt7yi
         86Uvq3AM96V2N7qQnc+W3cdcSAapro8NG2ekai68rHZu5l1G++FDbpU+oz0swqIyPNJA
         3RwHRfxwjzGTrBQ9vvS8mSTOrZ20boGPVFC1n/jpOlapt6Zuxl0TCvTSYPrqte/G9wlq
         C0u3f5rkn6Dvs59/QRYXGzor11thQb8XFAzD7KyKprDV+m7mF/D7zP+4vytKDwuITrkz
         kRsQ==
X-Gm-Message-State: AOAM530o7bxG2bxhfwsPXOOJujDz/EQmiCpqxflbkplRwUh1raLItDjA
        qIC8OpQ4CipHfzF1lTBf6j4=
X-Google-Smtp-Source: ABdhPJxccGQuLlIrOIzyho2DWsW3xFYeN0fW912aWAWzeVxOtAgbnpMMkUo4jTLJRSvM37QTGGWQ+w==
X-Received: by 2002:a2e:93c3:: with SMTP id p3mr26899838ljh.226.1629830246907;
        Tue, 24 Aug 2021 11:37:26 -0700 (PDT)
Received: from kari-VirtualBox.telewell.oy (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id k13sm1826378lfm.168.2021.08.24.11.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 11:37:26 -0700 (PDT)
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev, Christoph Hellwig <hch@lst.de>
Cc:     Kari Argillander <kari.argillander@gmail.com>,
        linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>
Subject: [PATCH v4 3/3] fs/ntfs3: Use kcalloc/kmalloc_array over kzalloc/kmalloc
Date:   Tue, 24 Aug 2021 21:37:08 +0300
Message-Id: <20210824183708.1008538-4-kari.argillander@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210824183708.1008538-1-kari.argillander@gmail.com>
References: <20210824183708.1008538-1-kari.argillander@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use kcalloc/kmalloc_array over kzalloc/kmalloc when we allocate array.
Checkpatch found these after we did not use our own defined allocation
wrappers.

Reviewed-by: Christoph Hellwig <hch@lst.de>
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
index 8d27c520bec5..a959f6197c99 100644
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
index bbe03eebf798..321edf272cde 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -2054,7 +2054,7 @@ int ni_readpage_cmpr(struct ntfs_inode *ni, struct page *page)
 	idx = (vbo - frame_vbo) >> PAGE_SHIFT;
 
 	pages_per_frame = frame_size >> PAGE_SHIFT;
-	pages = kzalloc(pages_per_frame * sizeof(struct page *), GFP_NOFS);
+	pages = kcalloc(pages_per_frame, sizeof(struct page *), GFP_NOFS);
 	if (!pages) {
 		err = -ENOMEM;
 		goto out;
@@ -2137,7 +2137,7 @@ int ni_decompress_file(struct ntfs_inode *ni)
 	frame_bits = ni_ext_compress_bits(ni);
 	frame_size = 1u << frame_bits;
 	pages_per_frame = frame_size >> PAGE_SHIFT;
-	pages = kzalloc(pages_per_frame * sizeof(struct page *), GFP_NOFS);
+	pages = kcalloc(pages_per_frame, sizeof(struct page *), GFP_NOFS);
 	if (!pages) {
 		err = -ENOMEM;
 		goto out;
@@ -2709,8 +2709,7 @@ int ni_write_frame(struct ntfs_inode *ni, struct page **pages,
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

