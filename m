Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA3730CA9D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 19:56:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239030AbhBBSzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 13:55:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233720AbhBBSox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 13:44:53 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A31C061573
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 10:44:13 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id t63so20851175qkc.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 10:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6NrYwMryjhSf8mb6qdDWT1m6IwDhTR3/t7R1WlKEKoI=;
        b=WLd+qHBVqRdD250/aYzj9n/ag1cWfmEHEDwFhQuNz21u2ptdc+L+vQl/LLxjhNbKsI
         ES7/wJd2DxX8IWjGzN1+xNuiZJCyjaxsf2EKFhyKUl8sxBMPFRfG7RHt1f6TKWp+X9Vk
         3gqkNpPBGMfsUkXJKwDBYmpSqdBgvf0DyZuCAZ8+S4mxms04TX6L4UoSHKbexEkgyFNP
         Ckx8Ybq64XG82JKWmeLCZHNQ5MkRkmmtc5WOkPoZ4LbowWPlTfhgk7RtsahV75rxyhi9
         7P+fV3nHLPSChNwTskvKY/bFGwbM3vjFQVEk4lA/LzoZhRW/jAbJKyvxKUAsmTupqEb7
         jhgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6NrYwMryjhSf8mb6qdDWT1m6IwDhTR3/t7R1WlKEKoI=;
        b=RZiepzvZkR28kUOZgU/YxUl0PsN//xu6GTMDHVuJ6+oflF+257mQoAt4vZUdXAKxaV
         O4rJau64Goe0FvAdp5y7tD38OECfw+4J1JxtrRzy+pAjTRmX+Ij9qjxd2MFuNkUZsVnn
         04fhWi1SF9FahUQbVzr907VcgEbEQOwLDUAa6OJHJ9/4FwPOOZ2jQ9YgDZVj9PHBJ7IE
         P+z9nF1LualTAWMpvGUU234t2s8b4HLES2xpyBIAmw6VTt0kDwd4MgQCnbeR1kQ4Ezz0
         JfJ2yiYtP40WaVjNYr6UDdr5Fq6vZw01pu5V8vctsWzdb9mHWgzwMwl6ZgDDkr0gABQ7
         yQiw==
X-Gm-Message-State: AOAM530lGBlv/QhCHtP7GkfA2PZaYwIrDSroJQQs82YQwKVlvbn2VYHG
        XlKNP1GXyxBeqlPaUvYfmWhilg==
X-Google-Smtp-Source: ABdhPJwExZvBVVEUtLaD1ZuRfZiAGXecrwPpVpHunS7NXDpk+oqMsb7jUQEKW7IIQU99XQGapTqPqg==
X-Received: by 2002:a37:4d8e:: with SMTP id a136mr21354060qkb.317.1612291452536;
        Tue, 02 Feb 2021 10:44:12 -0800 (PST)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id x74sm16903842qkb.55.2021.02.02.10.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 10:44:11 -0800 (PST)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH] mm: vmstat: add some comments on internal storage of byte items
Date:   Tue,  2 Feb 2021 13:44:11 -0500
Message-Id: <20210202184411.118614-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Byte-accounted items are used for slab object accounting at the cgroup
level, because the objects in a slab page can belong to different
cgroups. At the global level these items always change in multiples of
whole slab pages. The vmstat code exploits this and stores these items
as pages internally, which allows for more compact per-cpu data.

This optimization isn't self-evident from the asserts and the division
in the stat update functions. Provide the reader with some context.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 include/linux/vmstat.h |  6 ++++++
 mm/vmstat.c            | 12 ++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
index 773135fc6e19..506d625163a1 100644
--- a/include/linux/vmstat.h
+++ b/include/linux/vmstat.h
@@ -313,6 +313,12 @@ static inline void __mod_node_page_state(struct pglist_data *pgdat,
 			enum node_stat_item item, int delta)
 {
 	if (vmstat_item_in_bytes(item)) {
+		/*
+		 * Only cgroups use subpage accounting right now; at
+		 * the global level, these items still change in
+		 * multiples of whole pages. Store them as pages
+		 * internally to keep the per-cpu counters compact.
+		 */
 		VM_WARN_ON_ONCE(delta & (PAGE_SIZE - 1));
 		delta >>= PAGE_SHIFT;
 	}
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 1cf549dd703e..eff67397301b 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -346,6 +346,12 @@ void __mod_node_page_state(struct pglist_data *pgdat, enum node_stat_item item,
 	long t;
 
 	if (vmstat_item_in_bytes(item)) {
+		/*
+		 * Only cgroups use subpage accounting right now; at
+		 * the global level, these items still change in
+		 * multiples of whole pages. Store them as pages
+		 * internally to keep the per-cpu counters compact.
+		 */
 		VM_WARN_ON_ONCE(delta & (PAGE_SIZE - 1));
 		delta >>= PAGE_SHIFT;
 	}
@@ -555,6 +561,12 @@ static inline void mod_node_state(struct pglist_data *pgdat,
 	long o, n, t, z;
 
 	if (vmstat_item_in_bytes(item)) {
+		/*
+		 * Only cgroups use subpage accounting right now; at
+		 * the global level, these items still change in
+		 * multiples of whole pages. Store them as pages
+		 * internally to keep the per-cpu counters compact.
+		 */
 		VM_WARN_ON_ONCE(delta & (PAGE_SIZE - 1));
 		delta >>= PAGE_SHIFT;
 	}
-- 
2.30.0

