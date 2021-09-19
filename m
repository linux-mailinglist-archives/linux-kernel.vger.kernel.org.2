Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D56DF410D71
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Sep 2021 23:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232615AbhISVNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Sep 2021 17:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbhISVNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Sep 2021 17:13:10 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 265CBC061574
        for <linux-kernel@vger.kernel.org>; Sun, 19 Sep 2021 14:11:45 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id f129so15371245pgc.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Sep 2021 14:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xYUcfWhUdZuh85e32IgUBDiou2vTR9MT2ExA/x9jGQo=;
        b=i9RDUCz7FMUDmPstW+A3ZyFX4Cv5AUAQNM7V+p2B6+/xxKF+FyO6ihLMQ3TwSIIRuv
         kASOGUdZa6hiV7pL1tR0Th5Q/YA+KccqF7fswOb7GSiOg7y1/6f4EGQJaIK3ZdHB0c+7
         qOjm3HHWuKewLv2Wv1DBh2lZ5ysAS7v7ySFPF/SZu1E3tTt7AIVdQbeC8D7sKKXywanM
         joRmbQ8aqVjo9PSGxAwR73U9U+w8Lmz16Jm2B3u5UKXiwjCjOwAuC0cMXYzRlWus5b4m
         TLnpemAM71GToDGssu380CA7aZE8hvRzFrTvkJQ+lGM+sHBNnerk/EtmSJseZb6ps97X
         /XSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xYUcfWhUdZuh85e32IgUBDiou2vTR9MT2ExA/x9jGQo=;
        b=Fz9MRW0e3EyX1xm1Nm5G5ZdndgW94wNzxnS02k0biEvPtAIWOBBX9NkCMM7ZvEOLEi
         VkzKjqrWUj+Y/1o6LW5H0K7Zv7Xa3mmh33Gq1v+EncOp1T8PX8O/a1zfitDQwtgwJttL
         COKIFJtvdAreDUsE+GOnrws00HuM4068pT9coG8CFuWY9367t7Evb9WJbFeFUajca3lQ
         I6rXjytkcgg606myZzSp42bBmgBSXzV52QluAYHTlctEtjF0dn6AqjirwMVvcPSXn3N5
         S1p8ipNIbK1CB+Llg6DwWuN2j5Wt5Kw97ZfC9rUKTP622xwabxsL8JTMyTZWXd8WGRQN
         veVw==
X-Gm-Message-State: AOAM533QYfQ+19vs0OELrABQoLKkScqmNe6RGM1RfjUSCh7aDtuxrUTF
        gCXPh9NQ9TXtjh8w+fMZLx4=
X-Google-Smtp-Source: ABdhPJx3ZyB5j+hqrEoO6Ya/OUKsB2JDkJGte0Vs6uQfGcLWrg644Fr7SnBQfvuZnetczpJDDNAfww==
X-Received: by 2002:a63:7447:: with SMTP id e7mr20756338pgn.46.1632085904720;
        Sun, 19 Sep 2021 14:11:44 -0700 (PDT)
Received: from archl-c2lm.. ([103.51.72.29])
        by smtp.gmail.com with ESMTPSA id j9sm13520565pjb.33.2021.09.19.14.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Sep 2021 14:11:44 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Anand Moon <linux.amoon@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH] regulator: pwm-regulator: Make use of the helper function dev_err_probe()
Date:   Sun, 19 Sep 2021 21:11:28 +0000
Message-Id: <20210919211129.4364-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

devm_regulator_register can return -EPROBE_DEFER if the
regulator is not ready yet. Use dev_err_probe() for
pwm regulator resources to indicate the deferral reason
when waiting for the resource to come up.

Fixes: 0cd71b9a43ad ("regulator: pwm: Don't warn on probe deferral")

Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/regulator/pwm-regulator.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/pwm-regulator.c b/drivers/regulator/pwm-regulator.c
index 7629476d94ae..451e57a739f8 100644
--- a/drivers/regulator/pwm-regulator.c
+++ b/drivers/regulator/pwm-regulator.c
@@ -382,9 +382,9 @@ static int pwm_regulator_probe(struct platform_device *pdev)
 					    &drvdata->desc, &config);
 	if (IS_ERR(regulator)) {
 		ret = PTR_ERR(regulator);
-		dev_err(&pdev->dev, "Failed to register regulator %s: %d\n",
-			drvdata->desc.name, ret);
-		return ret;
+		return dev_err_probe(&pdev->dev, ret,
+				     "Failed to register regulator %s: %d\n",
+				     drvdata->desc.name, ret);
 	}
 
 	return 0;
-- 
2.33.0

