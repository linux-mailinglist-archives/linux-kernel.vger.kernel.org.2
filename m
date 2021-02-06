Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAFC9311E71
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 16:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbhBFPa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 10:30:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbhBFPaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 10:30:55 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D158C06174A
        for <linux-kernel@vger.kernel.org>; Sat,  6 Feb 2021 07:30:15 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id hs11so17814238ejc.1
        for <linux-kernel@vger.kernel.org>; Sat, 06 Feb 2021 07:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BZgjzAytNMoWQYrSS5TgqC8ghRav0h0ExXotMXjWNC4=;
        b=LK9yVoEc/BhUtyX3lpzGlTdblMixZ1MRCRGlhlUjsZE06ltsquJUVQuM3PsjNCOqp/
         lY5811036/puYQAlgRbnD4+tItxCELo874/eyiNURWIk4myrJ7kn1/szf7bq0jHy1Y9X
         F+juHDatq7V2s4FAItguFehPzc3Q/guAoKVF53w1E69QnFh77VcCNRYHdvtlj3+mppil
         6yX7giN7WDQ40gQpxmC4xXt4gm2LqMcXZ9/lq3MfmW7PE1/+SJxU6CsNW+QI9AsFlW4J
         kzetRD31D9D/2YqpdOATNinjopxSRV8o5lyEggBWHKzFdkdBc4tP3vFiRTijlM0ieCP6
         ZcrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BZgjzAytNMoWQYrSS5TgqC8ghRav0h0ExXotMXjWNC4=;
        b=R3WtS+tujqim47BIecKI5/IYFPrr+KpKcxPgOQ1OfP3sVWsfTUbPQ2aVc4FXiGGGw7
         +tv0IXXZGC160tOTOI1/9AV7JHJfdqBhkbWqsUAP3yiQpEB9BspK+qSVwPD2EGfTmO6a
         yB0931QVd7AyiuABnmCXfz1aTHDUfYQr4L5gQh0m9+nFE3H5KiHeUGe3DSqg+8nOlNx7
         bdCCDSXGV7snhBfwavWnervSbtXvHAAj5sPncymDee6fDpL/EFx5/oQVpQ79z6FDEAzv
         nOe+YLLNcgCKuWQDXY6ts34TVh6PURWIIqn9BB1idUQkwVijvMEc2DNH7CLWW05AVR5y
         ThdQ==
X-Gm-Message-State: AOAM531iHPXCdvfrhVLV3bUgBatOt9QPhE5uFoErglORxxySE2DDpS6G
        QY+nx7uju4nBwyt1B4Y1Jg==
X-Google-Smtp-Source: ABdhPJyk1g3564OXgLvRrw8CgHln1UgsLVG9YuasFS1oVaWDJGTACgdnXZrZYI4doMxrcZVBRFpOSw==
X-Received: by 2002:a17:906:86cf:: with SMTP id j15mr9165643ejy.194.1612625413912;
        Sat, 06 Feb 2021 07:30:13 -0800 (PST)
Received: from localhost.localdomain ([46.53.252.141])
        by smtp.gmail.com with ESMTPSA id hc13sm24714ejc.5.2021.02.06.07.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Feb 2021 07:30:13 -0800 (PST)
Date:   Sat, 6 Feb 2021 18:30:11 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     mingo@redhat.com, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
        rostedt@goodmis.org, bristot@redhat.com
Subject: [PATCH 5/5] sched: make multiple runqueue task counters 32-bit
Message-ID: <20210206153011.GE487103@localhost.localdomain>
References: <20210206151832.GA487103@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210206151832.GA487103@localhost.localdomain>
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

 kernel/sched/loadavg.c |    2 +-
 kernel/sched/sched.h   |   12 ++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)

--- a/kernel/sched/loadavg.c
+++ b/kernel/sched/loadavg.c
@@ -81,7 +81,7 @@ long calc_load_fold_active(struct rq *this_rq, long adjust)
 	long nr_active, delta = 0;
 
 	nr_active = this_rq->nr_running - adjust;
-	nr_active += (long)this_rq->nr_uninterruptible;
+	nr_active += (int)this_rq->nr_uninterruptible;
 
 	if (nr_active != this_rq->calc_load_active) {
 		delta = nr_active - this_rq->calc_load_active;
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
