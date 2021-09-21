Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20C5341370B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 18:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234279AbhIUQPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 12:15:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46445 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234339AbhIUQPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 12:15:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632240822;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kD1gPXuN5hXdBx7xkUXEssekkfNTX/T0+M6z2qHPbrk=;
        b=ZcaTELKY6aRxsKo85WXgIGFAi4WyRxFd4GZWNO4y1TWZxk+lUnUgYt0clo5OF0b43PzjnT
        udQUO8nT1w4XTB8oJdacBqwu7cMHwKZ9CYx7l5SkXW2lmIrhO3XpdWM1InbWMPCVGyOdlL
        gXiFDkoMumcx7CVmBnEGGMlIsTeesHE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-ZANv-Ws5OwmfVZb9gNtysg-1; Tue, 21 Sep 2021 12:13:41 -0400
X-MC-Unique: ZANv-Ws5OwmfVZb9gNtysg-1
Received: by mail-wr1-f69.google.com with SMTP id x2-20020a5d54c2000000b0015dfd2b4e34so9253456wrv.6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 09:13:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kD1gPXuN5hXdBx7xkUXEssekkfNTX/T0+M6z2qHPbrk=;
        b=pQD4FUZbl6usfAxazTFVJDlwSMGovAqwfiiWUU2xwVJniP0vMGGSBpw+pbOp/lhqdq
         fBDe4c0rJH+VeXTb4DIBMlapCLWtZver93OnmKJ7Lb96JSOx+B5GO9ZryXM/b4ioMFsp
         wVoTqokakQ9kFsNHEe2saJV/LXxc0YTe/G/lRCPRZDlya/qb9pEOGsFG60/v4mIfveqU
         BAvclk7NG9/XMp+aPQyfBeaHuwKGi0XXaz2KwGhoWJflQnYQLNVOm9LOJhUg8ALgLAIu
         nnKJ+k0tIdh56Wg311UWWHAPIcg7VJJOAGSu6x42aPb6TDorE20YZOe/YKgGPsbOiib9
         vmgg==
X-Gm-Message-State: AOAM533nvPzgXW/sRk8A3Y/BUCp5/Qt1r6+dkkMK8F8+evwAR1kh1GIB
        pEiYqO4Ik+LisUP8ZxR0peNXWmfK95Rs35FVaZY40bDH2Jvt2DNzo6EhjOxG5uDgHuHevmWKOBO
        YonLSKBnd0/f4sfsu4we+vUZq
X-Received: by 2002:adf:f890:: with SMTP id u16mr35026733wrp.388.1632240819873;
        Tue, 21 Sep 2021 09:13:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwILlB4+iYeakvY1cY1M2iraZrOJrl8W7MLtYotoTLsG/waIBsVBPTg6O9yF1Fb9VfMjynvqg==
X-Received: by 2002:adf:f890:: with SMTP id u16mr35026696wrp.388.1632240819716;
        Tue, 21 Sep 2021 09:13:39 -0700 (PDT)
Received: from vian.redhat.com ([2a0c:5a80:1d03:b900:c3d1:5974:ce92:3123])
        by smtp.gmail.com with ESMTPSA id t1sm19786477wrz.39.2021.09.21.09.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 09:13:39 -0700 (PDT)
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     akpm@linux-foundation.org, frederic@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        tglx@linutronix.de, cl@linux.com, peterz@infradead.org,
        juri.lelli@redhat.com, mingo@redhat.com, mtosatti@redhat.com,
        nilal@redhat.com, mgorman@suse.de, ppandit@redhat.com,
        williams@redhat.com, bigeasy@linutronix.de,
        anna-maria@linutronix.de, linux-rt-users@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>
Subject: [PATCH 5/6] mm/page_alloc: Allow remote per-cpu page list draining
Date:   Tue, 21 Sep 2021 18:13:23 +0200
Message-Id: <20210921161323.607817-6-nsaenzju@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210921161323.607817-1-nsaenzju@redhat.com>
References: <20210921161323.607817-1-nsaenzju@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some setups, notably NOHZ_FULL CPUs, are too busy to handle the per-cpu
drain work queued by __drain_all_pages(). So introduce new a mechanism
to remotely drain the per-cpu lists. It is made possible by using a more
constraining locking scheme, which is disabled by default and can be
enabled through the 'remote_pcpu_cache_access' static key. Regular users
shouldn't see any functional or performance change. Upcoming patches
will make use of the static key.

This is based on previous work by Thomas Gleixner, Anna-Maria Gleixner,
and Sebastian Andrzej Siewior[1].

[1] https://patchwork.kernel.org/project/linux-mm/patch/20190424111208.24459-3-bigeasy@linutronix.de/
Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
---
 mm/page_alloc.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 3244eb2ab51b..717df675ea06 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3268,15 +3268,25 @@ static void __drain_all_pages(struct zone *zone, bool force_all_cpus)
 			cpumask_clear_cpu(cpu, &cpus_with_pcps);
 	}
 
-	for_each_cpu(cpu, &cpus_with_pcps) {
-		struct pcpu_drain *drain = per_cpu_ptr(&pcpu_drain, cpu);
+	if (static_branch_unlikely(&remote_pcpu_cache_access)) {
+		for_each_cpu(cpu, &cpus_with_pcps) {
+			if (zone) {
+				drain_pages_zone(cpu, zone);
+			} else {
+				drain_pages(cpu);
+			}
+		}
+	} else {
+		for_each_cpu(cpu, &cpus_with_pcps) {
+			struct pcpu_drain *drain = per_cpu_ptr(&pcpu_drain, cpu);
 
-		drain->zone = zone;
-		INIT_WORK(&drain->work, drain_local_pages_wq);
-		queue_work_on(cpu, mm_percpu_wq, &drain->work);
+			drain->zone = zone;
+			INIT_WORK(&drain->work, drain_local_pages_wq);
+			queue_work_on(cpu, mm_percpu_wq, &drain->work);
+		}
+		for_each_cpu(cpu, &cpus_with_pcps)
+			flush_work(&per_cpu_ptr(&pcpu_drain, cpu)->work);
 	}
-	for_each_cpu(cpu, &cpus_with_pcps)
-		flush_work(&per_cpu_ptr(&pcpu_drain, cpu)->work);
 
 	mutex_unlock(&pcpu_drain_mutex);
 }
-- 
2.31.1

