Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CCAF3124CE
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 15:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbhBGOnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 09:43:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbhBGOla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 09:41:30 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C56A8C061223
        for <linux-kernel@vger.kernel.org>; Sun,  7 Feb 2021 06:39:57 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id ew18so5841130qvb.4
        for <linux-kernel@vger.kernel.org>; Sun, 07 Feb 2021 06:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YJE2aPOEkLIKEj61l27Ctrd7+4+SFwAw4jzWQDD0G1c=;
        b=vRZA+bp9CxaDQnbcLIMCP86fsnHA3pAiAQ+Gh6AZO+NavKryjzwTvbla6AvGQpXs4j
         5f7+t6DFu5+mT3AEBZcAEUb6Ps+XJNTnUvvvLyUi2ePkBYR0N7AU/wj85+daDcMKY9sS
         Zde2mF07V+Kq5v6tnXBdFhSYq7jbMteRcxeoD0PG/q2xIKLqkJIFmrmnOwY+L6bOHrqX
         vaUrmzjoxYuF0adNhC5tq2qSe61XtxpNKegICELeNh0z2ffrPyWm1khd3ZfHNhTOzsOX
         j2ZGLeuYzb98FIMOqnxFKsTh2MsYG7QWkoKVuQYRzoWZu3QoK290Es05zpzJ2pvspkNN
         NPWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YJE2aPOEkLIKEj61l27Ctrd7+4+SFwAw4jzWQDD0G1c=;
        b=LobepNtT0zka7RBhxpBiAP7WTHeq9hiLwrLK5/jGQ0YfQMmnS71N39REvzisz8H3s3
         psSjWkVIAUR9A9hJzM8wwDGIvdFFPt/I5oG3fR3p9b1W3EMG3rMihF+owoXgLhLyABrj
         PjiNZgQL+x4lt2mMNTQHgQXUQkjdOosCCHJYPgi7/K/DTWjAQmsf3/mURZfvfp6qVnyi
         wjIwryGbbhEymUWWjg04xbmhyVhdlCjcZa4unadGNwyGYNVKxYe8wg+hFEsQB216rUYw
         Bs+PMh3pBiGO961MXSJF7mBfRXvha4oMHWSplRIpbVU+H2HG0gkjLeYirsorUvD6e4mD
         4GHw==
X-Gm-Message-State: AOAM531vlbuEjeFLBTT92xcO+sWVOzE0GocQ0RdHhSYOQTen06bHbvLV
        UOlCopr7gDXlUoUioQqlgOtX6Q==
X-Google-Smtp-Source: ABdhPJxzoljplC50Tdb6nYh/4X2st4nDncfUkPwTVPCnwyDqvM/wxkHJgxK+bAkl2xuH2moPC8yNyg==
X-Received: by 2002:ad4:4d4c:: with SMTP id m12mr12732537qvm.6.1612708797055;
        Sun, 07 Feb 2021 06:39:57 -0800 (PST)
Received: from pop-os.fios-router.home (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.googlemail.com with ESMTPSA id c81sm13941493qkb.88.2021.02.07.06.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Feb 2021 06:39:56 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        bjorn.andersson@linaro.org
Cc:     ebiggers@google.com, ardb@kernel.org, sivaprak@codeaurora.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 10/11] crypto: qce: Remover src_tbl from qce_cipher_reqctx
Date:   Sun,  7 Feb 2021 09:39:45 -0500
Message-Id: <20210207143946.2099859-11-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210207143946.2099859-1-thara.gopinath@linaro.org>
References: <20210207143946.2099859-1-thara.gopinath@linaro.org>
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

