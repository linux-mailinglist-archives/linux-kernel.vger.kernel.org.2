Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE5533403A2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 11:41:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbhCRKlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 06:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbhCRKkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 06:40:46 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E57C061762
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 03:40:46 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id e18so4958519wrt.6
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 03:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1tEtqfwOT8tRZ9fytdoNTk6qtPKeMjP57sn7aBTbcvY=;
        b=TBI1ujphYCROOuN2IGHeqLZfcbf6KaQWLfajxnq9SCUdvYO9iPY2o0LiqFSfmSQ9Ql
         6bMjy/Sm9mueCSJr2bWsg75dXG9XIMnxgYBiEQUFbpSG3y8DGI8NudQvBtdfjQhuDvng
         BVvbYOFNGWUoanC/VkrYNk2IDFJHjyhJkryajzdxM+z2v2gOpgmuwgvIweZ6+2zeA6fa
         NLdFNBi75WhvLVWRwYlS7aI22rJCpvjmuJ65mqjVEL0r+MchSpxieyNM8NFGWURuXzXE
         G1i1tiMaKvrLAS8ns84rr8v74hdGh9iWc1m3tQXHEkaKi5DbguxiqvdiFocllQnvtqs9
         Yjpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1tEtqfwOT8tRZ9fytdoNTk6qtPKeMjP57sn7aBTbcvY=;
        b=YC2iO7uGcVUQ2/NngUU4nyROtNxpuBHyZj5IBgXDmyR+lESJ7QI2ww/GM+4C1wDraV
         AAugCYeCMcTww3+6CeFNh0K7NnC0yy8VO9MZC4RxvF3xqKIGgDbezKI/qWViJyeVoQQs
         eoBs4rCUmwLZwLLj6RZOqoFOXTtjfotUhma2G7U1BUVQARHa9Uau9nMjSQmfCjPEMsD8
         D/VoZG2ori8cwO90yVjX2uhjfNZkB6ey5ZN0QfGTCggC4hIrUkip/rq7bLYYQ/GRBlOl
         797CHBHQyUayUtS0KQ4daA1sEIdPV5X4RdUgYo97/c/Nhy1qPkGxO5B5UqCMqIw/RY0E
         3wwg==
X-Gm-Message-State: AOAM531qImVVcRZI2oOT7u12JiGlNWBmir4SxPuCancVDlcgd5tbnYP/
        XSZ99uxaYW6GTqFthhjidQoX9A==
X-Google-Smtp-Source: ABdhPJydJChfSJV1NmxCjDp6DMd0HgDgPwmtfA49Tck2MQgoEEEkqrOYyzMyq6clS6JgzRfYWwJiDQ==
X-Received: by 2002:adf:fcc9:: with SMTP id f9mr8989118wrs.420.1616064045253;
        Thu, 18 Mar 2021 03:40:45 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id z1sm2426033wru.95.2021.03.18.03.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 03:40:44 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org
Subject: [PATCH 01/10] of: device: Fix function name in header and provide missing descriptions
Date:   Thu, 18 Mar 2021 10:40:27 +0000
Message-Id: <20210318104036.3175910-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210318104036.3175910-1-lee.jones@linaro.org>
References: <20210318104036.3175910-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/of/device.c:72: warning: expecting prototype for of_dma_configure(). Prototype was for of_dma_configure_id() instead
 drivers/of/device.c:263: warning: Function parameter or member 'dev' not described in 'of_device_modalias'
 drivers/of/device.c:263: warning: Function parameter or member 'str' not described in 'of_device_modalias'
 drivers/of/device.c:263: warning: Function parameter or member 'len' not described in 'of_device_modalias'
 drivers/of/device.c:280: warning: Function parameter or member 'dev' not described in 'of_device_uevent'
 drivers/of/device.c:280: warning: Function parameter or member 'env' not described in 'of_device_uevent'

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: devicetree@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/of/device.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/of/device.c b/drivers/of/device.c
index 6cb86de404f1c..c5a9473a5fb1a 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -53,7 +53,7 @@ int of_device_add(struct platform_device *ofdev)
 }
 
 /**
- * of_dma_configure - Setup DMA configuration
+ * of_dma_configure_id - Setup DMA configuration
  * @dev:	Device to apply DMA configuration
  * @np:		Pointer to OF node having DMA configuration
  * @force_dma:  Whether device is to be set up by of_dma_configure() even if
@@ -258,6 +258,9 @@ EXPORT_SYMBOL_GPL(of_device_request_module);
 
 /**
  * of_device_modalias - Fill buffer with newline terminated modalias string
+ * @dev:	Calling device
+ * @str:	Modalias string
+ * @len:	Size of @str
  */
 ssize_t of_device_modalias(struct device *dev, char *str, ssize_t len)
 {
@@ -275,6 +278,8 @@ EXPORT_SYMBOL_GPL(of_device_modalias);
 
 /**
  * of_device_uevent - Display OF related uevent information
+ * @dev:	Device to apply DMA configuration
+ * @env:	Kernel object's userspace event reference
  */
 void of_device_uevent(struct device *dev, struct kobj_uevent_env *env)
 {
-- 
2.27.0

