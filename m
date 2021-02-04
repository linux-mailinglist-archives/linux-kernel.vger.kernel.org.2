Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4DAD30F1C7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 12:14:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235653AbhBDLNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 06:13:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235683AbhBDLLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 06:11:52 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7AC9C06121D
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 03:10:17 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id l12so2765110wmq.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 03:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zBZEiBnCpDze/1GuNJ3i38XwYi6MurOqLTEFwMePbaw=;
        b=P9bFnE5keghdh3BWBUni3jDga4wzhgq6MltnIId6KX0E3x3XTkggNsmjWbaYy/CbvQ
         5PI5SiqqrEnylEv2Kb2BcDmwoSuuXytdIbhaWuHUEO5NJfsqGHMa7rdAJlKyTTteJWAF
         HwM4Ugjfd4P2UIcA1Kl1XU9+6uwaaD/gGJdRQMeTu91HD0lmmBjgqQ1myxJPJy3ap0li
         xFQOKxmaMFOsMlKGvAYN/AOLw+npaUZLgWIBHgg9YzLiJpn3jN1UgpZd78eT63HMxGJR
         76KYyHGu36j2+iTkHinJ49RIPRe9Nqp1HKCUTwijHUr9fZ7c2HW8y/nlBGeOBx9zMUK3
         mVsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zBZEiBnCpDze/1GuNJ3i38XwYi6MurOqLTEFwMePbaw=;
        b=bQyk2um8uPHHQ1V7BVUYrLzILC3YhKyGxPWDS9VHfsrF/lrGwZxydD43++9hgQ4LgQ
         Ej9h67QHJKbuVuHjgi3psSco+pMJ6yQosA/CaxGhU9CdV7mqK6A93NCJIGE66lP34myR
         dqqc0bczIDGovh1mXOTwPvkBRYcY+2DAfNmuCWzgEsd6CsCi0yH+bbckZks6+76ZGfWv
         kvcppgR5w2PKcUYTgAh1R4zx7z7hA7d/4eJIv+rcDTqOqs9tTtkYVhjewMDBRgHDUYnj
         vDEmt+yKkJdzoGadwP5LNTyLP/H4G24AqNk6cXno63kXi9+Y5fNhMM1xgewkL0McN6ub
         1ALQ==
X-Gm-Message-State: AOAM531NwoYOWNDDJZHlezFpM6KqKCUhMT6NfADhy+r2AWWy4j/ys4To
        hH7lYLu42cemaDz8LkQI3gGpPg==
X-Google-Smtp-Source: ABdhPJxa0jBjTk9Ppr0Vm14I1WsrfGS8lDuYZwfoumBJ/YUQ89k6+Y07+/2DRivZIeayEMmQPc1/wg==
X-Received: by 2002:a1c:f70f:: with SMTP id v15mr6821220wmh.38.1612437016576;
        Thu, 04 Feb 2021 03:10:16 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id y18sm7696218wrt.19.2021.02.04.03.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 03:10:15 -0800 (PST)
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
Subject: [PATCH 11/20] crypto: ux500: cryp_core: Fix formatting issue and add description for 'session_id'
Date:   Thu,  4 Feb 2021 11:09:51 +0000
Message-Id: <20210204111000.2800436-12-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210204111000.2800436-1-lee.jones@linaro.org>
References: <20210204111000.2800436-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

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
 drivers/crypto/ux500/cryp/cryp_core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

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
-- 
2.25.1

