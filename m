Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE2503116CD
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 00:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbhBEXNy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 18:13:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232632AbhBEO26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 09:28:58 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C635C061794
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 08:06:43 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id r18so5560847qta.19
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 08:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=p2PHZd2SW9nz4o7+ZB1C3vkb9xhx8DH7M49Qc2p69KA=;
        b=lF3JI1Wz7SI+mSyZFHoJHyreQdSUTq5QY643cGS9GBBxjPRvwFD+iqezyeavSwGDTF
         uMprUNPCKb6jIjNQ9H27Fur8RtWhiDepPMiibytUc1NJTu0f7IFzzowNuNjrqBgmlLiv
         7Tr4SU49efZvmHAiHw87MpqB2rqt/EdI6B3iqynlt/57vW11+kQCzeiLS4vtTtF/ES7x
         3KkjctyAS2VhFEOvDpZJ0NSt8AamjRfvI1fi97PPs+ONtwsp9zEj2O5BeVMpwlZmNVVm
         vJzDRFXwJbhi9UAyMxR5Qu1VM7ormDH+bsHuZ7T8/e7tIEZCLXPYodKzTASn4vvBqtYJ
         5c/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=p2PHZd2SW9nz4o7+ZB1C3vkb9xhx8DH7M49Qc2p69KA=;
        b=ezHsRFDYS2kBeadN85ZDjH691LRXQ1adwQLJ9N5rmusuzVclXYGhgyhwazp/jdcyEW
         Xl2HiJMnvegoRLSgirU4ERt2+c/xjwCLNCK8BN328WojWk/ziZoaCTaynJZh7JBGFZP5
         Nhi0+b2uI1dM3wpPXkdOLk10UgEwFJGJbd0Jlw/vRIYIyD9pMXVaUJQTHJfzM9NGjWQv
         LAUw9YkbZx9h7sfFl76LVq2oxa2gmTj9NxLbuJChdQVEDMxy962J1qypdwkawSTnH+4a
         CURZBOxWf0HHBVvsFr3TIHkmIYHbGYWA51a/YoNCViN3+OUc1StPRg7DDAV3fG1WLf7O
         xykA==
X-Gm-Message-State: AOAM533yLKz3e6aBik9iLYuwGeCZ7AGmR54fsFJu6lGZUGZvSeYok3cF
        6ui1SL7BSRYEaJVb6wG5qYSi1WZmSiLwSqo/
X-Google-Smtp-Source: ABdhPJzwsewfz/TZInoLtcuvYaZ0I40Qn7oK2vNyTP6uAYb18yvMtG1+sQlLK+ggxuOgSY+2gruJ4PNGKknNJrtO
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:edb8:b79c:2e20:e531])
 (user=andreyknvl job=sendgmr) by 2002:a0c:eda6:: with SMTP id
 h6mr4862060qvr.19.1612539567383; Fri, 05 Feb 2021 07:39:27 -0800 (PST)
Date:   Fri,  5 Feb 2021 16:39:05 +0100
In-Reply-To: <cover.1612538932.git.andreyknvl@google.com>
Message-Id: <ece9cd2cca38dd3797c6cd1756e30a2e40b0d451.1612538932.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1612538932.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH v2 04/12] kasan: clean up setting free info in kasan_slab_free
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

