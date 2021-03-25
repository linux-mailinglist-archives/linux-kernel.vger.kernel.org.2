Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7038349745
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 17:48:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbhCYQsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 12:48:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:47302 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229833AbhCYQri (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 12:47:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1616690857; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wUJU1ZyQiULOm2uGJekEhkNryIBe6sBb+u3KEnxtjyw=;
        b=ixR9H4iP2iyMq+Ghj46uhoTg/mK9jfek7tT7cuk/lK9zT/cE5RnNCHVi3EVfKiHw6ShxZG
        /9HAKYeF56YpVnE/MF+0ZhH1ulfaWsuR4VXIT8oaS9CzZMWhfulU4d39gakKEWL5i6DSle
        LklhJ9PmjCZJ9lajmaRFRY1VdOjb+kY=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DAE63AA55;
        Thu, 25 Mar 2021 16:47:36 +0000 (UTC)
Date:   Thu, 25 Mar 2021 17:47:30 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/5] mm,memory_hotplug: Allocate memmap from the added
 memory range
Message-ID: <YFy+olsdS4iwrovN@dhcp22.suse.cz>
References: <YFyZV6QSffsHkP2d@dhcp22.suse.cz>
 <062bc5d7-a83c-1c1a-7b77-9f043643f4fa@redhat.com>
 <YFyfdDAoWON6IoPL@dhcp22.suse.cz>
 <31c3e6f7-f631-7b00-2c33-518b0f24a75f@redhat.com>
 <YFyoU/rkEPK3VPlN@dhcp22.suse.cz>
 <40fac999-2d28-9205-23f0-516fa9342bbe@redhat.com>
 <YFyt3UfoPkt7BbDZ@dhcp22.suse.cz>
 <YFy1J+mCyGmnwuHJ@dhcp22.suse.cz>
 <92fe19d0-56ac-e929-a9c1-d6a4e0da39d1@redhat.com>
 <YFy8ARml4R7/snVs@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFy8ARml4R7/snVs@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 25-03-21 17:36:22, Michal Hocko wrote:
> If all it takes is to make pfn_to_online_page work (and my
> previous attempt is incorrect because it should consult block rather
> than section pfn range)

This should work.

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index 9697acfe96eb..e50d685be8ab 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -510,6 +510,23 @@ static struct memory_block *find_memory_block_by_id(unsigned long block_id)
 	return mem;
 }
 
+struct page *is_vmemmap_page(unsigned long pfn)
+{
+	unsigned long nr = pfn_to_section_nr(pfn);
+	struct memory_block *mem;
+	unsigned long block_pfn;
+
+	mem = find_memory_block_by_id(memory_block_id(nr));
+	if (!mem || !mem->nr_vmemmap_pages)
+		return NULL;
+
+	block_pfn = section_nr_to_pfn(mem->start_section_nr);
+	if (pfn - block_pfn > mem->nr_vmemmap_pages)
+		return NULL;
+
+	return pfn_to_page(pfn);
+}
+
 /*
  * Called under device_hotplug_lock.
  */
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 754026a9164d..760bf3ad48d5 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -304,8 +304,16 @@ struct page *pfn_to_online_page(unsigned long pfn)
 		return NULL;
 
 	ms = __nr_to_section(nr);
-	if (!online_section(ms))
+	if (!online_section(ms)) {
+		/*
+		 * vmemmap reserved space can eat up a whole section which then
+		 * never gets onlined because it doesn't contain any memory to
+		 * online.
+		 */
+		if (memmap_on_memory)
+			return is_vmemmap_page(pfn);
 		return NULL;
+	}
 
 	/*
 	 * Save some code text when online_section() +
-- 
Michal Hocko
SUSE Labs
