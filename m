Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA3F432D0D3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 11:34:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238663AbhCDKcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 05:32:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238581AbhCDKb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 05:31:56 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B50C0613DF
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 02:30:12 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id m7so798472wmq.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 02:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pCe90PiqGmxROg4pfqFFTH25K7JQCv+JP3yxH8AOnKc=;
        b=EnueNiX6NpYKxBrj0wY36yyGp38a1izgQNX8Hx89b9vCl82p35QuJoeFi0PlgUEKdu
         adhL2KupJr9zBnoE0Qj3UPOk5DXG8PTYa5do55m2LDWTrih9GhieMQGmMBel92zrhQMP
         SCOQ89LyCAgrDjvE/GGe6WITNj68OMGsE2uQ/aHKJvaYrYVEBdBMJ1ro6OAp/GkchOFM
         QLTa526fTJMiNYEzS4msmOreeOBYRGRZoGlmYhUax5bQZNM+bFN17TIrx4urSvta/XbJ
         cgxuZAvzP/tJdV8HivrZ+Tq3Op8aL12FAm2laj/AgEFHrerOZpyLfbUC1dbjTcSrQ0FY
         CEZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pCe90PiqGmxROg4pfqFFTH25K7JQCv+JP3yxH8AOnKc=;
        b=pdJSzZx44vdqwmPbycR8xkHEhfUem5xrDO3NPdZ1vnLUykre6wA+9/BYyKfUWd9msY
         0KZzn4ecYrL6b4h7mUmZsLmfVpXlbcKW5eBg24EuZaSHhlM8V1q5vsjUpyj9aMpciyL9
         93y2WfDN9QUWbdbNQBQCLnXAjI+XQnOOuJTVdrtPskTR6977U2cMDgc5X3mlzd1ngMZ2
         3B8KGeNE/Q5/R7bYkX4uZqHGANaXzXamC8I10OOCtxGzQVDfkZvz6KR/lKWNm1rw9ram
         4Iro6vz/Y+09I41etMayRkIzp3ZtqdtiEdC4oHbdVsWnqZcpZceknPZMxNDUFODYj2tq
         RITA==
X-Gm-Message-State: AOAM532XO6DX89VEkuE8DRyUnYogbP/iS0pQPMn1f9qpS0p+u9IRSMVQ
        NUnzXD/qUTYLxzydZfeM0R3evA==
X-Google-Smtp-Source: ABdhPJzXMkznue5E1BXwSAv/5Jnk3qYctYhg0S8yF4gHZKgRkHzuNTIh1oPe4Fqhe5HmfeqXk9SRtA==
X-Received: by 2002:a1c:2016:: with SMTP id g22mr3213575wmg.137.1614853810754;
        Thu, 04 Mar 2021 02:30:10 -0800 (PST)
Received: from debian-brgl.home (amarseille-656-1-4-167.w90-8.abo.wanadoo.fr. [90.8.158.167])
        by smtp.gmail.com with ESMTPSA id f7sm35501854wre.78.2021.03.04.02.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 02:30:10 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Joel Becker <jlbec@evilplan.org>, Christoph Hellwig <hch@lst.de>,
        Shuah Khan <shuah@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Kent Gibson <warthog618@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 05/12] lib: bitmap: remove the 'extern' keyword from function declarations
Date:   Thu,  4 Mar 2021 11:24:45 +0100
Message-Id: <20210304102452.21726-6-brgl@bgdev.pl>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20210304102452.21726-1-brgl@bgdev.pl>
References: <20210304102452.21726-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

The 'extern' keyword doesn't have any benefits in header files. Remove it.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 include/linux/bitmap.h | 115 ++++++++++++++++++++---------------------
 1 file changed, 57 insertions(+), 58 deletions(-)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index 70a932470b2d..6939a8983026 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -118,54 +118,53 @@
  * Allocation and deallocation of bitmap.
  * Provided in lib/bitmap.c to avoid circular dependency.
  */
-extern unsigned long *bitmap_alloc(unsigned int nbits, gfp_t flags);
-extern unsigned long *bitmap_zalloc(unsigned int nbits, gfp_t flags);
-extern void bitmap_free(const unsigned long *bitmap);
+unsigned long *bitmap_alloc(unsigned int nbits, gfp_t flags);
+unsigned long *bitmap_zalloc(unsigned int nbits, gfp_t flags);
+void bitmap_free(const unsigned long *bitmap);
 
 /*
  * lib/bitmap.c provides these functions:
  */
 
