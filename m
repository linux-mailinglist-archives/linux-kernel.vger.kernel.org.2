Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA6730A6FF
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 12:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbhBAL6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 06:58:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbhBAL54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 06:57:56 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4934C0613ED
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 03:57:15 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id m6so11435956pfk.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 03:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WzQaOBZlTdFeeAyUnIR3ljNVjCjE/Wu9Dlif4gaAJvY=;
        b=esA7Ry0kwlpxtlu85rhoQcIC9ERb01N9h6G1izh5EeCUv5c0DE4mINXeKW/5QJZ4nf
         OZQ6/YvViFie6ZkszZ+YKImtPcwd7KEjXTZMns79nK1Z4y13XLug0fM7fM3TJicSXPH1
         xTCpYhXGh6vzn+oXaRZfFc/sSL9qGZm4tqYrkHUt4dlR+fCQioAOkUeZCY8ECzz7450j
         8QNx7fkP37R3gE1xBLIIl8ohY3ywoAudl7ymCV09XD8J7TWDnkomeDJhaChlzs53h1p2
         ZLxB1whrgDdQYtYESWowG4Dx8wriKfqX+VvEVEZUu5mlBO+mzvEArEPiKyfQNKJ4wU/5
         zQFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WzQaOBZlTdFeeAyUnIR3ljNVjCjE/Wu9Dlif4gaAJvY=;
        b=DfQ0GTO6PuwK9fkjZUOkIJ6H4QXNATKXwkTbNP/8dXB+k0+mpVc9cIBPCK/+jOc0Rc
         +zqRmU+TyiYzXLjBPlgaXQiMymVBI0Sg+4ZT+MLDCBjLRbad0esWJ2+pfiNNzQEf+CL6
         eQ1Gedym9m7WEAqGi+fIToIkTz911ldv3+mCo1iOpeygElNWJ1NPRkQkkYyTI+0hx2x8
         Y/SJi4uskf6K+5yjRN5N8bnJLpSwlp3UTcP7PVPKjdrFs0YMwO3a7TCK4Xvu4CV1iE57
         LyZI56xkQHzBvuGiwE6nEV+S98Py3z4BdGgtgwyH01E0uW47iUMp/H1E4EHFtfc0S/p2
         C4hA==
X-Gm-Message-State: AOAM532A9nnH7BegdEmlwO+QBmTas4Vg4u8uVopr/q9y4apVJ1X35v7M
        tTS679/+Rr/cI7/uaG8dAnk=
X-Google-Smtp-Source: ABdhPJydLIm3lfBizKgV9U4awm2q56du2GPXWHUcY3QLtYlqtbr5xaEOPzIgFVfvfAv2yVDFc8cw6Q==
X-Received: by 2002:aa7:8c4a:0:b029:1b8:2cd1:9a69 with SMTP id e10-20020aa78c4a0000b02901b82cd19a69mr15957805pfd.46.1612180635510;
        Mon, 01 Feb 2021 03:57:15 -0800 (PST)
Received: from localhost.localdomain ([50.236.19.102])
        by smtp.gmail.com with ESMTPSA id dw23sm7195152pjb.3.2021.02.01.03.57.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Feb 2021 03:57:14 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     andriy.shevchenko@linux.intel.com, david@redhat.com,
        vbabka@suse.cz, linmiaohe@huawei.com, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, pmladek@suse.com, rostedt@goodmis.org,
        sergey.senozhatsky@gmail.com, linux@rasmusvillemoes.dk
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>,
        Joe Perches <joe@perches.com>
Subject: [PATCH v2 3/3] vsprintf: dump full information of page flags in pGp
Date:   Mon,  1 Feb 2021 19:56:10 +0800
Message-Id: <20210201115610.87808-4-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20210201115610.87808-1-laoar.shao@gmail.com>
References: <20210201115610.87808-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the pGp only shows the names of page flags, rather than
the full information including section, node, zone, last cpupid and
kasan tag. While it is not easy to parse these information manually
because there're so many flavors. Let's interpret them in pGp as well.

- Before the patch,
[ 6343.396602] Slab 0x000000004382e02b objects=33 used=3 fp=0x000000009ae06ffc flags=0x17ffffc0010200(slab|head)

