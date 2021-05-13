Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0995B37FE40
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 21:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbhEMThe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 15:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbhEMThZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 15:37:25 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED70FC061761
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 12:36:13 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id b19-20020ac84f130000b02901d543c52248so15442874qte.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 12:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=mKHn5nW8hMSnIzbkNUA9bgAI/5jrfrz+RnfoZbF6j1k=;
        b=NxbyH77uCpX5jHPLaIxntl4MMEN72o3nW4IkVxd/s3G+RDesqezz14zIzof8/hNPe5
         bs0sPo+sfbA/DkdAe5qwND2yDe8Q64E5hUI4+AlxryJRLiGkfRkjlkEyaeLS0d71adGe
         EqppPm6oUyDCv9k3uQh/y6lgpmsdCDlIbWeyBJwuntF8gv+cgoXCeMogRGjMI3rhvHiU
         idKnSaGs+vEa/rnr4VhDzukE8dvmoHkR0nl+RncsQ8iu8K1NZakuYD3gCSj7JWp3xwB/
         9z6F4Y/tGgPWGTtRj7Gf2L8/2hhiBm1mowzmxrLDhi1u0Lyaki06ZcxNxWrNj5V5IMuB
         4KtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=mKHn5nW8hMSnIzbkNUA9bgAI/5jrfrz+RnfoZbF6j1k=;
        b=ZO/aLLC74VxiEb1V/1naiY+niqTiRwj4b2KVmO+mgTUd1mzOLZAK5pkgTi+eMXWJxG
         5iLRP5FwEtiP0UfwS1wY9TOJf/elEvYaBM5IG8c/ZBLhYUc3JJ1MnKDKIG84miqeSFHv
         6PbLoz6/kf67ngOg2C7ROvLl3ZTKZC3+XlfCgFmjTzAArueAkWpsuhk+qpbSqBSVoTnk
         L/aK9k1Q3nd4EGUKDLZmZMZySQXrSTtkyORE+LVOwmjA59ECgx82s8P9JhjqVioCY9Ap
         y8RLUb9sRVegNbYapAF9dkMm4OraF+eAlwlEQCKivo9PIMR8D3/ryCysVHhy4n7x4GQk
         Fs7w==
X-Gm-Message-State: AOAM533xl87i/Q1FErRgyLOjndPjf9CWUM0g+xBrIcafNjonQAn4ZA04
        wgICqCpyTXXl1/z8U2onDW990T0gN/W37w==
X-Google-Smtp-Source: ABdhPJzOzRUMhMpdqg5s7k2XyPDWGEgOheQSp/nxRF00tQp7xZJniBllI4qoqrF0m6c5fppZqVcMeF2SI9GnNQ==
X-Received: from spirogrip.svl.corp.google.com ([2620:15c:2cb:201:5f61:8ca4:879b:809e])
 (user=davidgow job=sendgmr) by 2002:a05:6214:373:: with SMTP id
 t19mr9320953qvu.45.1620934573116; Thu, 13 May 2021 12:36:13 -0700 (PDT)
Date:   Thu, 13 May 2021 12:32:00 -0700
In-Reply-To: <20210513193204.816681-1-davidgow@google.com>
Message-Id: <20210513193204.816681-6-davidgow@google.com>
Mime-Version: 1.0
References: <20210513193204.816681-1-davidgow@google.com>
X-Mailer: git-send-email 2.31.1.751.gd2f1c929bd-goog
Subject: [PATCH v2 06/10] mmc: sdhci-of-aspeed: Remove some unnecessary casts
 from KUnit tests
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Joel Stanley <joel@jms.id.au>
Cc:     David Gow <davidgow@google.com>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        openbmc@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With KUnit's EXPECT macros no longer typechecking arguments as strictly,
get rid of a number of now unnecessary casts.

Signed-off-by: David Gow <davidgow@google.com>
---
This should be a no-op functionality wise, and while it depends on the
first couple of patches in this series, it's otherwise independent from
the others. I think this makes the test more readable, but if you
particularly dislike it, I'm happy to drop it.

 drivers/mmc/host/sdhci-of-aspeed-test.c | 34 ++++++++++++-------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-aspeed-test.c b/drivers/mmc/host/sdhci-of-aspeed-test.c
