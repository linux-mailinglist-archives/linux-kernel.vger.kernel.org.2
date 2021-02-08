Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB30312EFF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 11:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232458AbhBHK3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 05:29:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbhBHKQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 05:16:04 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20875C06178B
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 02:15:24 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id d20so15011111oiw.10
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 02:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+XLXO2SWQmK2X0C7Wbz/yh9K6ApniIN/1/cELGqtW0Q=;
        b=Kdy9Sqn7DCDG1wqfJ081gBqy9T8jd5LM7NLDIuSz7ngUHNiA5Iie8JOLkCIZ3gpEE6
         RJr2mP9RkMRrqAUYu9X2+HFgiUTe5gXt5oovX+fqeJYRz+FxnY/xdQvbsad53ptWgVVT
         pcGwZ1lx1UyDssXPknhcpPbZxU9dPav/pqdlku1gQlYBGHLlFVk+kPBVHqbX7gopsdks
         sb6yqdxhC8r/sV6qj3bOprCNp7IvF4AqjaYZiFxwUHyia5IjnS8mvCx/RxG/cllUi8J0
         39qsy/Z9SDEJaG/2YRf09msRgP9PDYfY4BCkmAysZDWIfSDglpZ1Cxpe7/yne/6bQx3l
         Po3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+XLXO2SWQmK2X0C7Wbz/yh9K6ApniIN/1/cELGqtW0Q=;
        b=fLg75rSwQU+j6YcfLgdRmW3H3Vo5jwCgZdRXbrP8N6pSMU0yB0aAcOYoBqSnYmBOwU
         8XJaCgv9DclBuXzqB5qc1byRWYI3E5cWxsVZO+/osgapI2Afk9DttspS05MpdaJ3qqEr
         5VhhfOgIzg71V2ZidL3QgLH+UyxQlkKavR+GNKsU/vAdXi9RldYA3WgZFCDJIb4n+O6f
         kbj963MfRJ/6gKnfd4yG9vepJ+eMc6s9e5ITb5UJA2Q7O52KELycs94OBJgR8hKp8Evn
         a2YjZZ7PnsNXXZRoxHUYcPo9C4dOU+q9RFMPnu50LZCSgzvurYEkkrgghfiHCbUcy2SI
         GMhQ==
X-Gm-Message-State: AOAM533ktqlVbPZF1MhaZhr4ZnP/bNc/HZ2ZBpQKM7HZphJKFsjmid6B
        vQuWcRDrrZ8il2QssL8/EzI=
X-Google-Smtp-Source: ABdhPJwOm0jkdq4/RyBfteF+RUUKSmIJHOSKSFHjBYk3+hHt6YbAUL4kLGOc74QoxLjc7fSQI+T5lQ==
X-Received: by 2002:aca:1c08:: with SMTP id c8mr1131514oic.7.1612779323529;
        Mon, 08 Feb 2021 02:15:23 -0800 (PST)
Received: from localhost.localdomain ([50.236.19.102])
        by smtp.gmail.com with ESMTPSA id t3sm607226otb.36.2021.02.08.02.15.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Feb 2021 02:15:23 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     andriy.shevchenko@linux.intel.com, david@redhat.com,
        vbabka@suse.cz, willy@infradead.org, cl@linux.com,
        linmiaohe@huawei.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        pmladek@suse.com, rostedt@goodmis.org,
        sergey.senozhatsky@gmail.com, joe@perches.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v3 3/3] vsprintf: introduce new format to dump full information of page flags
Date:   Mon,  8 Feb 2021 18:14:39 +0800
Message-Id: <20210208101439.55474-4-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20210208101439.55474-1-laoar.shao@gmail.com>
References: <20210208101439.55474-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The existed pGp shows the names of page flags only, rather than the full
information including section, node, zone, last cpuipid and kasan tag.
While it is not easy to parse these information manually because there
are so many flavors. We'd better interpret them in printf.

