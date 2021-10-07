Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60E7B425293
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 14:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241234AbhJGMKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 08:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241155AbhJGMJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 08:09:57 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E08C061746
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 05:08:03 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id 145so5148152pfz.11
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 05:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GvtEAmv10KTKNmGmr2+wYmiKP1biHINp8QYP5Zd8fX4=;
        b=pWyUbNC5DgTs8jQLSOUmzAHeWqwkPRcLECVbpCjZKwHWxLV6mlPQrEL/ULSHvci2BS
         749PE8M//SfV0aNoIQjXTovMMhvLFnBMU7wB+9A8hsD1CpixK1jaKq0oPwJVb6s/wxbU
         0ynI70tEuEvGR08nm/bNASlY1nO0T+jOFJz9h4HuX81Ii77kJA2AUB2Aaxo3Tgyyr7NH
         oBo8Tlje8pgrvxMSKBF4OfVjgf/9bir5kdwaexD8F/RJcS/qUtVKBt6ycHlGLzaqldo+
         5Wf6t8n3ESWwo9K9XVYZfwkIPoAMgkwMkQpyamx7htVmpDr7wLZpiGg5/rEKs2rPEBGn
         oNYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GvtEAmv10KTKNmGmr2+wYmiKP1biHINp8QYP5Zd8fX4=;
        b=3tIub07XY8ayNdV9FzCdwkDAnStoVs4jPku8tfnyPYhFI5WRyQjEe6yQBaFgVSgfMF
         ZLayRpankWZMO1Rt3C8QzP7cX76swuQf+YXbx77pX40Hb73FtRCHszgMmX4YL0qt7uoP
         DHSyS0HFp2A1AOHTYN6XFgmDM66CMDO700UQGIK4RURTWDqIH0jwzD7ygYTE1eUMdzjU
         6a8MjqrEcEFn2wCd+fyyKeGk3gUGfRRkUQ6B/uWttxrgAFi6nyAbJ35MOfC8Vzc8qjyz
         x8TSUG5E+RdPIgJQDGC2EQldtzi0vo1qdilZuiSxJdFeLrS1eLyweLbi79vBv6FngEp8
         fPQA==
X-Gm-Message-State: AOAM530lQCgICK/I+Qi9UD3mMMexgkHF5lifcX+zvg7/wUIs8t+SpWhy
        Z3R3LXkeBJEy4kN3XP7Jz2c=
X-Google-Smtp-Source: ABdhPJyG7ap2acFO/8tJlIiam0O7cMsNnLU7UN3wsq1pC86XFgokQwPgoZOaCSSa6MQVf6/eQP3weA==
X-Received: by 2002:aa7:9f05:0:b0:44c:619e:87da with SMTP id g5-20020aa79f05000000b0044c619e87damr4003879pfr.42.1633608482857;
        Thu, 07 Oct 2021 05:08:02 -0700 (PDT)
Received: from localhost.localdomain ([144.202.123.152])
        by smtp.gmail.com with ESMTPSA id c8sm23915582pfj.204.2021.10.07.05.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 05:08:02 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     pmladek@suse.com, keescook@chromium.org, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, peterz@infradead.org,
        valentin.schneider@arm.com, mathieu.desnoyers@efficios.com,
        qiang.zhang@windriver.com, robdclark@chromium.org,
        christian@brauner.io, dietmar.eggemann@arm.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v2 4/4] kernel/kthread: show a warning if kthread's comm is truncated
Date:   Thu,  7 Oct 2021 12:07:52 +0000
Message-Id: <20211007120752.5195-5-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211007120752.5195-1-laoar.shao@gmail.com>
References: <20211007120752.5195-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Show a warning if task comm is truncated. Below is the result
of my test case:

truncated kthread comm:I-am-a-kthread-with-lon, pid:14 by 6 characters

Suggtested-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Cc: Kees Cook <keescook@chromium.org>
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

