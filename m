Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56A5C413709
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 18:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234330AbhIUQPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 12:15:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37652 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234279AbhIUQPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 12:15:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632240819;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Skz+wSCIMyvocC+cWmr1kqnk80+x9gFo8RgnyvxY9jI=;
        b=bI34Fs+7ApiP0wT6ko01niS4Be+t2jkB7WoVnoHUlD24nJKjYgRHaxB+OVHlHq1qolrTBf
        YJKzgBFIUg25J8GW30WqK3Yf5oK7Ko2DScyl0gJWzUR6uKKjGKeBIaLUxx0fQ2F/B2aCwF
        GVx8t8qYEAJPJg7kx6Inqm9Cf7KtUOk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-476-liO8uBn9N9utwDmentQJaA-1; Tue, 21 Sep 2021 12:13:38 -0400
X-MC-Unique: liO8uBn9N9utwDmentQJaA-1
Received: by mail-wr1-f69.google.com with SMTP id m18-20020adfe952000000b0015b0aa32fd6so9249582wrn.12
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 09:13:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Skz+wSCIMyvocC+cWmr1kqnk80+x9gFo8RgnyvxY9jI=;
        b=T7UCay2OcWLA4B/D1UD4Bz72D87g+v8Ndgm51QknAWGWTRIBdFbpscLbBDxDkxUtC+
         BZVOKIrLH5/tKwuxgeHqXyrQ54CDF0N/bDIa/95RDtYWcZpJg35nvhndgpNnvRmmhx/L
         cY1Emg1mkvK7UESRah4Jl05dwCcnLJ8xHZ5pAL+Qejgt5jf4MKgSblARw5ZoybW9QqqS
         RMOxHKJvLD4ftkkooCkFLga9Hnj/NzooKQmeo2qIpmUoV4l0m55irbbyHszj3X9c4ScO
         CXZjry3jmB4vSotsRFK3vckd0mdSHuEds8fJow7qOwEJkCWT2DOmHk87M1EVs7qc+cK0
         TBfg==
X-Gm-Message-State: AOAM531AlG0KNwm8pmhgv/wJWFQRQcHUaCqUqoNOvoPGd4YaHZ0s5Cm+
        AWicsdP8KUPi2qucO1LknvehxBZiquiHta93kuMn6cnDRe/5pd1SOs38Pai4xDnC4RrjpBygDSA
        /sRZQqnE1Oz+iDdL5IXZ2bGVY
X-Received: by 2002:a05:6000:c3:: with SMTP id q3mr35713548wrx.361.1632240817399;
        Tue, 21 Sep 2021 09:13:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwc8lfAIXvvAGBd2lf3kHl9jl9Ma+SH7iopQjrQOmNgpGD7Dcwtktf6tIufdAsdVPxyyoBuiQ==
X-Received: by 2002:a05:6000:c3:: with SMTP id q3mr35713524wrx.361.1632240817263;
        Tue, 21 Sep 2021 09:13:37 -0700 (PDT)
Received: from vian.redhat.com ([2a0c:5a80:1d03:b900:c3d1:5974:ce92:3123])
        by smtp.gmail.com with ESMTPSA id t1sm19786477wrz.39.2021.09.21.09.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 09:13:37 -0700 (PDT)
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     akpm@linux-foundation.org, frederic@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        tglx@linutronix.de, cl@linux.com, peterz@infradead.org,
        juri.lelli@redhat.com, mingo@redhat.com, mtosatti@redhat.com,
        nilal@redhat.com, mgorman@suse.de, ppandit@redhat.com,
        williams@redhat.com, bigeasy@linutronix.de,
        anna-maria@linutronix.de, linux-rt-users@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>
Subject: [PATCH 3/6] mm/swap: Allow remote LRU cache draining
Date:   Tue, 21 Sep 2021 18:13:21 +0200
Message-Id: <20210921161323.607817-4-nsaenzju@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210921161323.607817-1-nsaenzju@redhat.com>
References: <20210921161323.607817-1-nsaenzju@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some setups, notably NOHZ_FULL CPUs, are too busy to handle the per-cpu
drain work queued by __lru_add_drain_all(). So introduce new a mechanism
to remotely drain the per-cpu lists. It is made possible by using a more
constraining locking scheme, which is disabled by default and can be
enabled through the 'remote_pcpu_cache_access' static key. Regular users
shouldn't see any functional or performance change. Upcoming patches
will make use of the key.

Based on previous work by Thomas Gleixner, Anna-Maria Gleixner, and
Sebastian Andrzej Siewior[1].

[1] https://patchwork.kernel.org/project/linux-mm/cover/20190424111208.24459-1-bigeasy@linutronix.de/
Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
---
 mm/swap.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/mm/swap.c b/mm/swap.c
index bcf73bd563a6..59e96a2520d5 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -915,19 +915,29 @@ inline void __lru_add_drain_all(bool force_all_cpus)
 	WRITE_ONCE(lru_drain_gen, lru_drain_gen + 1);
 	smp_mb();
 
-	cpumask_clear(&has_work);
-	for_each_online_cpu(cpu) {
-		struct work_struct *work = &per_cpu(lru_add_drain_work, cpu);
-
-		if (force_all_cpus || lru_cpu_needs_drain(cpu)) {
-			INIT_WORK(work, lru_add_drain_per_cpu);
-			queue_work_on(cpu, mm_percpu_wq, work);
-			__cpumask_set_cpu(cpu, &has_work);
+	if (static_branch_unlikely(&remote_pcpu_cache_access)) {
+		for_each_online_cpu(cpu) {
+			if (force_all_cpus || lru_cpu_needs_drain(cpu)) {
+				lru_cache_lock_cpu(&lru_pvecs.locks, cpu);
+				lru_add_drain_cpu(cpu);
+				lru_cache_unlock_cpu(&lru_pvecs.locks, cpu);
+			}
+		}
+	} else {
+		cpumask_clear(&has_work);
+		for_each_online_cpu(cpu) {
+			struct work_struct *work = &per_cpu(lru_add_drain_work, cpu);
+
+			if (force_all_cpus || lru_cpu_needs_drain(cpu)) {
+				INIT_WORK(work, lru_add_drain_per_cpu);
+				queue_work_on(cpu, mm_percpu_wq, work);
+				__cpumask_set_cpu(cpu, &has_work);
+			}
 		}
-	}
 
-	for_each_cpu(cpu, &has_work)
-		flush_work(&per_cpu(lru_add_drain_work, cpu));
+		for_each_cpu(cpu, &has_work)
+			flush_work(&per_cpu(lru_add_drain_work, cpu));
+	}
 
 done:
 	mutex_unlock(&lock);
-- 
2.31.1

