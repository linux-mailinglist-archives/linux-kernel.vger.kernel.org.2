Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29004334382
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 17:48:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232432AbhCJQrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 11:47:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:44082 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232814AbhCJQq6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 11:46:58 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1615394817; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i7wCGWxIthCQtOrByjEJdXvIpxweKiduj/go7ZuFSCk=;
        b=sMuiD8zX+a7FveE1kCeh/PtxVM9BdM0To4gwSsJJ+V8/5RER6H9gxNrZAmV533TG1AuPFB
        t3qCs9ydJHrGtI6OQVCpk3TyUS1Hvs0qkmcFEcuWMZ6cENsXNChXAkHraUdxbOcFqYuSXo
        x597JNDL1ScfChSBR6mUuLqp2H2N5uc=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9B806ABD7;
        Wed, 10 Mar 2021 16:46:57 +0000 (UTC)
Date:   Wed, 10 Mar 2021 17:46:56 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Dias <joaodias@google.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Baron <jbaron@akamai.com>
Subject: Re: [PATCH v2] mm: page_alloc: dump migrate-failed pages
Message-ID: <YEj4AGuBn/Q4CIuY@dhcp22.suse.cz>
References: <20210308202047.1903802-1-minchan@kernel.org>
 <YEdAw6gnp9XxoWUQ@dhcp22.suse.cz>
 <YEefLYiX6rF3Uk4E@google.com>
 <YEh4doXvyuRl5BDB@google.com>
 <YEjEefQpBHV5eBXj@dhcp22.suse.cz>
 <YEjuUHBDKu2uX4EO@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YEjuUHBDKu2uX4EO@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 10-03-21 08:05:36, Minchan Kim wrote:
> On Wed, Mar 10, 2021 at 02:07:05PM +0100, Michal Hocko wrote:
[...]
> > The is a lot of churn indeed. Have you considered adding $FOO_lglvl
> > variants for those so that you can use them for your particular case
> > without affecting most of existing users? Something similar we have
> > discussed in other email thread regarding lru_add_drain_all?
> 
> I thought that way but didn't try since it couldn't make them
> atomic(For example, other printk place in other context will
> affect by the $FOO_lglvl).

I do not follow. I meant something like the following (likely incomplete
but you should get an idea).

diff --git a/include/linux/page_owner.h b/include/linux/page_owner.h
index 3468794f83d2..71b402eb8f78 100644
--- a/include/linux/page_owner.h
+++ b/include/linux/page_owner.h
@@ -14,7 +14,7 @@ extern void __set_page_owner(struct page *page,
 extern void __split_page_owner(struct page *page, unsigned int nr);
 extern void __copy_page_owner(struct page *oldpage, struct page *newpage);
 extern void __set_page_owner_migrate_reason(struct page *page, int reason);
-extern void __dump_page_owner(struct page *page);
+extern void __dump_page_owner(struct page *page, const char *loglvl);
 extern void pagetypeinfo_showmixedcount_print(struct seq_file *m,
 					pg_data_t *pgdat, struct zone *zone);
 
@@ -46,10 +46,10 @@ static inline void set_page_owner_migrate_reason(struct page *page, int reason)
 	if (static_branch_unlikely(&page_owner_inited))
 		__set_page_owner_migrate_reason(page, reason);
 }
-static inline void dump_page_owner(struct page *page)
+static inline void dump_page_owner(struct page *page, const char *loglvl)
 {
 	if (static_branch_unlikely(&page_owner_inited))
-		__dump_page_owner(page);
+		__dump_page_owner(page, loglvl);
 }
 #else
 static inline void reset_page_owner(struct page *page, unsigned int order)
@@ -69,7 +69,7 @@ static inline void copy_page_owner(struct page *oldpage, struct page *newpage)
 static inline void set_page_owner_migrate_reason(struct page *page, int reason)
 {
 }
-static inline void dump_page_owner(struct page *page)
+static inline void dump_page_owner(struct page *page, const char *loglvl)
 {
 }
 #endif /* CONFIG_PAGE_OWNER */
diff --git a/kernel/stacktrace.c b/kernel/stacktrace.c
index 9f8117c7cfdd..1b13135d9916 100644
--- a/kernel/stacktrace.c
+++ b/kernel/stacktrace.c
@@ -14,6 +14,18 @@
 #include <linux/kallsyms.h>
 #include <linux/stacktrace.h>
 
