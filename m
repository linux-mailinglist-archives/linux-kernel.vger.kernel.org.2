Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 705F13989C8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 14:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbhFBMlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 08:41:18 -0400
Received: from mail-pl1-f172.google.com ([209.85.214.172]:46067 "EHLO
        mail-pl1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbhFBMlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 08:41:12 -0400
Received: by mail-pl1-f172.google.com with SMTP id 11so1024563plk.12
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 05:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bLGwi9fO8fdDfHtgfYzu2Scl8l89O7XXWk70aMKsZCY=;
        b=cqWfgEeJn0SFsy5ID4t7Mw4kU+62niuRGJT/w1bW3N6s9iOZ3nejIs7KubZD+hSeCO
         0yeKQMkP1kbWk+tHaNiyOw5lEpNyt2hqGKvjf8BKJLssw5PAugOvA8dQ8L9VxyWshnlA
         2RxFUsFa5nsY2lWeAZMd3M/+Qz+kINRZEOx+bcTNiQI/UdoP8filXWYLyPy7mZkV9h0X
         bFkwx36HLxgb73F90P0Z/Kk2QYof0njOjbxF/NqXMfn/31fiLa8BSRzZ6OUDSANpbKDo
         C3jUVIGr5n+P6P6BHPmK+DCyJsqfi3SmHGG9t2DasSMUt/L5omLjpIr5Uhm1ULKzIsdv
         8Jbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bLGwi9fO8fdDfHtgfYzu2Scl8l89O7XXWk70aMKsZCY=;
        b=nI0Ik4B5LD0PEQBu4d9vvx+riaP/odNU3/o3AUNOGKBN3hDjrlzFwd9ONvVxalreYi
         ckOnclRq9SufkC1Mm1IixN0nrGry4Jf/wxr5piBLrfWb5bfVenr82Io+HWvxBLCK8TSj
         oR2QmQhLIzvt7Nc4oksLj5uUu+YiAhRbf61JOdA5Y1OCNBWGwFin81MYTtuFfWaxuVnz
         fvFLfZPbhKh83+E/U3CbhBu0Ub6SaJJy/GE9e83EfELMND1cGvpPHp5Ef4rVu6/6mEw1
         GSDqaPXv5jhIHO7UOOm9rwuXLSpvuj6q4hatreDiIfpYcawPMjHipiEmeQP9WSBs5Fst
         OKLA==
X-Gm-Message-State: AOAM5321b+SMtHAJrP9aPQtbEePbinnRSb4A4bvMIc+c4j+prXhvsO5S
        1ZSNAoklJPZvrRACKdf9Pdg=
X-Google-Smtp-Source: ABdhPJxA7I6tPZMa7KkxFCelIuzmL7yzN3MFu6QCVDB4UrGVkAy34tQz5LrRrCE4uOan+jl5R1Rczw==
X-Received: by 2002:a17:902:e903:b029:108:d6d0:c1d1 with SMTP id k3-20020a170902e903b0290108d6d0c1d1mr7116773pld.67.1622637498583;
        Wed, 02 Jun 2021 05:38:18 -0700 (PDT)
Received: from bj10906pcu1.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id h18sm12586628pgl.87.2021.06.02.05.38.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Jun 2021 05:38:18 -0700 (PDT)
From:   Xuewen Yan <xuewen.yan94@gmail.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com
Cc:     rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        zhang.lyra@gmail.com, xuewyan@foxmail.com
Subject: [PATCH] sched/uclamp: Avoid setting cpu.uclamp.min bigger than cpu.uclamp.max
Date:   Wed,  2 Jun 2021 20:38:03 +0800
Message-Id: <20210602123803.15738-1-xuewen.yan94@gmail.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xuewen Yan <xuewen.yan@unisoc.com>

When setting cpu.uclamp.min/max in cgroup, there is no validating
like uclamp_validate() in __sched_setscheduler(). It may cause the
cpu.uclamp.min is bigger than cpu.uclamp.max.

Although there is protection in cpu_util_update_eff():
“eff[UCLAMP_MIN] = min(eff[UCLAMP_MIN], eff[UCLAMP_MAX])”, it's better
not to let it happen.

Judging the uclamp value before setting uclamp_min/max, avoid
the cpu.uclamp.min is bigger than cpu.uclamp.max.

Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
---
 kernel/sched/core.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 5226cc26a095..520a2da40dc9 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8867,6 +8867,30 @@ static ssize_t cpu_uclamp_write(struct kernfs_open_file *of, char *buf,
 	rcu_read_lock();
 
 	tg = css_tg(of_css(of));
+
+	switch (clamp_id) {
+	case UCLAMP_MIN: {
+		unsigned int uc_req_max = tg->uclamp_req[UCLAMP_MAX].value;
+
+		if (req.util > uc_req_max) {
+			nbytes = -EINVAL;
+			goto unlock;
+		}
+		break;
+	}
+	case UCLAMP_MAX: {
+		unsigned int uc_req_min = tg->uclamp_req[UCLAMP_MIN].value;
+
+		if (req.util < uc_req_min) {
+			nbytes = -EINVAL;
+			goto unlock;
+		}
+		break;
+	}
+	default:
+		nbytes = -EINVAL;
+		goto unlock;
+	}
 	if (tg->uclamp_req[clamp_id].value != req.util)
 		uclamp_se_set(&tg->uclamp_req[clamp_id], req.util, false);
 
@@ -8878,7 +8902,7 @@ static ssize_t cpu_uclamp_write(struct kernfs_open_file *of, char *buf,
 
 	/* Update effective clamps to track the most restrictive value */
 	cpu_util_update_eff(of_css(of));
-
+unlock:
 	rcu_read_unlock();
 	mutex_unlock(&uclamp_mutex);
 
-- 
2.25.1

