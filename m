Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0C57353B75
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 07:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231954AbhDEFKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 01:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbhDEFJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 01:09:59 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D51F1C061756
        for <linux-kernel@vger.kernel.org>; Sun,  4 Apr 2021 22:09:52 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id k8so7433018pgf.4
        for <linux-kernel@vger.kernel.org>; Sun, 04 Apr 2021 22:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EIOSM+Jlbj62eZAoiGqrvJyU1MmccRrVFUma1qyaw8A=;
        b=mt6OhMv8kLzSjri6/NAOyuml+dUtvpeBUmRGr115w3EiQwMPw1+rzvSZJa6vPj4Xuk
         Mft/uQJYZgeh4vkuBMUK2n/lFOYt1a/V1kD3Dm0H9jxGYl2nLPhqbMU2zWNKXLe6wzyf
         UmUN7c0tZeXRto4IwnPde/3baIm6PwOpSj9hK3FmlisOvGGM8orMdOg8cdOFkDucephT
         H+pei0x0PH7Vpyxvol6JZJMmLXj3P2Q72+AVxhoQ6DXZje4pXgGuquh5PjT1HA2geod1
         YhjtY56m3RLnPRJlvQlUFo2N9kXm86npNNes233Pe6wu5bQ5z1RQeUgPkIldEwm5LfhP
         RLng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EIOSM+Jlbj62eZAoiGqrvJyU1MmccRrVFUma1qyaw8A=;
        b=NGqvHr1TPwZ7jCRLPERlw2tvLRMZPR//FjoiC4JroTXQOQVx1bdrzio/Aj8T9b/Iw5
         PKWuQ/+W5+sWOznKifHfREOGJVMUoDtX5T1hiQYdvY1r8ynnP/tSCOX9s/Nk7HOEQ1/R
         g8HncMhHz3pe3eWSuMks1+CTFXnMNFYdhmsswETg5xhMrDngzsteaNe+9x8PEf0lgtER
         jfuZn8rcwefpnz6IXu7xt5a7BT2B+4he+X0pndme0l19HLJKaWh9rt3T094/y4QAKShy
         V0DKkzcrZC6HHCM/R10W4+Avw0AsOVXrEPjP/WZMkLdZRwMvsEXeXTGc9c6nJUSNshnw
         z3+Q==
X-Gm-Message-State: AOAM532Q69h5aqgZNl9NEK/3wUcQzhtW9ETOzyYyWPpppL7EccSwXTKf
        iODuHVay3ooBz3O5ZUxHG1Sp
X-Google-Smtp-Source: ABdhPJxeaADlQpaccaPVeXis0lo9Ae+uSvbkkQg5MNUgs8oZVs9FZ5AGZd9pbeIwcTkHYHpF8poEgw==
X-Received: by 2002:a63:1921:: with SMTP id z33mr21738430pgl.211.1617599392121;
        Sun, 04 Apr 2021 22:09:52 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:98:8118:aa47:7491:f04a:71ea])
        by smtp.gmail.com with ESMTPSA id b126sm14177939pga.91.2021.04.04.22.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Apr 2021 22:09:51 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        boris.brezillon@collabora.com, Daniele.Palmas@telit.com,
        bjorn.andersson@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH] mtd: rawnand: qcom: Use dma_mapping_error() for error check
Date:   Mon,  5 Apr 2021 10:39:12 +0530
Message-Id: <20210405050912.115591-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dma_mapping_error() should be used for checking the error value of
dma_map_resource() API.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/mtd/nand/raw/qcom_nandc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index fe74cf3aece5..07b3c156a802 100644
--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -2990,7 +2990,7 @@ static int qcom_nandc_probe(struct platform_device *pdev)
 	nandc->base_dma = dma_map_resource(dev, res->start,
 					   resource_size(res),
 					   DMA_BIDIRECTIONAL, 0);
-	if (!nandc->base_dma)
+	if (dma_mapping_error(dev, nandc->base_dma))
 		return -ENXIO;
 
 	ret = qcom_nandc_alloc(nandc);
-- 
2.25.1

