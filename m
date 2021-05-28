Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79CB9394492
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 16:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236610AbhE1O4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 10:56:12 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:47087 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236306AbhE1O4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 10:56:01 -0400
Received: from mail-vs1-f70.google.com ([209.85.217.70])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lmdsX-00041G-UA
        for linux-kernel@vger.kernel.org; Fri, 28 May 2021 14:54:25 +0000
Received: by mail-vs1-f70.google.com with SMTP id n26-20020a67d61a0000b029023651d629a4so1087580vsj.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 07:54:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JmosCUrJkhqoGDagpIXrPPS//+f2tiAx4PxvTD+0vzc=;
        b=Jh2Hx3fwhuaAbv/2xRkzixesfKU7zXiHSn+9HpTY4HllaNpWR2+eUsB8NHNUvuWPrd
         on19Eb8qqjmNLD83SzYlLZm5ZD+f4X+vJLq5TaqzTa5m4noGynvJ4ZklW55oXwnmN2cN
         340jCafm09T9NRY38HodZr+ibB4cb2EPhr5RhDBjP0YJAheFokHzdGq4sBzUBw9L11iK
         CXEXSg51D/XPmqC5rt1d2WXTFojdx1oXoy8XNsswKGds+BmTfWaIewUJbJ27y/9tW9Lm
         Ye9iwlAm4TNB2XMRDeJ+REJLlFy3IjtCd0MjBfH9vy+v5SmnygVebMypQgQAGyQmUSEZ
         WjUA==
X-Gm-Message-State: AOAM53379TBe9XjfsG0M0fmtUcNDPY3dmKods9bzEW+gcwO0J/d/R1F4
        QjMpX7M8vgtbFdWeNvRbXu5T19bHSVG9x9kIAnU3xd/l2W/Yexr1jPpnMkY0mCa8iSSigyY9pfn
        8HwUwSQhRE+MHyFuXhSud32Y/oDCP4ic4kUxRUk45DA==
X-Received: by 2002:a9f:2c93:: with SMTP id w19mr3511500uaj.38.1622213664152;
        Fri, 28 May 2021 07:54:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyfCnczmKS2FJDI3h0cf4SKsP2OPOxaz3U8EXths1SvSa1Kbt0IX3VmJUwfbUqduPSAvOf9jA==
X-Received: by 2002:a9f:2c93:: with SMTP id w19mr3511475uaj.38.1622213663868;
        Fri, 28 May 2021 07:54:23 -0700 (PDT)
Received: from localhost.localdomain ([45.237.48.3])
        by smtp.gmail.com with ESMTPSA id v132sm737783vkd.1.2021.05.28.07.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 07:54:23 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        "David S. Miller" <davem@davemloft.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jakub Kicinski <kuba@kernel.org>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 03/11] nfc: mrvl: use SPDX-License-Identifier
Date:   Fri, 28 May 2021 10:53:22 -0400
Message-Id: <20210528145330.125055-3-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210528145330.125055-1-krzysztof.kozlowski@canonical.com>
References: <20210528145330.125055-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use SPDX-License-Identifier: GPL-2.0-only, instead of hand writing it.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/nfc/nfcmrvl/fw_dnld.c | 13 +------------
 drivers/nfc/nfcmrvl/fw_dnld.h | 15 ++-------------
 drivers/nfc/nfcmrvl/i2c.c     | 15 ++-------------
 drivers/nfc/nfcmrvl/main.c    | 13 +------------
 drivers/nfc/nfcmrvl/nfcmrvl.h | 15 ++-------------
 drivers/nfc/nfcmrvl/spi.c     | 15 ++-------------
 drivers/nfc/nfcmrvl/uart.c    | 13 +------------
 drivers/nfc/nfcmrvl/usb.c     | 15 ++-------------
 8 files changed, 13 insertions(+), 101 deletions(-)

diff --git a/drivers/nfc/nfcmrvl/fw_dnld.c b/drivers/nfc/nfcmrvl/fw_dnld.c
index 52c8ae504e32..05df7ad224d5 100644
--- a/drivers/nfc/nfcmrvl/fw_dnld.c
+++ b/drivers/nfc/nfcmrvl/fw_dnld.c
@@ -1,19 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Marvell NFC driver: Firmware downloader
  *
  * Copyright (C) 2015, Marvell International Ltd.
