Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88FDD311022
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 19:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232144AbhBEQ6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 11:58:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233704AbhBEQrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 11:47:32 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB808C061224
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 10:28:31 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id r13so3892395qvm.11
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 10:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BaUO0pgli+w3WAaSzoSou9pv5Ds3nAQBJUbmAgL0bVs=;
        b=AM3ZrZz8cvpBGn6MlO823+OEBTcXj/+p9LQp8MY8YAsGWuGslA5P7ox7fpa8rJoWfz
         md7ddBktXxCCmBlfPQRL549Cd+kHwYzfDMlBuA1Kis8uOitRMBu+JIr0TBY1JkhLaqEf
         U6c2a+wxWq9lQCLJwx5tuF3oJ+o5JNlwpkQa+paSMBwZ1veYAxAWfl0/TuCpDj4fsHzU
         mgGcUaIJfJbIt2Gl73PUll0IqbMyV3Cv4UHN3wInAJwUu3LsbL5p2rCnT+RMn6fSGVVV
         m4YfPHNDXLPlX5akurOGBWHjkX/aOxnlghimaHbpxRs9Q/5ddg7sX2By63vXOjhvn27H
         M5qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BaUO0pgli+w3WAaSzoSou9pv5Ds3nAQBJUbmAgL0bVs=;
        b=MzXY3EII3gzRr2ZXINJNruwxEFuyqV3nmB6iBCKN3B/DZmqBi9Pd/v8+nUlZcD8tRJ
         NKwQV7eYctnLj8jFvJK9fUbzihowczBXZxToHwh3a5bxpHGUoDGyFxC8kwe7zKD/ymVm
         iqM30hmyAr88lYnrisU6wmcEGdj3fxdinvgeHJn9Ia960vMIOrzF/2yJLNBreboKgntS
         SwBkyHFZVubZWgN2dmWfc8ISfZcP4+YSEEdi6NyUeZoAqQ87/hEEy9xSo6nooX1dPFiu
         BVz1jjN4VTUo4P5iIVqkial90lz+DnZR2aE6Mr93pNrLeaqvHDHrJnbAwbLOZ/f7Px4s
         ta/A==
X-Gm-Message-State: AOAM531hdOjoenl9PePgf0EyyDZixV8ic97TGv3wwxFwqSzapQXZlxrF
        lR1nfCIQBTcbHPvuPea2fSQHtQ==
X-Google-Smtp-Source: ABdhPJyz81NdWPmY29u6GqqNKhYbdUYvhmYNTCR0U6pkERftLYkKVVBInVR/qTkf3K/FfYJzX0/b0w==
X-Received: by 2002:a05:6214:a4f:: with SMTP id ee15mr5598175qvb.10.1612549711214;
        Fri, 05 Feb 2021 10:28:31 -0800 (PST)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id 5sm9582767qkk.109.2021.02.05.10.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 10:28:30 -0800 (PST)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>
Cc:     Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 4/8] cgroup: rstat: support cgroup1
Date:   Fri,  5 Feb 2021 13:28:02 -0500
Message-Id: <20210205182806.17220-5-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210205182806.17220-1-hannes@cmpxchg.org>
References: <20210205182806.17220-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rstat currently only supports the default hierarchy in cgroup2. In
order to replace memcg's private stats infrastructure - used in both
cgroup1 and cgroup2 - with rstat, the latter needs to support cgroup1.

The initialization and destruction callbacks for regular cgroups are
already in place. Remove the cgroup_on_dfl() guards to handle cgroup1.

The initialization of the root cgroup is currently hardcoded to only
handle cgrp_dfl_root.cgrp. Move those callbacks to cgroup_setup_root()
and cgroup_destroy_root() to handle the default root as well as the
various cgroup1 roots we may set up during mounting.

The linking of css to cgroups happens in code shared between cgroup1
and cgroup2 as well. Simply remove the cgroup_on_dfl() guard.

Linkage of the root css to the root cgroup is a bit trickier: per
default, the root css of a subsystem controller belongs to the default
hierarchy (i.e. the cgroup2 root). When a controller is mounted in its
cgroup1 version, the root css is stolen and moved to the cgroup1 root;
on unmount, the css moves back to the default hierarchy. Annotate
rebind_subsystems() to move the root css linkage along between roots.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
Reviewed-by: Roman Gushchin <guro@fb.com>
---
 kernel/cgroup/cgroup.c | 34 +++++++++++++++++++++-------------
 kernel/cgroup/rstat.c  |  2 --
 2 files changed, 21 insertions(+), 15 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 9153b20e5cc6..e049edd66776 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1339,6 +1339,7 @@ static void cgroup_destroy_root(struct cgroup_root *root)
 
 	mutex_unlock(&cgroup_mutex);
 
