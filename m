Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8819635D865
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 09:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245308AbhDMG6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 02:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345172AbhDMG6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 02:58:19 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 933E3C061346
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 23:57:39 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id t22so7362749ply.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 23:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Nm2qLQR55IXL2VTvCCbc055js3zSget/PmvTRGcIhzI=;
        b=SYDc5NQqBBJ4brJ6Ss8Q9ZO0pgg43LtamF9vVa3EBuNPT/+gjwy/G/AyELJxGFwXAZ
         P8ZoSUANNh/NKhe0oVZet49FfHqNcp3lSalETQA3VvfLMOShFa/dNhJizgaodB3smwlT
         Yp0bD/F0tizefNn6OwzwrwfvOKsY545GxAw+69nhxUzKyXCjumko+Dr+0tfMGL/AHFm+
         eeezTgw0hdZDv3842+nD+mZSyZJGiEWp3N3/1EWr2KpISZnXDOXScBZPXtLo0YuMX3SE
         1ZIytNcS8hN5jQODYw5YG0fSX/sSRYtMYIAWvqZZcRzY6M5WBlNHjibnjzEatgSzUUus
         Wqbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Nm2qLQR55IXL2VTvCCbc055js3zSget/PmvTRGcIhzI=;
        b=GWic0Wu0V54Ov/kmQj33RQC4SsNEKE4ryaI+Xvt4niGYH88aKJHHXTT1Kjg5Xj0MXD
         F3lQYkFapmOZG6k5oqnN4TINiLaNKo4inGlPyIwa0ExZ94m5Zdg6io9pRQb0Te9l2n8u
         z2NceISfTCs+rVDirz8a7fm7RJHikl6n0dChJ9v2O21RrQf2lu1qcDTzSsLWLYecxH24
         q0ucO9nfEdF1b/mMHRblhmH0RREhxXg3VSsc8wZgJr64N140Yvoys3F8PKGN3MXbZHwz
         HqYLZHwg/i6JITFwrwMYdbOyYXUDtWlBqbBuV80noT4MOvS6nQ49xRbd2wXDEeWJFGIz
         r6oA==
X-Gm-Message-State: AOAM532BGQc3KuBQTJQWLHWHoRGteqoo26jUb5w+KosV/loo8K1RzPwv
        16YZ4E25zc/pbXvlZihz39c56Q==
X-Google-Smtp-Source: ABdhPJzLAqcpFJPdGm9ND1hLM45nc0Xm5wg7mCzjWEcmGLjSKdPWnXxuyar0Nueum0yIyWvj2cuUbg==
X-Received: by 2002:a17:902:8e89:b029:e9:a576:886e with SMTP id bg9-20020a1709028e89b02900e9a576886emr22954128plb.65.1618297059217;
        Mon, 12 Apr 2021 23:57:39 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.241])
        by smtp.gmail.com with ESMTPSA id 78sm11508562pfu.40.2021.04.12.23.57.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Apr 2021 23:57:38 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 1/7] mm: memcontrol: fix page charging in page replacement
Date:   Tue, 13 Apr 2021 14:51:47 +0800
Message-Id: <20210413065153.63431-2-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210413065153.63431-1-songmuchun@bytedance.com>
References: <20210413065153.63431-1-songmuchun@bytedance.com>
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

