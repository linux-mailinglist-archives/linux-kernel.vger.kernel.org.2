Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6FB337AE12
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 20:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbhEKSKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 14:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232084AbhEKSJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 14:09:30 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 763FDC06138D
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 11:08:23 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id q136so19651918qka.7
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 11:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kHxF6L8K7UGYMQtKo4by9VSR3+YoFYHBzQNRgF6jcls=;
        b=Uk++7S6XxPE6zONdFYOfoSzSv5FU1/6M0TiFHKWIHDbc6QsvsbAG5yQvEWO2lJO3M8
         3HIy9zxsg4M1rVbtN7Fg6+DxNr8pApt3DWf0HagQJmX3vWhR1ejuMkZ/HL/4PhDoRaJk
         7UCGbpjAbCBpXHWzxZOmAtFyRWQkxNWk2Rwjt+kf3AnByN5RLCW64Eh+kt4LrjPz7BEu
         SGxVRb6mpNtTUtp5qnRe8ficKKvvsIEfbMrPGCy8KS2epKo+fOt2cY+jBqjMKjI2f0QK
         /rI5V3OLKnkqOeZR/uqeIe/IaATns89BA00/xd0TAvgHBQjbPxW6DNDiCewlhGXqQPJC
         74wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kHxF6L8K7UGYMQtKo4by9VSR3+YoFYHBzQNRgF6jcls=;
        b=b/jv2UnB1ZUyagVr0/AWmMhrGKEZl6hoqF4MTP0HOJypMfOuqBp1ua3u1UdU4o/FlH
         2p4NlkeoMp4Rwl3aymoGDMKs8TdWSHaCLiQHzX45/OipeJGHxUNV0ZZ5VRNXCLHDMNNs
         7E73C3vpvFWuGNGxO+o28/QWYPfkISAqGU/ChvaefG0hD1d5nKjxdTNHdbKosy867zNa
         1T/4QION/+wbESvnKPIGVACliX6DoMK6qcDk0v/P0i7INxbot5RXxKb63TBnAvq3onJn
         zaDnFAreivfwFQqoKGylL8+01g+pPvbcGxMFq/CSU3TPcRCpe5Zob+eAXsowMXgvw5u7
         iFCQ==
X-Gm-Message-State: AOAM532uApXwjQi1Xe9Z8IkM+ddwb1rUP0pp3QRrGWXGAIa9Lu64gDO/
        2bzfIUoBBkjor3oqde6cXOIg6A==
X-Google-Smtp-Source: ABdhPJyxXiBq5FGVjuG8DFH8RobC8xPCrjw6GF420gxa1sRYncaTUclKlSEELiBuJAqU2qa34g0GFg==
X-Received: by 2002:a05:620a:2115:: with SMTP id l21mr29007196qkl.342.1620756502744;
        Tue, 11 May 2021 11:08:22 -0700 (PDT)
Received: from localhost.localdomain (modemcable068.184-131-66.mc.videotron.ca. [66.131.184.68])
        by smtp.gmail.com with ESMTPSA id g5sm17104476qtm.2.2021.05.11.11.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 11:08:22 -0700 (PDT)
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
Date:   Tue, 11 May 2021 14:07:20 -0400
Message-Id: <20210511180728.23781-14-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20210511180728.23781-1-jonathan@marek.ca>
References: <20210511180728.23781-1-jonathan@marek.ca>
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
---
 drivers/media/platform/qcom/camss/camss-vfe-170.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss-vfe-170.c b/drivers/media/platform/qcom/camss/camss-vfe-170.c
index 076ca082e107..080eef767d3b 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe-170.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe-170.c
@@ -363,17 +363,7 @@ static irqreturn_t vfe_isr(int irq, void *dev)
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

