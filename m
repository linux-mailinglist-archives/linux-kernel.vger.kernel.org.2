Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D780236FD6F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 17:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbhD3PPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 11:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbhD3PPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 11:15:06 -0400
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD1AAC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 08:14:17 -0700 (PDT)
Received: by mail-wm1-x349.google.com with SMTP id b16-20020a7bc2500000b029014587f5376dso2100922wmj.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 08:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=R9A0FFHMxGak+rogDjXG1194mPgT82uPpYtaWutuk44=;
        b=bF9llhs8keQZLeZb1rULfFR6RXdo3OGXFzcD46QMcHJEq+mENPol5dgQ5zpDTV5LFY
         b+TdIt8ntPz6+hU7Wp7V9gAWsAiyuU4sq5G8qs67J+X/K0El2v73irFtdC8glrIEs0w7
         gaG3SijwVaKyZ5TIzrKTeXrRxzpd0mjM5PCg8ZOYMpjbAp7sp3+Sf9ujKJl8FZeTwSks
         iUma/Kxg0z/KxwGsLiuEMd/K3KkzrJ/LWniV5XDPdfsujuXGzr2xUHb6sDRaXj+9JQ/d
         Fqw6IoliXH35GwonqJiFCm+S16XVDL6JVJ2eqMhwXA6vgIp/MPMmHMyamh9GZfaUf6bh
         enYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=R9A0FFHMxGak+rogDjXG1194mPgT82uPpYtaWutuk44=;
        b=PTefsjxEGlBqQe8r3nqusFzRs/e7Nwc/p6RxGBuL5zw5lGmSF56SvP0ey6jbViwOsY
         mevMLrx58L8qIOWoY3C+gEk1R2Vee8Pa1+ZMW5nv3GKr5OSztCOHyNfBTZT/QPEC2itb
         IekngHQsfiIeLugfaz+MKyrAM88GK2fXvbUSNtPg/mMFfOsuAFX4UEhdmajWHwh85fs9
         fI0kzCjdz7YITOQ2FhiaPaQLJKw3/kxJHiYYPqW3ONCiAYquqT6i0OIlYQIa2bB01tEZ
         pAv1p0d3pe9ednYLptoF+o+ubGbtIfi3BKKLgoZcv/xgKHsTIhTXhlgZ6e36bizOuZm4
         FjbA==
X-Gm-Message-State: AOAM533501LXmVdKJb5dWfdfvsiJw8bq5Q48NUjjZHikGLnzWWZL2Isg
        VrxzbagpVffBw3l6euVlSchqDyOaUhMG
X-Google-Smtp-Source: ABdhPJzWzEBxQ/TkaFJYFuwSAds1UbCagbUIle41a6jkUMcfZUkYazylW1NQvr0dh2YPOrQUoHQgW7bzX2jQ
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a1c:540b:: with SMTP id
 i11mr17201265wmb.40.1619795656278; Fri, 30 Apr 2021 08:14:16 -0700 (PDT)
Date:   Fri, 30 Apr 2021 15:14:12 +0000
Message-Id: <20210430151412.160913-1-qperret@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.527.g47e6f16901-goog
Subject: [PATCH v3] sched: Fix out-of-bound access in uclamp
From:   Quentin Perret <qperret@google.com>
To:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        juri.lelli@redhat.com
Cc:     dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, qais.yousef@arm.com,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        patrick.bellasi@matbug.net
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Util-clamp places tasks in different buckets based on their clamp values
for performance reasons. However, the size of buckets is currently
computed using a rounding division, which can lead to an off-by-one
error in some configurations.

For instance, with 20 buckets, the bucket size will be 1024/20=51. A
task with a clamp of 1024 will be mapped to bucket id 1024/51=20. Sadly,
correct indexes are in range [0,19], hence leading to an out of bound
memory access.

Clamp the bucket id to fix the issue.

Fixes: 69842cba9ace ("sched/uclamp: Add CPU's clamp buckets refcounting")
Suggested-by: Qais Yousef <qais.yousef@arm.com>
Signed-off-by: Quentin Perret <qperret@google.com>
---
Changes in v3:
 - Keep rounding div to improve fairness (Vincent)
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 98191218d891..c12ec648423e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -928,7 +928,7 @@ DEFINE_STATIC_KEY_FALSE(sched_uclamp_used);
 
 static inline unsigned int uclamp_bucket_id(unsigned int clamp_value)
 {
-	return clamp_value / UCLAMP_BUCKET_DELTA;
+	return min_t(unsigned int, clamp_value / UCLAMP_BUCKET_DELTA, UCLAMP_BUCKETS - 1);
 }
 
 static inline unsigned int uclamp_none(enum uclamp_id clamp_id)
-- 
2.31.1.527.g47e6f16901-goog

