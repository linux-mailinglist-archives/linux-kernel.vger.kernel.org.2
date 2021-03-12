Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68FFE33892B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 10:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233475AbhCLJtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 04:49:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233132AbhCLJsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 04:48:19 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5893C061764
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 01:48:18 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id n11-20020a05600c4f8bb029010e5cf86347so4235743wmq.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 01:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=953zZzIFTk8WBz/FuB+6aJVYCMmR1USbvaybVRbnoaU=;
        b=TJ235tKzTr+0UDs6L+L/8surRmTFXWS0yvtC2LBubxd2ZLncAEP5MMGOymfDsCzi/w
         lV4PTKQf/9gFXbxeGHmY4QWgP6OjyxuWGo9r2LPI6JIT8RavfmDo5gVb8YIWx4UuwDRz
         DOep/3VfSFr9pmxODIdLdSHO17wfQ7T5LW/X1omMmCkCc4vhcXJx2Hy9YGMqIELBs+GS
         4CS0uxT2ITVmiRyTMgUIEHxWnkaL76PzlmMZoxRa0C4HAkqZDHrCx/BESIBMdmlKesTM
         vNUXNyK6M4voh7pm3voi3uI4JpuUBvvxg5f80hR0lwJwl++t1AcjU28HPB6J6d7Ts4+z
         q8DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=953zZzIFTk8WBz/FuB+6aJVYCMmR1USbvaybVRbnoaU=;
        b=CLWf5cr4vW+0fH58w1FOEhcVDCS4nesLP0hs7upQixJd3j5pFxTKzVzilGwN3ZKLJp
         SFm0qVEJbVICbp6C9LMEBF4i4KtyjBL3xclKnY7ys0kF/bAar1C7TD6XVbOzWPqAErb+
         SCMA52EnhEDYGNi3V+M1ifkAdSXO+Tp7rkY6FBnQeqfB/Kc5qICX6ayepuOKVz3sGA5M
         B461l3EY1xfwo2K1vgk3Mp2YI8wInJjO7xTEx3fqXnNZx9AlEzPZmywySIX/s8h4Op1U
         nieyzsevLV+EtymO95I0p/WY67tnjvXKKh4iiDG0VYMR973xeeMGDMAiewVokf4TvZhg
         lJ/Q==
X-Gm-Message-State: AOAM532PzDoQRWizhOkwaCgco4ZWoRQV66assfJrJLIMyej9LxE6Ks64
        UmTWWHhPTNLhEwOmKl+vvcpb9g==
X-Google-Smtp-Source: ABdhPJxENwFbPR1Qi3QEoJE/0xy1tsf3Pt5/PaL2hx9dKdCMGSjdmCWEiKK8XLUEG9961p3Qvkfa4Q==
X-Received: by 2002:a1c:7905:: with SMTP id l5mr12329070wme.181.1615542497362;
        Fri, 12 Mar 2021 01:48:17 -0800 (PST)
Received: from dell.default ([91.110.221.204])
        by smtp.gmail.com with ESMTPSA id f7sm1539536wmq.11.2021.03.12.01.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 01:48:16 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Adam Radford <aradford@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Subject: [PATCH 29/30] scsi: 3w-9xxx: Remove a few set but unused variables
Date:   Fri, 12 Mar 2021 09:47:37 +0000
Message-Id: <20210312094738.2207817-30-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210312094738.2207817-1-lee.jones@linaro.org>
References: <20210312094738.2207817-1-lee.jones@linaro.org>
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

