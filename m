Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7BD345B734
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 10:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241430AbhKXJTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 04:19:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233439AbhKXJTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 04:19:10 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFCE7C061574
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 01:16:00 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id np6-20020a17090b4c4600b001a90b011e06so2032135pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 01:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vpWDTC9TwRzJZvmNFiV3o1UcT2PSTzU0txHmJdlLF3M=;
        b=OBxn0TbGxfuFHxLwwnLYsQNBr9FLMVE7oaZxKaxiuZMMdujlb+hPzdTv3G0G/Lmbqu
         NRboLRlb5K7Vk8HDTVzj/0am4rQBs+yQph12SlPpfn/b3t7LozJcbLUAszykqy7ixgn2
         yscMQZPj9G9liaT4L//5MfMA/fdRFhqMW5o+nrCEV0l0wlBosRhMMd+A/DgrrpQ6DiWx
         W1IesovgEYJoB0/4qdxK1wBw1hjCCKspoRM38KkIlvAboAGtlltXqKe4HJ9yvyBtOG/m
         tqCnmbBbFuHywjdF4CG14dEoNhAnp+gZe/tJma1VK27bTpLLRleOgmM5MEf/9hP0qE7c
         4+cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vpWDTC9TwRzJZvmNFiV3o1UcT2PSTzU0txHmJdlLF3M=;
        b=pHQ2JogRwnKTy2MUAeFCp/r51GIASSEZhn0QrxiZY2T+KvHEus/pS+hLSQBFuNhzii
         kcVDHWnhMxpO34XDigjOTgXwYXCbILL29mcCApjPSEh1mgxy1ngwoqbY9IhLIiuEUE0C
         Tkqy4Ra8t9rov31R40TWruXPKp10RgP4jrWjTuuMnPYJHrD9zHMAN0EevEiyCyCkhn+f
         y3hdBadW3gU7ORBQXiYYSo65PPDA65k3j+/A68Pk0r6WOTgoAWl4vxuQlOCXKRmemA11
         gHpYSaeytox/UH1csPG0EKRxIqjPL6M2WAxuF4PPmbieDJwtQdQgHL47KInfJPCFwIMp
         bEuw==
X-Gm-Message-State: AOAM5318SatmsrE+OKttPTZAh3iyAWZiytohuvsaEIMmsYGyP1vpJ+mG
        uluxEr1rrn6Yd9SBoXH7ycs=
X-Google-Smtp-Source: ABdhPJxCF1+TNn5jg+vIIMtv6J8LDslLLIW1yHmvxg1P9ZszjSo9r4w0wqv9zVi+8CmxpE8EAfPkIA==
X-Received: by 2002:a17:902:9694:b0:143:6f27:29ad with SMTP id n20-20020a170902969400b001436f2729admr16780940plp.46.1637745360350;
        Wed, 24 Nov 2021 01:16:00 -0800 (PST)
Received: from baohua-VirtualBox.localdomain (47-72-151-34.dsl.dyn.ihug.co.nz. [47.72.151.34])
        by smtp.gmail.com with ESMTPSA id l6sm6757787pfc.51.2021.11.24.01.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 01:15:59 -0800 (PST)
From:   Barry Song <21cnbao@gmail.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org
Cc:     dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, Barry Song <song.bao.hua@hisilicon.com>
Subject: [PATCH v2] sched/fair: Remove the cost of a redundant cpumask_next_wrap in select_idle_cpu
Date:   Wed, 24 Nov 2021 17:15:46 +0800
Message-Id: <20211124091546.5072-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Barry Song <song.bao.hua@hisilicon.com>

This patch keeps the same scanning amount, but drops a redundant loop
of cpumask_next_wrap.
The original code did for_each_cpu_wrap(cpu, cpus, target + 1), then
checked --nr; this patch does --nr before doing the next loop, thus,
it can remove a cpumask_next_wrap() which costs a little bit.

Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
---
 -v2: make code clearer with respect to Peter's comment

 kernel/sched/fair.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6e476f6..8cd23f1 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6278,6 +6278,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
 		time = cpu_clock(this);
 	}
 
+	--nr;
 	for_each_cpu_wrap(cpu, cpus, target + 1) {
 		if (has_idle_core) {
 			i = select_idle_core(p, cpu, cpus, &idle_cpu);
@@ -6285,11 +6286,11 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
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

