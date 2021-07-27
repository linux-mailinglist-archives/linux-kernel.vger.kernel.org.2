Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1953D72AB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 12:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236237AbhG0KLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 06:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236226AbhG0KLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 06:11:12 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D8CC061757
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 03:11:13 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id p14-20020a05620a22eeb02903b94aaa0909so11182694qki.15
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 03:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=LMbzwrKhmf5Uh7cFjPrzQfkjN4w5P1hFNV37MXPWy0A=;
        b=g07x3AI1a3mnWrGkKJCpMArTSgKGgeTYcX9IbQJkDI4eLnBm6eR9EtOdZUELYSaaYK
         gN6MUyR8nitRLdtUZ7ip1IM4MDPNEr5F2xDxgRgtkWT4p3WF4X83gTB+wCMb3yJHXujz
         W+No/nsvDEebAfey6QVwufwuOYwHx61pawKxMuAX6NJ/KraLokPD1odaWroKqgVeGOcF
         Vli/GW+QzF0xFdhVk524Bz0oeZLZ9geELiGSsVPtnBWxZClkKxoMxbIt6Z0IlwebrdGQ
         Bt7hmmoqsN5dWE4LzxxFtz9Ty0/9CQWR0pAoTpMXTuz1NOTB5q6hD11XAuCkYIyJQ2ty
         3vJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=LMbzwrKhmf5Uh7cFjPrzQfkjN4w5P1hFNV37MXPWy0A=;
        b=b9g/h28/h8gh92Z5zFEBWD2i/NDoK0PEvmKHwyqsqu9gjLgHoZcjjQT5m+N+3LFpBu
         4kogT3lLpZZQm3+1qqFJXJzQvlKnPS1c0MvGufPLvb682p8A+p6SURi9Epb2wsZOj/jM
         R/U/B0W8kyurhykKo4gXfKf9ZCfI1ncJFCD5Fz4OAyAJAWdraNiKxWXsNr7UCHAhi36S
         LkjDyOghD4T1BOO5ptcl3J7+u0KrLelbwfyMa6/sPh8iMFGvg4HwZ4o0meNq4P+kgSYd
         e0oUh40BfLnAMPY8jg3m3OU+9IShIQXphyByfPrtQ5cSVIrLErTACd/caqeQxMRit3ts
         SLcA==
X-Gm-Message-State: AOAM530RrYvni0lH+4mhJfWo3sdVkJPNZgIMITzwunVtpEE07aAolRLk
        kmzVy4Yj71TSIiE9z272bRAjV6v62K1h
X-Google-Smtp-Source: ABdhPJw29tisXE6yd328tB/lJjxSzFi7TKezxkpsjmYY/1mKd1nHR/9E5nVO3dMOYPiCpI5aLezANrEjcbO0
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:c468:e033:fa2b:3a6])
 (user=qperret job=sendgmr) by 2002:a05:6214:27e5:: with SMTP id
 jt5mr21768862qvb.33.1627380672231; Tue, 27 Jul 2021 03:11:12 -0700 (PDT)
Date:   Tue, 27 Jul 2021 11:11:02 +0100
In-Reply-To: <20210727101103.2729607-1-qperret@google.com>
Message-Id: <20210727101103.2729607-3-qperret@google.com>
Mime-Version: 1.0
References: <20210727101103.2729607-1-qperret@google.com>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
Subject: [PATCH 2/2] sched: Don't report SCHED_FLAG_SUGOV in sched_getattr()
From:   Quentin Perret <qperret@google.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Quentin Perret <qperret@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SCHED_FLAG_SUGOV is supposed to be a kernel-only flag that userspace
cannot interact with. However, sched_getattr() currently reports it
in sched_flags if called on a sugov worker even though it is not
actually defined in a UAPI header. To avoid this, make sure to
clean-up the sched_flags field in sched_getattr() before returning to
userspace.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 kernel/sched/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2d9ff40f4661..d8f489dcc383 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7535,6 +7535,7 @@ SYSCALL_DEFINE4(sched_getattr, pid_t, pid, struct sched_attr __user *, uattr,
 		kattr.sched_priority = p->rt_priority;
 	else
 		kattr.sched_nice = task_nice(p);
+	kattr.sched_flags &= SCHED_FLAG_ALL;
 
 #ifdef CONFIG_UCLAMP_TASK
 	/*
-- 
2.32.0.432.gabb21c7263-goog

