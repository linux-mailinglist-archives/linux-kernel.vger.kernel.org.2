Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 281C841F2B4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 19:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241951AbhJARKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 13:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231626AbhJARKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 13:10:04 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D725EC061775
        for <linux-kernel@vger.kernel.org>; Fri,  1 Oct 2021 10:08:19 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id qe4-20020a17090b4f8400b0019f663cfcd1so3354765pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Oct 2021 10:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y2if6JtpDHx5Au3/IiXuFYQJ5NPAV0CgkFARbb/gA2s=;
        b=ccIfCNXjf9tNR//mRF8/jbXVyFvoM8fjj9iSsH0ulBu1Dmkyx7lMYbW65TWWMM8AKx
         sfAgAsCTg+yGW+FKBfEZ0tv3+VKDlidmO2LJq6a0yEHJMqfiaku+kp/BiBA9G+0GyWKd
         7gdpmTpRNY3bI3lOLtBIyUE32eoDUINjweb4jFbB334qoKWGqi1GEUEuEq8BKF6fbpmw
         nulgoMBVKwROFEiG+Awj+c7SpfTp00jTzRl7HKQtk/yhSlQdEvYAv7HbsRL7GwKclTdz
         o1HBcCjR0Dp0B8GsTWLH8l9TeFgJ6jEH45YxPdk3aiDKeM/RNjdUi5niuEzPKok4pOZP
         D1Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y2if6JtpDHx5Au3/IiXuFYQJ5NPAV0CgkFARbb/gA2s=;
        b=jKnHvSHkeoml8cMzhT6Oi8f0CFPUPu+pz/kHeSyMhmSTOP8VERJcH+6xYxlGmV07KM
         WA1PpgBFULyVA1Vz/zWgzUQa1CDi04ubN2ay4Y0MvTNZlIwXhOFMrqEb1ekmxgvaZR2X
         jpXQ8IHSp96jXbOE2IZP0q//+WJRM8eUlBInXDuDL9Fmbp7+T/0L5I+jW9iz/PAE/zxh
         /ycwISmM8Y4ih2ub++DBisAbAqIyz7OcuQuMm2wM2TdvIwKF3X0ImREbrUQakNr3apyZ
         WrA1wqJdnqrPf5EUMVYWpVFw9Pgp2m7atrIWJrzcqwe9Dxeczd1GdOusVebP/lztMwMW
         5J9w==
X-Gm-Message-State: AOAM532sXF5dTEHsG1X+lYDkr2h4MCjyqGEC38eWfyjz3+PHpQg41ep9
        jaIZ2PoUMoGL3beUaDkv5j4=
X-Google-Smtp-Source: ABdhPJxdUQtTzebMw3PF+fxpwBsgkUTmBxnW1T8ZXBGi9KaFaXUtRrAJOpTDSX/BQvS8It3kNMMKkg==
X-Received: by 2002:a17:90b:3108:: with SMTP id gc8mr20418141pjb.63.1633108099389;
        Fri, 01 Oct 2021 10:08:19 -0700 (PDT)
Received: from edumazet1.svl.corp.google.com ([2620:15c:2c4:201:b59b:abc0:171:fe0e])
        by smtp.gmail.com with ESMTPSA id w185sm4313737pfd.113.2021.10.01.10.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 10:08:18 -0700 (PDT)
From:   Eric Dumazet <eric.dumazet@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Eric Dumazet <edumazet@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Pengfei Li <lpf.vector@gmail.com>
Subject: [PATCH] mm/vmalloc: make sure to dump unpurged areas in /proc/vmallocinfo
Date:   Fri,  1 Oct 2021 10:08:15 -0700
Message-Id: <20211001170815.73321-1-eric.dumazet@gmail.com>
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

If last va found in vmap_area_list does not have a vm pointer,
vmallocinfo.s_show() returns 0, and show_purge_info() is not called
as it should.

Fixes: dd3b8353bae7 ("mm/vmalloc: do not keep unpurged areas in the busy tree")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Uladzislau Rezki (Sony) <urezki@gmail.com>
Cc: Pengfei Li <lpf.vector@gmail.com>
---
 mm/vmalloc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index d77830ff604cab1796a96e31ad1423a790c61ca7..42219f3d12b567fc64f54cd3e2f1e3398e261a2c 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3902,7 +3902,7 @@ static int s_show(struct seq_file *m, void *p)
 			(void *)va->va_start, (void *)va->va_end,
 			va->va_end - va->va_start);
 
-		return 0;
+		goto final;
 	}
 
 	v = va->vm;
@@ -3943,6 +3943,7 @@ static int s_show(struct seq_file *m, void *p)
 	/*
 	 * As a final step, dump "unpurged" areas.
 	 */
+final:
 	if (list_is_last(&va->list, &vmap_area_list))
 		show_purge_info(m);
 
-- 
2.33.0.800.g4c38ced690-goog

