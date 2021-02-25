Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12C2A325572
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 19:28:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233132AbhBYS2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 13:28:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233067AbhBYS2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 13:28:01 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B911C06178A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 10:27:20 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id z190so6578469qka.9
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 10:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JQJdSOWgWhcKarBNWRMV6VTAdv1Rbh5d+ABZaoC/+W4=;
        b=ieGfgpWtW+joVg+4cYRKzAzmyjHDhD/RbPnvpA0pTSDhSgZMN5sutEVKWuQE8IPrRk
         /tVi09ePFnUFgc8JbDUDR23avTi0pES3XhofNKSQXpVDgzPMDhPxjpBwSWThO1MWfXvu
         MHXzMAJgKpTRGcNDLcabQUlnI4bnKaOnzvtoBnNCuVKaJmqQ7Ibwx1t2bFiYBMEOXq+L
         YEMeQRbo8AyVSLQ4xnVbyQUoPMAu46W38ApntOdqDJbloy1nsDd8uex7XQfrWT7RpC+I
         h7OqLpbB2/a65pMsf/+6c9REufx4/KTmFLBJcO8lIPe4oup3uTWcl08MTNkfczv+Plog
         HdKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JQJdSOWgWhcKarBNWRMV6VTAdv1Rbh5d+ABZaoC/+W4=;
        b=dgsAiwvK9c8IJk7iXdqGDoInOeCZda0vInFBrB2aV8lxE3YTyOLUEj55Fj9YayqFJ6
         3BM9CF4yDAdY39Y13hQsc6rlk3d6neGwXUuPglXvsQxMS38HUQoMfQRVhbNekMikgqD7
         1HUSJXHhM4NBQ9PE3lSXnYC8D37v5NbqPOHygL2CEQBojSqVGpDpbzEs7qHoARgrBtKB
         QgMsu6frA5Sa5vE33iZcjmGY5VJTM/PrJ38NYIovJ9XhvlimZfPW4OIhvCycmfM68RYG
         HIQakpMtpSz5DhBGj8N+XPmk/+Sqg/QYWYAq/b/e4EiwqkLOnN/SZSHnQ1fdGfLtUpiI
         +6Dg==
X-Gm-Message-State: AOAM530VT5Dp818bxZg2uzcL+Q4+BpZ/yjwQNlI6jqB/6CDrSJ8wABGo
        ZnNefFfblYl2uNAIp0ZOxg6AfA==
X-Google-Smtp-Source: ABdhPJygSa8Hfmj+rZKtTtUiwOmK6QJAzpsGh2jwbEfFREVNB4elNGMHIel+sWrk/VjzPLJ3wLvvAg==
X-Received: by 2002:a05:620a:a19:: with SMTP id i25mr4037095qka.136.1614277639762;
        Thu, 25 Feb 2021 10:27:19 -0800 (PST)
Received: from pop-os.fios-router.home (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.googlemail.com with ESMTPSA id l65sm4519678qkf.113.2021.02.25.10.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 10:27:19 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        bjorn.andersson@linaro.org
Cc:     ebiggers@google.com, ardb@kernel.org, sivaprak@codeaurora.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] crypto: qce: Add mode for rfc4309
Date:   Thu, 25 Feb 2021 13:27:12 -0500
Message-Id: <20210225182716.1402449-4-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210225182716.1402449-1-thara.gopinath@linaro.org>
References: <20210225182716.1402449-1-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rf4309 is the specification that uses aes ccm algorithms with IPsec
security packets. Add a submode to identify rfc4309 ccm(aes) algorithm
in the crypto driver.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 drivers/crypto/qce/common.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/qce/common.h b/drivers/crypto/qce/common.h
index 3bc244bcca2d..3ffe719b79e4 100644
--- a/drivers/crypto/qce/common.h
+++ b/drivers/crypto/qce/common.h
@@ -51,9 +51,11 @@
 #define QCE_MODE_CCM			BIT(12)
 #define QCE_MODE_MASK			GENMASK(12, 8)
 
+#define QCE_MODE_CCM_RFC4309		BIT(13)
+
 /* cipher encryption/decryption operations */
-#define QCE_ENCRYPT			BIT(13)
-#define QCE_DECRYPT			BIT(14)
+#define QCE_ENCRYPT			BIT(14)
+#define QCE_DECRYPT			BIT(15)
 
 #define IS_DES(flags)			(flags & QCE_ALG_DES)
 #define IS_3DES(flags)			(flags & QCE_ALG_3DES)
@@ -73,6 +75,7 @@
 #define IS_CTR(mode)			(mode & QCE_MODE_CTR)
 #define IS_XTS(mode)			(mode & QCE_MODE_XTS)
 #define IS_CCM(mode)			(mode & QCE_MODE_CCM)
+#define IS_CCM_RFC4309(mode)		((mode) & QCE_MODE_CCM_RFC4309)
 
 #define IS_ENCRYPT(dir)			(dir & QCE_ENCRYPT)
 #define IS_DECRYPT(dir)			(dir & QCE_DECRYPT)
-- 
2.25.1

