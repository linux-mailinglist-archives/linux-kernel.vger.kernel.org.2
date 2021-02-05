Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8DFF310EF9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 18:44:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233489AbhBEQAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 11:00:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233380AbhBEPxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 10:53:19 -0500
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 954EEC061788
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 09:35:01 -0800 (PST)
Received: by mail-wr1-x44a.google.com with SMTP id u15so5734219wrn.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 09:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=p2PHZd2SW9nz4o7+ZB1C3vkb9xhx8DH7M49Qc2p69KA=;
        b=CHtaYiFloTo1h3fJ4zIwrdm8kH9MlR88HYI0/PTh1ZWy7A7CwjuDxNrv9Gx69/d5EU
         /uH5wwsCw9lrcu3UgF0woJeX8LvF46mbIjl1UXDMCFstkACeUmi7LjrhuV3m6VC1O4FA
         kLqgo4s84+U9SrE4Ij3D8TumUHcGxjFAg+UvRisEMQ4KFqgiuA/0irNBtFKpJm7Y2yvr
         rv5nooR3qty/BvdTJILjp8ZF4GmyrzIoPmJkwuLqIJMGj3IC94nPtvOTvoNrBK4XD6v9
         DrdflvRnrv/sqjoyw4HnrP0YYgEVd4PzvqCF+NE7zyq5KY/kgr+v0ibadQ+YFmPfzDvT
         14Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=p2PHZd2SW9nz4o7+ZB1C3vkb9xhx8DH7M49Qc2p69KA=;
        b=kuVCX+2V1Frq90wPTuhfcdkBMfLZB2Q9bINZ65CjN0XJHgoQWi7msVJ/y0KWm2zPf1
         DHhgH/pBAqD694L88aQjE8fDEwab67b4IEeYIgfGHERGgl+ZiwVf/q8xIpCRRrf+dI13
         0gT7xagV3q5S7QyMg4D0cR3IOnjRt/zpwqabsQHuXWcLpSTUs10lN/rYjpySNK4y0yRd
         4f1o+qTUvDdCDkMcnb6BsU7vzNX4NKm1BnKDsZLHC9/MM83OKWtzwfQqXtgMifqSETFG
         PfCnNrixx6omfexuqEHQVtNjibfmyHRutM5udLQ26ncO+oRkmG5hkKON8WM6ZupZ3Kkg
         p2Vw==
X-Gm-Message-State: AOAM533g+lgEJw8MhqqiYYlvkcv6omERD+Hv6aeGPi5mQCF1jHR6/tij
        bln14kDdZBv5LRN5Cwp2gg1nPV9WgtOetwnm
X-Google-Smtp-Source: ABdhPJwIwsTCSScqaKOmzq93PUblNEb3imIDP3qjpFcJgdUvxRfwSWqIL28ID41mG6cwO7YBgmA2OyAuujnKhGSd
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:edb8:b79c:2e20:e531])
 (user=andreyknvl job=sendgmr) by 2002:adf:800b:: with SMTP id
 11mr4807938wrk.322.1612546500193; Fri, 05 Feb 2021 09:35:00 -0800 (PST)
Date:   Fri,  5 Feb 2021 18:34:38 +0100
In-Reply-To: <cover.1612546384.git.andreyknvl@google.com>
Message-Id: <f838e249be5ab5810bf54a36ef5072cfd80e2da7.1612546384.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1612546384.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH v3 mm 04/13] kasan: clean up setting free info in kasan_slab_free
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Cc:     Will Deacon <will.deacon@arm.com>,
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

Reviewed-by: Marco Elver <elver@google.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/common.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index f2a6bae13053..da24b144d46c 100644
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

