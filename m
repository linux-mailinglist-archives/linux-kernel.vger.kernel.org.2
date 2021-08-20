Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 703513F244D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 03:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237439AbhHTBFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 21:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237579AbhHTBFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 21:05:14 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7357BC0613D9
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 18:04:37 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id s4-20020a259004000000b005947575ac53so8408052ybl.5
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 18:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=5ZSzDmZf9Lp/Z5C3yKlFbAaN/ZWlBsBW09PXv4v1as4=;
        b=IkqB1nRlRi+AqC600zP1g+vW12uwhGNK0Ps5se66FABH2EZ5am53LggtLR9EL2aQw0
         YFHJOlxjWyKU8oV8ftsV9GjMydjOZ7uknf4mtSGyb4/WwgzUMa4tQRclEC2rPUpZZN52
         kYNPZA3tV2KwkpEMtWEMZ8yX3l9xdaWEMh8KTsMEGtqJN//gxaJk6++KRTCL6248fKQF
         V07RFG4Diy58PlOQbAxmc7TM7UEUmU0uhBNj3OuDUliOLurQGY6GbQ0mbx31sgJeQes4
         9PqZ6RpaHB58eF/2qkUpbtGLNxCfqNyVT3yHRuK6b8FTOB7kZbEcuJ/oGgfx0iHpm26q
         4i+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5ZSzDmZf9Lp/Z5C3yKlFbAaN/ZWlBsBW09PXv4v1as4=;
        b=H0VD3KSDFgQzT4Otm+o9+szqC+J8iyWmze0ZyrMlT3tfw7xjbXXyrPfT89XjT/eixE
         MUjd7UVKBA39Nf2dGuo80pDEWtbcer3kDGXI7RDhRxwITfqz46fENyMHRyESaan6yqbV
         BP2C6Q0Vz6Kh2cDptsjNH0ll4jvXOLMPTCTXF9sC7jLaIK7SlBS4PNxJnvmXzeOkB8A4
         1jfO/13ct9UTnWn28m2S7Mp0/jOM/tvXT6XfTHVC9ThIaB6lFXKUMahY7J1iA5mHpMxt
         Rd9zswvryogWRhLiFx8XlnkzfsH3hQvK5zaVWUrvR17sK7lxF4sQS2LtO9stSPej7CMD
         UYqw==
X-Gm-Message-State: AOAM531j6laR4vTfe2dPvudsyw5GROAcR5qToXrV558eu/eZieRfcbWV
        6fui0529WeS5TNv5/nG5UgOG+LHJaHkL
X-Google-Smtp-Source: ABdhPJySkHLpJCRw49AswoJ3teo3iM1bCyoxqekeVYTp/Qmod+vsebUdyULCZ2QOqMtDxIpxBj7u8GBFJBV+
X-Received: from joshdon.svl.corp.google.com ([2620:15c:2cd:202:23c6:59ba:fc84:7672])
 (user=joshdon job=sendgmr) by 2002:a25:f80a:: with SMTP id
 u10mr22267696ybd.391.1629421476693; Thu, 19 Aug 2021 18:04:36 -0700 (PDT)
Date:   Thu, 19 Aug 2021 18:04:03 -0700
In-Reply-To: <20210820010403.946838-1-joshdon@google.com>
Message-Id: <20210820010403.946838-5-joshdon@google.com>
Mime-Version: 1.0
References: <20210820010403.946838-1-joshdon@google.com>
X-Mailer: git-send-email 2.33.0.rc2.250.ged5fa647cd-goog
Subject: [PATCH v3 4/4] sched: adjust sleeper credit for SCHED_IDLE entities
From:   Josh Don <joshdon@google.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Paul Turner <pjt@google.com>,
        Oleg Rombakh <olegrom@google.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Steve Sistare <steven.sistare@oracle.com>,
        Tejun Heo <tj@kernel.org>, Rik van Riel <riel@surriel.com>,
        linux-kernel@vger.kernel.org, Josh Don <joshdon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Give reduced sleeper credit to SCHED_IDLE entities. As a result, woken
SCHED_IDLE entities will take longer to preempt normal entities.

The benefit of this change is to make it less likely that a newly woken
SCHED_IDLE entity will preempt a short-running normal entity before it
blocks.

We still give a small sleeper credit to SCHED_IDLE entities, so that
idle<->idle competition retains some fairness.

Example: With HZ=1000, spawned four threads affined to one cpu, one of
which was set to SCHED_IDLE. Without this patch, wakeup latency for the
SCHED_IDLE thread was ~1-2ms, with the patch the wakeup latency was
~5ms.

Signed-off-by: Josh Don <joshdon@google.com>
---
 kernel/sched/fair.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 31f40aa005b9..aa9c046d2aab 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4230,7 +4230,12 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial)
 
 	/* sleeps up to a single latency don't count. */
 	if (!initial) {
-		unsigned long thresh = sysctl_sched_latency;
+		unsigned long thresh;
+
+		if (se_is_idle(se))
+			thresh = sysctl_sched_min_granularity;
+		else
+			thresh = sysctl_sched_latency;
 
 		/*
 		 * Halve their sleep time's effect, to allow
-- 
2.33.0.rc2.250.ged5fa647cd-goog

