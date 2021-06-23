Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 099AF3B1939
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 13:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbhFWLsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 07:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbhFWLsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 07:48:42 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54501C061574
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 04:46:23 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id nd37so3580184ejc.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 04:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OPO+5qBMrh6CFAk2k2y7MZTP5rtIuHwphQETmqm9ae4=;
        b=IV8RA4qZbaPs6dyGZDf30g8xjvUexu24ke0c3RCoxjkmR1n7v/rheLjlr03YZWtzhv
         XUgSoHvJCit3h65/V6TroslFX61gZQV8B8EyoBqQIUTzxOEtoKQfLBGLUVRyUGuaL0FQ
         WsTmT0Zf4dkwPKeyKL8tsqIa2pwpz1DBJWRj4B1LnimqlJ6oyN22uzmaJOwK9mOEozkg
         9YZnNtnnrmCvX4Qi3AZRU4D7XkJo7wJGj3oygNfL1Valkni7pHY63SH3vc3RXr8b6lPO
         7AEfcNm/LNco+XxbBQvsb0blqzNCJJYbbPA0A0trU2qURWAj2UC46ZXGGsXTH+aNDTVq
         l+GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=OPO+5qBMrh6CFAk2k2y7MZTP5rtIuHwphQETmqm9ae4=;
        b=tEYLubkynQ1GyB/ZAlSqfXj2S6whbR6IevIznw6IUuM6BL5uAkZ984YVVcsxd7VanH
         YYPdUY22z/UfYTj2Tpoqosx60DxES/GqeKTcu0nK4jy5ueJujFMJpLTKYHTneqmZZbzJ
         ib/5Kj2kDZXewxSVcV3Iu1TRo/Sb9lJ0XEBBvpp+7hXKVm2rkN94ewGfVYhpfqPwKOeJ
         eKfq6nUBPzZFDoKKOczomRlnRIJaOuv/d98FEcauaX0Yf43IHPGtuXyqgrogMekhNbdF
         JPVvgL7IfGD5XzoB81+MB8DSflu6OlXrx59uKGc5oCldfSKxe+Th0qxC8YOx4UV4eiU/
         gehA==
X-Gm-Message-State: AOAM532tnHHjRrUHso91no2btqIUovbxOKai9at9hb6gh89hQwY8IbYX
        1Ya4iHlY1ridy1bwA5VjBwDeW+kv0vuWuYEh
X-Google-Smtp-Source: ABdhPJwtqiBRtTiM4vMwsazfbiO9H2qs6bsFiFh8eifmNz3SgrrGo1BNRrd22+TQxm+ZL/2OKgmzgQ==
X-Received: by 2002:a17:906:ff48:: with SMTP id zo8mr9256580ejb.424.1624448781787;
        Wed, 23 Jun 2021 04:46:21 -0700 (PDT)
Received: from localhost ([2a02:768:2307:40d6::648])
        by smtp.gmail.com with ESMTPSA id j19sm3806941ejo.3.2021.06.23.04.46.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Jun 2021 04:46:21 -0700 (PDT)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] reset: reset-zynqmp: Fixed the argument data type
Date:   Wed, 23 Jun 2021 13:46:20 +0200
Message-Id: <925cebbe4eb73c7d0a536da204748d33c7100d8c.1624448778.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>

This patch changes the data type of the variable 'val' from
int to u32.

Addresses-Coverity: argument of type "int *" is incompatible with parameter of type "u32 *"
Signed-off-by: Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 drivers/reset/reset-zynqmp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/reset/reset-zynqmp.c b/drivers/reset/reset-zynqmp.c
index daa425e74c96..59dc0ff9af9e 100644
--- a/drivers/reset/reset-zynqmp.c
+++ b/drivers/reset/reset-zynqmp.c
@@ -53,7 +53,8 @@ static int zynqmp_reset_status(struct reset_controller_dev *rcdev,
 			       unsigned long id)
 {
 	struct zynqmp_reset_data *priv = to_zynqmp_reset_data(rcdev);
-	int val, err;
+	int err;
+	u32 val;
 
 	err = zynqmp_pm_reset_get_status(priv->data->reset_id + id, &val);
 	if (err)
-- 
2.32.0

