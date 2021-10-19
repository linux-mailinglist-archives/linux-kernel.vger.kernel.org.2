Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2EA9432F73
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 09:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234529AbhJSHcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 03:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbhJSHcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 03:32:06 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7288AC06161C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 00:29:54 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id c29so16884991pfp.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 00:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id;
        bh=vfd7MBPWblBhEd3Hxz8uuyeSEGwRnXcHNr8PPXrICm0=;
        b=hpagPFkUsa8FOypcLEmDs1wbh88Ft0/DruwIK09BQVN3bQ4noR0rXBxlOZW8DmHFZQ
         b3MjkT60YMfKmzxim2vhqj0TdhGIo1wob4BDrcMyhbGWUi0GVD9iDCk7E6dT3zoSA7Ex
         mDWmwGRnusmaa5XIAZRHKi5tTfXx/gAm0AK0kAu/eBakW5+pzqECVLu5NK7id0M12gNY
         2PcGXjrOf/OgsqCovyF+k5dr+4Gl5FAcg7CG6ESzrleGt8jn9uFRV8Mu0QKuMzR95Llt
         SDF3sR/hhnvnR8pCEZUcnVbasWenW5578jGEeNj1ow/t7mEfpwuD15xH+d4NGhGIl5nt
         ya1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=vfd7MBPWblBhEd3Hxz8uuyeSEGwRnXcHNr8PPXrICm0=;
        b=UQjMseBpab+pXxoLfE4lWWuXFqhCakEMxc2V2anCpy/3qCN/qChK0WuclhmyW9nz/q
         yb7pWjF5+0lzQB2Zh9GC3nn5uyWM+0DmFaT3lwoEttnvyDiKKguw8LLgocD0ioaMfFB4
         4L53xZgQ7s1CgY+C2BcHB01qv+c72PncVl+/WFA6fB6Z8CQqM1bVjMoZ6SGosmzcBNGr
         Q/mrVK7FNUX9HUQBKWeglUIz0qw3DGSZnchvWrhKcyMqdNw8Z8nKZsKjbJjcHNmQbexN
         0KrhpoQygPJOvrhjSD2Nkj7UNY5hyK0asNfWvhJGP/pFldObF5xQkFQzS8piHqj4gRyT
         kB6A==
X-Gm-Message-State: AOAM530rpB4u8wCAJHRWhtv5g7xVagPNYwJO3Sekz3pemXxBM0xuNrNs
        G6rDGtGjTl5ZGpN2vJ7IlF4=
X-Google-Smtp-Source: ABdhPJxC38FjB4+wdFAFEgy6+wIgbNqF69SDSFiEpOVNLV/BPBhJAohyBjKvZFE7KPC1UZbUljEzvA==
X-Received: by 2002:aa7:8198:0:b0:44b:e191:7058 with SMTP id g24-20020aa78198000000b0044be1917058mr34323872pfi.39.1634628594029;
        Tue, 19 Oct 2021 00:29:54 -0700 (PDT)
Received: from bj03382pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id u3sm15146220pfl.155.2021.10.19.00.29.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Oct 2021 00:29:53 -0700 (PDT)
From:   Huangzhaoyang <huangzhaoyang@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] mm: skip current when memcg reclaim
Date:   Tue, 19 Oct 2021 15:29:36 +0800
Message-Id: <1634628576-27448-1-git-send-email-huangzhaoyang@gmail.com>
X-Mailer: git-send-email 1.7.9.5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

Reclaiming pages from current LRU will introduce page thrashing during direct
reclaiming. Have all memory contraint groups steal pages from the processes
under root(Non-memory sensitive) or other groups with lower thresholds(high
memory tolerance) or the one totally sleeping(not busy for the time being,
borrow some pages).With regard to all groups trapping into direct reclaim,
retry if first round failed and all groups still compete fairly.

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
patch v2: grant current second chance if previous reclaiming failed
---
---
 mm/vmscan.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 5199b96..c17ef60 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2841,6 +2841,13 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
 				sc->memcg_low_skipped = 1;
 				continue;
 			}
+			/*
+			 * Don't bother current when its memcg is below low
+			 */
+			if (get_mem_cgroup_from_mm(current->mm) == memcg) {
+				sc->memcg_low_skipped = 1;
+				continue;
+			}
 			memcg_memory_event(memcg, MEMCG_LOW);
 		}
 
-- 
1.9.1

