Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF1AB3BA217
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 16:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232985AbhGBOYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 10:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232726AbhGBOYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 10:24:34 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F075C061762
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jul 2021 07:22:02 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id 67-20020a17090a0fc9b02901725ed49016so3266510pjz.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jul 2021 07:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LLyiXBRytwa/KX87QfGpWD6i8lQbUDmQ89vq7Dciep0=;
        b=h45Te8Su5tQ4M5/XKj+htL9DakKPj5hxB2r/2Sfh3FONMfiWAV/W8bKhHi0i8OLXFk
         8ZS4mxSSS19xegeJszQxyUw6XemPbESDKeZD3nRWGJ/Vyd29cW/pbAC0XQ37qXlxLjz/
         6yg0PG5r4eY0ohawwXcv/ygPzShIBwwl+KI01SJiGoagM1B/quDHL0JVikuKyL/5GsWG
         pZulYm0PvEdgg9fCUU09SBJISos5a46Bacf6noAus+aponJqVEGjzVgNW1uz0yKymxF/
         61jgI7i60DBfu85Eqnyfok1Nq3LYP/BJAyVZIRnJnoONUA9c5OCykcfPmxQOZuvOP4aF
         3IiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LLyiXBRytwa/KX87QfGpWD6i8lQbUDmQ89vq7Dciep0=;
        b=eK45aQevJw6C+5V0emwl+Mk6NBDgQCiOTLeBqrbY2JkIkc4KZgArDGnpGX/wLe823+
         v2swrh9Y0+x81uMjIRcMaNe8jcBIJfWno/iNqd02Nbek2e1cHLrck+0mgmYOLaffO/Y1
         gUQ/Ey2eApEVQFGiy9qF5+59Nc8ubjz2kUo3ZBa/4/MATZ17SJ2FIAd1QlW9Pe8t0+v8
         UBWiCXg4L3aIOsuZ9OkRyF67rlEr0E51rF0fzKoI5XW0m4QmzQkGMPnK5s9M+Q4EI1fq
         WE1EaO/++07awiyzHEYdBlMqudYYU/EM0Hs7DRuvNy+AEqpPyOzUqL9QZ2e+e+xRYMqv
         K1uA==
X-Gm-Message-State: AOAM533RpN1JaJW/ZUOufAee9qWJkQfYCESnv/ad2PoNwMpIJx9twO0u
        Rsap+DnXPLpOtVUetoiBAy88VQ==
X-Google-Smtp-Source: ABdhPJxMuvypfVbLtKDMfWpThhq9vF234lyb+dahtuMwJHzTH9rTgPUc52YD/j/AOAv/OrtP9LadSA==
X-Received: by 2002:a17:902:7fc3:b029:128:c222:a745 with SMTP id t3-20020a1709027fc3b0290128c222a745mr77674plb.56.1625235721516;
        Fri, 02 Jul 2021 07:22:01 -0700 (PDT)
Received: from localhost.localdomain (122-117-179-2.HINET-IP.hinet.net. [122.117.179.2])
        by smtp.gmail.com with ESMTPSA id 133sm3882755pfx.39.2021.07.02.07.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 07:22:00 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Henry Chen <henryc.chen@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH RFT] regulator: mtk-dvfsrc: Fix wrong dev pointer for devm_regulator_register
Date:   Fri,  2 Jul 2021 22:21:40 +0800
Message-Id: <20210702142140.2678130-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If use dev->parent, the regulator_unregister will not be called when this
driver is unloaded. Fix it by using dev instead.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/mtk-dvfsrc-regulator.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/regulator/mtk-dvfsrc-regulator.c b/drivers/regulator/mtk-dvfsrc-regulator.c
index d3d876198d6e..234af3a66c77 100644
--- a/drivers/regulator/mtk-dvfsrc-regulator.c
+++ b/drivers/regulator/mtk-dvfsrc-regulator.c
@@ -179,8 +179,7 @@ static int dvfsrc_vcore_regulator_probe(struct platform_device *pdev)
 	for (i = 0; i < regulator_init_data->size; i++) {
 		config.dev = dev->parent;
 		config.driver_data = (mt_regulators + i);
-		rdev = devm_regulator_register(dev->parent,
-					       &(mt_regulators + i)->desc,
+		rdev = devm_regulator_register(dev, &(mt_regulators + i)->desc,
 					       &config);
 		if (IS_ERR(rdev)) {
 			dev_err(dev, "failed to register %s\n",
-- 
2.25.1

