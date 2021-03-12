Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5A4533890B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 10:49:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233102AbhCLJso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 04:48:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232999AbhCLJsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 04:48:01 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B3B9C061761
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 01:48:00 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id b9so1407349wrt.8
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 01:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ulNuxr60llkoiFafxIlb+CHi87OxQ5J+B08tO2koRaI=;
        b=wLD8PaXskYr/2V4CFDzAJ3PEojmrvZ1xIEyZ6Jhnt/KibWadsZT5+wQ/2YL0HVLrSk
         SE96kMx96abgp4/G5W8rQz0jlm0YMfEybvT/Wvd1nuaqgqNUxWaajR6VtM8xV4HvEvfw
         Bbx/W03Tvi2yKmyrV05s6Shlf+u2jp06Wbta0PiNCk7RXTBoeDFbMKw3ABOxPrg1RTzM
         T1iy7YPjiO9Sul+uLBawusQd+njEVUYUYKbgz4CEruL8pCRdPbXNWz/SlhNBzM9y4aW1
         NKM36rCUGigDmnm2gkR+X96I/sgHwDReXna0h9TREBV+DYvMT5HKBU4gGoAfnSeSmrMX
         jhPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ulNuxr60llkoiFafxIlb+CHi87OxQ5J+B08tO2koRaI=;
        b=qmQJoAJIac2A92Ud8nNVCyHnz7Jspe8jLO1lXLinPwzriPNLnIaDI/695RHUi9dI3v
         1SQ0zfGxuVsK40KxK8y+eoQvZlAI48X7CPfEPXfQhHmrQ9PNwAe857NEtwHFWu7z3L07
         bPj4x7cinIn3QtfDKaczAcZVYgP1v31MfcsyrMiEqcPVkeEkIoidlo2weI6/EjpXmbHb
         LQgE4axo6n2IdSANZhf44pIuIyT1kHg5m8ya8draR9ZeFppmH+D6ZCXZxGSfjzU9tNNz
         NGyQAmRhKEFaaf4wojmr7s78WrQx7a7i2XMlCpiskcH53JgZL0EzpaYSrY3uukgycXtM
         K6Gw==
X-Gm-Message-State: AOAM530EhWbZmJlku2yPhmh3vmAsAIOw5r5oggKnn1CZ5N1bEK3/H2ug
        sDi2oVO1+w+hUJfLdOLclJyu/gbvz+u3IA==
X-Google-Smtp-Source: ABdhPJxo8uCvmvswyteyIJyt3Ic0kUyiaOa1EnkhnWi0vvcbV05Oc/wdTagCI2PErKTC3uAktABG5Q==
X-Received: by 2002:adf:f144:: with SMTP id y4mr13185758wro.408.1615542479341;
        Fri, 12 Mar 2021 01:47:59 -0800 (PST)
Received: from dell.default ([91.110.221.204])
        by smtp.gmail.com with ESMTPSA id f7sm1539536wmq.11.2021.03.12.01.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 01:47:58 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Nilesh Javali <njavali@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Subject: [PATCH 10/30] scsi: qla2xxx: qla_nx2: Fix incorrectly named function qla8044_check_temp()
Date:   Fri, 12 Mar 2021 09:47:18 +0000
Message-Id: <20210312094738.2207817-11-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210312094738.2207817-1-lee.jones@linaro.org>
References: <20210312094738.2207817-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/qla2xxx/qla_nx2.c:2038: warning: expecting prototype for qla4_8xxx_check_temp(). Prototype was for qla8044_check_temp() instead

Cc: Nilesh Javali <njavali@marvell.com>
Cc: GR-QLogic-Storage-Upstream@marvell.com
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/qla2xxx/qla_nx2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/qla2xxx/qla_nx2.c b/drivers/scsi/qla2xxx/qla_nx2.c
index 68a16c95dcb77..7c413f93d53ee 100644
--- a/drivers/scsi/qla2xxx/qla_nx2.c
+++ b/drivers/scsi/qla2xxx/qla_nx2.c
@@ -2028,7 +2028,7 @@ qla8044_device_state_handler(struct scsi_qla_host *vha)
 }
 
 /**
- * qla4_8xxx_check_temp - Check the ISP82XX temperature.
+ * qla8044_check_temp - Check the ISP82XX temperature.
  * @vha: adapter block pointer.
  *
  * Note: The caller should not hold the idc lock.
-- 
2.27.0

