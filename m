Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2B6B400D70
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Sep 2021 01:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235790AbhIDXLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 19:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236070AbhIDXLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 19:11:37 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9E1CC0613CF
        for <linux-kernel@vger.kernel.org>; Sat,  4 Sep 2021 16:10:35 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id u11-20020a17090adb4b00b00181668a56d6so2079550pjx.5
        for <linux-kernel@vger.kernel.org>; Sat, 04 Sep 2021 16:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ToPs2jRrz4x0XS4d4UNDYjpT1IuPancszzE+yLJCLOw=;
        b=H2cmGzuOTFKBL/pWYkrnaOwxjcW6EzaULyEbqhteZfVk7RUu/0EOIsLfIl0KkGmc/L
         0PGRug8d1aM4+PSb0jyQNFXatpgew9Ha+cBSIhccYne6pLVKaxXx7WqQHiELhpkza3Lv
         5yyJ0ejmlB6huwzLhblCV4KahWnIEuh4kXTQ1H1zJ9cwmPdixU3Pt84ChQt2Gzo8MOGa
         cpjhsIfoa2As+TkNuM1cTLQF8LVkNEG7i2FRnrJQLDbFK3gfybTEffsT4u2HK1AP1wvW
         FLfriihthy8keQiZmSNlnoXO9VHEAAYuryHYiEOJC4nECpnAo+dTBEHFJatW15q17QOd
         BBdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ToPs2jRrz4x0XS4d4UNDYjpT1IuPancszzE+yLJCLOw=;
        b=KmHTsyuSDf6o2DL6S6Fcx3Iikqmh7bDgGnW5Uo2vdOXB4Hf6s2gItMWWxYD6aGaRkT
         kEYk+VR4Mp9S83vc6o7HrckivvxDbVJmyr/37N5QRVetacOmxRBdsxhxb0l/ZJj/Da73
         slNVoEZUeMPzVccNUauQcHJ5w+tiKl5SD3+kjIN2AWPx1DValHnOltKFuAJNChCp8byr
         y90FBUZgXOkwa1KNx4dYfJ7lKy4skjhBYnXcPRrjTV6/S3J+mt2xxCN2sCtQbEyDHLFx
         K9tu4jwWFcygEGex0e8TX98bZb2nRBacKZfuzXLAvbMtbCoY22oW67qpLWAgRz73MlO8
         K0vQ==
X-Gm-Message-State: AOAM533SRWQxxLrojOqZVSHH+0/Y19YcPpGdobJilmmcWyqDuYM702rA
        l0RixjDM+0iwXvgx+F3QkIU=
X-Google-Smtp-Source: ABdhPJxm6TRdwwIC5d0VGLMrG8edhM+2BGCDO/5Dbi/JexqgV7IRoD/Wrcl+kcIkbH/PhtHS7q/hPg==
X-Received: by 2002:a17:902:9682:b0:138:e2f9:720d with SMTP id n2-20020a170902968200b00138e2f9720dmr4787468plp.57.1630797035123;
        Sat, 04 Sep 2021 16:10:35 -0700 (PDT)
Received: from localhost ([202.164.25.5])
        by smtp.gmail.com with ESMTPSA id n1sm3138192pfv.209.2021.09.04.16.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Sep 2021 16:10:34 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Chris Down <chris@chrisdown.name>,
        Gilles Muller <Gilles.Muller@inria.fr>,
        Ingo Molnar <mingo@kernel.org>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Joe Perches <joe@perches.com>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Peter Zijlstra <peterz@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, cocci@systeme.lip6.fr
Cc:     Yury Norov <yury.norov@gmail.com>
Subject: [PATCH v2 1/2] lib: add sputchar() helper
Date:   Sat,  4 Sep 2021 16:10:19 -0700
Message-Id: <20210904231020.331185-2-yury.norov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210904231020.331185-1-yury.norov@gmail.com>
References: <20210904231020.331185-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are 47 occurrences of the code snippet like this:
	if (buf < end)
	        *buf = ' ';
	++buf;

This patch adds a helper function sputchar() to replace opencoding.
It adds a lot to readability, and also saves 43 bytes of text on x86.

