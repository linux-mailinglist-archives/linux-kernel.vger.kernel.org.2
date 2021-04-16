Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 540E636191F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 07:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238558AbhDPFQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 01:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231997AbhDPFQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 01:16:09 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A28C061574
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 22:15:45 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id g35so18411949pgg.9
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 22:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8k6YXYK85mvc31ajI7k2coqgwaOfr7Ej3V6vhYCGVRI=;
        b=efWsErrRy6Y+q7AbkIPIOy5Upya1t/n2SZE33fPb3OfiCt8/AoLJQ8+y3xKWrG3giU
         /ufhSnUuwyEPh9AXrW1YrV1mDst07Js6C7JCixrgEMisbo+cOfQEAS3csT9k4iKIxQxB
         MlQ92g9HdhU7uf7ItfpepWKimxH+L7RVtrvC4bbC9xr+PAgkSgdVvMna7FXQ2CtBuOar
         hRpDe7r7VPNd/d4DlGDeGMwhHK+jpovUERNHZtSxPOu4z1WWMgp2J5DDsMQZ2XuL+PLs
         r45bBJPkpvHKzN+U+a6SsByLwC/ijypTht26AWuoHyInoGpG/6fG3hlXiq77OGnPtmUt
         raNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8k6YXYK85mvc31ajI7k2coqgwaOfr7Ej3V6vhYCGVRI=;
        b=fUldpvvjyn1jpFhOYUf3bR8rv9ireb0UtzKC1wk8OcknFavfD2sEtf3cgyD9kLQdm6
         YBI5Y+W97k34A5lU6VZrS8XnrjLLxcie/Au56KSKTOU2oPs9M0dy1pthvl7kGuWDAod5
         tf5zg93I5jQ4xGqvgYwrgWIom17q1rg9ErYPqRq9sKqRaz5A1WbFtqlSYJ+mvW0P3+86
         u8nfv6tMeldH3s3nc9GkjDHZeK2tQgRbf4JMg6PcDPV0XVkULVDEta9zZStMeTJOcTzr
         NViD4Pn24twZsu+PKV+kBOIlMLYR+9JP+f79BS/0z6E/o1wQcgYiLyoNhqmKCJNN2Fss
         DI1g==
X-Gm-Message-State: AOAM530h6QPKQ8FQ10gR0ghuzI5ypCrXKQdOKrXiCKwDDu2F+92osf7o
        wti4LXxKyS0N2HSnujMddkVL4A==
X-Google-Smtp-Source: ABdhPJypRzf2gPZt+cnsgCnfpajGcfQTSzsxaz5LpZts4H35QQ/kLfNwffTKJXeXBHRxNEagMZVCfQ==
X-Received: by 2002:a63:5857:: with SMTP id i23mr6629207pgm.152.1618550144354;
        Thu, 15 Apr 2021 22:15:44 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.235])
        by smtp.gmail.com with ESMTPSA id j7sm3518540pfd.129.2021.04.15.22.15.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Apr 2021 22:15:44 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@suse.com>
Subject: [PATCH v2 1/8] mm: memcontrol: fix page charging in page replacement
Date:   Fri, 16 Apr 2021 13:14:00 +0800
Message-Id: <20210416051407.54878-2-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210416051407.54878-1-songmuchun@bytedance.com>
References: <20210416051407.54878-1-songmuchun@bytedance.com>
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

