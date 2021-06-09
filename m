Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3833A1304
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 13:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239410AbhFILnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 07:43:00 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:54752 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239175AbhFILlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 07:41:32 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E5990219EA;
        Wed,  9 Jun 2021 11:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623238776; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YBcrguTXnI9hsctZTgQ7OZG0uV6yh0oH29eLHd7YhOM=;
        b=S9aDCy8NqeSbElUMJ7WzqpduEvWVpEeZGxboXI4yXCxlIEu7fG1uKF0z9lJHnm7rpwddij
        n+bVZPPSvlT349WpwhqNFVtX8b//dGxw4IcvqKw8avsziFGZSHgZ6f2LHEqpK7YFhw79LZ
        Ybbq1xJcy2WHL07mz5xEhmKZbLmb+dc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623238776;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YBcrguTXnI9hsctZTgQ7OZG0uV6yh0oH29eLHd7YhOM=;
        b=rL6U8d/br+ltLXTLyZtABuUoy7FOyMm0b6uCrM6FmDpyc330LYQnO+vOXlpMJMsavg/6bQ
        1wJyokoIUQFb+EDQ==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id B64C611A98;
        Wed,  9 Jun 2021 11:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623238776; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YBcrguTXnI9hsctZTgQ7OZG0uV6yh0oH29eLHd7YhOM=;
        b=S9aDCy8NqeSbElUMJ7WzqpduEvWVpEeZGxboXI4yXCxlIEu7fG1uKF0z9lJHnm7rpwddij
        n+bVZPPSvlT349WpwhqNFVtX8b//dGxw4IcvqKw8avsziFGZSHgZ6f2LHEqpK7YFhw79LZ
        Ybbq1xJcy2WHL07mz5xEhmKZbLmb+dc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623238776;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YBcrguTXnI9hsctZTgQ7OZG0uV6yh0oH29eLHd7YhOM=;
        b=rL6U8d/br+ltLXTLyZtABuUoy7FOyMm0b6uCrM6FmDpyc330LYQnO+vOXlpMJMsavg/6bQ
        1wJyokoIUQFb+EDQ==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id MKT/K3iowGD6XgAALh3uQQ
        (envelope-from <vbabka@suse.cz>); Wed, 09 Jun 2021 11:39:36 +0000
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
Subject: [RFC v2 27/34] mm, slub: don't disable irqs in slub_cpu_dead()
Date:   Wed,  9 Jun 2021 13:38:56 +0200
Message-Id: <20210609113903.1421-28-vbabka@suse.cz>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210609113903.1421-1-vbabka@suse.cz>
References: <20210609113903.1421-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

slub_cpu_dead() cleans up for an offlined cpu from another cpu and calls only
functions that are now irq safe, so we don't need to disable irqs anymore.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 5a81189608e6..12d35d6a6eaa 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2498,14 +2498,10 @@ static void flush_all(struct kmem_cache *s)
 static int slub_cpu_dead(unsigned int cpu)
 {
 	struct kmem_cache *s;
-	unsigned long flags;
 
 	mutex_lock(&slab_mutex);
-	list_for_each_entry(s, &slab_caches, list) {
-		local_irq_save(flags);
+	list_for_each_entry(s, &slab_caches, list)
 		__flush_cpu_slab(s, cpu);
-		local_irq_restore(flags);
-	}
 	mutex_unlock(&slab_mutex);
 	return 0;
 }
-- 
2.31.1

