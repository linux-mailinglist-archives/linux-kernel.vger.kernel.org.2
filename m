Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 255A732C2C0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:06:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353774AbhCDAF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 19:05:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388058AbhCCUp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 15:45:58 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028A8C061756
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 12:45:18 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id s23so5152742pji.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 12:45:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=32Qm/Uyf2Lhed9JgA1QJ7suEThHhdsVNGCD4lOn0G9Y=;
        b=Fp3P1jHF2RXHxJ6HE2oevW0qVoVfn2AJOv59VFIMl9j3cYi1E9SIlqsnCOI0yyZCVB
         w1NG3DOCcVe6S+F63FFT4vu7j3fVpTTW8an7y2y3uZiE4O4B8adI6W+2+n4UosmIXhfI
         JgdkYV2wPJ72XXWFszea6AkVRVIjiDR111pQ+Nc/IdsIpTuXFn872GOXKt6HZ1gxzmd2
         UbqReUwdpBYFXoCvFEl/2BXXT9hPISA+RvK8URuSNe8JIZLrObFf30Eg/exw35ivkD7T
         dSTDQ5LHO/jd6KEsxSkZgEuivh6k1ZIpB/2/mRWCcVUff/RagLhe3Ry8J2dEqEPo2nOe
         t8KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=32Qm/Uyf2Lhed9JgA1QJ7suEThHhdsVNGCD4lOn0G9Y=;
        b=mZOXncU2SL+vLF+N67KBtfySDeRTnN+Uhe8/G74aWTUq7GqvvJyDjpvuvfTY4k4A14
         RdYS/A9Z4XRO1uFRWeQAvdpo9ZxV5qI1s2lg16ACdC2dCiUsLv3pK87ILo12TH/rKx3b
         kyQW3IesfEaSjCaaLERF4wKM1/3YkbDuuOhMYiD4WsH3dT8H1TsrOBC5SEiXQwPJyQ1P
         OkT3MI4K2q5EknKCeurw/FZpFupuK3QZ1sPvgXBnaUZkjRGdYlO7kIGv4sdku8NJx+qs
         F1yuHDqWB8gP1lfYTF4mcBpWpaJF9zhFSJOiUUj/W66PtEgJZp4C0eIxb7AHN3jj2jMj
         DbEg==
X-Gm-Message-State: AOAM531Pv9hO8mklWPE6d8UEAwPCC8frzeyqZkTHBL5ZZXW8K1DI4d+b
        VgL9rhIHCSifI6yazElwl6c=
X-Google-Smtp-Source: ABdhPJz6qd0PVo3Tzd04F5outYkulshzoV4t+Uv8AJoOR15VhpkVw+PJYtNVrAezDstP+d3kZVD2QA==
X-Received: by 2002:a17:902:b78a:b029:e4:8ce6:fb64 with SMTP id e10-20020a170902b78ab02900e48ce6fb64mr883900pls.77.1614804317601;
        Wed, 03 Mar 2021 12:45:17 -0800 (PST)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:201:c87:c34:99dc:ba23])
        by smtp.gmail.com with ESMTPSA id y20sm14969784pfb.138.2021.03.03.12.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 12:45:16 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        joaodias@google.com, Minchan Kim <minchan@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>
Subject: [PATCH RESEND v2] mm: remove lru_add_drain_all in alloc_contig_range
Date:   Wed,  3 Mar 2021 12:45:12 -0800
Message-Id: <20210303204512.2863087-1-minchan@kernel.org>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__alloc_contig_migrate_range already has lru_add_drain_all call
via migrate_prep. It's necessary to move LRU taget pages into
LRU list to be able to isolated. However, lru_add_drain_all call
after __alloc_contig_migrate_range is pointless since it has changed
source page freeing from putback_lru_pages to put_page[1].

This patch removes it.

[1] c6c919eb90e0, ("mm: use put_page() to free page instead of putback_lru_page()"

Reviewed-by: Oscar Salvador <osalvador@suse.de>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Minchan Kim <minchan@kernel.org>
---
* From v1 - https://lore.kernel.org/linux-mm/20210209175048.361638-1-minchan@kernel.org/
  * add [Acked|Reviewed]-by - vbabka, mhocko, osalvador
  * add history to the description - vbabka

 mm/page_alloc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index f10966e3b4a5..11579f0ddba9 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8616,8 +8616,6 @@ int alloc_contig_range(unsigned long start, unsigned long end,
 	 * isolated thus they won't get removed from buddy.
 	 */
 
-	lru_add_drain_all();
-
 	order = 0;
 	outer_start = start;
 	while (!PageBuddy(pfn_to_page(outer_start))) {
-- 
2.30.1.766.gb4fecdf3b7-goog