+void __stack_trace_print(const unsigned long *entries, unsigned int nr_entries,
+		       int spacesconst, char *loglvl)
+{
+	unsigned int i;
+
+	if (WARN_ON(!entries))
+		return;
+
+	for (i = 0; i < nr_entries; i++)
+		printk("%s%*c%pS\n", loglvl, 1 + spaces, ' ', (void *)entries[i]);
+}
+
 /**
  * stack_trace_print - Print the entries in the stack trace
  * @entries:	Pointer to storage array
@@ -23,13 +35,7 @@
 void stack_trace_print(const unsigned long *entries, unsigned int nr_entries,
 		       int spaces)
 {
-	unsigned int i;
-
-	if (WARN_ON(!entries))
-		return;
-
-	for (i = 0; i < nr_entries; i++)
-		printk("%*c%pS\n", 1 + spaces, ' ', (void *)entries[i]);
+	__stack_trace_print(entries, nr_entries, spaces, KERN_DEFAULT);
 }
 EXPORT_SYMBOL_GPL(stack_trace_print);
 
diff --git a/mm/debug.c b/mm/debug.c
index 8a40b3fefbeb..b989ee2ffa89 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -42,7 +42,7 @@ const struct trace_print_flags vmaflag_names[] = {
 	{0, NULL}
 };
 
-void __dump_page(struct page *page, const char *reason)
+void __dump_page(struct page *page, const char *reason, const char *loglvl)
 {
 	struct page *head = compound_head(page);
 	struct address_space *mapping;
@@ -64,7 +64,7 @@ void __dump_page(struct page *page, const char *reason)
 	 * dump_page() when detected.
 	 */
 	if (page_poisoned) {
-		pr_warn("page:%px is uninitialized and poisoned", page);
+		printk("%spage:%px is uninitialized and poisoned", loglvl, page);
 		goto hex_only;
 	}
 
@@ -95,17 +95,17 @@ void __dump_page(struct page *page, const char *reason)
 	 */
 	mapcount = PageSlab(head) ? 0 : page_mapcount(page);
 
