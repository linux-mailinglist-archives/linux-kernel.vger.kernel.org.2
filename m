Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4077133D4D2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 14:26:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234981AbhCPNZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 09:25:59 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:47000 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233965AbhCPNZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 09:25:25 -0400
Received: from mail-ed1-f71.google.com ([209.85.208.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lM9hJ-0001GH-Kn
        for linux-kernel@vger.kernel.org; Tue, 16 Mar 2021 13:25:21 +0000
Received: by mail-ed1-f71.google.com with SMTP id q12so2209958edv.9
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 06:25:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=83ZIZm2jxLoXrgqf2w4Pq9GXA0XBAVNJX5oJ88+rGxI=;
        b=oF+aAbIhxksUIKZwfWmUvAWXjUoTyB5qB4tBEdYaUjZ9fj947Pgcqx+oBvfGpe4yb7
         yj62d3AYWUkV56vfVz0ePQTylx37JL0DsXdhbhluOBTmSCgS3T5BY0jZ9yzGGNezfFKT
         GefyOg31zIjnss2S8LIDjsuw0tbQzy8XpavND986LwaCLf73UPSMK2jiHxoav+wFxGd2
         +xRTrbWZ8al9WXmbeiti5z7OWJEnGS8HweyXgtEbfYnawZPML67AjLfl0yv59abrSDbX
         nw55mmd7ivGCltjjmbD7T0Rd54af8AL9gFe3e7e+TE0Ffrh2gKgNO6LcUNu160JAHLXO
         9dOg==
X-Gm-Message-State: AOAM533ZjFAbB1ZJpv/hvq07lZakvYYJtDZH7jtpcfb3JzoDkPy8PJUM
        uvbykmr1mOpawVyrY08SpFo3R37FzSfo7xXKEnxLCNqJwIGkfTRI46+yCRMhxeR7rNBkH1IeQHL
        E1tBT1YTeEwBxaiglfsarfZbjMIkibEM50vF9ZjIQVQ==
X-Received: by 2002:a17:906:4705:: with SMTP id y5mr29994536ejq.119.1615901121366;
        Tue, 16 Mar 2021 06:25:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwUVysx7ycFc90Jo/jv+3/QyA7CJAJ1yVRgIm54vcSiVdhofTbTH8E+xznhLUPZrQ6xZzFWwQ==
X-Received: by 2002:a17:906:4705:: with SMTP id y5mr29994516ejq.119.1615901121183;
        Tue, 16 Mar 2021 06:25:21 -0700 (PDT)
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.gmail.com with ESMTPSA id sb4sm9450217ejb.71.2021.03.16.06.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 06:25:20 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [RESEND PATCH] mfd: sec: initialize driver via module_platform_driver
Date:   Tue, 16 Mar 2021 14:25:15 +0100
Message-Id: <20210316132515.50588-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Krzysztof Kozlowski <krzk@kernel.org>

The driver was using subsys_initcall() because in old times deferred
probe was not supported everywhere and specific ordering was needed.
Since probe deferral works fine and specific ordering is discouraged
(hides dependencies between drivers and couples their boot order), the
driver can be converted to regular module_platform_driver.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/mfd/sec-core.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/mfd/sec-core.c b/drivers/mfd/sec-core.c
index 95473ff9bb4b..8d55992da19e 100644
--- a/drivers/mfd/sec-core.c
+++ b/drivers/mfd/sec-core.c
@@ -549,19 +549,7 @@ static struct i2c_driver sec_pmic_driver = {
 	.shutdown = sec_pmic_shutdown,
 	.id_table = sec_pmic_id,
 };
-
-static int __init sec_pmic_init(void)
-{
-	return i2c_add_driver(&sec_pmic_driver);
-}
-
-subsys_initcall(sec_pmic_init);
-
-static void __exit sec_pmic_exit(void)
-{
-	i2c_del_driver(&sec_pmic_driver);
-}
-module_exit(sec_pmic_exit);
+module_i2c_driver(sec_pmic_driver);
 
 MODULE_AUTHOR("Sangbeom Kim <sbkim73@samsung.com>");
 MODULE_DESCRIPTION("Core support for the S5M MFD");
-- 
2.25.1

