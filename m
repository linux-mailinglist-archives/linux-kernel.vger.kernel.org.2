Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6EA3F3E89
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 09:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232312AbhHVH6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 03:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231857AbhHVH5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 03:57:39 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45CD0C061764
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 00:56:59 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id y190so12616622pfg.7
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 00:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/IK2hUcT/4MYA89svC69IqQzJMxj9iX8eWhKLXV32Iw=;
        b=QCLdF+eD0anvEeWmalPSIHQDeFFhVXfkPNxoAL80wy2cfcL6ACoqSdB9gkksbW4ara
         cUfJu5UBfqt9XyNRqvYrrwTAQ1GEBtmaHDiKfHYgEdDdFVCzLFgdXRmHOzKPfysJQzjS
         z/xEGc3jiiIXY7kxxXwT+9TFBnlrpvOxikJ2E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/IK2hUcT/4MYA89svC69IqQzJMxj9iX8eWhKLXV32Iw=;
        b=gBxZNKFMVYFufQFIFQKfQ4AR3ZLUxwQMTECUy2ken5VHI8wcO9ZUWTG/lTWyYfPlkI
         PUzmXrm/YKjQqa61l2bKW8DPVkAcE2qmlMH+w+jZ0+SRNo5lwYliP5H6kcDQdtcJHIiS
         Wyq74+WgCiGWDVaB/Ok9Kce99/hyK8OAQ/Zd4tFa5atN0k/uyKa8HBMFwxj9cdcgcJeh
         Yu7M+k+9mI9nPn1iKknpHAioYQxZh67ZMUP4RAhdWBc0mHJeQW5TTbMSrb2EwFN63QsI
         CRNT026zMrXKC0LEuR3n/hRxKUxhOmpbUAfIE0uAoutscBrO3i8AXjhsFkqi6fob41cl
         hSkw==
X-Gm-Message-State: AOAM532MEJ7OP38vladdtQoHpIpqU6sHNCtOJRIHYBXHV/8lXL8Pbi9g
        CH8Yq0FWLgPX8qc/sioVmUrcsg==
X-Google-Smtp-Source: ABdhPJzq+TtZMZSw8dHF+lSpjwFHFLC/dgieYhWajSzCVBQ6JialEzTQyJ9NmX8gtFmU5viJM2uayw==
X-Received: by 2002:a63:5604:: with SMTP id k4mr26801500pgb.363.1629619018842;
        Sun, 22 Aug 2021 00:56:58 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m28sm14880372pgl.9.2021.08.22.00.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Aug 2021 00:56:57 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Daniel Micay <danielmicay@gmail.com>,
        Francis Laniel <laniel_francis@privacyrequired.com>,
        Bart Van Assche <bvanassche@acm.org>,
        David Gow <davidgow@google.com>, linux-mm@kvack.org,
        clang-built-linux@googlegroups.com, linux-hardening@vger.kernel.org
Subject: [PATCH for-next 19/25] fortify: Allow strlen() and strnlen() to pass compile-time known lengths
Date:   Sun, 22 Aug 2021 00:51:16 -0700
Message-Id: <20210822075122.864511-20-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210822075122.864511-1-keescook@chromium.org>
References: <20210822075122.864511-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4037; h=from:subject; bh=A8Geo8n4i5qwpvkI4vHxNJg+9VAd1dz9Zyf2I1wPWkI=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhIgH41/syAnC8eDuJXMCDQbQtT/FS9k5h9kcLncy9 eJedf0qJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYSIB+AAKCRCJcvTf3G3AJrn9D/ 9w5dThNsyCdRB28y4gKpDDLcvUjRa1Q7oKkwUtwYdV4cfAf+oyY6FWe+T3MEuQEGGcOExyAmym8iuM YdmWCH662e/XOVtgNQqcXFcLIOs0PWUTdV1Ps7VotgZMQFC2oVwakzruXHCfkyrKUEtcR5z0CILGRn t8zpD6TGNmD40Ks+KA3xAF4dpBjzIzL5Z/Sbix2dA6CwwEOedcVhEoOZkwefsdAqsCRIDrsxe46uhR yTqT1Py3Ztyo4HBf5/fq0ZvpqMNknPbP2I9+yxFrBfP2wJDCZcS7MR2x7q/USsg4Jm4oUzdL4M869d XaY4fTLBn0Skhh1lYpQRY7tw0HAru9lWcfYHIwQpzINLpSk4Gtcnik3fND1lF7OcQSnu/HmTyRBWes Pw83R50BMTQ8a/vjGbbbKml6GSvKB+UsGwvFTPgRD6xN71rN8D8YCvPxS+12ubmM+cTDFHZ/BX0QuD lMXeN2s9Zzs584Jq/4VOo/4f6vtSgmd2BOwzfyyDo+eYNHIPxS4YFZGaxGjcxgp9Tqz6cnc+5iHa1s 9lIm/i+0pU3Q0IcYwzFXrhkrNCarXCgQ8jI+7+dMIxsDfQQBkh+kv4HVXAM7bqjhArAiqt5J+w+QSP jotniJxsBv+glaPCKkmwkAM/MdceVn/RgSpZqz9gbeHZz+aD8fXSw7K9N+FQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Under CONFIG_FORTIFY_SOURCE, it is possible for the compiler to perform
strlen() and strnlen() at compile-time when the string size is known.
This is required to support compile-time overflow checking in strlcpy().

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/fortify-string.h | 47 ++++++++++++++++++++++++++--------
 1 file changed, 36 insertions(+), 11 deletions(-)

diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
index a3cb1d9aacce..e232a63fd826 100644
--- a/include/linux/fortify-string.h
+++ b/include/linux/fortify-string.h
@@ -10,6 +10,18 @@ void __read_overflow(void) __compiletime_error("detected read beyond size of obj
 void __read_overflow2(void) __compiletime_error("detected read beyond size of object (2nd parameter)");
 void __write_overflow(void) __compiletime_error("detected write beyond size of object (1st parameter)");
 
+#define __compiletime_strlen(p)	({		\
+	size_t ret = (size_t)-1;			\
+	size_t p_size = __builtin_object_size(p, 1);	\
+	if (p_size != (size_t)-1) {			\
+		size_t p_len = p_size - 1;		\
+		if (__builtin_constant_p(p[p_len]) &&	\
+		    p[p_len] == '\0')			\
+			ret = __builtin_strlen(p);	\
+	}						\
+	ret;						\
+})
+
 #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
 extern void *__underlying_memchr(const void *p, int c, __kernel_size_t size) __RENAME(memchr);
 extern int __underlying_memcmp(const void *p, const void *q, __kernel_size_t size) __RENAME(memcmp);
@@ -60,21 +72,31 @@ extern __kernel_size_t __real_strnlen(const char *, __kernel_size_t) __RENAME(st
 __FORTIFY_INLINE __kernel_size_t strnlen(const char *p, __kernel_size_t maxlen)
 {
 	size_t p_size = __builtin_object_size(p, 1);
-	__kernel_size_t ret = __real_strnlen(p, maxlen < p_size ? maxlen : p_size);
+	size_t p_len = __compiletime_strlen(p);
+	size_t ret;
+
+	/* We can take compile-time actions when maxlen is const. */
+	if (__builtin_constant_p(maxlen) && p_len != (size_t)-1) {
+		/* If p is const, we can use its compile-time-known len. */
+		if (maxlen >= p_size)
+			return p_len;
+	}
 
+	/* Do no check characters beyond the end of p. */
+	ret = __real_strnlen(p, maxlen < p_size ? maxlen : p_size);
 	if (p_size <= ret && maxlen != ret)
 		fortify_panic(__func__);
 	return ret;
 }
 
+/* defined after fortified strnlen to reuse it. */
 __FORTIFY_INLINE __kernel_size_t strlen(const char *p)
 {
 	__kernel_size_t ret;
 	size_t p_size = __builtin_object_size(p, 1);
 
-	/* Work around gcc excess stack consumption issue */
-	if (p_size == (size_t)-1 ||
-		(__builtin_constant_p(p[p_size - 1]) && p[p_size - 1] == '\0'))
+	/* Give up if we don't know how large p is. */
+	if (p_size == (size_t)-1)
 		return __underlying_strlen(p);
 	ret = strnlen(p, p_size);
 	if (p_size <= ret)
@@ -86,24 +108,27 @@ __FORTIFY_INLINE __kernel_size_t strlen(const char *p)
 extern size_t __real_strlcpy(char *, const char *, size_t) __RENAME(strlcpy);
 __FORTIFY_INLINE size_t strlcpy(char *p, const char *q, size_t size)
 {
-	size_t ret;
 	size_t p_size = __builtin_object_size(p, 1);
 	size_t q_size = __builtin_object_size(q, 1);
+	size_t q_len;	/* Full count of source string length. */
+	size_t len;	/* Count of characters going into destination. */
 
 	if (p_size == (size_t)-1 && q_size == (size_t)-1)
 		return __real_strlcpy(p, q, size);
-	ret = strlen(q);
-	if (size) {
-		size_t len = (ret >= size) ? size - 1 : ret;
-
-		if (__builtin_constant_p(len) && len >= p_size)
+	q_len = strlen(q);
+	len = (q_len >= size) ? size - 1 : q_len;
+	if (__builtin_constant_p(size) && __builtin_constant_p(q_len) && size) {
+		/* Write size is always larger than destintation. */
+		if (len >= p_size)
 			__write_overflow();
+	}
+	if (size) {
 		if (len >= p_size)
 			fortify_panic(__func__);
 		__underlying_memcpy(p, q, len);
 		p[len] = '\0';
 	}
-	return ret;
+	return q_len;
 }
 
 /* defined after fortified strnlen to reuse it */
-- 
2.30.2

