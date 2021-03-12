Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA0233892A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 10:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233455AbhCLJtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 04:49:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233130AbhCLJsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 04:48:18 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC39C061761
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 01:48:17 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id w203-20020a1c49d40000b029010c706d0642so4242400wma.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 01:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6g1k4NOJoIyIgRaKDu88zZvT9OX+R02WPv1Cq13vbSs=;
        b=GCHdIzAfYgsCay1B9SS+ZnYX0FYvTV60z5kscOccdfQV3WQUrWFvmOu2dh4+gP89WM
         bvP80g3F7eroGfdguGDDSx4CjsyHon4vWTUBzei/1s99cuO2eHYz98pRvVCveRwwSwZT
         UYokGX4YRNP/W1xJhVn7xnIXvDQXNT3mTKcbs5L8MLLRiQ/5prYIip+cmM/E3f8FCKhl
         UytLiD2rl+tZT9E8/edeF5IccIxaFomixfihGZWAxohzM5NqsjEn4eSj1ufE14Po8N1j
         ltteuMX4MDBUHBaTcngGraUBgKyxbrxHyLdhkIiDG3krqtoTR6rsQebt+C1bLmiKbJBV
         3LSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6g1k4NOJoIyIgRaKDu88zZvT9OX+R02WPv1Cq13vbSs=;
        b=lFwR8RXuBbR/IUdI76NoG46Wni8fTY2FyuqfK6pjv1D2clyQTJAT50BYULTg29wEr/
         w9GJlDcXkhONCTllgyGhOAoC9Nx0ynxbkpJNgZLa2dTlaj0EZ4Ol7AwCDm9fOWfoErYQ
         IsnvrNmgSPRaKq8CkVLYf+I1I+q3Uh0Uc0JnYPguOGB0r3Kp3gxySlg5iUBtzOAiFQRg
         uM++rkAJrX/6FbNNrJiX8k/mR3AnEmLi9uO7Yi9rqBveXnNgxyFtVCpJD/LN9/LVAcpM
         1ok/sG+yFYTzr4irAb+dng2mpHrzzORMAUykoDMtlu7ZKTtjM+BVQFXkffJJznTZ/prq
         cpzA==
X-Gm-Message-State: AOAM533Z5+cVxbW8d+ZGevLIaf+KJyGbxujm/tGpkb2oIHH1qQO4rd5w
        QagIw8CXpjbiDBJOKUZQHHYX/g==
X-Google-Smtp-Source: ABdhPJyTjzB26opz3HQn+LVBBuiOy0UuqXf2qbpSM1j3b5m1i7Lc/kJkb4ZwVFW3xsVria9vr0PCRg==
X-Received: by 2002:a1c:7916:: with SMTP id l22mr12001434wme.86.1615542496455;
        Fri, 12 Mar 2021 01:48:16 -0800 (PST)
Received: from dell.default ([91.110.221.204])
        by smtp.gmail.com with ESMTPSA id f7sm1539536wmq.11.2021.03.12.01.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 01:48:16 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Adam Radford <aradford@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Joel Jacobson <linux@3ware.com>,
        de Melo <acme@conectiva.com.br>,
        Andre Hedrick <andre@suse.com>, linux-scsi@vger.kernel.org
Subject: [PATCH 28/30] scsi: 3w-xxxx: Remove 2 unused variables 'response_que_value' and 'tw_dev'
Date:   Fri, 12 Mar 2021 09:47:36 +0000
Message-Id: <20210312094738.2207817-29-lee.jones@linaro.org>
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

 drivers/scsi/3w-xxxx.c: In function ‘tw_empty_response_que’:
 drivers/scsi/3w-xxxx.c:463:24: warning: variable ‘response_que_value’ set but not used [-Wunused-but-set-variable]
 drivers/scsi/3w-xxxx.c: In function ‘tw_scsi_biosparam’:
 drivers/scsi/3w-xxxx.c:1345:23: warning: variable ‘tw_dev’ set but not used [-Wunused-but-set-variable]

Cc: Adam Radford <aradford@gmail.com>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Joel Jacobson <linux@3ware.com>
Cc: de Melo <acme@conectiva.com.br>
Cc: Andre Hedrick <andre@suse.com>
Cc: linux-scsi@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/3w-xxxx.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/3w-xxxx.c b/drivers/scsi/3w-xxxx.c
index d90b9fca4aea2..a7292883b72bc 100644
--- a/drivers/scsi/3w-xxxx.c
+++ b/drivers/scsi/3w-xxxx.c
@@ -460,12 +460,12 @@ static int tw_check_errors(TW_Device_Extension *tw_dev)
 /* This function will empty the response que */
 static void tw_empty_response_que(TW_Device_Extension *tw_dev)
 {
-	u32 status_reg_value, response_que_value;
+	u32 status_reg_value;
 
 	status_reg_value = inl(TW_STATUS_REG_ADDR(tw_dev));
 
 	while ((status_reg_value & TW_STATUS_RESPONSE_QUEUE_EMPTY) == 0) {
-		response_que_value = inl(TW_RESPONSE_QUEUE_REG_ADDR(tw_dev));
+		inl(TW_RESPONSE_QUEUE_REG_ADDR(tw_dev));
 		status_reg_value = inl(TW_STATUS_REG_ADDR(tw_dev));
 	}
 } /* End tw_empty_response_que() */
@@ -1342,10 +1342,8 @@ static int tw_scsi_biosparam(struct scsi_device *sdev, struct block_device *bdev
 			     sector_t capacity, int geom[])
 {
 	int heads, sectors, cylinders;
-	TW_Device_Extension *tw_dev;
 
 	dprintk(KERN_NOTICE "3w-xxxx: tw_scsi_biosparam()\n");
-	tw_dev = (TW_Device_Extension *)sdev->host->hostdata;
 
 	heads = 64;
 	sectors = 32;
-- 
2.27.0

