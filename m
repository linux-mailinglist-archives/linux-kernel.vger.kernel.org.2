Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64F17398E60
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 17:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232435AbhFBPU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 11:20:56 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:32782 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232241AbhFBPUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 11:20:15 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0342333681;
        Wed,  2 Jun 2021 15:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1622647111; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         in-reply-to:in-reply-to:references:references;
        bh=ATheSSLLZ2P8MhU+2J3xNMWL+VSgOZk/hQ1TADrnaks=;
        b=RktuDgHxXX9qk0TdyvY443prykckoRzOTLV5fpx5qHhAslfQ66GoKH+CLP3lPtwvAw4Bn0
        mZkkJCv87vll6SAugeRnHgmKJlw2BE3pbsjUb0jBfXIjK4isU5LU7MmH/pLrLaNPTm0v5P
        LMUe0qOZGVOGbOUDLUPOwrrANyw1ABU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1622647111;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         in-reply-to:in-reply-to:references:references;
        bh=ATheSSLLZ2P8MhU+2J3xNMWL+VSgOZk/hQ1TADrnaks=;
        b=7EjBXnruDEMEdOxQjQm/Tn5Tis49KJPSFGiDKw14qVt2BiQP15LxUkjvOuom2jClxLmeN1
        iYoRysZxnMjcCCAg==
Received: by imap.suse.de (Postfix, from userid 51)
        id F17D511CD7; Wed,  2 Jun 2021 15:28:32 +0000 (UTC)
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 041A211D1D;
        Wed,  2 Jun 2021 09:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1622625309; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         in-reply-to:in-reply-to:references:references;
        bh=ATheSSLLZ2P8MhU+2J3xNMWL+VSgOZk/hQ1TADrnaks=;
        b=1CSir7kFrq/6l+vnYYjUHflh/ejKn7fulZUuf1vptmstMV3mHI+zop4H0al1+twDnGlbjX
        NK+5ZvzvN636e6axM/APtEWnvu64ymGnvPNBSQdveo0dnI+kAdTCMD19KlU0+43KeVKtQV
        V5DQf6ZZ0qL+1TipgvhTMrKU1tZs9ug=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1622625309;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         in-reply-to:in-reply-to:references:references;
        bh=ATheSSLLZ2P8MhU+2J3xNMWL+VSgOZk/hQ1TADrnaks=;
        b=7Kx1H8sSjrn2Y7RvWTpNtp4BoNOK9aJkDUQlb47cE031M9Y2elxYflmUMHc51rtyiKlpQV
        gADk3P5e5YVyNICw==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id UCDUOBxMt2A6HgAALh3uQQ
        (envelope-from <osalvador@suse.de>); Wed, 02 Jun 2021 09:15:08 +0000
From:   Oscar Salvador <osalvador@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v2 1/3] mm,page_alloc: Use {get,put}_online_mems() to get stable zone's values
Date:   Wed,  2 Jun 2021 11:14:55 +0200
Message-Id: <20210602091457.17772-2-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20210602091457.17772-1-osalvador@suse.de>
References: <20210602091457.17772-1-osalvador@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, page_outside_zone_boundaries() takes zone's span_seqlock
when reading zone_start_pfn and spanned_pages so those values are
stable vs memory hotplug operations.
move_pfn_range_to_zone() and remove_pfn_range_from_zone(), which are
the functions that can change zone's values are serialized by
mem_hotplug_lock by mem_hotplug_{begin,done}, so we can just use
{get,put}_online_mems() on the readers.

This will allow us to completely kill span_seqlock lock as no users
will remain after this series.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 mm/page_alloc.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index aaa1655cf682..296cb00802b4 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -582,17 +582,15 @@ void set_pageblock_migratetype(struct page *page, int migratetype)
 static int page_outside_zone_boundaries(struct zone *zone, struct page *page)
 {
 	int ret = 0;
-	unsigned seq;
 	unsigned long pfn = page_to_pfn(page);
 	unsigned long sp, start_pfn;
 
-	do {
-		seq = zone_span_seqbegin(zone);
-		start_pfn = zone->zone_start_pfn;
-		sp = zone->spanned_pages;
-		if (!zone_spans_pfn(zone, pfn))
-			ret = 1;
-	} while (zone_span_seqretry(zone, seq));
+	get_online_mems();
+	start_pfn = zone->zone_start_pfn;
+	sp = zone->spanned_pages;
+	if (!zone_spans_pfn(zone, pfn))
+		ret = 1;
+	put_online_mems();
 
 	if (ret)
 		pr_err("page 0x%lx outside node %d zone %s [ 0x%lx - 0x%lx ]\n",
-- 
2.16.3

