Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01D6732BF00
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 00:06:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1577092AbhCCRsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:48:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359491AbhCCOsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 09:48:47 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 648ACC0613AC
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 06:47:19 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id v15so23982934wrx.4
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 06:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fC33Zk0ZyYtHJeu4W5SBQTBQUeiPwdCaCHRN8M5tXzo=;
        b=DwK5Dwt6nm/K8A2h+SM7y1TVazpE7jM04zdOA6+fAjDaE24o4gNxKo0p47FOYZmr5p
         7tz4IncFdVyJWF34XsqHuofmvBXLxB0VAuFNK5Oarknakq8yfMUTidNNUttmss0O8dd2
         LEBuwpPwAa1vCL9qmlwDs04zTKm1W+O1XnxL559HFLhUE87HM/kKOm4AeqUvHaKjPpd8
         5QVrXrzwZMt9Jtn+JncyrKUh1LJ4L1EtZBsq+SiAJT78Kq71lCH2cWHhn3EZ1j+TYLgI
         NEVaoCHNezYapYZl+Jk0ZxYtfYtqV3+m+EikoTtv6hzQJawGtJ4cWul13WUXMTXEc+Hw
         GKUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fC33Zk0ZyYtHJeu4W5SBQTBQUeiPwdCaCHRN8M5tXzo=;
        b=NQQDkPGcajF+dc1DNU4WUiqq3KdKn710PRhFOds3qYD2hbM7xtmIlgKHbTPnwLOyqj
         c9oxgf7kZ09994lV7jeSJ8OiJsqx/pJKiE8qtEUhcAlW9eFPcrj8/b/5yJDz3lMYkjaX
         wZaqQIAFE++3dGZVDqYNWdcG+bSLTugplSGwy07TNAenFSGjQxs6vzc6CgDbyyPSw0Ox
         DwwIbNdCeqtN7pvm3FV7WsYv/5kPUZRkUsqOu5F/kQ8axU5vfpJwmL3XYOIf7Czf36wm
         TI50IWQycPxzJPnVOWjCoDK6t1XFQrNnHsO2b/TBO5MbbemJ5GOzgve2SwS2JwWUZ5og
         FuzQ==
X-Gm-Message-State: AOAM530ezRAiiUUqTY3X5eOxZ1TxDpCmKF1BUStltCawDHjUj5ReCg8r
        hhl5MeQ64Npm8q0/9apihrDkrg==
X-Google-Smtp-Source: ABdhPJxA1ca38hEZOIyWn15165I5rGmv6LMTG2ybwsHKfb9NP+M/DFJfic2d7l229KukE2tLKHBKfA==
X-Received: by 2002:adf:eec5:: with SMTP id a5mr12420188wrp.303.1614782838134;
        Wed, 03 Mar 2021 06:47:18 -0800 (PST)
Received: from dell.default ([91.110.221.155])
        by smtp.gmail.com with ESMTPSA id a14sm36567233wrg.84.2021.03.03.06.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 06:47:17 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Subject: [PATCH 13/30] scsi: pm8001: pm8001_ctl: Fix incorrectly named functions in headers
Date:   Wed,  3 Mar 2021 14:46:14 +0000
Message-Id: <20210303144631.3175331-14-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210303144631.3175331-1-lee.jones@linaro.org>
References: <20210303144631.3175331-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/pm8001/pm8001_ctl.c:313: warning: expecting prototype for pm8001_ctl_sas_address_show(). Prototype was for pm8001_ctl_host_sas_address_show() instead
 drivers/scsi/pm8001/pm8001_ctl.c:530: warning: expecting prototype for pm8001_ctl_aap_log_show(). Prototype was for pm8001_ctl_iop_log_show() instead

Cc: Jack Wang <jinpu.wang@cloud.ionos.com>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/pm8001/pm8001_ctl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/pm8001/pm8001_ctl.c b/drivers/scsi/pm8001/pm8001_ctl.c
index 12035baf0997b..1921e69bc2328 100644
--- a/drivers/scsi/pm8001/pm8001_ctl.c
+++ b/drivers/scsi/pm8001/pm8001_ctl.c
@@ -299,7 +299,7 @@ static DEVICE_ATTR(sas_spec_support, S_IRUGO,
 		   pm8001_ctl_sas_spec_support_show, NULL);
 
 /**
- * pm8001_ctl_sas_address_show - sas address
+ * pm8001_ctl_host_sas_address_show - sas address
  * @cdev: pointer to embedded class device
  * @attr: device attribute (unused)
  * @buf: the buffer returned
@@ -518,7 +518,7 @@ static ssize_t event_log_size_show(struct device *cdev,
 }
 static DEVICE_ATTR_RO(event_log_size);
 /**
- * pm8001_ctl_aap_log_show - IOP event log
+ * pm8001_ctl_iop_log_show - IOP event log
  * @cdev: pointer to embedded class device
  * @attr: device attribute (unused)
  * @buf: the buffer returned
-- 
2.27.0

