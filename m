Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CCC342114D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 16:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233942AbhJDOai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 10:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233767AbhJDOag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 10:30:36 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC16C061745
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 07:28:47 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id y15so6706265lfk.7
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 07:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0LHatFhVEIqMlI2Msj/gKIKEeT6D+78N3ryw0xfIhf4=;
        b=QGO/ulsvPQ98gRMYF3sIRAWyWai5o4ioiYmqDqdO0Wt81Wjn9/ddpCKpzIjdljWaVx
         ycGTegDq5EcpJGQToHEUIz8KOxgT4AZCembfMm9K5iGsjsnvAXCFmJ7bgG6BIURWIj6N
         DcB0vMhIbyUzmGvOUtTV4zkcje83glJbCMWnS+fmuYrkOz9rUlPBsXuttCfV2bd18AUe
         K7l43++pjUB+vlfDhLJ+9qb8BYAeb+n156MFLmjbnGyCapzhGHGlzJPpFOsAYcPF1/nf
         PY+v/abcCvFxtd8h4MEbVm96tBsrEdf2cpqQrmEKZ3vIoocRTznyKxOlBKRu4lKhv/i3
         Jucw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0LHatFhVEIqMlI2Msj/gKIKEeT6D+78N3ryw0xfIhf4=;
        b=mAZIai82dt6mh88fC72krc6LmsTnkpkdL46Q4TRKVlIdmrSKkDBTXpx78hT1oHxGUt
         83ylx5+XC4rTdBVb9z4+vSqRWWKWtRdR/o3lwzkDC5wPeoHRvzeQ0ah35Jdua5guL0H3
         OZGZXJ+guCsrMff6PVyKguOQyrQe8FQegakqavrEsbsUYKy/4QprwDPKlOpqjs80F7td
         iXPNnp4NOrkPgH4a7/jVgVBPb0a/FHhZ0FBu1RerHZbHYEs+jBN5NGmJO7J73PRXCb22
         Wey1dBEr5wurP1bz8zWVKt3igAKcdysYG0naTp74ga3WW3jysK7MTdyAmar6gXgDWIZr
         YI1g==
X-Gm-Message-State: AOAM533P4cWpbZhceOEqgYtlaEXvplM+QnebLi8wWeeazk09AKWkdWpA
        4n7Xrc8hH+BTlk2k8QF6EKQ=
X-Google-Smtp-Source: ABdhPJzNPnvc1CO4IOvFyX1d4m2ON2hLZB/7CiFpBal3s8jAdqO42Mg2HEVq4rjm84SPVvj56OxmLQ==
X-Received: by 2002:a05:6512:3082:: with SMTP id z2mr14905907lfd.657.1633357724143;
        Mon, 04 Oct 2021 07:28:44 -0700 (PDT)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id x15sm1338299lfe.129.2021.10.04.07.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 07:28:43 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@suse.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 2/2] mm/vmalloc: Check various alignments when debugging
Date:   Mon,  4 Oct 2021 16:28:29 +0200
Message-Id: <20211004142829.22222-2-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211004142829.22222-1-urezki@gmail.com>
References: <20211004142829.22222-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before we did not guarantee a free block with lowest start address
for allocations with alignment >= PAGE_SIZE. Because an alignment
overhead was included into a search length like below:

     length = size + align - 1;

doing so we make sure that a bigger block would fit after applying
an alignment adjustment. Now there is no such limitation, i.e. any
alignment that user wants to apply will result to a lowest address
of returned free area.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 9cce45dbdee0..343cb5d40706 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1269,7 +1269,7 @@ find_vmap_lowest_linear_match(unsigned long size,
 }
 
 static void
-find_vmap_lowest_match_check(unsigned long size)
+find_vmap_lowest_match_check(unsigned long size, unsigned long align)
 {
 	struct vmap_area *va_1, *va_2;
 	unsigned long vstart;
@@ -1278,8 +1278,8 @@ find_vmap_lowest_match_check(unsigned long size)
 	get_random_bytes(&rnd, sizeof(rnd));
 	vstart = VMALLOC_START + rnd;
 
-	va_1 = find_vmap_lowest_match(size, 1, vstart);
-	va_2 = find_vmap_lowest_linear_match(size, 1, vstart);
+	va_1 = find_vmap_lowest_match(size, align, vstart);
+	va_2 = find_vmap_lowest_linear_match(size, align, vstart);
 
 	if (va_1 != va_2)
 		pr_emerg("not lowest: t: 0x%p, l: 0x%p, v: 0x%lx\n",
@@ -1458,7 +1458,7 @@ __alloc_vmap_area(unsigned long size, unsigned long align,
 		return vend;
 
 #if DEBUG_AUGMENT_LOWEST_MATCH_CHECK
-	find_vmap_lowest_match_check(size);
+	find_vmap_lowest_match_check(size, align);
 #endif
 
 	return nva_start_addr;
-- 
2.20.1

