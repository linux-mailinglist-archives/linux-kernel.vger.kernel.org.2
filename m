Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC5B3820E0
	for <lists+linux-kernel@lfdr.de>; Sun, 16 May 2021 22:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233556AbhEPUWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 May 2021 16:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233417AbhEPUW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 May 2021 16:22:26 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 134BCC061573
        for <linux-kernel@vger.kernel.org>; Sun, 16 May 2021 13:21:11 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id j6so3058859lfr.11
        for <linux-kernel@vger.kernel.org>; Sun, 16 May 2021 13:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=79GjM4x/Ic55mS6eHRbboPY9tKUJn041OlCHIXbFv7w=;
        b=esKP1poaxeNM/5km5DjCa/yJ1+ew6bwu6Q3o4XP1drT/teb5LSfaAIEe/uF/TPmAmq
         uZYWLhiG9HpaB0wCfYjoLMiy7YNqWBCEhuRoB+ohw2TZd3OtrrOi1NrFz5TEjZ3g4O4L
         kbRzikCEryLvjNuCDCyDVrqmjjCY/XrI0qvhoxqZkhef8Ep4YwPJIbjXfxBDpeNCwyTx
         q51JJTtRJX1ZU0ghozgsmKMpy0EYlBVEc3hdoyAAXBPB304lGFrxi/VVBfq0pqaUCmso
         4r/MMzrjwjUKoFAFO8NDOd8WW5AIRJ1vLC98X9mE+PCDim6U82RdNnqgrMAZcDzCDJN7
         jsNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=79GjM4x/Ic55mS6eHRbboPY9tKUJn041OlCHIXbFv7w=;
        b=eydYgNzQ880yPHE9RShvGY4u3rlWnRzQS4YQ62+J/PP2EF2DcscKV56Qv7z4jeBy2i
         fgKpbUvRVtZ+9Y5aoVzKg6POP9dKctR0pmZCDbK2uLUEwn8/gogQ1MJU6Gzqv6UBwwI5
         EjTwPhhuU5a/NpipWwM0DZTw++Y9pj1qZl7FFw5MWqrYnpJKFb8NY7hlDuCQLvuUm8pS
         9fAjhHl86Q8AsjrBPhqVFZyeLnUcD4O/OKPrsylP3MUPARLcsya1ZytEgCMbSnTRWpvf
         yTEAh9u9nPnEgcpj2TQJi/NSpSOP9Qk7y0j9SxkJDY4UtqML1oFWBxo8nsmI7JQ3/WYk
         Sr5Q==
X-Gm-Message-State: AOAM531LbsCnP2WWy7wxm2irvh/4OMbOG8kXXOyXZ2QSdVqf0/DMhoG/
        6g6GpO8LUOLLfhY7b2VUyKg=
X-Google-Smtp-Source: ABdhPJy7wLHLdLMs4geBfOKh0U6fw0Z8tEv4vgtjJcHlMaTkZm3NcKvFoEDlb3xwhrSSZ8Hrd4jyMw==
X-Received: by 2002:a05:6512:21d:: with SMTP id a29mr6952310lfo.391.1621196469636;
        Sun, 16 May 2021 13:21:09 -0700 (PDT)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id y28sm378195lfg.210.2021.05.16.13.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 May 2021 13:21:09 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@suse.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 3/3] mm/vmalloc: Print a warning message first on failure
Date:   Sun, 16 May 2021 22:20:56 +0200
Message-Id: <20210516202056.2120-4-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210516202056.2120-1-urezki@gmail.com>
References: <20210516202056.2120-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a memory allocation for array of pages are not succeed
emit a warning message as a first step and then perform the
further cleanup.

The reason it should be done in a right order is the clean
up function which is free_vm_area() can potentially also
follow its error paths what can lead to confusion what was
broken first.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index a8e50278019a..b2a0cbfa37c1 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2781,11 +2781,11 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 	}
 
 	if (!area->pages) {
-		free_vm_area(area);
 		warn_alloc(gfp_mask, NULL,
 			   "vmalloc size %lu allocation failure: "
 			   "page array size %lu allocation failed",
 			   nr_small_pages * PAGE_SIZE, array_size);
+		free_vm_area(area);
 		return NULL;
 	}
 
-- 
2.20.1

