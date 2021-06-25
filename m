Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A68B83B3CE6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 08:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbhFYHAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 03:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbhFYHAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 03:00:48 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30644C061574
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 23:58:28 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id l132-20020a25258a0000b029054fc079d46eso2998525ybl.20
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 23:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=2nlTYNdkTccPa1M8YvTTP6TrQq3B5YIgoTfwE0h00Bs=;
        b=i1Rc1Z9hPqeYHQZxpNqttcH/1QfQSgHg2xZoUfBQWNjYaGrcgrRLmgI6eXC6Wmu1xX
         LQr+XvYYyl/Bl8qXOC09sonTLipPgLri6DX79FTlRpauP2A8vq7vQ4JPr397daInVdCS
         A+PbHWgE4r+nxv3Wb2TDdwDyFb5yepr20KuMqeFgr7a5/HteD/lLjdXAe5uiB7CRN6ts
         19hRmuaPZORiX/j+UR3KibjHH5hEmYgeaC7c90nHCbTPn5e/Ob85kGWDluJCRySp/HI4
         T6fTUUBWL44T1j3KNXn5P9nPFffFItImtVxgEZiet6ucVShla4h4ACzUHuOwKsgWP/48
         iepQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2nlTYNdkTccPa1M8YvTTP6TrQq3B5YIgoTfwE0h00Bs=;
        b=L+KK7PRlzBfgPtrAo0OElTxQxCswSg3/JRKWUaKLP320i20QZuPCLdOPg14uibxnKP
         1wJmhBkCWccEBAI2jf6E2xQSC7e2I5myXKin2RmfzKboWqjwzoE3SbbQeITWpylr/FVp
         4fqgRXuZWdHxAk5PSc4EdHTexMsO73Vc5GtCzKC9pQYDVATTKHsYdQ1WLr/R+XWiohKa
         mucsXnUrS4aqAws9H6vgn/3oGEdIrvndChFa/pJE7LLiWQTvcjLKC0gVvLCrAurIeQmX
         7T7/90SOZaDKDpxUDaQhb78FBbRedUZ0/eGCNtj1rPOvcIjYXiaF6GxzvSAQM9dK9+aw
         2SMg==
X-Gm-Message-State: AOAM530tWVi/rdBgP/hDcfNxmPOk99jzIxfTYhA8eVy+VmqSr2RKyHTW
        s+tJU158eBf2FnkL62PQUfuii01qfE/Kew==
X-Google-Smtp-Source: ABdhPJyl9qWG1WGb5COp4gwtPDejcLrh/cFAdVwveuRB6KmMlSw/RDhVd5rWL/MMTWFFtmtAVLeOxeBcZ4J4eg==
X-Received: from spirogrip.svl.corp.google.com ([2620:15c:2cb:201:bd17:f9ad:979a:a3a9])
 (user=davidgow job=sendgmr) by 2002:a25:2c02:: with SMTP id
 s2mr10313364ybs.139.1624604307372; Thu, 24 Jun 2021 23:58:27 -0700 (PDT)
Date:   Thu, 24 Jun 2021 23:58:15 -0700
In-Reply-To: <20210625065815.322131-1-davidgow@google.com>
Message-Id: <20210625065815.322131-4-davidgow@google.com>
Mime-Version: 1.0
References: <20210625065815.322131-1-davidgow@google.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [PATCH kunit-fixes v5 4/4] kasan: test: make use of kunit_skip()
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
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
---

No changes since v4:
https://lore.kernel.org/linux-kselftest/20210611070802.1318911-4-davidgow@google.com/
- Rebased on top of kselftest/kunit-fixes

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
2.32.0.93.g670b81a890-goog

