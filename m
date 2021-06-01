Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 219A3396E30
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 09:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233182AbhFAHt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 03:49:28 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:52156 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbhFAHt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 03:49:26 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 81B8B1FD2D;
        Tue,  1 Jun 2021 07:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1622533664; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QKUWHbN2cryxRpWGCysEGcdBOB1MXEIxNS6COFYpH98=;
        b=GiJvMgTmkvfRlp0JIy3maL9IwPN+9pF2Lr86hIURcpPxMtX+4clQRo6N3XTEZWYh2y4JH4
        OFs4d+KWKMpjh2AtKKWvK4Nd7KpiIk/s0FvK01pU0DAqhZpl560BfTV4GsAwlH0Wyazu7c
        4BQPsb6iu56sq+xymqtIAc11zHn/0/Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1622533664;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QKUWHbN2cryxRpWGCysEGcdBOB1MXEIxNS6COFYpH98=;
        b=C219fcOmkjZbIRb7kVzo5YcF8jRCd5D0bF+RuYRK8PGqYUxXUFGa4G/oT7om9rZbMZ70Lo
        pxxSZjr7UKg42MBw==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id DB67D118DD;
        Tue,  1 Jun 2021 07:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1622533664; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QKUWHbN2cryxRpWGCysEGcdBOB1MXEIxNS6COFYpH98=;
        b=GiJvMgTmkvfRlp0JIy3maL9IwPN+9pF2Lr86hIURcpPxMtX+4clQRo6N3XTEZWYh2y4JH4
        OFs4d+KWKMpjh2AtKKWvK4Nd7KpiIk/s0FvK01pU0DAqhZpl560BfTV4GsAwlH0Wyazu7c
        4BQPsb6iu56sq+xymqtIAc11zHn/0/Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1622533664;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QKUWHbN2cryxRpWGCysEGcdBOB1MXEIxNS6COFYpH98=;
        b=C219fcOmkjZbIRb7kVzo5YcF8jRCd5D0bF+RuYRK8PGqYUxXUFGa4G/oT7om9rZbMZ70Lo
        pxxSZjr7UKg42MBw==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id TPU+Mh/mtWC3MAAALh3uQQ
        (envelope-from <osalvador@suse.de>); Tue, 01 Jun 2021 07:47:43 +0000
Date:   Tue, 1 Jun 2021 09:47:42 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm,memory_hotplug: Drop unneeded locking
Message-ID: <20210601074737.GA30768@linux>
References: <20210531093958.15021-1-osalvador@suse.de>
 <679d311a-8ad4-bb53-18f0-11190a2bf1b5@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <679d311a-8ad4-bb53-18f0-11190a2bf1b5@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Authentication-Results: imap.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -0.50
X-Spamd-Result: default: False [-0.50 / 100.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         RCPT_COUNT_SEVEN(0.00)[8];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_NOT_FQDN(0.50)[];
         RCVD_COUNT_TWO(0.00)[2]
X-Spam-Flag: NO
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 01, 2021 at 10:47:31AM +0530, Anshuman Khandual wrote:
> Should also just drop zone_span_write[lock|unlock]() helpers as there
> are no users left ?

Yes, definitely.
Andrew, can you squash this on top? Thanks:

diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index a7fd2c3ccb77..27d8ba1d32cb 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -67,10 +67,6 @@ struct range mhp_get_pluggable_range(bool need_mapping);
 
 /*
  * Zone resizing functions
- *
- * Note: any attempt to resize a zone should has pgdat_resize_lock()
- * zone_span_writelock() both held. This ensure the size of a zone
- * can't be changed while pgdat_resize_lock() held.
  */
 static inline unsigned zone_span_seqbegin(struct zone *zone)
 {
@@ -80,14 +76,6 @@ static inline int zone_span_seqretry(struct zone *zone, unsigned iv)
 {
 	return read_seqretry(&zone->span_seqlock, iv);
 }
-static inline void zone_span_writelock(struct zone *zone)
-{
-	write_seqlock(&zone->span_seqlock);
-}
-static inline void zone_span_writeunlock(struct zone *zone)
-{
-	write_sequnlock(&zone->span_seqlock);
-}
 static inline void zone_seqlock_init(struct zone *zone)
 {
 	seqlock_init(&zone->span_seqlock);
@@ -233,8 +221,6 @@ static inline int zone_span_seqretry(struct zone *zone, unsigned iv)
 {
 	return 0;
 }
-static inline void zone_span_writelock(struct zone *zone) {}
-static inline void zone_span_writeunlock(struct zone *zone) {}
 static inline void zone_seqlock_init(struct zone *zone) {}
 
 static inline int try_online_node(int nid)


-- 
Oscar Salvador
SUSE L3
