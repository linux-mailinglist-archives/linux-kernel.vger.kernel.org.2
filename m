Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED0D42BCBB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 12:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239311AbhJMK0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 06:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239350AbhJMK0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 06:26:05 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC4AAC06174E
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 03:24:02 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 75so1885494pga.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 03:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OqWS0xdYApsn9gllT1tysMteOZDpfGt2y2/S2w2k+qg=;
        b=cdwMZ1ftAXU95xo0VixXXHVfRZ/yHx7zFJdI+1Y9/L0b1O2h0Q4L0gjZ8KTKyNCDqJ
         BpGpDNMnvhd9veCX04IRJr3IBs0bDeEOq2WfKgRNazZ9cKrA4Q0JEmL22idNXgpg6uRe
         Wle8OwCZ/LajAydOM2PtA4aqSSDIbe+yUKSuDbJxnSNoT18nJIvLI7EYqvWlytgM3Mo7
         27f+QalnNiZcPCjuxbUx7xR0hahbp603eN9psx5vlZvWCPB8kv0huG6Z4DGM7jc4GoOr
         4haxg8H+nYx5sA4H4+2e+jtj46NHiU3QXWmuHMMe3wBv1JQedESTcmHYPCJuq6m+Xefx
         mXwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OqWS0xdYApsn9gllT1tysMteOZDpfGt2y2/S2w2k+qg=;
        b=HXVOxTfL+Q1CNLc1Sm8ikDrqq66P/Y86L1TARydaJGlp3PPH4IXqApuGOYZ7ujpkEu
         zVep6RDZ5L0RKCr0HsAqXmnvebqkblxwIR8SJngklByIsDQFuof5MU+vbiAmaZ3KsM12
         ySDQBrUQO5gPt3XFEwCmx4RZqA4sysqMhabtCLb5Y4ZFsbF4fJ5TJojzLsur8bwdRFeY
         xUGUUE/Zeh4pEmOia+k3ya739O0NMvSU9/PxUkK4wZHJja5gcZKdo6DTpwrWnIHpUoIv
         Tf/Kxi3MC6BVuSTQ/DNdLekLCFdte8iSow9Ieo9v0mQyQrnpBe0cjKaIjtYPxIKTZDkG
         OkzQ==
X-Gm-Message-State: AOAM533VwATlOlgjLEFK+3d55R2tFYp6plS4AVGLZSJ1qAcNDeDrbSdY
        TPrfmG39fGeHDc7uE3c43h0=
X-Google-Smtp-Source: ABdhPJzsje2Tz8POLjXmy0RUrVLa95f//pE2W7Id9v0M2RD/HBSqcSZYjaf7knXlYFJpHw4cPZb0Uw==
X-Received: by 2002:a65:4689:: with SMTP id h9mr26780378pgr.137.1634120642569;
        Wed, 13 Oct 2021 03:24:02 -0700 (PDT)
Received: from vultr.guest ([144.202.123.152])
        by smtp.gmail.com with ESMTPSA id 184sm13900994pfw.49.2021.10.13.03.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 03:24:02 -0700 (PDT)
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
Subject: [PATCH v4 5/5] kernel/kthread: show a warning if kthread's comm is truncated
Date:   Wed, 13 Oct 2021 10:23:46 +0000
Message-Id: <20211013102346.179642-6-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211013102346.179642-1-laoar.shao@gmail.com>
References: <20211013102346.179642-1-laoar.shao@gmail.com>
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
2.17.1

