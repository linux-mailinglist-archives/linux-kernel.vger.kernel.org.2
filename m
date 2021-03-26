Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22AE534A783
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 13:45:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbhCZMox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 08:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbhCZMou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 08:44:50 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 188AAC0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 05:44:50 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id l13so4066217qtu.9
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 05:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dCXfAKEyJGgzrxMd1G3IH39eK2Y+HOrmuU+aq2NgQUE=;
        b=lHsWunFu4O9zhaac9mSnQCAHD/AFOi+B7tXtUGU27izCVQaS6krZTHwzVghp0+clSy
         7cbHn959Nq/CznF9iRnBGCS4PONrcoK0MEuO47M0F/yHZtJchNApa4n77MjVaCZpmqzc
         ryYyEYXx4612BuxVdHtY3bje3epVGTbPb3X9bgi5RUo31JPajp58Je2A4K9RFLE+sPGl
         LmE0XtJgyZGF0pMD6FTgt+ILxO0+O/dQWl4B8F6ImNm426lG1gX6oxD/eigf6cA7QKH8
         YjlVlGGPgQ7gZwLHnhtQN2h1gpTMSN79lrkNmVxbVZxtZTkJjzohe02UQad/xv8GiGEa
         Gllg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dCXfAKEyJGgzrxMd1G3IH39eK2Y+HOrmuU+aq2NgQUE=;
        b=jl6P1YmRNhh77UnuTch8NI3ggzvOwcuK6SkqFI87+nBdSdHE3OMGkAs5lF2lssAzXq
         vVOe84Qa+lonQ6OWKEBw2a8viCo6bqZyvtfL2U8tijg+Off42xThrgVnitu8hD8eHpwS
         icGoRc9NrUlwD5BPcyUgLds4iGh4Tl4KqvXohA6Yx8ujcIK5HSqB6MEfVcQTxsoQ7pl8
         XjQGadpYOp4Htzx2NSOZNClpBRAZOQNOTNlr6nmfkIGXkyXVkmTBMI0Vt2TWdh/S3qII
         2gNWsj0i0+WAmxxjKznZWDwZdglMpjqBGA8LisGqNMix5h0frLs+6cWcIHEoqiw77Wy9
         7qnw==
X-Gm-Message-State: AOAM5323U1dtjGbf8lOGQR3GO8UCeXyi4NqxzFFvdeMUe7bYq2SksOnw
        QygVWZiHCP9+zZNs1WIuXe1k1c+vY6cvEY9C
X-Google-Smtp-Source: ABdhPJxMD5LOnXnj/KW8jNq2psP+YTQIaH7MvckATjoVbmEzsR08HwboF7sClhAtmgqtRV0RN+1HMg==
X-Received: by 2002:a05:622a:188:: with SMTP id s8mr12011739qtw.42.1616762689372;
        Fri, 26 Mar 2021 05:44:49 -0700 (PDT)
Received: from localhost.localdomain ([37.19.198.107])
        by smtp.gmail.com with ESMTPSA id h7sm6359180qkk.41.2021.03.26.05.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 05:44:48 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     hannes@cmpxchg.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] sched/psi.c: Rudimentary typo fixes
Date:   Fri, 26 Mar 2021 18:12:33 +0530
Message-Id: <20210326124233.7586-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/possible/possible/
s/ exceution/execution/
s/manupulations/manipulations/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 kernel/sched/psi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 967732c0766c..316ebc57a115 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -59,7 +59,7 @@
  * states, we would have to conclude a CPU SOME pressure number of
  * 100%, since *somebody* is waiting on a runqueue at all
  * times. However, that is clearly not the amount of contention the
- * workload is experiencing: only one out of 256 possible exceution
+ * workload is experiencing: only one out of 256 possible execution
  * threads will be contended at any given time, or about 0.4%.
  *
  * Conversely, consider a scenario of 4 tasks and 4 CPUs where at any
@@ -73,7 +73,7 @@
  * we have to base our calculation on the number of non-idle tasks in
  * conjunction with the number of available CPUs, which is the number
  * of potential execution threads. SOME becomes then the proportion of
- * delayed tasks to possibe threads, and FULL is the share of possible
+ * delayed tasks to possible threads, and FULL is the share of possible
  * threads that are unproductive due to delays:
  *
  *	threads = min(nr_nonidle_tasks, nr_cpus)
@@ -441,7 +441,7 @@ static void psi_avgs_work(struct work_struct *work)
 	mutex_unlock(&group->avgs_lock);
 }

-/* Trigger tracking window manupulations */
+/* Trigger tracking window manipulations */
 static void window_reset(struct psi_window *win, u64 now, u64 value,
 			 u64 prev_growth)
 {
--
2.26.2

