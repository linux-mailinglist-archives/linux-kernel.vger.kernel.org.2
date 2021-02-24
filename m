Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF093242F3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 18:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232954AbhBXRLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 12:11:08 -0500
Received: from shelob.surriel.com ([96.67.55.147]:50078 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbhBXRLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 12:11:05 -0500
Received: from [2603:3005:d05:2b00:6e0b:84ff:fee2:98bb] (helo=imladris.surriel.com)
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <riel@shelob.surriel.com>)
        id 1lExg2-0000fq-F3; Wed, 24 Feb 2021 12:10:18 -0500
Date:   Wed, 24 Feb 2021 12:10:16 -0500
From:   Rik van Riel <riel@surriel.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        xuyu@linux.alibaba.com, mgorman@suse.de, aarcange@redhat.com,
        willy@infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, linux-mm@kvack.org, mhocko@suse.com
Subject: [PATCH 4/3] mm,shmem,thp: limit shmem THP allocations to requested
 zones
Message-ID: <20210224121016.1314ed6d@imladris.surriel.com>
In-Reply-To: <alpine.LSU.2.11.2102240854140.10197@eggly.anvils>
References: <20201124194925.623931-1-riel@surriel.com>
        <alpine.LSU.2.11.2012141226350.1925@eggly.anvils>
        <e3f67a5f-9835-2752-3d35-fb5f6d701cf1@suse.cz>
        <alpine.LSU.2.11.2102232329180.9202@eggly.anvils>
        <a7a85f81bd21254805bc91772530f237c9b73c04.camel@surriel.com>
        <alpine.LSU.2.11.2102240854140.10197@eggly.anvils>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: riel@shelob.surriel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Feb 2021 08:55:40 -0800 (PST)
Hugh Dickins <hughd@google.com> wrote:
> On Wed, 24 Feb 2021, Rik van Riel wrote:
> > On Wed, 2021-02-24 at 00:41 -0800, Hugh Dickins wrote:  
> > > Oh, I'd forgotten all about that gma500 aspect:
> > > well, I can send a fixup later on.  
> > 
> > I already have code to fix that, which somebody earlier
> > in this discussion convinced me to throw away. Want me
> > to send it as a patch 4/3 ?  
> 
> If Andrew wants it all, yes, please do add that - thanks Rik.

Trivial patch to fix the gma500 thing below:

---8<---

mm,shmem,thp: limit shmem THP allocations to requested zones

Hugh pointed out that the gma500 driver uses shmem pages, but needs
to limit them to the DMA32 zone. Ensure the allocations resulting from
the gfp_mask returned by limit_gfp_mask use the zone flags that were
originally passed to shmem_getpage_gfp.

Signed-off-by: Rik van Riel <riel@surriel.com>
Suggested-by: Hugh Dickins <hughd@google.com>
---
 mm/shmem.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index ee3cea10c2a4..876fec89686f 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1539,7 +1539,11 @@ static gfp_t limit_gfp_mask(gfp_t huge_gfp, gfp_t limit_gfp)
 {
 	gfp_t allowflags = __GFP_IO | __GFP_FS | __GFP_RECLAIM;
 	gfp_t denyflags = __GFP_NOWARN | __GFP_NORETRY;
-	gfp_t result = huge_gfp & ~allowflags;
+	gfp_t zoneflags = limit_gfp & GFP_ZONEMASK;
+	gfp_t result = huge_gfp & ~(allowflags | GFP_ZONEMASK);
+
+	/* Allow allocations only from the originally specified zones. */
+	result |= zoneflags;
 
 	/*
 	 * Minimize the result gfp by taking the union with the deny flags,

