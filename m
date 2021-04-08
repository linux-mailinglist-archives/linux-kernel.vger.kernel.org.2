Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3E5F358737
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 16:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbhDHOcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 10:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231665AbhDHOcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 10:32:09 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0135FC061761
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 07:31:58 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id v70so2344276qkb.8
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 07:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=btC50RWZIR531OhYeaaK7FrT2NEPi0tjXTwyDrbtV5o=;
        b=i6e9rr/E1F5vh2gsAqs1AjButTuV2db5PXnLnGsrylcSpVrAPBMDWw7TlkxlPuEcfR
         69vzlUrbGFl3mdMfMTrED2E20o/836zklqnPuO8grp+mwVmWtAl9sMJVQGN2R4Dfib4q
         Osvj9Hy/tqt2ZffewcVDUwMkxVb1ZeXE1xfdOe+xF3NssK0biDNoBBJm2sBSeWzjxNij
         nr9QqJj/dqmY/PhUHIQC7nJV/X2Y7+GSQPCA2WhHya1WL9wC13mjR7Cy40Od+40yG4kd
         Csi505C9RBKkqCoYQSty2edESBk7g/mzSEKx6/oZPMUVrtNTtAaw7umqVm4t7n/HereL
         hQBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=btC50RWZIR531OhYeaaK7FrT2NEPi0tjXTwyDrbtV5o=;
        b=ZNmbaCfEvbkKb08zLNxR9Yghfa9qqAji4VSDsTc1JblvFelx6iCFtbRYPhVADkvkhr
         PmJh71d+GfSD+pcjAHwAxEyqyxhidf3PYSDD/cUQ6+e5tRNDowVidrx4+jjwuM6Esa3B
         cuObMfSUqVh1vMlpV/isSDsiUMKlVrhmP8BipgWFNp5AW6mSybdTXpyC3hh50bAWQ8Rc
         61K2FEkyuBYf+bPfUNWf1bNJVH2QFmfOdoPQZsHTi086RdTq+sAi3JlfCkOFPpE1YVVx
         xfPnchZZT36HP3SlDlJwzt8tuKVzqqMknaD8VfnIniQyTdLGPUD6yNMmIsaFa6mledpF
         QQmA==
X-Gm-Message-State: AOAM533LsHhr8gwrVFEbPT46LX4g8dIzLB+aav/yhkxeRC1n0xym9fG7
        GzEQ2LTgPt1BrVQJ9+zzhJX5Zg==
X-Google-Smtp-Source: ABdhPJw9myrgIvMrLTa+QlhcKS2FfWUGYkStVWOHWX2cPsEm/RDXMQIRxqvmwPYAYvSc9C/Cz2AHcg==
X-Received: by 2002:a37:9d53:: with SMTP id g80mr8891089qke.499.1617892317152;
        Thu, 08 Apr 2021 07:31:57 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:cfb7])
        by smtp.gmail.com with ESMTPSA id o26sm17463212qko.83.2021.04.08.07.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 07:31:56 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@suse.com>, Hugh Dickins <hughd@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH] mm: page_counter: mitigate consequences of a page_counter underflow
Date:   Thu,  8 Apr 2021 10:31:55 -0400
Message-Id: <20210408143155.2679744-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the unsigned page_counter underflows, even just by a few pages, a
cgroup will not be able to run anything afterwards and trigger the OOM
killer in a loop.

Underflows shouldn't happen, but when they do in practice, we may just
be off by a small amount that doesn't interfere with the normal
operation - consequences don't need to be that dire.

Reset the page_counter to 0 upon underflow. We'll issue a warning that
the accounting will be off and then try to keep limping along.

[ We used to do this with the original res_counter, where it was a
  more straight-forward correction inside the spinlock section. I
  didn't carry it forward into the lockless page counters for
  simplicity, but it turns out this is quite useful in practice. ]

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/page_counter.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/mm/page_counter.c b/mm/page_counter.c
index c6860f51b6c6..7d83641eb86b 100644
--- a/mm/page_counter.c
+++ b/mm/page_counter.c
@@ -52,9 +52,13 @@ void page_counter_cancel(struct page_counter *counter, unsigned long nr_pages)
 	long new;
 
 	new = atomic_long_sub_return(nr_pages, &counter->usage);
-	propagate_protected_usage(counter, new);
 	/* More uncharges than charges? */
-	WARN_ON_ONCE(new < 0);
+	if (WARN_ONCE(new < 0, "page_counter underflow: %ld nr_pages=%lu\n",
+		      new, nr_pages)) {
+		new = 0;
+		atomic_long_set(&counter->usage, new);
+	}
+	propagate_protected_usage(counter, new);
 }
 
 /**
-- 
2.31.1

