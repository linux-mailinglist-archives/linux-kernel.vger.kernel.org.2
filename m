Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE894048B4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 12:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234319AbhIIKuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 06:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233990AbhIIKus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 06:50:48 -0400
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF922C061575
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 03:49:38 -0700 (PDT)
Received: by mail-wm1-x34a.google.com with SMTP id r3-20020a05600c35c300b002fbb0888a42so591080wmq.6
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 03:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=JKG2Csw+REpqX6pYLoajkSbStNWY+2P13qnXNLcGPTo=;
        b=oVBgZSF0f7gZb8HxrZbIdXzorsMl6/30hQtezrkGiG8Mjm7GMEenEEeX5JUiCbYIgx
         Doy4WrNjWdwiqs8RasWNSvfZMqCqnH3qDP5QY3UwDBgMIVon3xP9XEhsjAd1s9G2oe3x
         RiqzigUTJHbCf4sZNRHKAS30r6yHw0KBwy5YQPG1DjBL3/6mFcF5IBV5cgzgfseyw+lr
         N53YN3j9A/2jMxFze4B4nunFb0XIP42E5YN4mAKc7Ck8rGjvakkPbQCWqASi8Y3uDwYC
         thMRP3jA2e6aXbyMrjruuJeGvI7gZjIhXqKuZKJDaRFVke0PxsNbBzmW77HK7kksfQ58
         J8nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=JKG2Csw+REpqX6pYLoajkSbStNWY+2P13qnXNLcGPTo=;
        b=5jU4F8wa09S9HBRcLkgTB2Yr2dLzrTwSN06Dqac08Saki/ggbcu3ipXwoLrGTBJewH
         c/dzn6EPWslKW5PAvJEvP72lX4deuDvxQH5UY/JK60v0aTlhFYYW/XVfVqEvhO4PKT5S
         XOQVO2hAXndHBcNhSZD1coBPNpYNhAZf8chA4d9K/K9ipDc93Ft0b5/qxYToOmtw5KSB
         SUg4ivqvj5lIfjLEkqWKvcSrHDLCjGu5LCnwpAVl0OPHgFc43Jw39iwLmKW13+Jn/xD9
         k336B/1hJ3QT+qqSjHuPfzDAMUPgLF4TVViiL9+VZy5KoFOegN/2i3XzuXCZZEoYcUnH
         s7aA==
X-Gm-Message-State: AOAM531ImA81ZRJfn9v+CwMeU2w9SMPur+KZPGaVcsKaqUseUo4eXoLb
        wd0jRu1jxITqHNa1sdi9oBhybSnhtw==
X-Google-Smtp-Source: ABdhPJzkOAvHKQVqCuqxsCtyM6C/PyG02n+39nThS1IWFPChq3RDEGCJm3IbSKaPCz97WE1D6JAp5UuEWQ==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:98f9:2b1c:26b6:bc81])
 (user=elver job=sendgmr) by 2002:a05:600c:b4e:: with SMTP id
 k14mr2206453wmr.151.1631184577256; Thu, 09 Sep 2021 03:49:37 -0700 (PDT)
Date:   Thu,  9 Sep 2021 12:49:25 +0200
Message-Id: <20210909104925.809674-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.153.gba50c8fa24-goog
Subject: [PATCH] kasan: double -Wframe-larger-than threshold if KASAN
From:   Marco Elver <elver@google.com>
To:     elver@google.com, Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        Arnd Bergmann <arnd@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Aleksandr Nogikh <nogikh@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Taras Madan <tarasmadan@google.com>, linux-mm@kvack.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All architectures at least double stack size when using one of the KASAN
software modes that rely on compiler instrumentation.

Until now, warnings emitted by -Wframe-larger-than could easily be
ignored, as we would still get a working kernel.

However, with the introduction of -Werror (CONFIG_WERROR=y), it makes
sense to at least double the -Wframe-larger-than threshold for
software-based KASAN modes to reflect the already increased stack sizes
when building a kernel with KASAN enabled.

Link: https://lkml.kernel.org/r/YTbOs13waorzamZ6@Ryzen-9-3900X.localdomain
Signed-off-by: Marco Elver <elver@google.com>
---
 lib/Kconfig.debug | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index ed4a31e34098..2055bbb6724a 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -345,6 +345,8 @@ endif # DEBUG_INFO
 config FRAME_WARN
 	int "Warn for stack frames larger than"
 	range 0 8192
+	default 4096 if 64BIT && (KASAN_GENERIC || KASAN_SW_TAGS)
+	default 2048 if !64BIT && (KASAN_GENERIC || KASAN_SW_TAGS)
 	default 2048 if GCC_PLUGIN_LATENT_ENTROPY
 	default 1536 if (!64BIT && PARISC)
 	default 1024 if (!64BIT && !PARISC)
-- 
2.33.0.153.gba50c8fa24-goog

