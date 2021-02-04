Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10F0530F1C0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 12:14:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235731AbhBDLMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 06:12:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235674AbhBDLLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 06:11:48 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E90C0617A9
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 03:10:11 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id u14so2627594wmq.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 03:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a2lURvcXUAZ56o/yGYVgo6mp0F/K9gLatpjFLDr+G/I=;
        b=V9jzeEe7iyd/YDg6OYfRwyL21PZ5X/2P5QTnGWFRem+ALb5v5ZWl3H+ahTpTjdyOGk
         2wnJjy7BgMTUN9qLgIa/nvo/1A8y7LWCjupX1IY83coEJ9pQL687Fs0NwmA/n5ooTjUm
         OFv1m8uf49xbKfUHoG0P1CyX/uoai4oArpOo0p8uIrcSAZfYM9RMo8dG0zWOrjFiON0I
         0Kse5fpaaTUp+zArXeOvAwcTNl3oEIRm7oxmT9yD4f477G4qiz84YKibzcExHFYV0RGz
         oZoMFUk0+UXrBRTpR8F6ULHBdiGQOD1Llw/Ky7jUyWetDLxzqcJkshQU12Nv6m1ngseY
         hpzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a2lURvcXUAZ56o/yGYVgo6mp0F/K9gLatpjFLDr+G/I=;
        b=c7yqnTgbIiO4sIqZV6GxqkKQUBn0+WTNCEFw8AqWanXDkHCfMDYs4HzbNd35UNLHsx
         4Bmbw/NKtqcRW4wZMu727a/ByHXCR3Vi4Q5JPIiEztE8CGgPIrpDkXMLAMHKx4Oml2Rn
         v3Ra+PngdlaE63MrQRlkEWn0yEo3UzhjQcO7EHtFJYmYjQGgise/UWJMlEWnjNw+6lvv
         e4nE4zbseKUXNgsaBh9OedIql2p8qwOH2G7HuQN6fwHY+r9LqpmSlJFwaosoh8BvJ3g5
         SpGH/Cny+x1pVLYeTdsgKQ6cJE6tkPuNghleYu9b4BCWrjhI9DUWJ1EDmhm43Inb8isR
         jexA==
X-Gm-Message-State: AOAM530Tn47hIkb7e7GbLJsH/ESNpYtyVA/Q7JLbUQjXQXuSPp+p6Di8
        dWwK9AzxyKrA+4R0UDrvtLzpEg==
X-Google-Smtp-Source: ABdhPJwsjLElKxrRS5U+fKqac2/+gHlJnWj1+tLjCIOu7H5XbP7NufH5kTAz1uR6B/nsvyYS58hATw==
X-Received: by 2002:a1c:9845:: with SMTP id a66mr6772136wme.121.1612437010723;
        Thu, 04 Feb 2021 03:10:10 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id y18sm7696218wrt.19.2021.02.04.03.10.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 03:10:10 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Daniele Alessandrelli <daniele.alessandrelli@intel.com>,
        Declan Murphy <declan.murphy@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org
Subject: [PATCH 06/20] crypto: keembay: ocs-hcu: Fix incorrectly named functions/structs
Date:   Thu,  4 Feb 2021 11:09:46 +0000
Message-Id: <20210204111000.2800436-7-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210204111000.2800436-1-lee.jones@linaro.org>
References: <20210204111000.2800436-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/crypto/keembay/ocs-hcu.c:107: warning: expecting prototype for struct ocs_hcu_dma_list. Prototype was for struct ocs_hcu_dma_entry instead
 drivers/crypto/keembay/ocs-hcu.c:127: warning: expecting prototype for struct ocs_dma_list. Prototype was for struct ocs_hcu_dma_list instead
 drivers/crypto/keembay/ocs-hcu.c:610: warning: expecting prototype for ocs_hcu_digest(). Prototype was for ocs_hcu_hash_update() instead
 drivers/crypto/keembay/ocs-hcu.c:648: warning: expecting prototype for ocs_hcu_hash_final(). Prototype was for ocs_hcu_hash_finup() instead

Cc: Daniele Alessandrelli <daniele.alessandrelli@intel.com>
Cc: Declan Murphy <declan.murphy@intel.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: linux-crypto@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/crypto/keembay/ocs-hcu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/keembay/ocs-hcu.c b/drivers/crypto/keembay/ocs-hcu.c
index 81eecacf603ad..d522757855fb0 100644
--- a/drivers/crypto/keembay/ocs-hcu.c
+++ b/drivers/crypto/keembay/ocs-hcu.c
@@ -93,7 +93,7 @@
 #define OCS_HCU_WAIT_BUSY_TIMEOUT_US		1000000
 
 /**
- * struct ocs_hcu_dma_list - An entry in an OCS DMA linked list.
+ * struct ocs_hcu_dma_entry - An entry in an OCS DMA linked list.
  * @src_addr:  Source address of the data.
  * @src_len:   Length of data to be fetched.
  * @nxt_desc:  Next descriptor to fetch.
@@ -597,7 +597,7 @@ int ocs_hcu_hash_init(struct ocs_hcu_hash_ctx *ctx, enum ocs_hcu_algo algo)
 }
 
 /**
- * ocs_hcu_digest() - Perform a hashing iteration.
+ * ocs_hcu_hash_update() - Perform a hashing iteration.
  * @hcu_dev:	The OCS HCU device to use.
  * @ctx:	The OCS HCU hashing context.
  * @dma_list:	The OCS DMA list mapping the input data to process.
@@ -632,7 +632,7 @@ int ocs_hcu_hash_update(struct ocs_hcu_dev *hcu_dev,
 }
 
 /**
- * ocs_hcu_hash_final() - Update and finalize hash computation.
+ * ocs_hcu_hash_finup() - Update and finalize hash computation.
  * @hcu_dev:	The OCS HCU device to use.
  * @ctx:	The OCS HCU hashing context.
  * @dma_list:	The OCS DMA list mapping the input data to process.
-- 
2.25.1

