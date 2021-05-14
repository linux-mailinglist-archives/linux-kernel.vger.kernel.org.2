Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B11C380418
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 09:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232542AbhENHXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 03:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231331AbhENHXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 03:23:45 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57AFEC061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 00:22:33 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id d15-20020a05620a136fb02902e9e93c69c8so21228455qkl.23
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 00:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=wrcmbdNNJFx//dV10zYXdyJfZ8i9iBUOXuvlPxh7U7s=;
        b=apLDegMhJMs8ZJ0Xs14xG/DWMAf8uNy5/PaHXqPiLM8OqurGbgN1sVeEbolRgi0/aG
         0DawaeTh5ck+2X8Ylv+PY4v2330VfUWf6BPUkmj2ptIaD+Ol1DzXkgAW7Fp90P9ECPNE
         QAwsSYUmQjcMEcrqy3kP82OqM/N4PHuCoI4KWFl1Irp7k6mhVIG+rRY8sZprgvWtvqjx
         SRb70zB0XcVV8rwvWlkGWp1GsqCRjRi+LlSO+JNJhzk2qK43zl0DceiKNzB/HlXY26R3
         anbSM1z8wI5Vji63tRUEQQVkC3ETZR6Az+zIoChZ1tqRsDkv8GSMxNcypJMYtf6sWv2o
         zXww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=wrcmbdNNJFx//dV10zYXdyJfZ8i9iBUOXuvlPxh7U7s=;
        b=aRCHXa3mMVobmqN910sIpGQJfmAkrnzE4ffrW+vSew+J0Z6ksCOp3X5B4FkX726h67
         jXGJszM4FMTWqFYSvfoNxbD8wXrAX6oZp4sc8ikUT8x2B9ITrqqtlmdmgYqnNGeb30Z4
         ss5tRpap2H4JS+pPp7bAilX9IRpfO6pdYhJkz1aoSwWj5t+ZU6yHT6VcHWnXH8Bwp/Sb
         OkH8V3bcuTZn+YtuivVZrfOuBfAkuUnkxZoaT4+Vl95PLEdx5mYsqSvYKit6lvL1fhFu
         V/XuWvL5SOtippGsUJmErK/IrtvJOsC13txZvT9ybPyYpDzXsYfAgmUV0jtM3c4BV7Dr
         H/hw==
X-Gm-Message-State: AOAM531nygCzHLsY4DeLJY0c3bbPYjdq1Iv0yjZQ52n5NHtOznlHBedF
        RepjrBOQq2pRkSI/QEpncTeyJs4gahU=
X-Google-Smtp-Source: ABdhPJyrgq1xOyo6KhCUAYnPbyS44d0I9RWp+8tMVgCjHXLWI6cTgW68efaiiawnOHF4PRt7HvD3ZEBPBDY=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:e033:4e8b:8f1:9bb4])
 (user=glider job=sendgmr) by 2002:ad4:4810:: with SMTP id g16mr17927192qvy.21.1620976952308;
 Fri, 14 May 2021 00:22:32 -0700 (PDT)
Date:   Fri, 14 May 2021 09:22:28 +0200
Message-Id: <20210514072228.534418-1-glider@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.751.gd2f1c929bd-goog
Subject: [PATCH] kasan: slab: always reset the tag in get_freepointer_safe()
From:   Alexander Potapenko <glider@google.com>
To:     akpm@linux-foundation.org
Cc:     Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Elliot Berman <eberman@codeaurora.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With CONFIG_DEBUG_PAGEALLOC enabled, the kernel should also untag the
object pointer, as done in get_freepointer().

Failing to do so reportedly leads to SLUB freelist corruptions that
manifest as boot-time crashes.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Marco Elver <elver@google.com>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Elliot Berman <eberman@codeaurora.org>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Alexander Potapenko <glider@google.com>
---
 mm/slub.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/slub.c b/mm/slub.c
index feda53ae62ba..9a4f59e5b0c2 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -301,6 +301,7 @@ static inline void *get_freepointer_safe(struct kmem_cache *s, void *object)
 	if (!debug_pagealloc_enabled_static())
 		return get_freepointer(s, object);
 
+	object = kasan_reset_tag(object);
 	freepointer_addr = (unsigned long)object + s->offset;
 	copy_from_kernel_nofault(&p, (void **)freepointer_addr, sizeof(p));
 	return freelist_ptr(s, p, freepointer_addr);
-- 
2.31.1.751.gd2f1c929bd-goog

