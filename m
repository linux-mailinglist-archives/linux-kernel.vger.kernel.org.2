Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E575F35D864
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 09:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345184AbhDMG6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 02:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345173AbhDMG5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 02:57:54 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3680DC06175F
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 23:57:35 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id w10so11254517pgh.5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 23:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2UpyAPB0Z1vGr+5ZeVG7Jw1Em7aAxeW8HQK/+uDaVf4=;
        b=fn7DIidcNmD5207bnTZRh35LakOgRV8JIO4WuGAk36Ya1e2baCtWwnwVZNTjMZm03V
         m6rOvJi/kec/3sMvKqLBUp0scbT9l0m/EjvKPn+RXXOKgyo6lqeypErSwo+mY8r3FXB/
         JqT3Iq3F7wvRf0drwi29KfIJ7uZEPnkE2mHmPk81b/Swt2WAfVqterbwt5J2AH7JUO2/
         M9/3bXEukAGC1oxS7gzwPSmbQPyJZ+avI9qf+DTbDPZfrdZCite2SAF4aHAIIl5vKn7l
         sIcWOYdHtFs8TM3WGglvjnXvJmHC3IQ/EDK5bF2HaNh3L5kBX+ZUoX15wdyWkTByeVWR
         67yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2UpyAPB0Z1vGr+5ZeVG7Jw1Em7aAxeW8HQK/+uDaVf4=;
        b=fJhWuI7uCQFnJ6d2nFmemg4aYEqBqJI8VdyZcDI65VnflMU23tBBH8mss1BAhLzvvw
         FzFxL+H2km+v+2GSJ1LokHxbQ3VdAQk4pbTGUWZswmUGf4HbplSMbstLxmoLZzISouAA
         Dco8fJ5+dDuWeEk9hxbN9Yieb7aO2FkUXGuymKJJJ1Tb2PBly/gLegGs21IG9J1bjR0Z
         tos46euof0fqYDxE9lUjOu7w5XvLx0FF2SRdhv4TnzTm/47B81O3sh6GaGmYWxwW7f9l
         wWUnbzGpg2AwTbTvDCyr8ByFodJ/DviBYOAc0Ga49EGu4LJB2+y0yjxV5plZ13D2xvyu
         Crag==
X-Gm-Message-State: AOAM533nZl7/DjZHZQ9PxhJIRDUpjuzVJFYEXZRSAFZNoWHZ1IS0SO4z
        1TyQaEpPLlhg9naCoNapGb9uFA==
X-Google-Smtp-Source: ABdhPJzgHHpH76YHxZA8mGqBpbYnWexR591eqTLIZJPCcqOJJTGGhKTVTCQjKTydD9XCXGuD1YPWBw==
X-Received: by 2002:a63:e712:: with SMTP id b18mr26868252pgi.2.1618297054573;
        Mon, 12 Apr 2021 23:57:34 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.241])
        by smtp.gmail.com with ESMTPSA id 78sm11508562pfu.40.2021.04.12.23.57.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Apr 2021 23:57:34 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 0/7] memcontrol code cleanup and simplification
Date:   Tue, 13 Apr 2021 14:51:46 +0800
Message-Id: <20210413065153.63431-1-songmuchun@bytedance.com>
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

Muchun Song (7):
  mm: memcontrol: fix page charging in page replacement
  mm: memcontrol: bail out early when !mm in get_mem_cgroup_from_mm
  mm: memcontrol: remove the pgdata parameter of mem_cgroup_page_lruvec
  mm: memcontrol: simplify lruvec_holds_page_lru_lock
  mm: memcontrol: simplify the logic of objcg pinning memcg
  mm: memcontrol: move obj_cgroup_uncharge_pages() out of css_set_lock
  mm: vmscan: remove noinline_for_stack

 include/linux/memcontrol.h | 39 +++++++++--------------------
 mm/compaction.c            |  2 +-
 mm/memcontrol.c            | 61 ++++++++++++++++++++--------------------------
 mm/swap.c                  |  2 +-
 mm/vmscan.c                |  6 ++---
 mm/workingset.c            |  2 +-
 6 files changed, 43 insertions(+), 69 deletions(-)

-- 
2.11.0

