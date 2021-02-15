Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0893F31C01C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 18:08:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232476AbhBORIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 12:08:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbhBOPyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 10:54:02 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74556C061786
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 07:53:22 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id m6so4425956pfk.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 07:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4E1nnM6ZaInBESVeB5VZaUIJRc1fwF45IAGjtqazWmg=;
        b=YUJ59Vsx1Ga127DXK5+mjIbzGwFfJpB/Z3jROGhW8HlDgobdrSukwz1snyPO3MYBFd
         moS9Kqk8rfEkjI65EV1Uj7FKKDHVJAIi0pl9BU/+/amLq/c179hDddA3NWjskb5LTlwG
         bS4HJHL3k3+Mb7C3sz8Xm1rRdpOvHaD0TH1JPnMnOczq1KhgdpwAokBHbpm8AXsFMrz8
         6RLztNJrvyno0aaYDr2kouh2jAoFECPXbBPczrlp3KpeIqAxfE7/bm5wHjoP5qEmV9/O
         Xy78qxmz9MUEInNVmsYZ6xErJYeE0NH3u6QQSSw2g7NR7Uu5BLzu3flFBZv1wTi3tP6S
         ahjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4E1nnM6ZaInBESVeB5VZaUIJRc1fwF45IAGjtqazWmg=;
        b=TeQpKkgNYdxKSjoK4UKvm0mQK1WanhjaFvqMIQEaV/mTyQb7YyQ8kYHoOhHX+K5Tkh
         Rd7w1xIktgMzoeJRWVsVmJYK8sS1UmdOB/vwaCzNnkxPxUvMg8JCj1VEjo5U9dCIjOSw
         tnDsiiNK/Tx+IjaISkAxyBBy+IdnZ29KJMj9WRhBdUJfazPAB08OKmqtprr3w3AWg4UH
         9nqPVb5j1b1jFTBSc+b9f67Rcmd7ftt8N8z0aVycc/g51DVZ3r7W3RAPN3bDTFtkubKw
         zgWRhQJUJetSpi7BuKEmmNjLRZ8QQuwcZVUhk9wQRWh2DvJts1M92n4dUeNNiNgREYOk
         8c5g==
X-Gm-Message-State: AOAM531hoMUcfMtQBcVN+dMTOM7mmGwEDEOJOYh8sGllwJ3GuU+mtkX+
        aawIcNQU3ctpxPErbyy5s+k=
X-Google-Smtp-Source: ABdhPJx/8nHb7iHo0bu5n/F7o8RaHABs/aj3mosjk57ZVEoFsRESDBimsq6asncktIyJY1ta5wBwZg==
X-Received: by 2002:a63:f956:: with SMTP id q22mr7473399pgk.115.1613404401978;
        Mon, 15 Feb 2021 07:53:21 -0800 (PST)
Received: from localhost.localdomain ([50.236.19.102])
        by smtp.gmail.com with ESMTPSA id i1sm19771215pfq.158.2021.02.15.07.53.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Feb 2021 07:53:21 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     pmladek@suse.com, willy@infradead.org,
        andriy.shevchenko@linux.intel.com, david@redhat.com,
        linmiaohe@huawei.com, vbabka@suse.cz, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, rostedt@goodmis.org,
        sergey.senozhatsky@gmail.com, joe@perches.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v5 3/3] vsprintf: dump full information of page flags in pGp
Date:   Mon, 15 Feb 2021 23:51:41 +0800
Message-Id: <20210215155141.47432-4-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20210215155141.47432-1-laoar.shao@gmail.com>
References: <20210215155141.47432-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the pGp only shows the names of page flags, rather than
the full information including section, node, zone, last cpupid and
kasan tag. While it is not easy to parse these information manually
because there're so many flavors. Let's interpret them in pGp as well.

To be compitable with the existed format of pGp, the new introduced ones
also use '|' as the separator, then the user tools parsing pGp won't
need to make change, suggested by Matthew. The new information is
tracked onto the end of the existed one.

One example of the output in mm/slub.c as follows,
- Before the patch,
[ 6343.396602] Slab 0x000000004382e02b objects=33 used=3 fp=0x000000009ae06ffc flags=0x17ffffc0010200(slab|head)

