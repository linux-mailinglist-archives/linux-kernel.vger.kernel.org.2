Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8833BC354
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 22:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbhGEUPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 16:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbhGEUPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 16:15:07 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E3FC061574
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jul 2021 13:12:29 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id h6so26020535ljl.8
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jul 2021 13:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6yDwF3xJ6uKq9R8h2XYuJ4l+Q6LPg2Woh9j1XtGjc+Q=;
        b=AKWFLsIdim8CYTMHyHvDif4WM/2IW8USa0qU/KweaRACbeRYJ4HlS18KDpgV6tbHef
         w/VuwOPS06/47hY2kG3Qe6sVDS2kVRRR5bo9rOKpRCyNrWTH/LbZfsIeRBK/M/fsbKMc
         vqwLX46ZMP1L3qlzkoP19uwKgWWWvI6Kyf7oJbqmiIRalztPf+yJ9lum3kao07xL85HD
         QcxJPshjWlR1UWY2u3LDYeLjJ95uepfk/DpCLXCTlyPvWCoQFQxpCJViG9p/cjKRmjnk
         48EkMGj2R6HbELhjDK0eLQKicrqGe2pO5eHDC749aApNsVnfOU7WKQYA7VmuTSoRu4ES
         6cIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6yDwF3xJ6uKq9R8h2XYuJ4l+Q6LPg2Woh9j1XtGjc+Q=;
        b=ftxKA9HDsvHhAeVsJH2+10lr84v66y/WJly//ogVa5zslcf/nGnjGPZhvGuw2PqnLJ
         35VrwUb4LEnbH7wMq9JhpGFJ18KUG+YxEsq0+crot+hSwZvsyQWj4THo0/xTlkIe6Zgc
         dVIBnHaeI+W4EGKoQqheNPqEEI6gC7iy8+OIap2E3CXqy/GPQ1A8n7bZ1aR6QSKcTwwL
         REZWpV05OmmAWzCN5NuUpHtyWU4ZzRraA4AZv9b4qDp31rBvqHL0IGwazAN7nK9k1Ty2
         8hThspZz/O++I++1UBsDrqIyjRA3q1AyfEzVUvpEvJS6Fr23kc2sf5V38NwFpYXNGwZT
         XQ+Q==
X-Gm-Message-State: AOAM530joObT87niFptDOmRteic3Pb6jH0p1BPbl/e+Y7vPde2yhp7Iz
        2rTCsSV8yS0Q0rjA53zRB1E=
X-Google-Smtp-Source: ABdhPJwajx6iHpQrkLrmNXtaApzk0iGhFPVTQmrWPq2Qg4QCj1WsMnhDx9DrLR68wMwEmny+FDO/rw==
X-Received: by 2002:a2e:557:: with SMTP id 84mr12417499ljf.211.1625515947575;
        Mon, 05 Jul 2021 13:12:27 -0700 (PDT)
Received: from localhost.localdomain (94-29-37-113.dynamic.spd-mgts.ru. [94.29.37.113])
        by smtp.gmail.com with ESMTPSA id h8sm928117lfe.35.2021.07.05.13.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 13:12:27 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Matt Merhar <mattmerhar@protonmail.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v1] regulator: tps65910: Silence deferred probe error
Date:   Mon,  5 Jul 2021 23:12:11 +0300
Message-Id: <20210705201211.16082-1-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TPS65910 regulator now gets a deferred probe until supply regulator is
registered. Silence noisy error message about the deferred probe.

Fixes: aea6cb99703e ("regulator: resolve supply after creating regulator")
Reported-by: Matt Merhar <mattmerhar@protonmail.com> # Ouya T30
Tested-by: Matt Merhar <mattmerhar@protonmail.com> # Ouya T30
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/regulator/tps65910-regulator.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/regulator/tps65910-regulator.c b/drivers/regulator/tps65910-regulator.c
index 1d5b0a1b86f7..06cbe60c990f 100644
--- a/drivers/regulator/tps65910-regulator.c
+++ b/drivers/regulator/tps65910-regulator.c
@@ -1211,12 +1211,10 @@ static int tps65910_probe(struct platform_device *pdev)
 
 		rdev = devm_regulator_register(&pdev->dev, &pmic->desc[i],
 					       &config);
-		if (IS_ERR(rdev)) {
-			dev_err(tps65910->dev,
-				"failed to register %s regulator\n",
-				pdev->name);
-			return PTR_ERR(rdev);
-		}
+		if (IS_ERR(rdev))
+			return dev_err_probe(tps65910->dev, PTR_ERR(rdev),
+					     "failed to register %s regulator\n",
+					     pdev->name);
 
 		/* Save regulator for cleanup */
 		pmic->rdev[i] = rdev;
-- 
2.32.0

