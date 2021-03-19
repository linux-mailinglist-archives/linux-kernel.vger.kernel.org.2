Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F01B83419AB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 11:14:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbhCSKNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 06:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbhCSKNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 06:13:37 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D38CC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 03:13:37 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id e8so5467441iok.5
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 03:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hBeSsP8mZ8gtO7uRdztyECljz7VFqGYfmpNVgM2tF6Q=;
        b=aPnqrbwFLg+o2r2ACZUSshvAYxe1GtV+Tk8xmraV0hfFjOdpiOFAZfE50uz3zVgmoM
         utY++kUwNYbATkpoN3T+Sx6pYCbDuulx54jk+cUWHmFzuaSQTMT9UGKgx9TedpghVMiG
         eG3pR3MkQQtOBUvzM1HuVSTMSgu2rUib5wkECpL+MP+NeGuelZrT/CIaTbUnslC0HEU/
         yzA7WWBmRcEm+fqSdU1MhLg5IMDDbibFOrwP089FVVoa77POOd/QI44WRUTcYdmVJUmD
         AJE9K2Ca1fT+4+RwnYCc1Yt3HESGWPpjyopcUWZuKNZYdF7YobduCAG7Z2vgqoMyE2my
         TgIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hBeSsP8mZ8gtO7uRdztyECljz7VFqGYfmpNVgM2tF6Q=;
        b=fNLyKpwxQF5BBwPLnRr4mRqWrxjwq0vmA5T8oJ/cSvDRnbAMu4etYcpK/aDKZzLtA7
         0r2UUqyHon7pZkGsUUdOGJgXTiSW39VYf3h8arHS8MBqjAabE+U4HgA1zOGu0FnSh85a
         DPy6u+DPLb8uaKDZ2V0bY5rUups7Z6F2VcqLLlBcKy3ZRXObJWTPsJR7wk3iRSRObXbi
         3XnsaE+7Rzf0whJlRlMarkbnlBKiEvTrNN1YjQd/zfoVIokJXXQwrcs78X46NfqQlPUO
         s3AuJeoMfu2hJFgr6CDgf8SALP3ggARwNWm9kaRUIMjZUKzjqBBSdP2enA5RLrS7tEoM
         mXuA==
X-Gm-Message-State: AOAM531JdtgSAWoA2s2j9Nmk+qpHp1XS6POcLhy2f7ppeomVrVEikYIb
        LKD5lFoa1ovb+2wd8iPgOMg=
X-Google-Smtp-Source: ABdhPJyFDxQJBksIOfvC1JJrWXt6a65FWiPHfkcMXpWxGWl1hAQDvEejiTK6WXZ44kGkPDo/YJtJ/g==
X-Received: by 2002:a5e:c117:: with SMTP id v23mr2191556iol.54.1616148816383;
        Fri, 19 Mar 2021 03:13:36 -0700 (PDT)
Received: from localhost.localdomain ([50.236.19.102])
        by smtp.gmail.com with ESMTPSA id v19sm2372827ilj.60.2021.03.19.03.13.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Mar 2021 03:13:36 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     pmladek@suse.com, willy@infradead.org,
        andriy.shevchenko@linux.intel.com, david@redhat.com,
        linmiaohe@huawei.com, vbabka@suse.cz, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, rostedt@goodmis.org,
        sergey.senozhatsky@gmail.com, joe@perches.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, lkp@intel.com,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v6 resend 3/3] vsprintf: dump full information of page flags in pGp
Date:   Fri, 19 Mar 2021 18:12:46 +0800
Message-Id: <20210319101246.73513-4-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20210319101246.73513-1-laoar.shao@gmail.com>
References: <20210319101246.73513-1-laoar.shao@gmail.com>
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

On example of the output in mm/slub.c as follows,
- Before the patch,
[ 6343.396602] Slab 0x000000004382e02b objects=33 used=3 fp=0x000000009ae06ffc flags=0x17ffffc0010200(slab|head)

- After the patch,
[ 8448.272530] Slab 0x0000000090797883 objects=33 used=3 fp=0x00000000790f1c26 flags=0x17ffffc0010200(slab|head|node=0|zone=2|lastcpupid=0x1fffff)

