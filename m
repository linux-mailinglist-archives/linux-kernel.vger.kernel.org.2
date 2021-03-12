Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAE47338906
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 10:49:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233209AbhCLJsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 04:48:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232981AbhCLJr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 04:47:59 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B39DC061761
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 01:47:58 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id j4-20020a05600c4104b029010c62bc1e20so14791864wmi.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 01:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z+kSFSRrtdMVZ+j5+NugdaTX8hYYEw2c6IlgmOo4rIo=;
        b=HOcgEfaVoDJMWGnXaPpzgoYuj5aTw+ZVk9EuklTc1mwNWSzqEN5tkcy6SK22px7l2Z
         IH3b6a3DKeSc6jMUyR8EiLiJSP8A8swQ8qkWg3D1lqe/3lgUEb3SaN54EwL+87/rB6BM
         CO+2p6eJzkxo/NXOoqirxPaMWxKAxx+bH3ejrW26ApFwYq/fK1IykgBIrxqWyTbCpbUt
         g4l96HdnU9mxuZgI9lIrgVc+UfeG7p0fueHRhwfc8R9vhTO7ODFY3Ou5/lpCQCl99M4Q
         XwkTVTUmmfZtTgzZUDSoOE3L/lTFhPPNzZlYGRU2kPjTFoT4ML1VPdCPRod00eYtXtbP
         MZVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z+kSFSRrtdMVZ+j5+NugdaTX8hYYEw2c6IlgmOo4rIo=;
        b=AzXLBMPT6BAqntIaWOiQd2yQ1k97o8fTbfyoRy3WwBxb5TANYiGdIFva3trqc/ueFB
         E+IBENkcAq+cTZIKidB0d94SlxjpvWal4/tSd9KJ3xAm//RJQKvIf5sXFE/ZeaQj65hQ
         om/6EesFTJtGT43zVJGOcchh7Y11VWtFkKdaUb51f5HKj6ycCIoWIYIMSB94xQmYnnnw
         XlXCON3IpEfYqsLC1KPGPTK+3HasMdbQZ+W9Ex7lf6S0T707qInnYt4VnrXxsv3KxuBz
         rSumjuXEi8N/XDQIE8py6hUrVVc8sgCgNJZ2vn3joSz/XcKSJaxNTjBjYgr5tInmUYUm
         88QQ==
X-Gm-Message-State: AOAM530JNCEUd4b6yfW5XbVk0h5+aNhKGeS0HMUdMF4B9Z6k2OddTYrX
        NSW5KoOnRNn5NbLGXsL6HuvLP6Nsvi0mdg==
X-Google-Smtp-Source: ABdhPJyauKNkVBNzIvCP4ejtdeK/afAqJ050OX03Yub6PLyrcVZ1HV+Ir85+FHBYND0KC3AU7EZsQA==
X-Received: by 2002:a05:600c:4150:: with SMTP id h16mr12248304wmm.120.1615542477173;
        Fri, 12 Mar 2021 01:47:57 -0800 (PST)
Received: from dell.default ([91.110.221.204])
        by smtp.gmail.com with ESMTPSA id f7sm1539536wmq.11.2021.03.12.01.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 01:47:56 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Nilesh Javali <njavali@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Subject: [PATCH 08/30] scsi: qla2xxx: qla_mr: Fix a couple of misnamed functions
Date:   Fri, 12 Mar 2021 09:47:16 +0000
Message-Id: <20210312094738.2207817-9-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210312094738.2207817-1-lee.jones@linaro.org>
References: <20210312094738.2207817-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/qla2xxx/qla_mr.c:525: warning: expecting prototype for qlafx00_warm_reset(). Prototype was for qlafx00_soc_cpu_reset() instead
 drivers/scsi/qla2xxx/qla_mr.c:2869: warning: expecting prototype for qlafx00x_mbx_completion(). Prototype was for qlafx00_mbx_completion() instead

Cc: Nilesh Javali <njavali@marvell.com>
Cc: GR-QLogic-Storage-Upstream@marvell.com
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/qla2xxx/qla_mr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_mr.c b/drivers/scsi/qla2xxx/qla_mr.c
index ca73066853255..d488ae95e149a 100644
--- a/drivers/scsi/qla2xxx/qla_mr.c
+++ b/drivers/scsi/qla2xxx/qla_mr.c
@@ -516,7 +516,7 @@ qlafx00_pci_config(scsi_qla_host_t *vha)
 }
 
 /**
- * qlafx00_warm_reset() - Perform warm reset of iSA(CPUs being reset on SOC).
+ * qlafx00_soc_cpu_reset() - Perform warm reset of iSA(CPUs being reset on SOC).
  * @vha: HA context
  *
  */
@@ -2860,7 +2860,7 @@ qlafx00_async_event(scsi_qla_host_t *vha)
 }
 
 /**
- * qlafx00x_mbx_completion() - Process mailbox command completions.
+ * qlafx00_mbx_completion() - Process mailbox command completions.
  * @vha: SCSI driver HA context
  * @mb0: value to be written into mailbox register 0
  */
-- 
2.27.0

