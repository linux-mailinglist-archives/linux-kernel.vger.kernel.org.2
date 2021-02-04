Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0036630F1F0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 12:22:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235715AbhBDLSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 06:18:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235607AbhBDLLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 06:11:54 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA03BC06121F
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 03:10:18 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id e15so2655149wme.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 03:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PLs7LqNAnAgmBAtmZ421+3eJ35mH5VQmNcNQ6hrZ2jk=;
        b=w/YWwwHoBalPlN40RqolDputHUgs7ltrteDMkwSbm450sjnKe1GilEIqQfKOXYqVwT
         p6puBv8aesKr6hgfHUiv1B8b86YehM3QV2FYexzTjV/OqgDNe4CH8gsM8XEhHE5Z0wXs
         z1ywor6NhTVY05+bdkOpo0gNIEXWZ+NckY194k9i6cdc+Gqaa2StQ9lDAcdaTUSthi+d
         D7qBXrPlPKs2HVbkCFG4TyjQbVEyV00Q2Vz16RnI/HC856+Y0STTCBN5AiOyulcpTvOc
         UQo2UFGhjJM4dMBVOLVpGSBR3ogP1goMVoSma2uWn7PL4yVKWH2s4mNnyK3SyjSdav6s
         yuKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PLs7LqNAnAgmBAtmZ421+3eJ35mH5VQmNcNQ6hrZ2jk=;
        b=J0hQXrxObSOCRO5Ts0USddP18gAT+dSWmoPNbbytZhkneZ/0HVtRmRfCXkNU6KDFRl
         kuXjmYzuTJBKDiDwlC0M2mzgXrloLxAbraxgZldXpTQdBLwcVgsdsv7kiP+HW4CO+i8Z
         aDUkdjXQDSNbWv7t1BIh+9cTnxggihYqAajw/Fy02k1smuBM7tKS72IJrDqQxBPGVwCH
         mk2YWcvsH6EO4G9a5/FiC9AGm6PNDlrhM0PLeAdBKK3PKYC+7fOBP3y8k9v0mSfsvPgm
         IFmv5kQyt2LCCOGylAefJ/RPEHufWcN8pgQyCPYmfPiCvQ8zwU0tFBBIj8KI1fum2itW
         I9mw==
X-Gm-Message-State: AOAM531Ac8Yux2ZwlR8gEYvGSHqZF/yZINJAckCrhD793Kri58cMUkor
        hIQTGG5BZVdwFxKX+13S7RVPkw==
X-Google-Smtp-Source: ABdhPJwJkNyvrnalG1Avr6T8KZZg+DzNeFqzqCm+eQXMQLyMgzq5Tvxx/4+S0HlsUpBPvunszAe/Ng==
X-Received: by 2002:a1c:3587:: with SMTP id c129mr6949813wma.76.1612437017719;
        Thu, 04 Feb 2021 03:10:17 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id y18sm7696218wrt.19.2021.02.04.03.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 03:10:17 -0800 (PST)
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
Subject: [PATCH 12/20] crypto: atmel-ecc: Struct headers need to start with keyword 'struct'
Date:   Thu,  4 Feb 2021 11:09:52 +0000
Message-Id: <20210204111000.2800436-13-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210204111000.2800436-1-lee.jones@linaro.org>
References: <20210204111000.2800436-1-lee.jones@linaro.org>
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
2.25.1

