Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89550363056
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 15:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236533AbhDQNZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Apr 2021 09:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234904AbhDQNZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 09:25:38 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2492BC06138B
        for <linux-kernel@vger.kernel.org>; Sat, 17 Apr 2021 06:25:08 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id c123so26834106qke.1
        for <linux-kernel@vger.kernel.org>; Sat, 17 Apr 2021 06:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CcaW1nPaukhEXiXprBAQ1ypKp3C4X7MmOMiLijl8qRY=;
        b=RjH9XHI2oJOZeUG94wCXHJ5rvdfUHzbvA8lQHKAw7P1yZyToFuJWcLHvmwPIIp/4bb
         jYJCV77wE2D7xJx1JRXgOnge9haXxjrHyJ/uJDBapQTX7JaCoDfFGSbI/IQHKV/7xr6g
         BflkqxHI5R7ImiqgQYw/CuoPIkp+rpi95EbPrRT9PLZcGQJToXpdFA/TRJeEcCdDklNE
         Ye+Sv1KkJgOm+yiqhWi3HAB573wY7A+toq0Z6l5s9T7461ZwxJ2hHmdp6LPbHxInbXOU
         lMrqE8etp2feC8Zj4/cO9gpg1nNE38bSYWNXubCtvjtm3BgyKQqOP1qN2SbomD79uT6x
         2t1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CcaW1nPaukhEXiXprBAQ1ypKp3C4X7MmOMiLijl8qRY=;
        b=PL+i3sAU9zV+H1DTxDNG13gJI9E8CDA7LsoJb0pgWsSArMDtIZr39ElD7zKnbPy4Nr
         4bSACwUGh+v0Pw5rTLe64FMPBONqDvXABuwB6HT06tMo0ErKORBfuY3oADaSonk8JX3+
         seIniyurSUIRzQGYorpCYtxo5bQHB8VTuFmXar+YfhXoLHjJw4ak8SVlaiKxmsBaZ4dx
         TOfDqdSdXTALhL12KFeF++x5Tu9UzCKK8s9kmSq7yJDxKx+7VHCFV4EexcB//abn44qp
         +EIlQMN9WLU10TEwBowlwdPrLXH+3fMck6K6BsxR5d0DK+C78rPcn7hCjQbL2k3aHvYc
         V31Q==
X-Gm-Message-State: AOAM530OsNUnDu2sWnRBeKGDW5RSht+ZjHmTwE4mlH+imH1LUCX1khl8
        iAEA/5YVu8PfOW+t334eRBqvxg==
X-Google-Smtp-Source: ABdhPJzelx4Y76P0iNMp6JW6A0mlHIxUhe07/iXKfwepzoJEeRJbMe37kwc1JYFZAe86JM88aIwkSg==
X-Received: by 2002:a05:620a:1391:: with SMTP id k17mr451254qki.274.1618665907188;
        Sat, 17 Apr 2021 06:25:07 -0700 (PDT)
Received: from pop-os.fios-router.home (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.googlemail.com with ESMTPSA id o25sm1988327qtl.37.2021.04.17.06.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Apr 2021 06:25:06 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        bjorn.andersson@linaro.org
Cc:     ebiggers@google.com, ardb@kernel.org, sivaprak@codeaurora.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [Patch v2 3/7] crypto: qce: Add mode for rfc4309
Date:   Sat, 17 Apr 2021 09:24:59 -0400
Message-Id: <20210417132503.1401128-4-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210417132503.1401128-1-thara.gopinath@linaro.org>
References: <20210417132503.1401128-1-thara.gopinath@linaro.org>
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

