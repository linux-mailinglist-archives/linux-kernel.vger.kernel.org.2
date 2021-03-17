Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 824E433ECAC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 10:15:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbhCQJOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 05:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbhCQJNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 05:13:13 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95056C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 02:13:12 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id n11-20020a05600c4f8bb029010e5cf86347so4985012wmq.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 02:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0pHIZHhKpBhGoLa2stZTqH6Rz5RjIRSokSD2h9KbvHc=;
        b=zl+IsVUzggf7c6oUTebPYwinoPM3gAUpTCrNQIXx7CEpVCer3iLd98t6cddrT37fmq
         jksJSH2d30WdxQs/vyqpxmUMgjkQfz7uSLj43mckJ8QUHs8teBBmZGItrc9KDL4y7pt3
         tOFsIihDrg4v4a5Cr/i6mCH5XtisB1kjRlkUjcSGf5lCa7Y2FLETtMxKUUQSlxaMiqiv
         fFPQfsiDq3E3m4CEN9syAkcN2OBQoQSDu56fybhjF7eRyN7pwglpm4p8PE0QYuKX6TWV
         4r+ilX3dA6qcVefi8gp4ToF8aOoYoSNUVqa4t9iNwmvoBhsSI7gVGcJnMh0lzY/pqoX3
         qikw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0pHIZHhKpBhGoLa2stZTqH6Rz5RjIRSokSD2h9KbvHc=;
        b=P7eq9cKV7Syr1tJ63+Psm0alpa6cv1Rm95CdP+zL5KJXjWp5EGoX/JQxFH+lSMEjMe
         AbQqaIbxodOQbn5iAUe4jweX4idnuPMvrE9TDv0Q2Gkq8rwOUW14WnfEHaKW8t1trZIl
         CJGvKMO8JnrZxls+IBtbBQkRsecX7w12LgQ4REt7urvKApmkj9djT11YIWaRLc5Mj9vl
         /tsngS07iH6M0kxz8NEqq6FxXp86chEytLm31V33/weQLl5iDU+xP1QyKcITvLeTtXDm
         DDEizhNOPmt7CymcYWtkALDgSVrFvGYDIgmCnLDIJ1UiN3W+KE3jnzrS4qfUDVELqxwS
         ATPQ==
X-Gm-Message-State: AOAM530UzKoDbnvtQtxHqS4dCMCpMkL70ADiCvEQPi4JU1lvzshApD2n
        cpbQ4rsAP4UgvxhE0VkxE5dVo9agUCLe+Q==
X-Google-Smtp-Source: ABdhPJzQ5xBud4Eh400byYzDFHJYsOFWPS4jWuaPzcNcq3BgxqDs47Uqg1vJeNLu88Rpk/O/l3EAyQ==
X-Received: by 2002:a1c:b48a:: with SMTP id d132mr2637817wmf.108.1615972391306;
        Wed, 17 Mar 2021 02:13:11 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id e18sm12695886wru.73.2021.03.17.02.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 02:13:10 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        "Manoj N. Kumar" <manoj@linux.ibm.com>,
        "Matthew R. Ochs" <mrochs@linux.ibm.com>,
        Uma Krishnan <ukrishn@linux.ibm.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Subject: [PATCH 31/36] scsi: cxlflash: main: Fix a little do-rot
Date:   Wed, 17 Mar 2021 09:12:25 +0000
Message-Id: <20210317091230.2912389-32-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210317091230.2912389-1-lee.jones@linaro.org>
References: <20210317091230.2912389-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/cxlflash/main.c:1369: warning: Function parameter or member 'hwq' not described in 'process_hrrq'
 drivers/scsi/cxlflash/main.c:1369: warning: Excess function parameter 'afu' description in 'process_hrrq'
 drivers/scsi/cxlflash/main.c:2005: warning: Function parameter or member 'index' not described in 'init_mc'
 drivers/scsi/cxlflash/main.c:3303: warning: Function parameter or member 'lunprov' not described in 'cxlflash_lun_provision'
 drivers/scsi/cxlflash/main.c:3303: warning: Excess function parameter 'arg' description in 'cxlflash_lun_provision'
 drivers/scsi/cxlflash/main.c:3397: warning: Function parameter or member 'afu_dbg' not described in 'cxlflash_afu_debug'
 drivers/scsi/cxlflash/main.c:3397: warning: Excess function parameter 'arg' description in 'cxlflash_afu_debug'

Cc: "Manoj N. Kumar" <manoj@linux.ibm.com>
Cc: "Matthew R. Ochs" <mrochs@linux.ibm.com>
Cc: Uma Krishnan <ukrishn@linux.ibm.com>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/cxlflash/main.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/cxlflash/main.c b/drivers/scsi/cxlflash/main.c
index e72440d919d2a..dc36531d589e2 100644
--- a/drivers/scsi/cxlflash/main.c
+++ b/drivers/scsi/cxlflash/main.c
@@ -1357,7 +1357,7 @@ static irqreturn_t cxlflash_sync_err_irq(int irq, void *data)
 
 /**
  * process_hrrq() - process the read-response queue
- * @afu:	AFU associated with the host.
+ * @hwq:	HWQ associated with the host.
  * @doneq:	Queue of commands harvested from the RRQ.
  * @budget:	Threshold of RRQ entries to process.
  *
@@ -1997,7 +1997,7 @@ static enum undo_level init_intr(struct cxlflash_cfg *cfg,
 /**
  * init_mc() - create and register as the master context
  * @cfg:	Internal structure associated with the host.
- * index:	HWQ Index of the master context.
+ * @index:	HWQ Index of the master context.
  *
  * Return: 0 on success, -errno on failure
  */
@@ -3294,7 +3294,7 @@ static char *decode_hioctl(unsigned int cmd)
 /**
  * cxlflash_lun_provision() - host LUN provisioning handler
  * @cfg:	Internal structure associated with the host.
- * @arg:	Kernel copy of userspace ioctl data structure.
+ * @lunprov:	Kernel copy of userspace ioctl data structure.
  *
  * Return: 0 on success, -errno on failure
  */
@@ -3385,7 +3385,7 @@ static int cxlflash_lun_provision(struct cxlflash_cfg *cfg,
 /**
  * cxlflash_afu_debug() - host AFU debug handler
  * @cfg:	Internal structure associated with the host.
- * @arg:	Kernel copy of userspace ioctl data structure.
+ * @afu_dbg:	Kernel copy of userspace ioctl data structure.
  *
  * For debug requests requiring a data buffer, always provide an aligned
  * (cache line) buffer to the AFU to appease any alignment requirements.
-- 
2.27.0

