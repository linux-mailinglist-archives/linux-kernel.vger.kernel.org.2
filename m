Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2A741056B
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 11:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243905AbhIRJ0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 05:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238309AbhIRJ0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 05:26:34 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD814C061768
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 02:25:10 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id g19-20020a1c9d13000000b003075062d4daso8497356wme.0
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 02:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZgAFzPYLLEIZyR5p3BVXRSzgw7xSTQ9/sY8TbwA9U/g=;
        b=G4c5Ba7eVuJ1qFLwojui1JNnaWSwv67GLm/5CODDztRFGSCdkB112uqewEhq5we7QW
         xGwh9LiK3A5S5x4FEBKZl2gBVMJUh1X2PswDOAXETSXMjfl5EjBNtyEEiGZo1zZhtnEv
         8wV9sr7Ui2ThW2K598w/L4zHjJgs1pe/menYILZ83caIWPTv90YxJ1sgr1VQo3Kd1jBV
         /jx7MNSryn5IIu5wr85qPNsf78y5kLR6WBGLQGo0wH2oUKhAqvaWvHUpOpJjG0/Qfs8q
         m02E+AI2Ho8eZvVL4wG+pRXXGxB/G0nT3hC5df7QpUDI6Esy+Iik9PeXBHhtKadUi/w8
         5+tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZgAFzPYLLEIZyR5p3BVXRSzgw7xSTQ9/sY8TbwA9U/g=;
        b=bEjtywLWNqCidilPAVVm26x4UAGxiOUiScJCgwkbUC5jMGLrhmqYLnL9ghlQIqjBS9
         maWqqlPb6A/Nn9Laa7Z4f6f7fKyijo+5StczBsLJ1D3jbGdDcv5Fx9B5eIgA7xsMRwbg
         tdlGzXs0UEhDVD5fV6I1ON9BqXkKjOD2gDXFxyN41zfvVl3Y1lzOveb6V1AwHdeRqup6
         z9YmkyW2Os8mJhfALfcmhuKybrDkZZkXC8AJNa4SKmC7xaX5AlU2KvjNRDC7g9/YrIDh
         EIB40glgUjDWG80QU0uShawr4KnHE+eaPnz8gGkj8BMUjLxvjEAjP/OoojEyO69HCt6f
         fqzw==
X-Gm-Message-State: AOAM532z12dQHjEV/fBE/JcfWmAjjCGQc1Mfhhj+1RnhqiBXq/YlOQ2Y
        IBz47neme8zXsdOS0XVPZEQ=
X-Google-Smtp-Source: ABdhPJyoluQQtjN/3KvKwr2YsvdbxfgxNBoQSRhBzqqeT2PUuLT+4lDn6RbiBW/HUr54tCK/ZftIpQ==
X-Received: by 2002:a1c:f314:: with SMTP id q20mr18979651wmq.154.1631957109339;
        Sat, 18 Sep 2021 02:25:09 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::ae40])
        by smtp.gmail.com with ESMTPSA id 5sm4233742wmb.37.2021.09.18.02.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Sep 2021 02:25:09 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 06/12] staging: r8188eu: remove more dead code from ODM_Write_DIG()
Date:   Sat, 18 Sep 2021 11:24:37 +0200
Message-Id: <20210918092443.8724-7-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210918092443.8724-1-straube.linux@gmail.com>
References: <20210918092443.8724-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SupportICType is ODM_RTL8188E in this driver. Remove code that is
never executed.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/odm.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm.c b/drivers/staging/r8188eu/hal/odm.c
index cac4f8ff7b63..48c10b78f4a5 100644
--- a/drivers/staging/r8188eu/hal/odm.c
+++ b/drivers/staging/r8188eu/hal/odm.c
@@ -466,12 +466,8 @@ void ODM_Write_DIG(struct odm_dm_struct *pDM_Odm, u8 CurrentIGI)
 
 	if (pDM_DigTable->CurIGValue != CurrentIGI) {
 		ODM_SetBBReg(pDM_Odm, ODM_REG(IGI_A, pDM_Odm), ODM_BIT(IGI, pDM_Odm), CurrentIGI);
-		if (pDM_Odm->SupportICType != ODM_RTL8188E)
-			ODM_SetBBReg(pDM_Odm, ODM_REG(IGI_B, pDM_Odm), ODM_BIT(IGI, pDM_Odm), CurrentIGI);
-
 		pDM_DigTable->CurIGValue = CurrentIGI;
 	}
-/*  Add by Neil Chen to enable edcca to MP Platform */
 }
 
 /* Need LPS mode for CE platform --2012--08--24--- */
-- 
2.33.0

