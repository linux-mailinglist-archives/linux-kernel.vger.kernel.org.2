Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85A99413707
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 18:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234192AbhIUQPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 12:15:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36011 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233948AbhIUQPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 12:15:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632240817;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vXWudoCYk+miAPRPv+924oKRNUMxKATIYtsekauJQeA=;
        b=PNRhGgl4qtJo6C6geLrSXgTHfPrlaQ8dDhLF0U/VbupwdHlaa9h5V08jXh4K2LaDWSE2JK
        cc8hYmffr2n47bFRcnkbV8MOoPV28b61AVaKvc92iGWsEhy6ysFgTxbpTXukt6wLV2Csvc
        I4UQ8iRbrF4AtFJENZKMRtcdud+Rcpg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-60-8Yzj9ksEMPCVJxLLUC-kMA-1; Tue, 21 Sep 2021 12:13:35 -0400
X-MC-Unique: 8Yzj9ksEMPCVJxLLUC-kMA-1
Received: by mail-wr1-f70.google.com with SMTP id c15-20020a5d4ccf000000b0015dff622f39so9243662wrt.21
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 09:13:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vXWudoCYk+miAPRPv+924oKRNUMxKATIYtsekauJQeA=;
        b=lPyl4faY7OmPkZpY8Yro33S6c51T59H9r/KzoG42h+w/0sFcyqxWDiXhwcAPWo+glc
         mcQZgUSO0nervio4a2if4dxMo3T5usLdpTZT4M4DPOZKxhZGvlqV5aHapeQuH1vHFhpr
         AToSt5AcmKn1q3E9vDVc590fik8/vqjN0BWQfbaFaJlOIPuECMUV1dhQbudam1oZdMi5
         7NJ0eCZPSnd/JS5/JL5zgrgmflrzRnSeQLNbGdl/0zbJqUeEWuq76OOFH2qUFMVRBEqJ
         TG4xYsP/jducGJZ4KL9rHGOIE/GrRrURgjH5iV40Ueqd1HriK4w2Jt5MBZXt+PNm6XzP
         LaWg==
X-Gm-Message-State: AOAM531PITqya9asJiN8QED6qIGqhhxey3oZVofiGiNz1vtwEcaPBgMg
        XtqoEiIaGjWr85t2M/X++NhDc+NAphgwBjAQLHu4l6dRt3DSOLaAdlpvYlZhbBD518++aPRL2Oi
        r/tZPLRcdsE4Qdz1epZ/qLjaN
X-Received: by 2002:a05:600c:ac5:: with SMTP id c5mr5643279wmr.191.1632240814619;
        Tue, 21 Sep 2021 09:13:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy02a6TNjxvk76ZUdxL9bhj9bDessU6ld3p2HrKam7H2usXY6Tt6rrZgJ6GdFwngIshxJ2HPw==
X-Received: by 2002:a05:600c:ac5:: with SMTP id c5mr5643253wmr.191.1632240814460;
        Tue, 21 Sep 2021 09:13:34 -0700 (PDT)
Received: from vian.redhat.com ([2a0c:5a80:1d03:b900:c3d1:5974:ce92:3123])
        by smtp.gmail.com with ESMTPSA id t1sm19786477wrz.39.2021.09.21.09.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 09:13:34 -0700 (PDT)
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     akpm@linux-foundation.org, frederic@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        tglx@linutronix.de, cl@linux.com, peterz@infradead.org,
        juri.lelli@redhat.com, mingo@redhat.com, mtosatti@redhat.com,
        nilal@redhat.com, mgorman@suse.de, ppandit@redhat.com,
        williams@redhat.com, bigeasy@linutronix.de,
        anna-maria@linutronix.de, linux-rt-users@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>
Subject: [PATCH 1/6] mm/swap: Introduce lru_cpu_needs_drain()
Date:   Tue, 21 Sep 2021 18:13:19 +0200
Message-Id: <20210921161323.607817-2-nsaenzju@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210921161323.607817-1-nsaenzju@redhat.com>
References: <20210921161323.607817-1-nsaenzju@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Upcoming patches will need to check whether a CPU needs to drain its LRU
pagevecs on multiple locations. So move the check into its own function.

Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
---
 mm/swap.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/mm/swap.c b/mm/swap.c
index 04b678342c02..e7f9e4018ccf 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -726,6 +726,17 @@ static void lru_add_drain_per_cpu(struct work_struct *dummy)
 	lru_add_drain();
 }
 
+static bool lru_cpu_needs_drain(int cpu)
+{
+	return pagevec_count(&per_cpu(lru_pvecs.lru_add, cpu)) ||
+	       data_race(pagevec_count(&per_cpu(lru_rotate.pvec, cpu))) ||
+	       pagevec_count(&per_cpu(lru_pvecs.lru_deactivate_file, cpu)) ||
+	       pagevec_count(&per_cpu(lru_pvecs.lru_deactivate, cpu)) ||
+	       pagevec_count(&per_cpu(lru_pvecs.lru_lazyfree, cpu)) ||
+	       need_activate_page_drain(cpu) ||
+	       has_bh_in_lru(cpu, NULL);
+}
+
 /*
  * Doesn't need any cpu hotplug locking because we do rely on per-cpu
  * kworkers being shut down before our page_alloc_cpu_dead callback is
@@ -808,14 +819,7 @@ inline void __lru_add_drain_all(bool force_all_cpus)
 	for_each_online_cpu(cpu) {
 		struct work_struct *work = &per_cpu(lru_add_drain_work, cpu);
 
-		if (force_all_cpus ||
-		    pagevec_count(&per_cpu(lru_pvecs.lru_add, cpu)) ||
-		    data_race(pagevec_count(&per_cpu(lru_rotate.pvec, cpu))) ||
-		    pagevec_count(&per_cpu(lru_pvecs.lru_deactivate_file, cpu)) ||
-		    pagevec_count(&per_cpu(lru_pvecs.lru_deactivate, cpu)) ||
-		    pagevec_count(&per_cpu(lru_pvecs.lru_lazyfree, cpu)) ||
-		    need_activate_page_drain(cpu) ||
-		    has_bh_in_lru(cpu, NULL)) {
+		if (force_all_cpus || lru_cpu_needs_drain(cpu)) {
 			INIT_WORK(work, lru_add_drain_per_cpu);
 			queue_work_on(cpu, mm_percpu_wq, work);
 			__cpumask_set_cpu(cpu, &has_work);
-- 
2.31.1

