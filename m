Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 069184283D4
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 23:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233190AbhJJVeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 17:34:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:58706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233208AbhJJVe1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 17:34:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8EDDA61078;
        Sun, 10 Oct 2021 21:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633901548;
        bh=BZE2h9T8kyoATakOTh1LoFvV5zvzgcuKHtqR+EVL11M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Kg2QzZ7JGpiNKtuXDrwRJ//c7Hmv4APTJv5h8yQooetJFE0bDaMkINRoqZm0C9dzi
         tMZj0s/bkrl/yEDXrhHzCtkkl62Pj3TiEAwKA9zy7AOvhveV1QSz5HaJNSP70AReBb
         FuGFqAEiYajXnmiewHLfQBkUS4Gccn1fXxaRzERg4GC46MURkJwZVeRtZySjp7YIxG
         0/CoXFcKBEDfXeYBm9UWJTbmPr3XeCSn9KZRBE97Z6H/rRyEpkQWiVmrw8x+yPdKrz
         wexsk7LeyAkajNdmF17ttebxfOXxvOIYcp0ioYvTE4PUp4vmg6RKA5V87YE3MZ0NOB
         qHaS/cZg0TDfQ==
From:   Gao Xiang <xiang@kernel.org>
To:     linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Cc:     Lasse Collin <lasse.collin@tukaani.org>, Chao Yu <chao@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 5/7] lib/xz, lib/decompress_unxz.c: Fix spelling in comments
Date:   Mon, 11 Oct 2021 05:31:43 +0800
Message-Id: <20211010213145.17462-6-xiang@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211010213145.17462-1-xiang@kernel.org>
References: <20211010213145.17462-1-xiang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lasse Collin <lasse.collin@tukaani.org>

uncompressible -> incompressible
non-splitted -> non-split

Signed-off-by: Lasse Collin <lasse.collin@tukaani.org>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/decompress_unxz.c | 10 +++++-----
 lib/xz/xz_dec_lzma2.c |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/lib/decompress_unxz.c b/lib/decompress_unxz.c
index f7a3dc13316a..9f4262ee33a5 100644
--- a/lib/decompress_unxz.c
+++ b/lib/decompress_unxz.c
@@ -20,8 +20,8 @@
  *
  * The worst case for in-place decompression is that the beginning of
  * the file is compressed extremely well, and the rest of the file is
- * uncompressible. Thus, we must look for worst-case expansion when the
- * compressor is encoding uncompressible data.
+ * incompressible. Thus, we must look for worst-case expansion when the
+ * compressor is encoding incompressible data.
  *
  * The structure of the .xz file in case of a compressed kernel is as follows.
  * Sizes (as bytes) of the fields are in parenthesis.
@@ -58,7 +58,7 @@
  * uncompressed size of the payload is in practice never less than the
  * payload size itself. The LZMA2 format would allow uncompressed size
  * to be less than the payload size, but no sane compressor creates such
- * files. LZMA2 supports storing uncompressible data in uncompressed form,
+ * files. LZMA2 supports storing incompressible data in uncompressed form,
  * so there's never a need to create payloads whose uncompressed size is
  * smaller than the compressed size.
  *
@@ -167,8 +167,8 @@
  * memeq and memzero are not used much and any remotely sane implementation
  * is fast enough. memcpy/memmove speed matters in multi-call mode, but
  * the kernel image is decompressed in single-call mode, in which only
- * memmove speed can matter and only if there is a lot of uncompressible data
- * (LZMA2 stores uncompressible chunks in uncompressed form). Thus, the
+ * memmove speed can matter and only if there is a lot of incompressible data
+ * (LZMA2 stores incompressible chunks in uncompressed form). Thus, the
  * functions below should just be kept small; it's probably not worth
  * optimizing for speed.
  */
diff --git a/lib/xz/xz_dec_lzma2.c b/lib/xz/xz_dec_lzma2.c
index 46b186d7eb45..27ce34520e78 100644
--- a/lib/xz/xz_dec_lzma2.c
+++ b/lib/xz/xz_dec_lzma2.c
@@ -520,7 +520,7 @@ static __always_inline void rc_normalize(struct rc_dec *rc)
  * functions so that the compiler is supposed to be able to more easily avoid
  * an extra branch. In this particular version of the LZMA decoder, this
  * doesn't seem to be a good idea (tested with GCC 3.3.6, 3.4.6, and 4.3.3
- * on x86). Using a non-splitted version results in nicer looking code too.
+ * on x86). Using a non-split version results in nicer looking code too.
  *
  * NOTE: This must return an int. Do not make it return a bool or the speed
  * of the code generated by GCC 3.x decreases 10-15 %. (GCC 4.3 doesn't care,
-- 
2.20.1

