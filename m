Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37D7B3A3CA4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 09:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbhFKHLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 03:11:13 -0400
Received: from mail-yb1-f201.google.com ([209.85.219.201]:34559 "EHLO
        mail-yb1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbhFKHLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 03:11:11 -0400
Received: by mail-yb1-f201.google.com with SMTP id x187-20020a25e0c40000b029052a5f0bf9acso3020135ybg.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 00:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=LQ+bL0LyWEuBvKFw9/83tjsdx33/GmsNwb90dPirq54=;
        b=j+989NVxGeoBKTNdCUyCt7A0xYVs25YuQ4FjeeRz22Txf04tK2+L0fZUi3tzaTlZJ3
         e8FDZNU4DPnKWlY8CDDgqIkBtRFGnoZ06Hxg0JWJdNZEdJblmXNcDqpx2SVwtHXrk240
         SA8XYKEJgLjaICS856fh+g7B0pR+yOAzTXnwf/io7mRyOrjYbnNBzcxAoJ0HcR6lYogy
         Tc7XTqZLYBQQyeMDT5y1nYtd/gce7CxJdQKL0gSREVOeP1HAklq3/hcTxIykZ6po2it/
         6Ds2axjjiUL4pzJ0re8cKf/VlhiYj0gTagkPN0LSbx6SjZK8Za19EK3STmnFhGmfGdkG
         PpEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=LQ+bL0LyWEuBvKFw9/83tjsdx33/GmsNwb90dPirq54=;
        b=H5CxYUGjgtitHv77lq3hkfMuVFTZFSkD0guSmIOHrqktm4pu+nr94ISVOuHazSeZzl
         CQ2wnImVsHfftSlHMFlEFigtcAsOUpxoUroOWRlfdG3aEHhuQP40oqjsxao2/0MNMw15
         Bc/JJPb4NJszDx9nxzZY/AFAsrzD3mX78mSF45NWZcQotTakibM6EARRy5KY3Di3C04H
         JK6Ta43XzvvrADjgYDs+SUvDbEf+a1rLuiYF/wfKeRoZgp17Na6ByfYXA+TohEUh8hyf
         cWnEEVrBOKQqxsbUvFISS0cX368/cnLkXLUjLgbmmNG7pFKztREo+pn3QIcFOYo7nvgh
         IARw==
X-Gm-Message-State: AOAM532YjE89iwtb3h1xjuhs7Rh5aaFxX9XKR2KG5oLpy64Ot+1uiyii
        zQu8pRxDM6RgIZLAtH7sknl2TcEB7qHqOw==
X-Google-Smtp-Source: ABdhPJxrQUs2QlsdpTTs5mR4fSWZfio1au2JPgCB+oll+MoNozk482w8c4iTVdwC/uvgz1mx8wa5z8Mz+tYW9Q==
X-Received: from spirogrip.svl.corp.google.com ([2620:15c:2cb:201:b697:a576:a25f:5b1e])
 (user=davidgow job=sendgmr) by 2002:a25:218b:: with SMTP id
 h133mr3766811ybh.160.1623395293932; Fri, 11 Jun 2021 00:08:13 -0700 (PDT)
Date:   Fri, 11 Jun 2021 00:08:02 -0700
In-Reply-To: <20210611070802.1318911-1-davidgow@google.com>
Message-Id: <20210611070802.1318911-4-davidgow@google.com>
Mime-Version: 1.0
References: <20210611070802.1318911-1-davidgow@google.com>
X-Mailer: git-send-email 2.32.0.272.g935e593368-goog
Subject: [PATCH v4 4/4] kasan: test: make use of kunit_skip()
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        Alan Maguire <alan.maguire@oracle.com>
Cc:     Marco Elver <elver@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
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
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
---

No changes since v3:
https://lore.kernel.org/linux-kselftest/20210608065128.610640-1-davidgow@google.com/

No changes since v2:
https://lore.kernel.org/linux-kselftest/20210528075932.347154-4-davidgow@google.com

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
2.32.0.272.g935e593368-goog

