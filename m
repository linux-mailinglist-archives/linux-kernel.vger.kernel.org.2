Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC81540CEC1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 23:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232341AbhIOV1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 17:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232154AbhIOV06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 17:26:58 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50C42C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 14:25:39 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id w19so3850116pfn.12
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 14:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zhYwN/lCq5ZkLvxf/PjVkxh1djpp97jzhvuz0d4WTJs=;
        b=iQo7YEU2Ije7HfhxK5dK/P9pWxIHlUXld2/tqibk17hqHInnsYKx0o9GbqjoHag3eM
         mYu+CZL9Ejs05piAGCj9zaBkvAopdKdmRPgcG3pvMVL7WU/6fZoG05rIhUvASPq0gVS1
         OTlsgTdxfEWplKRUl532DZ5BauSSaDy/3RWP0adc2hxoaJI9day9SUYNDH/oFpqnYKXK
         QJ7yT327EkKWDufETgZG1ZU894QgLybavE5DIe0tL8ZR/Nc2HvdcgCLvL5I/7FTSo9ko
         q4CuuIhosQTaikm11sYRZ4667V/SeaVVcpvHf6uFZHOpo4cqDsltJkj4YG/K+INGX2xZ
         3t2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zhYwN/lCq5ZkLvxf/PjVkxh1djpp97jzhvuz0d4WTJs=;
        b=lG4NkqZ+AzR3MemBmm0uYAaT4PaTNJUWyeQLQdM9oBZZCihMxIvsihzNWWF/pHTR7H
         G8cdqPQH3QO87Hn3/ZeDgKp85qXpuY/VBAx+J/bfhatBHfn1R9zpmBlDtKDpZ//HWwOk
         R6R5OOcAkTKjDVv5c14tfTHmTZ6zgPe6+K2iAreTGsPCF3rB4BDVLgPGBx2DkgwyXaZX
         xYUJEqd8cfRpTzbDUI/fnJ5wfANmRBDLcfUtJdPuJcFf/ZJhpCVzUzMbHA70+08IOl9u
         AB2PqaPf3ZMWNJQ6AZVI/ruf86OIdy+RLH3hcCnE9nMyQIFtLINyBRpuz8YxJR95birl
         BbvQ==
X-Gm-Message-State: AOAM5323Npot8PScpJTrzyv+bTpUijBadBh/OPzK5rLthF7KsD8xEEu/
        xbSGA/4v8ZCeWqkFzuFvv6s=
X-Google-Smtp-Source: ABdhPJxSGIDvsYCuaBcntkAEAqdA+juDsJjjxrbZn3i/2+vvCCYgI9UCVTv0aMhAtT9ytvzOZ9YxZw==
X-Received: by 2002:a63:5c2:: with SMTP id 185mr1662389pgf.220.1631741138622;
        Wed, 15 Sep 2021 14:25:38 -0700 (PDT)
Received: from edumazet1.svl.corp.google.com ([2620:15c:2c4:201:c105:114d:6caf:7ab5])
        by smtp.gmail.com with ESMTPSA id b20sm720869pfl.9.2021.09.15.14.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 14:25:38 -0700 (PDT)
From:   Eric Dumazet <eric.dumazet@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH] mm/large system hash: avoid possible NULL deref in alloc_large_system_hash
Date:   Wed, 15 Sep 2021 14:25:30 -0700
Message-Id: <20210915212530.2321545-1-eric.dumazet@gmail.com>
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

If __vmalloc() returned NULL, is_vm_area_hugepages(NULL) will fault
if CONFIG_HAVE_ARCH_HUGE_VMALLOC=y

Fixes: 121e6f3258fe ("mm/vmalloc: hugepage vmalloc mappings")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
---
 mm/page_alloc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index b37435c274cf1cb1fabd26465ca7899bb610d91f..e115e21524739341d409b28379942241ed403060 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8756,7 +8756,8 @@ void *__init alloc_large_system_hash(const char *tablename,
 		} else if (get_order(size) >= MAX_ORDER || hashdist) {
 			table = __vmalloc(size, gfp_flags);
 			virt = true;
-			huge = is_vm_area_hugepages(table);
+			if (table)
+				huge = is_vm_area_hugepages(table);
 		} else {
 			/*
 			 * If bucketsize is not a power-of-two, we may free
-- 
2.33.0.309.g3052b89438-goog

