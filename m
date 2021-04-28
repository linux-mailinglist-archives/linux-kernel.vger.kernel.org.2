Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6A9C36DE41
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 19:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241603AbhD1R2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 13:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232057AbhD1R2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 13:28:16 -0400
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76499C061573
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 10:27:29 -0700 (PDT)
Received: by mail-wr1-x44a.google.com with SMTP id 93-20020adf83660000b029010d6b1e0949so2139772wrd.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 10:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=fOcUtl0F4jF4M8hpSc7lJv+2aC5W42lSCrpVyPBZlj4=;
        b=Lw4h45m6Kl3SUh3Yh7+RRQVaQorf0sDKIRMPTZw5D/NaFpmbNopX+/85rIXJWMoyO2
         JOCQlUiPrmbxFFR70InDEEzhhUWAhosDAvtBbidPBYZ/VwTRnkM6V8Lmvd56J9PG7B19
         umdu2R44oCA0LhodR2U5/KC+SWkHmb56441h1TAiw3Cnex//A4IHDwYfroq/Jma/w/li
         mTsCMr0q6yFJBUtHLjznJnyxV7UxgK69tVhOkehSheK31Gjw7K0ZdKwP9O4KVhsEPFnN
         v4r0Tv5f5mXjSBoqogorTFnCgu0NPnHeSDX9Fv0X6lxXb50ITqt8Y2kW0x4VH787p4B5
         Q/Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=fOcUtl0F4jF4M8hpSc7lJv+2aC5W42lSCrpVyPBZlj4=;
        b=LDX4XcTZNfdEgN46588DklREz5gOMpMHer2hsE4AlVpfYwhX1e6VP/0ALcCAyGmsTQ
         AYh50WhBSja2nNdmb/1T5WQvqoXXNtUOINXVn8POn7EibTDAjPnMzfkxun/nQN2u7Ghg
         0MNtPCyGZpHZNT5945Qr4o5khf4cjuRbYTvFNWBGTvFYDR0l5mRYuuH3nadkEADdNTFu
         VPEVFh6sOQUf8YFgiAe6AOcUsQ4d/z9XEuoJkzde4dZyWFTFdcMtkcsZnL0JDLo4g/ZN
         aGuTDggwf+ymgTvooDzvL3wOJ/0vOyEYqt+CsUoWuy4GcHNCLsXDzVAi8uIyqbQer6BF
         VL+g==
X-Gm-Message-State: AOAM533XHrt9svilDV2+Ge88D/kOTl5Lr289s/FHZmho3tcTlSjwB3Np
        2iv+mYAmRI/EWBOhbov+FzC9hWMDijlR
X-Google-Smtp-Source: ABdhPJzKoo3nM4B4x3dY3Iq7TaRwxKn5S/3BZ9a6T/xmzwCIVP1mr8CLkCzNXLL9WTd8hjtlISzH/eFNfm15
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a1c:c915:: with SMTP id
 f21mr630389wmb.0.1619630846173; Wed, 28 Apr 2021 10:27:26 -0700 (PDT)
Date:   Wed, 28 Apr 2021 17:27:22 +0000
Message-Id: <20210428172722.3908735-1-qperret@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
Subject: [PATCH] sched: Fix out-of-bound access in uclamp
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

For instance, with 20 buckets, the bucket size will be 1024/20=51.2,
rounded to the closest value: 51. Now, a task with a clamp of 1024 (as
is the default for the min clamp of RT tasks) will be mapped to bucket
id 1024/51=20 as we're now using a standard integer division. Sadly,
correct indexes are in range [0,19], hence leading to an out of bound
memory access.

Fix this by using a rounding-up division when computing the bucket size.

Fixes: 69842cba9ace ("sched/uclamp: Add CPU's clamp buckets refcounting")
Suggested-by: Qais Yousef <qais.yousef@arm.com>
Signed-off-by: Quentin Perret <qperret@google.com>

---

This was found thanks to the SCHED_WARN_ON() in uclamp_rq_dec_id() which
indicated a broken state while running with 20 buckets on Android.

Big thanks to Qais for the help with this one.
---
 kernel/sched/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 98191218d891..ec175909e8b0 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -920,8 +920,7 @@ static struct uclamp_se uclamp_default[UCLAMP_CNT];
  */
 DEFINE_STATIC_KEY_FALSE(sched_uclamp_used);
 
-/* Integer rounded range for each bucket */
-#define UCLAMP_BUCKET_DELTA DIV_ROUND_CLOSEST(SCHED_CAPACITY_SCALE, UCLAMP_BUCKETS)
+#define UCLAMP_BUCKET_DELTA DIV_ROUND_UP(SCHED_CAPACITY_SCALE, UCLAMP_BUCKETS)
 
 #define for_each_clamp_id(clamp_id) \
 	for ((clamp_id) = 0; (clamp_id) < UCLAMP_CNT; (clamp_id)++)
-- 
2.31.1.498.g6c1eba8ee3d-goog

