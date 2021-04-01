Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5B8F350CDE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 05:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233287AbhDADC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 23:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232565AbhDADCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 23:02:21 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB49C0613E6
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 20:02:20 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id l123so405525pfl.8
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 20:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZLLkTxJZICm9GVFNmsd9owELXRPBqC4NOmE5uFJRqG4=;
        b=enKCwWdpMvY8Czw8bFjHMoToCy2XTjo+ET4viygtctKaK+B90WkIh1QhApn7Zn9T0w
         2E5ZTTi2U9ovoF8A23fsZe6UaT2HymO5rzm4w6Cf9N7yy939Jz8/Q4MIGlN30Dr/bLih
         bjv2uFOTn6Wpuh7Xqr1DVW++ycWfjb3GHD5UUOnoerDofxpfl4vr6RevUdvh6zm+R/kI
         TgMbPjfdvA6gHZXugn5IllDKhvPBC3prdZydJP4bc7SIVn1QB2k+2EAjqtgrLf2s2kq/
         nFLHeVRpvPNhfBhbRzcKpJM/ca3Roy7/AJBXK9etp0i1TLjY9Z/18lBwDIqpnhLcw4Be
         2Yng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZLLkTxJZICm9GVFNmsd9owELXRPBqC4NOmE5uFJRqG4=;
        b=h7UQKbiXshjdErC9NxrFeRz9g4UgyFmqbewUw2+1fyVqUvWFeqN0WnBaOsGqhd+wcb
         cNhO/ADdCDqReAIskDn4MycolLCikhjxjATlEJ7aclFidfemJ1+ARWGvrP72ZHtiJ+Js
         NWwm2dDlTxkjTR+fSxY0X06QZiaFtizMzXIHYj3Sz2oURY/ns7pqOYVrGs2Bo4hgbG+K
         c7XgdHsOne5f8pyvFoIsVc4bE9iyAWHIhFpxlgJX30bu9lkWED1bFH5ZoKFSfgSIPpF7
         uVkw/3brEjnIA8ZXofrv3MAUCzuLGiTqbVuU7ZZ/LF7HH7N5I+QskQYd/nYU6dIv/L7T
         Rp6g==
X-Gm-Message-State: AOAM532D4SYDZMUszC6aaPK6ndoNwCSeIQJJ9q+hdowF5R8PBadgISG/
        KjhcqlXidUG9dTU0d2rFyGlzxA==
X-Google-Smtp-Source: ABdhPJwsiQRyF8W4DN5MDfFOYSgHyG7vMi1Ua2eBGpQONG0rQO5l2ww2a2S43YS1YhypjTrUKuzf3Q==
X-Received: by 2002:a63:cb44:: with SMTP id m4mr5760615pgi.4.1617246140366;
        Wed, 31 Mar 2021 20:02:20 -0700 (PDT)
Received: from localhost.localdomain ([2408:8445:add0:9210:fcb7:23f3:7cc:7f88])
        by smtp.gmail.com with ESMTPSA id s76sm3709134pfc.110.2021.03.31.20.02.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Mar 2021 20:02:19 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH] mm: memcontrol: fix forget to obtain the ref to objcg in split_page_memcg
Date:   Thu,  1 Apr 2021 11:01:41 +0800
Message-Id: <20210401030141.37061-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Borntraeger reported a warning about "percpu ref
(obj_cgroup_release) <= 0 (-1) after switching to atomic".
Because we forgot to obtain the reference to the objcg and
wrongly obtain the reference of memcg.

Reported-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/memcontrol.h | 6 ++++++
 mm/memcontrol.c            | 6 +++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 0e8907957227..c960fd49c3e8 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -804,6 +804,12 @@ static inline void obj_cgroup_get(struct obj_cgroup *objcg)
 	percpu_ref_get(&objcg->refcnt);
 }
 
+static inline void obj_cgroup_get_many(struct obj_cgroup *objcg,
+				       unsigned long nr)
+{
+	percpu_ref_get_many(&objcg->refcnt, nr);
+}
+
 static inline void obj_cgroup_put(struct obj_cgroup *objcg)
 {
 	percpu_ref_put(&objcg->refcnt);
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index c0b83a396299..64ada9e650a5 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3133,7 +3133,11 @@ void split_page_memcg(struct page *head, unsigned int nr)
 
 	for (i = 1; i < nr; i++)
 		head[i].memcg_data = head->memcg_data;
-	css_get_many(&memcg->css, nr - 1);
+
+	if (PageMemcgKmem(head))
+		obj_cgroup_get_many(__page_objcg(head), nr - 1);
+	else
+		css_get_many(&memcg->css, nr - 1);
 }
 
 #ifdef CONFIG_MEMCG_SWAP
-- 
2.11.0

