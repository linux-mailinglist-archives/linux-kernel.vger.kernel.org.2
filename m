Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 808F535DA9B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 11:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243689AbhDMJDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 05:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbhDMJD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 05:03:29 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D6CC06175F
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 02:03:08 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id f17so19082080lfu.7
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 02:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uged.al; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4iJUYo21aTslz6Z8Ta9PIHGPXdm8gkXi8+0HPXoSBsQ=;
        b=VD1IkuKhEvpeeF08omMrTP4Zn1dGCpJFSkgyvFwfXaYHJ7c/DULWvIUG3ZDl1jhk5N
         SrJ/virX6o+L0WmJVF9o57v9OGLLJCUI+2M4H4NXnrW1UINI6LOr1fBFjFDPp7+SOfkH
         EbC+WgNXCK0PFEllFpyKjnunx9Chn7otj8uCsnlim9/NlCmap6FTOU/p18miIowlpBND
         HJJIAw7oVmTxLguV2vEsWwH4D2iwYTt7shERHYNrJT+/7kr+sWxK5C8pYlNLYCzfafbZ
         Dqa7J1ho/Y8msY+HCLR0mmCF0Om9SVM7kw+bt3amoVS+wfzNfBRdIVjcXJ+i1bRcoJd4
         25dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4iJUYo21aTslz6Z8Ta9PIHGPXdm8gkXi8+0HPXoSBsQ=;
        b=frLW3mWuu68GLCs2rwh+umzvWvX876H1yf4WsC++nWdrvJYjSLz4LOtZlXx5T5sTrj
         73OyMCZ9WMbjjLlDBrqr1ZJNzKjPrUqyne/SqSW6TI9x306e+wUZWmBnlrXK7AZaIcY6
         HUxuAa7OjbYeXkrhDu7db7T0EdAbcvBGy1snTjQpBC9kWf7fdz/yQMWFa8jmVEYK+cc6
         tHTd1MF5o9hqcygkXJvjsZQ+sCsffKMtEJzGfLUC7AJ42MuNqT5f1P9pjvgr3Gl9OVrh
         337gzoU+Nq6m4nzEpNSiMlUe4a8+BpwKQF1mZmIMCWVF0/4JsYQJgJzAVuiuaRA8T4YO
         oZsw==
X-Gm-Message-State: AOAM530IdhyOXhjEVaoRSAF34GGOvQR5NYSYEmJa5WokjLweq6deaLpr
        hKgT7VhvkM8iBpuIUt9dUFp4xQ==
X-Google-Smtp-Source: ABdhPJwik2MYPYcshYBqspqTNhWGHWi2kTbAmtGMNd1gXN6tTL3Cvz94rMnNRnvmuOcUr2Z/xBUcqA==
X-Received: by 2002:a19:6d07:: with SMTP id i7mr21957674lfc.568.1618304587073;
        Tue, 13 Apr 2021 02:03:07 -0700 (PDT)
Received: from xps.wlan.ntnu.no ([2001:700:300:4008:3fb5:15ad:78ca:d9c1])
        by smtp.gmail.com with ESMTPSA id o11sm3722912ljg.42.2021.04.13.02.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 02:03:06 -0700 (PDT)
From:   Odin Ugedal <odin@uged.al>
To:     tj@kernel.org, lizefan.x@bytedance.com
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Odin Ugedal <odin@uged.al>
Subject: [PATCH 1/2] cgroup2: cpuset: Disable subset validation on set
Date:   Tue, 13 Apr 2021 11:02:34 +0200
Message-Id: <20210413090235.1903026-2-odin@uged.al>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210413090235.1903026-1-odin@uged.al>
References: <20210413090235.1903026-1-odin@uged.al>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to how cpuset works in v2, there is no need to check if direct
children are subsets of the new cpuset. In v2, the effective cpuset
of a cgroup is the intersection between the effective value of the parent
and the cpuset.cpus value of the cgroup, with a fallback to the effective
parent value in case the intersection is an empty set.

Therefore, in v2, it is allowed to set cpuset.cpus to a a value that is
not a subset of the parents effective value, resulting in inheriting the
effective cpuset from the parent. Therefore the validation when updating
the parent cpuset (in this case) is not necessary, and can be disabled.

Example:

  /sys/fs/cgroup/A     (cpus=1-2,cpus.effective=1-2)
  /sys/fs/cgroup/A/B   (cpus="", cpus.effective=1-2)

  Setting cpus to 3-4 is possible for A/B

  /sys/fs/cgroup/A     (cpus=1-2,cpus.effective=1-2)
  /sys/fs/cgroup/A/B   (cpus=3-4,cpus.effective=1-2)

  Setting cpus to 1 for A would result in an -EBUSY error, but
  with this patch it will work as expected:

  /sys/fs/cgroup/A     (cpus=1,  cpus.effective=1)
  /sys/fs/cgroup/A/B   (cpus=3-4,cpus.effective=1)

This also applies in a similar manner on cpuset.mems.

Signed-off-by: Odin Ugedal <odin@uged.al>
---
 kernel/cgroup/cpuset.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 5258b68153e0..f543c4c6084a 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -572,11 +572,13 @@ static int validate_change(struct cpuset *cur, struct cpuset *trial)
 
 	rcu_read_lock();
 
-	/* Each of our child cpusets must be a subset of us */
+	/* On legacy hierarchy, each of our child cpusets must be a subset of us */
 	ret = -EBUSY;
-	cpuset_for_each_child(c, css, cur)
-		if (!is_cpuset_subset(c, trial))
-			goto out;
+	if (!is_in_v2_mode()) {
+		cpuset_for_each_child(c, css, cur)
+			if (!is_cpuset_subset(c, trial))
+				goto out;
+	}
 
 	/* Remaining checks don't apply to root cpuset */
 	ret = 0;
-- 
2.31.0

