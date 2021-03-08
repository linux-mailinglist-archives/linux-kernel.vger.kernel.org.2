Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 796593309F6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 10:08:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbhCHJHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 04:07:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbhCHJHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 04:07:30 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6040AC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 01:07:30 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id g4so6007167pgj.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 01:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=rio9oywo5wOO4WrAVB/UN3oilFTR2R4R6Vr0uKN6cks=;
        b=HOc5grBLgA+ZRASYLntuKJqmLM17ZiyL97DMJK1FLt3y9SbUv3HR1y9bP7VNAh7LYc
         hGMzPh3fdiirR1QkFRNPSQokeSeifJjbSJCCBtKh26Fa3bOlMLGvBQ6IDRov0bHIYmdT
         V1LXvCB8IEBRSRNqLLFXKDm5JLmEWij/cuDHtW9rug61n/7hVgsa9lV59B431QJub/MB
         ptFt5vG7TvvRxJ5BUaTlBGA2U+nA8ZKGxXXOTMNasyAPtE8FuK4Wz8xspjmjFEpVWJBv
         iSrE24IAKCz2q+QT67g6cQ5pFYT6gDoq3EhYp2Bn8Ga+sGAN4rbjtuoClws05XirLRvu
         SPxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rio9oywo5wOO4WrAVB/UN3oilFTR2R4R6Vr0uKN6cks=;
        b=QO3Cfk1R+79LGyqnvKbglEAycPVzMBbRhhYKLUZZ49F37yQzEXmUsAg2qSFuAoBQmn
         DEe+mqINzI8mr3vgkdgja6C7lkMNj+Yx/KDEdGYdjQ4SmiSzRaiSvaosohwKa1R63TFL
         5GICY51MOwJK95Ff3H7y6Jho9Ryb/y388KYX6jS8O+nOmzZsz/09FXK/I/tKNY5KLAIL
         /DTVoMg2/6Zy092/anj7tnPyqFkhbFjeHmxGSlHZUAthT+sg+2mC7DxAZoPFBvjzrC2u
         vmiV31MSNZuvyaxhzlvbJTHBCaIWSQeRcoyDniZ2Kuc1Yf71AbY5Lmu30gvkAHkBE2sj
         frLQ==
X-Gm-Message-State: AOAM5328Iye48yV1pqMWo3NIV07z6AT+uyV9o8EDPwdHGPMyLLKvPFh8
        B4+CUsOpQBKdheFC7Mf5XMg=
X-Google-Smtp-Source: ABdhPJx4r0fB0RLk/Qo6mRWj36/f3U85RpNQWE6AxHogrs4qnyw2tLUGMyOr+6BA3TixqMdSGryazA==
X-Received: by 2002:a63:5962:: with SMTP id j34mr19434247pgm.331.1615194449905;
        Mon, 08 Mar 2021 01:07:29 -0800 (PST)
Received: from localhost.localdomain ([45.135.186.99])
        by smtp.gmail.com with ESMTPSA id m5sm8357274pfd.96.2021.03.08.01.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 01:07:29 -0800 (PST)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie, daniel@ffwll.ch,
        chris@chris-wilson.co.uk, matthew.auld@intel.com
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] gpu: drm: i915: fix error return code of igt_threaded_blt()
Date:   Mon,  8 Mar 2021 01:07:22 -0800
Message-Id: <20210308090722.8392-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When kcalloc() returns NULL to tsk or thread, no error code of 
igt_threaded_blt() is returned.
To fix this bug, -ENOMEM is returned as error code.

Fixes: 0e99f939f08f ("drm/i915/selftests/blt: add some kthreads into the mix")
Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/gpu/drm/i915/gem/selftests/i915_gem_object_blt.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/selftests/i915_gem_object_blt.c b/drivers/gpu/drm/i915/gem/selftests/i915_gem_object_blt.c
index 23b6e11bbc3e..b54ba8a1fcec 100644
--- a/drivers/gpu/drm/i915/gem/selftests/i915_gem_object_blt.c
+++ b/drivers/gpu/drm/i915/gem/selftests/i915_gem_object_blt.c
@@ -471,11 +471,13 @@ static int igt_threaded_blt(struct intel_engine_cs *engine,
 
 	tsk = kcalloc(n_cpus, sizeof(struct task_struct *), GFP_KERNEL);
 	if (!tsk)
-		return 0;
+		return -ENOMEM;
 
 	thread = kcalloc(n_cpus, sizeof(struct igt_thread_arg), GFP_KERNEL);
-	if (!thread)
+	if (!thread) {
+		err = -ENOMEM;
 		goto out_tsk;
+	}
 
 	thread[0].file = mock_file(engine->i915);
 	if (IS_ERR(thread[0].file)) {
-- 
2.17.1