- After the patch,
[ 6871.296131] Slab 0x00000000c0e19a37 objects=33 used=3 fp=0x00000000c4902159 flags=0x17ffffc0010200(Node 0,Zone 2,Lastcpupid 0x1fffff,slab|head)

The Documentation and test cases are also updated.

Cc: David Hildenbrand <david@redhat.com>
Cc: Joe Perches <joe@perches.com>
Cc: Miaohe Lin <linmiaohe@huawei.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 Documentation/core-api/printk-formats.rst |  2 +-
 lib/test_printf.c                         | 65 ++++++++++++++++++-----
 lib/vsprintf.c                            | 58 +++++++++++++++++++-
 3 files changed, 109 insertions(+), 16 deletions(-)

diff --git a/Documentation/core-api/printk-formats.rst b/Documentation/core-api/printk-formats.rst
index 6d26c5c6ac48..1374cdd04f0f 100644
--- a/Documentation/core-api/printk-formats.rst
+++ b/Documentation/core-api/printk-formats.rst
@@ -538,7 +538,7 @@ Flags bitfields such as page flags, gfp_flags
 
 ::
 
-	%pGp	referenced|uptodate|lru|active|private
+	%pGp	Node 0,Zone 2,referenced|uptodate|lru|active|private
 	%pGg	GFP_USER|GFP_DMA32|GFP_NOWARN
 	%pGv	read|exec|mayread|maywrite|mayexec|denywrite
 
diff --git a/lib/test_printf.c b/lib/test_printf.c
index 7ac87f18a10f..4c5e064cbe2e 100644
--- a/lib/test_printf.c
+++ b/lib/test_printf.c
@@ -569,6 +569,48 @@ netdev_features(void)
 {
 }
 
