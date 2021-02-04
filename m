Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9DF30FF8E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 22:47:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbhBDVq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 16:46:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbhBDVps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 16:45:48 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B70CC061224
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 13:44:10 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id 2so2524487qvd.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 13:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YJE2aPOEkLIKEj61l27Ctrd7+4+SFwAw4jzWQDD0G1c=;
        b=oeTV7brAnPNqzQlfpvHWPIN/2EByLwjB4ekTbsIoy2RKjdwjBERjCGhL/IfkW4K/ZU
         JcGD9gHoN67JvxbkFoswbR8lV9qF/FWuqxk6onmTMvPmDQBKd3o10vLUq3sQ2g0QnxjQ
         xSSZwGzTqRhYqZYsHjL9DOUT83eCqiu+FM3BMHtjoKSUZS8d2dTe8A+P/s26IIBSsHGq
         GmFLeVKUBPIG4s8I07Mdhu9oZKuddSgmwi8lKqODK8lOULkSTMP7MmgQw0w1rNz/IPcO
         i6orK5sgO0PdUyxhPdHY8KeiREjWthc9ZRiR/RqjN2iR0Yrdh44y8s21iSHxBzCXDn6S
         YVXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YJE2aPOEkLIKEj61l27Ctrd7+4+SFwAw4jzWQDD0G1c=;
        b=Kjkke10uFgWIVOy5WvbyIRseGXbeIzxIrDPBX3gU+oGQn7MObvI+JCVRpVBUHNF/7L
         SIMczqr7VlndHgsIrdgKzoC7qeuMceujbQgprPWo0PSgpOS+UK7nqo22JWoAfiNL07c6
         OGhBMqi+bxOsUvZiNYwD3n6PSwnR1nrP6AmlI7fus3geP5roAvfXTuhtbmIeprOCsyhA
         G1YJR86eVBsDwm56uRJjQz4z2wjuVTF5ShODVT7Ad7zaDqTJOgu1jv84A33Q6OrjWVek
         uVIEpbzGZ2zUyp/Ton0pbetKSQdMNZdOuaszDfChyLVbsnocytfq68TYx1FdhvaepbLp
         9KcA==
X-Gm-Message-State: AOAM532YcmQdsTDIHsPFDAMGHTiYb5t364o4tMPuAZbJACPgCmE61Au0
        Mt9TJduo+sxLL4tZwDyam/V1kw==
X-Google-Smtp-Source: ABdhPJwn3ZSW6oAClmcsSu2NnL8tNcCjUJzMWl9HG9iUhgwlapo4tz+vh2jft2Xgq75FhWD8ylwKEQ==
X-Received: by 2002:a05:6214:613:: with SMTP id z19mr1419357qvw.2.1612475049721;
        Thu, 04 Feb 2021 13:44:09 -0800 (PST)
Received: from pop-os.fios-router.home (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.googlemail.com with ESMTPSA id h185sm6353858qkd.122.2021.02.04.13.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 13:44:09 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        bjorn.andersson@linaro.org
Cc:     ebiggers@google.com, ardb@kernel.org, sivaprak@codeaurora.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 10/11] crypto: qce: Remover src_tbl from qce_cipher_reqctx
Date:   Thu,  4 Feb 2021 16:43:58 -0500
Message-Id: <20210204214359.1993065-11-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210204214359.1993065-1-thara.gopinath@linaro.org>
References: <20210204214359.1993065-1-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

src_table is unused and hence remove it from struct qce_cipher_reqctx

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 drivers/crypto/qce/cipher.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/crypto/qce/cipher.h b/drivers/crypto/qce/cipher.h
index cffa9fc628ff..850f257d00f3 100644
--- a/drivers/crypto/qce/cipher.h
+++ b/drivers/crypto/qce/cipher.h
@@ -40,7 +40,6 @@ struct qce_cipher_reqctx {
 	struct scatterlist result_sg;
 	struct sg_table dst_tbl;
 	struct scatterlist *dst_sg;
-	struct sg_table src_tbl;
 	struct scatterlist *src_sg;
 	unsigned int cryptlen;
 	struct skcipher_request fallback_req;	// keep at the end
-- 
2.25.1

