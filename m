Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8343349669
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 17:07:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbhCYQHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 12:07:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:55010 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229993AbhCYQHF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 12:07:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1616688424; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7ofJ/SzRjNvBQCBUiomtR9gZ1AM18bk0f0SRyUhB5O0=;
        b=J1nkte6qbWXyQdsFzjlnnxqk6EmfvOa9lLcEYfxvqiNLe3GJ/PJO7Vi+fsl8qF5e+VXRfN
        1Cd3xBI244n3QpZ1Ccc6d35dLsfwb+lrYDCPYrmagrfz9plh+tsRKj480Ih0zy0Z0v2BDi
        PZV40Ptlvnjt1u3uxqu1rBM+Ru99ULY=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CD600AA55;
        Thu, 25 Mar 2021 16:07:04 +0000 (UTC)
Date:   Thu, 25 Mar 2021 17:07:03 +0100
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
Message-ID: <YFy1J+mCyGmnwuHJ@dhcp22.suse.cz>
References: <db0c9218-bdc3-9cc6-42da-ec36786b7b60@redhat.com>
 <YFyDhKPqS15HdO0Y@dhcp22.suse.cz>
 <31110e58-c99a-8dee-6f6e-98f456b77759@redhat.com>
 <YFyZV6QSffsHkP2d@dhcp22.suse.cz>
 <062bc5d7-a83c-1c1a-7b77-9f043643f4fa@redhat.com>
 <YFyfdDAoWON6IoPL@dhcp22.suse.cz>
 <31c3e6f7-f631-7b00-2c33-518b0f24a75f@redhat.com>
 <YFyoU/rkEPK3VPlN@dhcp22.suse.cz>
 <40fac999-2d28-9205-23f0-516fa9342bbe@redhat.com>
 <YFyt3UfoPkt7BbDZ@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFyt3UfoPkt7BbDZ@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 25-03-21 16:35:58, Michal Hocko wrote:
[...]
> So there is indeed a difference. One way around that would be to mark
> vmemmap pages (e.g. PageReserved && magic value stored somewhere in the
> struct page - resembling bootmem vmemmaps) or mark section fully backing
> vmemmaps as online (ugly).

I am not yet ready to give up on this. Here is a quick stab at the
pfn_to_online_page approach. It is not great but it is not really
terrible either. I think we can do better and skip
find_memory_block_by_id in most cases because nr_vmemmap_pages should be
constant with our current implementation.

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 754026a9164d..0d2bc22c29d3 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -304,8 +304,20 @@ struct page *pfn_to_online_page(unsigned long pfn)
 		return NULL;
 
 	ms = __nr_to_section(nr);
-	if (!online_section(ms))
+	if (!online_section(ms)) {
+		if (memmap_on_memory) {
+			struct memory_block *mem;
+			unsigned long section_pfn = section_nr_to_pfn(nr);
+
+			mem = find_memory_block_by_id(memory_block_id(nr));
+			if (!mem || !mem->nr_vmemmap_pages || pfn - section_pfn > mem->nr_vmemmap_pages)
+				return NULL;
+
+			return pfn_to_page(pfn);
+
+		}
 		return NULL;
+	}
 
 	/*
 	 * Save some code text when online_section() +
-- 
Michal Hocko
SUSE Labs
