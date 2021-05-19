Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D55A638928F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 17:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354768AbhESP3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 11:29:41 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:34455 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239585AbhESP3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 11:29:38 -0400
Received: from mail-qt1-f198.google.com ([209.85.160.198])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1ljO7M-0004jM-Au
        for linux-kernel@vger.kernel.org; Wed, 19 May 2021 15:28:16 +0000
Received: by mail-qt1-f198.google.com with SMTP id z9-20020a05622a0609b02901f30a4fcf9bso6056559qta.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 08:28:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LqXyRtSuCtmt1Bdfqb5uxqT0FX+dQwjS7N5xNghObYo=;
        b=Qv9RGWM7wOBnOAxlpv53SGKBowuVMkEiQq66qbAoCNTC9gcFB0O3wbhY7UdOipcCFX
         NoyC3FqBzyjZjrBT/XgoPUPRtlELpF7sB6YkGea0vOZd9kxZMswXT2KHa35+AELpJmdn
         vk1pvff7IV7V5Vz3wk+lViQItKBAdbji4I6l7pgFD3pBXXz1FV7ynGrHRchYfuui2yqv
         tEMCmb8N8CD6KuqFu4WRV3AoQzoMtW6c+1L9TZPoW9yOAogrlWlx//uvvudI2ucwtokm
         aN9w98a4thL3ps6Y2fUoC8kZXxY+YJxnQGbd3J0MV4I4lyQlqg60YRS1Wj/9EWwrw2DT
         XzPQ==
X-Gm-Message-State: AOAM532FH261I83iDQQfKQzrW/qJG2mfmPxpS3gd0BNsHHalhCWe8Zfd
        dcUZvRzAycOyZweDFGvP3Jp1SYq0viWsXw7SO7LyKHMcqfBfdHvYi1rdM5ZEvebcEcdWSeEbQeg
        3XtVtiUgJdlXZS4Her6HNM2Zkr2GF7x3Z1umgCGaFdQ==
X-Received: by 2002:ac8:5bc7:: with SMTP id b7mr12111785qtb.274.1621438095523;
        Wed, 19 May 2021 08:28:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwy2l+1K1RnXggW90mxygky7jQA9uXUnrzz+97KlMRZIgaOw+SRk4vKqbYiR8VhSBVKGEmikw==
X-Received: by 2002:ac8:5bc7:: with SMTP id b7mr12111771qtb.274.1621438095360;
        Wed, 19 May 2021 08:28:15 -0700 (PDT)
Received: from localhost.localdomain ([45.237.48.1])
        by smtp.gmail.com with ESMTPSA id r9sm15234152qtf.62.2021.05.19.08.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 08:28:14 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Akinobu Mita <akinobu.mita@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Andrea Righi <andrea.righi@canonical.com>,
        Guilherme Piccoli <gpiccoli@canonical.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH] mm, page_alloc: really disable DEBUG_PAGEALLOC with hibernation
Date:   Wed, 19 May 2021 11:28:04 -0400
Message-Id: <20210519152804.27063-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The documentation of DEBUG_PAGEALLOC states that it cannot be used with
hibernation, however the Kconfig entry would allow it if
ARCH_SUPPORTS_DEBUG_PAGEALLOC && !PPC && !SPARC.

Fixes: ee3b4290aec0 ("generic debug pagealloc: build fix")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 mm/Kconfig.debug | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/Kconfig.debug b/mm/Kconfig.debug
index 1e73717802f8..0ace5b2a9d04 100644
--- a/mm/Kconfig.debug
+++ b/mm/Kconfig.debug
@@ -11,7 +11,7 @@ config PAGE_EXTENSION
 config DEBUG_PAGEALLOC
 	bool "Debug page memory allocations"
 	depends on DEBUG_KERNEL
-	depends on !HIBERNATION || ARCH_SUPPORTS_DEBUG_PAGEALLOC && !PPC && !SPARC
+	depends on !HIBERNATION && ARCH_SUPPORTS_DEBUG_PAGEALLOC && !PPC && !SPARC
 	select PAGE_POISONING if !ARCH_SUPPORTS_DEBUG_PAGEALLOC
 	help
 	  Unmap pages from the kernel linear mapping after free_pages().
-- 
2.27.0