- After the patch,
[ 8448.272530] Slab 0x0000000090797883 objects=33 used=3 fp=0x00000000790f1c26 flags=0x17ffffc0010200(slab|head|node=0|zone=2|lastcpupid=0x1fffff)

The documentation and test cases are also updated. The output of the
test cases as follows,
[11585.830272] test_printf: loaded.
[11585.830454] test_printf: all 388 tests passed
[11585.831401] test_printf: unloaded.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Joe Perches <joe@perches.com>
Cc: Miaohe Lin <linmiaohe@huawei.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Petr Mladek <pmladek@suse.com>
---
 Documentation/core-api/printk-formats.rst |  2 +-
 lib/test_printf.c                         | 60 +++++++++++++++++----
 lib/vsprintf.c                            | 66 +++++++++++++++++++++--
 3 files changed, 112 insertions(+), 16 deletions(-)

diff --git a/Documentation/core-api/printk-formats.rst b/Documentation/core-api/printk-formats.rst
index 160e710d992f..00d07c7eefd4 100644
--- a/Documentation/core-api/printk-formats.rst
+++ b/Documentation/core-api/printk-formats.rst
@@ -540,7 +540,7 @@ Flags bitfields such as page flags, gfp_flags
 
 ::
 
-	%pGp	referenced|uptodate|lru|active|private
+	%pGp	referenced|uptodate|lru|active|private|node=0|zone=2|lastcpupid=0x1fffff
 	%pGg	GFP_USER|GFP_DMA32|GFP_NOWARN
 	%pGv	read|exec|mayread|maywrite|mayexec|denywrite
 
diff --git a/lib/test_printf.c b/lib/test_printf.c
index 7ac87f18a10f..148773dfe97a 100644
--- a/lib/test_printf.c
+++ b/lib/test_printf.c
@@ -569,24 +569,68 @@ netdev_features(void)
 {
 }
 
