Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 321CB362DB5
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 06:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbhDQEia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Apr 2021 00:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbhDQEi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 00:38:28 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0003C061574
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 21:38:02 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id u7so13190719plr.6
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 21:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8k6YXYK85mvc31ajI7k2coqgwaOfr7Ej3V6vhYCGVRI=;
        b=ps1+a0+z21qwgsRdYo2hIYK2avotOHkYx3BP4oOagRnFhl/blcLB1v1fiGfsYeWwjB
         r+HCFHxNBDPj/n5UF3SbNMRjYnh5N1VDtGH+FAZcThLFwwbBbCyEj9jUE0E1TwBndNWY
         iIdiA/YDNmAIyMyySRsHmmSWSAMHEIk5RmAZPMs1NC0Zd/UkbQAFbHUFs1bqFBmx3c4Z
         AnjWuaxinOTVY2me31a3RJ2F8XmoQh1VHiiXbLZoNBdUm39+DG/dTRxIKzhC3PqabIpV
         SvcijOy+eHbybeP/SLVydbxRl2iZhP2NuurrjBs9JenKG1CRMKQgqP4z+s89SCieg+DB
         zHSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8k6YXYK85mvc31ajI7k2coqgwaOfr7Ej3V6vhYCGVRI=;
        b=A+E4xO5Sky34x/iQnfGAzTvm8wlSnPZKekU2BktZROcB8No6uu1/bJqmpSnapSkYBT
         JsXYNrUbHsarZbhtUj99BKKZpG/3V+gPFFLHCZZULWryWfklQW5fsAzvfXsDVsKuNNC1
         3EihIz16FB2uxIxxSVHcD09XeNWWYUINTXtnIznL15Lt51JYLQubj8RrRk5oZUOvXfGy
         9Nz+pJC0zqZH064Y9wpbP8P/IqdWZ9vuB2/Uaot/s5p2eBYlrKMkOQZc2tELhMdCgEaQ
         a2futP2ijseyeQzFzIFbXRCIe5i4rf8nxoAwzlSO6jOm++zlsHxn4obMKlgVUqBqpExe
         teqg==
X-Gm-Message-State: AOAM531MUNa83347+rRAn1qglf7MRprm0WDX1q8+pStiCLDKo6C0CUiH
        DGqOAoLqbI2o7vx5sMaDWKVWyg==
X-Google-Smtp-Source: ABdhPJxf0T3t8Wb69/tbGsZ2lpLCfYMfOgx16Q4hD5OSt32utfReq+PsYCafvJR3TPaUnVvUlqb2zw==
X-Received: by 2002:a17:902:264:b029:eb:3d3a:a09c with SMTP id 91-20020a1709020264b02900eb3d3aa09cmr12795807plc.0.1618634282457;
        Fri, 16 Apr 2021 21:38:02 -0700 (PDT)
Received: from localhost.bytedance.net ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id w21sm7064775pjy.21.2021.04.16.21.37.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Apr 2021 21:38:02 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@suse.com>
Subject: [PATCH v3 1/8] mm: memcontrol: fix page charging in page replacement
Date:   Sat, 17 Apr 2021 12:35:31 +0800
Message-Id: <20210417043538.9793-2-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210417043538.9793-1-songmuchun@bytedance.com>
References: <20210417043538.9793-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pages aren't accounted at the root level, so do not charge the page
to the root memcg in page replacement. Although we do not display the
value (mem_cgroup_usage) so there shouldn't be any actual problem, but
there is a WARN_ON_ONCE in the page_counter_cancel(). Who knows if it
will trigger? So it is better to fix it.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Reviewed-by: Shakeel Butt <shakeelb@google.com>
Acked-by: Roman Gushchin <guro@fb.com>
Acked-by: Michal Hocko <mhocko@suse.com>
---
 mm/memcontrol.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 64ada9e650a5..f229de925aa5 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6806,9 +6806,11 @@ void mem_cgroup_migrate(struct page *oldpage, struct page *newpage)
 	/* Force-charge the new page. The old one will be freed soon */
 	nr_pages = thp_nr_pages(newpage);
 
-	page_counter_charge(&memcg->memory, nr_pages);
-	if (do_memsw_account())
-		page_counter_charge(&memcg->memsw, nr_pages);
+	if (!mem_cgroup_is_root(memcg)) {
+		page_counter_charge(&memcg->memory, nr_pages);
+		if (do_memsw_account())
+			page_counter_charge(&memcg->memsw, nr_pages);
+	}
 
 	css_get(&memcg->css);
 	commit_charge(newpage, memcg);
-- 
2.11.0

