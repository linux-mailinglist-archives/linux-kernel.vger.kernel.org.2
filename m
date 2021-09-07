Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE7A402D42
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 18:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345318AbhIGQ5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 12:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345162AbhIGQ5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 12:57:05 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FFACC061575
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 09:55:59 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id e7so6196027plh.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 09:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=YP9tsinPr6XuopQ8OcMHKocADgx8ZaG7TikwRkGwubM=;
        b=ZunR9Qo9DjiGhtdJjLBzqLG66XF2LvgCn0uEEjDF/Jo+OwtCF2H/Sb101YBj6AyrF3
         EujTb0uForaV+P4LCR8aA/Xtvugbycecl3VEzV8nNVJctaysufQmYb98gwRE00nVuONG
         I8WuGY7cAAP7oPj92UpHhawHUO3n3WhpTV/WA8VJYAGUS8epkYoOPP4wSjcWNfX8RzeR
         npAKB8QqmMEf6KyCr400eH8cKbNPQL+JXie/WLVQo2Yd0DFzLYLyK6XSzWcDuKLVGMWc
         c84dcQBPkNT3/1vrtuWrjcMzvptGHqtj8X9fwi9IvMhDA9c+xhWD8P3t1GNDtzzYlQzV
         nRxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=YP9tsinPr6XuopQ8OcMHKocADgx8ZaG7TikwRkGwubM=;
        b=OBxBk4K48NgXXi6+F15tUZgFX4Zx2N3nrcKPrF7Ro1PYCJrFOgHDPMuuBwmTZm+eZf
         WlngO1q2I5+vBr46sVeDFUbKqLFeslBzC39sbQ01uDy7qVvtZA0cIqJigIhkMyKQ/hY5
         sUcLt+gZMqK8PehgWKPOwQhpYEgx1G9heLj4nGdTpuLQmiKkbwHA78QA1yBYYFh06F0E
         u4u0riunxaGbmX2RUY/SvGCy20soRNf8OyqiyQ84ZORsAWor2DKkKCFu+tp7gzKFJief
         xsKKjd/fKlxEDbHWqsFzyi0VxbQqTXw+aF7GPoMGMzfl0SWvCLOrwitlFRxP9VOHtUuW
         WBiA==
X-Gm-Message-State: AOAM532CwJbVR1K3jhwBevuObY3opbaHj/lNPVway47/OL1kj3a99nc3
        6DYrJO9iPKK9cNpoa5438xE=
X-Google-Smtp-Source: ABdhPJznul1j32DUZGdnD18Qms1R0ZzW5JPn2j7q9Y+yzlQpqh0R7sGEBfNCjth58Nxk3OSKAYF0wg==
X-Received: by 2002:a17:90a:2e88:: with SMTP id r8mr5567292pjd.169.1631033758203;
        Tue, 07 Sep 2021 09:55:58 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:998a:2486:f524:8502])
        by smtp.gmail.com with ESMTPSA id l12sm11083500pff.182.2021.09.07.09.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 09:55:57 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Tue, 7 Sep 2021 09:55:55 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     "Xing, Zhengjun" <zhengjun.xing@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Chris Goldsworthy <cgoldswo@codeaurora.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Laura Abbott <labbott@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        John Dias <joaodias@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, Minchan Kim <minchan.kim@gmail.com>
Subject: Re: [LKP] Re: [mm] 8cc621d2f4: fio.write_iops -21.8% regression
Message-ID: <YTeZm71hmcbJp+E2@google.com>
References: <20210520083144.GD14190@xsang-OptiPlex-9020>
 <YKasEeXCr9R5yzCr@google.com>
 <45f761de51d514f77cc48214846c5f8f@codeaurora.org>
 <YK0Us01mBTRWOQIw@google.com>
 <YK0oQ76zX0uVZCwQ@google.com>
 <5abc4469d16535119818e8e72173398d@codeaurora.org>
 <034fc860-d0d0-0c61-09d2-3c41c4f020c6@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <034fc860-d0d0-0c61-09d2-3c41c4f020c6@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Sep 03, 2021 at 03:11:33PM +0800, Xing, Zhengjun wrote:
> Hi Minchan,
> 
>     Do you have time to look at this? I re-test it in  v5.14, the regression
> still existed. Thanks.

Reminding me the issue, again, Xing. That's because the patch
was not merged yet so let me send it again.

Andrew?

From 8caadeb49d82403a08643dfbdb0b7749017c00bb Mon Sep 17 00:00:00 2001
From: Minchan Kim <minchan@kernel.org>
Date: Tue, 25 May 2021 08:19:17 -0700
Subject: [PATCH] mm: fs: invalidate bh_lrus for only cold path

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
Cc: Xing, Zhengjun <zhengjun.xing@intel.com>
Reviewed-by: Chris Goldsworthy <cgoldswo@codeaurora.org>
Reported-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Minchan Kim <minchan@kernel.org>
---
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

