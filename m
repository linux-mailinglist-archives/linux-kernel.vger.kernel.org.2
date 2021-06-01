Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 488DD3975D6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 16:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234249AbhFAO4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 10:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233924AbhFAO4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 10:56:14 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34812C061574
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 07:54:32 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id pi6-20020a17090b1e46b029015cec51d7cdso2087351pjb.5
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 07:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U7TS4b0zlj5D5C5rsCw1F4eSmoRnEp26MuVRDcrEynQ=;
        b=mnYY7J2c2VxzicZryJmotItv56nvoLKrZDcKULJ6AepnABN6UkNxeR6pqsur3qHClA
         zILaNlXz5LXfZ2vgEM2AIY+ast52NBlqXAjX8tJwzUyGJpyQY73YANl0Xw5Hs8rDANfP
         b7ZqJAi0erpD1RT6elRm9BUgtmzAMz+fxzrLVRRE9CDyz/C/NCODFmoElWqhXD4niWxj
         2jn7U3yk2cNqrFoNMU/mQmp62fdiCBwKWyTyuBwhgysLPSYYu91nBCa5AvsRm8j+z2US
         n4umVOAV6mnn8Gtfvpk4fyCO1pnRkBz1Obph6hkhJibfroxirAOJjpnmc/ra7PnohDVI
         3zAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=U7TS4b0zlj5D5C5rsCw1F4eSmoRnEp26MuVRDcrEynQ=;
        b=iTmFh1AtpybF7oLQ0cLYrQr9o2q86Gmf4O/HJHz6xTXkt3ILqmIbO9Rdl0nnzr7fwh
         +quYSMrApnWt0Asmdwk80imFDULehsqzEnkVd+KzZ2pccCjpPhlG1igLQTcRJ/d6wgGZ
         DAANkN2lInJPl83NI1RaJ+PHLCjZKpGUslmsxeBv77SJlO3es8OeYmxCRCkMfZrLtZPY
         zzIcnQtYEHZ0ykexSAEU7yZG8cdZ6KTj4kBB/JtT6Xkphke0Q4mRPcnKNcxMERcIrCgd
         StlzWbRFrBWejihR9hGcn5N1s2TOwSLQ0YHy4bbCkZRkK5NA58SYOQWiKWuG/C7yo3Kd
         AM1Q==
X-Gm-Message-State: AOAM532M4anrE1O9qTBb7eCX3VOLTE3NmtMaX7epLM6D/LoWilcybw2/
        +9Wy8CMCsfFtOKeVAQOuKvg=
X-Google-Smtp-Source: ABdhPJz0KylEhkjYi7vlWfh18rZmtFafg/cOwEjeI6XD26GQTgv3rNUz9PpM9ii1dpU+f8Yq44cd/Q==
X-Received: by 2002:a17:903:2c2:b029:101:9c88:d928 with SMTP id s2-20020a17090302c2b02901019c88d928mr19242970plk.62.1622559271678;
        Tue, 01 Jun 2021 07:54:31 -0700 (PDT)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:201:90c3:9d92:1e02:1380])
        by smtp.gmail.com with ESMTPSA id q24sm14539992pgk.32.2021.06.01.07.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 07:54:30 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Chris Goldsworthy <cgoldswo@codeaurora.org>,
        Laura Abbott <labbott@kernel.org>,
        Oliver Sang <oliver.sang@intel.com>,
        David Hildenbrand <david@redhat.com>,
        John Dias <joaodias@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@intel.com, linux-mm <linux-mm@kvack.org>,
        Minchan Kim <minchan@kernel.org>
Subject: [PATCH v2] mm: fs: invalidate bh_lrus for only cold path
Date:   Tue,  1 Jun 2021 07:54:25 -0700
Message-Id: <20210601145425.1396981-1-minchan@kernel.org>
X-Mailer: git-send-email 2.32.0.rc0.204.g9fa02ecfa5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel test robot reported the regression of fio.write_iops[1]
with [2].

Since lru_add_drain is called frequently, invalidate bh_lrus
there could increase bh_lrus cache miss ratio, which needs
more IO in the end.

This patch moves the bh_lrus invalidation from the hot path(
e.g., zap_page_range, pagevec_release) to cold path(i.e.,
lru_add_drain_all, lru_cache_disable).

[1] https://lore.kernel.org/lkml/20210520083144.GD14190@xsang-OptiPlex-9020/
[2] 8cc621d2f45d, mm: fs: invalidate BH LRU during page migration
Cc: "Xing, Zhengjun" <zhengjun.xing@intel.com>
Reported-by: kernel test robot <oliver.sang@intel.com>
Reviewed-by: Chris Goldsworthy <cgoldswo@codeaurora.org>
Signed-off-by: Minchan Kim <minchan@kernel.org>
---
* from v1 - https://lore.kernel.org/lkml/YK0oQ76zX0uVZCwQ@google.com/
  * add Reviewed-by - cgoldswo

 mm/swap.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/mm/swap.c b/mm/swap.c
index 1958d5feb148..3e25d99a9dbb 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -642,7 +642,6 @@ void lru_add_drain_cpu(int cpu)
 		pagevec_lru_move_fn(pvec, lru_lazyfree_fn);
 
 	activate_page_drain(cpu);
-	invalidate_bh_lrus_cpu(cpu);
 }
 
 /**
@@ -725,6 +724,17 @@ void lru_add_drain(void)
 	local_unlock(&lru_pvecs.lock);
 }
 
+static void lru_add_and_bh_lrus_drain(void)
+{
+	int cpu;
+
+	local_lock(&lru_pvecs.lock);
+	cpu = smp_processor_id();
+	lru_add_drain_cpu(cpu);
+	local_unlock(&lru_pvecs.lock);
+	invalidate_bh_lrus_cpu(cpu);
+}
+
 void lru_add_drain_cpu_zone(struct zone *zone)
 {
 	local_lock(&lru_pvecs.lock);
@@ -739,7 +749,7 @@ static DEFINE_PER_CPU(struct work_struct, lru_add_drain_work);
 
 static void lru_add_drain_per_cpu(struct work_struct *dummy)
 {
-	lru_add_drain();
+	lru_add_and_bh_lrus_drain();
 }
 
 /*
@@ -880,7 +890,7 @@ void lru_cache_disable(void)
 	 */
 	__lru_add_drain_all(true);
 #else
-	lru_add_drain();
+	lru_add_and_bh_lrus_drain();
 #endif
 }
 
-- 
2.31.1.818.g46aad6cb9e-goog