+static void __init
+page_flags_test(int section, int node, int zone, int last_cpupid,
+		int kasan_tag, int flags, const char *name, char *cmp_buf)
+{
+	unsigned long page_flags = 0;
+	unsigned long size = 0;
+
+	flags &= BIT(NR_PAGEFLAGS) - 1;
+	if (flags) {
+		page_flags |= flags;
+		snprintf(cmp_buf + size, BUF_SIZE - size, "%s|", name);
+		size = strlen(cmp_buf);
+	}
+
+#ifdef SECTION_IN_PAGE_FLAGS
+	page_flags |= (sec & SECTIONS_MASK) << SECTIONS_PGSHIFT;
+	snprintf(cmp_buf + size, BUF_SIZE - size, "section=%#x|", sec);
+	size = strlen(cmp_buf);
+#endif
+
+	page_flags |= ((node & NODES_MASK) << NODES_PGSHIFT) |
+			((zone & ZONES_MASK) << ZONES_PGSHIFT);
+	snprintf(cmp_buf + size, BUF_SIZE - size, "node=%d|zone=%d", node, zone);
+	size = strlen(cmp_buf);
+
+#ifndef LAST_CPUPID_NOT_IN_PAGE_FLAGS
+	page_flags |= (last_cpupid & LAST_CPUPID_MASK) << LAST_CPUPID_PGSHIFT;
+	snprintf(cmp_buf + size, BUF_SIZE - size, "|lastcpupid=%#x", last_cpupid);
+	size = strlen(cmp_buf);
+#endif
+
+#if defined(CONFIG_KASAN_SW_TAGS) || defined(CONFIG_KASAN_HW_TAGS)
+	page_flags |= (tag & KASAN_TAG_MASK) << KASAN_TAG_PGSHIFT;
+	snprintf(cmp_buf + size, BUF_SIZE - size, "|kasantag=%#x", tag);
+	size = strlen(cmp_buf);
+#endif
+
+	test(cmp_buf, "%pGp", &page_flags);
+}
+
 static void __init
 flags(void)
 {
 	unsigned long flags;
-	gfp_t gfp;
 	char *cmp_buffer;
+	gfp_t gfp;
+
+	cmp_buffer = kmalloc(BUF_SIZE, GFP_KERNEL);
+	if (!cmp_buffer)
+		return;
 
 	flags = 0;
-	test("", "%pGp", &flags);
+	page_flags_test(0, 0, 0, 0, 0, flags, "", cmp_buffer);
 
-	/* Page flags should filter the zone id */
 	flags = 1UL << NR_PAGEFLAGS;
-	test("", "%pGp", &flags);
+	page_flags_test(0, 0, 0, 0, 0, flags, "", cmp_buffer);
 
 	flags |= 1UL << PG_uptodate | 1UL << PG_dirty | 1UL << PG_lru
 		| 1UL << PG_active | 1UL << PG_swapbacked;
-	test("uptodate|dirty|lru|active|swapbacked", "%pGp", &flags);
-
+	page_flags_test(1, 1, 1, 0x1fffff, 1, flags,
+			"uptodate|dirty|lru|active|swapbacked",
+			cmp_buffer);
 
 	flags = VM_READ | VM_EXEC | VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC
 			| VM_DENYWRITE;
@@ -601,10 +645,6 @@ flags(void)
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
index 3b53c73580c5..0dc776f7dfa4 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1916,6 +1916,66 @@ char *format_flags(char *buf, char *end, unsigned long flags,
 	return buf;
 }
 
+struct page_flags_fields {
+	int width;
+	int shift;
+	int mask;
+	const struct printf_spec *spec;
+	const char *name;
+};
+
+static const struct page_flags_fields pff[] = {
+	{SECTIONS_WIDTH, SECTIONS_PGSHIFT, SECTIONS_MASK,
+	 &default_dec_spec, "section"},
+	{NODES_WIDTH, NODES_PGSHIFT, NODES_MASK,
+	 &default_dec_spec, "node"},
+	{ZONES_WIDTH, ZONES_PGSHIFT, ZONES_MASK,
+	 &default_dec_spec, "zone"},
+	{LAST_CPUPID_WIDTH, LAST_CPUPID_PGSHIFT, LAST_CPUPID_MASK,
+	 &default_flag_spec, "lastcpupid"},
+	{KASAN_TAG_WIDTH, KASAN_TAG_PGSHIFT, KASAN_TAG_MASK,
+	 &default_flag_spec, "kasantag"},
+};
+
+static
+char *format_page_flags(char *buf, char *end, unsigned long flags)
+{
+	unsigned long main_flags = flags & (BIT(NR_PAGEFLAGS) - 1);
+	bool append = false;
+	int i;
+
+	/* Page flags from the main area. */
+	if (main_flags) {
+		buf = format_flags(buf, end, main_flags, pageflag_names);
+		append = true;
+	}
+
+	/* Page flags from the fields area */
+	for (i = 0; i < ARRAY_SIZE(pff); i++) {
+		/* Skip undefined fields. */
+		if (!pff[i].width)
+			continue;
+
+		/* Format: Flag Name + '=' (equals sign) + Number + '|' (separator) */
+		if (append) {
+			if (buf < end)
+				*buf = '|';
+			buf++;
+		}
+
+		buf = string(buf, end, pff[i].name, *pff[i].spec);
+		if (buf < end)
+			*buf = '=';
+		buf++;
+		buf = number(buf, end, (flags >> pff[i].shift) & pff[i].mask,
+			     *pff[i].spec);
+
+		append = true;
+	}
+
+	return buf;
+}
+
 static noinline_for_stack
 char *flags_string(char *buf, char *end, void *flags_ptr,
 		   struct printf_spec spec, const char *fmt)
@@ -1928,11 +1988,7 @@ char *flags_string(char *buf, char *end, void *flags_ptr,
 
 	switch (fmt[1]) {
 	case 'p':
-		flags = *(unsigned long *)flags_ptr;
-		/* Remove zone id */
-		flags &= (1UL << NR_PAGEFLAGS) - 1;
-		names = pageflag_names;
-		break;
+		return format_page_flags(buf, end, *(unsigned long *)flags_ptr);
 	case 'v':
 		flags = *(unsigned long *)flags_ptr;
 		names = vmaflag_names;
-- 
2.18.2

