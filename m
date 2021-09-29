Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8562441D05B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 02:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347465AbhI3ACU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 20:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347875AbhI3ACO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 20:02:14 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE53BC0613E8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 16:59:55 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id v19-20020a17090a459300b0019c6f43c66fso2324459pjg.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 16:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Dcjau/hIXBnPM9Af06JmbVmh73kSQdc3IIMbzh+4PDE=;
        b=aME0s4J8CEldFAgU7YcsJ53qLez9XxJx5csADRA2Wm3oBwhYaTKUbkROEMXnxGI2ZH
         ao2J4zn23rmQ5TE8+c0BfNwXwyFP4zLFgvQQ2ZQex7/+CxNkcnhVIr5I/MWYDkDkL3Io
         0CicPtbz6PnAAoMhgkno83oc7oUAG6AmHUCNUk6iJe/J9QryUV52agm2AD7ZdfbtzW6v
         dIlD6h5iniiOYH3CnDYr+HmWay2p8xYrV7oOrsv5AvfUHqdNbLk403OVPIIwf/ZU3g+W
         YdTyoSL2divy1l3fwdFrA6s+yiJQ478ZNiZ8c4GMdiX/DyPPMjVKSIXmXl5Hp04vHgvf
         KX+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Dcjau/hIXBnPM9Af06JmbVmh73kSQdc3IIMbzh+4PDE=;
        b=NERuikQkWLHSwbQI2eOWXzJCMHMPhR+v79VRiKYxXO1+12q5v/hsHEUaGmtMdSOWFm
         zwA1p9F49OT9THlTuVZhGFu5pw2ociRdkL8QjDcLFbjvGyFO+EhorCPrs5eMSSPJ/knQ
         Qfc2t7C8/dph387fAMAXk8SS1i7GvMZUQwc71mw1OfRDXfEk3vgOjDfHOcWqR4nGDx47
         woxtS9/CzlzOJa7cPlEaZFBaCu/k08cTgAkvi2KW4xTl5rW8/Kg/O8+8C+j3SosBLJ+2
         wPLnRo4IjPHUhJeNMBx1DYHLlHtuD9UeVxc9CxMAuWmlfu4A2umlBg3NHWJWBElF3trM
         7eXg==
X-Gm-Message-State: AOAM531pYu3nsM1nkeGGMXRtwTYDW4PXko0YVHN4BbyCnNiPLwD1AumZ
        qOucYIHighXEEOCc1tmt+zyATz0ju75EVA==
X-Google-Smtp-Source: ABdhPJyvyjFzFG3ZXnlMMSITd+woVBpURrVOWNAkowKcRxQMC8tTkBdvkJR6jzAzqXMVk47tx5hbeJxN+m7o8Q==
X-Received: from shakeelb.svl.corp.google.com ([2620:15c:2cd:202:4f8a:fdf0:d4ae:6a30])
 (user=shakeelb job=sendgmr) by 2002:a17:90a:a88b:: with SMTP id
 h11mr2876287pjq.44.1632959995173; Wed, 29 Sep 2021 16:59:55 -0700 (PDT)
Date:   Wed, 29 Sep 2021 16:59:36 -0700
Message-Id: <20210929235936.2859271-1-shakeelb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
Subject: [PATCH] cgroup: rstat: optimize flush through speculative test
From:   Shakeel Butt <shakeelb@google.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        "=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently cgroup_rstat_updated() has a speculative already-on-list test
to check if the given cgroup is already part of the rstat update tree.
This helps in reducing the contention on the rstat cpu lock. This patch
adds the similar speculative not-on-list test on the rstat flush
codepath.

Recently the commit aa48e47e3906 ("memcg: infrastructure to flush memcg
stats") added periodic rstat flush. On a large system which is not much
busy, most of the per-cpu rstat tree would be empty. So, the speculative
not-on-list test helps in eliminating unnecessary work and potentially
reducing contention on the rstat cpu lock. Please note this might
introduce temporary inaccuracy but with the frequent and periodic flush
this would not be an issue.

To evaluate the impact of this patch, an 8 GiB tmpfs file is created on
a system with swap-on-zram and the file was pushed to swap through
memory.force_empty interface. On reading the whole file, the memcg stat
flush in the refault code path is triggered. With this patch, we
observed 38% reduction in the read time of 8 GiB file.

Signed-off-by: Shakeel Butt <shakeelb@google.com>
---
 kernel/cgroup/rstat.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index b264ab5652ba..748494fbc786 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -35,7 +35,7 @@ void cgroup_rstat_updated(struct cgroup *cgrp, int cpu)
 	 * instead of NULL, we can tell whether @cgrp is on the list by
 	 * testing the next pointer for NULL.
 	 */
-	if (cgroup_rstat_cpu(cgrp, cpu)->updated_next)
+	if (data_race(cgroup_rstat_cpu(cgrp, cpu)->updated_next))
 		return;
 
 	raw_spin_lock_irqsave(cpu_lock, flags);
@@ -157,6 +157,13 @@ static void cgroup_rstat_flush_locked(struct cgroup *cgrp, bool may_sleep)
 						       cpu);
 		struct cgroup *pos = NULL;
 
+		/*
+		 * Speculative not-on-list test. This may lead to temporary
+		 * inaccuracies which is fine.
+		 */
+		if (!data_race(cgroup_rstat_cpu(cgrp, cpu)->updated_next))
+			goto next;
+
 		raw_spin_lock(cpu_lock);
 		while ((pos = cgroup_rstat_cpu_pop_updated(pos, cgrp, cpu))) {
 			struct cgroup_subsys_state *css;
@@ -170,7 +177,7 @@ static void cgroup_rstat_flush_locked(struct cgroup *cgrp, bool may_sleep)
 			rcu_read_unlock();
 		}
 		raw_spin_unlock(cpu_lock);
-
+next:
 		/* if @may_sleep, play nice and yield if necessary */
 		if (may_sleep && (need_resched() ||
 				  spin_needbreak(&cgroup_rstat_lock))) {
-- 
2.33.0.685.g46640cef36-goog

