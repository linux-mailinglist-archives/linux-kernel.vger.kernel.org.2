Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03D303A38A6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 02:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbhFKA1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 20:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231283AbhFKA1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 20:27:24 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2039C0617AE
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 17:25:12 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id f16-20020a05600c1550b02901b00c1be4abso7622939wmg.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 17:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b7LCuD4Mi1ZY73S2sGwIUNflhwnyaOmFWD/95mQTmSQ=;
        b=ZIWfHhWFEmiYxAugmd7t3+L7iRTJd25vGq9YAgbwwwVY2CuYcxH1v2baCvIOTed6WY
         Ea7CiKt4gS2YfzYAb2d7BQozzJhMBISqK4i5rSOjy57kxWYec0Q+RftrSaKbnonptPol
         b/NQoOP1JKgwSUZurP6Pr0e1BMEW09Qx3ZEVcgicrtzWPwsolFiNtLVKG5aAxYRvHifT
         C7LJ0yGZGuEdurwqMGXahjR6wD3pjs3lGadScNshhDgktcCZBG1pSz72Y+OKmt2BwNVM
         wrjREC59ccF3LvBBnBjZGxelkFH4yJKyoEmYl6tt8/eYoCdohuH+f6T4Mmci2Tld67Om
         EtYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b7LCuD4Mi1ZY73S2sGwIUNflhwnyaOmFWD/95mQTmSQ=;
        b=MNNAOdb0KF+MW+twJM31iZxO78ZXOrpgqqMJcwzb3Laq55wCqLfDnbWgywUKfUbYbs
         PRiMFQKTc0sR1Ps8Z7DU/N+wghSUR+xcjwMg0r+UovfWa8YeabVq914IV8u89+sI7lPt
         ISNFk7szhnQ8lg8dam48fSQ43tL2nWuPpH1OaLSD3hfIufYuULNhHn+Z3jIaid/piMuQ
         NFjuGGlUuy3gIl/pLNdEW+6YoKgOzEFbiD0HBjgT9TyqncwJl/0t96+wLCcxycjjj50X
         b/feiGD6BJn8N7Ue7q7PqZ8yDl6WcGI8HmL6o5ok7R7ZcTjhbsH1R4xrvkLnx7Bow/hv
         3XgQ==
X-Gm-Message-State: AOAM533hx/ZT+1m2hRO67Lr/IuPm9OR7WFqZIHV2L+ttIqWOt9K1Lkzc
        OBPEk2x7DYdoEtcKhH4NCy4ApA==
X-Google-Smtp-Source: ABdhPJwtvOipj9EcO3rpFU2Srz26Lp4+/40l+EDMEfsSOp2KUDT/R1M9IdFVfXFefF/A0pgirqFTTQ==
X-Received: by 2002:a7b:c954:: with SMTP id i20mr1191997wml.161.1623371111222;
        Thu, 10 Jun 2021 17:25:11 -0700 (PDT)
Received: from localhost.localdomain (2.0.5.1.1.6.3.8.5.c.c.3.f.b.d.3.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16:0:3dbf:3cc5:8361:1502])
        by smtp.gmail.com with ESMTPSA id c2sm11386189wmf.24.2021.06.10.17.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 17:25:10 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, straube.linux@gmail.com,
        kaixuxia@tencent.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, liushixin2@huawei.com,
        unixbhaskar@gmail.com, gustavoars@kernel.org, martin@kaiser.cx,
        bkkarthik@pesu.pes.edu, dan.carpenter@oracle.com
Subject: [PATCH 3/6] staging: rtl8188eu: remove ODM_RT_TRACE calls from hal/odm_rtl8188e.c
Date:   Fri, 11 Jun 2021 01:25:01 +0100
Message-Id: <20210611002504.166405-4-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210611002504.166405-3-phil@philpotter.co.uk>
References: <20210611002504.166405-1-phil@philpotter.co.uk>
 <20210611002504.166405-2-phil@philpotter.co.uk>
 <20210611002504.166405-3-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove all ODM_RT_TRACE calls from hal/odm_rtl8188e.c, as this debug code
is not optimal and doesn't follow best practices. This in concert with
other removals allows for the removal of include/odm_debug.h in its
entirety.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/rtl8188eu/hal/odm_rtl8188e.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/odm_rtl8188e.c b/drivers/staging/rtl8188eu/hal/odm_rtl8188e.c
index a55a0d8b9fb7..e29cd35a5811 100644
--- a/drivers/staging/rtl8188eu/hal/odm_rtl8188e.c
+++ b/drivers/staging/rtl8188eu/hal/odm_rtl8188e.c
@@ -307,11 +307,7 @@ void rtl88eu_dm_antenna_diversity(struct odm_dm_struct *dm_odm)
 		return;
 
 	if (!dm_odm->bLinked) {
-		ODM_RT_TRACE(dm_odm, ODM_COMP_ANT_DIV, ODM_DBG_LOUD,
-			     ("ODM_AntennaDiversity_88E(): No Link.\n"));
 		if (dm_fat_tbl->bBecomeLinked) {
-			ODM_RT_TRACE(dm_odm, ODM_COMP_ANT_DIV, ODM_DBG_LOUD,
-				     ("Need to Turn off HW AntDiv\n"));
 			phy_set_bb_reg(adapter, ODM_REG_IGI_A_11N, BIT(7), 0);
 			phy_set_bb_reg(adapter, ODM_REG_CCK_ANTDIV_PARA1_11N,
 				       BIT(15), 0);
@@ -324,8 +320,6 @@ void rtl88eu_dm_antenna_diversity(struct odm_dm_struct *dm_odm)
 	}
 
 	if (!dm_fat_tbl->bBecomeLinked) {
-		ODM_RT_TRACE(dm_odm, ODM_COMP_ANT_DIV, ODM_DBG_LOUD,
-			     ("Need to Turn on HW AntDiv\n"));
 		phy_set_bb_reg(adapter, ODM_REG_IGI_A_11N, BIT(7), 1);
 		phy_set_bb_reg(adapter, ODM_REG_CCK_ANTDIV_PARA1_11N,
 			       BIT(15), 1);
-- 
2.30.2

