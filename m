Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ABFA3F9D53
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 19:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234192AbhH0RMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 13:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbhH0RMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 13:12:48 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA9C0C061757
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 10:11:59 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id y144so7924984qkb.6
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 10:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9GfgTMROga8z98Sw/g9Op7xG75QpQ/L4gEAmBf4SpAw=;
        b=rrAPHMuMHne12+1B0e70v5t3EOnulGgBwWdhaX+YRZC7CvR53iab/NOXHtxVQ9tX/7
         mDtxxZVvcBf3yQYfAFVip54J9UNNFlKerGKYyeXx9dkiczgLCZzPQea+lw1AzrSJNvoT
         NP8rXTt9vvrFWgJYPrwr2ZBAXyAfACY++TGqP4HiWvtXB3X3Ny4Bl3DCl1v8XulxqDH8
         KGWaLwk3BOkKBSHvQVukWGgNxNsTvuE1rKv1mytUdhtAz75NkgUIejoomXWnaFyHwHRT
         Bhf8QPdLFjQTPoNkbmkPf98lmxTtqyUyoHktMGtpXOJt31Pm5SrWw1E/wOLBFd8YjhqR
         ZWCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9GfgTMROga8z98Sw/g9Op7xG75QpQ/L4gEAmBf4SpAw=;
        b=DBHaEDd15h3AUl9ODT91XAQFy5LqZ9Y79F1E6gZ9fFH4rTSvihsAU5YfnekKDhowSa
         PkYzjpNupwQVrlkEJzHGM/FNZUtmFzf0OtadXg4gt7szWF+N5Xjg+8vGsDDqtuCgDEYV
         +sr4pAHOMVB4K1MyC+L5Qfx1UhD4LkBtDP6o5lBddBkBbQAs/cpMxuaNV1/ciOl4VVeL
         UGk6RSXzRLjd1VnFdaGZYQoYdvvR6GQjWlHTP2PlJHvD2KUgTgqjBUpqtKCXyBc1n/5C
         grZWTrEbHWNJWhjlD564X+D73Oc7vPgkz5beQplufo9gysfOZQk8wXigMeSPFBszNkiO
         q9Sg==
X-Gm-Message-State: AOAM531giHlm+m3XOwcnJFwgKS3xowft2ijRkVFCcwA9zzblTE7syfDd
        K6WDAEUxb+zINkg05Vh2bUU=
X-Google-Smtp-Source: ABdhPJw4nyQlMmdXh52noQbdTuY2kVQHB6+/tdxaRadXpSQj1p02TygDspmk/24BxPQuLbgfH55VjQ==
X-Received: by 2002:a37:8747:: with SMTP id j68mr10341122qkd.165.1630084318872;
        Fri, 27 Aug 2021 10:11:58 -0700 (PDT)
Received: from localhost ([12.28.44.171])
        by smtp.gmail.com with ESMTPSA id z20sm3930396qto.71.2021.08.27.10.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 10:11:58 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>
Subject: [PATCH] lib/vsprintf: add __putchar()
Date:   Fri, 27 Aug 2021 10:11:55 -0700
Message-Id: <20210827171155.700434-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are 26 occurrences of the code snippet like this in the file :
	if (buf < end)
	        *buf = separator;
	++buf;

This patch adds a helper function __putchar() to replace opencoding.
It adds a lot to readability, and also saves 43 bytes of text on x86.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 lib/vsprintf.c | 174 +++++++++++++++++--------------------------------
 1 file changed, 59 insertions(+), 115 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 134216c45980..58a985686c08 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -53,6 +53,14 @@
 #include <linux/string_helpers.h>
 #include "kstrtox.h"
 
