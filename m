Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A505C418A10
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 17:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbhIZPzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 11:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232020AbhIZPzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 11:55:40 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA78C061604
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 08:54:04 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id b15so64256868lfe.7
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 08:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WraWdZ/CzTYmuzEHanbN0/OAtgST0aRafGy3nu87PmE=;
        b=Js4Vor9UROzDBLcAkvg/OhbJBleWHe31URp/HIfjGU6uP1TZtoWyOKhX1RQRGGt61T
         zz4jW+tHZ2wB5IUM2eOqmE00fmB/SGV/0/7dKg4v8rWoGO5Uv0WX3fUSFwhV71YecH/S
         LaqFIFV7rqLu1gHq3mBkGWthUkDtcddNe5wTEzpA3kYut3ro0caemRZrNZnnZm+caDlr
         0p4+hxxwRhkltonH+TjMUbh4cn7+L6CdvB+v33sBjpfnpFAwjBWjzhwFRnQdhrNk5SFm
         jV8dh2lyX/noz4Ez4NB+J+h/lrAEqSYahxrvcqboBzoFtiGTzQ6glM70Yg8U2Om77f6o
         6j8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WraWdZ/CzTYmuzEHanbN0/OAtgST0aRafGy3nu87PmE=;
        b=JpDVsA/K9dCzgVUkFG0eK9Ke2tyI7qRs1zhu2LYrzf7A213mU1jrkwrkwVJ00xQ1vK
         xgdzo9YqhzUa60lyeHlpob81t0zytQWRegPmanQ/DkjTop/TjwkHk/hATKEWdwv9Yprc
         46IYkCSLSrzANWU4anmhyUS69I+C48tl75EMk2soULlrE/57cyJSdgUcdt6W0z63n0x4
         3BaDp0SYGMjzZMbaZbKsopVvVcxcBWRj9FinDDxhkJcuA169myb6/JR2i8erOGQJhylN
         KKRrrrhoBCfTv1nB2U6TfdLvwtDe1upfIDNYtIonUChNE3Z8VtXwIYc3Q5wfRCZk6gaf
         jg8A==
X-Gm-Message-State: AOAM5311wqhR5hjQ1AVTO26jA6A0WkW2M12NnzL2g4ucTOyrPWKP87lT
        8J0GQPtf94SjZGJjPKo0YBNeYw==
X-Google-Smtp-Source: ABdhPJwhSuhNqmpQKcNCGuFpj3palWu3b0H+8Kk6qJhtRgBvJthM/hzRRlIMHcHqnaX61r7YNnIkrg==
X-Received: by 2002:a05:6512:32c6:: with SMTP id f6mr20773651lfg.304.1632671641694;
        Sun, 26 Sep 2021 08:54:01 -0700 (PDT)
Received: from cobook.home (nikaet.starlink.ru. [94.141.168.29])
        by smtp.gmail.com with ESMTPSA id a21sm1811770lji.135.2021.09.26.08.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Sep 2021 08:54:01 -0700 (PDT)
From:   Nikita Yushchenko <nikita.yoush@cogentembedded.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Koji Matsuoka <koji.matsuoka.xm@renesas.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: [PATCH] media: vsp1: mask interrupts before enabling
Date:   Sun, 26 Sep 2021 18:53:56 +0300
Message-Id: <20210926155356.23861-1-nikita.yoush@cogentembedded.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Setting up VSP interrupt handler without masking interrupt before causes
interrupt handler to be immediately called (and crash due to null pointer
dereference) on r8a77951-ulcb-kf board.

Fix that by explicitly masking all interrupts before setting the interrupt
handler. To do so, have to set the interrupt handler later, after hw
revision is already detected and number of interrupts to mask gets
known.

Based on patch by Koji Matsuoka <koji.matsuoka.xm@renesas.com> included
in the Renesas BSP kernel. Updated that to use wfp_count as the number of
WPF interrupts to mask.

Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
---
 drivers/media/platform/vsp1/vsp1_drv.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/media/platform/vsp1/vsp1_drv.c b/drivers/media/platform/vsp1/vsp1_drv.c
index de442d6c9926..0e9a6fad54f8 100644
--- a/drivers/media/platform/vsp1/vsp1_drv.c
+++ b/drivers/media/platform/vsp1/vsp1_drv.c
@@ -811,13 +811,6 @@ static int vsp1_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	ret = devm_request_irq(&pdev->dev, irq->start, vsp1_irq_handler,
-			      IRQF_SHARED, dev_name(&pdev->dev), vsp1);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "failed to request IRQ\n");
-		return ret;
-	}
-
 	/* FCP (optional). */
 	fcp_node = of_parse_phandle(pdev->dev.of_node, "renesas,fcp", 0);
 	if (fcp_node) {
@@ -847,7 +840,6 @@ static int vsp1_probe(struct platform_device *pdev)
 		goto done;
 
 	vsp1->version = vsp1_read(vsp1, VI6_IP_VERSION);
-	vsp1_device_put(vsp1);
 
 	for (i = 0; i < ARRAY_SIZE(vsp1_device_infos); ++i) {
 		if ((vsp1->version & VI6_IP_VERSION_MODEL_MASK) ==
@@ -861,11 +853,26 @@ static int vsp1_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "unsupported IP version 0x%08x\n",
 			vsp1->version);
 		ret = -ENXIO;
+		vsp1_device_put(vsp1);
 		goto done;
 	}
 
 	dev_dbg(&pdev->dev, "IP version 0x%08x\n", vsp1->version);
 
+	for (i = 0; i < vsp1->info->lif_count; ++i)
+		vsp1_write(vsp1, VI6_DISP_IRQ_ENB(i), 0);
+	for (i = 0; i < vsp1->info->wpf_count; ++i)
+		vsp1_write(vsp1, VI6_WPF_IRQ_ENB(i), 0);
+
+	vsp1_device_put(vsp1);
+
+	ret = devm_request_irq(&pdev->dev, irq->start, vsp1_irq_handler,
+			       IRQF_SHARED, dev_name(&pdev->dev), vsp1);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "failed to request IRQ\n");
+		goto done;
+	}
+
 	/* Instantiate entities. */
 	ret = vsp1_create_entities(vsp1);
 	if (ret < 0) {
-- 
2.30.2

