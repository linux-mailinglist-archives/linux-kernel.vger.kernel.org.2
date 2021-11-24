Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0554045C703
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 15:14:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348070AbhKXOR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 09:17:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352939AbhKXORU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 09:17:20 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4DACC0818F1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 04:28:56 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id d24so3986636wra.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 04:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=itVP4aNbik/dROJTIOMt1U3nLqJ1tEkeMNd95tsUZfI=;
        b=MDUIPdijTyP4/fpQuv6ZuVlM7tyrXL9fEM9D1engdJP3v/7I6HXcc4tq3W05xa282v
         7MfuuDChpc2dk2IRy9XzTmqZZUZluuJu0ybfxkEN0VPtlboCLZ9Pe/NYIlieWYqYRXa2
         zQlZcgiu9HQw8pQYEwWLpqvKAljYvRUkNuZNWA3QxluesS3L5jcmU1RSGMf8gLUfR4RP
         XEKjcO0Sxi5XsOHlZPKE8l696doVzC4K0qFZ+SmW4GA6XCt5uzXH+FG8C7NiCcQimAnO
         dFQhZwxQ1vdoxp28sQxtbV0ROhqtvzmJTxUQWik3oKpeLmH9xCtN4OOOwQfnrX6Hluqj
         loPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=itVP4aNbik/dROJTIOMt1U3nLqJ1tEkeMNd95tsUZfI=;
        b=JADDlGEyqYLSSO360YfvfeUnb7LKMs9gikRq/JcQ/UnTwiCnjRcDe+0uRGmpo6y3QR
         EARr+G+XrKbJY3nkavUfUYtKVe0QD57LjMeg+Ps/IPd7K2ckFtNOnbkrGFaYvn7SDBHG
         8tT1y2Bcfz1t2+Jzhkeh07aLLus2UWw2ngUkT1NVV4JjlgYrwFHBkJ+M4q1lnjLEYFF+
         fBF0q/6T4qJQhfMsPaehl6VCgrtdruwlBrTz1Qbuc5utkyT2EWhGbKTs4avHo5Q1s7O6
         lJ8XSFtpDCZqQetIM5e5mHVjXm+LxdNigafzCZFEiojZtXTL6spapQHMVoNiHkQeiRfX
         CCmA==
X-Gm-Message-State: AOAM533eA3fOVOM0rV8UdUGF72hgzoJN5xvWdMfPGlXzqtzFaIOBWA0n
        Hk5yHnqisp8c42BWZ5egAbA65g==
X-Google-Smtp-Source: ABdhPJxI1/vhZ1KM2jJH6ksA70uIiYHjkzcyEe/prqKG2CyKBGHpDy10UuCc8LzOuo7Pl0GG8bMXbQ==
X-Received: by 2002:a5d:45c4:: with SMTP id b4mr18470805wrs.222.1637756935206;
        Wed, 24 Nov 2021 04:28:55 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:334:ac00:7d50:ff5:f5c1:e225])
        by smtp.gmail.com with ESMTPSA id p62sm4417694wmp.10.2021.11.24.04.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 04:28:54 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Johan Hovold <johan@kernel.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v3 1/2] gpiolib: improve coding style for local variables
Date:   Wed, 24 Nov 2021 13:28:49 +0100
Message-Id: <20211124122850.7095-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop unneeded whitespaces and put the variables of the same type
together for consistency with the rest of the code.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
v1 -> v2:
- keep initializations on separate lines

 drivers/gpio/gpiolib.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index abfbf546d159..ede8b8a7aa18 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -594,11 +594,11 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 			       struct lock_class_key *request_key)
 {
 	struct fwnode_handle *fwnode = gc->parent ? dev_fwnode(gc->parent) : NULL;
-	unsigned long	flags;
-	int		ret = 0;
-	unsigned	i;
-	int		base = gc->base;
 	struct gpio_device *gdev;
+	unsigned long flags;
+	int base = gc->base;
+	unsigned int i;
+	int ret = 0;
 
 	/*
 	 * First: allocate and populate the internal stat container, and
-- 
2.25.1