v2: cleanup cases discovered with coccinelle script.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 include/linux/kernel.h |   8 ++
 lib/string_helpers.c   |  56 +++--------
 lib/vsprintf.c         | 222 +++++++++++++----------------------------
 3 files changed, 90 insertions(+), 196 deletions(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 1b2f0a7e00d6..01941ed2f5aa 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -283,6 +283,14 @@ extern char *bin2hex(char *dst, const void *src, size_t count);
 
 bool mac_pton(const char *s, u8 *mac);
 
+static inline char *sputchar(char *buf, const char *end, char c)
+{
+	if (buf < end)
+		*buf = c;
+
+	return buf + 1;
+}
+
 /*
  * General tracing related utility functions - trace_printk(),
  * tracing_on/tracing_off and tracing_start()/tracing_stop
diff --git a/lib/string_helpers.c b/lib/string_helpers.c
index 3806a52ce697..f4e0c719650d 100644
--- a/lib/string_helpers.c
+++ b/lib/string_helpers.c
@@ -335,12 +335,8 @@ static bool escape_space(unsigned char c, char **dst, char *end)
 		return false;
 	}
 
-	if (out < end)
-		*out = '\\';
-	++out;
-	if (out < end)
-		*out = to;
-	++out;
+	out = sputchar(out, end, '\\');
+	out = sputchar(out, end, to);
 
 	*dst = out;
 	return true;
@@ -368,12 +364,8 @@ static bool escape_special(unsigned char c, char **dst, char *end)
 		return false;
 	}
 
-	if (out < end)
-		*out = '\\';
-	++out;
-	if (out < end)
-		*out = to;
-	++out;
+	out = sputchar(out, end, '\\');
+	out = sputchar(out, end, to);
 
 	*dst = out;
 	return true;
@@ -386,12 +378,8 @@ static bool escape_null(unsigned char c, char **dst, char *end)
 	if (c)
 		return false;
 
-	if (out < end)
-		*out = '\\';
-	++out;
-	if (out < end)
-		*out = '0';
-	++out;
+	out = sputchar(out, end, '\\');
+	out = sputchar(out, end, '0');
 
 	*dst = out;
 	return true;
@@ -401,18 +389,10 @@ static bool escape_octal(unsigned char c, char **dst, char *end)
 {
 	char *out = *dst;
 
-	if (out < end)
-		*out = '\\';
-	++out;
-	if (out < end)
-		*out = ((c >> 6) & 0x07) + '0';
-	++out;
-	if (out < end)
-		*out = ((c >> 3) & 0x07) + '0';
-	++out;
-	if (out < end)
-		*out = ((c >> 0) & 0x07) + '0';
-	++out;
+	out = sputchar(out, end, '\\');
+	out = sputchar(out, end, ((c >> 6) & 0x07) + '0');
+	out = sputchar(out, end, ((c >> 3) & 0x07) + '0');
+	out = sputchar(out, end, ((c >> 0) & 0x07) + '0');
 
 	*dst = out;
 	return true;
@@ -422,18 +402,10 @@ static bool escape_hex(unsigned char c, char **dst, char *end)
 {
 	char *out = *dst;
 
-	if (out < end)
-		*out = '\\';
-	++out;
-	if (out < end)
-		*out = 'x';
-	++out;
-	if (out < end)
-		*out = hex_asc_hi(c);
-	++out;
-	if (out < end)
-		*out = hex_asc_lo(c);
-	++out;
+	out = sputchar(out, end, '\\');
+	out = sputchar(out, end, 'x');
+	out = sputchar(out, end, hex_asc_hi(c));
+	out = sputchar(out, end, hex_asc_lo(c));
 
 	*dst = out;
 	return true;
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 919b70d00855..9d4c9fd81845 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -509,59 +509,38 @@ char *number(char *buf, char *end, unsigned long long num,
 	/* leading space padding */
 	field_width -= precision;
 	if (!(spec.flags & (ZEROPAD | LEFT))) {
-		while (--field_width >= 0) {
-			if (buf < end)
-				*buf = ' ';
-			++buf;
-		}
+		while (--field_width >= 0)
+			buf = sputchar(buf, end, ' ');
 	}
 	/* sign */
-	if (sign) {
-		if (buf < end)
-			*buf = sign;
-		++buf;
-	}
+	if (sign)
+		buf = sputchar(buf, end, sign);
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
+			buf = sputchar(buf, end, '0');
+		if (spec.base == 16)
+			buf = sputchar(buf, end, 'X' | locase);
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
+			buf = sputchar(buf, end, c);
 	}
 	/* hmm even more zero padding? */
-	while (i <= --precision) {
-		if (buf < end)
-			*buf = '0';
-		++buf;
-	}
+	while (i <= --precision)
+		buf = sputchar(buf, end, '0');
+
 	/* actual digits of result */
-	while (--i >= 0) {
-		if (buf < end)
-			*buf = tmp[i];
-		++buf;
-	}
+	while (--i >= 0)
+		buf = sputchar(buf, end, tmp[i]);
+
 	/* trailing space padding */
-	while (--field_width >= 0) {
-		if (buf < end)
-			*buf = ' ';
-		++buf;
-	}
+	while (--field_width >= 0)
+		buf = sputchar(buf, end, ' ');
 
 	return buf;
 }
@@ -619,11 +598,9 @@ char *widen_string(char *buf, int n, char *end, struct printf_spec spec)
 		move_right(buf - n, end, n, spaces);
 		return buf + spaces;
 	}
