Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83BFD312018
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 21:50:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbhBFUu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 15:50:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36443 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229536AbhBFUu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 15:50:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612644540;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=PCFKnTq1WWQXV4SZe1NEa1HYcBgQPqnFAnL0fpGrWIU=;
        b=G+m5vAXpmuwRQmgXBPojdCB81xtfHNFqVT7vAl8aE9nIRrA0gJdsKWIf4Ljbu+1DqRuApY
        /r72i82UqG4R5GrOU/ku1FkVWgQ9Zxu3tCsoxB194+LwfVtiSc5ogVDtYJd9IQnzd2NZtp
        +2tPMWre4t51w/kDnLWNsWiX+Xes6Ao=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-PxN6ZVUaOoOuhIzZtpB8Vw-1; Sat, 06 Feb 2021 15:48:59 -0500
X-MC-Unique: PxN6ZVUaOoOuhIzZtpB8Vw-1
Received: by mail-qk1-f198.google.com with SMTP id d194so8941737qke.3
        for <linux-kernel@vger.kernel.org>; Sat, 06 Feb 2021 12:48:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PCFKnTq1WWQXV4SZe1NEa1HYcBgQPqnFAnL0fpGrWIU=;
        b=O3v4NZ7Ju5cSbQ5gs8vmYuB8mhudT3F0n7sb8ljc0KtTGrwRSIAzHWgUkhXHn5/yv3
         YmL7WBA4nahuklWns6i9X0UFCtNE9NWwogkYofAYTcXIHjc+KmfJDSWgX5l0L8j6YWwq
         Gd9HM3u1bgKo4NZOEV2Uh+8jEyM4ljowSv2XxNRVITV2iONEG48VgUWEgOyZAmZuHaOp
         hTO1B8GArOCnna+kjOjlsRgENFs32mPOFlB49kN1z8ymrkPICJfXYkUGBJodACb8siDG
         iyx6122tTTzOV0vJUKuw1wGRYKV9zSPHi/z8FTz3gvUcSOMff1EocJeeuRU+W26C9Pp6
         Kn/A==
X-Gm-Message-State: AOAM530fl5y6Pk0VGF3rCaQD0nNLvIaNy28wTKBuC8kw6XOe/EcGPT8w
        /mrfOEiQbKCObB+JB5/eNCQEUozU871uFPyZoYOt4gvPYvFA9gtSiC8FSoD1b8/0a20J0zNQWbG
        ubH1fjfWK7ZekKKvIkWdYZ0Gv
X-Received: by 2002:a37:9e8a:: with SMTP id h132mr10472962qke.119.1612644538671;
        Sat, 06 Feb 2021 12:48:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz4ABoSm8MNhG2j0XpoBzjmwQleeKZNw2SbtFiIORMN8j9rCWlkjgD5g9YL3M3NMQk92wimMw==
X-Received: by 2002:a37:9e8a:: with SMTP id h132mr10472949qke.119.1612644538460;
        Sat, 06 Feb 2021 12:48:58 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id j125sm12880330qke.56.2021.02.06.12.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Feb 2021 12:48:57 -0800 (PST)
From:   trix@redhat.com
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] sched/deadline: fix BUG_ON() ENQUEUE_REPLENISH check
Date:   Sat,  6 Feb 2021 12:48:51 -0800
Message-Id: <20210206204851.3673588-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

When the BUG_ON check for (flags != ENQUEUE_REPLENISH) was created, the
flag was set to ENQUEUE_REPLENISH in rt_mutex_setprio(), now it is or-ed
in.  So the checking logic needs to change.

Fixes: 1de64443d755 ("sched/core: Fix task and run queue sched_info::run_delay inconsistencies")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 kernel/sched/deadline.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 1508d126e88b..f50d20b7fe7c 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1561,7 +1561,7 @@ static void enqueue_task_dl(struct rq *rq, struct task_struct *p, int flags)
 		 * the throttle.
 		 */
 		p->dl.dl_throttled = 0;
-		BUG_ON(!is_dl_boosted(&p->dl) || flags != ENQUEUE_REPLENISH);
+		BUG_ON(!is_dl_boosted(&p->dl) || !(flags & ENQUEUE_REPLENISH));
 		return;
 	}
 
-- 
2.27.0

