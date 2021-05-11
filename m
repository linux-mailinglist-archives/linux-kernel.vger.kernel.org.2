Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6BF37AE08
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 20:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232279AbhEKSJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 14:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232010AbhEKSJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 14:09:25 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5333FC06138B
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 11:08:17 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id l129so19667766qke.8
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 11:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TL0pxImTrhkdes2Qf58s3VuC8nEsAjomfspwAu0MVyc=;
        b=uJsLGmvxfJ0A/Y1O8bNW0h8SCMxQd72F8Yx+Kn0Lgks4EEyYx9UbnOWYaWkF+X3pBN
         CefT5cSD1l81ItHbRMPpAE4jMkeOP5eAjik3eSV7nxDA46f/+zszoAd8ViY01mOAc/1l
         DxWctRxOEpuIxRaRqLwEzZpSSewWlAYV/7j4DohRUB/APK9UGhNcv/ozQAsQdNCatAEU
         S2IPZJNOGnpCEyNsqgi47P4uV6kn8iUlWImGzNipD41w8/+b2o0bYz2LCDPT8GV0MrV9
         lHQvDSjPHciV6q23+Shl5NMDhWax93m2VX5XDGWThAKOeQ8ZyJLjVd8J9ZCufVsayXlq
         pdNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TL0pxImTrhkdes2Qf58s3VuC8nEsAjomfspwAu0MVyc=;
        b=GoLgXzJv9aCTBUxoeiIfCEv82cjI7bOHN5ppiki7TUkF/Z4VXtHYtOghbpbxWRa140
         0BFOOGM8oaCRlI9vM6QQJQ5mxRsx9UrnuAWF4gxR5euOgbLfeW9GUH2bEUq8Kcn7Jork
         Hl3ETVF2u2aBRxe5vyeFADGbFgjsOoj6nXb/9GED3w7QObkUaFtU1c9whvRU6OFIAsQS
         4BdZgvB1YIdoXU1jGXM/4o5ACQfhHHQ+ObMoQENrYqG+GH/xxAO381nlvvj+MlXLtT90
         tBLZhhgVqKcm1HZMz0U8YyYKOXQJjanBdXcAEi6XaL6EBNEtvY2RXpCz0osynMDjr7uJ
         rjeg==
X-Gm-Message-State: AOAM530d13ubnN8nOKsBOQtmz5bzxYjzGlCozFtpN4GiR8BZPoIuWM7t
        ZnCwdH9VkHBRRmyBpMsURxXblQ==
X-Google-Smtp-Source: ABdhPJwHnlePJ88znmzmkNLDS1ObxPxlZUGp97oorZZTYalOTwNaEX3niKPMv89jB9p/+O7H7YMIpA==
X-Received: by 2002:a05:620a:2019:: with SMTP id c25mr15730909qka.174.1620756496596;
        Tue, 11 May 2021 11:08:16 -0700 (PDT)
Received: from localhost.localdomain (modemcable068.184-131-66.mc.videotron.ca. [66.131.184.68])
        by smtp.gmail.com with ESMTPSA id g5sm17104476qtm.2.2021.05.11.11.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 11:08:16 -0700 (PDT)
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
Subject: [PATCH 08/17] media: camss: csid-170: set the right HALF_CMD when disabled
Date:   Tue, 11 May 2021 14:07:15 -0400
Message-Id: <20210511180728.23781-9-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20210511180728.23781-1-jonathan@marek.ca>
References: <20210511180728.23781-1-jonathan@marek.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the "HALT_CMD_RESUME_AT_FRAME_BOUNDARY" define instead of a "1" which
is otherwise confusing, and add a "HALT_CMD_HALT_AT_FRAME_BOUNDARY" which
is set when disabling.

Fixes: eebe6d00e9bf ("media: camss: Add support for CSID hardware version Titan 170")
Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 drivers/media/platform/qcom/camss/camss-csid-170.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss-csid-170.c b/drivers/media/platform/qcom/camss/camss-csid-170.c
index af134ded241d..9f6334fd68fc 100644
--- a/drivers/media/platform/qcom/camss/camss-csid-170.c
+++ b/drivers/media/platform/qcom/camss/camss-csid-170.c
@@ -105,7 +105,8 @@
 #define CSID_RDI_CTRL(rdi)			((IS_LITE ? 0x208 : 0x308)\
 						+ 0x100 * (rdi))
 #define		RDI_CTRL_HALT_CMD		0
-#define			ALT_CMD_RESUME_AT_FRAME_BOUNDARY	1
+#define			HALT_CMD_HALT_AT_FRAME_BOUNDARY		0
+#define			HALT_CMD_RESUME_AT_FRAME_BOUNDARY	1
 #define		RDI_CTRL_HALT_MODE		2
 
 #define CSID_RDI_FRM_DROP_PATTERN(rdi)			((IS_LITE ? 0x20C : 0x30C)\
@@ -443,7 +444,10 @@ static void csid_configure_stream(struct csid_device *csid, u8 enable)
 	val |= 1 << CSI2_RX_CFG1_MISR_EN;
 	writel_relaxed(val, csid->base + CSID_CSI2_RX_CFG1);
 
-	val = 1 << RDI_CTRL_HALT_CMD;
+	if (enable)
+		val = HALT_CMD_RESUME_AT_FRAME_BOUNDARY << RDI_CTRL_HALT_CMD;
+	else
+		val = HALT_CMD_HALT_AT_FRAME_BOUNDARY << RDI_CTRL_HALT_CMD;
 	writel_relaxed(val, csid->base + CSID_RDI_CTRL(0));
 }
 
-- 
2.26.1