- *
- * This software file (the "File") is distributed by Marvell International
- * Ltd. under the terms of the GNU General Public License Version 2, June 1991
- * (the "License").  You may use, redistribute and/or modify this File in
- * accordance with the terms and conditions of the License, a copy of which
- * is available on the worldwide web at
- * http://www.gnu.org/licenses/old-licenses/gpl-2.0.txt.
- *
- * THE FILE IS DISTRIBUTED AS-IS, WITHOUT WARRANTY OF ANY KIND, AND THE
- * IMPLIED WARRANTIES OF MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE
- * ARE EXPRESSLY DISCLAIMED.  The License provides additional details about
- * this warranty disclaimer.
  */
 
 #include <linux/module.h>
diff --git a/drivers/nfc/nfcmrvl/fw_dnld.h b/drivers/nfc/nfcmrvl/fw_dnld.h
index 058ce77b3cbc..7c4d91b01910 100644
--- a/drivers/nfc/nfcmrvl/fw_dnld.h
+++ b/drivers/nfc/nfcmrvl/fw_dnld.h
@@ -1,20 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * Marvell NFC driver: Firmware downloader
  *
  * Copyright (C) 2015, Marvell International Ltd.
- *
- * This software file (the "File") is distributed by Marvell International
- * Ltd. under the terms of the GNU General Public License Version 2, June 1991
- * (the "License").  You may use, redistribute and/or modify this File in
- * accordance with the terms and conditions of the License, a copy of which
- * is available on the worldwide web at
- * http://www.gnu.org/licenses/old-licenses/gpl-2.0.txt.
- *
- * THE FILE IS DISTRIBUTED AS-IS, WITHOUT WARRANTY OF ANY KIND, AND THE
- * IMPLIED WARRANTIES OF MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE
- * ARE EXPRESSLY DISCLAIMED.  The License provides additional details about
- * this warranty disclaimer.
- **/
+ */
 
 #ifndef __NFCMRVL_FW_DNLD_H__
 #define __NFCMRVL_FW_DNLD_H__
diff --git a/drivers/nfc/nfcmrvl/i2c.c b/drivers/nfc/nfcmrvl/i2c.c
index 3c9bbee98237..59a529e72d96 100644
--- a/drivers/nfc/nfcmrvl/i2c.c
+++ b/drivers/nfc/nfcmrvl/i2c.c
@@ -1,20 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Marvell NFC-over-I2C driver: I2C interface related functions
  *
  * Copyright (C) 2015, Marvell International Ltd.
- *
- * This software file (the "File") is distributed by Marvell International
- * Ltd. under the terms of the GNU General Public License Version 2, June 1991
- * (the "License").  You may use, redistribute and/or modify this File in
- * accordance with the terms and conditions of the License, a copy of which
- * is available on the worldwide web at
- * http://www.gnu.org/licenses/old-licenses/gpl-2.0.txt.
- *
- * THE FILE IS DISTRIBUTED AS-IS, WITHOUT WARRANTY OF ANY KIND, AND THE
- * IMPLIED WARRANTIES OF MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE
- * ARE EXPRESSLY DISCLAIMED.  The License provides additional details about
- * this warranty disclaimer.
- **/
+ */
 
 #include <linux/module.h>
 #include <linux/interrupt.h>
diff --git a/drivers/nfc/nfcmrvl/main.c b/drivers/nfc/nfcmrvl/main.c
index 529be35ac178..a4620b480c4f 100644
--- a/drivers/nfc/nfcmrvl/main.c
+++ b/drivers/nfc/nfcmrvl/main.c
@@ -1,19 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Marvell NFC driver: major functions
  *
  * Copyright (C) 2014-2015 Marvell International Ltd.
- *
- * This software file (the "File") is distributed by Marvell International
- * Ltd. under the terms of the GNU General Public License Version 2, June 1991
- * (the "License").  You may use, redistribute and/or modify this File in
- * accordance with the terms and conditions of the License, a copy of which
- * is available on the worldwide web at
- * http://www.gnu.org/licenses/old-licenses/gpl-2.0.txt.
- *
- * THE FILE IS DISTRIBUTED AS-IS, WITHOUT WARRANTY OF ANY KIND, AND THE
- * IMPLIED WARRANTIES OF MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE
- * ARE EXPRESSLY DISCLAIMED.  The License provides additional details about
- * this warranty disclaimer.
  */
 
 #include <linux/module.h>
diff --git a/drivers/nfc/nfcmrvl/nfcmrvl.h b/drivers/nfc/nfcmrvl/nfcmrvl.h
index e84ee18c73ae..0b4220bb91bc 100644
--- a/drivers/nfc/nfcmrvl/nfcmrvl.h
+++ b/drivers/nfc/nfcmrvl/nfcmrvl.h
@@ -1,20 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * Marvell NFC driver
  *
  * Copyright (C) 2014-2015, Marvell International Ltd.
