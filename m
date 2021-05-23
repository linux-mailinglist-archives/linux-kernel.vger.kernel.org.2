Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6004138DD9C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 00:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232056AbhEWWpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 May 2021 18:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231979AbhEWWo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 May 2021 18:44:59 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DAE5C06138A;
        Sun, 23 May 2021 15:43:19 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 131so31078959ljj.3;
        Sun, 23 May 2021 15:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vo7Y/USVXA7FdLoJDS1IuqZi56jT5xVRIvIbv9vjjrY=;
        b=ZTKMDUMVQW5ZtcLbkAl+ABOU7znqhxlG9djSFAZ0yHR0pCSpmNuHutbnrikmRGblvV
         t3xBUaG9SN2Ybds0kFeH36C9nf5dodX8I/EL/GIfQ/78Q3/Co1wjtaHub5u1gylOGMcw
         xrIzyVSSqA4CQqBwRGxTKJGc3IDn/44clQfCwkh0cV3naHqY4i2nujT7FH5w/Et48EFV
         rn3/49F52yrKIyV7oKpsy8C49OZ5adqK+2Pw0L0bHRvVL7t1HiaXWhLFTkc1ma5BTeEs
         zjDU6/N3Y9zeH8xDxAQWv+euo7Ni+H4xahXKL5Hbm3144zmPBdxOeF79DnzszhwtI/W0
         suVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vo7Y/USVXA7FdLoJDS1IuqZi56jT5xVRIvIbv9vjjrY=;
        b=sxG76Da3oDHh1AAcGX8zIrDmyZBCD8EVqtVIKjBfJERXVOAsUtumHwgvuZTUWJfFa6
         QRBEplsMKi7yRNar97kKQGuK0HNh2IUTItzdrbtKktNvQ8a9DHqrCTi8vMfKdYA9F74P
         aIfC3mj7pWWtAjrPT6IuIM/NUTcF1HxR/z32zc2XmirMeBd4xk9txNJI+EWLOgS6wOTM
         OHTs040jY2jV9Sxke4/DKaQw2nTxBeePBdBMaxelFJxmyxVpWIhP8lOQ66OILbwIvknR
         BmhWcafbXbNmFikI58Rf+0FNWjY+ND16y2YeLGzvxr68Px4ekyJKJHarPaOs7aolqbk+
         er+g==
X-Gm-Message-State: AOAM5319jJxLSnCudTrSIr9dMSCFo/vl8yR8+o66zJtGbLPhgxg027TZ
        Vyl29IFUKHeSu/IbMJ6lRtZAOG8Rch8=
X-Google-Smtp-Source: ABdhPJxd5j62YTvZHuQZFBYMGzWjQsayY8QrxGugVE8YwcafkvrcLv8bULqBUiTmPpWVpH43PcPV5w==
X-Received: by 2002:a05:651c:232:: with SMTP id z18mr15167885ljn.489.1621809797465;
        Sun, 23 May 2021 15:43:17 -0700 (PDT)
Received: from localhost.localdomain (109-252-193-110.dynamic.spd-mgts.ru. [109.252.193.110])
        by smtp.gmail.com with ESMTPSA id m5sm1531622ljg.118.2021.05.23.15.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 May 2021 15:43:17 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH v1 2/2] regulator: max77620: Silence deferred probe error
Date:   Mon, 24 May 2021 01:42:43 +0300
Message-Id: <20210523224243.13219-3-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210523224243.13219-1-digetx@gmail.com>
References: <20210523224243.13219-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One of previous changes to regulator core causes PMIC regulators to
re-probe until supply regulator is registered. Silence noisy error
message about the deferred probe.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/regulator/max77620-regulator.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/regulator/max77620-regulator.c b/drivers/regulator/max77620-regulator.c
index 5c439c850d09..3cf8f085170a 100644
--- a/drivers/regulator/max77620-regulator.c
+++ b/drivers/regulator/max77620-regulator.c
@@ -846,12 +846,10 @@ static int max77620_regulator_probe(struct platform_device *pdev)
 			return ret;
 
 		rdev = devm_regulator_register(dev, rdesc, &config);
-		if (IS_ERR(rdev)) {
-			ret = PTR_ERR(rdev);
-			dev_err(dev, "Regulator registration %s failed: %d\n",
-				rdesc->name, ret);
-			return ret;
-		}
+		if (IS_ERR(rdev))
+			return dev_err_probe(dev, PTR_ERR(rdev),
+					     "Regulator registration %s failed\n",
+					     rdesc->name);
 	}
 
 	return 0;
-- 
2.30.2

