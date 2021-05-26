Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05CAB39236C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 01:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234493AbhEZXyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 19:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232270AbhEZXyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 19:54:45 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C493C061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 16:53:14 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id v12so1419663plo.10
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 16:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6mXh3c9ZB/hAxTDKi9fynEz6oh8bZIstdzjsb0THY5o=;
        b=EEcT3ELNsQ9vVEUmHaT6Fa4RSd8lyVpze0AAw0NaoV8UlTeYSkXrowFBfeSw003bzT
         4wvYDwpw/1KIRfUqx9GkAenx7vcAXYKis5a75qsisnIo8TFtMEqMA/YK1u10buvAfRGo
         bUm5hGexCBBUK1adtCWh7Lo1eUz0fTMA8oElEj1EFtoHCnKSBiOL0pYz+o1SjarwRW+i
         daukyuJwLIfW9Ic6jDeuPPeJavzffWMZpGdJZzsIAjKosil0u36vFIczG7yEZWPu1J1h
         1DvQk8EPgeDjHsIP0JOHxqRmIkCPsVkeNjSgJqpzdISriOsnBUCjQaoNDoOm+A9lq5vh
         /PVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6mXh3c9ZB/hAxTDKi9fynEz6oh8bZIstdzjsb0THY5o=;
        b=ACC003E1YBzl19cGdvOH4punlO2ag6DgE5dgxlzoyRGSrK7GtVxHSZr2saN5W34NQX
         S3smC8fjkHIS6+Na2QfEvCMvwzHWMk46SYis/9dW5/8rnL4u3CxRWT4OLC08R2TFVQI3
         eBGaDJX1ITcdfGDWFVeRTj+ustsertQHVaiJXpaD544MliyAlZqAYaC4+0jogE0rgKaY
         TXvgsJGermd/ZPdlFljMg2mJ8un6FmNTs6mhN3p9I8RLdorrTVk8fVMArP2AOXkCKUh+
         btabfQzRiQ6lsHGHdCYAAJXJl6dFyxHL5dZOM6x9n0HZx76pV0Sj9BT8suJUVmazCvU/
         NOGA==
X-Gm-Message-State: AOAM533k2ZkjXTfQxogc1ut7KJNBr5QuNeyGYiiyNieEQnOqm/FNGhNm
        aViQlZTLSIMbRO0N6WtuNA==
X-Google-Smtp-Source: ABdhPJyOdrOvfLiJxE/Lds0YBYaFooytCDXCqmFsBU7kwDmrQ0AgYeRWG+3FWq7Rmmj5obrZjkBu/w==
X-Received: by 2002:a17:902:b683:b029:ee:f0e3:7a50 with SMTP id c3-20020a170902b683b02900eef0e37a50mr610607pls.7.1622073193498;
        Wed, 26 May 2021 16:53:13 -0700 (PDT)
Received: from localhost.localdomain (h175-177-040-153.catv02.itscom.jp. [175.177.40.153])
        by smtp.gmail.com with ESMTPSA id 10sm177063pgl.39.2021.05.26.16.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 16:53:13 -0700 (PDT)
From:   Naoya Horiguchi <nao.horiguchi@gmail.com>
To:     linux-mm@kvack.org, Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Michal Hocko <mhocko@suse.com>, Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] hugetlb: pass head page to remove_hugetlb_page()
Date:   Thu, 27 May 2021 08:52:57 +0900
Message-Id: <20210526235257.2769473-1-nao.horiguchi@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naoya Horiguchi <naoya.horiguchi@nec.com>

When memory_failure() or soft_offline_page() is called on a tail page of
some hugetlb page, "BUG: unable to handle page fault" error can be
triggered.

remove_hugetlb_page() dereferences page->lru, so it's assumed that the
page points to a head page, but one of the caller,
dissolve_free_huge_page(), provides remove_hugetlb_page() with 'page'
which could be a tail page.  So pass 'head' to it, instead.

Fixes: 6eb4e88a6d27 ("hugetlb: create remove_hugetlb_page() to separate functionality")
Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
---
 mm/hugetlb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git v5.13-rc3/mm/hugetlb.c v5.13-rc3_patched/mm/hugetlb.c
index 95918f410c0f..470f7b5b437e 100644
--- v5.13-rc3/mm/hugetlb.c
+++ v5.13-rc3_patched/mm/hugetlb.c
@@ -1793,7 +1793,7 @@ int dissolve_free_huge_page(struct page *page)
 			SetPageHWPoison(page);
 			ClearPageHWPoison(head);
 		}
-		remove_hugetlb_page(h, page, false);
+		remove_hugetlb_page(h, head, false);
 		h->max_huge_pages--;
 		spin_unlock_irq(&hugetlb_lock);
 		update_and_free_page(h, head);
-- 
2.25.1

