Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75B6F4101C3
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 01:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345026AbhIQXcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 19:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343828AbhIQXcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 19:32:32 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E3FDC061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 16:31:09 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id c8-20020a7bc008000000b002e6e462e95fso11144286wmb.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 16:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UmdvyLEdteIkPC5QKKxfnddWF+96+b6HOaR6hgtQ+98=;
        b=fPG4Cv5Uhb/qiJ7VRWXsmhMrkbmLDVXB7W3cDnvR942kiqFdhxvwhAGFFTQp/V2rnu
         34xsJIldCIXwhnCse40Uh90/9112mUB76L5ncWa6fkyDU8wMM8it4REkYqSehw4M07K5
         JdOASLhJMEgsFasyUnnpHnKl58rHjOPT1pB+gEHAM+PH6xdItzflZ2Ks2+iW/sUhM2dK
         UxpdhMQcCfPjkLrSSi4VU1Jk8vyT/g+DCIC6zGBxWCALcoaUoyV/07VYlr1T5rul1dGP
         c5OQdp2B53INTA885vmTEYdg0lp8ph66yV3ocPPAngovl1xSA0VULvhGAP8q3JVLeRaa
         kJbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UmdvyLEdteIkPC5QKKxfnddWF+96+b6HOaR6hgtQ+98=;
        b=o6QGZ9TaTwwOfU6v/MNRwicv2S1n57b4DQymmdnx1ToeJ0N8Esl/yVdvpgVkCC6Ml9
         cwejhDg6Dj++5TUwAXdLVgM6CXR4NxKmIkeTKQtpDuVkcOwlceRm534+aUGOc92BBfvz
         b51h8qXzxdjphOZC7+CSiK2qTd+kYym+PVsJYFEt4KwMQK0X1v/NsgJBNLFV1C0/qjso
         7DnIV77lrrcniEhwWgE8zalg40GqPfT0woQIwsPA5DCZMT4cs/6dniUNjYi5Ae2LoNhL
         LmVpD8XwbCwJQBe9oDw/2yyyHkiqijOei05INkMVN9CUZ1FCdVaXg8rvk4R7dDSUMIQQ
         KREw==
X-Gm-Message-State: AOAM533k3uUNbuzTstTegEh54uCO4EWC+EFu3J/lu0KANN4YNY3Qtx1V
        LVPDmnxzFcal2HsiknANsHo=
X-Google-Smtp-Source: ABdhPJzUSA4n/1TO2wLXj2TeUzNPrVtIJe/scbo/joTg7zWVw75geD4RA56m+SHAlcemT7Nhh3Q70w==
X-Received: by 2002:a1c:447:: with SMTP id 68mr17315856wme.137.1631921467907;
        Fri, 17 Sep 2021 16:31:07 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::ae40])
        by smtp.gmail.com with ESMTPSA id w9sm7523148wmc.19.2021.09.17.16.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 16:31:07 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 05/12] staging: r8188eu: remove unnecessary if statement
Date:   Sat, 18 Sep 2021 01:30:41 +0200
Message-Id: <20210917233048.31677-6-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210917233048.31677-1-straube.linux@gmail.com>
References: <20210917233048.31677-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SupportPlatform is ODM_CE in this driver. Remove an unnecessary
if statement that checks the SupportPlatform value.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/odm.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm.c b/drivers/staging/r8188eu/hal/odm.c
index 5f98c797c59a..cac4f8ff7b63 100644
--- a/drivers/staging/r8188eu/hal/odm.c
+++ b/drivers/staging/r8188eu/hal/odm.c
@@ -465,11 +465,10 @@ void ODM_Write_DIG(struct odm_dm_struct *pDM_Odm, u8 CurrentIGI)
 	struct rtw_dig *pDM_DigTable = &pDM_Odm->DM_DigTable;
 
 	if (pDM_DigTable->CurIGValue != CurrentIGI) {
-		if (pDM_Odm->SupportPlatform & (ODM_CE | ODM_MP)) {
-			ODM_SetBBReg(pDM_Odm, ODM_REG(IGI_A, pDM_Odm), ODM_BIT(IGI, pDM_Odm), CurrentIGI);
-			if (pDM_Odm->SupportICType != ODM_RTL8188E)
-				ODM_SetBBReg(pDM_Odm, ODM_REG(IGI_B, pDM_Odm), ODM_BIT(IGI, pDM_Odm), CurrentIGI);
-		}
+		ODM_SetBBReg(pDM_Odm, ODM_REG(IGI_A, pDM_Odm), ODM_BIT(IGI, pDM_Odm), CurrentIGI);
+		if (pDM_Odm->SupportICType != ODM_RTL8188E)
+			ODM_SetBBReg(pDM_Odm, ODM_REG(IGI_B, pDM_Odm), ODM_BIT(IGI, pDM_Odm), CurrentIGI);
+
 		pDM_DigTable->CurIGValue = CurrentIGI;
 	}
 /*  Add by Neil Chen to enable edcca to MP Platform */
-- 
2.33.0

