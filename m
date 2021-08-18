Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8147B3EF709
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 02:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236105AbhHRA5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 20:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234789AbhHRA5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 20:57:03 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0864EC061764
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 17:56:30 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id y185-20020a3764c20000b02903d2c78226ceso593372qkb.6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 17:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=kPhI44KGUm7/8eTG3gY7/tZXObx8TawisVJaeXRWoBI=;
        b=tpLYcVsKnU/TlaQgjIZeDx43Brjgw8Ld3uV8bjbsqHjo5HJjjJxIjuVvPH5j9HAHr3
         UTyMNG96+Fu10AxK2l5kFPXDJ78FxtG0F3jJJfWSrItdMA6g82/N187s7hPbpyr1igDn
         v8wSl6VBunCCEgBgwghc74+icMtW633p1mYcWuQVHfPUGbnC+MBZcJnaF2NGIZkWVco8
         P8fev9SpUEx17b5kIqaoGNBcLF7nxEtbuJX7BsggwBasOiyphArB/2gTLzIod031m41u
         DFH1j/aR9B4iwVooopPm4S699wKe1HYP1v4i+18QWt+veXtjxGnaHsixca01Ipzu7JVn
         e6Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=kPhI44KGUm7/8eTG3gY7/tZXObx8TawisVJaeXRWoBI=;
        b=czCX29N9kprwgeDPCTQeFVnJShl5sBX9eo4WgMelo7VyqB27zYOg+TybKYSdnMkIdi
         NTaamIKGE3TOEAECstIcF8XmoeJm4uryvaIMez4Eh22ajXeG4xzdJoJWTstoEE41OOCP
         HFIssDfgFqNtEzrJXWvH6BIr3E+oKmPTd0XvjDWG/hkQocwXqRDwWp6oVpYVOsSOGB4U
         TxteoB5OItFxkGAhceFPQtWiSjJzgo4ShzvQcfI4LGUYs3RfWCpt+Pcd7Yt1qMo/vFhb
         kHeqwsGEk8aOhBWTkxDr2vNlq2Q1EtWWEDqb0PMOzmTgLFoUVh3y/vuTxvD3UYbo/keg
         Hy7Q==
X-Gm-Message-State: AOAM530tA8JzoHVMJTX0Ee1MjW6UdtK3jzdy15qYENbKp28lWzW6Ue0f
        y9NUeRvR4tf/z6nIHMTkXSYVOFf29CRR
X-Google-Smtp-Source: ABdhPJzz4M5uqSoMBiNAb4Xed3nDt798o4wni9jd/NBPDxVzIcctsQ1Gq/ljco5hvrrG9Xy19hMh+MNw6SZp
X-Received: from joshdon.svl.corp.google.com ([2620:15c:2cd:202:2f5f:84e3:5bc7:d6a0])
 (user=joshdon job=sendgmr) by 2002:a05:6214:1c47:: with SMTP id
 if7mr6334685qvb.6.1629248189161; Tue, 17 Aug 2021 17:56:29 -0700 (PDT)
Date:   Tue, 17 Aug 2021 17:56:15 -0700
Message-Id: <20210818005615.138527-1-joshdon@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [PATCH] sched/core: fix pick_next_task 'max' tracking
From:   Josh Don <joshdon@google.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Vineeth Pillai <vineethrp@gmail.com>,
        linux-kernel@vger.kernel.org, Josh Don <joshdon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For core-sched, pick_next_task will update the 'max' task if there is a
cookie mismatch (since in this case the new task must be of higher
priority than the current max). However, we fail to update 'max' if
we've found a task with a matching cookie and higher priority than
'max'.

This can result in extra iterations on SMT-X machines, where X > 2.

As an example, on a machine with SMT=3, on core 0, SMT-0 might pick
the following, in order:

- SMT-0: p1, with cookie A, and priority 10 (max = p1)
- SMT-1: p2, with cookie A, and priority 30 (max not updated here)
- SMT-2: p3, with cookie B, and priority 20 (max = p2)
	> invalidate the other picks and retry

Here, we should have instead updated 'max' when picking for SMT-1. Note
that this code would eventually have righted itself, since the retry
loop would re-pick p2, and update 'max' accordingly. However, this patch
avoids the extra round-trip.

Signed-off-by: Josh Don <joshdon@google.com>
---
 kernel/sched/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 3431939699dc..110ea7582a33 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5623,6 +5623,8 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 					occ = 1;
 					goto again;
 				}
+			} else if (prio_less(max, p, fi_before)) {
+				max = p;
 			}
 		}
 	}
-- 
2.33.0.rc1.237.g0d66db33f3-goog

