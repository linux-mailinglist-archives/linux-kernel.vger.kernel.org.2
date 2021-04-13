Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D73D35D850
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 09:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245186AbhDMG5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 02:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242333AbhDMG5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 02:57:02 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28542C061574
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 23:56:43 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id i2so15393704ybl.21
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 23:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=uoN+cWnulcs+MZz6Yfoth7IiX8iwaSm44WY0GAxt+Q4=;
        b=Ky/g/4nTpvE6H1kNq4Im8vCSVqJJWgdY64updRqr3NGODL/gY7XSLNlMuXa/Yqagpg
         8h8aUIGoWcm6zgtJI5Fw5fMN+PJDxOQb+W3x0OLBhrQ+nOe/aDQ/DaNsTpFLgKXpBR7/
         Nvvw4ruE5Db9uCII9HC5YVMWkv6n0oPwKqmHcIgXqyJRfj6NX9MMyHBXVjqP883hb1k1
         Uts/76AmsciIF0vpEK2WDi/7DTKQWJN38NKXgOIJgZwI3uctZHJ221m0qvGUkZ8xVQ8M
         LJm2bY+K9olC9c50QyUPY+bxF/x11l+o56tHmajIr/WsoQoJ64e/eJ6Tpi1C0nsUQsqW
         HHBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=uoN+cWnulcs+MZz6Yfoth7IiX8iwaSm44WY0GAxt+Q4=;
        b=q4VjA6z3lTu7Y75EQkCaOUnGPrZr+a8VxIneVHg9KIy8GcVnTbV6azYx3iJlfN/mqY
         nM4GFUu6opNihX2CTE1sYviNzX90nlsf6Ip3WykacM0NVKoiD/02EGRPQvc0l3EE/8K0
         43Y8NKqjqKspr7Tjz074a8EJrkBUqhaBpFzDGZwvcg5JCb19/+tTrjWSio3YSp1gtbA+
         8OB8fTMMZlhaH5pTQWlQnQM3YN8CNJBooHERVgByq78Q7xObvheM9tjTza0hz5coErNv
         aLMQMSIT87k3f7EWq0H6qOBAaxbbR8uChrhfVLanXWxhaw/G+ZI5csPO154ctl5A0+5/
         Yc5g==
X-Gm-Message-State: AOAM5311I++jOq9dpMAS7ctzsZDbqRUOtVWfMxjhdktZjjKeusU8mSAv
        AjoVQqVxKqAzXcw+CT2fcJSxxzNjPAU=
X-Google-Smtp-Source: ABdhPJyfoyUlusz71TmeoRvttPw/GuUM1FYO9KnbxFJsUN5OFDqRz4J7wq87XkLveCWglWGJeEC6Et9cWvE=
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:d02d:cccc:9ebe:9fe9])
 (user=yuzhao job=sendgmr) by 2002:a25:bb41:: with SMTP id b1mr41562657ybk.249.1618297002301;
 Mon, 12 Apr 2021 23:56:42 -0700 (PDT)
Date:   Tue, 13 Apr 2021 00:56:18 -0600
In-Reply-To: <20210413065633.2782273-1-yuzhao@google.com>
Message-Id: <20210413065633.2782273-2-yuzhao@google.com>
Mime-Version: 1.0
References: <20210413065633.2782273-1-yuzhao@google.com>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
Subject: [PATCH v2 01/16] include/linux/memcontrol.h: do not warn in
 page_memcg_rcu() if !CONFIG_MEMCG
From:   Yu Zhao <yuzhao@google.com>
To:     linux-mm@kvack.org
Cc:     Alex Shi <alexs@kernel.org>, Andi Kleen <ak@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Benjamin Manes <ben.manes@gmail.com>,
        Dave Chinner <david@fromorbit.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Michael Larabel <michael@michaellarabel.com>,
        Michal Hocko <mhocko@suse.com>,
        Michel Lespinasse <michel@lespinasse.org>,
        Rik van Riel <riel@surriel.com>,
        Roman Gushchin <guro@fb.com>,
        Rong Chen <rong.a.chen@intel.com>,
        SeongJae Park <sjpark@amazon.de>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Yang Shi <shy828301@gmail.com>,
        Ying Huang <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        linux-kernel@vger.kernel.org, lkp@lists.01.org,
        page-reclaim@google.com, Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

page_memcg_rcu() warns on !rcu_read_lock_held() regardless of
CONFIG_MEMCG. The following code is legit, but it triggers the warning
when !CONFIG_MEMCG, since lock_page_memcg() and unlock_page_memcg()
are empty for this config.

  memcg = lock_page_memcg(page1)
    (rcu_read_lock() if CONFIG_MEMCG=y)

  do something to page1

  if (page_memcg_rcu(page2) == memcg)
    do something to page2 too as it cannot be migrated away from the
    memcg either.

  unlock_page_memcg(page1)
    (rcu_read_unlock() if CONFIG_MEMCG=y)

Locking/unlocking rcu consistently for both configs is rigorous but it
also forces unnecessary locking upon users who have no interest in
CONFIG_MEMCG.

This patch removes the assertion for !CONFIG_MEMCG, because
page_memcg_rcu() has a few callers and there are no concerns regarding
their correctness at the moment.

Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 include/linux/memcontrol.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 0c04d39a7967..f13dc02cf277 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1077,7 +1077,6 @@ static inline struct mem_cgroup *page_memcg(struct page *page)
 
 static inline struct mem_cgroup *page_memcg_rcu(struct page *page)
 {
-	WARN_ON_ONCE(!rcu_read_lock_held());
 	return NULL;
 }
 
-- 
2.31.1.295.g9ea45b61b8-goog

