Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C324B3A0732
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 00:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235450AbhFHWlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 18:41:22 -0400
Received: from mail-qt1-f175.google.com ([209.85.160.175]:40908 "EHLO
        mail-qt1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235397AbhFHWlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 18:41:03 -0400
Received: by mail-qt1-f175.google.com with SMTP id t9so10082714qtw.7
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 15:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v1xMzXmW4I8A20yjy4AJ9Bre8Zlk0ksm9chOAJeMj/U=;
        b=CYGqoeVnx4rMzz+HeBXV4/4Reh2bBFmtJn0nqGSgSPqkrhmgooh5EN0gUOWB/KVmxs
         KAMBdi7cT0x4yb7I08HyOe1afZDKaOAgts4wgvuh92E4LI/0dBw58KAb/lVjV2sAn3xO
         FTAUO+SM4iOK4Sp1OoNThF6BEgzSjFFyq2iLMDbStUPZwmsiz2lPes0FqSIZuUf61EPI
         yo/Twvg0ZbOniepw5JA7XXrHNG3RD+wq6N0M0qnjZFCFvr4vjjuDmX6eiIdh6ar1WoSv
         llGtqpL6rg042MGIk5MnhmyZtsBHya1YteDS3Su0HTTv1vd0PnsnkUe3U/rdqRC8slcl
         st5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v1xMzXmW4I8A20yjy4AJ9Bre8Zlk0ksm9chOAJeMj/U=;
        b=IpO893xDBSGMIQlSXXGZvjmT8NpWZiMY+gdxLPrRXM9BtjMiAxR+2srCaGBluFXiXs
         NclR8exXtSusl6L+r+ajLPZDZQvJR/lombccEz3grGNw2hPEI6mqNpo90Hb3Eo6dwCTl
         1qlwYnzjzlN/JzHZyGfqIStIGxKXwzmtUQRJidzUBtvVMZ1nID4X/+8TvQP8t3lKoeb0
         HDJX9T1eVaBI34vMYqmOURdGy3js6Wq8GYbzvEFXCLO/L9eDQYwhc2t8PSX5zX04Goa0
         FCZRzIjv9v3oLGsNMS8a/3NYM/L/4qfOp/L76xJcF95FMboMlfWiJy/DEMVDC+EI4sxA
         eHvA==
X-Gm-Message-State: AOAM530tQ8OO1edRvs6jelbRefMrV4dfPEY1jMjNeotC6N4d1LyeZhlC
        MWBuWlSwpImcX0nEGYVcH1SF8w==
X-Google-Smtp-Source: ABdhPJxPJ7139kfkP3asQjYjHTq0Q0zZhjYefdq0sumHlkAT/u8hSy/RpZYYqnmbPY7Hq5whpoTgtQ==
X-Received: by 2002:ac8:5bc1:: with SMTP id b1mr22672747qtb.161.1623191875339;
        Tue, 08 Jun 2021 15:37:55 -0700 (PDT)
Received: from localhost.localdomain (modemcable068.184-131-66.mc.videotron.ca. [66.131.184.68])
        by smtp.gmail.com with ESMTPSA id m3sm2324266qkh.135.2021.06.08.15.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 15:37:55 -0700 (PDT)
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
Subject: [PATCH 08/17] media: camss: csid-170: set the right HALT_CMD when disabled
Date:   Tue,  8 Jun 2021 18:34:57 -0400
Message-Id: <20210608223513.23193-9-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20210608223513.23193-1-jonathan@marek.ca>
References: <20210608223513.23193-1-jonathan@marek.ca>
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
Reviewed-by: Robert Foss <robert.foss@linaro.org>
---
 drivers/media/platform/qcom/camss/camss-csid-170.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss-csid-170.c b/drivers/media/platform/qcom/camss/camss-csid-170.c
index 2c84d40fe3e04..22a7d7ad63403 100644
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
@@ -444,7 +445,10 @@ static void csid_configure_stream(struct csid_device *csid, u8 enable)
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

