Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 874364068AD
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 10:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231849AbhIJIn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 04:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231792AbhIJIn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 04:43:58 -0400
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA62C061574
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 01:42:47 -0700 (PDT)
Received: by mail-wr1-x449.google.com with SMTP id r11-20020a5d4e4b000000b001575c5ed4b4so255669wrt.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 01:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=U1vC9mnO0GBdoKpseWlG9U1U97SJv1m6txgMtoboTzg=;
        b=n3pl4+LNU7r9TdH1mDQnshwXXrJ9vN5/AKvWIaXaZxv0es3C1jvHbtpnaE0QoyYV3s
         bLzMocdz5kT6gVxVNalgb3Rwf1g0k9EoahxKhtlRy5vRfV5ydiH0KM1K3aua5WQf/jhQ
         1tDObTW3VBWsk+pCgb7Tf+yPh8ZHkEypT5aKJVHfdKdV1d6zZb9067AiUIgSQuzsO75y
         NXOWCE5zzpABN4Dd87620agkbPs2IzRkQx0sDmog2t7wur+K0jrercr6NHyPQhp73xuK
         3BRgM68/bFtIJeuuDG+hTjHf3C6pFpltVwe3+af/AR1CpsJbPP+EeH7EvgfxLWgY+FUM
         0BFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=U1vC9mnO0GBdoKpseWlG9U1U97SJv1m6txgMtoboTzg=;
        b=giFaF6xuUIet1sUsKPe2FYcXd+WgaL/FFQTQYERhYuiSai2mkUcK5ieJE8i3UzRUrU
         NNDoXUvlSKiJxpqYQvkkp6s49qEry87jPKvJU/3eOLqBddU8Q1pCsbM4KFbh/iPDkVfz
         PuvvOZw0GdnqLh4mCa7ji0h2ZIrStg0UCP48oCt81cg+aVKrU3K85nNRpwpX/nxWUIAZ
         NWD82JChzS36X4nk2PaKSr2K58+Npm8ehDdL0Adq3rObg+KfvUpAzI7XhInXx3V3YciH
         KI437+sjX8wX67p9e22hqQPj1MuQlUR4DuzGmUa9w2HhIhejW8QFVpqrGfDv9IYA2Bqe
         Or/w==
X-Gm-Message-State: AOAM533JkkGG4Bo7SDTGsrLvVyh7jaViQdjsJlXqGxUHgy6dW+B/DZ9Z
        IqmYYoZVNLRBeg9FuoiW4PnNnbm/6w==
X-Google-Smtp-Source: ABdhPJwGuEJMuTO6/viXWtuEQiUIMR2aLLdxdXs8HVQnZ36KCbdmjDe56A7J6bV12sPrDHYPPEoqITXNGw==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:98f9:2b1c:26b6:bc81])
 (user=elver job=sendgmr) by 2002:a05:600c:19cc:: with SMTP id
 u12mr411559wmq.0.1631263365627; Fri, 10 Sep 2021 01:42:45 -0700 (PDT)
Date:   Fri, 10 Sep 2021 10:42:40 +0200
Message-Id: <20210910084240.1215803-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: [PATCH] kasan: fix Kconfig check of CC_HAS_WORKING_NOSANITIZE_ADDRESS
From:   Marco Elver <elver@google.com>
To:     elver@google.com, Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, Aleksandr Nogikh <nogikh@google.com>,
        Taras Madan <tarasmadan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the main KASAN config option CC_HAS_WORKING_NOSANITIZE_ADDRESS is
checked for instrumentation-based modes. However, if
HAVE_ARCH_KASAN_HW_TAGS is true all modes may still be selected.

To fix, also make the software modes depend on
CC_HAS_WORKING_NOSANITIZE_ADDRESS.

Fixes: 6a63a63ff1ac ("kasan: introduce CONFIG_KASAN_HW_TAGS")
Signed-off-by: Marco Elver <elver@google.com>
---
 lib/Kconfig.kasan | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
index 1e2d10f86011..cdc842d090db 100644
--- a/lib/Kconfig.kasan
+++ b/lib/Kconfig.kasan
@@ -66,6 +66,7 @@ choice
 config KASAN_GENERIC
 	bool "Generic mode"
 	depends on HAVE_ARCH_KASAN && CC_HAS_KASAN_GENERIC
+	depends on CC_HAS_WORKING_NOSANITIZE_ADDRESS
 	select SLUB_DEBUG if SLUB
 	select CONSTRUCTORS
 	help
@@ -86,6 +87,7 @@ config KASAN_GENERIC
 config KASAN_SW_TAGS
 	bool "Software tag-based mode"
 	depends on HAVE_ARCH_KASAN_SW_TAGS && CC_HAS_KASAN_SW_TAGS
+	depends on CC_HAS_WORKING_NOSANITIZE_ADDRESS
 	select SLUB_DEBUG if SLUB
 	select CONSTRUCTORS
 	help
-- 
2.33.0.309.g3052b89438-goog

