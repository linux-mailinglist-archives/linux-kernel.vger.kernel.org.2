Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1E9E30F1E3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 12:18:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235594AbhBDLSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 06:18:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235711AbhBDLMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 06:12:16 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE2AC061221
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 03:10:20 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id l12so2765191wmq.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 03:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SaJWQD4EKpGmPpCanTvsNZ7Bn2MtR7BiI9nKxNlqVtw=;
        b=U+WBo23B0peFGorO7gesn2YLEsU8eTQip1OggOGRWj1tPIbr8SwXLLk1casRK5oCnn
         wkWdjrLJKUtXzardMlzF4vwCmPlwj1cLOQoxfEGW++0ld+5uHLBWyCN5ko9hoTUckX+X
         uArTd51/R6O83F5TihJAeEchRufyzEB0S3wmgVSyBcEydwdWTYM5I/rDflMzWqkQqi53
         9NOZ8rJCvTUn+25rZDqOLL289kDdHhGluWeno1A5xodiH1HDLi5RkgPSbKc5mpClIYvz
         JPzzOSL/SLa965FohBQyvskS+qj9B32WsihhrnY9rRdcE268GDj0rbquT3YAZOy01gh3
         x4rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SaJWQD4EKpGmPpCanTvsNZ7Bn2MtR7BiI9nKxNlqVtw=;
        b=snCyLjuXls1a3QedI355TXL4RK7hE6s+1OEAp1+SSLULTqG/dSBPd2s2XJZfNGt0I5
         vb8M7Y9zs0vroGrvz0MHzd7cKlXc2xTvG25zwrNyPEufdstYJbdX16Mw+gQNDAjBZVb7
         tjW3+neljf3dso1R2VVzfob4ZyOE74GNnd+cBmU8V2vZSfUEfZuWLObiiPE1AGuwQGyi
         H+Pu1OYF3WqWGA6QzhGai6UGsHYvtmUyDSUT6NAYd5oVqMYC3efWu6GM3H92JUHmdYt+
         6OYproAlBUApNLXFpwgxztffJEKM7Mv1ajvZQrMl3k4hg9gfRj0slWNMbgdrl8XJ5GWb
         Yt6A==
X-Gm-Message-State: AOAM532ycf0PNZo9pZVksIKnar2sqOgKHX6fW6fzB9gSSjjFrAaU6RIQ
        QlRdnsQ8PSLXLHRsZzCEYVSpsg==
X-Google-Smtp-Source: ABdhPJxXqrSBs7UvzogxtH4gMcXG9+M+TmLs+sXRxykZ+DZpXvSgND5kRWDw2l55vrKZjOgmA443ew==
X-Received: by 2002:a7b:c856:: with SMTP id c22mr1529367wml.5.1612437018821;
        Thu, 04 Feb 2021 03:10:18 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id y18sm7696218wrt.19.2021.02.04.03.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 03:10:18 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Rice <rob.rice@broadcom.com>, linux-crypto@vger.kernel.org
Subject: [PATCH 13/20] crypto: bcm: cipher: Provide description for 'req' and fix formatting issues
Date:   Thu,  4 Feb 2021 11:09:53 +0000
Message-Id: <20210204111000.2800436-14-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210204111000.2800436-1-lee.jones@linaro.org>
References: <20210204111000.2800436-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/crypto/bcm/cipher.c:1048: warning: Function parameter or member 'req' not described in 'spu_aead_rx_sg_create'
 drivers/crypto/bcm/cipher.c:2966: warning: Function parameter or member 'cipher' not described in 'rfc4543_gcm_esp_setkey'
 drivers/crypto/bcm/cipher.c:2966: warning: Function parameter or member 'key' not described in 'rfc4543_gcm_esp_setkey'
 drivers/crypto/bcm/cipher.c:2966: warning: Function parameter or member 'keylen' not described in 'rfc4543_gcm_esp_setkey'

Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Rob Rice <rob.rice@broadcom.com>
Cc: linux-crypto@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/crypto/bcm/cipher.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/bcm/cipher.c b/drivers/crypto/bcm/cipher.c
index 851b149f71701..053315e260c22 100644
--- a/drivers/crypto/bcm/cipher.c
+++ b/drivers/crypto/bcm/cipher.c
@@ -1019,6 +1019,7 @@ static void handle_ahash_resp(struct iproc_reqctx_s *rctx)
  * a SPU response message for an AEAD request. Includes buffers to catch SPU
  * message headers and the response data.
  * @mssg:	mailbox message containing the receive sg
+ * @req:	Crypto API request
  * @rctx:	crypto request context
  * @rx_frag_num: number of scatterlist elements required to hold the
  *		SPU response message
@@ -2952,9 +2953,9 @@ static int aead_gcm_esp_setkey(struct crypto_aead *cipher,
 
 /**
  * rfc4543_gcm_esp_setkey() - setkey operation for RFC4543 variant of GCM/GMAC.
- * cipher: AEAD structure
- * key:    Key followed by 4 bytes of salt
- * keylen: Length of key plus salt, in bytes
+ * @cipher: AEAD structure
+ * @key:    Key followed by 4 bytes of salt
+ * @keylen: Length of key plus salt, in bytes
  *
  * Extracts salt from key and stores it to be prepended to IV on each request.
  * Digest is always 16 bytes
-- 
2.25.1

