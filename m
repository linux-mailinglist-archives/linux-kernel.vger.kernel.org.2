Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9B43117DA
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 01:38:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbhBFAgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 19:36:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231562AbhBEKpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 05:45:40 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 431E2C0617AB
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 02:44:54 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id j11so5612069wmi.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 02:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oxEhFanRiIwaURE1Asj018eMvsFp7g2C+jPywv6JQCM=;
        b=tSO4Sg60WMem1FDTqza6XCQPESNcZw47L5/wK0nElp+UkznqnfTtvUrOy7wynb4893
         hpwJCg8RBKiqe/afCDHiOipghDxMkFQXLthXZTBgnhMKlA2pZp08uhA3WdkJuT7BuJUZ
         OLhbBnYF3J6KIsM8rY8CGg/P3DWYQiSfcaZfc3J/0nvsPn/r/MlCTnwa73o/A0bekUXd
         3DWaxBZpaT5NNgR5F2Nju0p926/8F+w1Sq2l/wp+z/zJaVwxrrv8uorBU3jx1RpLSipS
         ZwIm/5TAGvV12qm7DBf942jiVud0JIn1/J2p/9OOnvKcjbODjEJriMFErLBfqcC5/ZEX
         qMRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oxEhFanRiIwaURE1Asj018eMvsFp7g2C+jPywv6JQCM=;
        b=gshXxMzKHAa2Z+EMqhzdq4Mam7u+M3qbMU+4BuvnPx+CwOhSi9e6cj16JFQR2Z4uHr
         JyQpJcdqRvRX6t8iVT2A9+/ehDpbpToIQTWnYOtcqL4mLp4eUrcq/fj/GySWOixxx1Ww
         9cutG1+i6jIFjjNAGe20pNrSJJZOr8YgYwzSQNzEHgUPSMb0yVxRgvyrO/za0lR7PvR5
         3oNKe53UITdOPaSq4fRsZBIyoPVvYuFeWVa4VTh7CFOCwQL0KLcCZR8HyuslS5pKn08w
         djkFiO20fkAfXouoGLHPLVUDIfLrxcdQpO5Zz/+ud70/xUE8gAAL3Yisoz3TU+2qi93h
         TP2g==
X-Gm-Message-State: AOAM533mBgJxK+MS6YkTiuljIBTWjibKX+EiIPnWDaJaSleItLq0THfw
        0oQAdIG9Kx3/tECTJu0Lejngpw==
X-Google-Smtp-Source: ABdhPJzxm4qZDH1ur4q1MjaB6uQHIE//ZPDCiBr8qLRA7s2U57lJLPR1T8hk7OC9XwQ5A4VJgntJvQ==
X-Received: by 2002:a1c:e912:: with SMTP id q18mr3058582wmc.162.1612521893061;
        Fri, 05 Feb 2021 02:44:53 -0800 (PST)
Received: from localhost.localdomain ([2a02:2450:102f:d6a:38fd:e0db:ea01:afc8])
        by smtp.gmail.com with ESMTPSA id u4sm11300233wrr.37.2021.02.05.02.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 02:44:52 -0800 (PST)
From:   Robert Foss <robert.foss@linaro.org>
To:     robert.foss@linaro.org, todor.too@gmail.com, agross@kernel.org,
        bjorn.andersson@linaro.org, mchehab@kernel.org, robh+dt@kernel.org,
        angelogioacchino.delregno@somainline.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Andrey Konovalov <andrey.konovalov@linaro.org>
Cc:     Tomasz Figa <tfiga@chromium.org>,
        Azam Sadiq Pasha Kapatrala Syed <akapatra@quicinc.com>,
        Sarvesh Sridutt <Sarvesh.Sridutt@smartwirelesscompute.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jonathan Marek <jonathan@marek.ca>
Subject: [PATCH v4 02/22] media: camss: Fix vfe_isr comment typo
Date:   Fri,  5 Feb 2021 11:43:54 +0100
Message-Id: <20210205104414.299732-3-robert.foss@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210205104414.299732-1-robert.foss@linaro.org>
References: <20210205104414.299732-1-robert.foss@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Comment refers to ISPIF, but this is incorrect. Only
the VFE interrupts are handled by this function.

Signed-off-by: Robert Foss <robert.foss@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1
 - Bjorn: Add r-b


 drivers/media/platform/qcom/camss/camss-vfe-4-1.c | 2 +-
 drivers/media/platform/qcom/camss/camss-vfe-4-7.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss-vfe-4-1.c b/drivers/media/platform/qcom/camss/camss-vfe-4-1.c
index 174a36be6f5d..a1b56b89130d 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe-4-1.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe-4-1.c
@@ -922,7 +922,7 @@ static void vfe_violation_read(struct vfe_device *vfe)
 }
 
 /*
- * vfe_isr - ISPIF module interrupt handler
+ * vfe_isr - VFE module interrupt handler
  * @irq: Interrupt line
  * @dev: VFE device
  *
diff --git a/drivers/media/platform/qcom/camss/camss-vfe-4-7.c b/drivers/media/platform/qcom/camss/camss-vfe-4-7.c
index b5704a2f119b..84c33b8f9fe3 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe-4-7.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe-4-7.c
@@ -1055,7 +1055,7 @@ static void vfe_violation_read(struct vfe_device *vfe)
 }
 
 /*
- * vfe_isr - ISPIF module interrupt handler
+ * vfe_isr - VFE module interrupt handler
  * @irq: Interrupt line
  * @dev: VFE device
  *
-- 
2.27.0

