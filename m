Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAEFB33DA90
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 18:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239164AbhCPRUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 13:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238767AbhCPRUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 13:20:08 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 779C5C061763
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 10:20:08 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id bm21so73470416ejb.4
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 10:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b2Yxcn9pIayZrG5IbORXfcFifUWLDIXNoqZkK9xbrmo=;
        b=Rkm6MKZcVytPjrLJ6z6n4fqg1Je9JRLtajs8uQHdKyurfUT+udf94hdM/AeP+4J2tC
         BeXQSmg2kh7fDTBp5BkopuDNPLtUiMxk8/yeC2gaBWHZjQx09n2Nv1elTjTZitE7siUx
         Oh3GgbGc74MeGZYh90IsmSlQwyMLm+chfzyRvdF5ZBFY6O0yy5zcbYFySCxfPbFiOWrx
         XRBVIcd83ykdpKEOa427BKcr5Zyfyhk8CUAatjbF5f+xr9p7F+CJwBkyux8wKFBfoHmP
         zIBHjE/h5oxUv/ggUFvBKI1bcXlghssP8YajK3VrBHGR61Ndhbg2Rb7rKZFF940ye7vs
         K60w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b2Yxcn9pIayZrG5IbORXfcFifUWLDIXNoqZkK9xbrmo=;
        b=pllT17NRckToRXTUiyI4SS6518mlMvSaqKd0dCxTbbaxDs0yUHsOKWjNYNkZOk7roW
         4zEdyRmcFLuEhH/q7aJixq27G2J0cMzbPJo2dS2RxGF8cQvWIbc6IVUbBH7t4RAm89rB
         RFMOdAWoc8fre4ioJynC5cLERW8IMYKX7IHYm/a8rx1I/DTKFVQ3TyBaeVWUo5j8b6YK
         7pEz3oxEYKoleOm5O56ALd4p/sl6nnrjD5WL5CpBmhJ5fdcvk10ABUhIjyHaQM/Zj5gI
         BTvrfEPQNOLKcVgu3p+DN9UK1xlSx8Hs6tR878MfoCQ3c6sGEcZ7Tq6riCbnz6aQQVc5
         g6xQ==
X-Gm-Message-State: AOAM530iylWuDn2HObFTUq+yTw3SvjcR4i9CG6LKfsV3MqoAJhfaecI3
        Nc5794iCmK292/4MtmFEJK6JZA==
X-Google-Smtp-Source: ABdhPJxbpOBrnF7xZ8Xw5p13WWrU0ejEI8V9oBAS0uu/QVHWeQQrSHUXBvFxHhf+CurDO4gehB8HFQ==
X-Received: by 2002:a17:906:5607:: with SMTP id f7mr30097440ejq.262.1615915207159;
        Tue, 16 Mar 2021 10:20:07 -0700 (PDT)
Received: from localhost.localdomain ([37.120.1.234])
        by smtp.gmail.com with ESMTPSA id u1sm10571584edv.90.2021.03.16.10.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 10:20:06 -0700 (PDT)
From:   Robert Foss <robert.foss@linaro.org>
To:     robert.foss@linaro.org, todor.too@gmail.com, agross@kernel.org,
        bjorn.andersson@linaro.org, mchehab@kernel.org, robh+dt@kernel.org,
        angelogioacchino.delregno@somainline.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Andrey Konovalov <andrey.konovalov@linaro.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Rob Herring <robh@kernel.org>, Tomasz Figa <tfiga@chromium.org>,
        Azam Sadiq Pasha Kapatrala Syed <akapatra@quicinc.com>,
        Sarvesh Sridutt <Sarvesh.Sridutt@smartwirelesscompute.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jonathan Marek <jonathan@marek.ca>
Subject: [PATCH v9 01/22] media: camss: Fix vfe_isr_comp_done() documentation
Date:   Tue, 16 Mar 2021 18:19:10 +0100
Message-Id: <20210316171931.812748-2-robert.foss@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210316171931.812748-1-robert.foss@linaro.org>
References: <20210316171931.812748-1-robert.foss@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function name in comment is wrong, and was changed to be
the same as the actual function name.

The comment was changed to kerneldoc format.

Signed-off-by: Robert Foss <robert.foss@linaro.org>
Reviewed-by: Andrey Konovalov <andrey.konovalov@linaro.org>
---


Changes since v1:
 - Bjorn: Fix function doc name & use kerneldoc format

Changes since v5:
 - Nicolas: Fixed typo in commit message
 - Andrey: Added r-b



 drivers/media/platform/qcom/camss/camss-vfe.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss-vfe.c b/drivers/media/platform/qcom/camss/camss-vfe.c
index b2c95b46ce66..f50e08c4fd11 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe.c
@@ -1076,8 +1076,8 @@ static void vfe_isr_wm_done(struct vfe_device *vfe, u8 wm)
 	spin_unlock_irqrestore(&vfe->output_lock, flags);
 }
 
-/*
- * vfe_isr_wm_done - Process composite image done interrupt
+/**
+ * vfe_isr_comp_done() - Process composite image done interrupt
  * @vfe: VFE Device
  * @comp: Composite image id
  */
-- 
2.27.0

