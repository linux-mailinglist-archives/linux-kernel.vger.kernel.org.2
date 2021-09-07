Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83CB8402A89
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 16:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237456AbhIGOPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 10:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236696AbhIGOPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 10:15:13 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC6DC061575
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 07:14:06 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id t18-20020a05620a0b1200b003f8729fdd04so14671886qkg.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 07:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=N/5YJhYADcqy8sBs5vH/zCaS3u8GV2W+ZzJdQ0X+ILI=;
        b=LRISar8+QTrl1Cr1oyWe4vLdGfZUfkMlRlMDd/NK0Kmk7Y/DRBslXQaQ0X7mSxUXmi
         wm531M1XS426nqxMn1W8GRMqNBjylH38g87qY5EpxICYsHkCs5qHSUKERzjptpi6719j
         /H4m3kZq8l2uvNx0QnqHX3MM5QXCLSysyxGeMIbtYrxq/s1FGDvWMfmDgG9F/ec3c3xj
         idHtizK63LEw5945mpWMf49WMrAuJykA23g6B0zm+xUHYrMwrU9WiHBpfUfzb2yEvcES
         922lt7ECnXTIRcMYgYMWsz6BweWTWVC1fORFAVsMLnaSefXxhf96MSDLdFD0jEgeaOy2
         4+QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=N/5YJhYADcqy8sBs5vH/zCaS3u8GV2W+ZzJdQ0X+ILI=;
        b=bjWWM2kLe2L8VNv0Q+Aimau7dQ4ognIqZaOYwKkCGYKSkZksGgufLQJTACV75kdnFr
         HV2dhhRLm+pm1UiKbNBKz59WpcCFIDiYph0iDnGzUoRmIxt4UYqgYtOgVWUTDChTYDQI
         tkr/MUxFnYppPfNodykOWXuspu8aI6PyAVpS2zR5U/2wr/NgH9GuAOqMI5yM/7fFo5wi
         3FSi+2jxUuxQMj+Row+DXMZT9fmbOCI+CFgEuOwjhEjy77Au20niNHGmcS0p91PSPn86
         vdYAQAiewryWnDSUzd1tR/luGx5jBtruL/HPyd1zW/re3pF2gX/5tF6gKACGJ6RmYmyT
         v61Q==
X-Gm-Message-State: AOAM530jNx7CHhk8H/Hl7asprVo7EvFRJG64qeE9e55XOYC0unqrUaht
        6PPETwLrqGWmltWAhoJ64o7sN5y6SQ==
X-Google-Smtp-Source: ABdhPJyR8jDVjdhyUz93LlcEeykwrpaVXBAWFlVsgNr0Lvtqc/eGJKRewlggnz5eecPqJQAot9SMUph8Aw==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:6800:c1ea:4271:5898])
 (user=elver job=sendgmr) by 2002:a0c:be85:: with SMTP id n5mr17013941qvi.59.1631024045883;
 Tue, 07 Sep 2021 07:14:05 -0700 (PDT)
Date:   Tue,  7 Sep 2021 16:13:03 +0200
In-Reply-To: <20210907141307.1437816-1-elver@google.com>
Message-Id: <20210907141307.1437816-3-elver@google.com>
Mime-Version: 1.0
References: <20210907141307.1437816-1-elver@google.com>
X-Mailer: git-send-email 2.33.0.153.gba50c8fa24-goog
Subject: [PATCH 2/6] lib/stackdepot: remove unused function argument
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Walter Wu <walter-zh.wu@mediatek.com>,
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
2.33.0.153.gba50c8fa24-goog

