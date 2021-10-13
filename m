Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5975642BCBA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 12:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239368AbhJMK0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 06:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239343AbhJMK0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 06:26:04 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919B5C061749
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 03:24:01 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id k23-20020a17090a591700b001976d2db364so1892524pji.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 03:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vCvh4uM/FRNBGr7C2xfJFbSVFodTskoYy6K4AEt9i4w=;
        b=YiY5PkIGIGAgPegbSd2KCPu3Ok+1ZHk5PFoowZEHhV7H6kYilai9DhPBpHD+J/Gouf
         S7a2Pc19RkydabX1Z+UYJ7k2EOFF4M04dOBHFli7y+64lqQX7VJrJlAs4dppklYd3Wt7
         22NWLIghgVDpjAZofGsMls4k3O6kAUGk1ZHbG4lYKyP+30Xmt6y7JXRoYbbc/macsOfc
         Rx3xwunwsbPXsxbGAM26PFrNOIfIP7iVXvofgNOVstgHzLKzjhg4JKP6Agqu1GIMdIex
         gFpULMGYymaJuOnyTgJtyE3+QAlY9GYPBQhk56yxrBhbGpEEdtUH2ISWygqVQPCgWziD
         20IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vCvh4uM/FRNBGr7C2xfJFbSVFodTskoYy6K4AEt9i4w=;
        b=S6peAzya79SVmAEKTSn+VjOj9N8u5NjwGkpN5MR3Co01kprGbfrmAMwO0h+Z475tIV
         ER7Fqp82d7OTUaGPzRKvYaJAr0r6dvLOJH87pZFQlTbLPieqVUCp1xeeecrQkvGPz+c5
         lkk/WFdri2GjBWGaZFcKr7/ryihMw0Ty4uVSo/g2zB+dWR0qnom5UNi6xwkgJ0RSp2X/
         65J+XffEVNjFeS/dGGt7VWEzqtmjo79IdotRmgApJDUCfivvZdKUwd30o02pMRyTR0TF
         ofYgOFexPHETYC8TYJQxoSCHSAEXvzBrqWwfO1VjT6P5kcDZJapkJghGUFwDRo8ribzN
         qu8g==
X-Gm-Message-State: AOAM533YWdF0VD25yf6ysXdoZWlJPoMWLOexanBWIFCnL0NOiql//z/V
        l9Fk1UvsYHIUviX8k2tNX8c=
X-Google-Smtp-Source: ABdhPJwckluSBiWeE3euEGKChLNtxFsfghZl49rbqfmMKqWzfXpjaBXfYJ5pc5EsWwW9ed4xzEBO4w==
X-Received: by 2002:a17:90a:df13:: with SMTP id gp19mr10359001pjb.151.1634120641186;
        Wed, 13 Oct 2021 03:24:01 -0700 (PDT)
Received: from vultr.guest ([144.202.123.152])
        by smtp.gmail.com with ESMTPSA id 184sm13900994pfw.49.2021.10.13.03.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 03:24:00 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     keescook@chromium.org, rostedt@goodmis.org, peterz@infradead.org,
        pmladek@suse.com, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, valentin.schneider@arm.com,
        mathieu.desnoyers@efficios.com, qiang.zhang@windriver.com,
        robdclark@chromium.org, christian@brauner.io,
        dietmar.eggemann@arm.com, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, davem@davemloft.net, kuba@kernel.org
Cc:     linux-kernel@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v4 4/5] sched.h: extend task comm from 16 to 24 for CONFIG_BASE_FULL
Date:   Wed, 13 Oct 2021 10:23:45 +0000
Message-Id: <20211013102346.179642-5-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211013102346.179642-1-laoar.shao@gmail.com>
References: <20211013102346.179642-1-laoar.shao@gmail.com>
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
index c1a927ddec64..d3f947ef7d0a 100644
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
2.17.1

