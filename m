Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8522A368798
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 22:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239377AbhDVUDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 16:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239266AbhDVUDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 16:03:23 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F21D0C06138D
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 13:02:47 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id w3so70662420ejc.4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 13:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SnOhfJ0MT6ulL904pALJzBTQTb9USKkGTJS+7NkOyis=;
        b=HKabR5piWEgdGIAykFLARdkWPmGYFMfK+iS66IATF5kRzw62WtmXm/qQ6nF3CQgVuD
         8jE5ryHkAxcp3IH5Bgw0TsCrpTsclSxnWAqR8X557uaJdvt0vghjyZZxmRsGGVAPk4Vn
         EwK+FfoqgHgD+dfPTvOKwkCKT4+IUJQ8ZgsNC3TrtKzY+sbm+q7vx2RT7xo2Anzd3FDr
         J61YTGtCjUb9F7cItsay+G1jlZnBxlUjeGamegFb7G8XWsF95CBNoRQl981CacltgfmC
         kLKX1Drgw3XHjl6Inl33WxFy2fBkCa0Ae1XfLmzqJ4yI6z3CbLQ0pQiSi1mtAVIP4XhJ
         eQXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SnOhfJ0MT6ulL904pALJzBTQTb9USKkGTJS+7NkOyis=;
        b=ArJGhY/iFaMRpmv0Iem4sTLdGQKMxWclnB0BDO/V52YPNDH2O2BJxGkWOJ9dXjhAXv
         hIv4pSDBZv0PH9uzqYW+qW5zm1qNAYzHOS5RVzciuESYvg39zCdpnX/YoydCcFpvoyhr
         AtLDWYjTPUgNH9nmpFVZ04EltQn6g8ceJyWIZzjkMLNxJHIzku3weBVnt43d/VelvLaO
         WMaB8PutsArQDCjQfmzp246mlo0aTWnIY022IkXEAdy9cE0ZT6kh/CyesTNhUh0nkDGo
         4zOYzT5flNzwQGykQE9IJ3yF+CfMkbJtR49Jx2u9oV3Wfi9NNGersk4FaVwqMSNQIIaV
         udfg==
X-Gm-Message-State: AOAM5302IpxMtyPBCO6n4eLhFQrCwnwSSWxo716iIssUBjI3ky6qoPjK
        tmJRu+ZO2PxY7uD2QgZ7ETm2GKt1fg==
X-Google-Smtp-Source: ABdhPJwadBampMttNxzQRSAo9aj/jzDsuXhr9dzGvbkB+Bo5yIT4L3CKFuVgfE3y3RW7IQuBC+wIhg==
X-Received: by 2002:a17:906:b7c4:: with SMTP id fy4mr355199ejb.489.1619121766732;
        Thu, 22 Apr 2021 13:02:46 -0700 (PDT)
Received: from localhost.localdomain ([46.53.248.145])
        by smtp.gmail.com with ESMTPSA id u15sm2936199edx.34.2021.04.22.13.02.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 13:02:46 -0700 (PDT)
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     mingo@redhat.com, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, Alexey Dobriyan <adobriyan@gmail.com>
Subject: [PATCH 4/4] sched: make multiple runqueue task counters 32-bit
Date:   Thu, 22 Apr 2021 23:02:28 +0300
Message-Id: <20210422200228.1423391-4-adobriyan@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210422200228.1423391-1-adobriyan@gmail.com>
References: <20210422200228.1423391-1-adobriyan@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make

	struct dl_rq::dl_nr_migratory
	struct dl_rq::dl_nr_running

	struct rt_rq::rt_nr_boosted
	struct rt_rq::rt_nr_migratory
	struct rt_rq::rt_nr_total

	struct rq::nr_uninterruptible

32-bit.

If total number of tasks can't exceed 2**32 (and less due to futex pid
limits), then per-runqueue counters can't as well.

This patchset has been sponsored by REX Prefix Eradication Society.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---
 kernel/sched/loadavg.c |  2 +-
 kernel/sched/sched.h   | 12 ++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/loadavg.c b/kernel/sched/loadavg.c
index d2a655643a02..aef8072cfebe 100644
--- a/kernel/sched/loadavg.c
+++ b/kernel/sched/loadavg.c
@@ -81,7 +81,7 @@ long calc_load_fold_active(struct rq *this_rq, long adjust)
 	long nr_active, delta = 0;
 
 	nr_active = this_rq->nr_running - adjust;
-	nr_active += (long)this_rq->nr_uninterruptible;
+	nr_active += (int)this_rq->nr_uninterruptible;
 
 	if (nr_active != this_rq->calc_load_active) {
 		delta = nr_active - this_rq->calc_load_active;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 10a1522b1e30..730c81a54ed1 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -622,8 +622,8 @@ struct rt_rq {
 	} highest_prio;
 #endif
 #ifdef CONFIG_SMP
-	unsigned long		rt_nr_migratory;
-	unsigned long		rt_nr_total;
+	unsigned int		rt_nr_migratory;
+	unsigned int		rt_nr_total;
 	int			overloaded;
 	struct plist_head	pushable_tasks;
 
@@ -637,7 +637,7 @@ struct rt_rq {
 	raw_spinlock_t		rt_runtime_lock;
 
 #ifdef CONFIG_RT_GROUP_SCHED
-	unsigned long		rt_nr_boosted;
+	unsigned int		rt_nr_boosted;
 
 	struct rq		*rq;
 	struct task_group	*tg;
@@ -654,7 +654,7 @@ struct dl_rq {
 	/* runqueue is an rbtree, ordered by deadline */
 	struct rb_root_cached	root;
 
-	unsigned long		dl_nr_running;
+	unsigned int		dl_nr_running;
 
 #ifdef CONFIG_SMP
 	/*
@@ -668,7 +668,7 @@ struct dl_rq {
 		u64		next;
 	} earliest_dl;
 
-	unsigned long		dl_nr_migratory;
+	unsigned int		dl_nr_migratory;
 	int			overloaded;
 
 	/*
@@ -946,7 +946,7 @@ struct rq {
 	 * one CPU and if it got migrated afterwards it may decrease
 	 * it on another CPU. Always updated under the runqueue lock:
 	 */
-	unsigned long		nr_uninterruptible;
+	unsigned int		nr_uninterruptible;
 
 	struct task_struct __rcu	*curr;
 	struct task_struct	*idle;
-- 
2.30.2

