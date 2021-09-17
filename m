Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87ADA4101BB
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 01:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344904AbhIQXct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 19:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344917AbhIQXcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 19:32:33 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A50C061757
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 16:31:10 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id z184-20020a1c7ec1000000b003065f0bc631so11148467wmc.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 16:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZgAFzPYLLEIZyR5p3BVXRSzgw7xSTQ9/sY8TbwA9U/g=;
        b=DF8gFNrfgriop0h3gtxixIfgZhJcSv7D4kN2CdJ3gvQWSMUAdnpOl5UCQk3hlgW9nZ
         FKtOPglggtBT5tJPKR4bAdVbJniOlkpcFcWM40TcEkae7nN5lt+ZbVQe2UOlCoUFBo28
         yzLPeeYFVXRNszGtnDZiqxaxKCTS+cG2yZAaplE7so0E89D3jhZPw7R280n62NtfClWZ
         jXyNnA4Uapiwv3mmnEQY3fOV+iKYVdqVLVxWCMeIE26XS8hWeCfY3FoDCCqi9aUAu6Ef
         QY1ZTdgZspMq8CPPE9YvRImGFFg7x2HVvJpipkOynWoidThNlEPHmqs2nPvfcyoihYq7
         ozkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZgAFzPYLLEIZyR5p3BVXRSzgw7xSTQ9/sY8TbwA9U/g=;
        b=7gw/ApiwDilDB3JqqE86MkJBCqVuwFH0XcuKSrkL9v/jHGtucCV1VlePeiLixlmHUw
         5LtRdZclKCfRuymqbkdtLwsYG4Vf88WEI8FoA+0Mpe4NwCXnYnsSWTWK90nbyfaYR5sV
         2i5tXF++gJ+laQWODx0e6nDEBsgk9N2akPCVrd6hosQEgYOC3iyZBI5S1kvWFvlldQVl
         2JKNQ1gkz2nJMkq4NDtJHtQgroqFQTKfHVqVpBl3GhwGsoJuyEtOvtOENIxgj6IfeONB
         CQd5abdUDPiMWVMwIYcXcF5LQndtEpctTjra8jCBUATKi8GVpPa+Mdd5ft2x0YFniRkn
         zG0Q==
X-Gm-Message-State: AOAM533asMFn2P3LN1yu8xLdTcvjN/e/CLzw1xyl5+KWcM7sO9jd87xe
        ZHicqhncRBh6QOP6aA6N6waJZuewkUXbMQ==
X-Google-Smtp-Source: ABdhPJy4l5AODdgDNkG7r7y+pBQmTYrSGKE4R5dHd9zdx/FHpZNIwa5QEMa93wFI++idBq9wrKo7Yg==
X-Received: by 2002:a1c:f206:: with SMTP id s6mr13178113wmc.102.1631921468836;
        Fri, 17 Sep 2021 16:31:08 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::ae40])
        by smtp.gmail.com with ESMTPSA id w9sm7523148wmc.19.2021.09.17.16.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 16:31:08 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 06/12] staging: r8188eu: remove more dead code from ODM_Write_DIG()
Date:   Sat, 18 Sep 2021 01:30:42 +0200
Message-Id: <20210917233048.31677-7-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210917233048.31677-1-straube.linux@gmail.com>
References: <20210917233048.31677-1-straube.linux@gmail.com>
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

