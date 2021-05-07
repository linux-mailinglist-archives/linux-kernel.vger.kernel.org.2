Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 933FB3760AA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 08:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234478AbhEGGqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 02:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234439AbhEGGqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 02:46:24 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C01C061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 23:45:24 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id m12so11965836eja.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 23:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Mj0Mrbwis8BlLVVsblHzd0GX9KXBMtpEBNXjdrEcK38=;
        b=jRwgD0JsulpHBWVe9/tpA6egUFCh8sv3YSEuuv5ObdqnrdVukfFxUdfWIhU+MTY8bq
         gR6Ggb+FfL2vPcPHtBc5cflELO8H2Ork0BmbFOOObgDBSWrF/rD19POdL+CBkgrSm2or
         TUZWV9ShQqCcedBIg8X4MbsWhb0cawehVKnWk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Mj0Mrbwis8BlLVVsblHzd0GX9KXBMtpEBNXjdrEcK38=;
        b=qYx0u0cU6hMjgN7mT/glS2It/L47DHM+pQgLuqb2r20BFIOInTIiv9/w5JMfltw8G6
         n/i/IHkLsmcTusCdYFLEvBUs4vp+G7D02U1X+XPpeIPAqgyE71Yuekktc3zAi6gQ1906
         mjaPYg+UapLcGXU8Kaj6T0cJqcw0Q2hqamzGbhGHd1CxcmPZnd1YINmymeEjzH4HDacc
         CF5K8Pfv4sCE2MuuAhX3V+LR8RXoOoRV+jUq67QlmVfl4tiAu+wb9H14B68hnUAu0z43
         NH1b7nYaLn7kilfyscUU7jiKdAmLr3GijpcdFP8IbTIGgev66OP12xX7mI3Ytc5qknlq
         xjOA==
X-Gm-Message-State: AOAM531T9QjUGiXGr+sA9TnH9JsEDC4/rinE7hYzXe/LvEvhlxZMbEsO
        SdeRCGReCbFQJ7rK7ivSnlNnhQ==
X-Google-Smtp-Source: ABdhPJz1uSwqC/K3o/5rBeb+EcG285dENMOzuYSw6iIAJe6vCzQPGFW7dwWUEaaU9AYfKuPjD5T2PA==
X-Received: by 2002:a17:907:628d:: with SMTP id nd13mr8267966ejc.299.1620369921868;
        Thu, 06 May 2021 23:45:21 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([80.208.71.248])
        by smtp.gmail.com with ESMTPSA id 11sm2445619ejx.55.2021.05.06.23.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 23:45:21 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Lobakin <alobakin@pm.me>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm/page_alloc: __alloc_pages_bulk(): do bounds check before accessing array
Date:   Fri,  7 May 2021 08:45:03 +0200
Message-Id: <20210507064504.1712559-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the event that somebody would call this with an already fully
populated page_array, the last loop iteration would do an access
beyond the end of page_array.

It's of course extremely unlikely that would ever be done, but this
triggers my internal static analyzer. Also, if it really is not
supposed to be invoked this way (i.e., with no NULL entries in
page_array), the nr_populated<nr_pages check could simply be removed
instead.

Fixes: 0f87d9d30f21 (mm/page_alloc: add an array-based interface to the bulk page allocator)
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 mm/page_alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index bcdc0c6f21f1..66785946eb28 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5053,7 +5053,7 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 	 * Skip populated array elements to determine if any pages need
 	 * to be allocated before disabling IRQs.
 	 */
-	while (page_array && page_array[nr_populated] && nr_populated < nr_pages)
+	while (page_array && nr_populated < nr_pages && page_array[nr_populated])
 		nr_populated++;
 
 	/* Use the single page allocator for one page. */
-- 
2.29.2

