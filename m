Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8313D1CA3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 06:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbhGVDVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 23:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbhGVDVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 23:21:30 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CCE1C061757;
        Wed, 21 Jul 2021 21:02:06 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id j8-20020a17090aeb08b0290173bac8b9c9so2372918pjz.3;
        Wed, 21 Jul 2021 21:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=akS7G7fDQc5oV25QXxyh3Me7TqHga56qr6CDdV6HGtw=;
        b=JWnLRvtLH0VPMXgB74AG/X+a60TibxTftfCnqtAr8OO19cyL6NDKiKBABTBTsa4jsy
         rYleignu8hDrNmdP8ZRwrX9k/7c/T1jftkWm7+FqZR0FaI8+SvJP4A+Bf+dAk1ahctwL
         zqZYGu8NIS/ixGPTJrjxOgvhPtj0Sasz1NeFgr1XlsGfouYQ3d9tz2naVkAHIzErAK4d
         CjoO+RuW1i8pTSa+guFONfHSu6O5bVqt2BeCHuBtW4oy0+uK3GGdRJU9OXfpnSfDcKT2
         mNkPkG4Doeiwt15rPiMJVKURGWJU+oQroDD003Fm5iex3BpUT6UuS6PEmqQXrtSqHiwk
         hiXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=akS7G7fDQc5oV25QXxyh3Me7TqHga56qr6CDdV6HGtw=;
        b=kp13kpiTu8JJ/oLnApUrkmiMAHUPbsX0ZgWy5j54MJVI3ecBCTpj3ROjeIpph+dbVX
         V2PEIAXdNSptNkeTlOaLGYo2PJMS/INFPIINWhr1zSAm+OnirmGWCqNL/F7cIRzpI1tH
         DBPGbThkQDIB27YgHGm7u52QREKtcZWpnVYNrz8PooWqHrCOEg5l7U6NgEaHjUxLfsex
         /8AJHg5IaMnm2FNOZau8F4HwmgZWJyn7azYZ0cXAybotdY3fQWrRPC49UUV4EbZ0qk/6
         Z9OFuTqVFl0EIj5mthV56t9vAgrgux15MtHyZ980DtI3s7LwqUm+h2c1PoZARtXmYIL5
         tmSQ==
X-Gm-Message-State: AOAM533jc8y+V7UKdQTq+2QZqRqdaPy6YgxNLTBJOpyKWIxCZTgreI7v
        l5T7c5z/yVoojcIA1iqC9D0=
X-Google-Smtp-Source: ABdhPJz5Y+1ld9SHZMbvb414AkqLe+C3TYkNqg1q/QqU0XRaDjsB8cHJJImBl9cEMWlWcVfVeAbrwg==
X-Received: by 2002:a63:f00d:: with SMTP id k13mr39693451pgh.260.1626926525697;
        Wed, 21 Jul 2021 21:02:05 -0700 (PDT)
Received: from jason-z170xgaming7.mshome.net (218-35-143-223.cm.dynamic.apol.com.tw. [218.35.143.223])
        by smtp.gmail.com with ESMTPSA id c19sm1663479pfp.184.2021.07.21.21.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 21:02:05 -0700 (PDT)
From:   Jason Lai <jasonlai.genesyslogic@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw,
        jason.lai@genesyslogiv.com.tw,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [RFC PATCH v3.2 07/29] mmc: core: UHS-II support, set APP_CMD bit if necessary
Date:   Thu, 22 Jul 2021 12:01:02 +0800
Message-Id: <20210722040124.7573-7-jasonlai.genesyslogic@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210722040124.7573-1-jasonlai.genesyslogic@gmail.com>
References: <20210722040124.7573-1-jasonlai.genesyslogic@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In UHS-II mode, MMC_APP_CMD command need not to be sent.
Instead, APP_CMD bit in a packet should be set.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 drivers/mmc/core/sd_ops.c | 9 +++++++++
 drivers/mmc/core/uhs2.c   | 4 ++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/mmc/core/sd_ops.c b/drivers/mmc/core/sd_ops.c
index baa05a6a36c4..279d676cd5e6 100644
--- a/drivers/mmc/core/sd_ops.c
+++ b/drivers/mmc/core/sd_ops.c
@@ -26,6 +26,15 @@ int mmc_app_cmd(struct mmc_host *host, struct mmc_card *card)
 	if (WARN_ON(card && card->host != host))
 		return -EINVAL;

+	/* UHS2 packet has APP bit so only set APP_CMD flag here.
+	 * Will set the APP bit when assembling UHS2 packet.
+	 */
+	if (host->flags &  MMC_UHS2_SUPPORT &&
+	    host->flags & MMC_UHS2_INITIALIZED) {
+		host->flags |= MMC_UHS2_APP_CMD;
+		return 0;
+	}
+
 	cmd.opcode = MMC_APP_CMD;

 	if (card) {
diff --git a/drivers/mmc/core/uhs2.c b/drivers/mmc/core/uhs2.c
index 1f6d0e0cf355..c0d61e7d9e4b 100644
--- a/drivers/mmc/core/uhs2.c
+++ b/drivers/mmc/core/uhs2.c
@@ -835,6 +835,10 @@ int uhs2_prepare_sd_cmd(struct mmc_host *host, struct mmc_request *mrq)
 		header |= UHS2_PACKET_TYPE_CCMD;

 	arg = cmd->opcode << UHS2_SD_CMD_INDEX_POS;
+	if (host->flags & MMC_UHS2_APP_CMD) {
+		arg |= UHS2_SD_CMD_APP;
+		host->flags &= ~MMC_UHS2_APP_CMD;
+	}

 	uhs2_cmd = cmd->uhs2_cmd;
 	payload = uhs2_cmd->payload;
--
2.32.0