-	pr_warn("page:%p refcount:%d mapcount:%d mapping:%p index:%#lx pfn:%#lx\n",
+	printk("%spage:%p refcount:%d mapcount:%d mapping:%p index:%#lx pfn:%#lx\n", loglvl,
 			page, page_ref_count(head), mapcount, mapping,
 			page_to_pgoff(page), page_to_pfn(page));
 	if (compound) {
 		if (hpage_pincount_available(page)) {
-			pr_warn("head:%p order:%u compound_mapcount:%d compound_pincount:%d\n",
+			printk("%shead:%p order:%u compound_mapcount:%d compound_pincount:%d\n", loglvl,
 					head, compound_order(head),
 					head_compound_mapcount(head),
 					head_compound_pincount(head));
 		} else {
-			pr_warn("head:%p order:%u compound_mapcount:%d\n",
+			printk("%shead:%p order:%u compound_mapcount:%d\n", loglvl,
 					head, compound_order(head),
 					head_compound_mapcount(head));
 		}
@@ -128,30 +128,31 @@ void __dump_page(struct page *page, const char *reason)
 		 */
 		if (get_kernel_nofault(host, &mapping->host) ||
 		    get_kernel_nofault(a_ops, &mapping->a_ops)) {
-			pr_warn("failed to read mapping contents, not a valid kernel address?\n");
+			prrintk("%sfailed to read mapping contents, not a valid kernel address?\n",
+					loglvl);
 			goto out_mapping;
 		}
 
 		if (!host) {
-			pr_warn("aops:%ps\n", a_ops);
+			printk("%saops:%ps\n", loglvl, a_ops);
 			goto out_mapping;
 		}
 
 		if (get_kernel_nofault(dentry_first, &host->i_dentry.first) ||
 		    get_kernel_nofault(ino, &host->i_ino)) {
-			pr_warn("aops:%ps with invalid host inode %px\n",
+			printk("%saops:%ps with invalid host inode %px\n", loglvl,
 					a_ops, host);
 			goto out_mapping;
 		}
 
 		if (!dentry_first) {
-			pr_warn("aops:%ps ino:%lx\n", a_ops, ino);
+			printk("%saops:%ps ino:%lx\n", loglvl, a_ops, ino);
 			goto out_mapping;
 		}
 
 		dentry_ptr = container_of(dentry_first, struct dentry, d_u.d_alias);
 		if (get_kernel_nofault(dentry, dentry_ptr)) {
-			pr_warn("aops:%ps ino:%lx with invalid dentry %px\n",
+			printk("%saops:%ps ino:%lx with invalid dentry %px\n", loglvl,
 					a_ops, ino, dentry_ptr);
 		} else {
 			/*
@@ -159,38 +160,38 @@ void __dump_page(struct page *page, const char *reason)
 			 * crash, but it's unlikely that we reach here with a
 			 * corrupted struct page
 			 */
-			pr_warn("aops:%ps ino:%lx dentry name:\"%pd\"\n",
+			printk("%saops:%ps ino:%lx dentry name:\"%pd\"\n", loglvl,
 					a_ops, ino, &dentry);
 		}
 	}
 out_mapping:
 	BUILD_BUG_ON(ARRAY_SIZE(pageflag_names) != __NR_PAGEFLAGS + 1);
 
-	pr_warn("%sflags: %#lx(%pGp)%s\n", type, head->flags, &head->flags,
+	printk("%s%sflags: %#lx(%pGp)%s\n", loglvl, type, head->flags, &head->flags,
 		page_cma ? " CMA" : "");
 
 hex_only:
-	print_hex_dump(KERN_WARNING, "raw: ", DUMP_PREFIX_NONE, 32,
+	print_hex_dump(loglvl, "%sraw: ", DUMP_PREFIX_NONE, 32,
 			sizeof(unsigned long), page,
 			sizeof(struct page), false);
 	if (head != page)
-		print_hex_dump(KERN_WARNING, "head: ", DUMP_PREFIX_NONE, 32,
+		print_hex_dump(loglvl, "head: ", DUMP_PREFIX_NONE, 32,
 			sizeof(unsigned long), head,
 			sizeof(struct page), false);
 
 	if (reason)
-		pr_warn("page dumped because: %s\n", reason);
+		printk("%spage dumped because: %s\n", loglvl, reason);
 
 #ifdef CONFIG_MEMCG
 	if (!page_poisoned && page->memcg_data)
-		pr_warn("pages's memcg:%lx\n", page->memcg_data);
+		printk("%spages's memcg:%lx\n", loglvl, page->memcg_data);
 #endif
 }
 
 void dump_page(struct page *page, const char *reason)
 {
-	__dump_page(page, reason);
-	dump_page_owner(page);
+	__dump_page(page, reason, KERN_WARNING);
+	dump_page_owner(page, KERN_ALERT);
 }
 EXPORT_SYMBOL(dump_page);
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 519a60d5b6f7..20b500f76667 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -637,7 +637,7 @@ static void bad_page(struct page *page, const char *reason)
 	pr_alert("BUG: Bad page state in process %s  pfn:%05lx\n",
 		current->comm, page_to_pfn(page));
 	__dump_page(page, reason);
-	dump_page_owner(page);
+	dump_page_owner(page, KERN_ALERT);
 
 	print_modules();
 	dump_stack();
diff --git a/mm/page_owner.c b/mm/page_owner.c
index af464bb7fbe7..ff5908605925 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -406,7 +406,7 @@ print_page_owner(char __user *buf, size_t count, unsigned long pfn,
 	return -ENOMEM;
 }
 
-void __dump_page_owner(struct page *page)
+void __dump_page_owner(struct page *page, const char *loglvl)
 {
 	struct page_ext *page_ext = lookup_page_ext(page);
 	struct page_owner *page_owner;
@@ -417,7 +417,7 @@ void __dump_page_owner(struct page *page)
 	int mt;
 
 	if (unlikely(!page_ext)) {
-		pr_alert("There is not page extension available.\n");
+		printk("There is not page extension available.\n", loglvl);
 		return;
 	}
 
@@ -426,38 +426,38 @@ void __dump_page_owner(struct page *page)
 	mt = gfp_migratetype(gfp_mask);
 
 	if (!test_bit(PAGE_EXT_OWNER, &page_ext->flags)) {
-		pr_alert("page_owner info is not present (never set?)\n");
+		printk("%spage_owner info is not present (never set?)\n", loglvl);
 		return;
 	}
 
 	if (test_bit(PAGE_EXT_OWNER_ALLOCATED, &page_ext->flags))
-		pr_alert("page_owner tracks the page as allocated\n");
+		printk("%spage_owner tracks the page as allocated\n", loglvl);
 	else
-		pr_alert("page_owner tracks the page as freed\n");
+		printk("page_owner tracks the page as freed\n", loglvl);
 
-	pr_alert("page last allocated via order %u, migratetype %s, gfp_mask %#x(%pGg), pid %d, ts %llu\n",
+	printk("%spage last allocated via order %u, migratetype %s, gfp_mask %#x(%pGg), pid %d, ts %llu\n", loglvl,
 		 page_owner->order, migratetype_names[mt], gfp_mask, &gfp_mask,
 		 page_owner->pid, page_owner->ts_nsec);
 
 	handle = READ_ONCE(page_owner->handle);
 	if (!handle) {
-		pr_alert("page_owner allocation stack trace missing\n");
+		printk("%spage_owner allocation stack trace missing\n", loglvl);
 	} else {
 		nr_entries = stack_depot_fetch(handle, &entries);
-		stack_trace_print(entries, nr_entries, 0);
+		__stack_trace_print(entries, nr_entries, 0, loglvl);
 	}
 
 	handle = READ_ONCE(page_owner->free_handle);
 	if (!handle) {
-		pr_alert("page_owner free stack trace missing\n");
+		printk("%spage_owner free stack trace missing\n", loglvl);
 	} else {
 		nr_entries = stack_depot_fetch(handle, &entries);
-		pr_alert("page last free stack trace:\n");
-		stack_trace_print(entries, nr_entries, 0);
+		printk("page last free stack trace:\n", loglvl);
+		__stack_trace_print(entries, nr_entries, 0, loglvl);
 	}
 
 	if (page_owner->last_migrate_reason != -1)
-		pr_alert("page has been migrated, last migrate reason: %s\n",
+		printk("%spage has been migrated, last migrate reason: %s\n", loglvl,
 			migrate_reason_names[page_owner->last_migrate_reason]);
 }
 
-- 
Michal Hocko
SUSE Labs
