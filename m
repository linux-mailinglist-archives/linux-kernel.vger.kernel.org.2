Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 271F836ED65
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 17:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240762AbhD2P1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 11:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232989AbhD2P1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 11:27:48 -0400
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8736FC06138B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 08:27:01 -0700 (PDT)
Received: by mail-wm1-x349.google.com with SMTP id z135-20020a1c7e8d0000b02901297f50f20dso1505636wmc.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 08:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=p0igZyrs5kNhrAalP/Bef9OTT/K+mc9eClA68h2BbGw=;
        b=g25g7eSv3DiOYvQLj9XcGvg72/wdAPGils2qsqtLeERwPsWbBt3tqc/oF6MYvyOzaQ
         Xz0ZMDjLqYlv85SfYdNgre/MZhNCsVPa5oWu4lrnDZlQGayGlxwZrup2hjX5As6ztpE8
         nrjSrVkBvPZPWN11HbodPTRC9P+49h7CFZRYMRxwU9DmEOt/jh7pOkQoPmBwDYtFONLT
         ZOSxrB9qFOGNLgKAEoxjNvICIV9ZS+0+rLlE5hrW9p7xEJQuLIECC88Xpv90x9uXF6U0
         Go5KX2EBQ0crdh+IenObEIeXhBZJ+oGuPdD/aaZDTOJ8mTNzwgYToOu679+51mHMNOQm
         DPZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=p0igZyrs5kNhrAalP/Bef9OTT/K+mc9eClA68h2BbGw=;
        b=g5JQ2LomUxH6T4HYYVu2oe0YplhVsvkci1Vg+d2O+mfFonJtPJFH35uoyHzjBhQrRC
         3TTZbG0uRGH4gY2B4w6tx2MVDlO5SwDxjYBnYT++btSU+ZWsh5QE8y2Zgyt6fQvw25wT
         w7rrf2SPbtoom/mE3IWLhAk5CxO4JTVvOnzGU1Pwbdfx4PNqcrUjJ31O6q+CZ/uGpB6o
         vlmlWawmTo+pxurIBNaZSXKcqDLg+IrO7iauuaG4KV6Pd/Q4wN1OqYoCWAcUmtH/Rn26
         7f4JbHmoPvhlth0QvvmN39PjYqZa3fl2sM4MdwaucG2XcNZWoJcAFDu06bHISdNzA5TF
         N3rg==
X-Gm-Message-State: AOAM532nuMLDtl9nlD+N7bpurSAF07q0OUcfPsvEDnFlaP2QuemF0T79
        /LUOAAMeXJALC88LeWej3IcsXE9kIaxp
X-Google-Smtp-Source: ABdhPJxGZl3J/RFxt6+Vl9aoO7k2oljSMnxglkps8BJDR/bwdVgtrSYGMYUXKftoy6ms3yYhy9QsfLnJaA9+
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a05:600c:499a:: with SMTP id
 h26mr643514wmp.176.1619710020173; Thu, 29 Apr 2021 08:27:00 -0700 (PDT)
Date:   Thu, 29 Apr 2021 15:26:56 +0000
Message-Id: <20210429152656.4118460-1-qperret@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
Subject: [PATCH v2] sched: Fix out-of-bound access in uclamp
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

Fix the math to compute the bucket size.

Fixes: 69842cba9ace ("sched/uclamp: Add CPU's clamp buckets refcounting")
Suggested-by: Qais Yousef <qais.yousef@arm.com>
Signed-off-by: Quentin Perret <qperret@google.com>

---

Changes in v2:
 - replaced the DIV_ROUND_UP(a,b) with a/b+1 (Dietmar)

This was found thanks to the SCHED_WARN_ON() in uclamp_rq_dec_id() which
indicated a broken state while running with 20 buckets on Android.

Big thanks to Qais for the help with this one.
---
 kernel/sched/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 98191218d891..c5fb230dc604 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -920,8 +920,7 @@ static struct uclamp_se uclamp_default[UCLAMP_CNT];
  */
 DEFINE_STATIC_KEY_FALSE(sched_uclamp_used);
 
-/* Integer rounded range for each bucket */
-#define UCLAMP_BUCKET_DELTA DIV_ROUND_CLOSEST(SCHED_CAPACITY_SCALE, UCLAMP_BUCKETS)
+#define UCLAMP_BUCKET_DELTA (SCHED_CAPACITY_SCALE / UCLAMP_BUCKETS + 1)
 
 #define for_each_clamp_id(clamp_id) \
 	for ((clamp_id) = 0; (clamp_id) < UCLAMP_CNT; (clamp_id)++)
-- 
2.31.1.498.g6c1eba8ee3d-goog

