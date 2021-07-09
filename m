Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 235093C1DE9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 05:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbhGIDsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 23:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbhGIDsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 23:48:09 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90015C061574
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jul 2021 20:45:25 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id ck17so3438880qvb.9
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 20:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LZc6PQvxJE3vuowyf5qW3WCAvlsyelNP3ykNDlBCd4A=;
        b=peRb848JP0XojBcDzRRia1v4sfZsZkCPLhNPiqDk47nE/YHcnau8FUbgkQsOXltIrp
         eEV0brbekkLX5ip2oaMIyIp0wvX4z0w6MS9jy7f4rtLHG34ca4FugsmWXLbdctRbE/5U
         XlBxhUs8ygwh5Nas7siRlT1ShQjL3y9GPZSqJuOtGbP8kAicPYSIjCusa+Y6MJDnYK3H
         r5Urbmp7WesBlUm1K+KC9ZgVNZUgT3FKvi5kIWpRajpsoD5IVHuyoK3b9PCXkwA+VqUQ
         dQ/8yV/4v3tEfjAGZsmFIIrV9dSSnPiH1w4DFUVLV7NgKsuTbVBY0TRWJUygGTsTbsZh
         Gqdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LZc6PQvxJE3vuowyf5qW3WCAvlsyelNP3ykNDlBCd4A=;
        b=rA/cHWO4suxXp/yHy78vQPV2za6+Wn1y4nEnA2jRlJw9avKbgopF1EONQbx6L6HgYu
         7l8+y5/z0iNk8zbjOIQtK89suhq6oWpcsORfbWrMlq+c5Bw2fidzz9Fgbqu/YHVK/jTi
         FruoEosnQTMVn3cpIynNQmhsT56bSG2W+oTKwKKb9ELL1xCM0qR32NpmcM0HyFeNIIHk
         hU4UYbFudSj50ChKUCvtwAbIcGtL2fYh5d/N2IBoOs6F/SuKi4fZKZE1W5Zo1zYjGJVi
         kaKzopLY4b31ROK77yKBeMSLQpciA4V4KKBWlHU7fF+gj4t3fajOXsneDRAxsjFFBwQE
         lNLw==
X-Gm-Message-State: AOAM531TK0rm86EjYLCQRhKjvLKk18CYUKVLykvbatlBpCTkLEk0Zdjk
        dr8J4ET+y8OHCCL7hMx6hCzbH+1xxLo=
X-Google-Smtp-Source: ABdhPJziLEsfdBh7HPtU/ANQ0WrGdPj0Hqhl/zbC8MJOKqCIXaIKhf/qRfKhC0Vy9fk4XTSPDS6Hqw==
X-Received: by 2002:a05:6214:90e:: with SMTP id dj14mr33498193qvb.10.1625802324438;
        Thu, 08 Jul 2021 20:45:24 -0700 (PDT)
Received: from localhost ([207.98.216.60])
        by smtp.gmail.com with ESMTPSA id p187sm1977782qkd.101.2021.07.08.20.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jul 2021 20:45:24 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 2/2] bitmap: introduce for_each_set_bitrange
Date:   Thu,  8 Jul 2021 20:45:19 -0700
Message-Id: <20210709034519.2859777-3-yury.norov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210709034519.2859777-1-yury.norov@gmail.com>
References: <20210709034519.2859777-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bitmap_list_string() is very ineffective when printing bitmaps with long
ranges of set bits because it calls find_next_bit for each bit. We can do
better by detecting ranges of set bits.

This patch introduces a macro for_each_set_bitrange and uses it in
bitmap_list_string(). In my environment, before/after is 943008/31008 ns.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 include/linux/find.h |  7 +++++++
 lib/vsprintf.c       | 40 ++++++++++++++++------------------------
 2 files changed, 23 insertions(+), 24 deletions(-)

diff --git a/include/linux/find.h b/include/linux/find.h
index ae9ed52b52b8..1a5ed45dc81b 100644
--- a/include/linux/find.h
+++ b/include/linux/find.h
@@ -301,6 +301,13 @@ unsigned long find_next_bit_le(const void *addr, unsigned
 	     (bit) < (size);					\
 	     (bit) = find_next_zero_bit((addr), (size), (bit) + 1))
 
+#define for_each_set_bitrange(b, e, addr, size)			\
+	for ((b) = find_next_bit((addr), (size), 0),		\
+	     (e) = find_next_zero_bit((addr), (size), (b) + 1);	\
+	     (b) < (size);					\
+	     (b) = find_next_bit((addr), (size), (e) + 1),	\
+	     (e) = find_next_zero_bit((addr), (size), (b) + 1))
+
 /**
  * for_each_set_clump8 - iterate over bitmap for each 8-bit clump with set bits
  * @start: bit offset to start search and to store the current iteration offset
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 87acf66f0e4c..1ee54dace71e 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1240,38 +1240,30 @@ char *bitmap_list_string(char *buf, char *end, unsigned long *bitmap,
 			 struct printf_spec spec, const char *fmt)
 {
 	int nr_bits = max_t(int, spec.field_width, 0);
-	/* current bit is 'cur', most recently seen range is [rbot, rtop] */
-	int cur, rbot, rtop;
-	bool first = true;
+	char *start = buf;
+	int b, e;
 
 	if (check_pointer(&buf, end, bitmap, spec))
 		return buf;
 
-	rbot = cur = find_first_bit(bitmap, nr_bits);
-	while (cur < nr_bits) {
-		rtop = cur;
-		cur = find_next_bit(bitmap, nr_bits, cur + 1);
-		if (cur < nr_bits && cur <= rtop + 1)
-			continue;
+	for_each_set_bitrange(b, e, bitmap, nr_bits) {
+		buf = number(buf, end, b, default_dec_spec);
+		if (e == b + 1)
+			goto put_comma;
 
-		if (!first) {
-			if (buf < end)
-				*buf = ',';
-			buf++;
-		}
-		first = false;
+		if (buf < end)
+			*buf = '-';
 
-		buf = number(buf, end, rbot, default_dec_spec);
-		if (rbot < rtop) {
-			if (buf < end)
-				*buf = '-';
-			buf++;
+		buf = number(++buf, end, e - 1, default_dec_spec);
+put_comma:
+		if (buf < end)
+			*buf = ',';
+		buf++;
+	}
 
-			buf = number(buf, end, rtop, default_dec_spec);
-		}
+	if (buf > start)
+		buf--;
 
-		rbot = cur;
-	}
 	return buf;
 }
 
-- 
2.30.2

