Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53048439697
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 14:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233344AbhJYMsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 08:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233070AbhJYMsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 08:48:10 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F704C061745
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 05:45:48 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id o133so10628226pfg.7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 05:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qVU4cYq6gzQiQmKsTxCHNQ+nSpf6GAnmjdUQN6QjAew=;
        b=vzztuKVTgZoX81QIwkLGvlv1WgsYk0QmRVnH5mLc/5u2Kr1spSR5z9I27xdVDIiXG3
         fNT6vfvu38X3YdXuZxrfJIy/UgvgnGAx4vyVvHX6FzJYWxMRKuWPNgW7wDjJM+IB5EY7
         amkbmS55Z/th6v36lrRwWBP7437jUEAjxdRvO/d6qxli9SqrkYlmUyr+GPkvP7Ov55k2
         DRePjp3kTJSpPbSF5eQ7RhbotrLXJj1FLQ2Ewukqg56LFX2vobFYokGqmdXLm+sPTmg9
         SI6pgcdVauAgoRMocl3vJjcuasuH0v3UckttIpTlIQY7s6pDqNiHPEN6vn8byRLf191m
         tPLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qVU4cYq6gzQiQmKsTxCHNQ+nSpf6GAnmjdUQN6QjAew=;
        b=6j7GKGendJzNLDvgabeJW19b5lO/XhXwFHr6TTKTa5lobH7N9LjQA58OjPq8JzVQ3h
         UC8HPfjVA1JWRsA/fE6XADlSQy++zt01LAqYtDjG62UvTG+H+fiK0G1Xy1oW9KQ2cQZj
         bXDlX4bAaF32aa8nI5BeC4aNVjsZHORntjrYxp3bg3IH9CCijtPl51u+Z6g7Hi7azMTz
         j4jfxOo36jpOE291rzIUDzMaiYJJCtPycB+1ZkGxCXXRULlI1ygbI0Qwf8n86GtRKfLz
         2TRi4w8D5uaQWBCjqgHgeWdM3L2fOvIOZ/PjeGsmq/eCxI1YXiN2koT8ZIZnf6QrSTmB
         DIbA==
X-Gm-Message-State: AOAM530FXQOvorpHVCN15ilY3w+QLZWfaLo5BbaJI3OkXRnNZcjJFZvi
        S9flUWRWt49Kk8bj9krbs7iGWw==
X-Google-Smtp-Source: ABdhPJyvC+6RSQyWZedPqX9VfAvhYfgRoJTLWPSeHwugj/drfD5CHD3XgoZIM3/t9zh9inDlGRWvvg==
X-Received: by 2002:a62:e315:0:b0:47b:f629:6b48 with SMTP id g21-20020a62e315000000b0047bf6296b48mr3910093pfh.72.1635165948112;
        Mon, 25 Oct 2021 05:45:48 -0700 (PDT)
Received: from localhost.localdomain ([61.120.150.70])
        by smtp.gmail.com with ESMTPSA id w1sm6268989pjd.1.2021.10.25.05.45.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Oct 2021 05:45:47 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     akpm@linux-foundation.org, mhocko@kernel.org, shakeelb@google.com,
        willy@infradead.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH] mm: list_lru: remove holding lru lock
Date:   Mon, 25 Oct 2021 20:45:34 +0800
Message-Id: <20211025124534.56345-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit e5bc3af7734f ("rcu: Consolidate PREEMPT and !PREEMPT
synchronize_rcu()"), the critical section of spin lock can serve
as an RCU read-side critical section which already allows readers
that hold nlru->lock avoid taking rcu lock. So just to remove
holding lock.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/list_lru.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/mm/list_lru.c b/mm/list_lru.c
index 2bba1cd68bb3..7572f8e70b86 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -401,18 +401,7 @@ static int memcg_update_list_lru_node(struct list_lru_node *nlru,
 	}
 
 	memcpy(&new->lru, &old->lru, flex_array_size(new, lru, old_size));
-
-	/*
-	 * The locking below allows readers that hold nlru->lock avoid taking
-	 * rcu_read_lock (see list_lru_from_memcg_idx).
-	 *
-	 * Since list_lru_{add,del} may be called under an IRQ-safe lock,
-	 * we have to use IRQ-safe primitives here to avoid deadlock.
-	 */
-	spin_lock_irq(&nlru->lock);
 	rcu_assign_pointer(nlru->memcg_lrus, new);
-	spin_unlock_irq(&nlru->lock);
-
 	kvfree_rcu(old, rcu);
 	return 0;
 }
-- 
2.11.0