index bb67d159b7d8..1ed4f86291f2 100644
--- a/drivers/mmc/host/sdhci-of-aspeed-test.c
+++ b/drivers/mmc/host/sdhci-of-aspeed-test.c
@@ -26,23 +26,23 @@ static void aspeed_sdhci_phase_ddr52(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, 15,
 			aspeed_sdhci_phase_to_tap(NULL, rate, 25));
 
-	KUNIT_EXPECT_EQ(test, (int)ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 0,
+	KUNIT_EXPECT_EQ(test, ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 0,
 			aspeed_sdhci_phase_to_tap(NULL, rate, 180));
-	KUNIT_EXPECT_EQ(test, (int)ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 0,
+	KUNIT_EXPECT_EQ(test, ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 0,
 			aspeed_sdhci_phase_to_tap(NULL, rate, 181));
-	KUNIT_EXPECT_EQ(test, (int)ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 1,
+	KUNIT_EXPECT_EQ(test, ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 1,
 			aspeed_sdhci_phase_to_tap(NULL, rate, 182));
-	KUNIT_EXPECT_EQ(test, (int)ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 1,
+	KUNIT_EXPECT_EQ(test, ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 1,
 			aspeed_sdhci_phase_to_tap(NULL, rate, 183));
-	KUNIT_EXPECT_EQ(test, (int)ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 2,
+	KUNIT_EXPECT_EQ(test, ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 2,
 			aspeed_sdhci_phase_to_tap(NULL, rate, 184));
-	KUNIT_EXPECT_EQ(test, (int)ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 3,
+	KUNIT_EXPECT_EQ(test, ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 3,
 			aspeed_sdhci_phase_to_tap(NULL, rate, 185));
-	KUNIT_EXPECT_EQ(test, (int)ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 14,
+	KUNIT_EXPECT_EQ(test, ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 14,
 			aspeed_sdhci_phase_to_tap(NULL, rate, 203));
-	KUNIT_EXPECT_EQ(test, (int)ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 15,
+	KUNIT_EXPECT_EQ(test, ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 15,
 			aspeed_sdhci_phase_to_tap(NULL, rate, 204));
-	KUNIT_EXPECT_EQ(test, (int)ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 15,
+	KUNIT_EXPECT_EQ(test, ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 15,
 			aspeed_sdhci_phase_to_tap(NULL, rate, 205));
 }
 
@@ -67,21 +67,21 @@ static void aspeed_sdhci_phase_hs200(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, 15,
 			aspeed_sdhci_phase_to_tap(NULL, rate, 96));
 
-	KUNIT_EXPECT_EQ(test, (int)ASPEED_SDHCI_TAP_PARAM_INVERT_CLK,
+	KUNIT_EXPECT_EQ(test, ASPEED_SDHCI_TAP_PARAM_INVERT_CLK,
 			aspeed_sdhci_phase_to_tap(NULL, rate, 180));
-	KUNIT_EXPECT_EQ(test, (int)ASPEED_SDHCI_TAP_PARAM_INVERT_CLK,
+	KUNIT_EXPECT_EQ(test, ASPEED_SDHCI_TAP_PARAM_INVERT_CLK,
 			aspeed_sdhci_phase_to_tap(NULL, rate, 185));
-	KUNIT_EXPECT_EQ(test, (int)ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 1,
+	KUNIT_EXPECT_EQ(test, ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 1,
 			aspeed_sdhci_phase_to_tap(NULL, rate, 186));
-	KUNIT_EXPECT_EQ(test, (int)ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 1,
+	KUNIT_EXPECT_EQ(test, ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 1,
 			aspeed_sdhci_phase_to_tap(NULL, rate, 187));
-	KUNIT_EXPECT_EQ(test, (int)ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 14,
+	KUNIT_EXPECT_EQ(test, ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 14,
 			aspeed_sdhci_phase_to_tap(NULL, rate, 269));
-	KUNIT_EXPECT_EQ(test, (int)ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 15,
+	KUNIT_EXPECT_EQ(test, ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 15,
 			aspeed_sdhci_phase_to_tap(NULL, rate, 270));
-	KUNIT_EXPECT_EQ(test, (int)ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 15,
+	KUNIT_EXPECT_EQ(test, ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 15,
 			aspeed_sdhci_phase_to_tap(NULL, rate, 271));
-	KUNIT_EXPECT_EQ(test, (int)ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 15,
+	KUNIT_EXPECT_EQ(test, ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 15,
 			aspeed_sdhci_phase_to_tap(NULL, rate, 276));
 }
 
-- 
2.31.1.751.gd2f1c929bd-goog

