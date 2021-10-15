Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 786B442E8C0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 08:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232377AbhJOGR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 02:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232308AbhJOGRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 02:17:54 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A2DDC061570
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 23:15:48 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id f11so3625125pfc.12
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 23:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id;
        bh=Xt+EtCeoNArQpSpBl66rnuBSnoc3jprqMsF8x7P8yrE=;
        b=g3JD1trlBvR6kaqIdTE4CNw3T26PTdw1D3d5EbHGPJkPrvkEFC3slZsFmi2PNm/kPn
         SBHopm0Lp8Si6bebHVabQtIasLQYa4UpLMuZ/K9BHgdmLa4+lp1W1hvQXcG5w5XvRIf8
         v9aC7V5SEEtHNoMu8cevOWdwqBCBCWLbW4wNQBzIs9r+ZNp8o6QMVI4UGKaZrAn2rVb0
         960tfPst+KO2BiO55qjkSpIwuLSH4Re0MOJIRbUSiqukVVvYp39GehhtfIUiLn2i13bF
         APD6BANii8ovoy2c1fbYuCshS2k/z4FROQBuRTkDAx8IR6v4EjXc0Pen2uii+u9GCmvM
         DRWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=Xt+EtCeoNArQpSpBl66rnuBSnoc3jprqMsF8x7P8yrE=;
        b=uqb74To9ksIEKwSGuJxzITrAbroAK6qkwP0dqN220Z+AySyllcVfyJLex/NP9EAi1b
         Qh8ddM972izhEPHZOHp7UR2YjarY62fY5vzXVQS5fTU6+r/h6huu1f4nuw6TIEVeDU2n
         oq7/Bn8xrO56ObH+jJP3uigz8BsNPvQQGeYmXKQzzYkzqKxGJ3/VK/VYVkMMjib4VcNQ
         CXg72jD+c/tMr3l/NPGmKG8/sG6lSbW1Fd1y2aAxrNgSr02XIKVcDGJNOkI9D8WZsquh
         shUyVACcHFhFYkNrD88J4SLZNLt/9JZejKirgsKoavlSwHy57q3IgUhwDItpU10k5fcn
         EEQA==
X-Gm-Message-State: AOAM532awPBAjZZJ+Qw6eLRAd1bdczCmySPbPI5NdlPdAEsjZNSY5NC9
        k2wyM3d/teFGIBIQkKDjdeI=
X-Google-Smtp-Source: ABdhPJwA8WcuNRh9h6zTX9Z9hP9sts6fgUyg5NjHaYhqTs5I7Pkg+of30UMxjvnIdGQzWVOLo5TxfQ==
X-Received: by 2002:a62:ea04:0:b0:44c:7370:e6d8 with SMTP id t4-20020a62ea04000000b0044c7370e6d8mr9989325pfh.18.1634278547733;
        Thu, 14 Oct 2021 23:15:47 -0700 (PDT)
Received: from bj03382pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id e24sm4045245pfn.8.2021.10.14.23.15.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Oct 2021 23:15:47 -0700 (PDT)
From:   Huangzhaoyang <huangzhaoyang@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm: skip current when memcg reclaim
Date:   Fri, 15 Oct 2021 14:15:29 +0800
Message-Id: <1634278529-16983-1-git-send-email-huangzhaoyang@gmail.com>
X-Mailer: git-send-email 1.7.9.5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

Sibling thread of the same process could refault the reclaimed pages
in the same time, which would be typical in None global reclaim and
introduce thrashing.
---
 mm/vmscan.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 5199b96..ebbdc37 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2841,6 +2841,11 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
 				sc->memcg_low_skipped = 1;
 				continue;
 			}
+			/*
+			 * Don't bother current when its memcg is below low
+			 */
+			if (get_mem_cgroup_from_mm(current->mm) == memcg)
+				continue;
 			memcg_memory_event(memcg, MEMCG_LOW);
 		}
 
-- 
1.9.1

