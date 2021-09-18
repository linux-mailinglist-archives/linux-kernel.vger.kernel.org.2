Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC2F3410811
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 20:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240481AbhIRSU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 14:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240261AbhIRSUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 14:20:49 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A43DC061764
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 11:19:25 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id v24so42957999eda.3
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 11:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZgAFzPYLLEIZyR5p3BVXRSzgw7xSTQ9/sY8TbwA9U/g=;
        b=lOFwAENwRZCqB/7vN1B1bjeEVrED3ORpOrsPKE+o/8Z4jIB3JpRKP0H1llDupxUeF+
         41mwwWK/712kDacF8eWJjulzDmnuQYGAYYVT+jNkjt3VCy3DYXNNyjLzZeufEwZSFTm9
         4RfHQC1yKkBS/mf9gcgwAt+8ZPqykTBZMVtIOlqaD+GC8WD4cf6TN/qY81hS9fziHO7j
         m/i/j8cz69cwxZreLcvv93iHwSc03P1PJwxDYI6Q2OimPRo4QTypgEIxNpYGJiB9LsGy
         YkRoyzYo0l1K/tvQYtkBmOXTQFfAc+STHOh3NjGlWbRoxd0xeKgUHLKqq3C1P5XZpObi
         DXEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZgAFzPYLLEIZyR5p3BVXRSzgw7xSTQ9/sY8TbwA9U/g=;
        b=uaIhv58gbDjCxqLO4sUs9vMAJZTtxGPx4Yo07PAhVhdr87r+YXP0wxq+pbjkvVbEqX
         YAV/SQMLtnpaRfH6xUfGAf3WKlTj9ILaqmI+OBUYZK3NJYV0r1dRIZ6BYVtJGFijEmpa
         obnDrU69ZHWTdq+tZ148euHG4F8r7vQYqYxUXf0gwwf2B35nYn1hUThSD7Uo9E94h4Q9
         yUMKwSIuK/pcQKG/HZoe714iKFYBJY1nlEDw9k7DicSFO0REZFWB0GW3A5IFERCYz6Ys
         QrSIu6S9ILT0gR1et4Pu1xLriaFZ4e+bO5e/0mPwkQemgGBgMImsnaH7mO/BmVFKRHO5
         rwYQ==
X-Gm-Message-State: AOAM533sNzsGkkhtrtpjANml3/dQ4OzwgUgnfhWxGRAzXQdd3Vm1JZMF
        zbb1eACQxXf4iKhZ2xNiG2s=
X-Google-Smtp-Source: ABdhPJxw7wwwCZFqHc8ef5F9ZwQp1DvPLhnD+aq2AxCoG+PfhY5+nL7+tK1+FvlzlIe3DND1M+YzXQ==
X-Received: by 2002:a17:906:9395:: with SMTP id l21mr19229580ejx.308.1631989164211;
        Sat, 18 Sep 2021 11:19:24 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::cde])
        by smtp.gmail.com with ESMTPSA id t19sm3903673ejb.115.2021.09.18.11.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Sep 2021 11:19:23 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v3 06/14] staging: r8188eu: remove more dead code from ODM_Write_DIG()
Date:   Sat, 18 Sep 2021 20:18:56 +0200
Message-Id: <20210918181904.12000-7-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210918181904.12000-1-straube.linux@gmail.com>
References: <20210918181904.12000-1-straube.linux@gmail.com>
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

