Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9997338989F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 23:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbhESVfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 17:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbhESVfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 17:35:06 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A40AC061574
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 14:33:45 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d78so9959953pfd.10
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 14:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oP8gkx8lBe4tFadnN1llHaYQNEqC1BdffwyrrrWEirY=;
        b=u7y1pYsrsONhi35thtT4sCU3kSP8eoObVlvB5VfQxPAQZMuSl+KUsG0H8Pw7ydtp12
         DRMKqvoMKkMX5/jW0t1WiVj1H0Z5Vx2/jMLnkM0S4btHP2fq4CA1qteSns00Fwa54O17
         7eu+COmp/BigfWKj1RuQO4+ZaAXmcoSezVniVvcVbljBupgj8OSvBCANOkLPUdLpQpnt
         i8qu4EeoeBqrTN3USqY6aa8fHseZvb+KQhshIzC0zEm6QhhitNeBsZxSfNEikxGPZXaV
         uR0Be5QwwM54fp/2toy7F7bAOpSYJHZMI4phLn1c7MWaxRHzbslxR+FWWytYkGkVqG0B
         +CcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=oP8gkx8lBe4tFadnN1llHaYQNEqC1BdffwyrrrWEirY=;
        b=tzcn8nF1TKpff9E004XHU7Viaug7la265WEjKw0pWjnkVGx9hqp11wLrWSj8FbmNa3
         pVURzfpcvf6bn7qFDi2E3ksQojHs/VbaDmduJ8+NWi2g1Mys4WR5qWWTXstiLebUpUrJ
         xsgJ+eNfhMqtRcQXsCPK36UigMaz8+Bgd1miDQHNZngCMy082YB5OE1DqNRkKDkgQxIQ
         cAVn7wAQJM/QoXS+cU/uD1BNrBVE7FEHM9s5VsUGJXxq6Uf/CwU2lGgAKcgYDX9Yi534
         P5wn99HkJLxQVpGRRxvy63kW7/g9EmvGIGj1UepgHi/a1EgjBNjyIH7q2+Ld9Q4AoAqo
         c36g==
X-Gm-Message-State: AOAM5323XZ554FEOF1faySvIvPOkxb+8o6hs3W5T4DVSQtgNEkZwuJua
        mdNwbRTVHbTKVIPeUsKfc18=
X-Google-Smtp-Source: ABdhPJw17dse/s5N6mmJmO3jjluXMyq5kxrCUDIerwZkvctMy0+GdVeA8EBeO2DKelkE5c6voVaOSA==
X-Received: by 2002:a62:8013:0:b029:2de:93c6:1358 with SMTP id j19-20020a6280130000b02902de93c61358mr1125885pfd.55.1621460025088;
        Wed, 19 May 2021 14:33:45 -0700 (PDT)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:201:4102:f4c7:9246:e6c4])
        by smtp.gmail.com with ESMTPSA id q24sm248773pgb.19.2021.05.19.14.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 14:33:44 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        John Dias <joaodias@google.com>,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Minchan Kim <minchan@kernel.org>
Subject: [PATCH] mm: page_alloc: dump migrate-failed pages only at -EBUSY
Date:   Wed, 19 May 2021 14:33:41 -0700
Message-Id: <20210519213341.2620708-1-minchan@kernel.org>
X-Mailer: git-send-email 2.31.1.751.gd2f1c929bd-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

alloc_contig_dump_pages aims for helping debugging page migration
failure by page refcount mismatch or something else of page itself
from migration handler function. However, in -ENOMEM case, there is
nothing to get clue from page descriptor information so just
dump pages only when -EBUSY happens.

Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 mm/page_alloc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 3100fcb08500..c0a2971dc755 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8760,7 +8760,8 @@ static int __alloc_contig_migrate_range(struct compact_control *cc,
 
 	lru_cache_enable();
 	if (ret < 0) {
-		alloc_contig_dump_pages(&cc->migratepages);
+		if (ret == -EBUSY)
+			alloc_contig_dump_pages(&cc->migratepages);
 		putback_movable_pages(&cc->migratepages);
 		return ret;
 	}
-- 
2.31.1.751.gd2f1c929bd-goog

