Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAFE34073FC
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 01:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234874AbhIJXmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 19:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234873AbhIJXmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 19:42:11 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F555C061764
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 16:40:59 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id ib9-20020a0562141c8900b003671c3a1243so39739144qvb.21
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 16:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=38/p5aKRxAN8lvaZDp0zhtUI6Snq8bGJp4KjVNrFxmM=;
        b=ClMvaE/jVFqEicWYTwhAUMg4CT9sQl4FTtk1QCXYfLbxl/z8eHdJIAmCgHm0ALrTgX
         6NNH59sSA/uJQCslchF6+vv2WH3Lg/544Ks+SobQ/+vHBR9uvBUTTPEeS7JNF6PUh4x0
         oji9HFyfLs9jEkCignvCitSoNF0nVGZh5hwNh1AgzHc0OnruJ8CR5gEIeQjyktGD0MzY
         fQKinUWOCv3m1Ei2THDJfEOQz1du+tBXIUkNdScXAFG/FjoQ7YDGmtmvQG6xo8Qwx/bX
         Oc13hWa/cGbAxYbZtXqP2Oj0jLT+5yhsbqbqmBhQeMxDcyxNnCyLb1d/HZCWRSduFFwY
         zLbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=38/p5aKRxAN8lvaZDp0zhtUI6Snq8bGJp4KjVNrFxmM=;
        b=ptgehzgPrw0gFttqeqfcnp1vXNE3Umchtb8KTGlY86hiA7Na9UkrzTcfJQAx8gQlgz
         zUdaqTEeuF3AVJYdmYcXU40MACc86heT2nLe9RVmlVpOI15PXPVIhXi6urrGvTCshNkt
         FjYBPmgiSxBNGZ8aDXxAIKhFb6BiYpry0OZfdkwFyNm9tZNPmzxxC9ZFZQWdnKFm1LAB
         3oDDQi0AblAIj5vjCkZZHGLqULXrukwMFQ1zFMA0nyFZOjZCYsMlopR3yS0DCZOysZcw
         8JN+DxozwRzG5UcRej3VTRVaAigZ5KbC6xCVD0hWmEY9RPOEL/WP0Rr7UTWyjLlkWi5o
         1keQ==
X-Gm-Message-State: AOAM532YdCoQ69DmwSGHzR7HlHQgKZ7BbeTLinP5Nn5BkHFE0tE/kpQm
        jhzxvfofv2oSoA0k6zqhihoeqUNnfMyHY5qSGns=
X-Google-Smtp-Source: ABdhPJyjuPM8sCI8as/3lV6WlUxULncaKeVF02wBX8pFk93JyIjwijJyA1Yv263qUWK+idkJL/zGXVCgBbAeu963iTI=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:2b76:71d3:b5fb:3734])
 (user=ndesaulniers job=sendgmr) by 2002:a05:6214:104d:: with SMTP id
 l13mr11107802qvr.13.1631317258077; Fri, 10 Sep 2021 16:40:58 -0700 (PDT)
Date:   Fri, 10 Sep 2021 16:40:40 -0700
In-Reply-To: <20210910234047.1019925-1-ndesaulniers@google.com>
Message-Id: <20210910234047.1019925-4-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20210910234047.1019925-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: [PATCH 03/10] mm/ksm: remove old GCC 4.9+ check
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Nathan Chancellor <nathan@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Joe Perches <joe@perches.com>, Arnd Bergmann <arnd@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The minimum supported version of GCC has been raised to GCC 5.1.

Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 mm/ksm.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 025338128cd9..a5716fdec1aa 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -651,10 +651,8 @@ static void remove_node_from_stable_tree(struct stable_node *stable_node)
 	 * from &migrate_nodes. This will verify that future list.h changes
 	 * don't break STABLE_NODE_DUP_HEAD. Only recent gcc can handle it.
 	 */
-#if defined(GCC_VERSION) && GCC_VERSION >= 40903
 	BUILD_BUG_ON(STABLE_NODE_DUP_HEAD <= &migrate_nodes);
 	BUILD_BUG_ON(STABLE_NODE_DUP_HEAD >= &migrate_nodes + 1);
-#endif
 
 	if (stable_node->head == &migrate_nodes)
 		list_del(&stable_node->list);
-- 
2.33.0.309.g3052b89438-goog

