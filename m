Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3020C3388F0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 10:48:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233029AbhCLJsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 04:48:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232909AbhCLJrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 04:47:52 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EFA2C061761
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 01:47:52 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id e10so4417615wro.12
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 01:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GvcOU9KB17xhaNjCrnAPnFFy7MF4/6/f5i41ACjeLUY=;
        b=IBfRbWkpboIyMwMp/jPVoOSWulevaUTPPqVD+jSxC3pzYsUkhwZm+8uDnHXXA6srhg
         Pk1j1KpiyHY4EbrBHxwnrzpNyIJQmQBeL4ouopXljRHdyBRKxr08UWUtGJ+dCYY9CCyY
         BS+JOSNdFRrwsdTnSelJhlI7MoRFhmF2cmB3x8n2ZUdSxlH65FOlRB2SjUkJiXRq0BIm
         H4MtC1k/sYeuZuyHBz5xWdn1Si6bMzyuO83gFui93EfCDY18C9td1I1aCzqckyUc9lbz
         9nSm+aWvRE2s3PEZETwiFiILMSfGthwi4bVd5/Pir64o+R2219H4rJICLo9nYjvQpZYz
         z+pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GvcOU9KB17xhaNjCrnAPnFFy7MF4/6/f5i41ACjeLUY=;
        b=NW/rAwtDP2b7LYIojV93MO39GgWx5gzB40Pc06cRKMlF4zDkWXWL7Ce+zpY1gVuAS7
         ZE4XSp4ZUJFnMQK50wsfCXCpdaecz6XoiQ8oQChgBMB98CduJJ6GWtTrOobEMiZQGLz1
         W593x5qcI6MyZQ7rmYmZGUv3r78gAG95dDPonbtaXguH1DhvpVOjyXF84PqsGFU/DwK2
         +/OoGCXFeUvXbSSUQvd7mPQaAziaTPd/vCIsY8UNuK5tyOCg5j5hVS0lSC1mra8SJWoz
         TzNRZABDPYr1jkYkMeT/EJ9i2qMwXyreu5oBYHYeoV7Cd2/k2pFt2bad890tK3/VD1M4
         L6Hg==
X-Gm-Message-State: AOAM5303JbVVB5r0WHdb6WIC5RCMECUwM1M2gZBU2rBZ5BUKYvfWdTkd
        PTCcpglBhFnhrX70oT4VbIvICw==
X-Google-Smtp-Source: ABdhPJyle5qhx7ikejNmByrUqCTOPH+IAyRTZ31+I8JjFcNjDJysq7mnoznoPd+Eo9N/SNCpUwTUWg==
X-Received: by 2002:adf:d851:: with SMTP id k17mr13274762wrl.254.1615542471088;
        Fri, 12 Mar 2021 01:47:51 -0800 (PST)
Received: from dell.default ([91.110.221.204])
        by smtp.gmail.com with ESMTPSA id f7sm1539536wmq.11.2021.03.12.01.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 01:47:50 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Santosh Yaraganavi <santosh.sy@samsung.com>,
        Vinayak Holikatti <h.vinayak@samsung.com>,
        linux-scsi@vger.kernel.org
Subject: [PATCH 02/30] scsi: ufs: ufshcd: Fix incorrectly named ufshcd_find_max_sup_active_icc_level()
Date:   Fri, 12 Mar 2021 09:47:10 +0000
Message-Id: <20210312094738.2207817-3-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210312094738.2207817-1-lee.jones@linaro.org>
References: <20210312094738.2207817-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/ufs/ufshcd.c:7142: warning: expecting prototype for ufshcd_calc_icc_level(). Prototype was for ufshcd_find_max_sup_active_icc_level() instead

Cc: Alim Akhtar <alim.akhtar@samsung.com>
Cc: Avri Altman <avri.altman@wdc.com>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Santosh Yaraganavi <santosh.sy@samsung.com>
Cc: Vinayak Holikatti <h.vinayak@samsung.com>
Cc: linux-scsi@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/ufs/ufshcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index b65c2899aae41..ffbea9f51dfef 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -7146,7 +7146,7 @@ static u32 ufshcd_get_max_icc_level(int sup_curr_uA, u32 start_scan, char *buff)
 }
 
 /**
- * ufshcd_calc_icc_level - calculate the max ICC level
+ * ufshcd_find_max_sup_active_icc_level - calculate the max ICC level
  * In case regulators are not initialized we'll return 0
  * @hba: per-adapter instance
  * @desc_buf: power descriptor buffer to extract ICC levels from.
-- 
2.27.0