The documentation and test cases are also updated. The output of the
test cases as follows,
[68599.816764] test_printf: loaded.
[68599.819068] test_printf: all 388 tests passed
[68599.830367] test_printf: unloaded.

[lkp@intel.com: reported issues in the prev version in test_printf.c]

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Joe Perches <joe@perches.com>
Cc: Miaohe Lin <linmiaohe@huawei.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Petr Mladek <pmladek@suse.com>
Cc: kernel test robot <lkp@intel.com>
---
 Documentation/core-api/printk-formats.rst |  2 +-
 lib/test_printf.c                         | 90 ++++++++++++++++++++---
 lib/vsprintf.c                            | 66 +++++++++++++++--
 3 files changed, 142 insertions(+), 16 deletions(-)

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
index 95a2f82427c7..27b964ec723d 100644
--- a/lib/test_printf.c
+++ b/lib/test_printf.c
@@ -577,24 +577,98 @@ netdev_features(void)
 {
 }
 
+struct page_flags_test {
+	int width;
+	int shift;
+	int mask;
+	unsigned long value;
+	const char *fmt;
+	const char *name;
+};
+
+static struct page_flags_test pft[] = {
+	{SECTIONS_WIDTH, SECTIONS_PGSHIFT, SECTIONS_MASK,
+	 0, "%d", "section"},
+	{NODES_WIDTH, NODES_PGSHIFT, NODES_MASK,
+	 0, "%d", "node"},
+	{ZONES_WIDTH, ZONES_PGSHIFT, ZONES_MASK,
+	 0, "%d", "zone"},
+	{LAST_CPUPID_WIDTH, LAST_CPUPID_PGSHIFT, LAST_CPUPID_MASK,
+	 0, "%#x", "lastcpupid"},
+	{KASAN_TAG_WIDTH, KASAN_TAG_PGSHIFT, KASAN_TAG_MASK,
+	 0, "%#x", "kasantag"},
+};
+
+static void __init
+page_flags_test(int section, int node, int zone, int last_cpupid,
+		int kasan_tag, int flags, const char *name, char *cmp_buf)
+{
+	unsigned long values[] = {section, node, zone, last_cpupid, kasan_tag};
+	unsigned long page_flags = 0;
+	unsigned long size = 0;
+	bool append = false;
+	int i;
+
+	flags &= BIT(NR_PAGEFLAGS) - 1;
+	if (flags) {
+		page_flags |= flags;
+		snprintf(cmp_buf + size, BUF_SIZE - size, "%s", name);
+		size = strlen(cmp_buf);
+#if SECTIONS_WIDTH || NODES_WIDTH || ZONES_WIDTH || \
+	LAST_CPUPID_WIDTH || KASAN_TAG_WIDTH
+		/* Other information also included in page flags */
+		snprintf(cmp_buf + size, BUF_SIZE - size, "|");
+		size = strlen(cmp_buf);
+#endif
+	}
+
+	/* Set the test value */
+	for (i = 0; i < ARRAY_SIZE(pft); i++)
+		pft[i].value = values[i];
+
+	for (i = 0; i < ARRAY_SIZE(pft); i++) {
+		if (!pft[i].width)
+			continue;
+
+		if (append) {
+			snprintf(cmp_buf + size, BUF_SIZE - size, "|");
+			size = strlen(cmp_buf);
+		}
+
+		page_flags |= (pft[i].value & pft[i].mask) << pft[i].shift;
+		snprintf(cmp_buf + size, BUF_SIZE - size, "%s=", pft[i].name);
+		size = strlen(cmp_buf);
+		snprintf(cmp_buf + size, BUF_SIZE - size, pft[i].fmt,
+			 pft[i].value & pft[i].mask);
+		size = strlen(cmp_buf);
+		append = true;
+	}
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
@@ -609,10 +683,6 @@ flags(void)
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
index 41ddc353ebb8..92e6085eef15 100644
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
+		buf = string(buf, end, pff[i].name, default_str_spec);
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

