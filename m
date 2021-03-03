Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E55AC32BEE6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 00:03:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386123AbhCCRql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:46:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243830AbhCCOhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 09:37:50 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37063C0611BE
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 06:35:04 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id w11so23901831wrr.10
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 06:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TyCRNcW9jhoQTNtiMi/xmI1j72eDsy4y59EVvo0Z4FE=;
        b=l8UUBG2uy3M0PPzlV0JbisAYlPqKofn0NrVD5U2bbR5BmLpsStqQ4UYbCQ9ZYOklNX
         ZnA5xeEviOvpvW/3LNb5j4Ll2Y9l7O9dKYESIGO8aa3vmNYoR4WghDEDiP9PTvHeM/JP
         XhgdSihASpr4apdI0bH9P5TvVPcSdPYljiLxd0BmcEKMDbWMJyildqTVgZ9gpj/2eLYu
         8W9mOw9Z80Ii6YtrUWJLv6Wq/xQG6lpatAmPR5KiuDKhjDXN7HDPdKPhvP2+uYRiL9iS
         m1G5k4nm8yvYX2LtBU0jB1Gkc9uUxg3WV6o5DiOTJ40RNZ1VaHhRm7aFFea1++YB2p8p
         CHtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TyCRNcW9jhoQTNtiMi/xmI1j72eDsy4y59EVvo0Z4FE=;
        b=GFar7AJ0sx3+adWPby+21iYFNR+4QobnCzpsQ4sWu0QAbWL+8JzjOeBnaHVJesaB1k
         Rn0oz7HnJzqh2PhPn9y2jB/lGfOuP28N0NJefH3sn5wZdFQusq8b0jGftyDzkYIhkjzf
         c/HdFJXEisRAaTnfWoKuWCYEYMlmP2OOfoYUrQsOz3RKjdLF1b164cRL4yDnWoQAEOVy
         5yHO/AZ6yP0LXR5QtO7W65zMX4kRuVNZ+zjcfOWZVUGIh/9sFkNNRqXgIbWaNqvF/40w
         4kAd7nqJqoL+lYeYCZHSU7827EytbzzVbB8QngRYue9WiGu19jovLpcLhU/H8gNU0Kwd
         Z5IQ==
X-Gm-Message-State: AOAM532Yr040LN2oO45Iehb/9G0SCw9/+blnv9IlohoeVqedjXJ26gip
        7BQrCWegu07ZhfnmZInuE7uof4H0vIz9VQ==
X-Google-Smtp-Source: ABdhPJy6wV8w5KlnpqihG1u/DW9aADK6d+5UUwRzDOfELWCTxZo0z3yIsOcs5twXTVVXgmdGD4SJ8Q==
X-Received: by 2002:a5d:67c8:: with SMTP id n8mr20592106wrw.351.1614782102888;
        Wed, 03 Mar 2021 06:35:02 -0800 (PST)
Received: from dell.default ([91.110.221.155])
        by smtp.gmail.com with ESMTPSA id f16sm31475923wrt.21.2021.03.03.06.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 06:35:02 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 06/10] crypto: atmel-ecc: Struct headers need to start with keyword 'struct'
Date:   Wed,  3 Mar 2021 14:34:45 +0000
Message-Id: <20210303143449.3170813-7-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210303143449.3170813-1-lee.jones@linaro.org>
References: <20210303143449.3170813-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/crypto/atmel-ecc.c:41: warning: cannot understand function prototype: 'struct atmel_ecdh_ctx '

Cc: Tudor Ambarus <tudor.ambarus@microchip.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
Cc: linux-crypto@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/crypto/atmel-ecc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/atmel-ecc.c b/drivers/crypto/atmel-ecc.c
index 9bd8e5167be34..66a31e5739f4c 100644
--- a/drivers/crypto/atmel-ecc.c
+++ b/drivers/crypto/atmel-ecc.c
@@ -26,7 +26,7 @@
 static struct atmel_ecc_driver_data driver_data;
 
 /**
- * atmel_ecdh_ctx - transformation context
+ * struct atmel_ecdh_ctx - transformation context
  * @client     : pointer to i2c client device
  * @fallback   : used for unsupported curves or when user wants to use its own
  *               private key.
-- 
2.27.0

