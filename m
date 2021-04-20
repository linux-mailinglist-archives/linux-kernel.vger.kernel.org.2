Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8442D3650FE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 05:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234782AbhDTDhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 23:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233679AbhDTDgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 23:36:39 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3472C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 20:36:06 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id l2so81857qvb.7
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 20:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7tQSQBp8E/uoMZD1l/8pHdv/Ocs7V0bwBi7hSbeXtqY=;
        b=BmeAmUO+y9Cynp9A0J6ATDoKtINwWPXTcOlBYdMJiFwwGxQ9QCgbTTkPbviJsI3FAu
         ksCmHJ/DGuA7exPuTP8RDeCeBRVUBD+inYD2ShU+AoXT5DERMTE2L8hTvLM+kFzD1CN0
         gqy8KnLyQQseiaITVVhfDjJXAz1prImBQUrqumXgOHBqbCCSHAuNfEZWTvGIXp2TgqbE
         1QC1gMZeZEXKasX9tU5gImUKjmCdn/iRa40Eae2Bk+D25bAFZahnsTqK5EfPsEG3jXNL
         rRyNFp091ytH03NTu4kVcs8MmdBSeGyB3rAxFlFIlqdTbi38Ud28J0ZqZLZvkcPJqifQ
         a1yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7tQSQBp8E/uoMZD1l/8pHdv/Ocs7V0bwBi7hSbeXtqY=;
        b=f3KZpkxEtE5urfQKEU4h/HnEA58zDfhAQoVqKxPIyfPQnM+G9CocQ9OYpOt2paUlse
         WqBklGbQl23Swzsklq/m5K5K4S7w62rDYUm8Ajm0/xZ5OeGiauJw9dT78pRQoGaNH6YL
         xrvfue7E+5g6sMlL7XIngpqEGJG5NxGzgkFH7I9pEK/R5Mod8AUsLYlqDkzsjuUZPD48
         vaKHSEnSFAEFL7nlFaOwxBJfFX7As/dvfhuMv5JijWjCkhBh/HI/jzBUed7pfobcWSG6
         iM5PY4G3IYrCV0vjv+3kdtaEptuX82zZmxdePHGqgEMXVapvu4VADKZ0BDQ/OvVkf9WV
         Rf5Q==
X-Gm-Message-State: AOAM533fa4t1mrAViRehcX/ZvowMqw7+PBpUiXfMlTSBlvbfO36Kh9zW
        5yEcZCnTzp1is+xCEjEWvWxS6A==
X-Google-Smtp-Source: ABdhPJxgsDMFRCrY7dFVQZfsuUEwUrsbH9bNAuAE5kw/3tmptIZ1sTTpaFW1lMBqOEJJvnS3nJg+ZQ==
X-Received: by 2002:a05:6214:223:: with SMTP id j3mr25055724qvt.9.1618889766110;
        Mon, 19 Apr 2021 20:36:06 -0700 (PDT)
Received: from pop-os.fios-router.home (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.googlemail.com with ESMTPSA id b8sm3562643qka.117.2021.04.19.20.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 20:36:05 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        bjorn.andersson@linaro.org
Cc:     ebiggers@google.com, ardb@kernel.org, sivaprak@codeaurora.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [Patch v3 3/7] crypto: qce: Add mode for rfc4309
Date:   Mon, 19 Apr 2021 23:35:58 -0400
Message-Id: <20210420033602.1729947-4-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210420033602.1729947-1-thara.gopinath@linaro.org>
References: <20210420033602.1729947-1-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rf4309 is the specification that uses aes ccm algorithms with IPsec
security packets. Add a submode to identify rfc4309 ccm(aes) algorithm
in the crypto driver.

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---

v1->v2:
	- Moved up the QCE_ENCRYPT AND QCE_DECRYPT bit positions so that
	  addition of other algorithms in future will not affect these
	  macros.

 drivers/crypto/qce/common.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/qce/common.h b/drivers/crypto/qce/common.h
index 3bc244bcca2d..b135440bf72b 100644
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
+#define QCE_ENCRYPT			BIT(30)
+#define QCE_DECRYPT			BIT(31)
 
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

