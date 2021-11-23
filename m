Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E559D45AC08
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 20:09:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237758AbhKWTMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 14:12:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235934AbhKWTMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 14:12:30 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19BB9C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 11:09:22 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id n13-20020a170902d2cd00b0014228ffc40dso9454825plc.4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 11:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=BLQhBkzThc5wElIUsHc2zAb2IUWmlXfCDG1CajkcIjg=;
        b=FDDqFo73a1z/W2nFOfqS+J/SlDpQ12TKK9oYaVG2VpIDfbJjzDPOSGqhH1Rm2lcVKH
         so4In/RnD8GFtcwlm9Dbz4Xqw5hHXEqGs66+/FVDYF2YZ1TwpdMANglTwiZ5bz43aFAo
         UhXTT6uKzDAZ+XbVsAnBDxX9eCFkbIeHY92PsE6e21VZNbBgv35aAk/Xa+1SlRjf6yUj
         fpqB9z/W+9e3tLx8SUvr09jaL+8D68+yfn7At6FAeiBaA1glen9k/DdCFte6JDz5X/sZ
         ShKrar4Omrb/4Sa6xdMWn5xdWIqWQbgURSiqhTQhjFH1cmVQ5sDelec/MPIbm9xVhTYd
         43+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=BLQhBkzThc5wElIUsHc2zAb2IUWmlXfCDG1CajkcIjg=;
        b=YxMHK9nEBSfpQgfi5kcGij6j3/e+fEO2url9oFgaDVnsllTWbOk1VZS57lolEsXQMw
         fNSdxpkBmYLtlWBVYl20PWPwOElc2VVcfy7/Ml0bqwOBZm+KZfuvr7seYQG7rzfpac9V
         fm3k3JStYPVhgKUYANob0GeeFk6EeVHpX188LlQL1eA2cepNpp1vi1ifAYnEUnX4MI0T
         VUqIft8XPS+Z6n9+vUv6PMgUMDVAWiP16VGSRBC6JuJK0QqYvglvE9UkhPdMVOzzVwcD
         YSyjBrau/UxamSwPdwlLxBeQ+fukPCoNvltX2rmEtCbPCrACfrStuOmA/BXwy2Nu4Hhy
         Y8EA==
X-Gm-Message-State: AOAM531/3u1A5NNauRyILA7bk9WFkptW2dzJxUWP96fqPDIpBmHO74in
        iERK5DdUKqy5IeQ0rSXUjbmmieDqdZlH9Q==
X-Google-Smtp-Source: ABdhPJxfQZfH5raouxjz7FWh60DTXFFP8HIvwwCXC8VoU5lMMGWDaU9N83eIR4YH49T7pamZBG2cdjM2S1zzPQ==
X-Received: from shakeelb.svl.corp.google.com ([2620:15c:2cd:202:bda6:1a8e:6bfd:ec0c])
 (user=shakeelb job=sendgmr) by 2002:a63:82c7:: with SMTP id
 w190mr5449998pgd.117.1637694561581; Tue, 23 Nov 2021 11:09:21 -0800 (PST)
Date:   Tue, 23 Nov 2021 11:09:16 -0800
Message-Id: <20211123190916.1738458-1-shakeelb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH v2] mm: thp: update split_queue_len correctly
From:   Shakeel Butt <shakeelb@google.com>
To:     David Hildenbrand <david@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The deferred THPs are split on memory pressure through shrinker
callback and splitting of THP during reclaim can fail for several
reasons like unable to lock the THP, under writeback or unexpected
number of pins on the THP. Such pages are put back on the deferred split
list for consideration later. However kernel does not update the
deferred queue size on putting back the pages whose split was failed.
This patch fixes that.

Without this patch the split_queue_len can underflow. Shrinker will
always get that there are some THPs to split even if there are not and
waste some cpu to scan the empty list.

Fixes: 364c1eebe453 ("mm: thp: extract split_queue_* into a struct")
Signed-off-by: Shakeel Butt <shakeelb@google.com>
---
Changes since v1:
- updated commit message
- incorporated Yang Shi's suggestion

 mm/huge_memory.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index e5483347291c..d393028681e2 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2809,7 +2809,7 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
 	unsigned long flags;
 	LIST_HEAD(list), *pos, *next;
 	struct page *page;
-	int split = 0;
+	unsigned long split = 0;
 
 #ifdef CONFIG_MEMCG
 	if (sc->memcg)
@@ -2847,6 +2847,7 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
 
 	spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
 	list_splice_tail(&list, &ds_queue->split_queue);
+	ds_queue->split_queue_len -= split;
 	spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
 
 	/*
-- 
2.34.0.rc2.393.gf8c9666880-goog

