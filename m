Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01B9643F45E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 03:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbhJ2BfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 21:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbhJ2BfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 21:35:01 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C67BAC061570;
        Thu, 28 Oct 2021 18:32:33 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id gh1so5349601qvb.8;
        Thu, 28 Oct 2021 18:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pDbmTFmdUa1vOFovfEjzfndFY1x7Eiw6Kvd3FWDkoxc=;
        b=VSKovtfAXRDGln/ro6n8sMyFekczXY1eZL1Vs6yQnGCyL/B71u90blTbUPv/Lh9G+E
         AviMJm3uAkjgGNIvgeWw+wVPDLDaZbLY9MXpn8TmhFp12noEwyJm0Zt4xlXoQuMiLAbx
         3UhTBSb1Mvk3m/C5RH6av4ecX9wVEF9UWtBUkoYbGiMSRbcafB5u2JVIWtnv4qZ841NK
         TMzyuCiRa9/S7n0zeTwlyflVN/aeRZMEuP1KcmlxaJqgHPdNyomzts+K0ouTDIKRf3qW
         mmENiWzEWLXhTKGf9hGv3EZ46Ox0e9s/knwJywRZWk2IchUZB3ZfDuPqHMVuRDdd2GcD
         1kPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pDbmTFmdUa1vOFovfEjzfndFY1x7Eiw6Kvd3FWDkoxc=;
        b=NYybBB7oK0K1pXcQlxP91iQp79NrVs02Se2UJJpVuNReibmi6OvwY5v+gN/lCnYvcw
         nrLLukOG8fChSJvHQhJ8sQwFqIE8YyXmYOWrMiXng073kGZw+VChECqBpySnouJmX8rV
         97knFtQfjXj8x8m+oC5hnexOSS4Ga06ppJxBu2izRjscbb+aSGITCOTG7QbhuOljUbSi
         pOox9cWFWz/ZyCTO3+uA9IWN5cFyVpcN7o/p8vdtkT7wowhoi8tHD9YmMcF9Xcof7Pf8
         tKI7Npz4z51hsCGgpXm52lAU3p+3ssbW6OI6TPDpmBOw9pPHPI9r4nJPHF5IV/684b6L
         bVrQ==
X-Gm-Message-State: AOAM532MRUpOSDTikKfsVCwx5wvwXbQQ8YNKz6Mf4tsZ8RqsyvLPmayC
        Yde1GB1lbZepKD8H+Pp+TAQ=
X-Google-Smtp-Source: ABdhPJyrHjdj9XEFnRSkldMt/4/bkKu/0E5F2TesyOmk7mzCDa1MO0CC/b/Nxz1xs3dhtFkmkob2LA==
X-Received: by 2002:a05:6214:300c:: with SMTP id ke12mr7716024qvb.41.1635471152973;
        Thu, 28 Oct 2021 18:32:32 -0700 (PDT)
Received: from localhost.localdomain (c-67-187-90-124.hsd1.tn.comcast.net. [67.187.90.124])
        by smtp.gmail.com with ESMTPSA id az12sm2991612qkb.28.2021.10.28.18.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 18:32:32 -0700 (PDT)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] of: unittest: fix EXPECT text for gpio hog errors
Date:   Thu, 28 Oct 2021 20:32:25 -0500
Message-Id: <20211029013225.2048695-1-frowand.list@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

The console message text for gpio hog errors does not match
what unittest expects.

Fixes: f4056e705b2ef ("of: unittest: add overlay gpio test to catch gpio hog problem")
Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---
 drivers/of/unittest.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index 8c056972a6dd..5b85a2a3792a 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -1688,19 +1688,19 @@ static void __init of_unittest_overlay_gpio(void)
 	 */
 
 	EXPECT_BEGIN(KERN_INFO,
-		     "GPIO line <<int>> (line-B-input) hogged as input\n");
+		     "gpio-<<int>> (line-B-input): hogged as input\n");
 
 	EXPECT_BEGIN(KERN_INFO,
-		     "GPIO line <<int>> (line-A-input) hogged as input\n");
+		     "gpio-<<int>> (line-A-input): hogged as input\n");
 
 	ret = platform_driver_register(&unittest_gpio_driver);
 	if (unittest(ret == 0, "could not register unittest gpio driver\n"))
 		return;
 
 	EXPECT_END(KERN_INFO,
-		   "GPIO line <<int>> (line-A-input) hogged as input\n");
+		   "gpio-<<int>> (line-A-input): hogged as input\n");
 	EXPECT_END(KERN_INFO,
-		   "GPIO line <<int>> (line-B-input) hogged as input\n");
+		   "gpio-<<int>> (line-B-input): hogged as input\n");
 
 	unittest(probe_pass_count + 2 == unittest_gpio_probe_pass_count,
 		 "unittest_gpio_probe() failed or not called\n");
@@ -1727,7 +1727,7 @@ static void __init of_unittest_overlay_gpio(void)
 	chip_request_count = unittest_gpio_chip_request_count;
 
 	EXPECT_BEGIN(KERN_INFO,
-		     "GPIO line <<int>> (line-D-input) hogged as input\n");
+		     "gpio-<<int>> (line-D-input): hogged as input\n");
 
 	/* overlay_gpio_03 contains gpio node and child gpio hog node */
 
@@ -1735,7 +1735,7 @@ static void __init of_unittest_overlay_gpio(void)
 		 "Adding overlay 'overlay_gpio_03' failed\n");
 
 	EXPECT_END(KERN_INFO,
-		   "GPIO line <<int>> (line-D-input) hogged as input\n");
+		   "gpio-<<int>> (line-D-input): hogged as input\n");
 
 	unittest(probe_pass_count + 1 == unittest_gpio_probe_pass_count,
 		 "unittest_gpio_probe() failed or not called\n");
@@ -1774,7 +1774,7 @@ static void __init of_unittest_overlay_gpio(void)
 	 */
 
 	EXPECT_BEGIN(KERN_INFO,
-		     "GPIO line <<int>> (line-C-input) hogged as input\n");
+		     "gpio-<<int>> (line-C-input): hogged as input\n");
 
 	/* overlay_gpio_04b contains child gpio hog node */
 
@@ -1782,7 +1782,7 @@ static void __init of_unittest_overlay_gpio(void)
 		 "Adding overlay 'overlay_gpio_04b' failed\n");
 
 	EXPECT_END(KERN_INFO,
-		   "GPIO line <<int>> (line-C-input) hogged as input\n");
+		   "gpio-<<int>> (line-C-input): hogged as input\n");
 
 	unittest(chip_request_count + 1 == unittest_gpio_chip_request_count,
 		 "unittest_gpio_chip_request() called %d times (expected 1 time)\n",
-- 
Frank Rowand <frank.rowand@sony.com>

