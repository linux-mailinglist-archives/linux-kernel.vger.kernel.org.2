Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB2A438F4D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 08:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbhJYGWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 02:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbhJYGWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 02:22:15 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 856B9C061764
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 23:19:53 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id z7-20020a63c047000000b0026b13e40309so5706479pgi.19
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 23:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=RvvgnIVJ5IfhyMI13kBptnFJgKfIo/YKqj1muP3uFSI=;
        b=aZ8ak0XSK/nUIpVaIxYsqvQ3bOgvICTgXeDUq5NeDeyr5OL7iUyvWts44akfikGFMn
         1aspFDXj9W11lkB0NYioB51giV7uGch6f5v0x3OT6iQNLR/94F1Q9CfGiv5uJETPK3Wo
         RRNHaOTJwxbXyS/U62bh0IfOpVfp/MIyVQf0ZW7p3kUyjf0LKjh2h1ARVySaMSbTyMe7
         fA1J+fHVAQrVVtfefQBHFwfSBMuFXgCIbm5oT2pCpy38ZaGkIqX1DuqV9iahGkUIKOjS
         auBFJhXgVautfW4go+wrMVBb33tzy+CoC1yxOEPEifacHzz2s5Hoc259+ifLMsOwWif1
         QPXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=RvvgnIVJ5IfhyMI13kBptnFJgKfIo/YKqj1muP3uFSI=;
        b=v+fC3BKIY+tIlljMoHLfXmvE7IjvTWpkYL+2geqrGtkGwiszbmiHLwaUu/Rug9womz
         S8JwXttAz9/qhE+T3OsSEvEdS6klczz5q0Yd/V4rZg23rnlLI1XBGonvtrO4t66iwTPK
         XZ6n7d9aTajSClfKG/TiLSNmhJ7794oZCU3pkQeGb517fhOkQC4wAD/N/rYaSOvyIHpC
         8Nq/yJJREmW6Xa/5o/O9soJd3TIut1futoerdHj1TnK3+SnB45anw0WdQzbtvk4bjnOL
         4BIftUlb977kYaUioM6dD9v3WInX3uYml0RLABnzSjEPBsqmz9Pbub4EoI4wmDMcaqIR
         BzDg==
X-Gm-Message-State: AOAM532K0pmRBuq9YQRk9MpwHaHGCpjtQKZzGZxdlwBhC1Syd8usjTFv
        f23x5+Tnepmc/DpSDdC/69YmvqAZpFGN4w==
X-Google-Smtp-Source: ABdhPJyzSiJVC0kHoKpRCObivFMdwsAEy5pGKIQtbDLvinjevJBkq5zez11JkasNwjxjPzVuvufvQd/e7GCSkQ==
X-Received: from shakeelb.svl.corp.google.com ([2620:15c:2cd:202:faf1:73d1:a656:9f7e])
 (user=shakeelb job=sendgmr) by 2002:a63:1d53:: with SMTP id
 d19mr12000107pgm.85.1635142792991; Sun, 24 Oct 2021 23:19:52 -0700 (PDT)
Date:   Sun, 24 Oct 2021 23:19:16 -0700
In-Reply-To: <20211025061916.3853623-1-shakeelb@google.com>
Message-Id: <20211025061916.3853623-3-shakeelb@google.com>
Mime-Version: 1.0
References: <20211025061916.3853623-1-shakeelb@google.com>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH 3/3] cgroup: no need for cgroup_mutex for /proc/cgroups
From:   Shakeel Butt <shakeelb@google.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     "=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the real systems, the cgroups hierarchies are setup early and just
once by the node controller, so, other than number of cgroups, all
information in /proc/cgroups remain same for the system uptime. Let's
remove the cgroup_mutex usage on reading /proc/cgroups. There is a
chance of inconsistent number of cgroups for co-mounted cgroups while
printing the information from /proc/cgroups but that is not a big
issue. In addition /proc/cgroups is a v1 specific interface, so the
dependency on it should reduce over time.

The main motivation for removing the cgroup_mutex from /proc/cgroups is
to reduce the avenues of its contention. On our fleet, we have observed
buggy application hammering on /proc/cgroups and drastically slowing
down the node controller on the system which have many negative
consequences on other workloads running on the system.

Signed-off-by: Shakeel Butt <shakeelb@google.com>
---
 kernel/cgroup/cgroup-v1.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index fd14a60379c1..81c9e0685948 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -659,11 +659,9 @@ int proc_cgroupstats_show(struct seq_file *m, void *v)
 
 	seq_puts(m, "#subsys_name\thierarchy\tnum_cgroups\tenabled\n");
 	/*
-	 * ideally we don't want subsystems moving around while we do this.
-	 * cgroup_mutex is also necessary to guarantee an atomic snapshot of
-	 * subsys/hierarchy state.
+	 * Grab the subsystems state racily. No need to add avenue to
+	 * cgroup_mutex contention.
 	 */
-	mutex_lock(&cgroup_mutex);
 
 	for_each_subsys(ss, i)
 		seq_printf(m, "%s\t%d\t%d\t%d\n",
@@ -671,7 +669,6 @@ int proc_cgroupstats_show(struct seq_file *m, void *v)
 			   atomic_read(&ss->root->nr_cgrps),
 			   cgroup_ssid_enabled(i));
 
-	mutex_unlock(&cgroup_mutex);
 	return 0;
 }
 
-- 
2.33.0.1079.g6e70778dc9-goog

