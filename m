Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17F1F3B1DAD
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 17:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbhFWPhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 11:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbhFWPhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 11:37:22 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF6F8C061574
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 08:35:04 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id pf4-20020a17090b1d84b029016f6699c3f2so4101081pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 08:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+mI6+zz+H583afuk78K0myFGshVLHyM3wXS60guYtuo=;
        b=kAnAOV0Cb5WWxjMsN894W7EHiVAoPY+5e0mwzuTOkRme634ZWqvUumNfyEmAjjMH9W
         GFQsOjhnaSSZ1ac1AslcbYWl3exG+VSq4UJoOcTMXhCsNvvxQrjKSoW2OS9rvHYRXWuU
         O4AaqbkyPwJQfooBqx5yWJYEkDC9j6DPHYhlCSvIFGDND8W05bFkRtK1e6htc+Umvx57
         3Lr+X+XtmPL2M0pQg5gugyfNAm9ViVc4CdgL6euUbrkDm6HZ7JwMlCkieS0MzUWMJT2L
         yPR/s0yjjxDQPZTltKc42/oPJuzOT2GXYc+6ZeF3tLZqicg/VChUYOFVZz4bBIDiCRjh
         kCSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+mI6+zz+H583afuk78K0myFGshVLHyM3wXS60guYtuo=;
        b=UWtGdz+RvJHgDfeZgOHDyUBnZRn0uh9W+aR1scbjxIJ2E2E99F0PsEo6ND6x+UIPQc
         G9Fyw8kg8HQzRiIqwivrpnSWeiH5UAtawor7omFLAhJRbY4wMf5h+iWIbWF14oB9Vbmy
         cJE5TUfdGVqaW6iRxk9Su4Ga1iJkWXNAlLgQ7j8eBfN5u+PRV70fMThryBV5DkQZAQXs
         z/LY0Bh4si8U2qAwHbMetSC84XxIXvruemRpnJBJJPb92ChTw86/ZsO9j11YO4CLmZ38
         Jro+5eqDiVLKeXdjUzwyhxcUerPQnZYXYjl300OM3mf8IHjb48Sel/YbhFgpF8JjhplG
         G46Q==
X-Gm-Message-State: AOAM532YqQK0ci5QNqyDKH7AWY4Niv6ZMtelNVn25e+qq5+GTnT3MWMy
        sq7GyeJ2oC6/VZuXtktyabuxqw==
X-Google-Smtp-Source: ABdhPJzNO0Rpq6z6YL9Mk3SpLmNc1ftGLkjm+Q8e86KEWVQXLZmOeBK5xEl3rJZnSUdWypHdhtgaVw==
X-Received: by 2002:a17:90a:d598:: with SMTP id v24mr302933pju.185.1624462504101;
        Wed, 23 Jun 2021 08:35:04 -0700 (PDT)
Received: from localhost.localdomain (122-117-179-2.HINET-IP.hinet.net. [122.117.179.2])
        by smtp.gmail.com with ESMTPSA id t13sm287472pfq.4.2021.06.23.08.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 08:35:03 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: bd9576: Fix testing wrong flag in check_temp_flag_mismatch
Date:   Wed, 23 Jun 2021 23:34:43 +0800
Message-Id: <20210623153443.623856-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix trivial copy-paste typo.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/bd9576-regulator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/bd9576-regulator.c b/drivers/regulator/bd9576-regulator.c
index 8b54d88827be..3023069536ff 100644
--- a/drivers/regulator/bd9576-regulator.c
+++ b/drivers/regulator/bd9576-regulator.c
@@ -294,9 +294,9 @@ static bool check_temp_flag_mismatch(struct regulator_dev *rdev, int severity,
 				    struct bd957x_regulator_data *r)
 {
 	if ((severity == REGULATOR_SEVERITY_ERR &&
-	     r->ovd_notif != REGULATOR_EVENT_OVER_TEMP) ||
+	     r->temp_notif != REGULATOR_EVENT_OVER_TEMP) ||
 	     (severity == REGULATOR_SEVERITY_WARN &&
-	     r->ovd_notif != REGULATOR_EVENT_OVER_TEMP_WARN)) {
+	     r->temp_notif != REGULATOR_EVENT_OVER_TEMP_WARN)) {
 		dev_warn(rdev_get_dev(rdev),
 			 "Can't support both thermal WARN and ERR\n");
 		if (severity == REGULATOR_SEVERITY_WARN)
-- 
2.25.1

