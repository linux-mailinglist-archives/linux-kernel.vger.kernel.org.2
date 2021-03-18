Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F01C340152
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 09:52:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbhCRIw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 04:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbhCRIwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 04:52:01 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E47E2C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 01:52:00 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id 61so4592935wrm.12
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 01:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DSIM2KKFr13N10pkFzbCvVsAAb9CD2J/MyFkt7g9szU=;
        b=CA700hUJYglYphG7hWhs+QWaHdDggOUb4ENo9IZTXiOYWDmEKwmIZ6iaZ7orORhxJc
         ApqyUHWhUmdY9go/HZ3dUEgcSMgUFFcd138H/EbLKjPzmBrWXuag6JF+49iiCdDZ49me
         fYi5r3tooDhkTFYTEeMSAwJ223ReivQzTuKtB/Jharx2Rq1EE54u/rPq1CrllGe7KV+e
         Ha1qBqsB34mHiH+wcPAfGSCb395h0mW3I4qrLpALGELxE8rz1hCOolaXSX25Fqa9ETgb
         6a8SUNpDVZhcrCORzCH6ailvSHY+lMXFOQIRuWVSWNlq1R1gSQXjIUuF9wyINGos/A+6
         RPRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DSIM2KKFr13N10pkFzbCvVsAAb9CD2J/MyFkt7g9szU=;
        b=d5neBn2rtSNJR4Ce8cQ+x8238WYg9JD54FtM9BrKCk1S9Kgbsub/LjuGOJHR5GfvJX
         apDSVrftyM1e5cmJ369bA/xCeq2mvnNnx267jOOIjL6JPKjCaMT4V4b82bs472Dz0uGn
         7HveUss9xwg29junbk4qVgM1/Jwv1LzmsQd+60xpbR37H6d3GH/Ef2B9M62BWRN/o4sN
         G24KW2lV0oS+Ab0eLPg5ALA3FchtHV4694FU18YXTneSYcvwgbBaunfQ1chHlPSqu7MM
         BMCkPzrPUKXHoDnkDx96SOQmNlzoXt2L5wMWlO6VM6XpDXPOlJLx+uDjplRZVrJESuDa
         Q2Ow==
X-Gm-Message-State: AOAM5335vQaVfXrjaoPBmgoh6sWO2CDr8HtCMOvSnITiWGcUjzFx3uwS
        NxKbvzPD/kDcXxGJ65XCWXW7kA==
X-Google-Smtp-Source: ABdhPJzEPYgbRNUAwcuzE78GENH1iH412dXX0gAwXiEmKzjEbfvmuU6qm40gguyTgpxrotpWTqRWUw==
X-Received: by 2002:adf:83c2:: with SMTP id 60mr8375626wre.386.1616057519679;
        Thu, 18 Mar 2021 01:51:59 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id w131sm1526868wmb.8.2021.03.18.01.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 01:51:59 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-ide@vger.kernel.org
Subject: [PATCH 08/15] ata: pata_sl82c105: Fix potential doc-rot
Date:   Thu, 18 Mar 2021 08:51:43 +0000
Message-Id: <20210318085150.3131936-9-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210318085150.3131936-1-lee.jones@linaro.org>
References: <20210318085150.3131936-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/ata/pata_sl82c105.c:191: warning: expecting prototype for sl82c105_bmdma_end(). Prototype was for sl82c105_bmdma_stop() instead

Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ata/pata_sl82c105.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/pata_sl82c105.c b/drivers/ata/pata_sl82c105.c
index ac7ddd87f188d..8487470e2e01e 100644
--- a/drivers/ata/pata_sl82c105.c
+++ b/drivers/ata/pata_sl82c105.c
@@ -173,7 +173,7 @@ static void sl82c105_bmdma_start(struct ata_queued_cmd *qc)
 }
 
 /**
- *	sl82c105_bmdma_end		-	DMA engine stop
+ *	sl82c105_bmdma_stop		-	DMA engine stop
  *	@qc: ATA command
  *
  *	Reset the DMA engine each use as recommended by the errata
-- 
2.27.0

