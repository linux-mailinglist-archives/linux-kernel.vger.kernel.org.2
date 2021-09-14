Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4341740BAF6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 00:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235112AbhINWNd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 18:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbhINWNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 18:13:33 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE57C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 15:12:15 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id w19-20020a17090aaf9300b00191e6d10a19so739477pjq.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 15:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2pOyKODTTbckGvzWr1C97Zs9KpuucrD9qrClzy15doM=;
        b=g8DL/VLnPVI9uHMWr9a5jQ8quiP0AwK8ZkVUJx32p14hYNeHjhuOzWTeEKJN92njDB
         lqkqhcPc4OV9UssFhAiGvfY8YzAqzpqm0LZdwuBzwC6yb6ccBgnwv185mxxnS/7/LQxu
         DBLKXAiIhreRmcE4r/78rKHdvyA9OVtNzueSgMAGxmUmYS7Zovmcn+YRU+UGW0U2+9Wi
         qBhU0zSED7moxxLJAAYVFmHmCEiA0pliz6y07VnQpmTjMQ4Sdnf1XiInuVrnxbIFNwmQ
         2YxygoLfYERsr5rSX9c7RbO2ENPqnaOBIoOdKdb4Dzs/bJ2H+w1G8bk6imCuhY/zPn0R
         bArw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2pOyKODTTbckGvzWr1C97Zs9KpuucrD9qrClzy15doM=;
        b=n4wJCjYXK/x1YFO6BMVfmqrexFV3IrF14Z+GAcs3K3Cs6Eqi9dqofzL/06BDcA0dLN
         UUnwJ0Vi6rNwEz1/4qaF7fslL8CdU7dmTV66Y6xAFE+cxf3v2BW2NcMLPcIRCa6RnoJO
         4CNLw5bdYm7xlcewW+y0FaTcZbCsDEJTP/9nZ2FL/9g+ypaiAO9b19VqDxnDb9hnnDwK
         POIZALH8Llj3FE8iVrPPNuH7GzvkjGNCwE6LxfbydJ/vkJI44W9XPQ8hS2cIjpoEgYNa
         Xbv4w8gv50Ty2Uc7/JSZ19vpb58KzEGRTVrFlpNeRz1Ymf4r7aas4ji6ON4G2X3yLKxp
         AFyQ==
X-Gm-Message-State: AOAM533z5js1sOIjfx7U3hyDMhKz+2qDqxbUAH4bHVkDciuz0hABLlZw
        P2HrpOW7JBAMikQiUnekBjRtd7hcQCg=
X-Google-Smtp-Source: ABdhPJxSaO5qP79kRhNacaQI0D2PhMlhruO2k2vHtQ+2Nc+dggAEzN+HaVcRbytwKh2gEVVUo1HZxQ==
X-Received: by 2002:a17:902:b102:b0:134:a329:c2f8 with SMTP id q2-20020a170902b10200b00134a329c2f8mr16833722plr.71.1631657534370;
        Tue, 14 Sep 2021 15:12:14 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id l22sm13085741pgo.45.2021.09.14.15.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 15:12:13 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jim Quinlan <jim2101024@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM BCM7XXX ARM
        ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM7XXX
        ARM ARCHITECTURE)
Subject: [PATCH] reset: brcmstb-rescal: fix incorrect polarity of status bit
Date:   Tue, 14 Sep 2021 15:11:21 -0700
Message-Id: <20210914221122.62315-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jim Quinlan <jim2101024@gmail.com>

The readl_poll_timeout() should complete when the status bit
is a 1, not 0.

Fixes: 4cf176e52397 ("reset: Add Broadcom STB RESCAL reset controller")
Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/reset/reset-brcmstb-rescal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/reset/reset-brcmstb-rescal.c b/drivers/reset/reset-brcmstb-rescal.c
index b6f074d6a65f..433fa0c40e47 100644
--- a/drivers/reset/reset-brcmstb-rescal.c
+++ b/drivers/reset/reset-brcmstb-rescal.c
@@ -38,7 +38,7 @@ static int brcm_rescal_reset_set(struct reset_controller_dev *rcdev,
 	}
 
 	ret = readl_poll_timeout(base + BRCM_RESCAL_STATUS, reg,
-				 !(reg & BRCM_RESCAL_STATUS_BIT), 100, 1000);
+				 (reg & BRCM_RESCAL_STATUS_BIT), 100, 1000);
 	if (ret) {
 		dev_err(data->dev, "time out on SATA/PCIe rescal\n");
 		return ret;
-- 
2.25.1

