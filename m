Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBE1035DA9C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 11:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244095AbhDMJDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 05:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240161AbhDMJDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 05:03:30 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C58C06138C
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 02:03:09 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id u4so18534689ljo.6
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 02:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uged.al; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SY4sqotEknC2i6pL+rlRoKqg/a1bJa4Vth62OIkfAoQ=;
        b=uxWTujCWfNBeN/O4X+ntEhKXR936PgNw8iSl4QEH+vCqE24dWezDXJ5p7WmD0nifNV
         13RPIgq8FCe5WiqzrGG9mYC+LTWfv854+V1guX2HA8czTlmwab74maIxGVos9YgK4qpp
         x6NKH75ghp5ZDs2sadWAAR67QY73AS+aI80VF8xuQyio4XnAG/0R44OutaPx04sJttVd
         Vu58VEnVDbO06/xTZsRk6fKVx2pZ7ZoQ/NjQct93M59xTtIK3naz7iG0+kuCVuIbv6nn
         2l4dGWfbawnrcCHrKNIYRNTAMVc+CoyD3I27q7JqsED7dvLrA8hKdCdmdARfnDR1WS/e
         kfeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SY4sqotEknC2i6pL+rlRoKqg/a1bJa4Vth62OIkfAoQ=;
        b=qApRezuDcEzyM+6Km1dZZsjRylfjWrAKpKcqdW82a5ei3t4LxSo8RZ8BqIDPHdZCpp
         O7AS0BjnOibH+jM/uG1FYY/UKE9QgQHzUOqyGbekm0iGEiimIsaC27K1kYGlgzwdcx+M
         6kSQsdwLlak6621SnGesOtnTw5Ueia80+K/bVdgeyhCga0N6sJBqZDN8SXFgU7nInM0b
         Hlq83wVL6T4dB5Gdq2VSS2Df4U0bQGMfLivEcx3kHCYbmWw2uciK57WW0OwiLBJdV444
         kvq+OYZEmUMmxvC+o1BqKOD0khwMkkFxa036DIeTO1vmmeeO+EVA7AdUvG6EA7q6IFFM
         4/5w==
X-Gm-Message-State: AOAM530Ge0RZDJ5EQOiONN/YZm7+/OfAOijH3EeWgrVKFe3UDraevap2
        SUV4hOWgwBgAufnheIYZc1Lg6w==
X-Google-Smtp-Source: ABdhPJzfcDC1QmFeVBdVvPaUOSXsUyovVHa0wrWKVmzm0/16NQFzG7So3+md+TiskjTAEgulGecShg==
X-Received: by 2002:a2e:9cc2:: with SMTP id g2mr3903189ljj.245.1618304588393;
        Tue, 13 Apr 2021 02:03:08 -0700 (PDT)
Received: from xps.wlan.ntnu.no ([2001:700:300:4008:3fb5:15ad:78ca:d9c1])
        by smtp.gmail.com with ESMTPSA id o11sm3722912ljg.42.2021.04.13.02.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 02:03:08 -0700 (PDT)
From:   Odin Ugedal <odin@uged.al>
To:     tj@kernel.org, lizefan.x@bytedance.com
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Odin Ugedal <odin@uged.al>
Subject: [PATCH 2/2] cgroup2: cpuset: Always allow setting empty cpuset
Date:   Tue, 13 Apr 2021 11:02:35 +0200
Message-Id: <20210413090235.1903026-3-odin@uged.al>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210413090235.1903026-1-odin@uged.al>
References: <20210413090235.1903026-1-odin@uged.al>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to how cpuset works in v2, there is no need to disallow setting an
empty cpuset when tasks are attached. In v2, the effective cpuset of a
cgroup is the intersection between the effective value of the parent and
the cpuset.cpus value of the cgroup, with a fallback to the effective
parent value in case the intersection is an empty set.

Allowing this will make it easier to move the cpuset of a nested cgroup
hierarchy where multiple cgroup use the cpuset.cpus, since the current
solution is to manually update the cpuset of each cgroup when doing this,
causing it be quite complex to change. It also makes it possible to
disable cpuset for a populated cgroup (or one of its ancestors), without
having to manually write the effective value into cpuset.cpus.

This also applies in a similar manner on cpuset.mems.

Signed-off-by: Odin Ugedal <odin@uged.al>
---
 kernel/cgroup/cpuset.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index f543c4c6084a..33a55d461ec3 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -609,11 +609,12 @@ static int validate_change(struct cpuset *cur, struct cpuset *trial)
 	}
 
 	/*
-	 * Cpusets with tasks - existing or newly being attached - can't
-	 * be changed to have empty cpus_allowed or mems_allowed.
+	 * On legacy hierarchy, cpusets with tasks - existing or newly being
+	 * attached - can't be changed to have empty cpus_allowed or
+	 * mems_allowed.
 	 */
 	ret = -ENOSPC;
-	if ((cgroup_is_populated(cur->css.cgroup) || cur->attach_in_progress)) {
+	if (!is_in_v2_mode() && (cgroup_is_populated(cur->css.cgroup) || cur->attach_in_progress)) {
 		if (!cpumask_empty(cur->cpus_allowed) &&
 		    cpumask_empty(trial->cpus_allowed))
 			goto out;
-- 
2.31.0

