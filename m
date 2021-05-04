Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2FF372DB8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 18:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbhEDQNz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 12:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231809AbhEDQNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 12:13:42 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CCD8C061574
        for <linux-kernel@vger.kernel.org>; Tue,  4 May 2021 09:12:46 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id t11so12590442lfl.11
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 09:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TbWXoJHQ0uWHFVcBWf57QwZSLHYhmQWZi0APC0CkQ08=;
        b=gExKlqDoKgJalaIZaU8BM2x89Hb4Dohp9KedfOXruDPXVcWDkbMIubEXRTev60u9Th
         HcZRM3d7e8VDENDbx9lfI6MezGAisJxM1un5F/Yi1e2NR23HxAFVr0MsR2xpmDyh/tL8
         AEeIZn3rjHu66iBNPk3Dxe0fZ1LYs5keoyuEWGyNZAnb2ica6U0UeMr3NXzO35CiwVxi
         tsEszOaRd4F+OAR65+/pPl8pDiWdMZHW3pk+2xZOqB9Vp0l/GgNuBNWLE499L+A9Q+LJ
         Ku+PuQzagL5cp1qjHyUWmkt8mhIVkYt/L+FCAgIga1xTunlbn3N3Z9DAQwIJpighfA8X
         567A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TbWXoJHQ0uWHFVcBWf57QwZSLHYhmQWZi0APC0CkQ08=;
        b=NUrhh80asSy3UHROvZU4LDflGEJXcDcseErNh5pqGclVLw+TWeoOi6YrQ4NIBddyx7
         kl000/+4vxbQLQ+tzflVg/tCD/dOele59NzX0fSZvXjMapA6Imqrex7kT8pv2h7aGQtc
         vJ4MVIKkMFBltwzrAXvwsjS9we/bKIXodSsEt5ytRsj9nEf25hR6Z9nMPJShwrjNzV+m
         2vOmsodybTv/8rrOheA+hFLy9MHf/kSjqrgund6XPFmQyB98OuvCeXM5rFgAlmMcg639
         YZB7JV3N7SMb3QuIZpkJ1qoJARVF+DfkXKJMKgsTAOT5UJT5MSct77Ni6tO8UeYp3yC7
         vv+w==
X-Gm-Message-State: AOAM531nVA0lWk7+klIzHo8Mqi5LdOHirdLqClgsTWYadmWAvVcrAbsR
        CUfVIaI2xbP0c3MMc05NenaQOw==
X-Google-Smtp-Source: ABdhPJyvMw01Rzrp2T1AFFthQkcduusLKNZ1Zsiz/LYkrImYWZ59EDKdnOxO8rE7EoDsNLHKgHvDrA==
X-Received: by 2002:a19:ac4a:: with SMTP id r10mr17287804lfc.112.1620144765023;
        Tue, 04 May 2021 09:12:45 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-180-197.NA.cust.bahnhof.se. [98.128.180.197])
        by smtp.gmail.com with ESMTPSA id s20sm164193ljs.116.2021.05.04.09.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 09:12:44 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Avri Altman <avri.altman@wdc.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 06/11] mmc: core: Prepare mmc_send_cxd_data() to be re-used for additional cmds
Date:   Tue,  4 May 2021 18:12:17 +0200
Message-Id: <20210504161222.101536-7-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210504161222.101536-1-ulf.hansson@linaro.org>
References: <20210504161222.101536-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function mmc_send_cxd_data() sends a data read command of ADTC type and
prepares to receive an R1 response. To make it even more re-usable, let's
extend it with another in-parameter for the command argument. While at it,
let's also rename the function to mmc_send_adtc_data() as it better
describes its purpose.

Note that, this change doesn't add any new users of the function. Instead
that is done from subsequent changes.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/mmc_ops.c | 11 +++++------
 drivers/mmc/core/mmc_ops.h |  2 ++
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 653627fe02a3..b1da8f1950ee 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -252,9 +252,8 @@ mmc_send_cxd_native(struct mmc_host *host, u32 arg, u32 *cxd, int opcode)
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
@@ -265,7 +264,7 @@ mmc_send_cxd_data(struct mmc_card *card, struct mmc_host *host,
 	mrq.data = &data;
 
 	cmd.opcode = opcode;
-	cmd.arg = 0;
+	cmd.arg = args;
 
 	/* NOTE HACK:  the MMC_RSP_SPI_R1 is always correct here, but we
 	 * rely on callers to never use this with "native" calls for reading
@@ -311,7 +310,7 @@ static int mmc_spi_send_cxd(struct mmc_host *host, u32 *cxd, u32 opcode)
 	if (!cxd_tmp)
 		return -ENOMEM;
 
-	ret = mmc_send_cxd_data(NULL, host, opcode, cxd_tmp, 16);
+	ret = mmc_send_adtc_data(NULL, host, opcode, 0, cxd_tmp, 16);
 	if (ret)
 		goto err;
 
@@ -359,7 +358,7 @@ int mmc_get_ext_csd(struct mmc_card *card, u8 **new_ext_csd)
 	if (!ext_csd)
 		return -ENOMEM;
 
-	err = mmc_send_cxd_data(card, card->host, MMC_SEND_EXT_CSD, ext_csd,
+	err = mmc_send_adtc_data(card, card->host, MMC_SEND_EXT_CSD, 0, ext_csd,
 				512);
 	if (err)
 		kfree(ext_csd);
diff --git a/drivers/mmc/core/mmc_ops.h b/drivers/mmc/core/mmc_ops.h
index aca66c128804..2b1d730e56bf 100644
--- a/drivers/mmc/core/mmc_ops.h
+++ b/drivers/mmc/core/mmc_ops.h
@@ -26,6 +26,8 @@ int mmc_set_dsr(struct mmc_host *host);
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

