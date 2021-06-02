Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A733B398E5C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 17:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232305AbhFBPUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 11:20:38 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:60666 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232236AbhFBPUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 11:20:14 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A107022DF8;
        Wed,  2 Jun 2021 15:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1622647110; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         in-reply-to:in-reply-to:references:references;
        bh=9PGunXTcA2aMR3u/oDIIHMBR3qsGadtV3/P/9ZHHFPE=;
        b=VQ4uTVg54lQHpiSy7YTWRl8o4+oGVDHVxSzjplkZ9cm5M1wL56pQsZiNzbCTTPK0U4aEwT
        /bne6SyV9I13mZXGtZTDcAn9QdmA9/p9+7miqhGk534PWAI8QX3aU6jUl0aqCUQE/oKFZA
        LovF6h33gC30gNvS6xLIbZNWRoL+LgA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1622647110;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         in-reply-to:in-reply-to:references:references;
        bh=9PGunXTcA2aMR3u/oDIIHMBR3qsGadtV3/P/9ZHHFPE=;
        b=cGUBQ9X9qjs9y97+yeVL6GixfgImpFj+j0XZ9mF8LncVt4a3VJyondrYkHTIvpINAPRg12
        eLCetlPLEavntvCw==
Received: by imap.suse.de (Postfix, from userid 51)
        id 9A9B311CD8; Wed,  2 Jun 2021 15:28:32 +0000 (UTC)
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id A773111D1F;
        Wed,  2 Jun 2021 09:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1622625311; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         in-reply-to:in-reply-to:references:references;
        bh=9PGunXTcA2aMR3u/oDIIHMBR3qsGadtV3/P/9ZHHFPE=;
        b=gHo9waZztSQ4cdcNNm9TAYFEpbYwYEQJ/7uzFxKphCHfESuuL6qYD7bcHPaO3UdL/AkNCV
        l0tYCFQH5YRyN9jPwZGQLQDin+DPhZbYZKs+EgsXP7iLDcIrP7N5eX/dyplYv358pEFa/o
        /N97fpsQO4wszZUd4bStcuckVKhxANc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1622625311;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         in-reply-to:in-reply-to:references:references;
        bh=9PGunXTcA2aMR3u/oDIIHMBR3qsGadtV3/P/9ZHHFPE=;
        b=fP+vbG45AtHaXcrp9A2R0Ref8J+lkHsP1LOMBDKfw3RvFs/NOu6BBAt868Jbw6meiEg6E/
        3KxbwIs0D14L5EBQ==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id GBqUJR5Mt2A6HgAALh3uQQ
        (envelope-from <osalvador@suse.de>); Wed, 02 Jun 2021 09:15:10 +0000
From:   Oscar Salvador <osalvador@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v2 3/3] mm,memory_hotplug: Remove unneeded declarations
Date:   Wed,  2 Jun 2021 11:14:57 +0200
Message-Id: <20210602091457.17772-4-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20210602091457.17772-1-osalvador@suse.de>
References: <20210602091457.17772-1-osalvador@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

include/linux/memory_hotplug.h has the following declarations:

extern int zone_grow_free_lists(struct zone *zone, unsigned long new_nr_pages);
extern int zone_grow_waitqueues(struct zone *zone, unsigned long nr_pages);
extern int add_one_highpage(struct page *page, int pfn, int bad_ppro);

These declarations were added by the following commit:

commit 3947be1969a9ce455ec30f60ef51efb10e4323d1
Author: Dave Hansen <haveblue@us.ibm.com>
Date:   Sat Oct 29 18:16:54 2005 -0700

    [PATCH] memory hotplug: sysfs and add/remove functions

It seems that zone_grow_free_lists() and zone_grow_waitqueues() were
never used, and add_one_highpage() was always declared as static in
arch/i386/mm/init.c and later on in arch/x86/mm/init_32.c, and was
later removed in:

commit 5e7ccf8635c93b493f7d378a57ce300fbe1484e8
Author: Jiang Liu <liuj97@gmail.com>
Date:   Mon Apr 29 15:07:12 2013 -0700

    mm/x86: use free_highmem_page() to free highmem pages into buddy system

So remove these declarations.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 include/linux/memory_hotplug.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index 0d837ce6ec11..9a19e97d4f1a 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -80,9 +80,6 @@ struct range mhp_get_pluggable_range(bool need_mapping);
 /*
  * Zone resizing functions
  */
-extern int zone_grow_free_lists(struct zone *zone, unsigned long new_nr_pages);
-extern int zone_grow_waitqueues(struct zone *zone, unsigned long nr_pages);
-extern int add_one_highpage(struct page *page, int pfn, int bad_ppro);
 extern void adjust_present_page_count(struct zone *zone, long nr_pages);
 /* VM interface that may be used by firmware interface */
 extern int mhp_init_memmap_on_memory(unsigned long pfn, unsigned long nr_pages,
-- 
2.16.3