-	while (spaces--) {
-		if (buf < end)
-			*buf = ' ';
-		++buf;
-	}
+	while (spaces--)
+		buf = sputchar(buf, end, ' ');
+
 	return buf;
 }
 
@@ -638,9 +615,7 @@ static char *string_nocheck(char *buf, char *end, const char *s,
 		char c = *s++;
 		if (!c)
 			break;
-		if (buf < end)
-			*buf = c;
-		++buf;
+		buf = sputchar(buf, end, c);
 		++len;
 	}
 	return widen_string(buf, len, end, spec);
@@ -931,7 +906,7 @@ char *dentry_name(char *buf, char *end, const struct dentry *d, struct printf_sp
 		}
 	}
 	s = array[--i];
-	for (n = 0; n != spec.precision; n++, buf++) {
+	for (n = 0; n != spec.precision; n++) {
 		char c = *s++;
 		if (!c) {
 			if (!i)
@@ -939,8 +914,7 @@ char *dentry_name(char *buf, char *end, const struct dentry *d, struct printf_sp
 			c = '/';
 			s = array[--i];
 		}
-		if (buf < end)
-			*buf = c;
+		buf = sputchar(buf, end, c);
 	}
 	rcu_read_unlock();
 	return widen_string(buf, n, end, spec);
@@ -968,11 +942,9 @@ char *bdev_name(char *buf, char *end, struct block_device *bdev,
 	hd = bdev->bd_disk;
 	buf = string(buf, end, hd->disk_name, spec);
 	if (bdev->bd_partno) {
-		if (isdigit(hd->disk_name[strlen(hd->disk_name)-1])) {
-			if (buf < end)
-				*buf = 'p';
-			buf++;
-		}
+		if (isdigit(hd->disk_name[strlen(hd->disk_name)-1]))
+			buf = sputchar(buf, end, 'p');
+
 		buf = number(buf, end, bdev->bd_partno, spec);
 	}
 	return buf;
@@ -1175,18 +1147,10 @@ char *hex_string(char *buf, char *end, u8 *addr, struct printf_spec spec,
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
+		buf = sputchar(buf, end, hex_asc_hi(addr[i]));
+		buf = sputchar(buf, end, hex_asc_lo(addr[i]));
+		if (separator && i != len - 1)
+			buf = sputchar(buf, end, separator);
 	}
 
 	return buf;
@@ -1221,11 +1185,9 @@ char *bitmap_string(char *buf, char *end, unsigned long *bitmap,
 		bit = i % BITS_PER_LONG;
 		val = (bitmap[word] >> bit) & chunkmask;
 
-		if (!first) {
-			if (buf < end)
-				*buf = ',';
-			buf++;
-		}
+		if (!first)
+			buf = sputchar(buf, end, ',');
+
 		first = false;
 
 		spec.field_width = DIV_ROUND_UP(chunksz, 4);
@@ -1248,20 +1210,17 @@ char *bitmap_list_string(char *buf, char *end, unsigned long *bitmap,
 		return buf;
 
 	for_each_set_bitrange(rbot, rtop, bitmap, nr_bits) {
-		if (!first) {
-			if (buf < end)
-				*buf = ',';
-			buf++;
-		}
+		if (!first)
+			buf = sputchar(buf, end, ',');
+
 		first = false;
 
 		buf = number(buf, end, rbot, default_dec_spec);
 		if (rtop == rbot + 1)
 			continue;
 
-		if (buf < end)
-			*buf = '-';
-		buf = number(buf + 1, end, rtop - 1, default_dec_spec);
+		buf = sputchar(buf, end, '-');
+		buf = number(buf, end, rtop - 1, default_dec_spec);
 	}
 	return buf;
 }
@@ -1822,14 +1781,9 @@ char *date_str(char *buf, char *end, const struct rtc_time *tm, bool r)
 	int mon = tm->tm_mon + (r ? 0 : 1);
 
 	buf = number(buf, end, year, default_dec04_spec);
-	if (buf < end)
-		*buf = '-';
-	buf++;
-
+	buf = sputchar(buf, end, '-');
 	buf = number(buf, end, mon, default_dec02_spec);
-	if (buf < end)
-		*buf = '-';
-	buf++;
+	buf = sputchar(buf, end, '-');
 
 	return number(buf, end, tm->tm_mday, default_dec02_spec);
 }
@@ -1838,14 +1792,9 @@ static noinline_for_stack
 char *time_str(char *buf, char *end, const struct rtc_time *tm, bool r)
 {
 	buf = number(buf, end, tm->tm_hour, default_dec02_spec);
-	if (buf < end)
-		*buf = ':';
-	buf++;
-
+	buf = sputchar(buf, end, ':');
 	buf = number(buf, end, tm->tm_min, default_dec02_spec);
-	if (buf < end)
-		*buf = ':';
-	buf++;
+	buf = sputchar(buf, end, ':');
 
 	return number(buf, end, tm->tm_sec, default_dec02_spec);
 }
@@ -1889,11 +1838,8 @@ char *rtc_str(char *buf, char *end, const struct rtc_time *tm,
 
 	if (have_d)
 		buf = date_str(buf, end, tm, raw);
-	if (have_d && have_t) {
-		if (buf < end)
-			*buf = iso8601_separator ? 'T' : ' ';
-		buf++;
-	}
+	if (have_d && have_t)
+		buf = sputchar(buf, end, iso8601_separator ? 'T' : ' ');
 	if (have_t)
 		buf = time_str(buf, end, tm, raw);
 
@@ -1972,11 +1918,8 @@ char *format_flags(char *buf, char *end, unsigned long flags,
 		buf = string(buf, end, names->name, default_str_spec);
 
 		flags &= ~mask;
-		if (flags) {
-			if (buf < end)
-				*buf = '|';
-			buf++;
-		}
+		if (flags)
+			buf = sputchar(buf, end, '|');
 	}
 
 	if (flags)
@@ -2026,16 +1969,11 @@ char *format_page_flags(char *buf, char *end, unsigned long flags)
 			continue;
 
 		/* Format: Flag Name + '=' (equals sign) + Number + '|' (separator) */
-		if (append) {
-			if (buf < end)
-				*buf = '|';
-			buf++;
-		}
+		if (append)
+			buf = sputchar(buf, end, '|');
 
 		buf = string(buf, end, pff[i].name, default_str_spec);
-		if (buf < end)
-			*buf = '=';
-		buf++;
+		buf = sputchar(buf, end, '=');
 		buf = number(buf, end, (flags >> pff[i].shift) & pff[i].mask,
 			     *pff[i].spec);
 
@@ -2125,11 +2063,8 @@ char *device_node_string(char *buf, char *end, struct device_node *dn,
 
 	for (pass = false; strspn(fmt,"fnpPFcC"); fmt++, pass = true) {
 		int precision;
-		if (pass) {
-			if (buf < end)
-				*buf = ':';
-			buf++;
-		}
+		if (pass)
+			buf = sputchar(buf, end, ':');
 
 		switch (*fmt) {
 		case 'f':	/* full_name */
@@ -2773,25 +2708,14 @@ int vsnprintf(char *buf, size_t size, const char *fmt, va_list args)
 			break;
 
 		case FORMAT_TYPE_CHAR: {
-			char c;
-
 			if (!(spec.flags & LEFT)) {
-				while (--spec.field_width > 0) {
-					if (str < end)
-						*str = ' ';
-					++str;
-
-				}
-			}
-			c = (unsigned char) va_arg(args, int);
-			if (str < end)
-				*str = c;
-			++str;
-			while (--spec.field_width > 0) {
-				if (str < end)
-					*str = ' ';
-				++str;
+				while (--spec.field_width > 0)
+					str = sputchar(str, end, ' ');
 			}
+			str = sputchar(str, end, (unsigned char) va_arg(args, int));
+
+			while (--spec.field_width > 0)
+				str = sputchar(str, end, ' ');
 			break;
 		}
 
@@ -2807,9 +2731,7 @@ int vsnprintf(char *buf, size_t size, const char *fmt, va_list args)
 			break;
 
 		case FORMAT_TYPE_PERCENT_CHAR:
-			if (str < end)
-				*str = '%';
-			++str;
+			str = sputchar(str, end, '%');
 			break;
 
 		case FORMAT_TYPE_INVALID:
@@ -3251,21 +3173,15 @@ int bstr_printf(char *buf, size_t size, const char *fmt, const u32 *bin_buf)
 			char c;
 
 			if (!(spec.flags & LEFT)) {
-				while (--spec.field_width > 0) {
-					if (str < end)
-						*str = ' ';
-					++str;
-				}
+				while (--spec.field_width > 0)
+					str = sputchar(str, end, ' ');
 			}
+
 			c = (unsigned char) get_arg(char);
-			if (str < end)
-				*str = c;
-			++str;
-			while (--spec.field_width > 0) {
-				if (str < end)
-					*str = ' ';
-				++str;
-			}
+			str = sputchar(str, end, c);
+
+			while (--spec.field_width > 0)
+				str = sputchar(str, end, ' ');
 			break;
 		}
 
@@ -3312,9 +3228,7 @@ int bstr_printf(char *buf, size_t size, const char *fmt, const u32 *bin_buf)
 		}
 
 		case FORMAT_TYPE_PERCENT_CHAR:
-			if (str < end)
-				*str = '%';
-			++str;
+			str = sputchar(str, end, '%');
 			break;
 
 		case FORMAT_TYPE_INVALID:
-- 
2.30.2

