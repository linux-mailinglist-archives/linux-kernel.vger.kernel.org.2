Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96FC745A155
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 12:22:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236082AbhKWLZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 06:25:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234580AbhKWLZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 06:25:52 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 667CDC061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 03:22:44 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id fv9-20020a17090b0e8900b001a6a5ab1392so2627702pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 03:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vhPW0YtcaTnHaaY0ZoKEimkD5ekl0wlo2OX6rNbIzc8=;
        b=cn5F/Saxtzf+dnF0Qm44lcxvOcSKLpORZGWgKq/BVCB4h62wqtd1R6r2neF8k3w0mc
         z/2i4y6ebmwZvf9HYABC4nx0GMt/HsEj1kuUr5YwR60K1gh1bfSZmDgOwN/4FR6v18tj
         GqR5k4kyzcv+xJ8L3dYUqdlc0FGIc5gsxO1Zqmsf4wE19j2tpUyD1CsiXMjBgnLzJAI+
         mIuITt7BV4ENr85MNvWRvCjT+tTwvPGsDJtxWnbah11gis+dphJ1xkVzQRMQYc0Mq/ew
         WpUIZ69ZIH1LSZodO51IOjK+LzHRlWh13XKsSokYPxAVoqp3lbP6I/JKSKS/2bjodsWw
         Vb9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vhPW0YtcaTnHaaY0ZoKEimkD5ekl0wlo2OX6rNbIzc8=;
        b=hyX79S2LrfU/2CpZvbZRsoptMG8+URTHZwAI6HGV1Ui+M+HSpld+LehwnXSj6eHg5D
         5uw1OJiN+8Tj7YlykHW3+5mCoEs+Z8gZWhZm8DBR1QkYSKhjIfDDTRUr2bSSrtF+B94c
         WRtZmyiqipZ4L6hwVguIrNo7KlmGVMbHGB/4e4zXvQj5UUjA+FZ15lmGKk886Xx7Tgvg
         iCuHzBo0KOJVkOaHCOvzjTqrG6hIMuruWVxI9G97z3iZrWMB8oHtEmxKyrmAbLahZ1iZ
         rx/6hOiYbzDeI6FPRBptRUDQnayBSbFHUMgG4qz6DkfDKDnvLosJZuk/KVnoCoPrunIq
         i4iw==
X-Gm-Message-State: AOAM533POHMRWZ/IAzt3YUTBz4iVYFGKzV2VL9s3evBCMJ2/ENASkme5
        9CQVVdVe/hfxeCFFrYId30iqhI3a3VolIw==
X-Google-Smtp-Source: ABdhPJzwxeIeTqHbhXp5R+eV6V6NZi/7KfZOHtNXp2kUMPF6lb2Om3MaG9OCLhDSRTVIIeY176KHOw==
X-Received: by 2002:a17:90b:1c86:: with SMTP id oo6mr1872395pjb.165.1637666563981;
        Tue, 23 Nov 2021 03:22:43 -0800 (PST)
Received: from baohua-VirtualBox.localdomain (47-72-151-34.dsl.dyn.ihug.co.nz. [47.72.151.34])
        by smtp.gmail.com with ESMTPSA id il7sm1098595pjb.54.2021.11.23.03.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 03:22:43 -0800 (PST)
From:   Barry Song <21cnbao@gmail.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org
Cc:     dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, Barry Song <song.bao.hua@hisilicon.com>
Subject: [PATCH] sched/fair: Remove the cost of a redundant cpumask_next_wrap in select_idle_cpu
Date:   Tue, 23 Nov 2021 19:22:29 +0800
Message-Id: <20211123112229.7812-1-21cnbao@gmail.com>
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
 kernel/sched/fair.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ff69f24..e2fb3e0 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6298,9 +6298,9 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
 
 		span_avg = sd->span_weight * avg_idle;
 		if (span_avg > 4*avg_cost)
-			nr = div_u64(span_avg, avg_cost);
+			nr = div_u64(span_avg, avg_cost) - 1;
 		else
-			nr = 4;
+			nr = 3;
 
 		time = cpu_clock(this);
 	}
@@ -6312,11 +6312,11 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
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

