Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CCCB445D03
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 01:28:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbhKEAaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 20:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbhKEAau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 20:30:50 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99281C061714
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 17:28:11 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id r9-20020a7bc089000000b00332f4abf43fso6001280wmh.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 17:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O4YUDgdo255VAYFqIsJJWpu2PRm/0Or1BTzsdPRBrWk=;
        b=cHCo4gmABWuKJiSybcT/mk1Y2DZ4oBzkPmeJL3FPTwxhr9SRrlxubLRg/LuBrnlKH1
         vIVEDT0pjtWkI03yyGUc+x0Lj0ZbTx8SAqWrHYm2W3DzvtPjjhu1koNSdbO+c01X07jx
         kyqXT0Pms9lIMaYkU4WR+YGq3Pl0/Ru23wvnWBM5T0H/Ztf10wK2bgj6cG9aWPXHywog
         Pv7JLyKW7n5YjzlFGBfYStcYbCAOVFMC9weiDsQwYoJdcN87sMKPyDKnster9bVKXzaX
         zkgl4+vJaCP+pWWlpecd00tj/s2J6l05HFCSqsFW3eijEYl22ZzOm+C56zQNlep/lFDD
         eZPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O4YUDgdo255VAYFqIsJJWpu2PRm/0Or1BTzsdPRBrWk=;
        b=VCi3ojd3aQNgHIZxeOAB4PO9KCNDjJIi1DsGxSTK6t4HFcZaNRSaVCxO4gn2XeexgG
         H4bt7ZESRsCCLv+SQd+7xIWeT5t+3bsjbcbBi4uvzrpc0fKK9Q7KTSO2ol25kHg5uXGc
         fW1QvhLPiaDYVIoyRg+idUgtK9EJh0O7MtgIJGPjVk4bugclKUu6MkDtYCkhpsQ/DWrr
         aFxfBZ6gR3ybBQCUFl9ngDidLww4BJx1zSD93+boBmIIlSukcuGyojvN3R93NtJ5Nrs7
         YvZ8F0PFUt6KC13hhtCMg/3QmcWsRJYnQ5ZPLkf3+GSqpQh9kPHrkjLbvFX23AtWmFtk
         zwbQ==
X-Gm-Message-State: AOAM5333P0DGOI/6jvyFXu8sXpCCwVG2i/8NLSAdM2Bzwi200RJBEL/S
        08VkhR9iDS7vLA/0iZk8Rm0kcQ==
X-Google-Smtp-Source: ABdhPJx4p9NftzFucX4ulXLAkGfTpfrMSXcolRKkskOwXdMsmHLlKAcnfTmWTrFXg53nadktouJ/Ew==
X-Received: by 2002:a1c:7515:: with SMTP id o21mr28288141wmc.99.1636072090171;
        Thu, 04 Nov 2021 17:28:10 -0700 (PDT)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id g18sm6924566wmq.4.2021.11.04.17.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 17:28:09 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, straube.linux@gmail.com,
        martin@kaiser.cx, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: r8188eu: remove MSG_88E call from odm_TXPowerTrackingThermalMeterInit
Date:   Fri,  5 Nov 2021 00:28:07 +0000
Message-Id: <20211105002807.6628-1-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary MSG_88E macro call from hal/odm.c, within the
function odm_TXPowerTrackingThermalMeterInit. All it does is print a
struct member, during initialization, that is then immediately set on
the following line. It is therefore surplus to requirements.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/hal/odm.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm.c b/drivers/staging/r8188eu/hal/odm.c
index 21f115194df8..bca625a46263 100644
--- a/drivers/staging/r8188eu/hal/odm.c
+++ b/drivers/staging/r8188eu/hal/odm.c
@@ -891,8 +891,6 @@ void odm_TXPowerTrackingThermalMeterInit(struct odm_dm_struct *pDM_Odm)
 	pDM_Odm->RFCalibrateInfo.bTXPowerTracking = true;
 	pDM_Odm->RFCalibrateInfo.TXPowercount = 0;
 	pDM_Odm->RFCalibrateInfo.bTXPowerTrackingInit = false;
-	MSG_88E("pDM_Odm TxPowerTrackControl = %d\n", pDM_Odm->RFCalibrateInfo.TxPowerTrackControl);
-
 	pDM_Odm->RFCalibrateInfo.TxPowerTrackControl = true;
 }
 
-- 
2.31.1

