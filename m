Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D81813A0738
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 00:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235581AbhFHWl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 18:41:28 -0400
Received: from mail-qv1-f47.google.com ([209.85.219.47]:33739 "EHLO
        mail-qv1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235484AbhFHWlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 18:41:11 -0400
Received: by mail-qv1-f47.google.com with SMTP id l3so4718075qvl.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 15:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YF+r6J+3VfhXF0w7kNy6T/fUbmvmV9LKX6YLuEVLoRg=;
        b=MjpIW44LVEmHX2q0gFwSod1kO98C0xxLFr85YAgYxUpGYGrzDGrULry/yapkewaxid
         xCZ9OxC2S5ordjs24B5FywBkr+eKxz6RC+hlpUBoPvBwnDN0/IGLdtCt2AlAZVz/wVjp
         ejO7BcE8qYXoobqgGP8bs6pGAdGiKwT58JSQTLk4dSODKRbARDSSZkMvspoy9dACOQjg
         RAM/ZNnSpNzsjGAIpTZdb6uzz1/6D4eM14O9gNNbxSKS6e594IrxHMBXS+3NRrvclfa5
         kQVD3ZUHSzeVMSG3vRjiCW7T3F0gP50ihCCVR7YaHG2xhMJhOITC3lJFDNRzenXEPWZw
         lH1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YF+r6J+3VfhXF0w7kNy6T/fUbmvmV9LKX6YLuEVLoRg=;
        b=DTAhMa3H0k74m3f4SQpYd762rwkUZq+iV53LpFW+26kDdmT4HPt81k4fscz4vC/tpF
         BSGteXmctx1V4ntRKztzCLvRR+AUKFAqG8jFJTvyt+Ngd02VgOT+xwJwgaCqyy1jqQDi
         1fw8gIFQm1O3c5/oS5RHu2D+z8uHokq6ffoLKGe+3Ob0//wDYLRREOyf24ecl63MRaFl
         lJQOl3S+wixEynzfUv1VAZ9BGaSPdURQAYa8gNiWLXSsyhzYpgOLWD1muMvIOi28QC/i
         ksC7ERcMuoszDKS7jUJ2zpnGQmJ5saY6CLjmJYeJO+w855/3pW0rOlxnpt03qzvfNUx0
         z2pA==
X-Gm-Message-State: AOAM5303adJMQ3gZ5KdS+fDY07BOG14dHAsAwHj4jzqEThBMEz7S/1v3
        AU4cVGbEznIn2GNiH2KhJVrtoQ==
X-Google-Smtp-Source: ABdhPJwVbH69KUAIfKnaIV0u4eUMVkZv8Bc78jwoeYG/XhR8Lr7OU+NamcJAKAvtFSaHM426dcVjlw==
X-Received: by 2002:a05:6214:6b1:: with SMTP id s17mr2811745qvz.60.1623191882071;
        Tue, 08 Jun 2021 15:38:02 -0700 (PDT)
Received: from localhost.localdomain (modemcable068.184-131-66.mc.videotron.ca. [66.131.184.68])
        by smtp.gmail.com with ESMTPSA id m3sm2324266qkh.135.2021.06.08.15.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 15:38:01 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     linux-arm-msm@vger.kernel.org
Cc:     robert.foss@linaro.org, andrey.konovalov@linaro.org,
        Todor Tomov <todor.too@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org (open list:QUALCOMM CAMERA SUBSYSTEM DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 13/17] media: camss: vfe-170: fix "VFE halt timeout" error
Date:   Tue,  8 Jun 2021 18:35:02 -0400
Message-Id: <20210608223513.23193-14-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20210608223513.23193-1-jonathan@marek.ca>
References: <20210608223513.23193-1-jonathan@marek.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function waits for halt_complete but doesn't do anything to cause
it to complete, and always hits the "VFE halt timeout" error. Just delete
this code for now.

Fixes: 7319cdf189bb ("media: camss: Add support for VFE hardware version Titan 170")
Signed-off-by: Jonathan Marek <jonathan@marek.ca>
Reviewed-by: Robert Foss <robert.foss@linaro.org>
---
 drivers/media/platform/qcom/camss/camss-vfe-170.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss-vfe-170.c b/drivers/media/platform/qcom/camss/camss-vfe-170.c
index 1de793b218194..ba142c8cec6ee 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe-170.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe-170.c
@@ -355,17 +355,7 @@ static irqreturn_t vfe_isr(int irq, void *dev)
  */
 static int vfe_halt(struct vfe_device *vfe)
 {
-	unsigned long time;
-
-	reinit_completion(&vfe->halt_complete);
-
-	time = wait_for_completion_timeout(&vfe->halt_complete,
-					   msecs_to_jiffies(VFE_HALT_TIMEOUT_MS));
-	if (!time) {
-		dev_err(vfe->camss->dev, "VFE halt timeout\n");
-		return -EIO;
-	}
-
+	/* rely on vfe_disable_output() to stop the VFE */
 	return 0;
 }
 
-- 
2.26.1

