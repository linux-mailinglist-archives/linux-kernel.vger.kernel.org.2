Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDE513405EA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 13:45:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbhCRMpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 08:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231324AbhCRMof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 08:44:35 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D1AC06175F
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 05:44:35 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id e9so5384159wrw.10
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 05:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GVJx+OIpfKowVFAHFOdCV34ApK3YA2W1l4+0ZHpyDsw=;
        b=oGDY3f1hsLm/RRceUXYCZGe+2E0KHDebnMjvny/6+Yagr9ieN2j8lO5C8vjZzHMz7X
         7nAV7LLYH10IRNIgLxGfNmp1Kum+lgpQl0PqzF9yp4/xMpugGIWehf7PI4LYJVhoBqDQ
         g41+/wiUN0dAaum5iOgMg9aC1UkR22yz/jdB+/Wiqg3Gt9JHNlis7eWQ6n8MqBb35Qa4
         tFxVgMEfeqNv0DFLQPKpzeDRmvCYxGhihqRESBl4DVX2Q4qx/cxD1bBLHXEiM4LXg3lk
         NFG/aeBC3XVox9ORyb5x08AYb95qHo/w86EUWgrj/7DIaMzVy4aUBZoM6OAy72ml1KTh
         DLtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GVJx+OIpfKowVFAHFOdCV34ApK3YA2W1l4+0ZHpyDsw=;
        b=FqkdY55/JG1yT56P1sCMFJ0bny1evs873Um5miy4pz6njTGwjyMnfUaA418r3Uo7JM
         aJz6qbyN6GtFPK3YguKH42c4oTpCkFuocJ9dcfjqh+YvPFW4mdqEGDmIARqGg01RuQM5
         6FCXM2HDrxZ+Sww766p2sqUEpIecFTTtgiIWzLGAXufkdZ2CxqG2VCUgrALZs9MRYZ8H
         7BXU3vmqk2e8+DG/+ufJyk8hxrXAeihUFKAQhewwlumfQdt8NKVwQuZ5zrkD+fMCsEh4
         tH3yvCZ+wbI9s+dNfEn/HsHvykbvqaaal8pI0IiteG6JvKKg0bV7QuSfXThJ6bveIYCf
         KlGw==
X-Gm-Message-State: AOAM532qpbo+iMFBa+BXmbLDE3DiNxiLSxtoZIq+sIHJPX3mEhfWhmBk
        v0Pj6OjacN9NdW+6ToLeUhUJGg==
X-Google-Smtp-Source: ABdhPJz+3dqBeG+BvnsNt/dKos5qgphcI0MBVWV7mfP9zSF43K5SROETB9Vehj9QEcVv/n7nGdT7JA==
X-Received: by 2002:adf:e60e:: with SMTP id p14mr9567459wrm.221.1616071474295;
        Thu, 18 Mar 2021 05:44:34 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id q15sm2813900wrx.56.2021.03.18.05.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 05:44:33 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Shujuan Chen <shujuan.chen@stericsson.com>,
        Joakim Bech <joakim.xx.bech@stericsson.com>,
        Berne Hebark <berne.herbark@stericsson.com>,
        Niklas Hernaeus <niklas.hernaeus@stericsson.com>,
        Jonas Linde <jonas.linde@stericsson.com>,
        Andreas Westin <andreas.westin@stericsson.com>,
        linux-crypto@vger.kernel.org
Subject: [PATCH 04/10] crypto: ux500: hash: hash_core: Fix worthy kernel-doc headers and remove others
Date:   Thu, 18 Mar 2021 12:44:16 +0000
Message-Id: <20210318124422.3200180-5-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210318124422.3200180-1-lee.jones@linaro.org>
References: <20210318124422.3200180-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ones remove here not only fail to conform to kernel-doc, but also
provide no value, so let's remove them completely in this case.

