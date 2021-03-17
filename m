Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C08AA33EC0C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 09:58:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbhCQI6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 04:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbhCQI53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 04:57:29 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09BEC0613D7
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 01:57:17 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id g25so1021915wmh.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 01:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=953zZzIFTk8WBz/FuB+6aJVYCMmR1USbvaybVRbnoaU=;
        b=fN4I7yFb3bT0agUZAuKKK9MV20bGKoUYv0gAijUMS2TNYQQvzkAoGdQgUJ3K51szki
         fTF8u3u60XNSbvef7u15WZrwakRolIlNMlhFEQfADUUS7mDxS1zOthkwvkOCENpM8EMo
         ujHu5fizvEkphyoTeyn/AA5Vf6R7sh2LH2O+vBRV+A1KZVFEQ5M9s9HPrw4Oo2gwJO4L
         CSS1OcRGjL4WElyE0yxy/zqZVPhbj2Cl4yKPIXj6fZQHlwNVTC9d4jC1dTD+NGJQTyBN
         GC9EIjopVXqh9rGgjSDv2l9hReRYQfd7tce1bQwII+m120TsKuCYZ85gtJYAOYg5zBnq
         YxQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=953zZzIFTk8WBz/FuB+6aJVYCMmR1USbvaybVRbnoaU=;
        b=po8n14+2U46mb5uXXjBk3c7+hi0cPl1oM4aTu3Fu9zX63qU7N2OX8tITqVl2/tDqfv
         T865uTYpoOwCly/TKB+K2g3AXyapfN8EIS4qy94V6jgRlnEL9RB0R9cnJlBkU+TnwHMB
         dNqsPve1RgAkMK/Gj6v0A3QSL25miqe++hbQbuIHALkej7nuJhXEVGbhVW8wHeNhmB/x
         +2RGNdQaFDLjcTes1Tv8xsfD/xKsE52GACW158E/aWiUXvP7Z9XRpX5Hqu9BaQj9gYAw
         ysC3QD9/yO0uGFJQkmMvuEHd5Iuooq8DQz0dcFit21sLMeDNVGCJNwEpNR9Mlz7Ac0dQ
         I8nQ==
X-Gm-Message-State: AOAM532G03jT/7KeDRsPmPfKCM5pl1mucitSGD/t7pkphfbfVtjPWYmc
        LBVCo9H6lPlZLbgRRLB5xe4aZw==
X-Google-Smtp-Source: ABdhPJxVE0cd3tfdS9zvh2oezWLmBGKpwJPkLXFlFaytd8aVRlYU14e2Z5bxQHn7n06CvfzPplnUtQ==
X-Received: by 2002:a7b:c35a:: with SMTP id l26mr2660180wmj.104.1615971436636;
        Wed, 17 Mar 2021 01:57:16 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id j123sm1807243wmb.1.2021.03.17.01.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 01:57:16 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Adam Radford <aradford@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Subject: [PATCH 11/18] scsi: 3w-9xxx: Remove a few set but unused variables
Date:   Wed, 17 Mar 2021 08:56:54 +0000
Message-Id: <20210317085701.2891231-12-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210317085701.2891231-1-lee.jones@linaro.org>
References: <20210317085701.2891231-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/3w-9xxx.c: In function ‘twa_empty_response_queue’:
 drivers/scsi/3w-9xxx.c:942:24: warning: variable ‘response_que_value’ set but not used [-Wunused-but-set-variable]
 drivers/scsi/3w-9xxx.c: In function ‘twa_scsi_biosparam’:
 drivers/scsi/3w-9xxx.c:1701:23: warning: variable ‘tw_dev’ set but not used [-Wunused-but-set-variable]
 drivers/scsi/3w-9xxx.c: In function ‘twa_scsiop_execute_scsi’:
 drivers/scsi/3w-9xxx.c:1812:22: warning: variable ‘sglist’ set but not used [-Wunused-but-set-variable]

Cc: Adam Radford <aradford@gmail.com>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/3w-9xxx.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/scsi/3w-9xxx.c b/drivers/scsi/3w-9xxx.c
index b96e82de4237d..47028f5e57abd 100644
--- a/drivers/scsi/3w-9xxx.c
+++ b/drivers/scsi/3w-9xxx.c
@@ -939,13 +939,13 @@ static int twa_decode_bits(TW_Device_Extension *tw_dev, u32 status_reg_value)
 /* This function will empty the response queue */
 static int twa_empty_response_queue(TW_Device_Extension *tw_dev)
 {
-	u32 status_reg_value, response_que_value;
+	u32 status_reg_value;
 	int count = 0, retval = 1;
 
 	status_reg_value = readl(TW_STATUS_REG_ADDR(tw_dev));
 
 	while (((status_reg_value & TW_STATUS_RESPONSE_QUEUE_EMPTY) == 0) && (count < TW_MAX_RESPONSE_DRAIN)) {
-		response_que_value = readl(TW_RESPONSE_QUEUE_REG_ADDR(tw_dev));
+		readl(TW_RESPONSE_QUEUE_REG_ADDR(tw_dev));
 		status_reg_value = readl(TW_STATUS_REG_ADDR(tw_dev));
 		count++;
 	}
@@ -1698,9 +1698,6 @@ static int twa_reset_sequence(TW_Device_Extension *tw_dev, int soft_reset)
 static int twa_scsi_biosparam(struct scsi_device *sdev, struct block_device *bdev, sector_t capacity, int geom[])
 {
 	int heads, sectors, cylinders;
-	TW_Device_Extension *tw_dev;
-
-	tw_dev = (TW_Device_Extension *)sdev->host->hostdata;
 
 	if (capacity >= 0x200000) {
 		heads = 255;
@@ -1809,14 +1806,11 @@ static int twa_scsiop_execute_scsi(TW_Device_Extension *tw_dev, int request_id,
 	u32 num_sectors = 0x0;
 	int i, sg_count;
 	struct scsi_cmnd *srb = NULL;
-	struct scatterlist *sglist = NULL, *sg;
+	struct scatterlist *sg;
 	int retval = 1;
 
-	if (tw_dev->srb[request_id]) {
+	if (tw_dev->srb[request_id])
 		srb = tw_dev->srb[request_id];
-		if (scsi_sglist(srb))
-			sglist = scsi_sglist(srb);
-	}
 
 	/* Initialize command packet */
 	full_command_packet = tw_dev->command_packet_virt[request_id];
-- 
2.27.0

