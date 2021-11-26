Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 266C845ECAA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 12:32:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344691AbhKZLfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 06:35:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237992AbhKZLdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 06:33:23 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A53BDC0617A5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 02:51:55 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id i12so8583823pfd.6
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 02:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=57ZJ18gQggOd2bwwvV6aEax1+gmFjvhVpwsDc59KReU=;
        b=clR4xfuPgiYCClNLdvZTQeIU8y2Ftry2yYaCjZhcT7cWrP98VOvVta8w91CktzVpnM
         ybtOByP9Auhjrrwazd7qh4CmVbD9NbpfYymbdSLHVJIXhEtstkvg8N8pmKpUO2yKYE1c
         S2mMTVUpufhYkwb9BeD4q+k5WRyzahCKo928gK7NSBj1TUvEKXdwfmbqc2gJia2G7dFM
         K0nj3lJEYFFxD5biFVSD/8iDOXzlC2Ahm2cUCbkHegZNnQ7YwNlkOvY/dwdoTX3qS3j2
         A6w8MWQ5Jci+zksC1sUjk7J8ICs79nAukbQxvt/4C8MgU9aXHpOWMXjPL9FCZr/43Ftw
         dMmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=57ZJ18gQggOd2bwwvV6aEax1+gmFjvhVpwsDc59KReU=;
        b=rw9/i4Ay5XfhUnL7bBaJkeMZn+kA+8ytEpYbiGGFb5njI/vuBfsqBWMcfReEu0uYg5
         ytbq9Gp+rVcEzt7XQ9rjTvU45peysrR60oR5kTnF4ms45BnDK618PoKOofXqecOS+Pup
         N7ba20Npknuizvev1TzKmPeDAOG5aZidjiYUsF9GkSzPa4mqvk+nx+LYvYLdkLR41RRL
         osEr3K9hiAGOMwwj1uKQJsanoiCMFib9uatdQLR4XIpXmjplcvzLMJ9TZQX92Dlfp3Rj
         kYxjbfU1hyh2dt1jeT9yDhTnZJU9tozOWpAh3jBBO1NZvLwSqsoE5q1MPPc3ZolCraaq
         BWVQ==
X-Gm-Message-State: AOAM533nv8WzeiGQu1ia4zKqhqF+i0tCQgH8FbrrybXVltvUxf04dKnW
        7SCEhSWP8JW4yvHUz0ijLOI=
X-Google-Smtp-Source: ABdhPJynp6aiW22jnusStscy+1OBGkksE8zcL475fnI4bJcnQGjekfBZ67ZbgiS47Jf5c/OwNBMEPA==
X-Received: by 2002:a63:4f57:: with SMTP id p23mr20465156pgl.325.1637923915243;
        Fri, 26 Nov 2021 02:51:55 -0800 (PST)
Received: from baohua-VirtualBox.localdomain (47-72-151-34.dsl.dyn.ihug.co.nz. [47.72.151.34])
        by smtp.gmail.com with ESMTPSA id m7sm4567971pgn.32.2021.11.26.02.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Nov 2021 02:51:54 -0800 (PST)
From:   Barry Song <21cnbao@gmail.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org
Cc:     dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, Barry Song <song.bao.hua@hisilicon.com>
Subject: [PATCH v3] sched/fair: Eliminate confusion for the scan number in select_idle_cpu
Date:   Fri, 26 Nov 2021 18:51:39 +0800
Message-Id: <20211126105139.11784-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Barry Song <song.bao.hua@hisilicon.com>

Right now, the number of scans is very confusing. For example, if nr==4,
the code is iterating 4 times but scanning 3 times only. Because in the
4th iteration, the code returns directly due to --nr==0. So the code is
wasting time on doing the 4th cpumask_next_wrap() and it is also very
confusing since the actual scan number is nr-1 but not nr. This seems not
to be the original intention.

This patch moves to scan nr times rather than nr-1 times, and it also
makes the last iteration of cpumask_next_wrap() useful.

Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
---
 -v3:
  scan nr times instead of nr-1 times with respect to Peter's comments;
  rewrite commit log and subject since we have changed the behaviour of
  the code;
 -v2:
  https://lore.kernel.org/lkml/20211124091546.5072-1-21cnbao@gmail.com/

 kernel/sched/fair.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6e476f6..5c259aa 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6285,11 +6285,11 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
 				return i;
 
 		} else {
-			if (!--nr)
-				return -1;
 			idle_cpu = __select_idle_cpu(cpu, p);
 			if ((unsigned int)idle_cpu < nr_cpumask_bits)
 				break;
+			if (!--nr)
+				return -1;
 		}
 	}
 
-- 
1.8.3.1

