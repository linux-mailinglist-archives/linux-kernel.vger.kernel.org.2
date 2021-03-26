Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B87F34AC05
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 16:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbhCZPyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 11:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbhCZPyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 11:54:18 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F04BC0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 08:54:18 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id j9so4385076wrx.12
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 08:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0gM6MhylLmsS8UCBArcB0UX6YnOZb1avXJIhdnV1ZL0=;
        b=Nvokwcp8C6Q63inAZFN/z19xXEPEDjuV+T40QLKS7Z2tiQi2UyGBw6rh40N2x1Rgkf
         QKWZBe03CGLxL1YDoXiwB5w8+q2xYtG68POgDy/ZisoSbg4XTrph51WFSy5POkz+Jjue
         x+ouFQ3ufKuH5/siuV0OegqR9cO+/baYiM5d5hxmVKlGG07lv1wDajwd3uN6lDcusyTo
         UvP+bWC2FKBHnj4kHTYID0i55T/1VA0kGy1iHN7/FVqpnB0D7xLBfQoDe4SkQ7rqFZ+H
         0o3mOgHCbasZ+KOaBRzNa2DOA7PITG6RwYrn6k20qasU6NWWbEa9EwgFueNp6Z13rm7K
         dKTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0gM6MhylLmsS8UCBArcB0UX6YnOZb1avXJIhdnV1ZL0=;
        b=L8CbNsaPL2ZYt+P2UJF1XWLIDBpVcgL6MrkxPXjBF8hs9gm4jvt/Zr3mJRiy/FKCOU
         Dh5zYUC/M3e5YjMwLsKLBSe73xI4Tk+gvSFFIEz0Feg1WUxoUlJEdGCmy8LUNM16MUBZ
         rQrFzqOX7SkLhNz96wXouKaV2Cmp0Hpzn/CnXW+uEk7ujasyDj4ap38VsxnHWttpXkVK
         qmCrd2viGZIJvcNz1uANXrPuKJzlwxB+4JEB8J0Dva1KgX9U96aqEW08L8+hTR6UTMpN
         rZ9lyDXdWWblPeraZ9sqcMm0N1X1wLq2w8GBREuPdxDQkWaltY+r9nnZ/3xIAT+/VTbP
         2k0g==
X-Gm-Message-State: AOAM530u5/0ratk7rkoO26p/1zSSLplv6GdsQhbAvni/Uw9bFqoWDwme
        6jJWb2x8FOrB+1V2wbu6O7pruA==
X-Google-Smtp-Source: ABdhPJyKW70DH/l/rfFUAPqGEausbzi3IVnX01AzVH/A1qIwTZxD2XB7mjeWj8CQjUy/aVtfuEO2EQ==
X-Received: by 2002:a5d:4312:: with SMTP id h18mr15209521wrq.193.1616774056883;
        Fri, 26 Mar 2021 08:54:16 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id k24sm11338971wmr.48.2021.03.26.08.54.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Mar 2021 08:54:16 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     minchan@kernel.org
Cc:     rostedt@goodmis.org, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, georgi.djakov@linaro.org
Subject: [PATCH] mm: cma: Add the CMA instance name to the cma_alloc_start trace event
Date:   Fri, 26 Mar 2021 17:54:14 +0200
Message-Id: <20210326155414.25006-1-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During CMA allocation, print also the name to identify the CMA instance.

Suggested-by: Minchan Kim <minchan@kernel.org>
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 include/trace/events/cma.h | 9 ++++++---
 mm/cma.c                   | 2 +-
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/include/trace/events/cma.h b/include/trace/events/cma.h
index cdfd06afb39a..be1525a10457 100644
--- a/include/trace/events/cma.h
+++ b/include/trace/events/cma.h
@@ -63,21 +63,24 @@ TRACE_EVENT(cma_release,
 
 TRACE_EVENT(cma_alloc_start,
 
-	TP_PROTO(unsigned int count, unsigned int align),
+	TP_PROTO(const char *name, unsigned int count, unsigned int align),
 
-	TP_ARGS(count, align),
+	TP_ARGS(name, count, align),
 
 	TP_STRUCT__entry(
+		__string(name, name)
 		__field(unsigned int, count)
 		__field(unsigned int, align)
 	),
 
 	TP_fast_assign(
+		__assign_str(name, name);
 		__entry->count = count;
 		__entry->align = align;
 	),
 
-	TP_printk("count=%u align=%u",
+	TP_printk("name=%s count=%u align=%u",
+		  __get_str(name),
 		  __entry->count,
 		  __entry->align)
 );
diff --git a/mm/cma.c b/mm/cma.c
index 984c85fd16ec..df5673d0b23d 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -443,7 +443,7 @@ struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align,
 	if (!count)
 		goto out;
 
-	trace_cma_alloc_start(count, align);
+	trace_cma_alloc_start(cma->name, count, align);
 
 	mask = cma_bitmap_aligned_mask(cma, align);
 	offset = cma_bitmap_aligned_offset(cma, align);
