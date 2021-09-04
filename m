Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0D0E400AF6
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 13:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351372AbhIDKwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 06:52:55 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59752 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351143AbhIDKvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 06:51:16 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E7DDF226A0;
        Sat,  4 Sep 2021 10:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1630752613; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p1eRZMhxY07/cPHYxD57xDLVN35T7tHbH+Nv73UiRlg=;
        b=kh0s1C3NLo2xaYWqNEJRExoRSdJSYnDPq5OQNsKf2Y25bqL2N2jA1LonISQiei1Z0SaNcu
        7KrBeieWjfrwBnSbmujn7qbSm29xdfvS+WVOBIrPcPCsOm933Kk8ym7g60NK4XHqfQSMqs
        QSyQDYyh7lOAukO4TQ67V6bHpLcZGAM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1630752613;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p1eRZMhxY07/cPHYxD57xDLVN35T7tHbH+Nv73UiRlg=;
        b=ItTlZBMOkEtNE+JVVUIl5J4I/Q56u+Dwlw/1W0t4iW6nSQkQOvCINA+7o/lzww8W1edi4j
        gS70YnzRxMj0VHAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C0A5C1348A;
        Sat,  4 Sep 2021 10:50:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KF5uLmVPM2HoUQAAMHmgww
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
Subject: [PATCH v6 26/33] mm, slub: don't disable irqs in slub_cpu_dead()
Date:   Sat,  4 Sep 2021 12:49:56 +0200
Message-Id: <20210904105003.11688-27-vbabka@suse.cz>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210904105003.11688-1-vbabka@suse.cz>
References: <20210904105003.11688-1-vbabka@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=840; h=from:subject; bh=h6nzJhDgk2ZvszSdJHL3MX5oVhHKmynUK46JJaaagsE=; b=owEBbQGS/pANAwAIAeAhynPxiakQAcsmYgBhM09HKkn7kB+0dVpcTh24XH7mRYHSRPgStKCOwJny jkAD8wGJATMEAAEIAB0WIQSNS5MBqTXjGL5IXszgIcpz8YmpEAUCYTNPRwAKCRDgIcpz8YmpEISVB/ 9cq1cyrQj48CpGgFbC6pCfD5peOzqcZ0tLTqXRpZqn3y8qjqqjKeTbzaeqHuhWP72pHqyCjUsoH8PF VEVRSwlpKWHxm7TWJYmb73ErRm++yX5TRyqZUxXBQ5Bf3CMTOKmmPO15oSGLnBY7yyy5E03PNabf13 HXb/jyP10CPQBDTSQdDI8jFlA1iosQOgPW6xcDvFgWmrrSV2d9sBcDrSfLwPgVNQKm8QtHuelufGpq wFx0/JvaSkt/uecRBnER+GQNTlUiy20UTvCSHkq+QUVe76x+U9YMFBIrA16wsFQiLFt1oV0XsfhiFf 3e0/+znMSgllxam7bu/LQPwJNogoKS
X-Developer-Key: i=vbabka@suse.cz; a=openpgp; fpr=A940D434992C2E8E99103D50224FA7E7CC82A664
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
index c5766e504e73..c4a9b8901576 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2554,14 +2554,10 @@ static void flush_all(struct kmem_cache *s)
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
2.33.0

