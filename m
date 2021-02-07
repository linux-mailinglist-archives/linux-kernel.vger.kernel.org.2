Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D76BB3124CA
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 15:44:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbhBGOma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 09:42:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbhBGOlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 09:41:13 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2341AC061356
        for <linux-kernel@vger.kernel.org>; Sun,  7 Feb 2021 06:39:55 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id w11so5820755qvz.12
        for <linux-kernel@vger.kernel.org>; Sun, 07 Feb 2021 06:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aBCNw2sBGbDAVprr4vYeHsYbO7AgbkLvqbpGnAY2zpA=;
        b=eQIjWXsRruSo59w86ZyCxMtGc79M6RTNi9zn5ZsDr0mNYjdxPflsIDBEa2OSsTF8LN
         4v5IpdnR0tyhszxBPoVX4n1Xw3D9BfJVxqBr9TvkSymIuPkDzuQN/VsS7sMWhrTAvvhX
         cn5TSLTzx70MNAsq7M3Mj9yiLoWZSGy8jon9TeKsI9LnepNiF2GgKrjK822FsrDEPSMe
         zTxeZ1x8IYuTTC10Xq2nzr9Yt0OU2m5Rh8Nlvt0a7ioQT/esnmVTV146gQkd9IZCpDpf
         Y8xRYiBW87z7eqaIWELirH1o7pVQ1lI1Fd0C2FS18nAq7XtFK8XUY6+nqOI4bY1l0ocF
         X/HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aBCNw2sBGbDAVprr4vYeHsYbO7AgbkLvqbpGnAY2zpA=;
        b=MTpRqw2HvC+6eReR8wO042ZrdgAql7JPROGjUcoV3UY5n9utDpZVji8C8lS1hLvQ7B
         4lpWmvkvtVSxtSCPFqti3/Dy14+Xi+iOey14aynawnmNYu3a/mJdndEoFIPLQ58LPYuq
         2UH+o19kfcONr7gM9A8KWZKGjNcHc9MITU3esqgNXtllkoDq7SPbXb2jl471MQvErkZv
         0G/7pj8BZ+E5EBBOaPMmWT7/iF8v5rptnMQ8vcpI48xCw1Ws0/Y+c34jBqce+NEAcqY9
         jRtpmk6jiSCSx+dPZwuK9ciELSL4ZjHKN7E4DHFNTfY9IxG+ZjQTtQ0lYJVBTiIVcM86
         KonA==
X-Gm-Message-State: AOAM531fWo8wGe1hdptwoIlVpoqDd1RTrZgXDhygZBDoWMnB/+ih4hWm
        mgLMxIe+EuWQEYfn8+Mgi3Tmww==
X-Google-Smtp-Source: ABdhPJzq9BMxWKK98fGBJllyBTJ97Qqb5nuUy1iC5ToySlb0CKTBsnix10+G69zNvQ6Y81OHP096bA==
X-Received: by 2002:a0c:dd8b:: with SMTP id v11mr12497164qvk.31.1612708794395;
        Sun, 07 Feb 2021 06:39:54 -0800 (PST)
Received: from pop-os.fios-router.home (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.googlemail.com with ESMTPSA id c81sm13941493qkb.88.2021.02.07.06.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Feb 2021 06:39:53 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        bjorn.andersson@linaro.org
Cc:     ebiggers@google.com, ardb@kernel.org, sivaprak@codeaurora.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 07/11] crypto: qce: skcipher: Set ivsize to 0 for ecb(aes)
Date:   Sun,  7 Feb 2021 09:39:42 -0500
Message-Id: <20210207143946.2099859-8-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210207143946.2099859-1-thara.gopinath@linaro.org>
References: <20210207143946.2099859-1-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ECB transformations do not have an IV and hence set the ivsize to 0 for
ecb(aes).

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 drivers/crypto/qce/skcipher.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/qce/skcipher.c b/drivers/crypto/qce/skcipher.c
index d24d96ed5be9..64f661d7335f 100644
--- a/drivers/crypto/qce/skcipher.c
+++ b/drivers/crypto/qce/skcipher.c
@@ -353,7 +353,7 @@ static const struct qce_skcipher_def skcipher_def[] = {
 		.name		= "ecb(aes)",
 		.drv_name	= "ecb-aes-qce",
 		.blocksize	= AES_BLOCK_SIZE,
-		.ivsize		= AES_BLOCK_SIZE,
+		.ivsize		= 0,
 		.min_keysize	= AES_MIN_KEY_SIZE,
 		.max_keysize	= AES_MAX_KEY_SIZE,
 	},
-- 
2.25.1

