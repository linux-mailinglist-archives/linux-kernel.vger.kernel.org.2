Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0FF3565A5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 09:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244529AbhDGHnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 03:43:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:42738 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233952AbhDGHnG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 03:43:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 409ACB005;
        Wed,  7 Apr 2021 07:42:56 +0000 (UTC)
Date:   Wed, 7 Apr 2021 09:42:53 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/8] mm,memory_hotplug: Relax fully spanned sections
 check
Message-ID: <20210407074249.GA9353@linux>
References: <df9bdb5157d6ad2f4a922d396ddf0c07@suse.de>
 <59A04B1D-08D6-4E71-A382-F5503A6E0AF7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59A04B1D-08D6-4E71-A382-F5503A6E0AF7@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 06, 2021 at 10:43:01PM +0200, David Hildenbrand wrote:
> But not end_pfn as given in my version or what am I missing?

Nah, was my fault, I managed to see:

 if (WARN_ON_ONCE(!nr_pages ||
         !IS_ALIGNED(start_pfn, pageblock_nr_pages))
         !IS_ALIGNED(start_pfn | nr_pages, PAGES_PER_SECTION)))

which would not work.

I agree that keeping the PAGES_PER_SECTION check maks this safer, so this all
should have been:

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 0cdbbfbc5757..25e59d5dc13c 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -838,9 +838,14 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
        int ret;
        struct memory_notify arg;
 
-       /* We can only online full sections (e.g., SECTION_IS_ONLINE) */
+       /* We can only offline full sections (e.g., SECTION_IS_ONLINE).
+        * However, when using e.g: memmap_on_memory, some pages are initialized
+        * prior to calling in here. The remaining amount of pages must be
+        * pageblock aligned.
+        */
        if (WARN_ON_ONCE(!nr_pages ||
-                        !IS_ALIGNED(pfn | nr_pages, PAGES_PER_SECTION)))
+                        !IS_ALIGNED(pfn, pageblock_nr_pages) ||
+                        !IS_ALIGNED(pfn + nr_pages, PAGES_PER_SECTION)))
                return -EINVAL;
 
        mem_hotplug_begin();
@@ -1573,9 +1578,14 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
        int ret, node;
        char *reason;
 
-       /* We can only offline full sections (e.g., SECTION_IS_ONLINE) */
+       /* We can only offline full sections (e.g., SECTION_IS_ONLINE).
+        * However, when using e.g: memmap_on_memory, some pages are initialized
+        * prior to calling in here. The remaining amount of pages must be
+        * pageblock aligned.
+        */
        if (WARN_ON_ONCE(!nr_pages ||
-                        !IS_ALIGNED(start_pfn | nr_pages, PAGES_PER_SECTION)))
+                        !IS_ALIGNED(start_pfn, pageblock_nr_pages) ||
+                        !IS_ALIGNED(start_pfn + nr_pages, PAGES_PER_SECTION)))
                return -EINVAL;
 
        mem_hotplug_begin();

 

-- 
Oscar Salvador
SUSE L3
