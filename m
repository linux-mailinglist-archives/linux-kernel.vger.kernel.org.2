Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 098B042A003
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 10:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235029AbhJLIho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 04:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234745AbhJLIhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 04:37:42 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 967F2C061570
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 01:35:41 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id i83-20020a256d56000000b005b706d1417bso26412129ybc.6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 01:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=2PxooU0wMNWHRoqVg8KGWycx2G1vRUD/xvnBqPnO+Cw=;
        b=spzW640BaOKfr0hbZcimKSsUIxmi9aHJwfY7TPcMFosV8HHVLQ66+2SUyvTnniKPPb
         KepRy35l2WP5YsEj4uzZxcKfXhkbSjNmXkq0Jj0bI1OgdEWOqTCMkvyiGZFRzVVaKeIt
         R24G1kQbcJ0OiheevlxwUeRSfu8L6EoJLtIB0If3bBW9z54EIwQvD0AYdyPi1uRrph/t
         r3pqbZJi6MtobB/f65O8Wbm1a6U2N0trK1AHbKvaMnq5gb6A93J+41dZo7OkwK4n5BUL
         BViigYx/MBTXPNF0lXhx5lxDEYzSmmLQLUfflMHdDwRT5/6MLTFnxN4uUVrb8rTftX0V
         EVpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=2PxooU0wMNWHRoqVg8KGWycx2G1vRUD/xvnBqPnO+Cw=;
        b=j9Hpw1tvf05swDOrihyxj0nwha5D+pxtgRsaRcR4q5HTCUx9r+ixV415QaiO29IEkL
         NKeAzSuZyw0ZCZXxyNPYBphEdRl2PzV8KI3spbDJd3J19eAnYBvjbfOCWI3dZtu9kBPz
         oyVbl0zThi3c+BtEKPc0GZm72+WH/AQ55DwytZxQtM3M6xQM/YPWS5qDatwjyNyhyatZ
         Rw+lFXJso+Bb7a0vZBWufeOID8zn2HKAGhYX3SNzxGTO+c7IPzi4DRfEU9t6ejO8VnBk
         gPJWR+2VPsaRJYzjt5axpa4t7AFhojqDS+8eNvTUbDimiNSqs8bR6VRW16pGix36btcx
         8FfQ==
X-Gm-Message-State: AOAM532rsh4pjvs7KBmrKjGcgL9ZHbIr6oBreQzEtc0MwJZH9bUp6vJc
        YaHEvM9Y+iuemwhuiAy6mL91FNR5zfud5g==
X-Google-Smtp-Source: ABdhPJzsF7hKhKik4m/BXdA5SYLtnCn2FwEwKL8zo0ZS0qJXXGfN7j/oMoAqO+Vb1MWa2LKVTRR/JNUbx4/7Ug==
X-Received: from woodylin.ntc.corp.google.com ([2401:fa00:fc:202:4a20:efbd:8eb8:c383])
 (user=woodylin job=sendgmr) by 2002:a25:e08d:: with SMTP id
 x135mr26667230ybg.199.1634027740838; Tue, 12 Oct 2021 01:35:40 -0700 (PDT)
Date:   Tue, 12 Oct 2021 16:35:21 +0800
Message-Id: <20211012083521.973587-1-woodylin@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH] sched/scs: Reset the shadow stack when idle_task_exit
From:   Woody Lin <woodylin@google.com>
To:     Ingo Molnar <mingo@redhat.com>, Ben Segall <bsegall@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org, Woody Lin <woodylin@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There was a 'init_idle' that resets scs sp to base, but is removed by
f1a0a376ca0c. Without the resetting, the hot-plugging implemented by
cpu_psci_cpu_boot will use the previous scs sp as new base when starting
up a CPU core, so the usage on scs page is being stacked up until
overflow.

This only happens on idle task since __cpu_up is using idle task as the
main thread to start up a CPU core, so the overflow can be fixed by
resetting scs sp to base in 'idle_task_exit'.

Fixes: f1a0a376ca0c ("sched/core: Initialize the idle task with preemption disabled")
Signed-off-by: Woody Lin <woodylin@google.com>
---
 kernel/sched/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1bba4128a3e6..f21714ea3db8 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8795,6 +8795,7 @@ void idle_task_exit(void)
 		finish_arch_post_lock_switch();
 	}
 
+	scs_task_reset(current);
 	/* finish_cpu(), as ran on the BP, will clean up the active_mm state */
 }
 
-- 
2.33.0.882.g93a45727a2-goog

