Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9966E31F34F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 01:23:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbhBSAXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 19:23:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbhBSAXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 19:23:12 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C26FC061574
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 16:22:32 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id t5so2274355qti.5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 16:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=U/iWzYWPjCN+XW1A2BqmtUjlIIZumhGvP/yo+EmOxYg=;
        b=G7bAXsSfm+ZNftqz1PsApsrrwJT8rMmTOEArec4kk5JfXkHSn5yAxj9DM4umoFPnWp
         RGmtL7d5uL9H7zRtAjVAbKIkaAF8ufdT94u9akurg8SFStJwtepBldAe7CzJ3uhcaMzp
         9WEo3HH6yOSmwI+Lcgdd4NIQ6NS6Js00aG5ddncE4w0J4+Ks2433wNoGqaOZDjsXit0l
         tdPTVlwbwaNJ+GN5c/McwoIy7K8gu4vVTR2V/16/tycbQ9v2qp4R93lfHwogeNIl0Kjn
         NzIwqCWwxxy9qLwZ9Mf402aMCg10rkgFlP6McJvh2yH2Fz6dXez8C9TT4sRw8BpZBGe+
         MWNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=U/iWzYWPjCN+XW1A2BqmtUjlIIZumhGvP/yo+EmOxYg=;
        b=GCYU7pmxDTxcwuHQfHAfPoHC03pOdo7nRW2bHlmF4zivW5/KB2MRmgfrvWOdumOhV4
         3/8/WgRg3sToquS4yuXJBvSDPEb1fNkFhds73ndn+USuL1CfY3xdFKTeZPugefmlJ2gS
         n+3+WlqOS9Zoge+wKQ4xuzBoaqJN09qlxomquMLg8JQzKAsnHWsfVbUeMqqIPcO2V51A
         TkfX7NfULdpvp1c520RUkyE1VJjceMj1mNLetGyCwoET0fRnadwY7ri6RZhbd53okx5b
         EqJKGpu09BgQS91Ggi3YFgBVO3xFIZm0jyz76t60Hhr2bwl0SnBA4OTjF3EsMiseGx6D
         hJeQ==
X-Gm-Message-State: AOAM533FKtmatmLQAHKrDi0uG6XZ/PCNVvDt3tNtnfDS3F00344PlrsC
        hEXAFCUxm1gXJknGdxGTK8hD5KtKL491MJZk
X-Google-Smtp-Source: ABdhPJyFsVJtAau0Mc2BHt611wI2ENN7q1M05EoS8ziF6kD66XPpoztxHVTEQqqAY5LyC/zaszm81323HxFZMODP
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:2d89:512e:587f:6e72])
 (user=andreyknvl job=sendgmr) by 2002:a0c:8b8a:: with SMTP id
 r10mr6826124qva.52.1613694151028; Thu, 18 Feb 2021 16:22:31 -0800 (PST)
Date:   Fri, 19 Feb 2021 01:22:23 +0100
Message-Id: <c8e93571c18b3528aac5eb33ade213bf133d10ad.1613692950.git.andreyknvl@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.617.g56c4b15f3c-goog
Subject: [PATCH v2 1/2] kasan: initialize shadow to TAG_INVALID for SW_TAGS
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, KASAN_SW_TAGS uses 0xFF as the default tag value for
unallocated memory. The underlying idea is that since that memory
hasn't been allocated yet, it's only supposed to be dereferenced
through a pointer with the native 0xFF tag.

While this is a good idea in terms on consistency, practically it
doesn't bring any benefit. Since the 0xFF pointer tag is a match-all
tag, it doesn't matter what tag the accessed memory has. No accesses
through 0xFF-tagged pointers are considered buggy by KASAN.

This patch changes the default tag value for unallocated memory to 0xFE,
which is the tag KASAN uses for inaccessible memory. This doesn't affect
accesses through 0xFF-tagged pointer to this memory, but this allows
KASAN to detect wild and large out-of-bounds invalid memory accesses
through otherwise-tagged pointers.

This is a prepatory patch for the next one, which changes the tag-based
KASAN modes to not poison the boot memory.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 include/linux/kasan.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index 14f72ec96492..44c147dae7e3 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -30,7 +30,8 @@ struct kunit_kasan_expectation {
 /* Software KASAN implementations use shadow memory. */
 
 #ifdef CONFIG_KASAN_SW_TAGS
-#define KASAN_SHADOW_INIT 0xFF
+/* This matches KASAN_TAG_INVALID. */
+#define KASAN_SHADOW_INIT 0xFE
 #else
 #define KASAN_SHADOW_INIT 0
 #endif
-- 
2.30.0.617.g56c4b15f3c-goog

