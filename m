Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5BEA4337C5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 15:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235984AbhJSNyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 09:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235935AbhJSNx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 09:53:59 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F30C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 06:51:46 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id m22so48086166wrb.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 06:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ok68sRc2xOIfCvTBrCJZswQdaMM1ovxmj3Sg5Olbf3c=;
        b=e/vQ8OpNsvfaGotJlFLTgx6var/MTxcCatXICfK6E5blUuPFGygomPgaUZ0NXyuepF
         Yhvo+L5BPULwjPDbaZwLpCffrDjiMUqY5+NtND8oKzWdFQ5hPteTUu1BeHiQda9pM8/m
         G5tDbVYFJJkn4r0e93Ltv389u4Yp/IX9PkBDeVCjZIaFMlvzK73gc/C+Ig9jrrnYWjf7
         5bnQlKVjVO1BzJnEr1C5nzW2TSLBHCw/2+2eAo+3YrVpigsdbUv25lAlmBei04DvH0Gp
         VDcYBYSZvuOxIGKsNWxq3LUaVBqgXaJ4JQzbER+7F80dCpfzrzMzvIfG5UoINyDEDIo+
         dEQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ok68sRc2xOIfCvTBrCJZswQdaMM1ovxmj3Sg5Olbf3c=;
        b=C5MT8qgRp7lBLIk8soIVLAv5j3QSBzzqQCAFsxWUwo1FAFSADkhta5qO4LSAEXhoR+
         AN8pa09irrhepwoN6xtqJiN332FeG9iPjbzLi4wWE6u5CO0mRPk4MNmronWI52Cb6vcj
         VZKsxqJVf9KAkv1s0VNuBS2DDkW28kC8wdTLBOT7bSRmw+hNI033I0Yv6JjeqfA/7wXN
         OaAx/MFoijpA2MOzHZbc+OesOkp7Dm+roywj/0mtHDjpxhhWkTpepxUP06iMGtO+5jMo
         GXAYQXogqHa4Ey+sRJNgcQZn5IybPefzW7o35Ze2QnY8sD+JsjvcsfslhSmVQbdHBD81
         7Fuw==
X-Gm-Message-State: AOAM5319C+zQu0GhMHrHGl5R1c6QznHQ6b9dqIWPo296x0TWSDVMzltc
        6PRTUaExaf2Z/QxfcxbT2sk=
X-Google-Smtp-Source: ABdhPJxI5tXOwAS/0+QSOzjvfJ4wOUNEcAE9QKwg3PIhaf9BXN9yKQDpW/DxgF19mQl37H9cb23EQQ==
X-Received: by 2002:adf:9784:: with SMTP id s4mr45905989wrb.277.1634651504774;
        Tue, 19 Oct 2021 06:51:44 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::3de4])
        by smtp.gmail.com with ESMTPSA id i203sm2280699wma.48.2021.10.19.06.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 06:51:44 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 3/7] staging: r8188eu: rename ODM_PhyStatusQuery_92CSeries()
Date:   Tue, 19 Oct 2021 15:51:33 +0200
Message-Id: <20211019135137.9893-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211019135137.9893-1-straube.linux@gmail.com>
References: <20211019135137.9893-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ODM_PhyStatusQuery() is just a wrapper around
ODM_PhyStatusQuery_92CSeries().

Rename ODM_PhyStatusQuery_92CSeries to ODM_PhyStatusQuery()
and remove the wrapper.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/odm_HWConfig.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm_HWConfig.c b/drivers/staging/r8188eu/hal/odm_HWConfig.c
index 4772c2c0d50d..3125886e6731 100644
--- a/drivers/staging/r8188eu/hal/odm_HWConfig.c
+++ b/drivers/staging/r8188eu/hal/odm_HWConfig.c
@@ -362,11 +362,11 @@ static void odm_Process_RSSIForDM(struct odm_dm_struct *dm_odm,
 }
 
 /*  Endianness before calling this API */
-static void ODM_PhyStatusQuery_92CSeries(struct odm_dm_struct *dm_odm,
-					 struct phy_info *pPhyInfo,
-					 u8 *pPhyStatus,
-					 struct odm_per_pkt_info *pPktinfo,
-					 struct adapter *adapt)
+void ODM_PhyStatusQuery(struct odm_dm_struct *dm_odm,
+			struct phy_info *pPhyInfo,
+			u8 *pPhyStatus,
+			struct odm_per_pkt_info *pPktinfo,
+			struct adapter *adapt)
 {
 	odm_RxPhyStatus92CSeries_Parsing(dm_odm, pPhyInfo, pPhyStatus,
 					 pPktinfo, adapt);
@@ -374,14 +374,6 @@ static void ODM_PhyStatusQuery_92CSeries(struct odm_dm_struct *dm_odm,
 		odm_Process_RSSIForDM(dm_odm, pPhyInfo, pPktinfo);
 }
 
-void ODM_PhyStatusQuery(struct odm_dm_struct *dm_odm,
-			struct phy_info *pPhyInfo,
-			u8 *pPhyStatus, struct odm_per_pkt_info *pPktinfo,
-			struct adapter *adapt)
-{
-	ODM_PhyStatusQuery_92CSeries(dm_odm, pPhyInfo, pPhyStatus, pPktinfo, adapt);
-}
-
 enum HAL_STATUS ODM_ConfigRFWithHeaderFile(struct odm_dm_struct *dm_odm,
 					   enum rf_radio_path content,
 					   enum rf_radio_path rfpath)
-- 
2.33.1

