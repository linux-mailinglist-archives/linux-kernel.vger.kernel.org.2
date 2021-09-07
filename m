Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35621403020
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 23:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347008AbhIGVLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 17:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344715AbhIGVLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 17:11:01 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D60C061575
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 14:09:54 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id eb14so15770983edb.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 14:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C5NPY5Lx+zyVAxeyICgaHLJymUzcNGdqg/vyuIUtGPk=;
        b=Iu6tlX+GEDCEUsHOVOn3+5fVFv58/hsD1/Ux4jYKeo/sTq5OI3T75unevKpEP9aGmR
         VyIFASq5zySOGU3+ajM1DzXfgPDE2o94tu0k+omqRSoWft+pQkktVgAERnRBsRZ698RA
         lLbTIg1nCZZJwWK6G/hW9h1eSENeel/QKUgV8qNdsvDi4D86TftqRjGTtuFsPwrCC5ce
         SC5P8zdgwcYyBcj5KcT9opMmffrA/PoNWbQIn+cEJadmO7E/DIRa6nuBL+VWYXl3JUbg
         r1zDjRf9bTU3wt9UJ5Akze03+2VFYyP4zATlMm0XDKQ5rWoMDC3657sEUFkglEngmb9L
         A5HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C5NPY5Lx+zyVAxeyICgaHLJymUzcNGdqg/vyuIUtGPk=;
        b=ESIlUVCyBvkkOjUfBO5yYuq526dUurPJ4zwgDkQNOpNOgd5bWMh5hjQQRoLm4thbJ0
         7FSG0Yt3jVAEpEXUERe6b4n7xH7hptiSJRQJXqKCOx5UdZRHXpi3ifOpLIv3GPKyoOGR
         CVAhuiIKlOTyvvPZfebSNvICEpFJQAVyBwna6C90ir9KyiBevPw+7b2/HQwYjxbnLWfa
         3ek9s2XDrYkR5ig906BzntP1xG67XjYVGJK7nYGCCMw3tqpxdd71pExXnd8zz4U4kXrG
         R5Kz/fPQ2I41eQk0XbaDP00DS6UZ8sr4jiOyaBLof0gB+SvMv1FD/xC+S69BoneqSh4g
         2fAA==
X-Gm-Message-State: AOAM530t1CDAwy3mSuwolpw4Iw03W4AcDfyjnGUPJNP5Fey36/tj/QeV
        ooYlC2Rw3xnclls661hUIr4=
X-Google-Smtp-Source: ABdhPJwVSUeTQyr7P+n1vnUyQP/tub6I3vOdnMbwGX4zLxEcc/pNmafyuEG66MALY49okk2GNa0FkA==
X-Received: by 2002:a05:6402:2801:: with SMTP id h1mr209390ede.209.1631048993410;
        Tue, 07 Sep 2021 14:09:53 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::dc38])
        by smtp.gmail.com with ESMTPSA id l7sm107490edb.26.2021.09.07.14.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 14:09:52 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: r8188eu: remove unused function Hal_ProSetCrystalCap()
Date:   Tue,  7 Sep 2021 23:09:24 +0200
Message-Id: <20210907210924.22287-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused function Hal_ProSetCrystalCap().

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_mp.c    | 9 ---------
 drivers/staging/r8188eu/include/rtw_mp.h | 1 -
 2 files changed, 10 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mp.c b/drivers/staging/r8188eu/core/rtw_mp.c
index dabdd0406f30..82268f754da0 100644
--- a/drivers/staging/r8188eu/core/rtw_mp.c
+++ b/drivers/staging/r8188eu/core/rtw_mp.c
@@ -924,12 +924,3 @@ void _rtw_mp_xmit_priv(struct xmit_priv *pxmitpriv)
 exit:
 	;
 }
-
-void Hal_ProSetCrystalCap(struct adapter *pAdapter, u32 CrystalCapVal)
-{
-	CrystalCapVal = CrystalCapVal & 0x3F;
-
-	// write 0x24[16:11] = 0x24[22:17] = CrystalCap
-	PHY_SetBBReg(pAdapter, REG_AFE_XTAL_CTRL, 0x7FF800,
-		     (CrystalCapVal | (CrystalCapVal << 6)));
-}
diff --git a/drivers/staging/r8188eu/include/rtw_mp.h b/drivers/staging/r8188eu/include/rtw_mp.h
index b2befe09d944..73fb6974d076 100644
--- a/drivers/staging/r8188eu/include/rtw_mp.h
+++ b/drivers/staging/r8188eu/include/rtw_mp.h
@@ -466,7 +466,6 @@ void Hal_TriggerRFThermalMeter(struct adapter *pAdapter);
 u8 Hal_ReadRFThermalMeter(struct adapter *pAdapter);
 void Hal_SetCCKContinuousTx(struct adapter *pAdapter, u8 bStart);
 void Hal_SetOFDMContinuousTx(struct adapter *pAdapter, u8 bStart);
-void Hal_ProSetCrystalCap (struct adapter *pAdapter , u32 CrystalCapVal);
 void _rtw_mp_xmit_priv(struct xmit_priv *pxmitpriv);
 void MP_PHY_SetRFPathSwitch(struct adapter *pAdapter ,bool bMain);
 
-- 
2.33.0

