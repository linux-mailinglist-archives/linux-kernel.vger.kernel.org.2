Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4FC140419D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 01:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236470AbhIHXLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 19:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235589AbhIHXLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 19:11:24 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61743C061575
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 16:10:16 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id x6so5570246wrv.13
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 16:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UZtUkA8uA7tyAnR1JQv0hvRBLsmltUOtKeKYLbxIW8c=;
        b=CqZQgiOgLva3wRn6rcX+rsQbs7Aihl/+1pSGLWlq4AcBHLL/c1D/xAq5P+E0T55R+9
         o9S3P6t25cjtHKTJMRTx9bxjYc0YelCDwox/bNZAtgQM2biglVLHQCJ3Bjm1p2frULep
         3axycg5ILdeRvg8YBG/FCyPdPwK/d+xpLgxnhjKnzrcomBhyI8G2SdguMkS8z0ZInJ6L
         C+n9tJDdmKY/NUNL5KBgWi8MEwNyW9M3oHGz3NLk22fcrs7xQ7SmSVxAS+VkMHvJJKg1
         IvmZ9Dc+E0kK0VEfgy7y/WrS1OvTnShW5UWJL6fEkgfubdCgFR6vV+v9N/1sWNMu/irp
         FlcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UZtUkA8uA7tyAnR1JQv0hvRBLsmltUOtKeKYLbxIW8c=;
        b=w+pd1CE1rXvWXjLglzPHgVMf9fvZAQNW0Rw9A2USMXczZbFUJdRaxXQPta9k5VF5Mj
         7qhIVBwQi8mOcQYpyY/zyssyCQ3RZ2m5HzB8NNOgayxtcqJ9LrvmAg0BOtf6+G32k01G
         2r54ozRvjP7G6//Md/dpcXx/hQIxy5nfiZtfPUHCLQz5Bx2c2f7a8fnKLd5jy5Inz3zF
         Zq6jOOP9anrqqfua0TQgvfuMDGLH5L8msOH2I7xS2jRv82Ru4VGsqwpBe9Ckcho/mRXJ
         euC2S+VhLL7OTKe+YaO6M1AAQZ/8h7EfzwLbmn+xJb/xgOlW6ZgwaoChUbyIFD9izQ5G
         Jx3w==
X-Gm-Message-State: AOAM5331VJt6Nz0YZtM6Db5kvyg/32072+oZw7ny7HlzOAozIOhAeTni
        Io0pqw/w/XZN+UoQ9Wl/DFQ=
X-Google-Smtp-Source: ABdhPJwmbUd4K2WLg6p3JTv6MNdyVrJy5d1p4iVIYgBaZ8pfF54JFOCfZZmlSTF2Xw8Lv2Oc8WHkwg==
X-Received: by 2002:adf:eacb:: with SMTP id o11mr65857wrn.418.1631142615093;
        Wed, 08 Sep 2021 16:10:15 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::8fe1])
        by smtp.gmail.com with ESMTPSA id l21sm348393wmh.31.2021.09.08.16.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 16:10:14 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/2] staging: r8188eu: remove unused odm_Init_RSSIForDM()
Date:   Thu,  9 Sep 2021 01:09:52 +0200
Message-Id: <20210908230953.16931-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210908230953.16931-1-straube.linux@gmail.com>
References: <20210908230953.16931-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function odm_Init_RSSIForDM() is unused and empty, remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/odm_HWConfig.c     | 4 ----
 drivers/staging/r8188eu/include/odm_HWConfig.h | 2 --
 2 files changed, 6 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm_HWConfig.c b/drivers/staging/r8188eu/hal/odm_HWConfig.c
index ada22a526fee..db4c072ec6c5 100644
--- a/drivers/staging/r8188eu/hal/odm_HWConfig.c
+++ b/drivers/staging/r8188eu/hal/odm_HWConfig.c
@@ -356,10 +356,6 @@ static void odm_RxPhyStatus92CSeries_Parsing(struct odm_dm_struct *dm_odm,
 	dm_odm->DM_FatTable.antsel_rx_keep_2 = pPhyStaRpt->antsel_rx_keep_2;
 }
 
-void odm_Init_RSSIForDM(struct odm_dm_struct *dm_odm)
-{
-}
-
 static void odm_Process_RSSIForDM(struct odm_dm_struct *dm_odm,
 				  struct odm_phy_status_info *pPhyInfo,
 				  struct odm_per_pkt_info *pPktinfo)
diff --git a/drivers/staging/r8188eu/include/odm_HWConfig.h b/drivers/staging/r8188eu/include/odm_HWConfig.h
index 9b2ab3bcf992..790ab4d1eff5 100644
--- a/drivers/staging/r8188eu/include/odm_HWConfig.h
+++ b/drivers/staging/r8188eu/include/odm_HWConfig.h
@@ -89,8 +89,6 @@ struct phy_status_rpt {
 #endif
 };
 
-void odm_Init_RSSIForDM(struct odm_dm_struct *pDM_Odm);
-
 void ODM_PhyStatusQuery(struct odm_dm_struct *pDM_Odm,
 			struct odm_phy_status_info *pPhyInfo,
 			u8 *pPhyStatus,
-- 
2.33.0

