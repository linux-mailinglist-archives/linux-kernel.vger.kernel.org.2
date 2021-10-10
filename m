Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8754428078
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 12:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbhJJK1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 06:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231556AbhJJK1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 06:27:13 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81ABBC061570
        for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021 03:25:15 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id oa12-20020a17090b1bcc00b0019f715462a8so11212092pjb.3
        for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021 03:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MkMsqD8hz7/bS7hLZsOqQOOezI0HIhcevrX69qu28YI=;
        b=T99GJBzzW5gsDm7ILAMawWCa2OG1STclzemq8G0hWvi+qLt1fxrVrHrW0Exhk8NmOo
         tbJ2gNMygnn+Gp6tdYiTF0sbzUAbRDR5PTz1UAaqfMFGd+gtq80m3/ki7HOWLEZW7Qjl
         iH5RS+0tfKgrMXph2kKykUDMAmh8/o8oXliFv8vZQmyAVtldJGoTKEHv7Ud8Hrv3cuYy
         QVC2ccSEn5qVuZqGhFF0lns4ohLGOfJjyGu4HEMu6surEiw++RZhSSLiB5lVdZdQ+IXM
         z9reDSl/oWTyphPUIydauLQkikv43yQDK7e4gwyf21RyZ1kFVWIzlWJI0xuAlrDfwQR9
         Q27Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MkMsqD8hz7/bS7hLZsOqQOOezI0HIhcevrX69qu28YI=;
        b=NiK3T9UOR3xNYkxU5eBaJQp0VKqqF9+VJZm4+kMItByM/fZQKc6PjByaaNgwhA4LAV
         zRCqMpJi8uZJwNZESIoayWOOGHZ6JyHumjuc4LCY5m60vfzqsAwWwuvLqAws2Tu8o8Yx
         AkFqBFRBifBr6v0HT6KKIcr4Gvkze44v0D2plmRvG3R3ZP0x1lthv91H8R4PwDGieecI
         lPVJaRUru5jOdFuF1eF0CnKUzhuiGn2a4yz/VL3/9/Zuvj5piwlfIpej2jb2kFN16ybA
         IA8XfjJaW3q8uzuz4YmFT0lbABT5STVOJzv9J5eu/q5E87gKpV64tasNOLrk8UXz40aA
         UxFA==
X-Gm-Message-State: AOAM532jocDYPZ2VrN6vHzIgDWshnbb3zPw4CMyNQcJZ8Nw8fG3pD8IL
        Buqu27cS/4xdzHSmHQDzl2Q=
X-Google-Smtp-Source: ABdhPJwEtsgZPBWTb0EFjvsruFq65MuC8Sm637Vb7lYw6stENpChl2JiGZd/yd0zjTwZDJCQzHmTPA==
X-Received: by 2002:a17:90a:1d0:: with SMTP id 16mr23054104pjd.60.1633861515111;
        Sun, 10 Oct 2021 03:25:15 -0700 (PDT)
Received: from vultr.guest ([144.202.123.152])
        by smtp.gmail.com with ESMTPSA id w4sm4347494pfb.3.2021.10.10.03.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Oct 2021 03:25:14 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     keescook@chromium.org, rostedt@goodmis.org, peterz@infradead.org,
        pmladek@suse.com, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, valentin.schneider@arm.com,
        mathieu.desnoyers@efficios.com, qiang.zhang@windriver.com,
        robdclark@chromium.org, christian@brauner.io,
        dietmar.eggemann@arm.com, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v3 3/4] sched.h: extend task comm from 16 to 24 for CONFIG_BASE_FULL
Date:   Sun, 10 Oct 2021 10:24:28 +0000
Message-Id: <20211010102429.99577-4-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211010102429.99577-1-laoar.shao@gmail.com>
References: <20211010102429.99577-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When I was implementing a new per-cpu kthread cfs_migration, I found the
comm of it "cfs_migration/%u" is truncated due to the limitation of
TASK_COMM_LEN. For example, the comm of the percpu thread on CPU10~19 are
all with the same name "cfs_migration/1", which will confuse the user. This
issue is not critical, because we can get the corresponding CPU from the
task's Cpus_allowed. But for kthreads correspoinding to other hardware
devices, it is not easy to get the detailed device info from task comm,
for example,

    jbd2/nvme0n1p2-
    xfs-reclaim/sdf

We can also shorten the name to work around this problem, but I find
there are so many truncated kthreads:

    rcu_tasks_kthre
    rcu_tasks_rude_
    rcu_tasks_trace
    poll_mpt3sas0_s
    ext4-rsv-conver
    xfs-reclaim/sd{a, b, c, ...}
    xfs-blockgc/sd{a, b, c, ...}
    xfs-inodegc/sd{a, b, c, ...}
    audit_send_repl
    ecryptfs-kthrea
    vfio-irqfd-clea
    jbd2/nvme0n1p2-
    ...

We should improve this problem fundamentally.

This patch extends the size of task comm to 24 bytes, which is the
same length with workqueue's, for the CONFIG_BASE_FULL case. And for the
CONFIG_BASE_SMALL case, the size of task comm is still kept as 16 bytes.

Suggested-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Petr Mladek <pmladek@suse.com>
---
 include/linux/sched.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 39039ce8ac4c..e0796068dee0 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -275,7 +275,11 @@ struct task_group;
 #define get_current_state()	READ_ONCE(current->__state)
 
 /* Task command name length: */
+#if CONFIG_BASE_SMALL
 #define TASK_COMM_LEN			16
+#else
+#define TASK_COMM_LEN			24
+#endif
 
 extern void scheduler_tick(void);
 
-- 
2.18.2

