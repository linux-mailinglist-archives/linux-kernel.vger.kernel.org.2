Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41D95362DB4
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 06:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbhDQEiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Apr 2021 00:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbhDQEiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 00:38:24 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C0E5C061574
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 21:37:57 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id k23-20020a17090a5917b02901043e35ad4aso17468832pji.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 21:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E5ofI2S0aai/KdG416W18c7tdk8//D5KVJSZm4FAE8o=;
        b=P1reKspW/4bYVlcZPReWmQsuKpwtWuULRlwnZXdbfX8KaDLPxmDwXt8SCSo+bYN5jQ
         dzDyC/InElP1r0nmnAEoXqFxX920crb5sS6WgZk3a0Sfy0GirZnpqgrulOoQrUhEY/lG
         YmQ/swpyD+URrXFtHL5F1rL0goMzWXypgwnAap0idYlloZY1fQa9oa/66arnPQCiESmA
         bhIRLQanbk/iFTQ4ueqh8L1Er8Y5FxFO5twuMeYYfu/OjeeHX/KTXc7KELJCvWInKAnY
         Tl/lDxrK9LMbWausoj+JCSzNFCcXHCtJ2hoYr4rQG6F+rlNAo/ZvnivYo8g46f5w2SZ7
         bC9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E5ofI2S0aai/KdG416W18c7tdk8//D5KVJSZm4FAE8o=;
        b=NpyLRALL74k4KPOwaeW8JBkVh3lJhEUw8wq5Htmf35cEYho2Njca/WTjwXxIzfjXLi
         lYzMWHiGuzpmlcxb0Xy4mqHPFrw35jx9ryLNmZitpGk40LPGA/4VKmz5Vo7hpq8CNBqB
         ZoKUeJs7CvZMlaVLnlY9iA8XgD69Q15bxzIq3wcYktc7VlICtGx047I0QCONOSMUtuE9
         p1fOzgxj7SNfQqk+SpE8F7SqvRc2K1MUWkKJ4h3i7/lcEHEXRgEIAar49KF6ORPusrHt
         SzEwiuvwC95yn4a09vCDw8oAOT0H72hJBEceCzZXb70KY9IjMOsG1Qh7B0/fzOJvC1Yu
         vYUw==
X-Gm-Message-State: AOAM532M8NJkpBy/el1AJoFPR1OzJaHfvvTaXofyfI0ntgmnv3U+SOpM
        4cK4hUdueFPBQ37EgfvHYQCsBA==
X-Google-Smtp-Source: ABdhPJyKYGViUSs/doNhFPK3fvI0+zjrN24GVxEnmRyyGBlHXkjTE5WdOW7xjxOXDoS6kkQVkoDh/w==
X-Received: by 2002:a17:902:7594:b029:e8:c21b:76aa with SMTP id j20-20020a1709027594b02900e8c21b76aamr12698555pll.37.1618634276750;
        Fri, 16 Apr 2021 21:37:56 -0700 (PDT)
Received: from localhost.bytedance.net ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id w21sm7064775pjy.21.2021.04.16.21.37.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Apr 2021 21:37:56 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3 0/8] memcontrol code cleanup and simplification
Date:   Sat, 17 Apr 2021 12:35:30 +0800
Message-Id: <20210417043538.9793-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series is part of [1] patch series. Because those patches are
code cleanup or simplification. I gather those patches into a separate
series to make it easier to review.

[1] https://lore.kernel.org/linux-mm/20210409122959.82264-1-songmuchun@bytedance.com/

Changlogs in v3:
  1. Collect Acked-by and Review-by tags.
  2. Add a comment to patch 5 (suggested by Johannes).

  Thanks to Johannes, Shakeel and Michal's review.

Changlogs in v2:
  1. Collect Acked-by and Review-by tags.
  2. Add a new patch to rename lruvec_holds_page_lru_lock to page_matches_lruvec.
  3. Add a comment to patch 2.

  Thanks to Roman, Johannes, Shakeel and Michal's review.

Muchun Song (8):
  mm: memcontrol: fix page charging in page replacement
  mm: memcontrol: bail out early when !mm in get_mem_cgroup_from_mm
  mm: memcontrol: remove the pgdata parameter of mem_cgroup_page_lruvec
  mm: memcontrol: simplify lruvec_holds_page_lru_lock
  mm: memcontrol: rename lruvec_holds_page_lru_lock to
    page_matches_lruvec
  mm: memcontrol: simplify the logic of objcg pinning memcg
  mm: memcontrol: move obj_cgroup_uncharge_pages() out of css_set_lock
  mm: vmscan: remove noinline_for_stack

 include/linux/memcontrol.h | 43 ++++++++++--------------------
 mm/compaction.c            |  2 +-
 mm/memcontrol.c            | 65 +++++++++++++++++++++-------------------------
 mm/swap.c                  |  2 +-
 mm/vmscan.c                |  8 +++---
 mm/workingset.c            |  2 +-
 6 files changed, 50 insertions(+), 72 deletions(-)

-- 
2.11.0

