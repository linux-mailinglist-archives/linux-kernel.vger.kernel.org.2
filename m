Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D774C36191E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 07:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238486AbhDPFQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 01:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231997AbhDPFQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 01:16:04 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F94C061574
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 22:15:40 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id w8so14110620pfn.9
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 22:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UDpdshztz/2za17iaVnTMNTApawNDUT2Y5nH58k+LE0=;
        b=L0XpDiazBY76m/j/SY5ERWYder6J8VlKI1V4q/3+aOfIYJqUU3hZO5SlYHruNk9LAL
         EO0RAf2Pyxu+gFvkulTzU2kCtCYMUCG0wz53x+KLTxxrUWH5EgZmJ6SUFfHRsfU+CbFO
         mls2vEERCjgB5R8wcEWZ2yFFqxXPVptXcmGEvNGuyxB3Q8tCmYE3YnR8oZZsVWn8Te5F
         BC8CF1vlV5/d7wERxqO8gbFmKLAnY6NiflSdwKtEBS99AGNvECcSy371g83i9I+DfxE8
         RBNIDNM2IAlLdP0fQaLQ7jCLuyZABMhTGtbKPJkyOa4bFQ3kfEqwLOooacg5FWcRXLQS
         iV7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UDpdshztz/2za17iaVnTMNTApawNDUT2Y5nH58k+LE0=;
        b=fEIslr6noWEqrWSbt8jyM77XZsyr65DZNuAvRLoMaJnNrJ17th1q/+lvlCX3dksz4U
         GYU3dZXxJyALZVY2T32X1OhU2xuPe+9TMLxZtNsRfcg1t/miypOdI6jTV0gRqYQDHuJN
         HOvoQd4v2QD4K4IX3ae28+4Iqu4kMQDMr5sgz1lwROeCbfrPBwQ8D6UsURckTTpVkr83
         1BC6or2y7Zf7LdkpQh6BbOg50cuUDzDxlzV4NVLs4oLw275/Kmyk3paOtw8dOnVRDuYF
         YdsuQ+zOHAObB8M3uHGd1gnAP1Tskmpj7ARB2J/0CF+CtcQNIRm3ZgEt2nKtd2lPUYM2
         Tpow==
X-Gm-Message-State: AOAM533MiNung9NS8aVAfsf2jHiaSxP7hwc+LU1tl+3w9ihVkbz7hbh/
        th2pZ1gsOyUuTNAcOAXXacAC9A==
X-Google-Smtp-Source: ABdhPJx0WZ4jvMVJjrJxdOih7nJyBY/sYo+21tABOyfUNAnGGAU4mTwihrl8Qf8jMEa3+J5D7qRszQ==
X-Received: by 2002:a62:dd41:0:b029:24c:27a4:48f1 with SMTP id w62-20020a62dd410000b029024c27a448f1mr6429029pff.42.1618550139664;
        Thu, 15 Apr 2021 22:15:39 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.235])
        by smtp.gmail.com with ESMTPSA id j7sm3518540pfd.129.2021.04.15.22.15.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Apr 2021 22:15:39 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2 0/8] memcontrol code cleanup and simplification
Date:   Fri, 16 Apr 2021 13:13:59 +0800
Message-Id: <20210416051407.54878-1-songmuchun@bytedance.com>
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

 include/linux/memcontrol.h | 42 +++++++++---------------------
 mm/compaction.c            |  2 +-
 mm/memcontrol.c            | 65 +++++++++++++++++++++-------------------------
 mm/swap.c                  |  2 +-
 mm/vmscan.c                |  8 +++---
 mm/workingset.c            |  2 +-
 6 files changed, 49 insertions(+), 72 deletions(-)

-- 
2.11.0

