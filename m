Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF02F39A001
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 13:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbhFCLn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 07:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbhFCLn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 07:43:57 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 474F8C06174A
        for <linux-kernel@vger.kernel.org>; Thu,  3 Jun 2021 04:41:58 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id f11so8318316lfq.4
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 04:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uged.al; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zoxuOrzcIzq8RN+/4nBQ/3k2NzacgB/FA90ZDc0iE2g=;
        b=B0B/U0Te+oqbPP7glz7wROMs2i1Yf6OIFxaf66AT+lvKHMBwMbKBNs+49GdQYtgSL2
         lmmuxPD4p/aXsOBVDMiuLF4JIeLWsLQFWUiYrxQCyY0/T/BL49JNN0hyHhqsYvY6g9I5
         yKv9tF7FsCeDqKvgCgzBATkoTHw9N97uuXLP6s9IoKXB7iGTtOPqTXJ2ZTZWHgw/NnIK
         5aSZvw9GsU3XDkKfdMIsDn7LlawJXxwFCDpNst9WieGgF/qv9zUj49JIRbcebbNVrJIQ
         GMuNIJlee2UlF/jP9qzRgQGDoVYwqeh/VZJ0IKwEDqHhecSvKvQIdEUaoTIKUWVgB9pU
         34ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zoxuOrzcIzq8RN+/4nBQ/3k2NzacgB/FA90ZDc0iE2g=;
        b=tJ4iaHfvnNbP33tr6+Tn41rPhOdPf/ZwyFe+EFIjUJcr8nphOsh0Ea0uaxlCz2s3Gr
         lcVrO7mUUmirXkiBORxmLW3N7e1F5hQ01hgz7jdxJf9sUtgZlMZA/HMYGvc2nxRBdRiO
         wtsI7Y53iSyQgY9OpGHUDy/D2cpoxyPPayCmU5ENXW4gVAg5Y7R/YkYtlNi2DgymeteZ
         TuF5sFTbz/LStEErd3BKsn1xFt6sSyF90G4krhOqxhmNbNmaydaqX1iHIx0kA0H2gPCs
         K2Yjp2VOwwCsU6thEJpbs4PEu/j4xp6FlVFpuq1NYlJnSROVZbAmvCqdm1isCH0QG9Y0
         pQSw==
X-Gm-Message-State: AOAM530F1vSExLGT7gFfDO9PrInT9O9w2KXPT7QjKf6Av1Nn9jK2yNPQ
        B9kxv3XrbwDY7B6LylFmDronXQ==
X-Google-Smtp-Source: ABdhPJyz5OLV8CIcK4HPiGR3l5v2ioTxV7ylqEAakz11SE9zOgXl2uDMFOyJEw3duhJCRIVjKNwTRQ==
X-Received: by 2002:a05:6512:2397:: with SMTP id c23mr1028542lfv.114.1622720516606;
        Thu, 03 Jun 2021 04:41:56 -0700 (PDT)
Received: from localhost.localdomain (ti0005a400-2351.bb.online.no. [80.212.254.60])
        by smtp.gmail.com with ESMTPSA id u24sm295117lfc.162.2021.06.03.04.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 04:41:56 -0700 (PDT)
From:   Odin Ugedal <odin@uged.al>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Odin Ugedal <odin@uged.al>
Subject: [PATCH v2] sched/fair: Correctly insert cfs_rq's to list on unthrottle
Date:   Thu,  3 Jun 2021 13:38:47 +0200
Message-Id: <20210603113847.163512-1-odin@uged.al>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes an issue where fairness is decreased since cfs_rq's can
end up not being decayed properly. For two sibling control groups with
the same priority, this can often lead to a load ratio of 99/1 (!!).

This happen because when a cfs_rq is throttled, all the descendant cfs_rq's
will be removed from the leaf list. When they initial cfs_rq is
unthrottled, it will currently only re add descendant cfs_rq's if they
have one or more entities enqueued. This is not a perfect heuristic.

Insted, we insert all cfs_rq's that contain one or more enqueued
entities, or contributes to the load of the task group.

Can often lead to sutiations like this for equally weighted control
groups:

$ ps u -C stress
USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root       10009 88.8  0.0   3676   100 pts/1    R+   11:04   0:13 stress --cpu 1
root       10023  3.0  0.0   3676   104 pts/1    R+   11:04   0:00 stress --cpu 1

Fixes: 31bc6aeaab1d ("sched/fair: Optimize update_blocked_averages()")
Signed-off-by: Odin Ugedal <odin@uged.al>
---

Original thread: https://lore.kernel.org/lkml/20210518125202.78658-3-odin@uged.al/
Changes since v1:
 - Replaced cfs_rq field with using tg_load_avg_contrib
 - Went from 3 to 1 pathces; one is merged and one is replaced
   by a new patchset.

 kernel/sched/fair.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 794c2cb945f8..0f1b39ca5ca8 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4719,8 +4719,11 @@ static int tg_unthrottle_up(struct task_group *tg, void *data)
 		cfs_rq->throttled_clock_task_time += rq_clock_task(rq) -
 					     cfs_rq->throttled_clock_task;
 
-		/* Add cfs_rq with already running entity in the list */
-		if (cfs_rq->nr_running >= 1)
+		/*
+		 * Add cfs_rq with tg load avg contribution or one or more
+		 * already running entities to the list
+		 */
+		if (cfs_rq->tg_load_avg_contrib || cfs_rq->nr_running)
 			list_add_leaf_cfs_rq(cfs_rq);
 	}
 
-- 
2.31.1