-extern int __bitmap_equal(const unsigned long *bitmap1,
-			  const unsigned long *bitmap2, unsigned int nbits);
-extern bool __pure __bitmap_or_equal(const unsigned long *src1,
-				     const unsigned long *src2,
-				     const unsigned long *src3,
-				     unsigned int nbits);
-extern void __bitmap_complement(unsigned long *dst, const unsigned long *src,
-			unsigned int nbits);
-extern void __bitmap_shift_right(unsigned long *dst, const unsigned long *src,
-				unsigned int shift, unsigned int nbits);
-extern void __bitmap_shift_left(unsigned long *dst, const unsigned long *src,
-				unsigned int shift, unsigned int nbits);
-extern void bitmap_cut(unsigned long *dst, const unsigned long *src,
-		       unsigned int first, unsigned int cut,
-		       unsigned int nbits);
-extern int __bitmap_and(unsigned long *dst, const unsigned long *bitmap1,
+int __bitmap_equal(const unsigned long *bitmap1,
+		   const unsigned long *bitmap2, unsigned int nbits);
+bool __pure __bitmap_or_equal(const unsigned long *src1,
+			      const unsigned long *src2,
+			      const unsigned long *src3,
+			      unsigned int nbits);
+void __bitmap_complement(unsigned long *dst, const unsigned long *src,
+			 unsigned int nbits);
+void __bitmap_shift_right(unsigned long *dst, const unsigned long *src,
+			  unsigned int shift, unsigned int nbits);
+void __bitmap_shift_left(unsigned long *dst, const unsigned long *src,
+			 unsigned int shift, unsigned int nbits);
+void bitmap_cut(unsigned long *dst, const unsigned long *src,
+		unsigned int first, unsigned int cut, unsigned int nbits);
+int __bitmap_and(unsigned long *dst, const unsigned long *bitmap1,
+		 const unsigned long *bitmap2, unsigned int nbits);
+void __bitmap_or(unsigned long *dst, const unsigned long *bitmap1,
+		 const unsigned long *bitmap2, unsigned int nbits);
+void __bitmap_xor(unsigned long *dst, const unsigned long *bitmap1,
+		  const unsigned long *bitmap2, unsigned int nbits);
+int __bitmap_andnot(unsigned long *dst, const unsigned long *bitmap1,
+		    const unsigned long *bitmap2, unsigned int nbits);
+void __bitmap_replace(unsigned long *dst,
+		      const unsigned long *old, const unsigned long *new,
+		      const unsigned long *mask, unsigned int nbits);
+int __bitmap_intersects(const unsigned long *bitmap1,
 			const unsigned long *bitmap2, unsigned int nbits);
-extern void __bitmap_or(unsigned long *dst, const unsigned long *bitmap1,
-			const unsigned long *bitmap2, unsigned int nbits);
-extern void __bitmap_xor(unsigned long *dst, const unsigned long *bitmap1,
-			const unsigned long *bitmap2, unsigned int nbits);
-extern int __bitmap_andnot(unsigned long *dst, const unsigned long *bitmap1,
-			const unsigned long *bitmap2, unsigned int nbits);
-extern void __bitmap_replace(unsigned long *dst,
-			const unsigned long *old, const unsigned long *new,
-			const unsigned long *mask, unsigned int nbits);
-extern int __bitmap_intersects(const unsigned long *bitmap1,
-			const unsigned long *bitmap2, unsigned int nbits);
-extern int __bitmap_subset(const unsigned long *bitmap1,
-			const unsigned long *bitmap2, unsigned int nbits);
-extern int __bitmap_weight(const unsigned long *bitmap, unsigned int nbits);
-extern void __bitmap_set(unsigned long *map, unsigned int start, int len);
-extern void __bitmap_clear(unsigned long *map, unsigned int start, int len);
-
-extern unsigned long bitmap_find_next_zero_area_off(unsigned long *map,
-						    unsigned long size,
-						    unsigned long start,
-						    unsigned int nr,
-						    unsigned long align_mask,
-						    unsigned long align_offset);
+int __bitmap_subset(const unsigned long *bitmap1,
+		    const unsigned long *bitmap2, unsigned int nbits);
+int __bitmap_weight(const unsigned long *bitmap, unsigned int nbits);
+void __bitmap_set(unsigned long *map, unsigned int start, int len);
+void __bitmap_clear(unsigned long *map, unsigned int start, int len);
+
+unsigned long bitmap_find_next_zero_area_off(unsigned long *map,
+					     unsigned long size,
+					     unsigned long start,
+					     unsigned int nr,
+					     unsigned long align_mask,
+					     unsigned long align_offset);
 
 /**
  * bitmap_find_next_zero_area - find a contiguous aligned zero area
@@ -190,33 +189,33 @@ bitmap_find_next_zero_area(unsigned long *map,
 					      align_mask, 0);
 }
 
-extern int bitmap_parse(const char *buf, unsigned int buflen,
+int bitmap_parse(const char *buf, unsigned int buflen,
 			unsigned long *dst, int nbits);
-extern int bitmap_parse_user(const char __user *ubuf, unsigned int ulen,
+int bitmap_parse_user(const char __user *ubuf, unsigned int ulen,
 			unsigned long *dst, int nbits);
-extern int bitmap_parselist(const char *buf, unsigned long *maskp,
+int bitmap_parselist(const char *buf, unsigned long *maskp,
 			int nmaskbits);
-extern int bitmap_parselist_user(const char __user *ubuf, unsigned int ulen,
+int bitmap_parselist_user(const char __user *ubuf, unsigned int ulen,
 			unsigned long *dst, int nbits);
-extern void bitmap_remap(unsigned long *dst, const unsigned long *src,
+void bitmap_remap(unsigned long *dst, const unsigned long *src,
 		const unsigned long *old, const unsigned long *new, unsigned int nbits);
-extern int bitmap_bitremap(int oldbit,
+int bitmap_bitremap(int oldbit,
 		const unsigned long *old, const unsigned long *new, int bits);
-extern void bitmap_onto(unsigned long *dst, const unsigned long *orig,
+void bitmap_onto(unsigned long *dst, const unsigned long *orig,
 		const unsigned long *relmap, unsigned int bits);
-extern void bitmap_fold(unsigned long *dst, const unsigned long *orig,
+void bitmap_fold(unsigned long *dst, const unsigned long *orig,
 		unsigned int sz, unsigned int nbits);
-extern int bitmap_find_free_region(unsigned long *bitmap, unsigned int bits, int order);
-extern void bitmap_release_region(unsigned long *bitmap, unsigned int pos, int order);
-extern int bitmap_allocate_region(unsigned long *bitmap, unsigned int pos, int order);
+int bitmap_find_free_region(unsigned long *bitmap, unsigned int bits, int order);
+void bitmap_release_region(unsigned long *bitmap, unsigned int pos, int order);
+int bitmap_allocate_region(unsigned long *bitmap, unsigned int pos, int order);
 
 #ifdef __BIG_ENDIAN
-extern void bitmap_copy_le(unsigned long *dst, const unsigned long *src, unsigned int nbits);
+void bitmap_copy_le(unsigned long *dst, const unsigned long *src, unsigned int nbits);
 #else
 #define bitmap_copy_le bitmap_copy
 #endif
-extern unsigned int bitmap_ord_to_pos(const unsigned long *bitmap, unsigned int ord, unsigned int nbits);
-extern int bitmap_print_to_pagebuf(bool list, char *buf,
+unsigned int bitmap_ord_to_pos(const unsigned long *bitmap, unsigned int ord, unsigned int nbits);
+int bitmap_print_to_pagebuf(bool list, char *buf,
 				   const unsigned long *maskp, int nmaskbits);
 
 #define BITMAP_FIRST_WORD_MASK(start) (~0UL << ((start) & (BITS_PER_LONG - 1)))
@@ -265,9 +264,9 @@ static inline void bitmap_copy_clear_tail(unsigned long *dst,
  * therefore conversion is not needed when copying data from/to arrays of u32.
  */
 #if BITS_PER_LONG == 64
-extern void bitmap_from_arr32(unsigned long *bitmap, const u32 *buf,
+void bitmap_from_arr32(unsigned long *bitmap, const u32 *buf,
 							unsigned int nbits);
-extern void bitmap_to_arr32(u32 *buf, const unsigned long *bitmap,
+void bitmap_to_arr32(u32 *buf, const unsigned long *bitmap,
 							unsigned int nbits);
 #else
 #define bitmap_from_arr32(bitmap, buf, nbits)			\
-- 
2.29.1