Fixes the following W=1 kernel build warning(s):

 drivers/crypto/ux500/hash/hash_core.c:368: warning: Function parameter or member 'ctx' not described in 'hash_get_device_data'
 drivers/crypto/ux500/hash/hash_core.c:368: warning: Excess function parameter 'hash_ctx' description in 'hash_get_device_data'
 drivers/crypto/ux500/hash/hash_core.c:551: warning: expecting prototype for hash_init(). Prototype was for ux500_hash_init() instead
 drivers/crypto/ux500/hash/hash_core.c:592: warning: Function parameter or member 'length' not described in 'hash_processblock'
 drivers/crypto/ux500/hash/hash_core.c:1302: warning: expecting prototype for hash_update(). Prototype was for ahash_update() instead
 drivers/crypto/ux500/hash/hash_core.c:1322: warning: expecting prototype for hash_final(). Prototype was for ahash_final() instead
 drivers/crypto/ux500/hash/hash_core.c:1622: warning: Function parameter or member 'device_data' not described in 'ahash_algs_register_all'
 drivers/crypto/ux500/hash/hash_core.c:1622: warning: expecting prototype for hash_algs_register_all(). Prototype was for ahash_algs_register_all() instead
 drivers/crypto/ux500/hash/hash_core.c:1647: warning: Function parameter or member 'device_data' not described in 'ahash_algs_unregister_all'
 drivers/crypto/ux500/hash/hash_core.c:1647: warning: expecting prototype for hash_algs_unregister_all(). Prototype was for ahash_algs_unregister_all() instead
 drivers/crypto/ux500/cryp/cryp.c:19: warning: Incorrect use of kernel-doc format:  * cryp_wait_until_done - wait until the device logic is not busy
 drivers/crypto/ux500/cryp/cryp.c:22: warning: Function parameter or member 'device_data' not described in 'cryp_wait_until_done'
 drivers/crypto/ux500/cryp/cryp.c:22: warning: expecting prototype for ST(). Prototype was for cryp_wait_until_done() instead
 drivers/crypto/ux500/cryp/cryp.c:292: warning: Function parameter or member 'cryp_mode' not described in 'cryp_save_device_context'
 drivers/crypto/ux500/cryp/cryp_irq.c:21: warning: Function parameter or member 'device_data' not described in 'cryp_enable_irq_src'
 drivers/crypto/ux500/cryp/cryp_irq.c:21: warning: Function parameter or member 'irq_src' not described in 'cryp_enable_irq_src'
 drivers/crypto/ux500/cryp/cryp_irq.c:21: warning: expecting prototype for ST(). Prototype was for cryp_enable_irq_src() instead
 drivers/crypto/ux500/cryp/cryp_core.c:42: warning: expecting prototype for ST(). Prototype was for CRYP_MAX_KEY_SIZE() instead
 drivers/crypto/ux500/cryp/cryp_core.c:91: warning: Function parameter or member 'key' not described in 'cryp_ctx'
 drivers/crypto/ux500/cryp/cryp_core.c:91: warning: Function parameter or member 'session_id' not described in 'cryp_ctx'

Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Shujuan Chen <shujuan.chen@stericsson.com>
Cc: Joakim Bech <joakim.xx.bech@stericsson.com>
Cc: Berne Hebark <berne.herbark@stericsson.com>
Cc: Niklas Hernaeus <niklas.hernaeus@stericsson.com>
Cc: Jonas Linde <jonas.linde@stericsson.com>
Cc: Andreas Westin <andreas.westin@stericsson.com>
Cc: linux-crypto@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/crypto/ux500/cryp/cryp.c      |  5 +++--
 drivers/crypto/ux500/cryp/cryp_core.c |  5 +++--
 drivers/crypto/ux500/cryp/cryp_irq.c  |  2 +-
 drivers/crypto/ux500/hash/hash_core.c | 15 +++++----------
 4 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/crypto/ux500/cryp/cryp.c b/drivers/crypto/ux500/cryp/cryp.c
index 9866c2a5e9a70..759d0d9786fd1 100644
--- a/drivers/crypto/ux500/cryp/cryp.c
+++ b/drivers/crypto/ux500/cryp/cryp.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/**
+/*
  * Copyright (C) ST-Ericsson SA 2010
  * Author: Shujuan Chen <shujuan.chen@stericsson.com> for ST-Ericsson.
  * Author: Jonas Linde <jonas.linde@stericsson.com> for ST-Ericsson.
@@ -15,7 +15,7 @@
 #include "cryp_p.h"
 #include "cryp.h"
 
-/**
+/*
  * cryp_wait_until_done - wait until the device logic is not busy
  */
 void cryp_wait_until_done(struct cryp_device_data *device_data)
