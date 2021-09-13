Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7053408A1D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 13:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239596AbhIML16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 07:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239549AbhIML1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 07:27:53 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C88A7C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 04:26:37 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id d2-20020a0caa02000000b003784ba308f1so55579694qvb.9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 04:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ptSP4yyc5ltqSERpcwLdEP2vwQAqnRLUENIn1iThCXw=;
        b=lQJHcNeX6xmyAzHEBQijP50dslqB4ng/uZaXNlPMDkefvXL1DmklWKmkgYFNycLqh6
         QqZ10XQ247wUWTQ2+uMyHvCrbximNAhp396NL4rInA4JSL8Y1fxCDV2JelnMx0Ndarrq
         1iB+NB6DcgsFstDQpdu787ZRUaVXbr6bQJ8y60pGHOGar1RbB+jBt9vBN2OrR4Zmg2SC
         D3khYK6nF+5Wbzrq9be7/M/x9nXkcbXtPyOeanOwJ4M5+aHD4kQ2McxcB55ee7N396Ed
         4/wIsAvhPXKTYR/JvOWtXQkyQi7jh+z85TBd7hBgH3lONGOFlRRPiZ2/BetPVsWzDX/v
         GH9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ptSP4yyc5ltqSERpcwLdEP2vwQAqnRLUENIn1iThCXw=;
        b=HolDeAoKIUekz7myenjupZbElNfABIgMCzoIVvAtupq7SCj0lfyts6sFolZrsshJi3
         TwwJu+hR0k1yadOQY+tcD9oi+gqMwaA6AN/Z9B34s0q1699YeTaHGnClgXOEO0ghwssI
         viNxJ0/kDa70mOXrHjqECCYKgwzEAXpQ8/BjnpM1UPi9Fsl46ESDETaJGGD2gNdkYq61
         fTmUwPtpKLM44oAkvn4VVGcq/kGExc9BQq9odveZvoFdMq0bACpBcEOX7DX/Ek8RfFgY
         gNYdEQAra3ePkS/3htdMOgAOf3h8Zp4g7GTkKhed7YAqiX7PR1+JIpokxflo9KHyldB9
         TNoA==
X-Gm-Message-State: AOAM531/dF65h+Rwom1VTs2nS2p6gskjcCOawi18j4fFNCmJLAS6G5Rv
        Ij6iGQLlZZe3LrP/VOM1RHiwGzUHyw==
X-Google-Smtp-Source: ABdhPJwEq/LT0qtGFvFgCGkRgy6m1M7iEma80J+GQ4oANgWzfE9nbLt7djdJjIebizDl8HvmEU3Ms3Ha7Q==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:1f19:d46:38c8:7e48])
 (user=elver job=sendgmr) by 2002:a05:6214:1142:: with SMTP id
 b2mr10077845qvt.0.1631532396945; Mon, 13 Sep 2021 04:26:36 -0700 (PDT)
Date:   Mon, 13 Sep 2021 13:26:07 +0200
In-Reply-To: <20210913112609.2651084-1-elver@google.com>
Message-Id: <20210913112609.2651084-5-elver@google.com>
Mime-Version: 1.0
References: <20210913112609.2651084-1-elver@google.com>
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: [PATCH v2 4/6] kasan: common: provide can_alloc in kasan_save_stack()
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

Add another argument, can_alloc, to kasan_save_stack() which is passed
as-is to __stack_depot_save().

No functional change intended.

Signed-off-by: Marco Elver <elver@google.com>
Tested-by: Shuah Khan <skhan@linuxfoundation.org>
Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 mm/kasan/common.c  | 6 +++---
 mm/kasan/generic.c | 2 +-
 mm/kasan/kasan.h   | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 2baf121fb8c5..3e0999892c36 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -30,20 +30,20 @@
 #include "kasan.h"
 #include "../slab.h"
 
-depot_stack_handle_t kasan_save_stack(gfp_t flags)
+depot_stack_handle_t kasan_save_stack(gfp_t flags, bool can_alloc)
 {
 	unsigned long entries[KASAN_STACK_DEPTH];
 	unsigned int nr_entries;
 
 	nr_entries = stack_trace_save(entries, ARRAY_SIZE(entries), 0);
 	nr_entries = filter_irq_stacks(entries, nr_entries);
-	return stack_depot_save(entries, nr_entries, flags);
+	return __stack_depot_save(entries, nr_entries, flags, can_alloc);
 }
 
 void kasan_set_track(struct kasan_track *track, gfp_t flags)
 {
 	track->pid = current->pid;
-	track->stack = kasan_save_stack(flags);
+	track->stack = kasan_save_stack(flags, true);
 }
 
 #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
index c3f5ba7a294a..2a8e59e6326d 100644
--- a/mm/kasan/generic.c
+++ b/mm/kasan/generic.c
@@ -345,7 +345,7 @@ void kasan_record_aux_stack(void *addr)
 		return;
 
 	alloc_meta->aux_stack[1] = alloc_meta->aux_stack[0];
-	alloc_meta->aux_stack[0] = kasan_save_stack(GFP_NOWAIT);
+	alloc_meta->aux_stack[0] = kasan_save_stack(GFP_NOWAIT, true);
 }
 
 void kasan_set_free_info(struct kmem_cache *cache,
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index 8bf568a80eb8..fa6b48d08513 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -251,7 +251,7 @@ void kasan_report_invalid_free(void *object, unsigned long ip);
 
 struct page *kasan_addr_to_page(const void *addr);
 
-depot_stack_handle_t kasan_save_stack(gfp_t flags);
+depot_stack_handle_t kasan_save_stack(gfp_t flags, bool can_alloc);
 void kasan_set_track(struct kasan_track *track, gfp_t flags);
 void kasan_set_free_info(struct kmem_cache *cache, void *object, u8 tag);
 struct kasan_track *kasan_get_free_track(struct kmem_cache *cache,
-- 
2.33.0.309.g3052b89438-goog

