Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90D34359EF0
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 14:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233228AbhDIMkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 08:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232763AbhDIMkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 08:40:25 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51CA7C061760
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 05:40:12 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id e7so6359023edu.10
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 05:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jP3PhGigK/Ueh3VHQJ9puGdUHkKb5RPpqr31LnHq7qA=;
        b=iALCGv7dgZJfAl75kq+j15/GEW609PAV7qIjtsmpitYkjUbDk2Srcv5XeJ9WUay9tI
         OPtn2chLgQntM1yVNqd+A4gBWXL1vBbgpkqcS7pC3d+rlPxlVybKn/1XnrjuxTOqKn8/
         cAI84iEpY/5eEIR/2w9w5jWQ3yFKBEYlkV6ZYmsszFf57mZo4LXRHqerCOGD/NQ+Z4jp
         3NEwcKBPH6Y9ucTzZWlzzbR/J5voOovP1J/5p72FEPF7IYSFOpmrqoMLHeUbipnxkcKm
         ZCPj3/sPK/YaibFxl5UJJphOBn1gebOgJ1khPGWsdy5SEXF5jYf1KkntbfUhNnm1s6k/
         zIag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jP3PhGigK/Ueh3VHQJ9puGdUHkKb5RPpqr31LnHq7qA=;
        b=ro7Im12jIVJ9mc3t0zpcyBtrl939S7aeJVKPO/yuk5f/7nZQPd/15H9jpXRzmDe4fU
         k5e3U5Dqj46fEVlcdRhQAuoF6ipYZ4IdsYW6wNI016a8A4zyoOnNwLCKj9vX7C7yMr2c
         Jr3Cn3ztpZRBfKIKQenI3LMcb7kDB5lCKfe2psWIGRBWTbuqx/fu4HaHz1elh3Ljp2ng
         uqz+jd1q09YDesoDRo17dPV9GfyV3bqGkb8PGjtSrKw4aq93V3SXNGuzQ1K5hFdggIgp
         cHWcTeU9Jq1QF03m5PbWgPDH3q1rxAVFAbRgoPy84gMtEvqY4RlzgQCbVSDnC2n5BUSs
         zSMQ==
X-Gm-Message-State: AOAM533fF0AUixdpCj8bN2n8P4g6WCaYyLCu/eMd2UMj0/BRU0oo/VrK
        koRH6Ig/2f0QexsAt/DgIQM=
X-Google-Smtp-Source: ABdhPJw2vjjPOvYZVnYSy+uAgediVSvUZ+6nuGvzEe3aEpQZknjVA6iqVETu50DlFxmUbl9jr+YdgQ==
X-Received: by 2002:a05:6402:105a:: with SMTP id e26mr17307788edu.164.1617972011158;
        Fri, 09 Apr 2021 05:40:11 -0700 (PDT)
Received: from agape ([151.43.204.41])
        by smtp.gmail.com with ESMTPSA id q19sm1175784ejy.50.2021.04.09.05.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 05:40:10 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 2/3] staging: rtl8723bs: remove commented out MSG_8192C log
Date:   Fri,  9 Apr 2021 14:40:02 +0200
Message-Id: <845969563d7c90d1b7aa3215ae29dd91afc5100c.1617971592.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617971592.git.fabioaiuto83@gmail.com>
References: <cover.1617971592.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove commented out MSG_8192C log.

MSG_8192C is a private trace mechanism macro and is deactivated.
(i.e. the default behaviour is _do nothing_)
The only way to activate it is to manually define a debug
symbol.

So just remove it.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/odm.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/odm.c b/drivers/staging/rtl8723bs/hal/odm.c
index 6f8f38a58237..dea4e3679b8e 100644
--- a/drivers/staging/rtl8723bs/hal/odm.c
+++ b/drivers/staging/rtl8723bs/hal/odm.c
@@ -776,9 +776,6 @@ void odm_TXPowerTrackingInit(struct dm_odm_t *pDM_Odm)
 	else
 		pdmpriv->TxPowerTrackControl = false;
 
-
-	/* MSG_8192C("pdmpriv->TxPowerTrackControl = %d\n", pdmpriv->TxPowerTrackControl); */
-
 	/* pDM_Odm->RFCalibrateInfo.TxPowerTrackControl = true; */
 	pDM_Odm->RFCalibrateInfo.ThermalValue = pHalData->EEPROMThermalMeter;
 	pDM_Odm->RFCalibrateInfo.ThermalValue_IQK = pHalData->EEPROMThermalMeter;
-- 
2.20.1

