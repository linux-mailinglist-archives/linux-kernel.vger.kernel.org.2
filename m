Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A11930B0B0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 20:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbhBATpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 14:45:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232227AbhBATox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 14:44:53 -0500
Received: from mail-lj1-x249.google.com (mail-lj1-x249.google.com [IPv6:2a00:1450:4864:20::249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85BFBC061788
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 11:43:51 -0800 (PST)
Received: by mail-lj1-x249.google.com with SMTP id a5so2034138ljp.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 11:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=vdSQ7N299ttJfkAji9JrIXHPqKuzBqRIB40yh5wvGsM=;
        b=Phj+HIZS3dxn0owHV5yLJaaC0AGJkEU7TfgxvzoS86S8PoZm4Rt1g+God+bs67EJc+
         oAD4CGWKbkQlIIbCUNovOV1zLvhKFi5m+ZzhOblNupaIUd5ggX6TEZOlIrDz5XWmWLta
         JTZs7Uw7XmdRI9FLQF1x63YHp2a9KJzeObyFVOK0Yf424coQsCFXhiGhs5WSS+Wfdr5+
         DV7O2YJKktRTJmORtVpVqwjlVS56TeRw4d0zGoTpGadYHfwg5/12VFuGKUvo3egw2HjJ
         JyuLK5fUm/yWENE6Hh73fMc8gwZMa7zXTtIL5S8EwT3PsxdE5NtR2aqDG2mEhfgqxwDS
         Cr8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=vdSQ7N299ttJfkAji9JrIXHPqKuzBqRIB40yh5wvGsM=;
        b=hAnnjQijqm8MsXwdplcZHoy/inN1kbj0441OCg4euBATLl9OuclMrQJYI0W0y88zF0
         IyR9xpA1VpFbY/QvrElLgxko549XBRTnmf89jkC5k7pXC4usQ0AT54N2YY6c7aFuZpie
         PYw9j2ZvJtusxiIteATAi79lvVHPscywnEXwWVdVbvEj4KH0mij38vk+G9LDErBB/JjM
         6rP4oHY1hFeqKS64iPio2fBdMgE9MF3X7AIp1ESpiNpgWw5V1xcnz4ftqERI4GRzSIFO
         s87ja5aj+BiMME/1iqxQYAXIHT5kLbKNFSyJAsuo+miTEW0JkxJEf3eOsUB0rMCKeWrj
         6YQQ==
X-Gm-Message-State: AOAM530X9JUjcMXlG05y/X6BrrNkpVBi9q0ExPaR6yLlngj3Hon2bn0t
        DWcFrHJAXfLx5hVdCp3RUTSu0e8fFQTElKbU
X-Google-Smtp-Source: ABdhPJyTPeHvPlSg3evueEvog+d2Wbu3vFUyi7JAGczcnckPOWrvdcuYouS1E9V9e/DkjSKSFt3vDyjaDwqvcObf
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:ac2:44b8:: with SMTP id
 c24mr9569637lfm.155.1612208629709; Mon, 01 Feb 2021 11:43:49 -0800 (PST)
Date:   Mon,  1 Feb 2021 20:43:28 +0100
In-Reply-To: <cover.1612208222.git.andreyknvl@google.com>
Message-Id: <e762958db74587308514341a18622ff350a75d8a.1612208222.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1612208222.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH 04/12] kasan: clean up setting free info in kasan_slab_free
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Put kasan_stack_collection_enabled() check and kasan_set_free_info()
calls next to each other.

The way this was previously implemented was a minor optimization that
relied of the the fact that kasan_stack_collection_enabled() is always
true for generic KASAN. The confusion that this brings outweights saving
a few instructions.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/common.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index a7eb553c8e91..086bb77292b6 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -350,13 +350,11 @@ static bool ____kasan_slab_free(struct kmem_cache *cache, void *object,
 
 	kasan_poison(object, cache->object_size, KASAN_KMALLOC_FREE);
 
-	if (!kasan_stack_collection_enabled())
-		return false;
-
 	if ((IS_ENABLED(CONFIG_KASAN_GENERIC) && !quarantine))
 		return false;
 
-	kasan_set_free_info(cache, object, tag);
+	if (kasan_stack_collection_enabled())
+		kasan_set_free_info(cache, object, tag);
 
 	return kasan_quarantine_put(cache, object);
 }
-- 
2.30.0.365.g02bc693789-goog