+static inline char *__putchar(char *buf, const char *end, char c)
+{
+	if (buf < end)
+		*buf = c;
+
+	return buf + 1;
+}
+
 static unsigned long long simple_strntoull(const char *startp, size_t max_chars,
 					   char **endp, unsigned int base)
 {
@@ -509,59 +517,38 @@ char *number(char *buf, char *end, unsigned long long num,
 	/* leading space padding */
 	field_width -= precision;
 	if (!(spec.flags & (ZEROPAD | LEFT))) {
-		while (--field_width >= 0) {
-			if (buf < end)
-				*buf = ' ';
-			++buf;
-		}
+		while (--field_width >= 0)
+			buf = __putchar(buf, end, ' ');
 	}
 	/* sign */
-	if (sign) {
-		if (buf < end)
-			*buf = sign;
-		++buf;
-	}
+	if (sign)
+		buf = __putchar(buf, end, sign);
+
 	/* "0x" / "0" prefix */
 	if (need_pfx) {
-		if (spec.base == 16 || !is_zero) {
-			if (buf < end)
-				*buf = '0';
-			++buf;
-		}
-		if (spec.base == 16) {
-			if (buf < end)
-				*buf = ('X' | locase);
-			++buf;
-		}
+		if (spec.base == 16 || !is_zero)
+			buf = __putchar(buf, end, '0');
+		if (spec.base == 16)
+			buf = __putchar(buf, end, 'X' | locase);
 	}
 	/* zero or space padding */
 	if (!(spec.flags & LEFT)) {
 		char c = ' ' + (spec.flags & ZEROPAD);
 
-		while (--field_width >= 0) {
-			if (buf < end)
-				*buf = c;
-			++buf;
-		}
+		while (--field_width >= 0)
+			buf = __putchar(buf, end, c);
 	}
 	/* hmm even more zero padding? */
-	while (i <= --precision) {
-		if (buf < end)
-			*buf = '0';
-		++buf;
-	}
+	while (i <= --precision)
+		buf = __putchar(buf, end, '0');
+
 	/* actual digits of result */
-	while (--i >= 0) {
-		if (buf < end)
-			*buf = tmp[i];
-		++buf;
-	}
+	while (--i >= 0)
+		buf = __putchar(buf, end, tmp[i]);
+
 	/* trailing space padding */
-	while (--field_width >= 0) {
-		if (buf < end)
-			*buf = ' ';
-		++buf;
-	}
+	while (--field_width >= 0)
+		buf = __putchar(buf, end, ' ');
 
 	return buf;
 }
@@ -619,11 +606,9 @@ char *widen_string(char *buf, int n, char *end, struct printf_spec spec)
 		move_right(buf - n, end, n, spaces);
 		return buf + spaces;
 	}
-	while (spaces--) {
-		if (buf < end)
-			*buf = ' ';
-		++buf;
-	}
+	while (spaces--)
+		buf = __putchar(buf, end, ' ');
+
 	return buf;
 }
 
@@ -638,9 +623,7 @@ static char *string_nocheck(char *buf, char *end, const char *s,
 		char c = *s++;
 		if (!c)
 			break;
-		if (buf < end)
-			*buf = c;
-		++buf;
+		buf = __putchar(buf, end, c);
 		++len;
 	}
 	return widen_string(buf, len, end, spec);