To avoid breaking some tools which parsing pGp via debugfs or affecting
the printf buffer, other new formats are introduced, so the user can choose
what and in which order they want, suggested by Andy. These new introduced
format as follows,
    pGpb: print other information first and then the names of page flags
    pGpl: print the names of page flags first and then the other info

The differece between them looks like the difference between big-endian and
little-endian, that's why they are named like that. The examples of the
output as follows,
    %pGpb 0x17ffffc0010200(node=0|zone=2|lastcpupid=0x1fffff|slab|head)
    %pGpl 0x17ffffc0010200(slab|head|node=0|zone=2|lastcpupid=0x1fffff)

To be compitable with the existed format of pGp, the new introduced ones
also use '|' as the separator, then the user tools parsing pGp won't
need to make change, suggested by Matthew.

The doc and test cases are also updated. Below is the output of the
test cases,
[ 4299.847655] test_printf: loaded.
[ 4299.848301] test_printf: all 404 tests passed
[ 4299.850371] test_printf: unloaded.

Cc: David Hildenbrand <david@redhat.com>
Cc: Joe Perches <joe@perches.com>
Cc: Miaohe Lin <linmiaohe@huawei.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 Documentation/core-api/printk-formats.rst |   2 +
 lib/test_printf.c                         | 126 +++++++++++++++++++---
 lib/vsprintf.c                            | 115 +++++++++++++++++++-
 3 files changed, 226 insertions(+), 17 deletions(-)

diff --git a/Documentation/core-api/printk-formats.rst b/Documentation/core-api/printk-formats.rst
index 6d26c5c6ac48..56f8e0fc3963 100644
--- a/Documentation/core-api/printk-formats.rst
+++ b/Documentation/core-api/printk-formats.rst
@@ -539,6 +539,8 @@ Flags bitfields such as page flags, gfp_flags
 ::
 
 	%pGp	referenced|uptodate|lru|active|private
+	%pGpb	node=0|zone=2|referenced|uptodate|lru|active|private
+	%pGpl	referenced|uptodate|lru|active|private|node=0|zone=2
 	%pGg	GFP_USER|GFP_DMA32|GFP_NOWARN
 	%pGv	read|exec|mayread|maywrite|mayexec|denywrite
 
diff --git a/lib/test_printf.c b/lib/test_printf.c
index 7ac87f18a10f..af2945bb730a 100644
--- a/lib/test_printf.c
+++ b/lib/test_printf.c
@@ -569,24 +569,130 @@ netdev_features(void)
 {
 }
 
+static void  __init
+page_flags_build_info(char *cmp_buf, int prefix, int sec, int node, int zone,
+		      int last_cpupid, int kasan_tag, unsigned long *flags)
+{
+	unsigned long size = prefix;
+
+#ifdef SECTION_IN_PAGE_FLAGS
+	*flags |= (sec & SECTIONS_MASK) << SECTIONS_PGSHIFT;
+	snprintf(cmp_buf + size, BUF_SIZE - size, "section=%#x|", sec);
+	size = strlen(cmp_buf);
+#endif
+
+	*flags |= ((node & NODES_MASK) << NODES_PGSHIFT) |
+		  ((zone & ZONES_MASK) << ZONES_PGSHIFT);
+	snprintf(cmp_buf + size, BUF_SIZE - size, "node=%d|zone=%d", node, zone);
+	size = strlen(cmp_buf);
+
+#ifndef LAST_CPUPID_NOT_IN_PAGE_FLAGS
+	*flags |= (last_cpupid & LAST_CPUPID_MASK) << LAST_CPUPID_PGSHIFT;
+	snprintf(cmp_buf + size, BUF_SIZE - size, "|lastcpupid=%#x", last_cpupid);
+	size = strlen(cmp_buf);
+#endif
+
+#if defined(CONFIG_KASAN_SW_TAGS) || defined(CONFIG_KASAN_HW_TAGS)
+	*flags |= (tag & KASAN_TAG_MASK) << KASAN_TAG_PGSHIFT;
+	snprintf(cmp_buf + size, BUF_SIZE - size, "|kasantag=%#x", tag);
+	size = strlen(cmp_buf);
+#endif
+}
+
 static void __init
