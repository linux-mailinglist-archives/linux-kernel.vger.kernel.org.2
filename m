Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BDD7408A19
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 13:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239574AbhIML1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 07:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239555AbhIML1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 07:27:48 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C596EC061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 04:26:32 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id a11-20020a0ca98b000000b0037855a1171fso55550277qvb.12
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 04:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=heQI9hJRYZNN0F3wqdwBsNM0iszmJ1+UNOx43ei/BCA=;
        b=i2hbw8Fe7sVHU566q0FLXy62ugeDqkJJyt5CZ0CRDVVlErfT6R2EnyiQMD2UU2/8b0
         ScsIl8ZafYdGmTDU17WrkZjAdWMBTxCG84VNlB90cTj1wPLvAbpdRu5MzsQCort61cMg
         62WdBVzIcnTrZR5wU6SLRHuQPFSjZNCt/uUuQfyR84h4tq6uZoRPBXGeR6Bt69NhJd/8
         nn7Kd4Bl1ctKe69OVC4+J5P9F+lHpQcq2TthmzMBZKOs7YMXnuXxKLh2KJ/WGDKyXb/C
         eMBlk2cF39wbq6Z8BALvgLIF4+TBDj+vD93yBLW4fvWl0PLVrsDqhQhFeBcpTMwHL6lg
         PW1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=heQI9hJRYZNN0F3wqdwBsNM0iszmJ1+UNOx43ei/BCA=;
        b=CJ3cY3wqrpJkIfDZE9IPGh5did6i9h48fIAKDWWme1qSozdrLyX8x/cxvSFQwopnBH
         cfdrwC+IyQvQrt4mqcT3pvKl/Hrbj+WP07cAh0Y9k4cGdfLRq7fLFz5VhznDMQ8ULvSO
         VoEQZ4dAg3pWdlN6LaQaBYwThsJhFbCnepVKy3zrlSJHZCMUBb1DZ5DP4k0UdNhEBrIl
         xydNrn0Tf/Ir/RWGUiZ+chQ8ssusByVpL8A3RZmCXfvBs8FHWizaISeuIpz9ymd3YtKp
         bzbqfaIKPccazVSg0bKblPX+ZcB4+kNUnW9EyFSjC+epF8O6su9LdTLyxm0iOtO3FDTg
         ICqQ==
X-Gm-Message-State: AOAM531qvlTXIV+FCAL5SHpjN8C4D2uqtNL2k1h5mc09ijcKTSjykVWx
        kqM4Gib05e9JEbA+7N4P7kNJBD0jQg==
X-Google-Smtp-Source: ABdhPJyW/EhPrZl53ptstiIf3nFkaM5zOt+a6HCqqc/9uUTbLofGIrfJ/QCoYU1DvLk95ohhAm6quwmfXQ==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:1f19:d46:38c8:7e48])
 (user=elver job=sendgmr) by 2002:a05:6214:250f:: with SMTP id
 gf15mr10095078qvb.2.1631532391965; Mon, 13 Sep 2021 04:26:31 -0700 (PDT)
Date:   Mon, 13 Sep 2021 13:26:05 +0200
In-Reply-To: <20210913112609.2651084-1-elver@google.com>
Message-Id: <20210913112609.2651084-3-elver@google.com>
Mime-Version: 1.0
References: <20210913112609.2651084-1-elver@google.com>
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: [PATCH v2 2/6] lib/stackdepot: remove unused function argument
From:   Marco Elver <elver@google.com>
To:     elver@google.com, Andrew Morton <akpm@linux-foundation.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Walter Wu <walter-zh.wu@mediatek.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vijayanand Jitta <vjitta@codeaurora.org>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Aleksandr Nogikh <nogikh@google.com>,
        Taras Madan <tarasmadan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

alloc_flags in depot_alloc_stack() is no longer used; remove it.

Signed-off-by: Marco Elver <elver@google.com>
Tested-by: Shuah Khan <skhan@linuxfoundation.org>
Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 lib/stackdepot.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index 0a2e417f83cb..c80a9f734253 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -102,8 +102,8 @@ static bool init_stack_slab(void **prealloc)
 }
 
 /* Allocation of a new stack in raw storage */
-static struct stack_record *depot_alloc_stack(unsigned long *entries, int size,
-		u32 hash, void **prealloc, gfp_t alloc_flags)
+static struct stack_record *
+depot_alloc_stack(unsigned long *entries, int size, u32 hash, void **prealloc)
 {
 	struct stack_record *stack;
 	size_t required_size = struct_size(stack, entries, size);
@@ -309,9 +309,8 @@ depot_stack_handle_t stack_depot_save(unsigned long *entries,
 
 	found = find_stack(*bucket, entries, nr_entries, hash);
 	if (!found) {
-		struct stack_record *new =
-			depot_alloc_stack(entries, nr_entries,
-					  hash, &prealloc, alloc_flags);
+		struct stack_record *new = depot_alloc_stack(entries, nr_entries, hash, &prealloc);
+
 		if (new) {
 			new->next = *bucket;
 			/*
-- 
2.33.0.309.g3052b89438-goog

