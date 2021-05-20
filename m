Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F284838B697
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 21:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237892AbhETTDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 15:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236850AbhETTCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 15:02:44 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06471C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 12:01:22 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id v12so18713729wrq.6
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 12:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SBAKKQalOJHvEKpRKihiee3lgyfHDvw81EwoK2O6KMU=;
        b=TOvjUnExrJkfS1a45A6elsHA3Nl0rygE9dkkcvcFh7uIdhijihhEW8zz9F8JQcWqPR
         kvAVumtrWHiDB8TqE6unzMoO12ejgb5og9J8YLybBHJUDy7sgnIqJZsImgJEdH6I48kT
         +WLUmf3bQC8ISrYcCGnO25lOmgOJ60bVSo5aJu8sYffcdHdFmBWxtXJEJ/JCU8d1DzIn
         et09Sl6fYThOAIVhfqyZBsDepD2VA+Nxy9HMXXamTsLFUElmIWlTUeGR8jdX5M1AUC8y
         /h/c74ZlUYgJQRJl3cEgJr7yikN8q8eMcnajBiKVQvUpvC2lPlxt7tNsxJpNaRDpzCBD
         xh6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SBAKKQalOJHvEKpRKihiee3lgyfHDvw81EwoK2O6KMU=;
        b=Lg5FpIHPdcYRxOhFqzcZ2Fp6vty2EiS7LcDokzo/5xL93IkkiNiQON/CrJymx4mC+0
         5AOHGsXohGqYvzW9xGWkAvWA6gCQoixsna12jQxNHoITJlTQgIXZQlJRLAmZEvpy6tsb
         UzvNy/0tMrUJxkODqJm4Q6a9yk4NSTyJ94M9oeyhy4kKOLsWS9Ous+tPeWiNJCaJCSfc
         JZPB/fafERNiFiuWaevGw9P9XrWrzToTZJAdQ0yQhMkHrGB6olgmkvwW5Hsi3v9Q1mn3
         DJITELKo4zDLVG3YHarK/nuKDtt1IDTfO63MTtiY2ThK3sS1zlvbDRQsSOGbX/OqIQvc
         k7Cw==
X-Gm-Message-State: AOAM531tBf5sut5wwhjCAsiyQxG0C4I3wOTrHF/HYQcHBjqll26P/Mvf
        jcnqV5UptKA4KbdGuTybNJKlNg==
X-Google-Smtp-Source: ABdhPJz+/a10pqf8oJ6E1JvsxS0ZPNJkmppgFWPCA+O5Gqw1gs8ZbTONZBJ3SYcvJc2naOp2wIYlFQ==
X-Received: by 2002:a5d:4046:: with SMTP id w6mr5792880wrp.15.1621537280605;
        Thu, 20 May 2021 12:01:20 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id p20sm9011899wmq.10.2021.05.20.12.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 12:01:20 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Korsgaard <peter@korsgaard.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Andreas Larsson <andreas@gaisler.com>,
        linux-i2c@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH 10/16] i2c: busses: i2c-ocores: Place the expected function names into the documentation headers
Date:   Thu, 20 May 2021 20:00:59 +0100
Message-Id: <20210520190105.3772683-11-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210520190105.3772683-1-lee.jones@linaro.org>
References: <20210520190105.3772683-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/i2c/busses/i2c-ocores.c:253: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 drivers/i2c/busses/i2c-ocores.c:267: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 drivers/i2c/busses/i2c-ocores.c:299: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 drivers/i2c/busses/i2c-ocores.c:347: warning: expecting prototype for It handles an IRQ(). Prototype was for ocores_process_polling() instead

Cc: Peter Korsgaard <peter@korsgaard.com>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Andreas Larsson <andreas@gaisler.com>
Cc: linux-i2c@vger.kernel.org
Cc: linux-riscv@lists.infradead.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/i2c/busses/i2c-ocores.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-ocores.c
index 273222e38056e..a0af027db04c1 100644
--- a/drivers/i2c/busses/i2c-ocores.c
+++ b/drivers/i2c/busses/i2c-ocores.c
@@ -250,7 +250,7 @@ static irqreturn_t ocores_isr(int irq, void *dev_id)
 }
 
 /**
- * Process timeout event
+ * ocores_process_timeout() - Process timeout event
  * @i2c: ocores I2C device instance
  */
 static void ocores_process_timeout(struct ocores_i2c *i2c)
@@ -264,7 +264,7 @@ static void ocores_process_timeout(struct ocores_i2c *i2c)
 }
 
 /**
- * Wait until something change in a given register
+ * ocores_wait() - Wait until something change in a given register
  * @i2c: ocores I2C device instance
  * @reg: register to query
  * @mask: bitmask to apply on register value
@@ -296,7 +296,7 @@ static int ocores_wait(struct ocores_i2c *i2c,
 }
 
 /**
- * Wait until is possible to process some data
+ * ocores_poll_wait() - Wait until is possible to process some data
  * @i2c: ocores I2C device instance
  *
  * Used when the device is in polling mode (interrupts disabled).
@@ -334,7 +334,7 @@ static int ocores_poll_wait(struct ocores_i2c *i2c)
 }
 
 /**
- * It handles an IRQ-less transfer
+ * ocores_process_polling() - It handles an IRQ-less transfer
  * @i2c: ocores I2C device instance
  *
  * Even if IRQ are disabled, the I2C OpenCore IP behavior is exactly the same
-- 
2.31.1

