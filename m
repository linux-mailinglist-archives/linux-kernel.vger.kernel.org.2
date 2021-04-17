Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20C1D36304B
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 15:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236473AbhDQNZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Apr 2021 09:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236306AbhDQNZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 09:25:32 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1A5C061756
        for <linux-kernel@vger.kernel.org>; Sat, 17 Apr 2021 06:25:06 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id h7so22903060qtx.3
        for <linux-kernel@vger.kernel.org>; Sat, 17 Apr 2021 06:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VcMAQ1EGbeesv8V+7yaxgvD6ypjuKCvSWavQ5LbGTMA=;
        b=HJklx3NmN3v5pM8kGfdNbm5n0eFqnc10Glfghb83pTbDpCrMYdPfZz4u4Bv2vHH83U
         VMDX1shkqN4rrDBBmHtap2Cqyv2nTXbd4Lg5fEBujY+6YExQHpoEFXtc1z6FA2rsd5js
         BQEjaQLOfkVpRyt5/v5p+yWUCgSw575N9FmQ5BtsB1qxb3rQHn8zvh4UUWTfTLUoGbz6
         itIj34CECkk0qnPmcoYGn8dnrxxXauKMaJ3wu0SY9OYlqKmWCIf3U54S13EIDvtDsjUL
         /5bof0+dO8U3AAsui0BDUKVVXdANhKngxPfGKPOcPO0I8iqTXHRAwHMdTS43BeF4uvgm
         b5cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VcMAQ1EGbeesv8V+7yaxgvD6ypjuKCvSWavQ5LbGTMA=;
        b=V/hFPED1LeVd5d4sx37pxBEXV78NxMoD4E0kgPOJYh4zrK1WfxWH2UQ107YQh2a5QS
         zIPpDSN3xV++JEceG4oDiIWwoR/ay+ruGfxWAv7DozG0fAGMMnme33kpYRQ8hldaM4Ey
         FvBc13EyYiry86Kunh4YLkIh0friPyrMDk3RW095o5xhEkR14K1Fl0fDuzqdc5hR+7wA
         xqVjhQ/R34XxKZ+wSB1wmUKep4yBgxAxlxa41DbnA4b4RS5wKH7Mw6wkUow1Pj/5EMGW
         43YWtil3XcYje+ez9bRLhzjk2ntq84sJhx9jssCBQJ5WnRtA/0+kqkOifAB/vesEEeO8
         yN1Q==
X-Gm-Message-State: AOAM531+aGceDEuXPBspvR17Nc00ROlbhrSYUdQiOmiGJHgV6VcHCGVC
        RWdOnycEgB71PqGGdg2c7Nu78g==
X-Google-Smtp-Source: ABdhPJx3FdLlhpGerzeCsNZOVNq0P81zG6Q0EqRRgjQRfNuHkBtZCwi8z8rJg8QXx94c9+y7tjHyPQ==
X-Received: by 2002:ac8:4411:: with SMTP id j17mr3793443qtn.109.1618665905302;
        Sat, 17 Apr 2021 06:25:05 -0700 (PDT)
Received: from pop-os.fios-router.home (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.googlemail.com with ESMTPSA id o25sm1988327qtl.37.2021.04.17.06.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Apr 2021 06:25:04 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        bjorn.andersson@linaro.org
Cc:     ebiggers@google.com, ardb@kernel.org, sivaprak@codeaurora.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [Patch v2 1/7] crypto: qce: common: Add MAC failed error checking
Date:   Sat, 17 Apr 2021 09:24:57 -0400
Message-Id: <20210417132503.1401128-2-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210417132503.1401128-1-thara.gopinath@linaro.org>
References: <20210417132503.1401128-1-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MAC_FAILED gets set in the status register if authenthication fails
for ccm algorithms(during decryption). Add support to catch and flag
this error.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---

v1->v2:
	- Split the error checking for -ENXIO and -EBADMSG into if-else clause
	  so that the code is more readable as per Bjorn's review comment.

 drivers/crypto/qce/common.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/crypto/qce/common.c b/drivers/crypto/qce/common.c
index dceb9579d87a..dd76175d5c62 100644
--- a/drivers/crypto/qce/common.c
+++ b/drivers/crypto/qce/common.c
@@ -419,6 +419,8 @@ int qce_check_status(struct qce_device *qce, u32 *status)
 	 */
 	if (*status & STATUS_ERRORS || !(*status & BIT(OPERATION_DONE_SHIFT)))
 		ret = -ENXIO;
+	else if (*status & BIT(MAC_FAILED_SHIFT))
+		ret = -EBADMSG;
 
 	return ret;
 }
-- 
2.25.1

