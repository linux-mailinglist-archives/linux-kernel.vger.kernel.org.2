Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE86E42E795
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 06:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234215AbhJOEQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 00:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233083AbhJOEQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 00:16:41 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC512C061570
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 21:14:35 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id v8so3163161pfu.11
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 21:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Si9ouXlXyI21h1ATzxm32s1noPryMBQu12dZAHuCiSI=;
        b=Hp4v4euUd7ul9q1hL3fqCIwqMgN+jbR32+hImETHLGmz35MNo0PZEW8gz7WPwtSENW
         YBe6eYE0aljM2NycLTLkbrTXiMd7/EHQNuUDjkwMgNpqv87V+9xfYreyaxWDGgLx0czH
         q49zMs+M7DEpBv++56JbBsAtvwPfYXzM2Wm9Xb1nvqNk2AnaonB1qgD8sEglx7grid/D
         v4Iq/q3ooiacnhL3dxC7guq/i1SyHwZjGqBzfEhKhmdq5mPjLzWtbShr68gwV1OGS2CG
         LVQHj+B7Gqwm2uERTyXrpE9wSK5YC7EDhQyJY0JSKZbsHp5mGTtKBd6Ghd92BPyAh+Xz
         8wzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Si9ouXlXyI21h1ATzxm32s1noPryMBQu12dZAHuCiSI=;
        b=GTbXF+VWkWOrVVfg4DfVIXBkchc6FfjRp7KQMcTjbs0O/Lu5OftoAWCCf8s/DqeuZA
         JRoLKVnfdYS2Nbn7AiEKUrE2u/dYPf+maJTRX59FsgxEPqpw7QKa34QHnttxiQlGR6Hb
         jW5LuyWNVRq1H8Tm3ytOdpzxcjACr0xqizgkxIyXO5hz5uv1ABlj3JH2V7Wd3lT2fchT
         OLvn8bNJetmkh2WNYSTcwFMbIupYpOiBEby7EnZCsSqezEpnxab25JP51A8M/G0ID9oe
         T+keNYinQWXTLr7T1CxZb24tkQHLsjdutT5CW83Rq0di/GcYM32ynqUmZqnlyxYKhJLZ
         OoXw==
X-Gm-Message-State: AOAM530KyDG8Amfmf7LF2LzNVzo1kmFFpciv3HELo/cfu1IBj3pRTfa3
        HuekgxayPyFLrPDM7pcwFDQ=
X-Google-Smtp-Source: ABdhPJz9cdiz3oIXM1tM3X2Gi6jljFff4Y9w090ty6ICAhh7xl2QHCnRKoVPkbRjQ8TgcGGnZW0FEA==
X-Received: by 2002:a05:6a00:1488:b0:44d:25b2:f80b with SMTP id v8-20020a056a00148800b0044d25b2f80bmr9410866pfu.20.1634271275000;
        Thu, 14 Oct 2021 21:14:35 -0700 (PDT)
Received: from baohua-VirtualBox.localdomain (203-173-222-16.dialup.ihug.co.nz. [203.173.222.16])
        by smtp.gmail.com with ESMTPSA id 3sm10801746pjk.18.2021.10.14.21.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 21:14:34 -0700 (PDT)
From:   Barry Song <21cnbao@gmail.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        yangyicong@hisilicon.com, Barry Song <song.bao.hua@hisilicon.com>
Subject: [PATCH] sched/fair: document the slow path and fast path in select_task_rq_fair
Date:   Fri, 15 Oct 2021 12:14:12 +0800
Message-Id: <20211015041412.5569-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Barry Song <song.bao.hua@hisilicon.com>

All people I know including myself took a long time to understand typical
wake_up will always go to fast path and never go to slow path except
FORK and EXEC.
Vincent reminded me once in a linaro meeting and it made me understand
slow path won't happen for WF_TTWU. But my other friends repeatedly
wasted a lot of time on testing this path like me before I reminded
them.
So obviously the code needs some document.

Cc: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
---
 kernel/sched/fair.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f6a05d9b5443..ccf8f73dd4d1 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6951,6 +6951,11 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
 			break;
 		}
 
+		/*
+		 * This is usually true only for WF_EXEC and WF_FORK, for WF_TTWU
+		 * it is almost always false as sched_domain hasn't SD_BALANCE_WAKE
+		 * in default
+		 */
 		if (tmp->flags & sd_flag)
 			sd = tmp;
 		else if (!want_affine)
@@ -6958,7 +6963,11 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
 	}
 
 	if (unlikely(sd)) {
-		/* Slow path */
+		/*
+		 * Slow path, usually only for WF_EXEC and WF_FORK; WF_TTWU almost
+		 * always goes to fast path as sched_domain hasn't SD_BALANCE_WAKE
+		 * in default
+		 */
 		new_cpu = find_idlest_cpu(sd, p, cpu, prev_cpu, sd_flag);
 	} else if (wake_flags & WF_TTWU) { /* XXX always ? */
 		/* Fast path */
-- 
2.25.1