- *
- * This software file (the "File") is distributed by Marvell International
- * Ltd. under the terms of the GNU General Public License Version 2, June 1991
- * (the "License").  You may use, redistribute and/or modify this File in
- * accordance with the terms and conditions of the License, a copy of which
- * is available on the worldwide web at
- * http://www.gnu.org/licenses/old-licenses/gpl-2.0.txt.
- *
- * THE FILE IS DISTRIBUTED AS-IS, WITHOUT WARRANTY OF ANY KIND, AND THE
- * IMPLIED WARRANTIES OF MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE
- * ARE EXPRESSLY DISCLAIMED.  The License provides additional details about
- * this warranty disclaimer.
- **/
+ */
 
 #ifndef _NFCMRVL_H_
 #define _NFCMRVL_H_
diff --git a/drivers/nfc/nfcmrvl/spi.c b/drivers/nfc/nfcmrvl/spi.c
index 0647b85930a6..66696321c645 100644
--- a/drivers/nfc/nfcmrvl/spi.c
+++ b/drivers/nfc/nfcmrvl/spi.c
@@ -1,20 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Marvell NFC-over-SPI driver: SPI interface related functions
  *
  * Copyright (C) 2015, Marvell International Ltd.
- *
- * This software file (the "File") is distributed by Marvell International
- * Ltd. under the terms of the GNU General Public License Version 2, June 1991
- * (the "License").  You may use, redistribute and/or modify this File in
- * accordance with the terms and conditions of the License, a copy of which
- * is available on the worldwide web at
- * http://www.gnu.org/licenses/old-licenses/gpl-2.0.txt.
- *
- * THE FILE IS DISTRIBUTED AS-IS, WITHOUT WARRANTY OF ANY KIND, AND THE
- * IMPLIED WARRANTIES OF MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE
- * ARE EXPRESSLY DISCLAIMED.  The License provides additional details about
- * this warranty disclaimer.
- **/
+ */
 
 #include <linux/module.h>
 #include <linux/interrupt.h>
diff --git a/drivers/nfc/nfcmrvl/uart.c b/drivers/nfc/nfcmrvl/uart.c
index 7194dd7ef0f1..d7ba5b5c653c 100644
--- a/drivers/nfc/nfcmrvl/uart.c
+++ b/drivers/nfc/nfcmrvl/uart.c
@@ -1,19 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Marvell NFC-over-UART driver
  *
  * Copyright (C) 2015, Marvell International Ltd.
- *
- * This software file (the "File") is distributed by Marvell International
- * Ltd. under the terms of the GNU General Public License Version 2, June 1991
- * (the "License").  You may use, redistribute and/or modify this File in
- * accordance with the terms and conditions of the License, a copy of which
- * is available on the worldwide web at
- * http://www.gnu.org/licenses/old-licenses/gpl-2.0.txt.
- *
- * THE FILE IS DISTRIBUTED AS-IS, WITHOUT WARRANTY OF ANY KIND, AND THE
- * IMPLIED WARRANTIES OF MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE
- * ARE EXPRESSLY DISCLAIMED.  The License provides additional details about
- * this warranty disclaimer.
  */
 
 #include <linux/module.h>
diff --git a/drivers/nfc/nfcmrvl/usb.c b/drivers/nfc/nfcmrvl/usb.c
index bcd563cb556c..50f06dd1ba25 100644
--- a/drivers/nfc/nfcmrvl/usb.c
+++ b/drivers/nfc/nfcmrvl/usb.c
@@ -1,20 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Marvell NFC-over-USB driver: USB interface related functions
  *
  * Copyright (C) 2014, Marvell International Ltd.
- *
- * This software file (the "File") is distributed by Marvell International
- * Ltd. under the terms of the GNU General Public License Version 2, June 1991
- * (the "License").  You may use, redistribute and/or modify this File in
- * accordance with the terms and conditions of the License, a copy of which
- * is available on the worldwide web at
- * http://www.gnu.org/licenses/old-licenses/gpl-2.0.txt.
- *
- * THE FILE IS DISTRIBUTED AS-IS, WITHOUT WARRANTY OF ANY KIND, AND THE
- * IMPLIED WARRANTIES OF MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE
- * ARE EXPRESSLY DISCLAIMED.  The License provides additional details about
- * this warranty disclaimer.
- **/
+ */
 
 #include <linux/module.h>
 #include <linux/usb.h>
-- 
2.27.0