@@ -968,11 +951,9 @@ char *bdev_name(char *buf, char *end, struct block_device *bdev,
 	hd = bdev->bd_disk;
 	buf = string(buf, end, hd->disk_name, spec);
 	if (bdev->bd_partno) {
-		if (isdigit(hd->disk_name[strlen(hd->disk_name)-1])) {
-			if (buf < end)
-				*buf = 'p';
-			buf++;
-		}
+		if (isdigit(hd->disk_name[strlen(hd->disk_name)-1]))
+			buf = __putchar(buf, end, 'p');
+
 		buf = number(buf, end, bdev->bd_partno, spec);
 	}
 	return buf;
@@ -1175,18 +1156,10 @@ char *hex_string(char *buf, char *end, u8 *addr, struct printf_spec spec,
 		len = min_t(int, spec.field_width, 64);
 
 	for (i = 0; i < len; ++i) {
-		if (buf < end)
-			*buf = hex_asc_hi(addr[i]);
-		++buf;
-		if (buf < end)
-			*buf = hex_asc_lo(addr[i]);
-		++buf;
-
-		if (separator && i != len - 1) {
-			if (buf < end)
-				*buf = separator;
-			++buf;
-		}
+		buf = __putchar(buf, end, hex_asc_hi(addr[i]));
+		buf = __putchar(buf, end, hex_asc_lo(addr[i]));
+		if (separator && i != len - 1)
+			buf = __putchar(buf, end, separator);
 	}
 
 	return buf;
@@ -1221,11 +1194,9 @@ char *bitmap_string(char *buf, char *end, unsigned long *bitmap,
 		bit = i % BITS_PER_LONG;
 		val = (bitmap[word] >> bit) & chunkmask;
 
-		if (!first) {
-			if (buf < end)
-				*buf = ',';
-			buf++;
-		}
+		if (!first)
+			buf = __putchar(buf, end, ',');
+
 		first = false;
 
 		spec.field_width = DIV_ROUND_UP(chunksz, 4);
@@ -1248,20 +1219,17 @@ char *bitmap_list_string(char *buf, char *end, unsigned long *bitmap,
 		return buf;
 
 	for_each_set_bitrange(rbot, rtop, bitmap, nr_bits) {
-		if (!first) {
-			if (buf < end)
-				*buf = ',';
-			buf++;
-		}
+		if (!first)
+			buf = __putchar(buf, end, ',');
+
 		first = false;
 
 		buf = number(buf, end, rbot, default_dec_spec);
 		if (rtop == rbot + 1)
 			continue;
 
-		if (buf < end)
-			*buf = '-';
-		buf = number(buf + 1, end, rtop - 1, default_dec_spec);
+		buf = __putchar(buf, end, '-');
+		buf = number(buf, end, rtop - 1, default_dec_spec);
 	}
 	return buf;
 }
@@ -1822,14 +1790,9 @@ char *date_str(char *buf, char *end, const struct rtc_time *tm, bool r)
 	int mon = tm->tm_mon + (r ? 0 : 1);
 
 	buf = number(buf, end, year, default_dec04_spec);
-	if (buf < end)
-		*buf = '-';
-	buf++;
-
+	buf = __putchar(buf, end, '-');
 	buf = number(buf, end, mon, default_dec02_spec);
-	if (buf < end)
-		*buf = '-';
-	buf++;
+	buf = __putchar(buf, end, '-');
 
 	return number(buf, end, tm->tm_mday, default_dec02_spec);
 }
@@ -1838,14 +1801,9 @@ static noinline_for_stack
 char *time_str(char *buf, char *end, const struct rtc_time *tm, bool r)
 {
 	buf = number(buf, end, tm->tm_hour, default_dec02_spec);
-	if (buf < end)
-		*buf = ':';
-	buf++;
-
+	buf = __putchar(buf, end, ':');
 	buf = number(buf, end, tm->tm_min, default_dec02_spec);
-	if (buf < end)
-		*buf = ':';
-	buf++;
+	buf = __putchar(buf, end, ':');
 
 	return number(buf, end, tm->tm_sec, default_dec02_spec);
 }
@@ -1889,11 +1847,8 @@ char *rtc_str(char *buf, char *end, const struct rtc_time *tm,
 
 	if (have_d)
 		buf = date_str(buf, end, tm, raw);
-	if (have_d && have_t) {
-		if (buf < end)
-			*buf = iso8601_separator ? 'T' : ' ';
-		buf++;
-	}
+	if (have_d && have_t)
+		buf = __putchar(buf, end, iso8601_separator ? 'T' : ' ');
 	if (have_t)
 		buf = time_str(buf, end, tm, raw);
 
@@ -1972,11 +1927,8 @@ char *format_flags(char *buf, char *end, unsigned long flags,
 		buf = string(buf, end, names->name, default_str_spec);
 
 		flags &= ~mask;
-		if (flags) {
-			if (buf < end)
-				*buf = '|';
-			buf++;
-		}
+		if (flags)
+			buf = __putchar(buf, end, '|');
 	}
 
 	if (flags)
@@ -2026,16 +1978,11 @@ char *format_page_flags(char *buf, char *end, unsigned long flags)
 			continue;
 
 		/* Format: Flag Name + '=' (equals sign) + Number + '|' (separator) */
-		if (append) {
-			if (buf < end)
-				*buf = '|';
-			buf++;
-		}
+		if (append)
+			buf = __putchar(buf, end, '|');
 
 		buf = string(buf, end, pff[i].name, default_str_spec);
-		if (buf < end)
-			*buf = '=';
-		buf++;
+		buf = __putchar(buf, end, '=');
 		buf = number(buf, end, (flags >> pff[i].shift) & pff[i].mask,
 			     *pff[i].spec);
 
@@ -2125,11 +2072,8 @@ char *device_node_string(char *buf, char *end, struct device_node *dn,
 
 	for (pass = false; strspn(fmt,"fnpPFcC"); fmt++, pass = true) {
 		int precision;
-		if (pass) {
-			if (buf < end)
-				*buf = ':';
-			buf++;
-		}
+		if (pass)
+			buf = __putchar(buf, end, ':');
 
 		switch (*fmt) {
 		case 'f':	/* full_name */
-- 
2.30.2

