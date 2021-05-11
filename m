Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46E1637ADE9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 20:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232020AbhEKSJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 14:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232035AbhEKSJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 14:09:16 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D162C061760
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 11:08:08 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id j11so15252278qtn.12
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 11:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d77/SN0sw3S601ACuPLv1G4s2o9nNfN/Ue8skHxyW9c=;
        b=vqMDxM0QeVwffBByg1JFdsycJHC2T7U8tFV6Flyof7pCIfCU0FDnfFc4h/WqMdY47/
         uU5EWYnYX6NMYHn3d+DFAPIQRhwlXpwM5ZuVmJ85aAvL8++KBXlDKmOl6SfCONWQOCTG
         adhztuKJssfS75qF45xhqBDERoBEUr+8UD+AYv7Ojp6GS38udNK/Kjtpf1g+9T9mLL+h
         UyUIKJRmlrxcgt59G75T9YzHyOA76pNsmGVkpnGvkjwSBjAHs2ZvGilSGg5LFAaZPZTk
         v8kteIwA0D6+U+KPFXvbXBmFqZuesr78hQXhrHiuufmLCZFa36ouZtcRrFL6idruRfE+
         a+Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d77/SN0sw3S601ACuPLv1G4s2o9nNfN/Ue8skHxyW9c=;
        b=S0AQatzG/HIGARd+dtcLVvvmXiusRjN2D6BunTSlsXO5h3Lb/xJTlq00tHejv8e7ip
         Th0zxaNio+mIoorVyiwfUM+e5gIlloTqWO2Ph9V75IEeZSP4rES/UbpcpixdtAM9WZcN
         t2/KRHrDEQFxLAqivRT2QtZcCxmtwLaquq0tm+3RPgOFBOQhQqNLgOkmmglGd8wMuBy8
         fojGuafvcSZG+ltOHfC5tuKbiDv94m0Jwo2ArFvuSZFUrGcVZh5NDZ7che8vjQdPRaaw
         P5UZCh1SgKaW1/2HySiorJl7yGZ6kStG1fuiNFK6GMrarhwqC/bZGHZrjA8ty7orOmI7
         2lzw==
X-Gm-Message-State: AOAM5311V4HYp2SQT60I7VmLoXgaoNHUajCNMQrhpUn2FSTH2M+XcAqh
        kiEYrkEOWlbqGNnFsUCzG9j3gA==
X-Google-Smtp-Source: ABdhPJy8pR3BigeIHmKbrpHRTw+dfxpq/4e+J7XZAyhssyQbZuUpMOWeqmsktrVjADGD2XumxMEGZw==
X-Received: by 2002:ac8:518a:: with SMTP id c10mr28958949qtn.66.1620756487703;
        Tue, 11 May 2021 11:08:07 -0700 (PDT)
Received: from localhost.localdomain (modemcable068.184-131-66.mc.videotron.ca. [66.131.184.68])
        by smtp.gmail.com with ESMTPSA id g5sm17104476qtm.2.2021.05.11.11.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 11:08:07 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     linux-arm-msm@vger.kernel.org
Cc:     robert.foss@linaro.org, andrey.konovalov@linaro.org,
        Todor Tomov <todor.too@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org (open list:QUALCOMM CAMERA SUBSYSTEM DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 01/17] media: camss: csiphy-3ph: don't print HW version as an error
Date:   Tue, 11 May 2021 14:07:08 -0400
Message-Id: <20210511180728.23781-2-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20210511180728.23781-1-jonathan@marek.ca>
References: <20210511180728.23781-1-jonathan@marek.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid unnecessary noise in normal usage (it prints every time CSIPHY is
powered on).

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c b/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c
index e318c822ab04..5948abdcd220 100644
--- a/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c
+++ b/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c
@@ -163,7 +163,7 @@ static void csiphy_hw_version_read(struct csiphy_device *csiphy,
 	hw_version |= readl_relaxed(csiphy->base +
 				   CSIPHY_3PH_CMN_CSI_COMMON_STATUSn(15)) << 24;
 
-	dev_err(dev, "CSIPHY 3PH HW Version = 0x%08x\n", hw_version);
+	dev_dbg(dev, "CSIPHY 3PH HW Version = 0x%08x\n", hw_version);
 }
 
 /*
-- 
2.26.1

