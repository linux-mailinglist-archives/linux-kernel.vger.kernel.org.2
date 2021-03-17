Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C838733EC71
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 10:13:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbhCQJNL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 05:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbhCQJMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 05:12:49 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 146AAC061760
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 02:12:49 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id v4so990997wrp.13
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 02:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JOb+P/qw104YPM5H9Pk4ZXuOVMmz3snbpqZtEzxVXZA=;
        b=F1h9XpvvlAIfIaTIkV910sK2Dtfb9XwkVVfR/pBYqkkhyXvxA6dE/288OwsBxgb0+h
         kuNekb0Wva2qFigdWkqcNEOXvOoiAUK7KKb20zkPxk3Lo2IBg4gCQ/S7x40AXiIcVXBt
         xaHoN3HLXxGGbrOLe0/O1u3xMDQtPiK6bM0lD2QhG48Qfskhi+Qc4vaT/ImCWVMN8h1n
         UhSpU54xHEmcIz6v14p2tFZ5sMcJjalNQWiOrErgbSYL3499emaJbMxxwmsVHwIBIrTy
         W4lX0d9BiGRxtBPKYqxWnFJwWRZq/dfZ/SQpX9SDzU9Jwc9sBPlDwqV8+oMhIluNllQ0
         TMLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JOb+P/qw104YPM5H9Pk4ZXuOVMmz3snbpqZtEzxVXZA=;
        b=PK9FDrOnDxcAFvoIxcMjueOVt4ZCu7IMJrRJ3nRt0tLPR/XLAx6jmDw4E/on1OngHu
         UpVkhQVGBEfuV/BOqGd5i0SQJX/DT0Lc+00C2vQ2kPlMyyer4xVurblxj9R7yF8iqawR
         rDpBTprl98Qw+JnDscwzORl0aybSHyfsSMog5Ar9oEWrgqBYKhZBL7aLcvzmH24wdLyU
         WvGsogwZ6jmzEcHOnOrNdClci3er/aJMoJUO1dqHyhvlbl8YqbWdfIMSE0PhpNQDpZ+V
         SneW8OKot5n2G3ChTuDo/8aCyYivQyz+nX+mE0CbhV8uChWB3A9IaC97fKQn8JTeAl4h
         2j3g==
X-Gm-Message-State: AOAM532A6uPM7HU+nonT3AFpWihE/W7JRODJiZF17vAJ7UFkQOAzqFEo
        2LJLgUWdWLg7URhMheJTV/mVfg==
X-Google-Smtp-Source: ABdhPJwyw3IY56GgaarfpoxnIhJ43nSxiB70jKffGjLrw+e5KuXQi2wAjXliozYP4OSdytEqE1mBMw==
X-Received: by 2002:adf:df10:: with SMTP id y16mr3323925wrl.372.1615972367856;
        Wed, 17 Mar 2021 02:12:47 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id e18sm12695886wru.73.2021.03.17.02.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 02:12:47 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Subbu Seetharaman <subbu.seetharaman@broadcom.com>,
        Ketan Mukadam <ketan.mukadam@broadcom.com>,
        Jitendra Bhivare <jitendra.bhivare@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-drivers@broadcom.com, linux-scsi@vger.kernel.org
Subject: [PATCH 08/36] scsi: be2iscsi: be_main: Ensure function follows directly after its header
Date:   Wed, 17 Mar 2021 09:12:02 +0000
Message-Id: <20210317091230.2912389-9-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210317091230.2912389-1-lee.jones@linaro.org>
References: <20210317091230.2912389-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/be2iscsi/be_main.c:4935: warning: expecting prototype for beiscsi_show_boot_tgt_info(). Prototype was for BEISCSI_SYSFS_ISCSI_BOOT_FLAGS() instead

Cc: Subbu Seetharaman <subbu.seetharaman@broadcom.com>
Cc: Ketan Mukadam <ketan.mukadam@broadcom.com>
Cc: Jitendra Bhivare <jitendra.bhivare@broadcom.com>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-drivers@broadcom.com
Cc: linux-scsi@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/be2iscsi/be_main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/scsi/be2iscsi/be_main.c b/drivers/scsi/be2iscsi/be_main.c
index ab32ca535078d..eac67878b2b1b 100644
--- a/drivers/scsi/be2iscsi/be_main.c
+++ b/drivers/scsi/be2iscsi/be_main.c
@@ -4926,14 +4926,13 @@ void beiscsi_start_boot_work(struct beiscsi_hba *phba, unsigned int s_handle)
 	schedule_work(&phba->boot_work);
 }
 
+#define BEISCSI_SYSFS_ISCSI_BOOT_FLAGS	3
 /**
  * beiscsi_show_boot_tgt_info()
  * Boot flag info for iscsi-utilities
  * Bit 0 Block valid flag
  * Bit 1 Firmware booting selected
  */
-#define BEISCSI_SYSFS_ISCSI_BOOT_FLAGS	3
-
 static ssize_t beiscsi_show_boot_tgt_info(void *data, int type, char *buf)
 {
 	struct beiscsi_hba *phba = data;
-- 
2.27.0

