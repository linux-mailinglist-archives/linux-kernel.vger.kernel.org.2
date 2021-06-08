Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4477139EF01
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 08:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbhFHGye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 02:54:34 -0400
Received: from mail-yb1-f202.google.com ([209.85.219.202]:42841 "EHLO
        mail-yb1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbhFHGyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 02:54:25 -0400
Received: by mail-yb1-f202.google.com with SMTP id 22-20020a250d160000b0290532b914c9f4so25596695ybn.9
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 23:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=el9m4nJm2ABZGSXDbSDzRvh2IOwN+krWXJF343PJuq0=;
        b=TVpKZCnUIXnWAkU8iVk2TfsLMEF3UFbYS54yNKPP4LARDPoLlYcikn5iURqWn4+1P9
         UFGkO098m8w5IB+8Yd1YmYH1JP/x2RXdUXL0NztHtzf9Y0xlGz+LV3RncB0xrMzag2lS
         uuYlSICwhmFRXVt5Ljmnc16OAPE0PYqo756hD2ry6uJn7hvVZiZNLDz1lUQ7+lgLexMy
         ejTa1BBf276CH27qMwqIPtHpA4loHyNeexwiuCUasQHEeEnaDvrUC5QyuEAf7k3YNARd
         KaJMgAdEKMfwDieDoMDr4xJAWBW3EuirKNcrkVm7z2YALiPQRreKWq3OY2cwRcPFU5KC
         SIsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=el9m4nJm2ABZGSXDbSDzRvh2IOwN+krWXJF343PJuq0=;
        b=IrK5dcSmj2Fokj60llyseEyEE8T89eJCmGOSGghD1P537ggIdBjlklXF3me7V2VTZf
         3StDYWBDgsSYet/yQ/GNQQFke8kbjs2yjTBk4Prs6ljSHMevRb+we6YvnJVEGKzottHq
         bixt0pYifFdoNdp8hRMBbCJ3fDwIX1xKJPOwL4a43MsJ9DNBls3p8ahZjlk5TNvdB1g5
         JAODDtyW8Kjv1Iag+2yCYx0v1P/jgFDkOEAGLHBpZJewwkZhL7TtyOApoDGOT+F3QjO5
         wTES0k6WfxVRrf4fZt+C1uBHga8SqEoJ3WS4o50gJ34dSKid7arSXznTZUc+TlTYSe6H
         F0Xg==
X-Gm-Message-State: AOAM532WIR55gBZzpBzTW05wl/F0rjpwUaub+pBHtQ1O48slLb9DCQE+
        Hd/oQETlhFNQ8iaybM8YmrtOzsdcVfrUXw==
X-Google-Smtp-Source: ABdhPJzyPWJlEcZupmOi+AKNU/JJGCCgiB9QzacwxQLd6sGpxGqAiR1NYFJp/GHMQM/ViLfx4L+JauebETqmkw==
X-Received: from spirogrip.svl.corp.google.com ([2620:15c:2cb:201:868:b4e3:8c14:177d])
 (user=davidgow job=sendgmr) by 2002:a25:a449:: with SMTP id
 f67mr32854218ybi.388.1623135092957; Mon, 07 Jun 2021 23:51:32 -0700 (PDT)
Date:   Mon,  7 Jun 2021 23:51:28 -0700
In-Reply-To: <20210608064852.609327-1-davidgow@google.com>
Message-Id: <20210608065128.610640-1-davidgow@google.com>
Mime-Version: 1.0
References: <20210608064852.609327-1-davidgow@google.com>
X-Mailer: git-send-email 2.32.0.rc1.229.g3e70b5a671-goog
Subject: [PATCH v3 4/4] kasan: test: make use of kunit_skip()
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        Alan Maguire <alan.maguire@oracle.com>
Cc:     Marco Elver <elver@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        kunit-dev@googlegroups.com, kasan-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Gow <davidgow@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marco Elver <elver@google.com>

Make use of the recently added kunit_skip() to skip tests, as it permits
TAP parsers to recognize if a test was deliberately skipped.

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: David Gow <davidgow@google.com>
Reviewed-by: Daniel Latypov <dlatypov@google.com>
Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
---

No changes since v1

 lib/test_kasan.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/lib/test_kasan.c b/lib/test_kasan.c
index cacbbbdef768..0a2029d14c91 100644
--- a/lib/test_kasan.c
+++ b/lib/test_kasan.c
@@ -111,17 +111,13 @@ static void kasan_test_exit(struct kunit *test)
 } while (0)
 
 #define KASAN_TEST_NEEDS_CONFIG_ON(test, config) do {			\
-	if (!IS_ENABLED(config)) {					\
-		kunit_info((test), "skipping, " #config " required");	\
-		return;							\
-	}								\
+	if (!IS_ENABLED(config))					\
+		kunit_skip((test), "Test requires " #config "=y");	\
 } while (0)
 
 #define KASAN_TEST_NEEDS_CONFIG_OFF(test, config) do {			\
-	if (IS_ENABLED(config)) {					\
-		kunit_info((test), "skipping, " #config " enabled");	\
-		return;							\
-	}								\
+	if (IS_ENABLED(config))						\
+		kunit_skip((test), "Test requires " #config "=n");	\
 } while (0)
 
 static void kmalloc_oob_right(struct kunit *test)
-- 
2.32.0.rc1.229.g3e70b5a671-goog

