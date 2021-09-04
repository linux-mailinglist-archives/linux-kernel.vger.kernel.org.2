Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE005400AFD
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 13:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351381AbhIDKxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 06:53:17 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:41820 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351122AbhIDKvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 06:51:15 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6C49120049;
        Sat,  4 Sep 2021 10:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1630752613; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WETh2l+H2XGr/b8umJrqMOqpxk43rv6xOLKvPHqZkHM=;
        b=KDB61j03G+46/rETq1r+jP+Mq/o3BQpmXW4CE7aiGc6HBLNbmhlshWiPm00IVb+7GEa2jf
        jrI9KTB2GQHvsTLbwZ0Nu0jdI4Tj06CcxhuZCtPw33a5F2Soc+flFQJ7C8+IJbkfNFxGoN
        cB1w3HoFoD+jOxye3PDpFZN8mFxDOtQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1630752613;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WETh2l+H2XGr/b8umJrqMOqpxk43rv6xOLKvPHqZkHM=;
        b=rd90RmJq1SjpjesM8KlUJsq8VLgoF6lAzOvc5ccLVgHSHAiYg/zaf9KLbmwWIxAH+LAf9E
        wOUeudzkWXYLGlDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 444CD13A2C;
        Sat,  4 Sep 2021 10:50:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sKP2D2VPM2HoUQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Sat, 04 Sep 2021 10:50:13 +0000
From:   Vlastimil Babka <vbabka@suse.cz>
To:     linux-mm@kvack.org, Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Mike Galbraith <efault@gmx.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v6 23/33] mm, slub: detach whole partial list at once in unfreeze_partials()
Date:   Sat,  4 Sep 2021 12:49:53 +0200
Message-Id: <20210904105003.11688-24-vbabka@suse.cz>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210904105003.11688-1-vbabka@suse.cz>
References: <20210904105003.11688-1-vbabka@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1079; h=from:subject; bh=9dO5Fy52OYg6aamf/fFyTsnxFPvKT5TUAOHnYRrwruI=; b=owEBbQGS/pANAwAIAeAhynPxiakQAcsmYgBhM09AhPTgFAr0mSp22Wz5xIepTmks6ErJbKhGBjkQ p6jEhIOJATMEAAEIAB0WIQSNS5MBqTXjGL5IXszgIcpz8YmpEAUCYTNPQAAKCRDgIcpz8YmpEKfRCA Cpi+KWCiIdcwC8RjnMcE5n6Ixidb1SFLhOW1s7Ys3mPU09kGC0bbFminQkaAE8Qt4MpB60bn/QMNiL bW/vU9AllEztwhHYcJL6jpuVacqwTm1lF+QZN6bbCx+YvfhBJWp0lzPUvkQbI01sQtyb0lVqiwnxc0 l+GRc6pJrUNZpsoYwgFLgbBq0bJ8Lty/rNU3FqzZ7Ne7TnXhXzCMua1j7D+x36LzKJm3t7pF6XqVra R9KUoebAtACLoJYQxBTvkPc95js46555o+7hcM0OFEwdC665rR4auVRbd3WLY+6r5UJjVNtneP4NFc jIIDp/IwtwQg7vdgu5c9o92Rwyf9IX
X-Developer-Key: i=vbabka@suse.cz; a=openpgp; fpr=A940D434992C2E8E99103D50224FA7E7CC82A664
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of iterating through the live percpu partial list, detach it from the
kmem_cache_cpu at once. This is simpler and will allow further optimization.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 0a1e048d0db7..b31e00eb9561 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2358,16 +2358,20 @@ static void unfreeze_partials(struct kmem_cache *s,
 {
 #ifdef CONFIG_SLUB_CPU_PARTIAL
 	struct kmem_cache_node *n = NULL, *n2 = NULL;
-	struct page *page, *discard_page = NULL;
+	struct page *page, *partial_page, *discard_page = NULL;
 	unsigned long flags;
 
 	local_irq_save(flags);
 
-	while ((page = slub_percpu_partial(c))) {
+	partial_page = slub_percpu_partial(c);
+	c->partial = NULL;
+
+	while (partial_page) {
 		struct page new;
 		struct page old;
 
-		slub_set_percpu_partial(c, page);
+		page = partial_page;
+		partial_page = page->next;
 
 		n2 = get_node(s, page_to_nid(page));
 		if (n != n2) {
-- 
2.33.0

