Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6239391351
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 11:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233640AbhEZJFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 05:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233633AbhEZJE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 05:04:56 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E7F1C061761
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 02:03:24 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id v12so257923wrq.6
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 02:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/arfmioWBLl+bsHh1UkXgXV/45lpjUcVc8QQOrErq1I=;
        b=IKLvO0Amcwou2kpUEF4Q5W9RkdDW5MVj7SZSl6NxpozlTGBNHxubhLqpqgodj2qdPg
         XkMnNHaWZp3y7vUj22Y6KYO2m39UUuzcgY2lya6EBTtB+dWpg2bO+OQzHVaCzOdaKKjn
         DDDNXEvK2qRSdi7syM9rLUawkbjqIDCXcjWXoVLYuL3ItCJ32KasZUXw5OYSCtZ0h7K0
         +7+r4hA2DjRIrht5wxogbKEG9ql1PGuz3eCYlXk7Xx9X7hRHk9qIhysqEHME0ANaiNzw
         bA1COHgEsYuNnG6Xq5KFb7IzP6/3y5hCPnioWgLzr+68gB4uUq1cMCT5OubuP5Gec/sx
         uRMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/arfmioWBLl+bsHh1UkXgXV/45lpjUcVc8QQOrErq1I=;
        b=i36kxGkdFe6jYMPYZ0aYEcQHAYtRjENxlzotsR7uXA3uzVjD0q9HVZHoybPoe2+qkN
         y4cGiQed0OI07sGFWvldU6k7GysEPZHmF1EZnYkUPQ2JbTLAX4sON44P2YhZbR3g6drs
         teu4t4+oT3AsN0oNbNQ6qqHencLxNY1lQeibD0fwqce+GdNbpc2RZ/KXYzwLHS4A0xfe
         xms0IW4FKIQZFRs4Ng/owWFw+LYNzUTI8Tpvv3qZc6z7nmFQPfHH7KqxOKQDAG70wFQS
         KNtlLbIrg+plCfUZNWJdcQX5YHquda5HvOe0Mso2Wn0P82DQCpo1POsNDG3nVDCjOdmP
         vgKQ==
X-Gm-Message-State: AOAM532z1aERc2fyU6pXpGDiw/LT10pzY91lr+moyh49W7Jc2Rk2Gqzj
        0lOVRFSUbTO+7fUXS4WxDUVItA==
X-Google-Smtp-Source: ABdhPJxD6hf4X859eRImh9hnGp3tvmqXfjcvgUmlKakdWchmwoKQhk7/tmCM4Z7pezfmqXiCRdpidg==
X-Received: by 2002:a5d:5688:: with SMTP id f8mr31819035wrv.237.1622019802699;
        Wed, 26 May 2021 02:03:22 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:15:13:cd98:de82:208c:cbdb])
        by smtp.gmail.com with ESMTPSA id a17sm19021929wrt.53.2021.05.26.02.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 02:03:22 -0700 (PDT)
Date:   Wed, 26 May 2021 11:03:16 +0200
From:   Marco Elver <elver@google.com>
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com
Subject: Re: [PATCH 1/3] kunit: Support skipped tests
Message-ID: <YK4O1DkP1/DKzVU5@elver.google.com>
References: <20210526081112.3652290-1-davidgow@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210526081112.3652290-1-davidgow@google.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 26, 2021 at 01:11AM -0700, David Gow wrote:
> The kunit_mark_skipped() macro marks the current test as "skipped", with
> the provided reason. The kunit_skip() macro will mark the test as
> skipped, and abort the test.
> 
> The TAP specification supports this "SKIP directive" as a comment after
> the "ok" / "not ok" for a test. See the "Directives" section of the TAP
> spec for details:
> https://testanything.org/tap-specification.html#directives
> 
> The 'success' field for KUnit tests is replaced with a kunit_status
> enum, which can be SUCCESS, FAILURE, or SKIPPED, combined with a
> 'status_comment' containing information on why a test was skipped.
> 
> A new 'kunit_status' test suite is added to test this.
> 
> Signed-off-by: David Gow <davidgow@google.com>
[...]
>  include/kunit/test.h   | 68 ++++++++++++++++++++++++++++++++++++++----
>  lib/kunit/kunit-test.c | 42 +++++++++++++++++++++++++-
>  lib/kunit/test.c       | 51 ++++++++++++++++++-------------
>  3 files changed, 134 insertions(+), 27 deletions(-)

Very nice, thank you.

	Tested-by: Marco Elver <elver@google.com>

, with the below changes to test_kasan.c. If you would like an immediate
user of kunit_skip(), please feel free to add the below patch to your
series.

Thanks,
-- Marco

------ >8 ------

From: Marco Elver <elver@google.com>
Date: Wed, 26 May 2021 10:43:12 +0200
Subject: [PATCH] kasan: test: make use of kunit_skip()

Make use of the recently added kunit_skip() to skip tests, as it permits
TAP parsers to recognize if a test was deliberately skipped.

Signed-off-by: Marco Elver <elver@google.com>
---
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
2.31.1.818.g46aad6cb9e-goog

