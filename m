Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9346E3A1301
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 13:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239154AbhFILms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 07:42:48 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:54744 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239168AbhFILlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 07:41:31 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1AF66219E7;
        Wed,  9 Jun 2021 11:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623238776; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CLObwQuENcRgoukMvNxRJzoRvFwUKPTdwZDaHjVrHHA=;
        b=YlGl6sq2LuhXUI56gbtKfae6pZ4AY5ckS09vFiOApOYSgzTheLO36HgdqBhxrpyvLXrv6H
        xouoMVF2jZrrd2Qj+k4B9VDu3nuRfGAPRnJE+XSP1Wozu8FXIR5jMNUUmTKpLqUlSt+jgv
        Z/yDLxcN+rOcHGR4MgtzhMN/GThiauA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623238776;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CLObwQuENcRgoukMvNxRJzoRvFwUKPTdwZDaHjVrHHA=;
        b=Tf1wjSQaqv/yJ3IoWAa7MJQE8Qp0aY6MDq08lGLOT3kASNsCN2/NXpw1KdzDwsUIYOjxTa
        N68AarkIwtKZCbAw==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id E01C611A98;
        Wed,  9 Jun 2021 11:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623238776; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CLObwQuENcRgoukMvNxRJzoRvFwUKPTdwZDaHjVrHHA=;
        b=YlGl6sq2LuhXUI56gbtKfae6pZ4AY5ckS09vFiOApOYSgzTheLO36HgdqBhxrpyvLXrv6H
        xouoMVF2jZrrd2Qj+k4B9VDu3nuRfGAPRnJE+XSP1Wozu8FXIR5jMNUUmTKpLqUlSt+jgv
        Z/yDLxcN+rOcHGR4MgtzhMN/GThiauA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623238776;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CLObwQuENcRgoukMvNxRJzoRvFwUKPTdwZDaHjVrHHA=;
        b=Tf1wjSQaqv/yJ3IoWAa7MJQE8Qp0aY6MDq08lGLOT3kASNsCN2/NXpw1KdzDwsUIYOjxTa
        N68AarkIwtKZCbAw==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id uFI8NneowGD6XgAALh3uQQ
        (envelope-from <vbabka@suse.cz>); Wed, 09 Jun 2021 11:39:35 +0000
From:   Vlastimil Babka <vbabka@suse.cz>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jann Horn <jannh@google.com>, Vlastimil Babka <vbabka@suse.cz>
Subject: [RFC v2 23/34] mm, slub: discard slabs in unfreeze_partials() without irqs disabled
Date:   Wed,  9 Jun 2021 13:38:52 +0200
Message-Id: <20210609113903.1421-24-vbabka@suse.cz>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210609113903.1421-1-vbabka@suse.cz>
References: <20210609113903.1421-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need for disabled irqs when discarding slabs, so restore them before
discarding.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/slub.c b/mm/slub.c
index 4a3cd8174cd2..dcbc5baea702 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2346,6 +2346,8 @@ static void unfreeze_partials(struct kmem_cache *s,
 	if (n)
 		spin_unlock(&n->list_lock);
 
+	local_irq_restore(flags);
+
 	while (discard_page) {
 		page = discard_page;
 		discard_page = discard_page->next;
@@ -2355,7 +2357,6 @@ static void unfreeze_partials(struct kmem_cache *s,
 		stat(s, FREE_SLAB);
 	}
 
-	local_irq_restore(flags);
 #endif	/* CONFIG_SLUB_CPU_PARTIAL */
 }
 
-- 
2.31.1

