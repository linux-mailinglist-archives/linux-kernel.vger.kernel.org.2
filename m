Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0B632545F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 18:08:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233404AbhBYRIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 12:08:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233965AbhBYRG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 12:06:27 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDDA1C06178B
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 09:04:11 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id v5so9577110lft.13
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 09:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZVkhv4WLhPkQvvBDaC3A5L+BewGJsj7lWC/5+KaE4JA=;
        b=enfH8oFi28/hppzGCOifB4bJ74Bb94E6Vdwi3GjeNdzdskpS8ek8FB//2Rx3r/LI2M
         8ngLNnIPsl1aGROSv4rIFHPg8s3mkN30n6yj0PaQ778NMwlmYeIoKJ+BovJTOnzx8NJh
         GpjkeSCCZ6/UpLIWQgF1y6mA3cjgZwEgpKZy3DXcOokdftd1jlxBL+FRxH58cgfuEzJV
         bfDXkCpbXdLAztgtCwIqlSQ/3RpU0cOSiBIdD829qkhBN0TUR3lRx78unnA84Uwn4Wr/
         z0xWPQgRXOFW4zqUrtbZTGuiUCXtaz2MQUUETBE2p1hq/KZwb/a4CHCzvqhLKaMjVsPU
         ODLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZVkhv4WLhPkQvvBDaC3A5L+BewGJsj7lWC/5+KaE4JA=;
        b=P+XEnOYfOfH3Ki8kEoeMC9Ks1PBcqY4y5tg1TuT3M4opgUPImBoGgxR4Gbmx5ZNGuV
         kErPic1LDLL/t5LuPAE34KmuIRPjaPsRkc1ZQh4vTy9lH2quaQzaqobhuoW6MJ3wjcBP
         5nlFwZz5MLqVA39EWy3Am+rfBf5kkO6mrAMMJrzBPxlNNLlT16nyQI1YR12cBLQ+aAHW
         U46c8+M5a7ZuR0vwsMbvCTrltC5ew527FvCkQb6n7M6a36MMYNcVzTEMRxbTGBqZqgzF
         pFgBMNVkyA6n+j8Xxq6+JhRZsCH3mSD+NMZwgQM7QSv8RM2BEqOQmGB0R9T8MLx11zeo
         JfEA==
X-Gm-Message-State: AOAM5336QLyCdBMNkjCiBGFn6DKcmc2gaU8PgngHiaHJbhRuOpNgzQyU
        pOFE2Umi6uiJ06SDuQh+4Fz1JA==
X-Google-Smtp-Source: ABdhPJwBIn7qT2kk2z7x3v+0WSkxq4k+EqeVr0wX0+WBr8fHtR6BnMS1BIclwvkAmlKvish5zY1rvg==
X-Received: by 2002:a05:6512:131f:: with SMTP id x31mr2485503lfu.552.1614272650258;
        Thu, 25 Feb 2021 09:04:10 -0800 (PST)
Received: from localhost.localdomain (h-155-4-129-234.NA.cust.bahnhof.se. [155.4.129.234])
        by smtp.gmail.com with ESMTPSA id b39sm1103749ljf.68.2021.02.25.09.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 09:04:09 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        greg.tu@genesyslogic.com.tw, Renius Chen <reniuschengl@gmail.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Takao Orito <orito.takao@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] mmc: core: Announce successful insertion of an SD UHS-II card
Date:   Thu, 25 Feb 2021 18:03:51 +0100
Message-Id: <20210225170352.76872-4-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210225170352.76872-1-ulf.hansson@linaro.org>
References: <20210225170352.76872-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To inform the users about SD UHS-II cards, let's extend the print at card
insertion with a "UHS-II" substring. Within this change, it seems
reasonable to convert from using "ultra high speed" into "UHS-I speed", for
the UHS-I type, as it should makes it more clear.

Note that, the new print for UHS-II cards doesn't include the actual
selected speed mode. Instead, this is going to be added from subsequent
change.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/bus.c  | 4 +++-
 drivers/mmc/core/host.h | 5 +++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
index f4851ec8290c..887b0b80ac3f 100644
--- a/drivers/mmc/core/bus.c
+++ b/drivers/mmc/core/bus.c
@@ -353,7 +353,9 @@ int mmc_add_card(struct mmc_card *card)
 	if (mmc_card_hs(card))
 		speed_mode = "high speed ";
 	else if (mmc_card_uhs(card))
-		speed_mode = "ultra high speed ";
+		speed_mode = "UHS-I speed ";
+	else if (mmc_card_uhs2(card))
+		speed_mode = "UHS-II speed ";
 	else if	(mmc_card_ddr52(card))
 		speed_mode = "high speed DDR ";
 	else if (mmc_card_hs200(card))
diff --git a/drivers/mmc/core/host.h b/drivers/mmc/core/host.h
index ba407617ed23..76cb024a0868 100644
--- a/drivers/mmc/core/host.h
+++ b/drivers/mmc/core/host.h
@@ -83,5 +83,10 @@ static inline bool mmc_card_sd_express(struct mmc_host *host)
 		host->ios.timing == MMC_TIMING_SD_EXP_1_2V;
 }
 
+static inline bool mmc_card_uhs2(struct mmc_card *card)
+{
+	return card->host->ios.timing == MMC_TIMING_SD_UHS2;
+}
+
 #endif
 
-- 
2.25.1

