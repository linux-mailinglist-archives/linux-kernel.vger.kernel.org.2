Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA233823B2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 07:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234271AbhEQF2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 01:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234074AbhEQF2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 01:28:47 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CB13C061573
        for <linux-kernel@vger.kernel.org>; Sun, 16 May 2021 22:27:31 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id gc22-20020a17090b3116b02901558435aec1so3021490pjb.4
        for <linux-kernel@vger.kernel.org>; Sun, 16 May 2021 22:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wQS67suSf0G276D1wZcLh2Jza71dQA+sZCZqztMfOYM=;
        b=CNGqfWd6TVsRza2u2DO42LkrhZnTtTb8LKY8jbRbkGFN0QCHrjBOTGJNsR7sI2jro4
         RwkIhTcRODgnkWPVE69N+rf7evKhd4bqshBw1NSFWhciDIpGxCQTJfY2KsmuS7cph6yD
         gdAdiKfnuDb69thTA5CcKOV6krr78KD6c3dS6nPdk5jhhdPqIs8J9mjxHTZBPkAU9zh5
         0FXgw9bxcENnWsOsVYpq0PzwhnMh4yWQkLqWuvJsSYDx0tYloqn3n/9sIR8qNnNtsi31
         HLaTAZjgtztdcQG9BFSjw/vZLv/QnK3AkrwnmudCAkZyc7iMCQ/z82sRcpQCyC/6yzLd
         KKBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wQS67suSf0G276D1wZcLh2Jza71dQA+sZCZqztMfOYM=;
        b=agmiLAZI+pZ2S48lFed08QEodjTiFXgEbyu7UH6BLUw0BUoAj+iTF59v4t8Bap9h4A
         p/JPzTqqvJAWw8NXWOsm/qOqOIPfT1LoLWsSh+kbB+fS2ottftEYVsK0XtCAlQX8TddF
         sD3fexFyyMyW8C6mpKbT1blq/qGnvhLWFbsSp3IEQr87afjrUMMHqL9a0IV/V/7eLrKT
         XuTj5DwOKTO+386hUYWWG3bOgnxuH7jfgmtzSRs0avwBNhW7cA8iLPuuMJOobqA1AzAI
         /Nv72B+mGdXQgc+ZH0vdM/ikhG2uEFgZgKVmG2aij6yWmW80rAvW5l/IW1whsVMWs/dN
         L4hA==
X-Gm-Message-State: AOAM533JcEpSydDb+IzO+2vT0xSf6enmCIPpj3fQ9KFDGHic/VtCxKtY
        ZPiJM1HmfwRhbuNvmrlbwVr25N6WSilauWW7
X-Google-Smtp-Source: ABdhPJyQGxrmXLcZ5xfPZrLuvOK/r/WRN6Q1SsIHwvWeXLCHZF/3iezkKT9n95aITVH8e4Cnj1lDzg==
X-Received: by 2002:a17:90a:5406:: with SMTP id z6mr8875590pjh.130.1621229251139;
        Sun, 16 May 2021 22:27:31 -0700 (PDT)
Received: from localhost.localdomain (122-117-179-2.HINET-IP.hinet.net. [122.117.179.2])
        by smtp.gmail.com with ESMTPSA id g29sm9239275pgm.11.2021.05.16.22.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 May 2021 22:27:30 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Adam Ward <Adam.Ward.opensource@diasemi.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: da9121: Return REGULATOR_MODE_INVALID for invalid mode
Date:   Mon, 17 May 2021 13:27:21 +0800
Message-Id: <20210517052721.1063375-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-EINVAL is not a valid return value for .of_map_mode, return
REGULATOR_MODE_INVALID instead.

Fixes: 65ac97042d4e ("regulator: da9121: add mode support")
Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/da9121-regulator.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/da9121-regulator.c b/drivers/regulator/da9121-regulator.c
index 08cbf688e14d..e66925090258 100644
--- a/drivers/regulator/da9121-regulator.c
+++ b/drivers/regulator/da9121-regulator.c
@@ -280,7 +280,7 @@ static unsigned int da9121_map_mode(unsigned int mode)
 	case DA9121_BUCK_MODE_FORCE_PFM:
 		return REGULATOR_MODE_STANDBY;
 	default:
-		return -EINVAL;
+		return REGULATOR_MODE_INVALID;
 	}
 }
 
@@ -317,7 +317,7 @@ static unsigned int da9121_buck_get_mode(struct regulator_dev *rdev)
 {
 	struct da9121 *chip = rdev_get_drvdata(rdev);
 	int id = rdev_get_id(rdev);
-	unsigned int val;
+	unsigned int val, mode;
 	int ret = 0;
 
 	ret = regmap_read(chip->regmap, da9121_mode_field[id].reg, &val);
@@ -326,7 +326,11 @@ static unsigned int da9121_buck_get_mode(struct regulator_dev *rdev)
 		return -EINVAL;
 	}
 
-	return da9121_map_mode(val & da9121_mode_field[id].msk);
+	mode = da9121_map_mode(val & da9121_mode_field[id].msk);
+	if (mode == REGULATOR_MODE_INVALID)
+		return -EINVAL;
+
+	return mode;
 }
 
 static const struct regulator_ops da9121_buck_ops = {
-- 
2.25.1

