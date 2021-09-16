Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6ED840E3A1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 19:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbhIPQvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 12:51:21 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:53278
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244157AbhIPQql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 12:46:41 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 4DDE43F4B9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 16:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631810719;
        bh=Bsa8JOGGCKGqD18D4sehfiJwGit16PjwUVoBvcbwuaE=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=FOFao9op70RKIETayHtyeTujsjwJlRD796Ak1KKguLOI6LnEXXtlK4Rfy6V333ys/
         FK72QFGK7H/Iv8FjQbNCUiRiOPb+SWCLgHc/jSUtWmTM7TnhAupdGvaNLbOu28ZiG8
         oImL7ezfjZCoEbv4eQlcHQ7X6p3VMiGj2PgrA6I8xvNWm/Hw0f+8EwuPQo9HJFQLMY
         1BBDBj6hMulWHY3xiZLeGsWhAHBHU4iu5Mm0xDbsI8a6q9p3hUEMv1+m0XA62v6FsC
         +9eTQR6dE23RrfNBbOx4eHZeiT5NmSL1D5b6idYA0sL/5EJ11fO9mMdnF81H+0/K3P
         LYbQ+KYksu0Zg==
Received: by mail-wm1-f71.google.com with SMTP id 5-20020a1c00050000b02902e67111d9f0so3378676wma.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 09:45:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Bsa8JOGGCKGqD18D4sehfiJwGit16PjwUVoBvcbwuaE=;
        b=4e2wK/DQ1sobQgTq9/e/lLKKiBZ5pIqn0dIoK6lAue4a1YxDP8qrbRj5ovgFVo/Ool
         66KJGul7gPQUb0jg31uFAI4mh+i4NQvns5wR4dSvUiqIpvdtApwcqytzFo2hEBNBCcuA
         pqtJLX/8phIx+4e8t1tEr7CT3Km+fC5uiuht6d6h74whU74vF+rJPDg9Tr0+GP1rcZVZ
         ZjhVt2H6bYXJdwSmVVL7Su6W18esg0JzykoUvl/dOe5iAsret5xfY84V8WyOqTTkKn3X
         9wQuehA7hDK9infi2cpOBcnQGBU5rnY2OwGJDZn0wmrH0hU7ExuvEMGsyGur1x1us8QO
         0s3A==
X-Gm-Message-State: AOAM532c8iruULUH3dTelVwqQZ8pjbIB+rgyMnMMCU7//0oaSBruCcVN
        j6h/lCrfT2Oe7+WYGadev79x7gsSxuK42mVqmy6PEcrq1NcBM069VvgVKCgJuyK69l0vE0V+lTW
        KiQOZFcOZye8xwW45J6NQFpHqVVHFTYa5ptBNzn31NA==
X-Received: by 2002:a7b:cd90:: with SMTP id y16mr10706132wmj.84.1631810718440;
        Thu, 16 Sep 2021 09:45:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz2JuDX3DqgsifbIvvV1lhfVqk1firlNmZ4F0o08GsrlrdHsnMaJzFPqkY3TSk0PC9I7m7bQg==
X-Received: by 2002:a7b:cd90:: with SMTP id y16mr10706126wmj.84.1631810718312;
        Thu, 16 Sep 2021 09:45:18 -0700 (PDT)
Received: from kozik-lap.lan (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id j27sm3388187wms.6.2021.09.16.09.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 09:45:17 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH 1/2] rtc: omap: drop unneeded MODULE_ALIAS
Date:   Thu, 16 Sep 2021 18:45:12 +0200
Message-Id: <20210916164513.134725-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MODULE_DEVICE_TABLE already creates proper alias for platform
driver.  Having another MODULE_ALIAS causes the alias to be duplicated.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/rtc/rtc-omap.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
index d46e0f0cc502..4d4f3b1a7309 100644
--- a/drivers/rtc/rtc-omap.c
+++ b/drivers/rtc/rtc-omap.c
@@ -1029,6 +1029,5 @@ static struct platform_driver omap_rtc_driver = {
 
 module_platform_driver(omap_rtc_driver);
 
-MODULE_ALIAS("platform:omap_rtc");
 MODULE_AUTHOR("George G. Davis (and others)");
 MODULE_LICENSE("GPL");
-- 
2.30.2

