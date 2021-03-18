Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 714743405E9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 13:45:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbhCRMpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 08:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbhCRMof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 08:44:35 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CCB2C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 05:44:34 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id o16so5400655wrn.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 05:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HZrsJeCHjZzLqDs78jg58TD58YS3CDAKgLNjuHszhbU=;
        b=GB1tHMwOe8xB2YCpzMzEyAQ/aaFW/MRJKBLj+9Zqr1WZTsDxjjyqXq/HD7Gk7pnbs8
         ZZhHAqdQUcQtHN7PLy4pmYIdfC5Skh8ZF8R3GKwuDEXxZlmXsnTrHFpdTmq+k0520N/O
         Qz2XoGjmE3LLPhujJ1oXCi5u+PpGpEtgnIm0rKrk0oK3TvU9liZFROdY6k/sGNuJlqYh
         fynD0wYZzkCuN/s+0pN6/c5fCLJ0pAn1+AcIvQc/W2zDeUBntfZRgfitkJnpzPM7LHa8
         TIJpMQAmFF9kbeKq1RN9dvAtXGqFOD4EKmd3ZuQlBu0hSzGpFjO8BeqGA7lklCcaa+9f
         gCfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HZrsJeCHjZzLqDs78jg58TD58YS3CDAKgLNjuHszhbU=;
        b=sqO4YFdv57/GIxfoRnu+w3oeHgStWX/5qdv4WXjbAYAr9WK+WQlyv62xDLvDhyz2cL
         ohbL2yH7OGVZDGkWpBumvGsFjt+4QcSDhUwLe/2rEQUD3zf2AQ9S0rKlG5Ayr3q+Jft3
         x3mBiE3rWrc+M4fLgjBLRf7N7uSaQ67rSJsoa4rW0KQQyzTavHlZMIhS8YZYOpmvtqkw
         hWmsbIB6/nBDOFLbgUUBXHptAWszBTD0OUfGX2CsyXmjIxthZRdFGBiXHGxpOEkmLiF8
         J05VA3+SeOHequJ61+p2rYkarCVb2KMgVIO9a7n48AZmlktjKF3UIX7JmGe9aykwaRsn
         eugA==
X-Gm-Message-State: AOAM531pIxgwxvVPo+Ik4prsdHIgtkUb2VOXLcuFP7nVCP8QmYaCWsEI
        juwX0vkc4ejqaCR3SeGGgv6RzQ==
X-Google-Smtp-Source: ABdhPJytI/0ZX0w0UTk5BnrMKYr8R35Ov9/amsgdtQ26LTMo74EsYmQH31oOTcZvrpPo+m8bTaCanQ==
X-Received: by 2002:a05:6000:114e:: with SMTP id d14mr9605253wrx.236.1616071473401;
        Thu, 18 Mar 2021 05:44:33 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id q15sm2813900wrx.56.2021.03.18.05.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 05:44:33 -0700 (PDT)
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
Subject: [PATCH 03/10] crypto: chelsio: chcr_core: Fix some kernel-doc issues
Date:   Thu, 18 Mar 2021 12:44:15 +0000
Message-Id: <20210318124422.3200180-4-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210318124422.3200180-1-lee.jones@linaro.org>
References: <20210318124422.3200180-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/crypto/chelsio/chcr_core.c:2: warning: wrong kernel-doc identifier on line:
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
 drivers/crypto/chelsio/chcr_core.c | 2 +-
 2 files changed, 4 insertions(+), 6 deletions(-)

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
diff --git a/drivers/crypto/chelsio/chcr_core.c b/drivers/crypto/chelsio/chcr_core.c
index f91f9d762a45e..f03ef4a23f96d 100644
--- a/drivers/crypto/chelsio/chcr_core.c
+++ b/drivers/crypto/chelsio/chcr_core.c
@@ -1,4 +1,4 @@
-/**
+/*
  * This file is part of the Chelsio T4/T5/T6 Ethernet driver for Linux.
  *
  * Copyright (C) 2011-2016 Chelsio Communications.  All rights reserved.
-- 
2.27.0

