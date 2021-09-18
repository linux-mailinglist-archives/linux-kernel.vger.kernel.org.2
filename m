Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25CC34108ED
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Sep 2021 01:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240763AbhIRXlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 19:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240331AbhIRXlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 19:41:05 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A123EC061574
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 16:39:41 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id e7so13529423pgk.2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 16:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NyjJPH0yWwRNiBCx2+K7AQlPL3GeoPPTkMMh4PEMJGg=;
        b=oNnwdDV9G1cuZt4+7Pv87ODBrobfZ0zDBsgGmNVG1AO9LojUUIo/S/n7RF4W2Gx59U
         bOW6rNakaOPogdOpghUbbNJ5I44v8//NpdJPRk1ewQH5E/uKu0s46gQAKoAt59npEp95
         IPLJJnLLaILUM9A4F79BPL2YRDgmUDAHHVy3lScJO+Gi+9TiDnlN7dbyOD0UTShLZCeK
         OZdIpcgXiS2NgDtSLclnu6HnX17y1eG+BtAk8JeCvNWEsuP5PfD20Ks8y4i1qSI+sDnz
         ubAycn6bjX5H/po7V1awvio29qe3PIs6alCLva4talhgC3cXsJx+Tm7AB5d3L2fzAiB2
         vg7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=NyjJPH0yWwRNiBCx2+K7AQlPL3GeoPPTkMMh4PEMJGg=;
        b=OkPzweHGhhmioiRKCjnV4hRN8CfMEqgWRkKodeMch1sVNWTHowhhSPbsqIjc8edOOQ
         GB4CeOnF+xgb9MTeeR5wdYjz7tur1W8Echg6wEV/73iJeNl1cG6xZx0iMYQT2d/n4OzQ
         WFZCJYk3RZjkxQJAljLrVmzN9z6JWSiyBpMvbbkTmgl4sEHzWmIZX+tPerkmMwTW57ju
         d7RSahI6qU6+uLpNaYUMBiyfFqilb6xbDQzU/uKnnZ+vTHIfSePHXSSNA0cj7+fSNP8J
         pqIZ9gcOEaiK9SBcfjohtb8vzzS0hdRp7ba4jokgTYQKr7UmnWa9xHWYSrDoObnYlsGm
         LIQA==
X-Gm-Message-State: AOAM5329xc4dqCr5wfqQ5PbZHLvwkUYSgbvs1bJy/9WkK4NVMI4R1O99
        ImRKZSIAIlbo49BQfV1ovAY=
X-Google-Smtp-Source: ABdhPJwEuk9elTXcN348LxGvPBO93RYvG7K5IKAKFfLVUGJGAK45o3W4b3SqKpRlCKVUzt6AeeV9uQ==
X-Received: by 2002:a62:1b07:0:b0:438:db92:6db0 with SMTP id b7-20020a621b07000000b00438db926db0mr18269679pfb.29.1632008380989;
        Sat, 18 Sep 2021 16:39:40 -0700 (PDT)
Received: from sultan-box.localdomain ([204.152.215.247])
        by smtp.gmail.com with ESMTPSA id i1sm11981696pja.26.2021.09.18.16.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Sep 2021 16:39:40 -0700 (PDT)
Sender: Sultan Alsawaf <sultan.kerneltoast@gmail.com>
From:   Sultan Alsawaf <sultan@kerneltoast.com>
X-Google-Original-From: Sultan Alsawaf
Cc:     Sultan Alsawaf <sultan@kerneltoast.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        Mel Gorman <mgorman@suse.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm: Mark the OOM reaper thread as freezable
Date:   Sat, 18 Sep 2021 16:39:20 -0700
Message-Id: <20210918233920.9174-1-sultan@kerneltoast.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sultan Alsawaf <sultan@kerneltoast.com>

The OOM reaper thread uses wait_event_freezable() without actually being
marked as freezable. Fix it by adding a set_freezable() call.

Fixes: aac453635549 ("mm, oom: introduce oom reaper")
Signed-off-by: Sultan Alsawaf <sultan@kerneltoast.com>
---
 mm/oom_kill.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 831340e7ad8b..46a742b57735 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -641,6 +641,8 @@ static void oom_reap_task(struct task_struct *tsk)
 
 static int oom_reaper(void *unused)
 {
+	set_freezable();
+
 	while (true) {
 		struct task_struct *tsk = NULL;
 
-- 
2.33.0

