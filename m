Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F11D23B2DBF
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 13:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232414AbhFXLYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 07:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232530AbhFXLYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 07:24:15 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC3AC061574
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 04:21:55 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id p7so9681345lfg.4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 04:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uged.al; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=esYbPkZY+mNiFhPIhgBGY1PmVNh7PO+rv7V8GnoEFCg=;
        b=X/HQaJrIZ06jeuSz3cH4rp7eZAK3xlI/dyWeZfUwpdtm7SYCcQL66lo6aRE8yPGfxv
         KPkvFf+8nsnANFx9PR7AHklQad3m/kQ1x0R8xBfGB1RuIirsV4wG+IfrqKXXUF7P+hp6
         yBdAeOeawtiM+pG0wZLewjSfHrUsaNEiQYhZoj0okho/wcGP+L+RMUNj0FvbVxJ7/L6J
         4IU5n0kgSJ635dRv6NieClAxiApvvHqYmpmmWz7ue0jGjWXfYVMeQxP9Dsuz9Y84H5mw
         7sJuKSy7KvU+50WYBipIKaDydW0vDRBz4j2IYWqFK6uxb4wBZWKqT4vz+z/4+rjshX9Z
         piMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=esYbPkZY+mNiFhPIhgBGY1PmVNh7PO+rv7V8GnoEFCg=;
        b=RtFE9lrS3nvxBfn0DB4n4lSgnaZH2JkOnDreBHy7gHcZHKYgGyw4MZ1eBJFxZSfL8M
         XZ0IvI4+1HZRcDWzd5v3UzeXJ1dZJHfzLmKxOWRGE0Yaups4bYVeU45CQW6cZuq+eQlN
         JHLbnBWnz7Y3oaxwJo/oeUVh3kOdCEyCAKoAOTFkUJOfxdfpNrpCuwK3NeiR4npsCOJq
         wDXzl8Rbx6HgcAWlVPt3S42dR8qvgZSh3cjU7CGjBVjLCv8LFF/EMSM+FfVt/qiAdYwK
         3OpjgVbqyNHBlRoieWwTzMEyJYzbQzylql6L/CF36BzL6gVI+vwGesghCvPS/c6Ts+h8
         ko3A==
X-Gm-Message-State: AOAM533ZTqM7U04NGtCjgTWh6ek38cmPymrYHs5pJYWuE6xARgeR6cEK
        z5pF0q/V/abs5U0OFXGONxkrPA==
X-Google-Smtp-Source: ABdhPJwJaCL6DqaFALLWUimas3bankdPahP9aJuuerfgUeQbOQcd0JWWjc68rLVWtTOHdkGj1AAXqw==
X-Received: by 2002:ac2:4d2d:: with SMTP id h13mr3519828lfk.456.1624533713869;
        Thu, 24 Jun 2021 04:21:53 -0700 (PDT)
Received: from localhost.localdomain (ti0005a400-2351.bb.online.no. [80.212.254.60])
        by smtp.gmail.com with ESMTPSA id q21sm196923lfp.233.2021.06.24.04.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 04:21:53 -0700 (PDT)
From:   Odin Ugedal <odin@uged.al>
To:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Sachin Sant <sachinp@linux.vnet.ibm.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org, Odin Ugedal <odin@uged.al>
Subject: [PATCH] sched/fair: Ensure _sum and _avg values stay consistent
Date:   Thu, 24 Jun 2021 13:18:15 +0200
Message-Id: <20210624111815.57937-1-odin@uged.al>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The _sum and _avg values are in general sync together with the PELT
divider. They are however not always completely in perfect sync,
resulting in situations where _sum gets to zero while _avg stays
positive. Such situations are undesirable.

This comes from the fact that PELT will increase period_contrib, also
increasing the PELT divider, without updating _sum and _avg values to
stay in perfect sync where (_sum == _avg * divider). However, such PELT
change will never lower _sum, making it impossible to end up in a
situation where _sum is zero and _avg is not.

Therefore, we need to ensure that when subtracting load outside PELT,
that when _sum is zero, _avg is also set to zero. This occurs when
(_sum < _avg * divider), and the subtracted (_avg * divider) is bigger
or equal to the current _sum, while the subtracted _avg is smaller than
the current _avg.

Reported-by: Sachin Sant <sachinp@linux.vnet.ibm.com>
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Signed-off-by: Odin Ugedal <odin@uged.al>
---

Reports and discussion can be found here:

https://lore.kernel.org/lkml/2ED1BDF5-BC0C-47CD-8F33-9A46C738F8CF@linux.vnet.ibm.com/
https://lore.kernel.org/lkml/CA+G9fYsMXELmjGUzw4SY1bghTYz_PeR2diM6dRp2J37bBZzMSA@mail.gmail.com/

 kernel/sched/fair.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index bfaa6e1f6067..def48bc2e90b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3688,15 +3688,15 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
 
 		r = removed_load;
 		sub_positive(&sa->load_avg, r);
-		sub_positive(&sa->load_sum, r * divider);
+		sa->load_sum = sa->load_avg * divider;
 
 		r = removed_util;
 		sub_positive(&sa->util_avg, r);
-		sub_positive(&sa->util_sum, r * divider);
+		sa->util_sum = sa->util_avg * divider;
 
 		r = removed_runnable;
 		sub_positive(&sa->runnable_avg, r);
-		sub_positive(&sa->runnable_sum, r * divider);
+		sa->runnable_sum = sa->runnable_avg * divider;
 
 		/*
 		 * removed_runnable is the unweighted version of removed_load so we
-- 
2.32.0

