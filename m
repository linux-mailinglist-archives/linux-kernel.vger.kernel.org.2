Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F297400AF4
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 13:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351364AbhIDKww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 06:52:52 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59794 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351149AbhIDKvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 06:51:16 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 21060226A2;
        Sat,  4 Sep 2021 10:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1630752614; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iSpQG1+PfwLKiMgJfknaJqeXj7cXw4vf/kl9y706Bhg=;
        b=kBFNjaGembaer+vkNpQ/n87tA3rdoNkMNLE1J/0B6bIw66J3h0r0/Onr+QqiMKbcm/X1dH
        rO+bTpVNuM8ogAVyyJbnZTLfk4QPfh5iLYR/Opz6ujvH+udhAlkaD8CrgtfHJSxDTJ1ZT5
        bmcZzZGSzSF8FNFFisx+LEUM9vLk8vs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1630752614;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iSpQG1+PfwLKiMgJfknaJqeXj7cXw4vf/kl9y706Bhg=;
        b=kCW/C6ClzXP0qrkeELjN6iiL66wL7lhmykDM9yB4ZvwdcA1yIhZw9CYqLkngG7HyPz2/QE
        LUVHmGDCWQAnRADg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EA7F913A2C;
        Sat,  4 Sep 2021 10:50:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0AEoOGVPM2HoUQAAMHmgww
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
Subject: [PATCH v6 27/33] mm, slab: split out the cpu offline variant of flush_slab()
Date:   Sat,  4 Sep 2021 12:49:57 +0200
Message-Id: <20210904105003.11688-28-vbabka@suse.cz>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210904105003.11688-1-vbabka@suse.cz>
References: <20210904105003.11688-1-vbabka@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1480; h=from:subject; bh=Me93t/ujdmp4NIcicG7SIS7AaN3bj9p7Xn+WAdX4uvg=; b=owEBbQGS/pANAwAIAeAhynPxiakQAcsmYgBhM09KUSTBRuzrR5kT1PPvCxtCuMM0lzUc2IGoF+87 gDGdpiOJATMEAAEIAB0WIQSNS5MBqTXjGL5IXszgIcpz8YmpEAUCYTNPSgAKCRDgIcpz8YmpEERJCA CYMPna+TQkf7B2RM7MZCyWwsuRm/ZDyUTUAQ3tECgppZ38qu0PbOfjaT4h0ANkIzTFNL3umsHelShB UlDEBmqSkN7X/b2UKKPjFg5gVeqMpxqBV1tC42TGfK2KEKcMy/tC610mSG0GsEw42Z/zwqJwet/3fC 6NEUHqdQ77phe1YpuXnqmHhFHRlmSuabHgX1JQvB9XdTOtIyw64bENDVG0qZuMNTrX31nuKFg25why 3/X1Wm/gl9V1EqNoHDqYns9TFGvTXVVKefwIGC3vXSoJOW6iYSJpAQ7TqppNai+qGkQd4SvRhIenaY zBFf20EjtZpd0bsbZPyTM9dhgWeI/T
X-Developer-Key: i=vbabka@suse.cz; a=openpgp; fpr=A940D434992C2E8E99103D50224FA7E7CC82A664
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

flush_slab() is called either as part IPI handler on given live cpu, or as a
cleanup on behalf of another cpu that went offline. The first case needs to
protect updating the kmem_cache_cpu fields with disabled irqs. Currently the
whole call happens with irqs disabled by the IPI handler, but the following
patch will change from IPI to workqueue, and flush_slab() will have to disable
irqs (to be replaced with a local lock later) in the critical part.

To prepare for this change, replace the call to flush_slab() for the dead cpu
handling with an opencoded variant that will not disable irqs nor take a local
lock.

Suggested-by: Mike Galbraith <efault@gmx.de>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index c4a9b8901576..fa9a366d2d9c 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2511,9 +2511,17 @@ static inline void flush_slab(struct kmem_cache *s, struct kmem_cache_cpu *c)
 static inline void __flush_cpu_slab(struct kmem_cache *s, int cpu)
 {
 	struct kmem_cache_cpu *c = per_cpu_ptr(s->cpu_slab, cpu);
+	void *freelist = c->freelist;
+	struct page *page = c->page;
 
-	if (c->page)
-		flush_slab(s, c);
+	c->page = NULL;
+	c->freelist = NULL;
+	c->tid = next_tid(c->tid);
+
+	if (page) {
+		deactivate_slab(s, page, freelist);
+		stat(s, CPUSLAB_FLUSH);
+	}
 
 	unfreeze_partials_cpu(s, c);
 }
-- 
2.33.0

