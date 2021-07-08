Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C71803C19A4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 21:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbhGHTO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 15:14:27 -0400
Received: from mail-qt1-f175.google.com ([209.85.160.175]:41604 "EHLO
        mail-qt1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhGHTOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 15:14:25 -0400
Received: by mail-qt1-f175.google.com with SMTP id z18so2342195qtq.8
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 12:11:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y37sxqdyEEFFUgy5VlTHVFB6NCIJDJ+Q1MpiuJu7Kuc=;
        b=L62hs+XttK6l9tVhqNLnDDPyE7FzM+/wPdEEaAp4Ycgo8eV3rIwiPaCMTkDglPhP8D
         b5aMfqm2UCbr5bcVYhdCVUozu3Y1EzEjhtzmKGVO2unOzkXcg/hsptuMHdhnGJO2UUWA
         QJndIonidXviZhUwEFXCITmtaCgjblRuiUx3cTbsfFqdvhe/mz+UvwSU5SRQQWbTVZpJ
         R8hXzEvRHvPhJfRxDycEy5XfAaayvCZKA4DFxFL8Rf+0ji8UKFwoO36egvsCb0DzkdJA
         HRapAyuya1sExJ1Y05L6EObRI5v74QBoSGYWw9aA7cVWbGH7rQbL42K1Gw8X125424eJ
         2Mzg==
X-Gm-Message-State: AOAM532/794hEk4q/6VEf35UaBAGKBeXVStcbA+inXmeHPwyIPLU8IUX
        vJWlEp56BR2IMeiEzZ1L/Vg=
X-Google-Smtp-Source: ABdhPJxKOGf0wyKILouQA7dYUfZOfHDAgSb3Z5+ZQgEPFEzSYKD/7E0N9Y3cN9BswWyxBFjZb5fuCw==
X-Received: by 2002:a05:622a:209:: with SMTP id b9mr9039217qtx.375.1625771502621;
        Thu, 08 Jul 2021 12:11:42 -0700 (PDT)
Received: from msft-t490s.. ([45.74.48.12])
        by smtp.gmail.com with ESMTPSA id p9sm1283880qtw.88.2021.07.08.12.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jul 2021 12:11:42 -0700 (PDT)
From:   Matteo Croce <mcroce@linux.microsoft.com>
To:     Mel Gorman <mgorman@techsingularity.net>,
        Linux-MM <linux-mm@kvack.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dan Streetman <ddstreet@ieee.org>,
        Yang Shi <shy828301@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] Revert "mm/page_alloc: make should_fail_alloc_page() static"
Date:   Thu,  8 Jul 2021 21:11:28 +0200
Message-Id: <20210708191128.153796-1-mcroce@linux.microsoft.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matteo Croce <mcroce@microsoft.com>

This reverts commit f7173090033c70886d925995e9dfdfb76dbb2441.

Fix an unresolved symbol error when CONFIG_DEBUG_INFO_BTF=y:

  LD      vmlinux
  BTFIDS  vmlinux
FAILED unresolved symbol should_fail_alloc_page
make: *** [Makefile:1199: vmlinux] Error 255
make: *** Deleting file 'vmlinux'

Fixes: f7173090033c ("mm/page_alloc: make should_fail_alloc_page() static")
Signed-off-by: Matteo Croce <mcroce@microsoft.com>
---
 mm/page_alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index d6e94cc8066c..7b6405f8ff48 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3831,7 +3831,7 @@ static inline bool __should_fail_alloc_page(gfp_t gfp_mask, unsigned int order)
 
 #endif /* CONFIG_FAIL_PAGE_ALLOC */
 
-static noinline bool should_fail_alloc_page(gfp_t gfp_mask, unsigned int order)
+noinline bool should_fail_alloc_page(gfp_t gfp_mask, unsigned int order)
 {
 	return __should_fail_alloc_page(gfp_mask, order);
 }
-- 
2.31.1

