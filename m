Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28B7039EF9A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 09:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbhFHHb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 03:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbhFHHb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 03:31:56 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FECEC061574
        for <linux-kernel@vger.kernel.org>; Tue,  8 Jun 2021 00:29:52 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id b15-20020a17090a550fb029015dad75163dso1721269pji.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 00:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=A1FVdBLroLku9q9ilLiRJwe+Pjc9CxTsM6tUd9JMzio=;
        b=WwrMIJm/AGIvcQSZdNNALddGnCqfVUn2saoi2X0NHxQqbTomV5y2hM0pPbV9k8oZ/S
         WZDNrZdQsOVhdwyUKlsg44nGpc1TxFyEs+67yl3Wrzflf5j+AluRQc+avWS2R6KhVmxp
         8/2aY4Eg1hU9aQciO1Qrpc+kk8sAbsu8NzZXbH4YcIT2lkcPnEEo+zyahdr5Tw/xHARG
         +ZlJ8Ip+KXsBHzMvOzcq5Rx0XmISsJkYxORMZ12atdFpPT9OTl7YKuTljeS31k6PgiyW
         YwQvlMXLyZFbwG4NDbzGz54mJ+9w5gLtc58xoi2Wv9blpnNp+GzKdh79FawoM4NwJk9+
         5V5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=A1FVdBLroLku9q9ilLiRJwe+Pjc9CxTsM6tUd9JMzio=;
        b=L3yM9nXEL9EjRglJhXzNcR3KldZe+O0mOcAyNuv5xIeYRPnS5s48AQXM8I0UK66RPP
         jlKQ6nqVUbLK9I/Wot3Ja+wvX6KEQko7uUpemr6gQr10AYQJtDRjZCapKiX1LdEyHDgk
         OnqByFQZPjP9/CltK7b5p3lt44fZmEP2vduk1N0sp1SQ/7KfPHbEEdqQicw7/j7ik3yY
         5qSjfHmM3uVsYPpkEWir9sOd/fNFgDAZJe1pVJtbstfY4N7K7a3O42ncE6T5fQH2c54y
         B6R4uzBM2MHqPZJK8lAPIHr0clNXu2e2aR9Sh1163rVxOss3BuknSoCGJ/U0gVBenk8g
         bzHA==
X-Gm-Message-State: AOAM532mR6MgGl3c2VuxeRAacAx2S4KVt9tF4/U70WkWQktIQdHh/05e
        Yd3KRr9nqSaHZWtnf3LtV1M=
X-Google-Smtp-Source: ABdhPJwiUnjNauhfySzvfF5dovb7omM5q58TCIclGTS9zR86etrocbOAuHA3NRGCMGaGfNJ9kfujGQ==
X-Received: by 2002:a17:90b:1e0b:: with SMTP id pg11mr3304270pjb.173.1623137391677;
        Tue, 08 Jun 2021 00:29:51 -0700 (PDT)
Received: from bj03382pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id o10sm13807080pjr.2.2021.06.08.00.29.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jun 2021 00:29:51 -0700 (PDT)
From:   Huangzhaoyang <huangzhaoyang@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH] mm: zram: amend SLAB_RECLAIM_ACCOUNT on zspage_cachep
Date:   Tue,  8 Jun 2021 15:28:17 +0800
Message-Id: <1623137297-29685-1-git-send-email-huangzhaoyang@gmail.com>
X-Mailer: git-send-email 1.7.9.5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

Zspage_cachep is found be merged with other kmem cache during test, which
is not good for debug things(zs_pool->zspage_cachep present to be another
kmem cache in memory dumpfile). It is also neccessary to do so as shrinker has
been registered for zspage. Amending this flag can help kernel to calculate
SLAB_RECLAIMBLE correctly.

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
 mm/zsmalloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 19b563b..0b0addd 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -328,7 +328,7 @@ static int create_cache(struct zs_pool *pool)
 		return 1;
 
 	pool->zspage_cachep = kmem_cache_create("zspage", sizeof(struct zspage),
-					0, 0, NULL);
+					0, SLAB_RECLAIM_ACCOUNT, NULL);
 	if (!pool->zspage_cachep) {
 		kmem_cache_destroy(pool->handle_cachep);
 		pool->handle_cachep = NULL;
-- 
1.9.1