+	cgroup_rstat_exit(cgrp);
 	kernfs_destroy_root(root->kf_root);
 	cgroup_free_root(root);
 }
@@ -1751,6 +1752,12 @@ int rebind_subsystems(struct cgroup_root *dst_root, u16 ss_mask)
 				       &dcgrp->e_csets[ss->id]);
 		spin_unlock_irq(&css_set_lock);
 
+		if (ss->css_rstat_flush) {
+			list_del_rcu(&css->rstat_css_node);
+			list_add_rcu(&css->rstat_css_node,
+				     &dcgrp->rstat_css_list);
+		}
+
 		/* default hierarchy doesn't enable controllers by default */
 		dst_root->subsys_mask |= 1 << ssid;
 		if (dst_root == &cgrp_dfl_root) {
@@ -1971,10 +1978,14 @@ int cgroup_setup_root(struct cgroup_root *root, u16 ss_mask)
 	if (ret)
 		goto destroy_root;
 
-	ret = rebind_subsystems(root, ss_mask);
+	ret = cgroup_rstat_init(root_cgrp);
 	if (ret)
 		goto destroy_root;
 
+	ret = rebind_subsystems(root, ss_mask);
+	if (ret)
+		goto exit_stats;
+
 	ret = cgroup_bpf_inherit(root_cgrp);
 	WARN_ON_ONCE(ret);
 
@@ -2006,6 +2017,8 @@ int cgroup_setup_root(struct cgroup_root *root, u16 ss_mask)
 	ret = 0;
 	goto out;
 
+exit_stats:
+	cgroup_rstat_exit(root_cgrp);
 destroy_root:
 	kernfs_destroy_root(root->kf_root);
 	root->kf_root = NULL;
@@ -4934,8 +4947,7 @@ static void css_free_rwork_fn(struct work_struct *work)
 			cgroup_put(cgroup_parent(cgrp));
 			kernfs_put(cgrp->kn);
 			psi_cgroup_free(cgrp);
-			if (cgroup_on_dfl(cgrp))
-				cgroup_rstat_exit(cgrp);
+			cgroup_rstat_exit(cgrp);
 			kfree(cgrp);
 		} else {
 			/*
@@ -4976,8 +4988,7 @@ static void css_release_work_fn(struct work_struct *work)
 		/* cgroup release path */
 		TRACE_CGROUP_PATH(release, cgrp);
 
-		if (cgroup_on_dfl(cgrp))
-			cgroup_rstat_flush(cgrp);
+		cgroup_rstat_flush(cgrp);
 
 		spin_lock_irq(&css_set_lock);
 		for (tcgrp = cgroup_parent(cgrp); tcgrp;
@@ -5034,7 +5045,7 @@ static void init_and_link_css(struct cgroup_subsys_state *css,
 		css_get(css->parent);
 	}
 
-	if (cgroup_on_dfl(cgrp) && ss->css_rstat_flush)
+	if (ss->css_rstat_flush)
 		list_add_rcu(&css->rstat_css_node, &cgrp->rstat_css_list);
 
 	BUG_ON(cgroup_css(cgrp, ss));
@@ -5159,11 +5170,9 @@ static struct cgroup *cgroup_create(struct cgroup *parent, const char *name,
 	if (ret)
 		goto out_free_cgrp;
 
-	if (cgroup_on_dfl(parent)) {
-		ret = cgroup_rstat_init(cgrp);
-		if (ret)
-			goto out_cancel_ref;
-	}
+	ret = cgroup_rstat_init(cgrp);
+	if (ret)
+		goto out_cancel_ref;
 
 	/* create the directory */
 	kn = kernfs_create_dir(parent->kn, name, mode, cgrp);
@@ -5250,8 +5259,7 @@ static struct cgroup *cgroup_create(struct cgroup *parent, const char *name,
 out_kernfs_remove:
 	kernfs_remove(cgrp->kn);
 out_stat_exit:
-	if (cgroup_on_dfl(parent))
-		cgroup_rstat_exit(cgrp);
+	cgroup_rstat_exit(cgrp);
 out_cancel_ref:
 	percpu_ref_exit(&cgrp->self.refcnt);
 out_free_cgrp:
diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index d51175cedfca..faa767a870ba 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -285,8 +285,6 @@ void __init cgroup_rstat_boot(void)
 
 	for_each_possible_cpu(cpu)
 		raw_spin_lock_init(per_cpu_ptr(&cgroup_rstat_cpu_lock, cpu));
-
-	BUG_ON(cgroup_rstat_init(&cgrp_dfl_root.cgrp));
 }
 
 /*
-- 
2.30.0

