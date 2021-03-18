Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 869743405EC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 13:45:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbhCRMpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 08:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbhCRMoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 08:44:37 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CCA6C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 05:44:37 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id w203-20020a1c49d40000b029010c706d0642so6863492wma.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 05:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V3/tc0Yb6jrNSgFN3wzJjGp740jB6twjzIpO+YKSzDo=;
        b=aUM2L0+pi/1cI3jATJQAlraEb4KXpWG+rU4TizHnfrUYZmIvpEP1xfkQTgcwNHdZyh
         UflbNqAPANaQe+LcS+pKV+QUJBY1LIkBcDTVlvZD3LgH1jBv8XjM5189zmcTYS+2r1yZ
         lQ7IukKrv8o6znuYrXHAI/u3dD2ie7xA10DBvncwPPfxftToByDADIn4HP55yajJ5yWJ
         EWK21J1WinSmihtJY0Nmv8oMSe7aL+REVU0Qob68rN8H7dD3OKJ9amNVmumeEja9ykQ1
         lljl/7MDjS1zdbF0VTxlOF6dSdcOrMLHnKHDPegRPxfqKCxZsOFJ1noMeQsZMgSbftNL
         ZEQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V3/tc0Yb6jrNSgFN3wzJjGp740jB6twjzIpO+YKSzDo=;
        b=oAKlsXyTrxR0if02+8bWOvU6hxncGySUMtDytzzHjjh3g7VSfyXknIxNYNT9PSlys6
         s5eCJCoP4f0D048n3WG4GeAqUHsJReAvjTj5/OzucwyduNSeShncZLwDyhLlihVEBBMe
         f01wBK6NJaWGqrzYfPtcYMki4lSlQbURhYV8ghkUMzluWb7najKIsrcJaVTsDbHi5HvT
         pnGRfH94hHx24p+UGnus+InTQg0znrkJ1HSNdV49WOZGJetDDXp+BngWY+DwVPdLLt80
         XudoC1+XmyY9GGGU7RUUYH2Sh+UFdA1L2piTGQDTfzVG8doVIk0fXZ+3wG3oJiqtacUS
         Bk5Q==
X-Gm-Message-State: AOAM531Afa3pDod+wp7gr2J71F2JC8viseKWW6T7X+R58Jo7A1yUhpYN
        d3vPtnx2SHaDiDvYERpqU7/5qQ==
X-Google-Smtp-Source: ABdhPJyKR338FNSwiovSQH97gzw+u/TywpTayrlftICyjXcQzKH05FqBFmP+pXqU11eWzlEYaNL3+g==
X-Received: by 2002:a1c:7210:: with SMTP id n16mr3403759wmc.13.1616071476358;
        Thu, 18 Mar 2021 05:44:36 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id q15sm2813900wrx.56.2021.03.18.05.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 05:44:36 -0700 (PDT)
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
Date:   Thu, 18 Mar 2021 12:44:18 +0000
Message-Id: <20210318124422.3200180-7-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210318124422.3200180-1-lee.jones@linaro.org>
References: <20210318124422.3200180-1-lee.jones@linaro.org>
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
index 515946c99394e..333fbefbbccbd 100644
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

