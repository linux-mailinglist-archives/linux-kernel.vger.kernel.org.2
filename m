Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0DC2314DCA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 12:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232087AbhBILDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 06:03:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232020AbhBIK5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 05:57:36 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA476C0617AA
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 02:56:55 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id d7so14793396otq.6
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 02:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Tiu8l4y3al7LgwJKu3HpcATrkXUFgjknz33lq4pbxoA=;
        b=k++LRIBNM+LnlzQ3RhLOrOu9XfFeNd+paAUv57y7zWFDPHbBlIzD5V8nPvjq1w4Jq5
         C+o6kshlFu9Qq/YiIJ2zxstUAd0XkLMRkjFPvd0IgZXasO4I4wFBEXlKE1Cim5ZEv3LG
         1KZWNPnNlC5gYBA2A6e/UrzrF5eqObtqE6npzPyhwQ9pody7TkzcjI81UKclZJNIh17X
         so5s/SHiLgMiFafhbYYgftBH6MA6MAsn6UTZA4iSpwjWEHvtqVCZbv5rEPNR5nvZb/gh
         5WtmJm+uvXfrxkRPanxBi5mVGMqTdxzm0+K33UVuMdOCGNPxQzh/SCRQW9GGUVD9ps0f
         6C5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Tiu8l4y3al7LgwJKu3HpcATrkXUFgjknz33lq4pbxoA=;
        b=ZieN+dJ1pw1n8+ehQs3m9mHyb/GmA7aoGpVKSY0SZX26tqBfOncJDhb0cfvYEgLCTL
         p1BvnY/TZEJ+xM+lsyKM16sdqPwkQelETnvx9ylbb/sHHwD3CGdrLjj4Vhs9UfOZ5v4G
         ZbkcJcbtJWr8VOma6k6H6IK3Nsr4GIOHHb+O0l2UeyUfPRFSEjFDpnRujsbWWzv3Hyiv
         BHFzz0VafV7vGGeJYRmvSIb1LPblfIiS75soGa2MuNQaq43kOD6Ee09Dz0qvhwgEq5/N
         plIpCy0DsaHlgzJW3F0XTUHR4G4duCe8FHNeiTuRK1W+nuHotKWfDNP4WJM0WpUDye50
         HO9A==
X-Gm-Message-State: AOAM530TXfkAr1nsr5mb/v1T9KwFtpKBZmUr7M9WHesONEcXs7rMmCzZ
        WgvI4F+8QGKzBLnT9E+EElA=
X-Google-Smtp-Source: ABdhPJxktUXu4h77GSmd7pREko2nmczvFLgyZ8KCmheT4HTHlhsiJtr+jCmI/PRcGNPlbYxRmmdNgw==
X-Received: by 2002:a9d:6f03:: with SMTP id n3mr14202565otq.295.1612868215229;
        Tue, 09 Feb 2021 02:56:55 -0800 (PST)
Received: from localhost.localdomain ([50.236.19.102])
        by smtp.gmail.com with ESMTPSA id g3sm4171377ooi.28.2021.02.09.02.56.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Feb 2021 02:56:54 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     willy@infradead.org, andriy.shevchenko@linux.intel.com,
        david@redhat.com, linmiaohe@huawei.com, vbabka@suse.cz,
        cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        pmladek@suse.com, rostedt@goodmis.org,
        sergey.senozhatsky@gmail.com, joe@perches.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v4 3/3] vsprintf: dump full information of page flags in pGp
Date:   Tue,  9 Feb 2021 18:56:13 +0800
Message-Id: <20210209105613.42747-4-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20210209105613.42747-1-laoar.shao@gmail.com>
References: <20210209105613.42747-1-laoar.shao@gmail.com>
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
[ 8838.835456] Slab 0x000000002828b78a objects=33 used=3 fp=0x00000000d04efc88 flags=0x17ffffc0010200(slab|head|node=0|zone=2|lastcpupid=0x1fffff)

The documentation and test cases are also updated. The output of the
test cases as follows,
[  501.485081] test_printf: loaded.
[  501.485768] test_printf: all 388 tests passed
[  501.488762] test_printf: unloaded.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Joe Perches <joe@perches.com>
Cc: Miaohe Lin <linmiaohe@huawei.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Matthew Wilcox <willy@infradead.org>
---
 Documentation/core-api/printk-formats.rst |  2 +-
 lib/test_printf.c                         | 60 +++++++++++++++++----
 lib/vsprintf.c                            | 66 +++++++++++++++++++++--
 3 files changed, 114 insertions(+), 14 deletions(-)

diff --git a/Documentation/core-api/printk-formats.rst b/Documentation/core-api/printk-formats.rst
index 6d26c5c6ac48..93c3e48ff30d 100644
--- a/Documentation/core-api/printk-formats.rst
+++ b/Documentation/core-api/printk-formats.rst
@@ -538,7 +538,7 @@ Flags bitfields such as page flags, gfp_flags
 
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
index 14c9a6af1b23..3f26611adb34 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1916,6 +1916,66 @@ char *format_flags(char *buf, char *end, unsigned long flags,
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
+char *format_page_flags(char *buf, char *end, unsigned long flags)
+{
+	DECLARE_BITMAP(mask, ARRAY_SIZE(pfl));
+	unsigned long last;
+	int i;
+
+	if (flags & (BIT(NR_PAGEFLAGS) - 1)) {
+		if (buf < end)
+			*buf = '|';
+		buf++;
+	}
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
 static noinline_for_stack
 char *flags_string(char *buf, char *end, void *flags_ptr,
 		   struct printf_spec spec, const char *fmt)
@@ -1929,10 +1989,10 @@ char *flags_string(char *buf, char *end, void *flags_ptr,
 	switch (fmt[1]) {
 	case 'p':
 		flags = *(unsigned long *)flags_ptr;
-		/* Remove zone id */
-		flags &= (1UL << NR_PAGEFLAGS) - 1;
 		names = pageflag_names;
-		break;
+		buf = format_flags(buf, end, flags & (BIT(NR_PAGEFLAGS) - 1), names);
+		buf = format_page_flags(buf, end, flags);
+		return buf;
 	case 'v':
 		flags = *(unsigned long *)flags_ptr;
 		names = vmaflag_names;
-- 
2.17.1

