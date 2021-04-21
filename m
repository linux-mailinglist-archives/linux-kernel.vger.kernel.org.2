Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A278B366945
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 12:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235295AbhDUKc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 06:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234409AbhDUKco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 06:32:44 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E75C06138B
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 03:32:10 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 12so65909080lfq.13
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 03:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3W0ReYXRDLZ9Zk92wTxQ+mDg4oUgh0CQC6EcZq5vXt8=;
        b=GhiCkljrdNvqz8QU4hX9Tvnr6q+NsiDe277dOmS8cRYIm9XTToYEn/exylT2vI4HH8
         Za7AV2XxPytEAmwzvjr7ZyDSom3b6sxdkds7uiS30xeBbmF1+g47zPMDbeJPFLk0y5xf
         HkeETLlOTg140sM+6GzQKfTBjuGTyF1Xd9uJ2S4TXKyG+Z3be5Xb9nh4Kt7GQT6C7G/0
         0d+EK4IMoctJ6f/fN0aJTtoDrl875CeUsHv2qzKnzFR+GOHM8tB/bACK+l/9V9qAsCtZ
         gxH9W93t96yVTYi1kW4sHrgCdUmdF76PtXEB8V3OxBrkvcKwOwGSuZS1dp7IhwOFx48J
         fEAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3W0ReYXRDLZ9Zk92wTxQ+mDg4oUgh0CQC6EcZq5vXt8=;
        b=YJ/V4rSdEfvoplcSV5LpLC0PJjw194ysC4Q5bZ5Lf4J2Q7mCVwsQKQTdDoXYDF3HCt
         P6QnIgj2yU0KpZQ4tjoilES8xFUsedLgzS3tdn46NbwhT8UfJKdmrVcS8DsZ/PXHEa2m
         sM5eqfPLzY2/krfIcAmw/FJK+LnMY/Ork/KSRnfAYeiED+Z5um9XhqwGEz6RsHCDl8kP
         7ZL6myKmIiAp6pKYUO/n+QpTKxWP4WJ17GXlivB/ptT9WOgesbqNt2Fb/p/Y97UxVJu0
         iybD/ypbatdgQlQaYtv+k6u+/sN3Cpo6OzCNEULUc0E9reMnbogxWcy4fu8u86D27Aqc
         cLuA==
X-Gm-Message-State: AOAM533Fg/yJbXAiBC6kmQ5ki3M9J0yClazsBxcftdtzCN+IB/XOm4GO
        EY1bqkQOov7aNxXpYvZsjkljcA==
X-Google-Smtp-Source: ABdhPJxFQ8YxIK3vd8BtH0GSoGH0VjymzL2Lks/uZpkaUbebB0LOmNrGQQvoVoVZIOUEfTpknokAOw==
X-Received: by 2002:a05:6512:b8f:: with SMTP id b15mr20669206lfv.633.1619001129306;
        Wed, 21 Apr 2021 03:32:09 -0700 (PDT)
Received: from localhost.localdomain (h-155-4-129-234.NA.cust.bahnhof.se. [155.4.129.234])
        by smtp.gmail.com with ESMTPSA id u13sm170603lfg.139.2021.04.21.03.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 03:32:08 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Shawn Lin <shawn.lin@rock-chips.com>,
        Avri Altman <avri.altman@wdc.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] mmc: core: Prepare mmc_send_cxd_data() to be used for CMD48 for SD cards
Date:   Wed, 21 Apr 2021 12:31:52 +0200
Message-Id: <20210421103154.169410-3-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210421103154.169410-1-ulf.hansson@linaro.org>
References: <20210421103154.169410-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CMD48 is used to read the SD function extension registers, which is an
ADTC type of command with an R1 response. It's very similar to the commands
that are currently being managed via mmc_send_cxd_data().

Therefore, let's adapt mmc_send_cxd_data() so it can manage CMD48 as well.
While at it, let's also rename the function to mmc_send_adtc_data() as it
better describes its purpose.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/mmc_ops.c | 11 +++++------
 drivers/mmc/core/mmc_ops.h |  2 ++
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index aa6a85783723..148fdc528382 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -245,9 +245,8 @@ mmc_send_cxd_native(struct mmc_host *host, u32 arg, u32 *cxd, int opcode)
  * NOTE: void *buf, caller for the buf is required to use DMA-capable
  * buffer or on-stack buffer (with some overhead in callee).
  */
-static int
-mmc_send_cxd_data(struct mmc_card *card, struct mmc_host *host,
-		u32 opcode, void *buf, unsigned len)
+int mmc_send_adtc_data(struct mmc_card *card, struct mmc_host *host, u32 opcode,
+		       u32 args, void *buf, unsigned len)
 {
 	struct mmc_request mrq = {};
 	struct mmc_command cmd = {};
@@ -258,7 +257,7 @@ mmc_send_cxd_data(struct mmc_card *card, struct mmc_host *host,
 	mrq.data = &data;
 
 	cmd.opcode = opcode;
-	cmd.arg = 0;
+	cmd.arg = args;
 
 	/* NOTE HACK:  the MMC_RSP_SPI_R1 is always correct here, but we
 	 * rely on callers to never use this with "native" calls for reading
@@ -304,7 +303,7 @@ static int mmc_spi_send_cxd(struct mmc_host *host, u32 *cxd, u32 opcode)
 	if (!cxd_tmp)
 		return -ENOMEM;
 
-	ret = mmc_send_cxd_data(NULL, host, opcode, cxd_tmp, 16);
+	ret = mmc_send_adtc_data(NULL, host, opcode, 0, cxd_tmp, 16);
 	if (ret)
 		goto err;
 
@@ -352,7 +351,7 @@ int mmc_get_ext_csd(struct mmc_card *card, u8 **new_ext_csd)
 	if (!ext_csd)
 		return -ENOMEM;
 
-	err = mmc_send_cxd_data(card, card->host, MMC_SEND_EXT_CSD, ext_csd,
+	err = mmc_send_adtc_data(card, card->host, MMC_SEND_EXT_CSD, 0, ext_csd,
 				512);
 	if (err)
 		kfree(ext_csd);
diff --git a/drivers/mmc/core/mmc_ops.h b/drivers/mmc/core/mmc_ops.h
index 5782fdf4e8e9..55b8ad1d004c 100644
--- a/drivers/mmc/core/mmc_ops.h
+++ b/drivers/mmc/core/mmc_ops.h
@@ -25,6 +25,8 @@ int mmc_set_dsr(struct mmc_host *host);
 int mmc_go_idle(struct mmc_host *host);
 int mmc_send_op_cond(struct mmc_host *host, u32 ocr, u32 *rocr);
 int mmc_set_relative_addr(struct mmc_card *card);
+int mmc_send_adtc_data(struct mmc_card *card, struct mmc_host *host, u32 opcode,
+		       u32 args, void *buf, unsigned len);
 int mmc_send_csd(struct mmc_card *card, u32 *csd);
 int __mmc_send_status(struct mmc_card *card, u32 *status, unsigned int retries);
 int mmc_send_status(struct mmc_card *card, u32 *status);
-- 
2.25.1