-flags(void)
+page_flags_build_names(char *cmp_buf, int prefix, const char *expect,
+		       unsigned long flags, unsigned long *page_flags)
 {
+	*page_flags |= flags;
+	snprintf(cmp_buf + prefix, BUF_SIZE - prefix, "%s", expect);
+}
+
+static void __init
+__page_flags_test(const char *expect, unsigned long flags)
+{
+	test(expect, "%pGp", &flags);
+}
+
+static void __init
+page_flags_test_be(char *cmp_buf, int sec, int node, int zone,
+		   int last_cpupid, int kasan_tag, const char *name,
+		   unsigned long flags)
+{
+	unsigned long page_flags = 0;
+	int size;
+
+	page_flags_build_info(cmp_buf, 0, sec, node, zone, last_cpupid,
+			      kasan_tag, &page_flags);
+
+	if (*name) {
+		size = strlen(cmp_buf);
+		if (size < BUF_SIZE - 2) {
+			*(cmp_buf + size) = '|';
+			*(cmp_buf + size + 1) = '\0';
+		}
+		page_flags_build_names(cmp_buf, strlen(cmp_buf), name, flags, &page_flags);
+	}
+
+	test(cmp_buf, "%pGpb", &page_flags);
+}
+
+static void __init
+page_flags_test_le(char *cmp_buf, int sec, int node, int zone,
+		   int last_cpupid, int kasan_tag, const char *name,
+		   unsigned long flags)
+{
+	unsigned long page_flags = 0;
+	int size = 0;
+
+	if (*name) {
+		page_flags_build_names(cmp_buf, 0, name, flags, &page_flags);
+		size = strlen(cmp_buf);
+		if (size < BUF_SIZE - 2) {
+			*(cmp_buf + size) = '|';
+			*(cmp_buf + size + 1) = '\0';
+		}
+		size = strlen(cmp_buf);
+	}
+
+	page_flags_build_info(cmp_buf, size, sec, node, zone, last_cpupid,
+			      kasan_tag, &page_flags);
+
+	test(cmp_buf, "%pGpl", &page_flags);
+}
+
+static void __init
+page_flags_test(char *cmp_buf)
+{
+	char *name = "uptodate|dirty|lru|active|swapbacked";
 	unsigned long flags;
-	gfp_t gfp;
-	char *cmp_buffer;
 
 	flags = 0;
-	test("", "%pGp", &flags);
+	__page_flags_test("", flags);
+	page_flags_test_be(cmp_buf, 0, 0, 0, 0, 0, "", flags);
+	page_flags_test_le(cmp_buf, 0, 0, 0, 0, 0, "", flags);
 
-	/* Page flags should filter the zone id */
 	flags = 1UL << NR_PAGEFLAGS;
-	test("", "%pGp", &flags);
+	__page_flags_test("", flags);
 
 	flags |= 1UL << PG_uptodate | 1UL << PG_dirty | 1UL << PG_lru
-		| 1UL << PG_active | 1UL << PG_swapbacked;
-	test("uptodate|dirty|lru|active|swapbacked", "%pGp", &flags);
+		 | 1UL << PG_active | 1UL << PG_swapbacked;
+	__page_flags_test(name, flags);
+	page_flags_test_be(cmp_buf, 1, 1, 1, 0x1fffff, 1, name, flags);
+	page_flags_test_le(cmp_buf, 1, 1, 1, 0x1fffff, 1, name, flags);
+}
+
+static void __init
+flags(void)
+{
+	unsigned long flags;
+	gfp_t gfp;
+	char *cmp_buffer;
 
+	cmp_buffer = kmalloc(BUF_SIZE, GFP_KERNEL);
+	if (!cmp_buffer)
+		return;
+
+	page_flags_test(cmp_buffer);
 
 	flags = VM_READ | VM_EXEC | VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC
 			| VM_DENYWRITE;
@@ -601,10 +707,6 @@ flags(void)
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
index 14c9a6af1b23..c912cc9bddb0 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1916,6 +1916,115 @@ char *format_flags(char *buf, char *end, unsigned long flags,
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
+char *__format_page_flags(char *buf, char *end, unsigned long flags)
+{
+	DECLARE_BITMAP(mask, ARRAY_SIZE(pfl));
+	unsigned long last;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(pfl); i++)
+		__assign_bit(i, mask, pfl[i].width);
+
+	last = find_last_bit(mask, ARRAY_SIZE(pfl));
+
+	for_each_set_bit(i, mask, ARRAY_SIZE(pfl)) {
+		/* Format: Flag Name + '=' (equals sign) + Number + '|' (separator) */
+		buf = string(buf, end, pfl[i].name, *pfl[i].spec);
+
+		if (buf < end)
+			*buf = '=';
+		buf++;
+		buf = number(buf, end, (flags >> pfl[i].shift) & pfl[i].mask,
+			     *pfl[i].spec);
+
+		/* No separator for the last entry */
+		if (i != last) {
+			if (buf < end)
+				*buf = '|';
+			buf++;
+		}
+	}
+
+	return buf;
+}
+
+static
+char *format_page_flags_be(char *buf, char *end, unsigned long flags)
+{
+	unsigned long mask = BIT(NR_PAGEFLAGS) - 1;
+
+	buf = __format_page_flags(buf, end, flags);
+
+	if (flags & mask) {
+		if (buf < end)
+			*buf = '|';
+		buf++;
+	}
+
+	return format_flags(buf, end, flags & mask, pageflag_names);
+}
+
+static
+char *format_page_flags_le(char *buf, char *end, unsigned long flags)
+{
+	unsigned long mask = BIT(NR_PAGEFLAGS) - 1;
+
+	buf = format_flags(buf, end, flags & mask, pageflag_names);
+
+	if (flags & mask) {
+		if (buf < end)
+			*buf = '|';
+		buf++;
+	}
+
+	return __format_page_flags(buf, end, flags & ~mask);
+}
+
+static
+char *format_page_flags(char *buf, char *end, void *flags_ptr,
+			struct printf_spec spec, const char *fmt)
+{
+	unsigned long flags = *(unsigned long *)flags_ptr;
+	unsigned long mask = BIT(NR_PAGEFLAGS) - 1;
+
+	if (strlen(fmt) == 2) {
+		flags &= mask;
+		return format_flags(buf, end, flags, pageflag_names);
+	}
+
+	switch (fmt[2]) {
+	case 'b':
+		return format_page_flags_be(buf, end, flags);
+	case 'l':
+		return format_page_flags_le(buf, end, flags);
+	default:
+		flags &= mask;
+		return format_flags(buf, end, flags, pageflag_names);
+	}
+}
+
 static noinline_for_stack
 char *flags_string(char *buf, char *end, void *flags_ptr,
 		   struct printf_spec spec, const char *fmt)
@@ -1928,11 +2037,7 @@ char *flags_string(char *buf, char *end, void *flags_ptr,
 
 	switch (fmt[1]) {
 	case 'p':
-		flags = *(unsigned long *)flags_ptr;
-		/* Remove zone id */
-		flags &= (1UL << NR_PAGEFLAGS) - 1;
-		names = pageflag_names;
-		break;
+		return format_page_flags(buf, end, flags_ptr, spec, fmt);
 	case 'v':
 		flags = *(unsigned long *)flags_ptr;
 		names = vmaflag_names;
-- 
2.17.1

