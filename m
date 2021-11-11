Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46A6A44DC78
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 21:25:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233684AbhKKU2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 15:28:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233666AbhKKU17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 15:27:59 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3815C061203
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 12:25:09 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id y196so6033761wmc.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 12:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2q89+eCO5OTJBjwQcEdcm4YwakpritICTXy5rLsjKJE=;
        b=2oXYDeSr587m7GQrYT+XAjjuuTChhTvQ9PkoHiuoQCtg2VuX78ne04J8560Z3jbD+M
         udAuur671Glx3gcYiOL2bibHzk8F8dkSmFxDBJIv+85u+5M6//9UhdmjRxiCbEZasRW9
         QMXT/EmAKlgwHmS2rs+ewSWbxPcYZ9/D34kgx5wav1N+nkImRzZiB3ZD3xd4AmcVrW+v
         j4v8l1azCbiw/BdofTXfS/YumkJ8qvIqhgEklPZhnXiHuJsssvh5coTcxlXu9Weqx7DT
         Jmrw17cFVqG90p3F07h3RmUvfMUE2mYYYeHxzfqzf6faDmYf+Jk7jrMv8MaGFnTMTNBH
         1jgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2q89+eCO5OTJBjwQcEdcm4YwakpritICTXy5rLsjKJE=;
        b=nDVqK9f8nQqUNLBNNWRJLIxfXRXctSkG7Zpr/swbShYeaKuTYL+b7Xbs4SayMXI+Mt
         gleUfy6Cl0DB9l5WuzDuremgzS4E7YKjoAL9l75eDp+ra0cvYEchV+2Pj/O29bmZGxbA
         dKW9/FlWjDr7LDbX6ISVlUOwke2blUyOPpiGRKZmFShYZKO2vLxS2v24GmQqCm3iQ53Y
         tjR2/NlJ88jiHPERp8c2EL5nhu8XxIvbXygM0k/maUyHhPDEmA1kBunyReLbd3fMQspQ
         3wP9ot2/7+ToTIyZ6NAf4FPQlNBJAck1pjkCoTQSHQ2uGAY/BGy7aOSTl9mdZJ1Vxy3p
         4YhQ==
X-Gm-Message-State: AOAM530arYiMFqZ/B0DrRbpY/oITWRpRiCNrYAolzJYt6yog3jlD6MrR
        kn1KjvSJ9+3UCGAY/9Q5TB4ge/LdAu28udqN
X-Google-Smtp-Source: ABdhPJzJoTfVwDKyV4maNq6sdZjvFVbZzxugbHzTzHcLtFZO5Ri+wb6Y0XwVI95W3zDhdY0z4Z2Vng==
X-Received: by 2002:a7b:c14f:: with SMTP id z15mr11091547wmi.56.1636662308581;
        Thu, 11 Nov 2021 12:25:08 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:334:ac00:7d50:ff5:f5c1:e225])
        by smtp.gmail.com with ESMTPSA id t11sm3819907wrz.97.2021.11.11.12.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Nov 2021 12:25:08 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 1/2] gpiolib: improve coding style for local variables
Date:   Thu, 11 Nov 2021 21:25:05 +0100
Message-Id: <20211111202506.19459-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop unneeded whitespaces and put the variables of the same type
together for consistency with the rest of the code.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
---
 drivers/gpio/gpiolib.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index d1b9b721218f..4c34c96ef136 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -594,11 +594,10 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 			       struct lock_class_key *request_key)
 {
 	struct fwnode_handle *fwnode = gc->parent ? dev_fwnode(gc->parent) : NULL;
-	unsigned long	flags;
-	int		ret = 0;
-	unsigned	i;
-	int		base = gc->base;
+	int ret = 0, base = gc->base;
 	struct gpio_device *gdev;
+	unsigned long flags;
+	unsigned int i;
 
 	/*
 	 * First: allocate and populate the internal stat container, and
-- 
2.30.1

