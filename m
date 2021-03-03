Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 327B132BF20
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 00:08:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1577816AbhCCSBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 13:01:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359745AbhCCOup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 09:50:45 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A03C0611A2
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 06:47:42 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id e23so5395879wmh.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 06:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GU8Y2fU2IPGLTocyu2Vs2OyGQon6ldafbekOMqUJ5SM=;
        b=M3q0WIe1Cnzq0w/d7Q+kHBzw27f0RuiCBJB7Xim0oB03tMl0FA88FSXO1wH9QA14vW
         ZIU/xJ/wRJ5rZhQZtn9lh7hX5c55tSVUjEC5klSItz8DIdMkaL/1SwBrYh+iYJuNbrLN
         bdeQtFltgGxvi0M/mlMz2HrhV41uRDfSm7hhF6aYRnqf5/SqoIsltPrcwdI4SRtzyCi7
         JoJ3j6k7bE+BxykdsZIqsMPT+83RmowzJ6Md5gzsRQ1kRMb/3fxRupK1jBDN4gLKzcV0
         zR4dKzovB+xi9fqFZ4uW488cbMynrswf5XQlCZfS3Et8rODuprLxP2CSA2jCkb5f+fAO
         c6hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GU8Y2fU2IPGLTocyu2Vs2OyGQon6ldafbekOMqUJ5SM=;
        b=Tp+o4u3UZPGW1PDBt7LyNlf5xK3Mh+srpS3EaohavE9a9GmfdAF3YnFO3RbGnkQDS+
         3cukVzv7Q+oww8Vv/yyj31jktre8Dc8ana2iO3wIPGrEHnh2TiGWx/fzOCM/wLuvKGwm
         XDfl4O7PhB7v37hJvxJ6/ZjHNBU/R46KgB/NUl/kV3R8pOxfHdxiLga1gQRmI9aBz9Z4
         NpIkPVAvfMkV7j93D1S4S4EnfpD7Pgvwub0uQvLKmWUWlNFv8GkOOFAGjlzsRc8F5bnO
         JOXahbOHwt6QXDTxLLms6K4qslKZHjQuL4WVdHtGN69b+I/1leFUPfTe1Vf6kO7c7+DQ
         s+1A==
X-Gm-Message-State: AOAM530pBIUX8F2AYZdfrndZWs35z82y1I+UamJFaZPhkRvXauWeuu1g
        SGHVC85kZ7YP2Tj2CUfLgs0tQA==
X-Google-Smtp-Source: ABdhPJw4ZS6vhz895/y/q1aE97JtZo5BnoyyQUg+XtYLIs3G9VcdEShToaonr7xYVVEHHh4yAYKUDg==
X-Received: by 2002:a1c:730a:: with SMTP id d10mr9233099wmb.53.1614782860947;
        Wed, 03 Mar 2021 06:47:40 -0800 (PST)
Received: from dell.default ([91.110.221.155])
        by smtp.gmail.com with ESMTPSA id a14sm36567233wrg.84.2021.03.03.06.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 06:47:40 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Nilesh Javali <njavali@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Subject: [PATCH 23/30] scsi: qla2xxx: qla_gs: Fix some incorrect formatting/spelling issues
Date:   Wed,  3 Mar 2021 14:46:24 +0000
Message-Id: <20210303144631.3175331-24-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210303144631.3175331-1-lee.jones@linaro.org>
References: <20210303144631.3175331-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/qla2xxx/qla_gs.c:1259: warning: expecting prototype for qla2x00_snd_rft_id(). Prototype was for qla2x00_sns_rft_id() instead
 drivers/scsi/qla2xxx/qla_gs.c:1492: warning: expecting prototype for qla2x00_prep_ct_req(). Prototype was for qla2x00_prep_ct_fdmi_req() instead
 drivers/scsi/qla2xxx/qla_gs.c:1596: warning: expecting prototype for perform HBA attributes registration(). Prototype was for qla2x00_hba_attributes() instead
 drivers/scsi/qla2xxx/qla_gs.c:1851: warning: expecting prototype for perform Port attributes registration(). Prototype was for qla2x00_port_attributes() instead
 drivers/scsi/qla2xxx/qla_gs.c:2284: warning: expecting prototype for perform RPRT registration(). Prototype was for qla2x00_fdmi_rprt() instead

Cc: Nilesh Javali <njavali@marvell.com>
Cc: GR-QLogic-Storage-Upstream@marvell.com
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/qla2xxx/qla_gs.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_gs.c b/drivers/scsi/qla2xxx/qla_gs.c
index 517d358b0031a..8e126afe61b11 100644
--- a/drivers/scsi/qla2xxx/qla_gs.c
+++ b/drivers/scsi/qla2xxx/qla_gs.c
@@ -1247,7 +1247,7 @@ qla2x00_sns_gnn_id(scsi_qla_host_t *vha, sw_info_t *list)
 }
 
 /**
- * qla2x00_snd_rft_id() - SNS Register FC-4 TYPEs (RFT_ID) supported by the HBA.
+ * qla2x00_sns_rft_id() - SNS Register FC-4 TYPEs (RFT_ID) supported by the HBA.
  * @vha: HA context
  *
  * This command uses the old Exectute SNS Command mailbox routine.
@@ -1479,7 +1479,7 @@ qla2x00_update_ms_fdmi_iocb(scsi_qla_host_t *vha, uint32_t req_size)
 }
 
 /**
- * qla2x00_prep_ct_req() - Prepare common CT request fields for SNS query.
+ * qla2x00_prep_ct_fdmi_req() - Prepare common CT request fields for SNS query.
  * @p: CT request buffer
  * @cmd: GS command
  * @rsp_size: response size in bytes
@@ -1582,7 +1582,7 @@ qla25xx_fdmi_port_speed_currently(struct qla_hw_data *ha)
 }
 
 /**
- * qla2x00_hba_attributes() perform HBA attributes registration
+ * qla2x00_hba_attributes() - perform HBA attributes registration
  * @vha: HA context
  * @entries: number of entries to use
  * @callopt: Option to issue extended or standard FDMI
@@ -1837,7 +1837,7 @@ qla2x00_hba_attributes(scsi_qla_host_t *vha, void *entries,
 }
 
 /**
- * qla2x00_port_attributes() perform Port attributes registration
+ * qla2x00_port_attributes() - perform Port attributes registration
  * @vha: HA context
  * @entries: number of entries to use
  * @callopt: Option to issue extended or standard FDMI
@@ -2272,7 +2272,7 @@ qla2x00_fdmi_dhba(scsi_qla_host_t *vha)
 }
 
 /**
- * qla2x00_fdmi_rprt() perform RPRT registration
+ * qla2x00_fdmi_rprt() - perform RPRT registration
  * @vha: HA context
  * @callopt: Option to issue extended or standard FDMI
  *           command parameter
-- 
2.27.0