@@ -285,6 +285,7 @@ int cryp_configure_init_vector(struct cryp_device_data *device_data,
  *				other device context parameter
  * @device_data: Pointer to the device data struct for base address.
  * @ctx: Crypto device context
+ * @cryp_mode: Mode: Polling, Interrupt or DMA
  */
 void cryp_save_device_context(struct cryp_device_data *device_data,
 			      struct cryp_device_context *ctx,
diff --git a/drivers/crypto/ux500/cryp/cryp_core.c b/drivers/crypto/ux500/cryp/cryp_core.c
index c3adeb2e58232..25ce56d05084e 100644
--- a/drivers/crypto/ux500/cryp/cryp_core.c
+++ b/drivers/crypto/ux500/cryp/cryp_core.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/**
+/*
  * Copyright (C) ST-Ericsson SA 2010
  * Author: Shujuan Chen <shujuan.chen@stericsson.com> for ST-Ericsson.
  * Author: Joakim Bech <joakim.xx.bech@stericsson.com> for ST-Ericsson.
@@ -62,7 +62,7 @@ struct cryp_driver_data {
 /**
  * struct cryp_ctx - Crypto context
  * @config: Crypto mode.
- * @key[CRYP_MAX_KEY_SIZE]: Key.
+ * @key: Key array.
  * @keylen: Length of key.
  * @iv: Pointer to initialization vector.
  * @indata: Pointer to indata.
@@ -73,6 +73,7 @@ struct cryp_driver_data {
  * @updated: Updated flag.
  * @dev_ctx: Device dependent context.
  * @device: Pointer to the device.
+ * @session_id: Atomic session ID.
  */
 struct cryp_ctx {
 	struct cryp_config config;
diff --git a/drivers/crypto/ux500/cryp/cryp_irq.c b/drivers/crypto/ux500/cryp/cryp_irq.c
index 7ebde69e8c76b..6d2f07bec98a7 100644
--- a/drivers/crypto/ux500/cryp/cryp_irq.c
+++ b/drivers/crypto/ux500/cryp/cryp_irq.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/**
+/*
  * Copyright (C) ST-Ericsson SA 2010
  * Author: Shujuan Chen <shujuan.chen@stericsson.com> for ST-Ericsson.
  * Author: Jonas Linde <jonas.linde@stericsson.com> for ST-Ericsson.
diff --git a/drivers/crypto/ux500/hash/hash_core.c b/drivers/crypto/ux500/hash/hash_core.c
index da284b0ea1b26..bcaf6ba3e9235 100644
--- a/drivers/crypto/ux500/hash/hash_core.c
+++ b/drivers/crypto/ux500/hash/hash_core.c
@@ -356,7 +356,7 @@ static int hash_enable_power(struct hash_device_data *device_data,
 
 /**
  * hash_get_device_data - Checks for an available hash device and return it.
- * @hash_ctx:		Structure for the hash context.
+ * @ctx:		Structure for the hash context.
  * @device_data:	Structure for the hash device.
  *
  * This function check for an available hash device and return it to
@@ -542,7 +542,7 @@ static bool hash_dma_valid_data(struct scatterlist *sg, int datasize)
 }
 
 /**
- * hash_init - Common hash init function for SHA1/SHA2 (SHA256).
+ * ux500_hash_init - Common hash init function for SHA1/SHA2 (SHA256).
  * @req: The hash request for the job.
  *
  * Initialize structures.
@@ -585,6 +585,7 @@ static int ux500_hash_init(struct ahash_request *req)
  * @device_data:	Structure for the hash device.
  * @message:		Block (512 bits) of message to be written to
  *			the HASH hardware.
+ * @length:		Message length
  *
  */
 static void hash_processblock(struct hash_device_data *device_data,
@@ -1295,7 +1296,7 @@ void hash_get_digest(struct hash_device_data *device_data,
 }
 
 /**
- * hash_update - The hash update function for SHA1/SHA2 (SHA256).
+ * ahash_update - The hash update function for SHA1/SHA2 (SHA256).
  * @req: The hash request for the job.
  */
 static int ahash_update(struct ahash_request *req)
@@ -1315,7 +1316,7 @@ static int ahash_update(struct ahash_request *req)
 }
 
 /**
- * hash_final - The hash final function for SHA1/SHA2 (SHA256).
+ * ahash_final - The hash final function for SHA1/SHA2 (SHA256).
  * @req:	The hash request for the job.
  */
 static int ahash_final(struct ahash_request *req)
@@ -1615,9 +1616,6 @@ static struct hash_algo_template hash_algs[] = {
 	}
 };
 
-/**
- * hash_algs_register_all -
- */
 static int ahash_algs_register_all(struct hash_device_data *device_data)
 {
 	int ret;
@@ -1640,9 +1638,6 @@ static int ahash_algs_register_all(struct hash_device_data *device_data)
 	return ret;
 }
 
-/**
- * hash_algs_unregister_all -
- */
 static void ahash_algs_unregister_all(struct hash_device_data *device_data)
 {
 	int i;
-- 
2.27.0