+static void __init
+page_flags_test(int section, int node, int zone, int last_cpupid,
+		int kasan_tag, int flags, const char *name, char *cmp_buf)
+{
+	unsigned long page_flags = 0;
+	unsigned long size = 0;
+
+#ifdef SECTION_IN_PAGE_FLAGS
+	page_flags |= (sec & SECTIONS_MASK) << SECTIONS_PGSHIFT;
+	snprintf(cmp_buf, BUF_SIZE, "Section %#x,", sec);
+	size = strlen(cmp_buf);
+#endif
+
+	page_flags |= (node & NODES_MASK) << NODES_PGSHIFT;
+	snprintf(cmp_buf + size, BUF_SIZE - size, "Node %d", node);
+	size = strlen(cmp_buf);
+
+	page_flags |= (zone & ZONES_MASK) << ZONES_PGSHIFT;
+	snprintf(cmp_buf + size, BUF_SIZE - size, ",Zone %d", zone);
+	size = strlen(cmp_buf);
+
+#ifndef LAST_CPUPID_NOT_IN_PAGE_FLAGS
+	page_flags |= (last_cpupid & LAST_CPUPID_MASK) << LAST_CPUPID_PGSHIFT;
+	snprintf(cmp_buf + size, BUF_SIZE - size, ",Lastcpupid %#x", last_cpupid);
+	size = strlen(cmp_buf);
+#endif
+
+#if defined(CONFIG_KASAN_SW_TAGS) || defined(CONFIG_KASAN_HW_TAGS)
+	page_flags |= (tag & KASAN_TAG_MASK) << KASAN_TAG_PGSHIFT;
+	snprintf(cmp_buf + size, BUF_SIZE - size, ",Kasantag %#x", tag);
+	size = strlen(cmp_buf);
+#endif
+
+	test(cmp_buf, "%pGp", &page_flags);
+
+	if (flags) {
+		page_flags |= flags;
+		snprintf(cmp_buf + size, BUF_SIZE - size, ",%s", name);
+		test(cmp_buf, "%pGp", &page_flags);
+	}
+}
+
 static void __init
 flags(void)
 {
@@ -576,17 +618,16 @@ flags(void)
 	gfp_t gfp;
 	char *cmp_buffer;
 
-	flags = 0;
-	test("", "%pGp", &flags);
-
-	/* Page flags should filter the zone id */
-	flags = 1UL << NR_PAGEFLAGS;
-	test("", "%pGp", &flags);
-
-	flags |= 1UL << PG_uptodate | 1UL << PG_dirty | 1UL << PG_lru
-		| 1UL << PG_active | 1UL << PG_swapbacked;
-	test("uptodate|dirty|lru|active|swapbacked", "%pGp", &flags);
+	cmp_buffer = kmalloc(BUF_SIZE, GFP_KERNEL);
+	if (!cmp_buffer)
+		return;
 
+	page_flags_test(0, 0, 0, 0, 0, 0, NULL, cmp_buffer);
+	page_flags_test(1, 1, 1, 0x1ffff, 1,
+			(1UL << PG_uptodate | 1UL << PG_dirty | 1UL << PG_lru
+			 | 1UL << PG_active | 1UL << PG_swapbacked),
+			"uptodate|dirty|lru|active|swapbacked",
+			cmp_buffer);
 
 	flags = VM_READ | VM_EXEC | VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC
 			| VM_DENYWRITE;
@@ -601,10 +642,6 @@ flags(void)
 	gfp = __GFP_ATOMIC;
 	test("__GFP_ATOMIC", "%pGg", &gfp);
 
-	cmp_buffer = kmalloc(BUF_SIZE, GFP_KERNEL);
-	if (!cmp_buffer)
-		return;
-
 	/* Any flags not translated by the table should remain numeric */
 	gfp = ~__GFP_BITS_MASK;
 	snprintf(cmp_buffer, BUF_SIZE, "%#lx", (unsigned long) gfp);
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 14c9a6af1b23..5c2b02ad60f1 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1916,6 +1916,62 @@ char *format_flags(char *buf, char *end, unsigned long flags,
 	return buf;
 }
 
+struct page_flags_layout {
+	int width;
+	int shift;
+	int mask;
+	const struct printf_spec *spec;
+	const char *name;
+};
+
+static const struct page_flags_layout pfl[] = {
+	{SECTIONS_WIDTH, SECTIONS_PGSHIFT, SECTIONS_MASK,
+	 &default_dec_spec, "Section "},
+	{NODES_WIDTH, NODES_PGSHIFT, NODES_MASK,
+	 &default_dec_spec, "Node "},
+	{ZONES_WIDTH, ZONES_PGSHIFT, ZONES_MASK,
+	 &default_dec_spec, "Zone "},
+	{LAST_CPUPID_WIDTH, LAST_CPUPID_PGSHIFT, LAST_CPUPID_MASK,
+	 &default_flag_spec, "Lastcpupid "},
+	{KASAN_TAG_WIDTH, KASAN_TAG_PGSHIFT, KASAN_TAG_MASK,
+	 &default_flag_spec, "Kasantag "},
+};
+
+static
+char *format_page_flags(char *buf, char *end, unsigned long page_flags)
+{
+	unsigned long flags = page_flags & ((1UL << NR_PAGEFLAGS) - 1);
+	int size = ARRAY_SIZE(pfl);
+	bool separator = false;
+	int i;
+
+	for (i = 0; i < size; i++) {
+		if (pfl[i].width == 0)
+			continue;
+
+		if (separator) {
+			if (buf < end)
+				*buf = ',';
+			buf++;
+		}
+
+
+		buf = string(buf, end, pfl[i].name, *pfl[i].spec);
+
+		buf = number(buf, end, (page_flags >> pfl[i].shift) & pfl[i].mask,
+			     *pfl[i].spec);
+		separator = true;
+	}
+
+	if (flags) {
+		if (buf < end)
+			*buf = ',';
+		buf++;
+	}
+
+	return buf;
+}
+
 static noinline_for_stack
 char *flags_string(char *buf, char *end, void *flags_ptr,
 		   struct printf_spec spec, const char *fmt)
@@ -1929,7 +1985,7 @@ char *flags_string(char *buf, char *end, void *flags_ptr,
 	switch (fmt[1]) {
 	case 'p':
 		flags = *(unsigned long *)flags_ptr;
-		/* Remove zone id */
+		buf = format_page_flags(buf, end, flags);
 		flags &= (1UL << NR_PAGEFLAGS) - 1;
 		names = pageflag_names;
 		break;
-- 
2.17.1

