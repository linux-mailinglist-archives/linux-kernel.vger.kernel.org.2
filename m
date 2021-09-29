Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9EC841CEA7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 00:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347026AbhI2WEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 18:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345332AbhI2WEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 18:04:05 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7302C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 15:02:23 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id w14so3159922pfu.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 15:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uRhBWrgFlaAm1vNONWn7eBn+C1gWiV8BF1SotpY7wF4=;
        b=XKTJ3egRbn88mEWHt3e+NT5KCfMY5twURwT5zz5ZEAy4HBp8LSwa/+FnrXK3LRRKkT
         z6g2BRe8HPSATIQEdZO9kSxRUJH9iUGNXS5qMILUhHDhj8MwNkfpgrdoFzdwmxBE3ALy
         dACyf1uiHL0kU9LpK6/Jwb0rEZezv2HsKTPx4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uRhBWrgFlaAm1vNONWn7eBn+C1gWiV8BF1SotpY7wF4=;
        b=0fxMPczgqzrbObTH4gj2jv3g2Cp7SVsuDpL0ilH6T/7TFd/HijiI6Ul/TdXaDpYEqg
         QEXR777bV0O9B9plKxQOx/5QuKyDnMGUgbgGD/O3m0NoUhbjms1kebk+ha/Xq6rTwYSO
         glLEyp++SCr+8KGlJuIBTHWLSb8xpdkLjSMiXmh5Bd/8A10CGo0RufjJJShs/wTX194A
         hiWTZ5gTD2rzXQZUhlg7OiVvjRZq8cBb1n8rnP1NLE0fqMA0eK8W82JMCSUl1qBBsIXf
         HB/X3GnDEGs0jru7A+WhBFxPv4s10Vy4+BNpvk57FtN7IoFF0twSKt3xEXZJSrzslfW+
         hJ0w==
X-Gm-Message-State: AOAM5308gDWOAAY71qZISfIMoIYmJQAV++oz5mHjFurC6faKCPGsNsJQ
        aL5069V8uioEDzXjFe+Gnfwo3A==
X-Google-Smtp-Source: ABdhPJxC17A4z/lSx47PDiLiFULUOvXwmBTm++Bv6j1g8B33SA4QeFQDMuP4z5hdB2v8p/omo/yiPg==
X-Received: by 2002:a62:51c6:0:b0:43d:e849:c69d with SMTP id f189-20020a6251c6000000b0043de849c69dmr843514pfb.31.1632952943316;
        Wed, 29 Sep 2021 15:02:23 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u6sm582368pgr.3.2021.09.29.15.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 15:02:20 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        kernel test robot <oliver.sang@intel.com>,
        Vito Caputo <vcaputo@pengaru.com>,
        Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Anand K Mistry <amistry@google.com>,
        "Kenta.Tada@sony.com" <Kenta.Tada@sony.com>,
        Alexey Gladkov <legion@kernel.org>,
        =?UTF-8?q?Michael=20Wei=C3=9F?= <michael.weiss@aisec.fraunhofer.de>,
        Michal Hocko <mhocko@suse.com>, Helge Deller <deller@gmx.de>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        "Tobin C. Harding" <me@tobin.cc>,
        Tycho Andersen <tycho@tycho.pizza>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jens Axboe <axboe@kernel.dk>,
        Stefan Metzmacher <metze@samba.org>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Ohhoon Kwon <ohoono.kwon@samsung.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-hardening@vger.kernel.org, x86@kernel.org
Subject: [PATCH v2 2/6] sched: Add wrapper for get_wchan() to keep task blocked
Date:   Wed, 29 Sep 2021 15:02:14 -0700
Message-Id: <20210929220218.691419-3-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210929220218.691419-1-keescook@chromium.org>
References: <20210929220218.691419-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2019; h=from:subject; bh=hDSVcS+yS4zZDdIDUOZIhgW3NO0PbtwfKyydbAUGaMU=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhVOJoXE4lnUJcVhzfp3ihdwxyB+SepKuT2zcL6CCW aOKOM4iJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYVTiaAAKCRCJcvTf3G3AJtD4EA CKIae2l/Y4dicmSYuz6SdCtnqA0Rd5XecPN40jZIiItJs97tI0zHJfZJ0grAuBL62iw0oTrDAep0rJ hbKWV0M7J6ZcSqjI/alre0T7Jp1q8rOp/PnsXrdt23dO2vZXQh/6qvDemzNIvxOpQ4xk1cEann4FyQ mb1o02iC6K5JJaKT7HJXFfQo3fi++ezzGECuBqyyZYFcIMx5RuTUS+ZpWNgraW+WZpPgzl6ZXGP4bn xB+1NZDZqY5Q9oZ8vuDm1SC/+QwmZJCrgyeQTS213hV7Kuv0qIo/GTM+v/+/jTbqfXPZUWNKUbB28I TxAnDGXvT77m6f1R0ihCffDBj36GLZF6X+u1Mb8BeSeg7UGxXLf9EdwMsZIGs9PhUL6titRBgNwAc0 R7vAin9+bCS4p/0Tl9HfHtJoIRUWleimK8KDxGOz6LuA8ZozXBRcwUuCoTwT+9nF4T06Nou/8fcvfF BSG0SkCgkr0ug2ebMP2txQ8gxIXcWKntvutRuw0xuKNeHWIGtg8JMccsidYwQ6l2D0q6FMDcE+K1QJ YU4/m+ZEpM1mrWDvBfI0i2fkC85s++MH3kuyyx15f8J6ZosClV6STeF5l8QBbZC5wWgoxEdV50MX+A QOOb4MBGs24mNWLO/oiPqGS21M141Fn88kp6/GifGhov5UAVvVKoaTEUseeA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Having a stable wchan means the process must be blocked and for it to
stay that way while performing stack unwinding.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/sched.h |  1 +
 kernel/sched/core.c   | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 39039ce8ac4c..0c8185089e20 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2137,6 +2137,7 @@ static inline void set_task_cpu(struct task_struct *p, unsigned int cpu)
 #endif /* CONFIG_SMP */
 
 extern bool sched_task_on_rq(struct task_struct *p);
+extern unsigned long sched_task_get_wchan(struct task_struct *p);
 
 /*
  * In order to reduce various lock holder preemption latencies provide an
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1bba4128a3e6..4a30455e1ff5 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1962,6 +1962,22 @@ bool sched_task_on_rq(struct task_struct *p)
 	return task_on_rq_queued(p);
 }
 
+unsigned long sched_task_get_wchan(struct task_struct *p)
+{
+	unsigned int state;
+	unsigned long ip = 0;
+
+	/* Only get wchan if task is blocked and we can keep it that way. */
+	raw_spin_lock_irq(&p->pi_lock);
+	state = READ_ONCE(p->__state);
+	smp_rmb(); /* see try_to_wake_up() */
+	if (state != TASK_RUNNING && state != TASK_WAKING && !p->on_rq)
+		ip = get_wchan(p);
+	raw_spin_unlock_irq(&p->pi_lock);
+
+	return ip;
+}
+
 static inline void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
 {
 	if (!(flags & ENQUEUE_NOCLOCK))
-- 
2.30.2

