Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2EC03124CF
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 15:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbhBGOnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 09:43:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbhBGOly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 09:41:54 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1DA8C06121F
        for <linux-kernel@vger.kernel.org>; Sun,  7 Feb 2021 06:39:56 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id h21so5824869qvb.8
        for <linux-kernel@vger.kernel.org>; Sun, 07 Feb 2021 06:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H4BViZmMHUNQYYu9VpJJKST4ly897JCfdbGhTeJJKpE=;
        b=veORIMbTEFHdV2ZFA+S4kEqUqMfKyKjfNRJMTAEVlAONkV2h5bwCaHF3o9lCgPjfFb
         EJIYZZBFcFhsE+mnA4rdIKkppadaNlyCpp4ZoeiueOvoGJ+BBPJPpMCg/oopX/tMdU4k
         GorzXEKwPixX/LLKL6FbW4GPvfRshWd8T8J/Ak63guKJSWL5O/3Qycm+ti+q9y/vI4MB
         Km6FCq47E9QImjzb1P3QQlioEPjq5Cxlc+I3cRp61L2J8VI0wY+2UiZkXJ1zzl8R2GNt
         8vOXhAksSFd2wew/MXWwXO+9IZZmJMgDEz9+r8OALJUMCFp4p6aU9odGTWTH+6ZlnBKv
         O9/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H4BViZmMHUNQYYu9VpJJKST4ly897JCfdbGhTeJJKpE=;
        b=tjn5UtnkiR7p31/WBvydStbQKUVzgIWKRL9j9YWoiHC9Eto0aSDa9gtjtLSIhIGLvV
         r3lfZQZvzwJ3C7QBlcoMtaO5uwcAm+8rXGLg370fE7TJqSXfJyQo28NHG50xk6FScmh+
         JQzK1FSKb8Qr/MjDboFWCTZA1vPGLkjb9xrIpowrt8kyi7bR7A2p0Le31XydIrHzeyzo
         rECYq7m8Lg4du4mUXf1og47AepUFGH/brzNE3nXi94mi8NRa62X/J806MTLgr6g4xAdM
         OfbRy8CrDq/T5YNZy4mWUhqlMwtfQJqhs8kPILzXD55taOrv9mIWZSJQJTQbCcU9AN2/
         8KPQ==
X-Gm-Message-State: AOAM533YS6qmhg+FynEwsuWXeIjf2L2W7Dw1MLz9IZ7o4G9CtuylAnG/
        HHFfLC+qh6zaY8lmuAd3SvheRA==
X-Google-Smtp-Source: ABdhPJzeSgh2p+L/L8h1gjw16RyNB+thQjs39W/uAo60+eoIlMsLixTMZakTLAeIhiYcy6WxhKioLg==
X-Received: by 2002:a05:6214:1341:: with SMTP id b1mr12650305qvw.57.1612708796200;
        Sun, 07 Feb 2021 06:39:56 -0800 (PST)
Received: from pop-os.fios-router.home (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.googlemail.com with ESMTPSA id c81sm13941493qkb.88.2021.02.07.06.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Feb 2021 06:39:55 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        bjorn.andersson@linaro.org
Cc:     ebiggers@google.com, ardb@kernel.org, sivaprak@codeaurora.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 09/11] crypto: qce: common: Set data unit size to message length for AES XTS transformation
Date:   Sun,  7 Feb 2021 09:39:44 -0500
Message-Id: <20210207143946.2099859-10-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210207143946.2099859-1-thara.gopinath@linaro.org>
References: <20210207143946.2099859-1-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set the register REG_ENCR_XTS_DU_SIZE to cryptlen for AES XTS
transformation. Anything else causes the engine to return back
wrong results.

Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 drivers/crypto/qce/common.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/qce/common.c b/drivers/crypto/qce/common.c
index a73db2a5637f..f7bc701a4aa2 100644
--- a/drivers/crypto/qce/common.c
+++ b/drivers/crypto/qce/common.c
@@ -295,15 +295,15 @@ static void qce_xtskey(struct qce_device *qce, const u8 *enckey,
 {
 	u32 xtskey[QCE_MAX_CIPHER_KEY_SIZE / sizeof(u32)] = {0};
 	unsigned int xtsklen = enckeylen / (2 * sizeof(u32));
-	unsigned int xtsdusize;
 
 	qce_cpu_to_be32p_array((__be32 *)xtskey, enckey + enckeylen / 2,
 			       enckeylen / 2);
 	qce_write_array(qce, REG_ENCR_XTS_KEY0, xtskey, xtsklen);
 
-	/* xts du size 512B */
-	xtsdusize = min_t(u32, QCE_SECTOR_SIZE, cryptlen);
-	qce_write(qce, REG_ENCR_XTS_DU_SIZE, xtsdusize);
+	/* Set data unit size to cryptlen. Anything else causes
+	 * crypto engine to return back incorrect results.
+	 */
+	qce_write(qce, REG_ENCR_XTS_DU_SIZE, cryptlen);
 }
 
 static int qce_setup_regs_skcipher(struct crypto_async_request *async_req,
-- 
2.25.1

