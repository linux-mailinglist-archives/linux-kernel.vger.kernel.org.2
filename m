Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF66413C6C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 23:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235375AbhIUV3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 17:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235342AbhIUV3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 17:29:18 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 113EAC061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 14:27:50 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id dw14so543021pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 14:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Dfl+3o580a+kMNSziAD63BdB1Q2KQn9mivPlLyQZDa4=;
        b=DdbDl3YmnHFbEkAEzDhzvQP+q6jTeUFwWcThXjc7O+ZM0UFjjsHsiI1S9SLX2uTJFm
         97wnEuXjIC0VHQs3FKZAV1FkVtxNgLiWu91/8ZbzFvRcAtZnIuT6MR6qDBNQ9Wx1jCyt
         0YQwCNhNaDynhsDv7VrE+H/90q0O+1/2mJyP9zh9tZ5XSYSQUrbbvEcAY3iafXyKXsw/
         I6Z5QpoVYVRV2bcapqOobErfFi/ktYmfsgCXUoo3u2dgYeped6zJg1/+LfxrKjvsqXx8
         CBIXoloCbgvEyDuvBnZQe2K6xg9Tu6TTxUoAsZUPbMAbaBKS0u7cTXcZ5PUyxsPKGNGt
         9tOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Dfl+3o580a+kMNSziAD63BdB1Q2KQn9mivPlLyQZDa4=;
        b=RFLfggQeISG2m06zTkNDGrXYsBMtF2HYuRNqzbXXVfBy7/VKCfST0F9P0eAvGN1AeJ
         V47U+ae9flnUOreIzW9dC74yVyKuPoLEY9FY4xIDnv3uwdsfyAdKbQigMrpxnYTzSxV9
         JOT+SgR2u4IQqBiKeGh4yOl378xFAppxoFyWtbw+b6ek5LGYhPTcJIyNU/XNVyQcPLSk
         Ha4BPOMAKOlXaKpJrUp6FrU/D6Fqy76CeImr9qMXhKsScd57K7hrluOqTDm1A/QBgYuE
         WEPYFeV5+xCDwo3zTLM41+pua7hVQbvUwEEfsnoVn/AzAqtE1i4DsNtZCz1BHXudwSrq
         Bfxg==
X-Gm-Message-State: AOAM531/0iqIlENP2qYsuzpFcFhb0AIVkoqDeIb5lKFbasxib/urNuK1
        KP9LIfPLnaPKZm3VmnCGCFk=
X-Google-Smtp-Source: ABdhPJxkuxtEncfxVsxXDjCkEfFSk5C8p5pf8Bt4pS1LFd5h/MqkdORJDlDmm6zVQbSYutusMGJdZQ==
X-Received: by 2002:a17:90b:8cb:: with SMTP id ds11mr7548115pjb.66.1632259669458;
        Tue, 21 Sep 2021 14:27:49 -0700 (PDT)
Received: from archl-c2lm.. ([103.51.72.29])
        by smtp.gmail.com with ESMTPSA id q21sm61399pjg.55.2021.09.21.14.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 14:27:48 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Anand Moon <linux.amoon@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCHv3] regulator: pwm-regulator: Make use of the helper function dev_err_probe()
Date:   Tue, 21 Sep 2021 21:27:31 +0000
Message-Id: <20210921212732.1334-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

devm_pwm_get() can return -EPROBE_DEFER if the pwm regulator is not
ready yet. Use dev_err_probe() for pwm regulator resources
to indicate the deferral reason when waiting for the
resource to come up.

Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
V2 - Fix the return message and drop the FIX tag in commit.
V1 - Fix the wrong probe defer for devm_regulator_register.
   - Fix the commit message.
---
 drivers/regulator/pwm-regulator.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/regulator/pwm-regulator.c b/drivers/regulator/pwm-regulator.c
index 7629476d94ae..9e2784ce8f67 100644
--- a/drivers/regulator/pwm-regulator.c
+++ b/drivers/regulator/pwm-regulator.c
@@ -353,13 +353,8 @@ static int pwm_regulator_probe(struct platform_device *pdev)
 
 	drvdata->pwm = devm_pwm_get(&pdev->dev, NULL);
 	if (IS_ERR(drvdata->pwm)) {
-		ret = PTR_ERR(drvdata->pwm);
-		if (ret == -EPROBE_DEFER)
-			dev_dbg(&pdev->dev,
-				"Failed to get PWM, deferring probe\n");
-		else
-			dev_err(&pdev->dev, "Failed to get PWM: %d\n", ret);
-		return ret;
+		return dev_err_probe(&pdev->dev, PTR_ERR(drvdata->pwm),
+				     "Failed to get PWM\n");
 	}
 
 	if (init_data->constraints.boot_on || init_data->constraints.always_on)
-- 
2.33.0

