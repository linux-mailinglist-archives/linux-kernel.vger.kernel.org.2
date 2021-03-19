Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD4A2342212
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 17:39:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbhCSQjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 12:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbhCSQiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 12:38:54 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 972DCC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 09:38:54 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id w11so3212161ply.6
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 09:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j+pjxQiaXnPHaW0/aM9Ma4XbfsZ3VGpPRSn22gO/IJk=;
        b=hndwoIvTDp18phnZoOCAMilxvlnI5R4bA0e6iNMwiZ2EStHkNhhanShOAxQm/paJOL
         vrd258tkru/GarijoiTCdxlme4iCHlzw78VJjk6jR6gS8nQFoqbrbHcAY16uad1yuM4M
         Z7Cynrc7DTbGPAJ93R+Ee1nqRC89+tCS9In9PXNSX2XxHoD8v4I2VxZcrdxGwb/VLK6V
         e0OqJ087jjnsHeyWmUdjgEnRK+OAv+O7nGiG0gsoDo/HmZuzINONi8sptadFQnhycaeI
         huBd+7zO5WRDxnOHI+cNbxkvIv7NZSCUwhVxSqXR9nEH7q73J37fkqSpW2Ty+vFuYWUu
         9WIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j+pjxQiaXnPHaW0/aM9Ma4XbfsZ3VGpPRSn22gO/IJk=;
        b=sLGJqR6/bCia9iwOjHjxJgMzw8R80/L+HIwuZoW/pmwIygLgdo4UptfHtV1ss/kegB
         SoJE4B8dIufE3CdZan/VWM+leFAf7HgQrIS47yPSNjzC8axz4sTPhl84rI0rc/uSFwsN
         3iXBZ4jRNaDH/Ik+w4k4ONcGapVD3Vg2d462aqHr/bPXOSuHHkh1clf/q4FsP46WJct2
         N90PI4+ovHhAKYHTBa2xrN7Ml+ahf6onKNnE27cUjnNjVNyDGFu0A4OipcvYKXrY4Sxy
         x4PCR8sbqI6Z583BbKlI854MjuRE46jUZ5cQ1yK1MG6FVawdYgG0RF9+ekS5bWB60Dy9
         85RQ==
X-Gm-Message-State: AOAM533FUpPphnWRMkJXP2uadov8l0jxEjQDOapzdpKgKz2xbHyjYwbL
        8WIXFaKj47z3ZimrCTddmfAIBw==
X-Google-Smtp-Source: ABdhPJxixIQ1BHBaesp4TbWicJ28kV8dAw86Zj6b62FphQwkOH+vVTVeZmrTYVNMmK7JAPjxFw1sNg==
X-Received: by 2002:a17:902:c48c:b029:e4:c093:593a with SMTP id n12-20020a170902c48cb02900e4c093593amr14951679plx.1.1616171934202;
        Fri, 19 Mar 2021 09:38:54 -0700 (PDT)
Received: from localhost.bytedance.net ([139.177.225.231])
        by smtp.gmail.com with ESMTPSA id z25sm5860239pfn.37.2021.03.19.09.38.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Mar 2021 09:38:53 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v5 4/7] mm: memcontrol: change ug->dummy_page only if memcg changed
Date:   Sat, 20 Mar 2021 00:38:17 +0800
Message-Id: <20210319163821.20704-5-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210319163821.20704-1-songmuchun@bytedance.com>
References: <20210319163821.20704-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just like assignment to ug->memcg, we only need to update ug->dummy_page
if memcg changed. So move it to there. This is a very small optimization.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Reviewed-by: Shakeel Butt <shakeelb@google.com>
---
 mm/memcontrol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 9489c7fc1e04..8d28a5a2ee58 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6854,6 +6854,7 @@ static void uncharge_page(struct page *page, struct uncharge_gather *ug)
 			uncharge_gather_clear(ug);
 		}
 		ug->memcg = page_memcg(page);
+		ug->dummy_page = page;
 
 		/* pairs with css_put in uncharge_batch */
 		css_get(&ug->memcg->css);
@@ -6867,7 +6868,6 @@ static void uncharge_page(struct page *page, struct uncharge_gather *ug)
 	else
 		ug->pgpgout++;
 
-	ug->dummy_page = page;
 	page->memcg_data = 0;
 	css_put(&ug->memcg->css);
 }
-- 
2.11.0

