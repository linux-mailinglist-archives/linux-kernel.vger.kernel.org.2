Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FDF638D3B6
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 06:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbhEVEoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 May 2021 00:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbhEVEoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 May 2021 00:44:16 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26C8AC0613ED
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 21:42:52 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 129-20020a2504870000b0290513326cc5e0so17349527ybe.10
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 21:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=+mCKHQLNW0bmkhVlCsKZrExVqQxng7WsA9n/3Ys5BVQ=;
        b=C5413F/lQS6sC2Bq71hJ5vmfehTB/Hkw2+Hegi0dATxWt0uIta2N9Q91/2q3RkxdnN
         owErC93qkIHMo0hFx0FYqn8FvQnYQZPgl2T9B7uHwoXdoYmyiAOkXw8EDXuJRf/SVCtE
         mk919RFkeWzYKg5CeI59P361gVsFJxJ5gCx1bX2rLwJJpZBo+O/2xqAUAntkHamULkOU
         r07xp3WXWPfsR5Okx+BcxYqHuwIUaoCqUickUOJ6DeMkZumC7w2rL2JXRhN1U1DRB5g6
         fAmwRodElUIptCDo4EYyDMKfF2J8VnmxwXKZyTi+/eLYbYf5/Qr5EvBkOO0hPhcKfngX
         FNZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=+mCKHQLNW0bmkhVlCsKZrExVqQxng7WsA9n/3Ys5BVQ=;
        b=oGRgeH0tiT99KvFZGjcdX8ePqjj3GGNrePoIb39VLo+q7ciO2GiIdvmVnZID2Gb15k
         bvWqvzpP/ciLNo/GYxrVMgw6x/TlCUtoSL95/1Eyry58xEZBmVH6pXIMDAzb+MFFL+yX
         TpQic5YQzPWmpVwb1bwHD6JksllwHi08IWs5MpbpDCUzAjmWOqr5l82r3fLF4EJgL9+Z
         y/FWrhz3Eqn+4td+gT7FcqRF33i2bpM87qtjravQkn5ST/+P5EuBGlAZxv4fZ+sdWIcs
         VgtAUnhotFFq6OlgoIfiWHs5Fp45bEgZ1k44jbAAYDMaYDkgZq42almEraTXEADt64pt
         48eA==
X-Gm-Message-State: AOAM533JSRQ8K+GN0MssN/B73mOLIyulMl9wB1HOXWG1Vi1HarzNpEMz
        Ftqk3MQNDmMJ2udbJe8UCJyQAoRKGalH1A==
X-Google-Smtp-Source: ABdhPJzfVQ4bGR7OTvcE8Dh17iy4veOvxbsqhzIgR/I5HutN6ubTmWSCnoMOIHBoD5X6g9EsF1XLwZNY4VLhsQ==
X-Received: from spirogrip.svl.corp.google.com ([2620:15c:2cb:201:74c:35f3:92d:b18a])
 (user=davidgow job=sendgmr) by 2002:a5b:d46:: with SMTP id
 f6mr14789792ybr.488.1621658571180; Fri, 21 May 2021 21:42:51 -0700 (PDT)
Date:   Fri, 21 May 2021 21:42:39 -0700
Message-Id: <20210522044241.2763088-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
Subject: [PATCH v2 1/3] kunit: arch/um/configs: Enable KUNIT_ALL_TESTS by default
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     David Gow <davidgow@google.com>, Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the default .kunitconfig (specified in
arch/um/configs/kunit_defconfig) specify CONFIG_KUNIT_ALL_TESTS by
default. KUNIT_ALL_TESTS runs all tests which have satisfied
dependencies in the current .config (which would be the architecture
defconfig).

Currently, the default .kunitconfig enables only the example tests and
KUnit's own tests. While this does provide a good example of what a
.kunitconfig for running a few individual tests should look like, it
does mean that kunit_tool runs a pretty paltry collection of tests by
default.

The example tests' config entry (CONFIG_KUNIT_EXAMPLE_TEST=y) continues
to be included -- despite now being redundant -- to provide an example
of how tests are enabled when KUNIT_ALL_TESTS is disabled.

A default run of ./tools/testing/kunit/kunit.py run now runs 70 tests
instead of 14.

Signed-off-by: David Gow <davidgow@google.com>
Acked-by: Daniel Latypov <dlatypov@google.com>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
---

Changes since v1:
https://lore.kernel.org/linux-kselftest/20210518035825.1885357-1-davidgow@google.com/
- Keep the KUNIT_EXAMPLE_TEST entry as an example.
- Move (in patches 2,3) kunit_defconfig to tools/testing/kunit/configs
  and replace all_tests.config.

 arch/um/configs/kunit_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/configs/kunit_defconfig b/arch/um/configs/kunit_defconfig
index 9235b7d42d38..e67af7b9f1bb 100644
--- a/arch/um/configs/kunit_defconfig
+++ b/arch/um/configs/kunit_defconfig
@@ -1,3 +1,3 @@
 CONFIG_KUNIT=y
-CONFIG_KUNIT_TEST=y
 CONFIG_KUNIT_EXAMPLE_TEST=y
+CONFIG_KUNIT_ALL_TESTS=y
-- 
2.31.1.818.g46aad6cb9e-goog

