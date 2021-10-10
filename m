Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4DB4428079
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 12:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbhJJK1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 06:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231580AbhJJK1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 06:27:15 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB130C061762
        for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021 03:25:16 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id 187so12194396pfc.10
        for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021 03:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lHX3T1QaGRW7QLyVlwJ/mNN/4KcRZcqxwEcbPgjUcaI=;
        b=Ky2XqBIdiz4urS2uso29THdRJHXLDNpCj53Bc4AsnF0vA8YmsFy8f5sGr5ZwQ+/KAR
         c3SlFZ+b4/Ibgq5GsTABwP6az0a27Naebvb3vhzvcuQqhT7LJnDLjkhAMzys7qJeI2Me
         lMg/ewQNjqL6R1e9Rw4Kk/AxlqU5hcXVlNBmxtqv8sQxOW5lIk9DpA//o7LRppPdehUv
         mYD2IgdZrEYyhjzZrPWweN/OlfBaEvfkYmccqAHPVVjVTN7EbzAg3HBqJcdshR+FwEVt
         2wt/M0XG7jVJoDlIYf9zpkfjPTAhAel1WUZekF1W0fuRBsBvTJuDaD51HKVoKRrwQfIp
         U+Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lHX3T1QaGRW7QLyVlwJ/mNN/4KcRZcqxwEcbPgjUcaI=;
        b=vnNpjzeynh51LQMI2BmnZWLta0p6d7FRruKyfiRdXDhpuNf7OmZRsqLWO0PdNQ2iN3
         dChFCUbfV1sUfHnp2vN9ehczOgg65PWZYyUMF6i0VQIlEhSaTL/auBSIGMuG6sJkoLG+
         IqvP/JJzR4ywvfvv/lTC61rer12h7HOG0AEpvr8Xp1UnrMWrS0gcS2NxpFbhevNghTiD
         8AA3oETRunCZx/fm4UbwlgBcRoNZnaaadWK0C8xuhMy0clw5t6ojp3W3NZMDgqAJS6T2
         LARgJJ4wAJsPh17aFeikgQDQeil6g6dn6C/oqTiAXtd6+QbjKFWfSHn7BHFPro0oqJET
         NR5w==
X-Gm-Message-State: AOAM531GiwI+DkmLeKuKF18PP+zTtgPv4zWzBefeXSE/T3wPJK2l+0ZB
        /Ty5CFbVdNz/tvGuM3zhbGQ=
X-Google-Smtp-Source: ABdhPJwVwfPWSeY5cNbiUM43AHBpvY0c8AoU/ps5Q2J2tSm1Dv60CBpV1sbyRR/KsKva+UI9PR58nQ==
X-Received: by 2002:a05:6a00:1147:b029:3e0:8c37:938e with SMTP id b7-20020a056a001147b02903e08c37938emr19805158pfm.65.1633861516515;
        Sun, 10 Oct 2021 03:25:16 -0700 (PDT)
Received: from vultr.guest ([144.202.123.152])
        by smtp.gmail.com with ESMTPSA id w4sm4347494pfb.3.2021.10.10.03.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Oct 2021 03:25:16 -0700 (PDT)
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
Subject: [PATCH v3 4/4] kernel/kthread: show a warning if kthread's comm is truncated
Date:   Sun, 10 Oct 2021 10:24:29 +0000
Message-Id: <20211010102429.99577-5-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211010102429.99577-1-laoar.shao@gmail.com>
References: <20211010102429.99577-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Show a warning if task comm is truncated. Below is the result
of my test case:

truncated kthread comm:I-am-a-kthread-with-lon, pid:14 by 6 characters

Suggested-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Petr Mladek <pmladek@suse.com>
---
 kernel/kthread.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/kthread.c b/kernel/kthread.c
index 5b37a8567168..46b924c92078 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -399,12 +399,17 @@ struct task_struct *__kthread_create_on_node(int (*threadfn)(void *data),
 	if (!IS_ERR(task)) {
 		static const struct sched_param param = { .sched_priority = 0 };
 		char name[TASK_COMM_LEN];
+		int len;
 
 		/*
 		 * task is already visible to other tasks, so updating
 		 * COMM must be protected.
 		 */
-		vsnprintf(name, sizeof(name), namefmt, args);
+		len = vsnprintf(name, sizeof(name), namefmt, args);
+		if (len >= TASK_COMM_LEN) {
+			pr_warn("truncated kthread comm:%s, pid:%d by %d characters\n",
+				name, task->pid, len - TASK_COMM_LEN + 1);
+		}
 		set_task_comm(task, name);
 		/*
 		 * root may have changed our (kthreadd's) priority or CPU mask.
-- 
2.18.2

