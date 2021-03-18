Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88D0334043A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 12:09:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbhCRLJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 07:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbhCRLIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 07:08:40 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A5C0C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 04:08:40 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id t20so1121201plr.13
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 04:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=15LgLWnrDF9xrY/f9Qycq0PzYRn8kF+pr7olZciihDc=;
        b=KtCvKs+mdXNV7hiXR9LnggjmgOU3pD83nEi3aMALjUmJrnwc0VCJWtA33DzRM3ejR+
         8YCeNCjveM54mbqMhLrw7JP3SDAA/+rS/tHgOg0YaCpi3cyMXag0Dd61VsNKgMB2tvID
         2b3pQVxuK/+w61Y4cHv1gZ2IyWU6+YiEJEGoFb3ThIPpM7fhElDTPdmC8c0tPj13uqN7
         Cnc09uKri9MNkeloxXsBQiYNrzdIxFI+iQgNuZlIcQ/cYabVryhTdoTfUO6LWLt+9hxe
         LqHeBrO8JdxSUeNpZP/k85gDtzMZNOpwKW35Zg+IlzLlJg2zS4J2SFgP68SJqs4Lp1+l
         lemA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=15LgLWnrDF9xrY/f9Qycq0PzYRn8kF+pr7olZciihDc=;
        b=kE28qWpIWN8D2Grhs3wd+a6eWJIGWq0IRvl67VqqO3Z4RDzW3H1mmRBqbvIr8zhD7H
         PRJHXDwaFEJFgxxFwsD95klZviWe61UrKSgaNXlhGjQ4YOccw6IFdWb+TT+YlYfgeG6B
         Dy+Ggh/XMF17XBIzm11pz70KoW1z57uchUUbIfsd+OXlXE7dCJ4Mp870zROI+W35a/uQ
         w0T2KP0SDf24Fjn7WNcgvTlMgLJqOMC/6iH/3jAb8WOu/CF9HXA9NrhiWBE4sNLc0pj7
         ufr60XmrSaUgAKHwPQV6Jao5y3mqDLBggwwV/sGZwJLSaFMGx0WoNidVC0AwEo1mqnBE
         JDLA==
X-Gm-Message-State: AOAM532xaIcr/R2mS33hTeXLSVViTtcEkw6nug+lXJNhVrvRxrmEPDF7
        mljquupJwgD+VMP/RHXocJipbQ==
X-Google-Smtp-Source: ABdhPJwNlbzYvF2snPZSAkGAO2vl/mGld5g0amM9i3l7jk7w+k2UvRsVeWdXBYNJeKHXR8MS6D85HA==
X-Received: by 2002:a17:90a:6e44:: with SMTP id s4mr3579552pjm.112.1616065720004;
        Thu, 18 Mar 2021 04:08:40 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.231])
        by smtp.gmail.com with ESMTPSA id e21sm1779509pgv.74.2021.03.18.04.08.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Mar 2021 04:08:39 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v4 3/5] mm: memcontrol: change ug->dummy_page only if memcg changed
Date:   Thu, 18 Mar 2021 19:06:56 +0800
Message-Id: <20210318110658.60892-4-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210318110658.60892-1-songmuchun@bytedance.com>
References: <20210318110658.60892-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just like assignment to ug->memcg, we only need to update ug->dummy_page
if memcg changed. So move it to there. This is a very small optimization.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/memcontrol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index fc22da9805fb..104bddf21314 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6845,6 +6845,7 @@ static void uncharge_page(struct page *page, struct uncharge_gather *ug)
 			uncharge_gather_clear(ug);
 		}
 		ug->memcg = page_memcg(page);
+		ug->dummy_page = page;
 
 		/* pairs with css_put in uncharge_batch */
 		css_get(&ug->memcg->css);
@@ -6858,7 +6859,6 @@ static void uncharge_page(struct page *page, struct uncharge_gather *ug)
 	else
 		ug->pgpgout++;
 
-	ug->dummy_page = page;
 	page->memcg_data = 0;
 	css_put(&ug->memcg->css);
 }
-- 
2.11.0

