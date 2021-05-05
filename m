Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 700FE373D01
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 16:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233691AbhEEOGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 10:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232569AbhEEOGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 10:06:40 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8855BC061574
        for <linux-kernel@vger.kernel.org>; Wed,  5 May 2021 07:05:43 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id l2so1979801wrm.9
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 07:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CmkloHZMbYYsutWi2v9Qx78QF4fzXdmWotZ2Kv9nAZg=;
        b=UqyhSR4lXze/ooFXogbnFNZQ+l03UPDgvYFdrX8BICA3iusG9aMFtcbK7s7jCg2QcG
         WFMXu3XTeUG213ML1j/JYNZ7WZl9wpE/AFvE1zK+f9wzKiFi/BH+duc/L7SPNHovEn6O
         tgUORMpw1mLM4S1bZBLKTBh2v7LZurFB37a47Mh/hZ5Gz8qWChbScUSLrKbWKAa8zTHZ
         Hfr21OmOtrO/R8jweTqrNCGGtvtz0ssh/Yd14+oQ3VvBmxOxvMTHdXQKzMYonBHDC8Wn
         zDzNPM5HhJb8zfjSEUnG93TwFAc8t5naGG4vJlUDbeS0rhEecNL2k79ebaMjMpKJtxW9
         dRQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CmkloHZMbYYsutWi2v9Qx78QF4fzXdmWotZ2Kv9nAZg=;
        b=nFsXQrl0mH5/+vJcFKVUApc3V6spF1RJPdzumfzOYsxYnzN6dpOyN5bYLVwD1USD4t
         mbkSbrejBaY9VPe7Duaq5melUYH0CwW1XQjsILRz7hCMfmVc3TilGU0L6yndEcy0i8kh
         9WpNivYxTBpNF150PRcTxvNCZoZe+eruGcyhMJWDj+Zyg8z6UphsKFjp/dXolZYT0IGY
         hUrHXBnlScXBzDtG+Es8ESSWLlLqXCUAJa4Np46MqRpUnJ/UEFyzsEIu1GCXJV/W28Zx
         WklbGbDUgw1Jt9eowCSsbm6UKEiBD8HbYUNT34ogKT271sFYpB8VIseoMUdoEfNEYwUU
         BCag==
X-Gm-Message-State: AOAM530BhQ2ydm5nBWVbXaZcApWtlRC6NHaS5d+wXABZO/DFzQ+/tsaI
        uofsTSfUG/NAk3nH+/uPRWA+oA==
X-Google-Smtp-Source: ABdhPJzDTH57HIhjDeThf/cNMDXb6vxbqDEYrjFgiBf9y9IzSYt9HIz/q/8dnK3sUbQx+7L3xIcRTg==
X-Received: by 2002:a5d:5242:: with SMTP id k2mr38938187wrc.269.1620223542265;
        Wed, 05 May 2021 07:05:42 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id f6sm23296476wru.72.2021.05.05.07.05.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 May 2021 07:05:41 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     akpm@linux-foundation.org, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, georgi.djakov@linaro.org,
        Liam Mark <lmark@codeaurora.org>
Subject: [PATCH] mm/memory_hotplug: Rate limit page migration warnings
Date:   Wed,  5 May 2021 17:05:42 +0300
Message-Id: <20210505140542.24935-1-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liam Mark <lmark@codeaurora.org>

When offlining memory the system can attempt to migrate a lot of pages,
if there are problems with migration this can flood the logs. Printing
all the data hogs the CPU and cause some RT threads to run for a long
time, which may have some bad consequences.

Rate limit the page migration warnings in order to avoid this.

Signed-off-by: Liam Mark <lmark@codeaurora.org>
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 mm/memory_hotplug.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 70620d0dd923..64acbdc6bece 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1521,6 +1521,8 @@ do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
 	struct page *page, *head;
 	int ret = 0;
 	LIST_HEAD(source);
+	static DEFINE_RATELIMIT_STATE(migrate_rs, DEFAULT_RATELIMIT_INTERVAL,
+				      DEFAULT_RATELIMIT_BURST);
 
 	for (pfn = start_pfn; pfn < end_pfn; pfn++) {
 		if (!pfn_valid(pfn))
@@ -1567,8 +1569,10 @@ do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
 						    page_is_file_lru(page));
 
 		} else {
-			pr_warn("failed to isolate pfn %lx\n", pfn);
-			dump_page(page, "isolation failed");
+			if (__ratelimit(&migrate_rs)) {
+				pr_warn("failed to isolate pfn %lx\n", pfn);
+				dump_page(page, "isolation failed");
+			}
 		}
 		put_page(page);
 	}
@@ -1597,9 +1601,11 @@ do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
 			(unsigned long)&mtc, MIGRATE_SYNC, MR_MEMORY_HOTPLUG);
 		if (ret) {
 			list_for_each_entry(page, &source, lru) {
-				pr_warn("migrating pfn %lx failed ret:%d ",
-				       page_to_pfn(page), ret);
-				dump_page(page, "migration failure");
+				if (__ratelimit(&migrate_rs)) {
+					pr_warn("migrating pfn %lx failed ret:%d\n",
+						page_to_pfn(page), ret);
+					dump_page(page, "migration failure");
+				}
 			}
 			putback_movable_pages(&source);
 		}
