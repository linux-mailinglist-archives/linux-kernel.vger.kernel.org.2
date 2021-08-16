Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65D543ED39D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 14:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235831AbhHPMCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 08:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235798AbhHPMCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 08:02:41 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7546DC061764
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 05:02:09 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id n6so26734000ljp.9
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 05:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r6r8va6Dg2Si6p1qLWqzldiHMFwpXfRX5u3lnqvgf50=;
        b=jdBYVl6FVZiGHHJ07dR6L+gaooQEvB6aUPT7DdTl2sxzZB72QvIm8RjFuksMDCsvxs
         QACEMWzp/Q3iBoOjiKNZgcOebLotXfTDiRG/6VU7bW+9PQAEVQbbM8sfV9+AeK8NCbwB
         dOqsowtWGiOYzzik+kGvYfcRt/uHZPFJLL5DHMbAXigBGPSv+cDn20pKDwtJucPdL07E
         aYBSAPv3PU0ANahj14MJS6sUfUfrTJYD7yuklIwmLKbTFEUsIPqOhyA6x+wk33Ix/KAs
         zf6OvGO8cFF6p7JbPnyC+e2+p1WgCyFyO+5nuoUWR6d7Jq89QOQbkWDOwNhTt6xOB3LZ
         /2pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r6r8va6Dg2Si6p1qLWqzldiHMFwpXfRX5u3lnqvgf50=;
        b=Q3CcoQDkEVvulkUdEaqPMiR1Egw+t8RM9WZDE3gclyXNECuZwpwPGZ86En3Ptvbsfp
         IVAeeXsmGIHC9UMaY2s/7lWPVkTSnlAQyWXIeIn7HWqrjRiYhJefLarg+06f9UVH7Uc+
         Jfx1n+QXEUfrTxUUBHOt9R/OBY8csFD7oaG54Hvd536Hd7YacwpdJtsNHVh7zXJ6EEdb
         5bjT+Uanyh45QtBUxyLoEMyA5LuTIfyOpnoNNp28ZvENtenp1pnydojGvooASY/upqYx
         6TMON+AN7dYiYy3xNU61tK4/bMZVIUWPkoUvXaQCjXFiihWc4cuoNIAK79qrr0eL5NZR
         Zs5A==
X-Gm-Message-State: AOAM533qW6M35kWZhcDjJ4/15arMMnXEl1AbvoqH1lSpPx6gTP6TuBNr
        EhTNJFNvgWrzRqjNILWcChE=
X-Google-Smtp-Source: ABdhPJwuu5CRQ+ULVJ3im3r0i6BORE41/c2yLBzmo1gk45h3Bk3q0m02bP4lyLSStgA+Aeyo4cDcTA==
X-Received: by 2002:a2e:b80f:: with SMTP id u15mr9208488ljo.232.1629115326402;
        Mon, 16 Aug 2021 05:02:06 -0700 (PDT)
Received: from kari-VirtualBox.telewell.oy (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id c10sm1144333ljr.134.2021.08.16.05.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 05:02:05 -0700 (PDT)
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev
Cc:     Kari Argillander <kari.argillander@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] fs/ntfs3: Add ifndef + define to all header files
Date:   Mon, 16 Aug 2021 15:01:56 +0300
Message-Id: <20210816120156.186193-1-kari.argillander@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add guards so that compiler will only include header files once.

Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
---
I do not mind if this get's merged to V28/V29 without commit.
---
 fs/ntfs3/debug.h   | 5 +++++
 fs/ntfs3/ntfs.h    | 3 +++
 fs/ntfs3/ntfs_fs.h | 5 +++++
 3 files changed, 13 insertions(+)

diff --git a/fs/ntfs3/debug.h b/fs/ntfs3/debug.h
index dfaa4c79dc6d..465466631d38 100644
--- a/fs/ntfs3/debug.h
+++ b/fs/ntfs3/debug.h
@@ -7,6 +7,9 @@
  */
 
 // clang-format off
+#ifndef _LINUX_NTFS3_DEBUG_H
+#define _LINUX_NTFS3_DEBUG_H
+
 #ifndef Add2Ptr
 #define Add2Ptr(P, I)		((void *)((u8 *)(P) + (I)))
 #define PtrOffset(B, O)		((size_t)((size_t)(O) - (size_t)(B)))
@@ -61,4 +64,6 @@ void ntfs_inode_printk(struct inode *inode, const char *fmt, ...)
 #define ntfs_free(p)		kfree(p)
 #define ntfs_vfree(p)		kvfree(p)
 #define ntfs_memdup(src, len)	kmemdup(src, len, GFP_NOFS)
+
+#endif /* _LINUX_NTFS3_DEBUG_H */
 // clang-format on
diff --git a/fs/ntfs3/ntfs.h b/fs/ntfs3/ntfs.h
index 40398e6c39c9..16da514af124 100644
--- a/fs/ntfs3/ntfs.h
+++ b/fs/ntfs3/ntfs.h
@@ -7,6 +7,8 @@
  */
 
 // clang-format off
+#ifndef _LINUX_NTFS3_NTFS_H
+#define _LINUX_NTFS3_NTFS_H
 
 /* TODO:
  * - Check 4K mft record and 512 bytes cluster
@@ -1235,4 +1237,5 @@ struct SID {
 };
 static_assert(offsetof(struct SID, SubAuthority) == 8);
 
+#endif /* _LINUX_NTFS3_NTFS_H */
 // clang-format on
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index 0c3ac89c3115..80e1dea2579a 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -6,6 +6,9 @@
  */
 
 // clang-format off
+#ifndef _LINUX_NTFS3_NTFS_FS_H
+#define _LINUX_NTFS3_NTFS_FS_H
+
 #define MINUS_ONE_T			((size_t)(-1))
 /* Biggest MFT / smallest cluster */
 #define MAXIMUM_BYTES_PER_MFT		4096
@@ -1090,3 +1093,5 @@ static inline void le64_sub_cpu(__le64 *var, u64 val)
 {
 	*var = cpu_to_le64(le64_to_cpu(*var) - val);
 }
+
+#endif /* _LINUX_NTFS3_NTFS_FS_H */
-- 
2.30.2

