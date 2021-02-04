Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95F2930F1CD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 12:18:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235482AbhBDLOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 06:14:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235708AbhBDLMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 06:12:14 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C13C061356
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 03:10:16 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id a1so3006070wrq.6
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 03:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=avN1u0Er/3jjbceQj3GDRB5KtHhfEhx0wpHOx8svPCg=;
        b=tbTk9psUc52Wwl90sZuJm/3vqked4L4RjNIaBf8tRL3qUxnaYWAE+Ijgg+Mwqge9mh
         C+lQ2LAaNUd9Jby+KXE88A9m6VnjNMqHu3U+EsZWNpHpUszlyKG37cJ9SOo0WjV/mT/H
         xJ020nufrEvJlN3WnYNB8z0mFMgP2fOISxcMVHdZUIxQtwUjbPr3FrvLIJtN3NyLBrZZ
         lk03+BTzI04dXjyjLMiY6b+JWk4ZeMOBhbROzr4VHLi+VTfY902xPc80ZK5aJsSZQb2n
         p0AALHyUhOwxR8ahBOkzU2+qOXqLDLRKm4bZwq+Seczaee2tiX+pXxfT6FVQn4Ic5JY4
         pG/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=avN1u0Er/3jjbceQj3GDRB5KtHhfEhx0wpHOx8svPCg=;
        b=fD1y8TwqNlItIGgAB7w5uqYyfm1myDntAC5fyp6K/9DfFT0v3EdW4WYAcN/domwlZY
         Xo62G7GYvgmBuXHQQuoIEouLsSSvFmn+vAxPaqdju7XCnh0AYHHczdu9kRLfjWTXGIHX
         CiiRXBEXI6Wt6t6vIyn3JQUTiEm8a1s4wIVWUCiWAY74g6xDSBiekKaX710FU90duwP/
         qrZuwXbG1hRLKYk41amKhnXsixjeFy3Gu1tF9YwlWuXL2PRFJoRh+z61ZhYCGtcd97xT
         GJa6vEKkVdTg1z44GBuG5YPMAJqdNzSQG1h64GE8JdrRFVDK0drKwPkdyKWtFjvxuyfB
         ok7Q==
X-Gm-Message-State: AOAM532hMUHTAv6NlK36WxudLw9R5gLHjdX7cboEKPT6iAXOhUosLlpX
        Vmf9UVQA62UV8VfN+Mz+sYRATw==
X-Google-Smtp-Source: ABdhPJzTMVni3uUeJoJsuMcvVIXormUpRYGc5uC7YJqFJZbIZqsofBqllUbt0pYWV02sTZYFmPC61g==
X-Received: by 2002:adf:dd05:: with SMTP id a5mr8572303wrm.402.1612437015406;
        Thu, 04 Feb 2021 03:10:15 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id y18sm7696218wrt.19.2021.02.04.03.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 03:10:14 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Ayush Sawal <ayush.sawal@chelsio.com>,
        Vinay Kumar Yadav <vinay.yadav@chelsio.com>,
        Rohit Maheshwari <rohitm@chelsio.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Manoj Malviya <manojmalviya@chelsio.com>,
        Atul Gupta <atul.gupta@chelsio.com>,
        Jitendra Lulla <jlulla@chelsio.com>,
        M R Gowda <yeshaswi@chelsio.com>,
        Harsh Jain <harsh@chelsio.com>, linux-crypto@vger.kernel.org
Subject: [PATCH 10/20] crypto: chelsio: chcr_algo: Fix a couple of kernel-doc issues caused by doc-rot
Date:   Thu,  4 Feb 2021 11:09:50 +0000
Message-Id: <20210204111000.2800436-11-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210204111000.2800436-1-lee.jones@linaro.org>
References: <20210204111000.2800436-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/crypto/chelsio/chcr_algo.c:806: warning: Function parameter or member 'wrparam' not described in 'create_cipher_wr'
 drivers/crypto/chelsio/chcr_algo.c:806: warning: Excess function parameter 'req' description in 'create_cipher_wr'
 drivers/crypto/chelsio/chcr_algo.c:806: warning: Excess function parameter 'ctx' description in 'create_cipher_wr'
 drivers/crypto/chelsio/chcr_algo.c:806: warning: Excess function parameter 'qid' description in 'create_cipher_wr'
 drivers/crypto/chelsio/chcr_algo.c:806: warning: Excess function parameter 'op_type' description in 'create_cipher_wr'
 drivers/crypto/chelsio/chcr_algo.c:1566: warning: Function parameter or member 'req' not described in 'create_hash_wr'
 drivers/crypto/chelsio/chcr_algo.c:1566: warning: Function parameter or member 'param' not described in 'create_hash_wr'

Cc: Ayush Sawal <ayush.sawal@chelsio.com>
Cc: Vinay Kumar Yadav <vinay.yadav@chelsio.com>
Cc: Rohit Maheshwari <rohitm@chelsio.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Manoj Malviya <manojmalviya@chelsio.com>
Cc: Atul Gupta <atul.gupta@chelsio.com>
Cc: Jitendra Lulla <jlulla@chelsio.com>
Cc: M R Gowda <yeshaswi@chelsio.com>
Cc: Harsh Jain <harsh@chelsio.com>
Cc: linux-crypto@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/crypto/chelsio/chcr_algo.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/crypto/chelsio/chcr_algo.c b/drivers/crypto/chelsio/chcr_algo.c
index f5a336634daa6..f77d3fd962bf8 100644
--- a/drivers/crypto/chelsio/chcr_algo.c
+++ b/drivers/crypto/chelsio/chcr_algo.c
@@ -797,10 +797,7 @@ static inline void create_wreq(struct chcr_context *ctx,
 
 /**
  *	create_cipher_wr - form the WR for cipher operations
- *	@req: cipher req.
- *	@ctx: crypto driver context of the request.
- *	@qid: ingress qid where response of this WR should be received.
- *	@op_type:	encryption or decryption
+ *	@wrparam: Container for create_cipher_wr()'s parameters
  */
 static struct sk_buff *create_cipher_wr(struct cipher_wr_param *wrparam)
 {
@@ -1559,7 +1556,8 @@ static inline void chcr_free_shash(struct crypto_shash *base_hash)
 
 /**
  *	create_hash_wr - Create hash work request
- *	@req - Cipher req base
+ *	@req: Cipher req base
+ *	@param: Container for create_hash_wr()'s parameters
  */
 static struct sk_buff *create_hash_wr(struct ahash_request *req,
 				      struct hash_wr_param *param)
-- 
2.25.1

