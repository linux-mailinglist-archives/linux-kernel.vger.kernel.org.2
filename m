Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 743083B703E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 11:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232953AbhF2JrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 05:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232850AbhF2JrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 05:47:07 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 894CCC061574
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 02:44:40 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id x16so16682104pfa.13
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 02:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Egp2INH24GecpOyqDXmIt9wlO7BC40kEajevlBy0j3c=;
        b=KKfflM77Ww5SOuzT7DmT1GIeX0x5VOmSxBpbMVKSG367rvUR7Vs891hZ0rA8JD9LPN
         DILqKomfHn3hcFb271ORqCNsH8OeRsWvkJaHYPjsU3VqqDMAJZOL8SY0BDahznO0nkqP
         PJEd8dFPfBPPTfRTNpraJHZetghwEMyuu4Htk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Egp2INH24GecpOyqDXmIt9wlO7BC40kEajevlBy0j3c=;
        b=OHB/q8/osBtpfwm6bnJmPgMoqakwhwgAl8eqpwyeHt1YaU3AYBXMhg04TS6b2oYBtx
         m+7ZO22xkIXYm4gs9ktPd2rO31ZNX49v2WvxVPqR39yaQuqujXbyH5XrbSiVbqClJUN0
         6HEnZiiT91iZu2Xli0rpeso/e92zFguuk9+nKM1OaniV6dqII9Ujo3LrL7l5Xw1ef3D1
         Mi3xMNGhAnlIQRQVEx1+/ILvp4y6C7eIgviL5CtcAzPJ7Vi98+0v8nDkIg2M+JRX1urT
         mlDJdqeF8XuOAm0w4ACdZsMn53GqEUupJQ+5es+eGhb83O7nEE6qOrefF1fAZW8y/XWf
         L1Uw==
X-Gm-Message-State: AOAM530WDkKJOS7sVXm0/aip+se5GtzWcsr9etsp5zJi0ghMrwsv+uFd
        kPMPkLBBSmcELVr9zzwjVEnNyQ==
X-Google-Smtp-Source: ABdhPJxb1UAMqIPOICuhB0EY9ckYxXlb4L4WE5yeqXUyYXEGPBE1qDSui7jr01Ta0sSJ701ROVAxVw==
X-Received: by 2002:aa7:8090:0:b029:300:18db:4e11 with SMTP id v16-20020aa780900000b029030018db4e11mr28988541pff.22.1624959880119;
        Tue, 29 Jun 2021 02:44:40 -0700 (PDT)
Received: from fshao-glinux.tpe.corp.google.com ([2401:fa00:1:10:ebba:3e19:7691:d53e])
        by smtp.gmail.com with ESMTPSA id f15sm17891538pgg.23.2021.06.29.02.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 02:44:39 -0700 (PDT)
From:   Fei Shao <fshao@chromium.org>
To:     lee.jones@linaro.org
Cc:     Fei Shao <fshao@chromium.org>, Gene Chen <gene_chen@richtek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 2/2] mfd: mt6360: Restore error message to regmap_read failure
Date:   Tue, 29 Jun 2021 17:43:39 +0800
Message-Id: <20210629094339.874120-2-fshao@chromium.org>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
In-Reply-To: <20210629094339.874120-1-fshao@chromium.org>
References: <20210629094339.874120-1-fshao@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds back a missing error message for better log readability.

Fixes: e84702940613 ("mfd: mt6360: Fix flow which is used to check ic
exist")

Signed-off-by: Fei Shao <fshao@chromium.org>
---

 drivers/mfd/mt6360-core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/mt6360-core.c b/drivers/mfd/mt6360-core.c
index 6eaa6775b888..0ff8dae4536c 100644
--- a/drivers/mfd/mt6360-core.c
+++ b/drivers/mfd/mt6360-core.c
@@ -351,8 +351,10 @@ static int mt6360_check_vendor_info(struct mt6360_ddata *ddata)
 	int ret;
 
 	ret = regmap_read(ddata->regmap, MT6360_PMU_DEV_INFO, &info);
-	if (ret < 0)
+	if (ret < 0) {
+		dev_err(ddata->dev, "Failed to read device info from regmap\n");
 		return ret;
+	}
 
 	if ((info & CHIP_VEN_MASK) != CHIP_VEN_MT6360) {
 		dev_err(ddata->dev, "Device not supported\n");
-- 
2.32.0.93.g670b81a890-goog

