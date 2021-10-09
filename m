Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C77A42777A
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 07:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233830AbhJIFIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Oct 2021 01:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbhJIFIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Oct 2021 01:08:15 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D7CEC061570
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 22:06:19 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id n11so7043487plf.4
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 22:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=RCPTshEDJD1Y+rfEbp8XH1g9vPebJXz3+gWAjl+hT5g=;
        b=EIJ5Mz+icS1YZj8r0R1Nc8L1pvrdj0GhkTBuGyuhtY2XcPQDw48WeA3M2t8AcrjNPO
         7sGDkLLKNqvqXNdUZXW27u44R/xEJS06uTOYFTx5v4PFtcmdm2XmW34rhHpOwfuSYElO
         VgAAH2C8NT0pshjoqZ4wfKGFuoL8m1Wqu9Uyp4r49xQZwKmuq169yLQZqqIyw2VNOKN7
         mxWampOIacsBfGY92ms76f97AZvX4T/chjTi/pov3q07MwUhv+zKAFrv5+0bVntpDvkF
         vfRBabI66ToZ4R2JUABelFWkdin2LB0Y7UBKcomjF/qZjEHJQ76FND/JUFASsYE/KQlw
         HIjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=RCPTshEDJD1Y+rfEbp8XH1g9vPebJXz3+gWAjl+hT5g=;
        b=pqeXpB9ay9KXIj+qFZVVFGmdsXZTBHaJ9B+ki0JtdUN02nriOD00Q0VWsRAOnJq/fT
         UmMy5zqg9idPc23lJ2nntM7RNuj8qfSY6qxC9DJo2hNG7lGodVotMSPFf/q8u2sNd9ga
         /wXPX2cxA7um84cuaibd/LxHh8me2U9ldRzAlaFMQgqPXMadiMJ/CPthArh+Xdxs6YyI
         rRWB/M/2f1AOPn1CtYSNppIC4bhpI93Fq7HfCEZLweaysjISUm7nQcd2MqdUmS2C5Bs8
         muXj0QJ2InQ8PPq1NAStOjDIWvc27Hb5uheOrZNrZSk2nf4agQnCeu7dNIq8PrABG84P
         zm3A==
X-Gm-Message-State: AOAM5328/f7s5ocnbsrJE3yA2m/i6UCOA5m5vQC/+ilkB7lhThk4TFUT
        xuWpYiiDQoNd9Y/h9kMysq4=
X-Google-Smtp-Source: ABdhPJzgoC5KXNuVzYu5qXB78+uaAonwDHIH4jd5tYu5LZcw6KKPu8qR9I8vCVr3IY3n9CRAWpUSAA==
X-Received: by 2002:a17:902:a40c:b029:12c:17cf:ab6f with SMTP id p12-20020a170902a40cb029012c17cfab6fmr13119033plq.71.1633755978416;
        Fri, 08 Oct 2021 22:06:18 -0700 (PDT)
Received: from user ([223.230.43.197])
        by smtp.gmail.com with ESMTPSA id w15sm829770pfc.220.2021.10.08.22.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 22:06:17 -0700 (PDT)
Date:   Sat, 9 Oct 2021 10:36:12 +0530
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
To:     gregkh@linuxfoundation.org, fabioaiuto83@gmail.com,
        ross.schm.dev@gmail.com, fmdefrancesco@gmail.com,
        zhansayabagdaulet@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
Subject: [PATCH] staging: rtl8723bs: core: merge the if conditions
Message-ID: <YWEjRHU5FCoVphmu@user>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

merge the two consecutive if conditions in rtw_set_rpwm().
Both are having same condition to check.

Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_pwrctrl.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c b/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
index a392d5b4caf2..5292f90251e0 100644
--- a/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
+++ b/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
@@ -272,11 +272,11 @@ void rtw_set_rpwm(struct adapter *padapter, u8 pslv)
 	pwrpriv->rpwm = pslv;

 	cpwm_orig = 0;
-	if (rpwm & PS_ACK)
+	if (rpwm & PS_ACK) {
 		rtw_hal_get_hwreg(padapter, HW_VAR_CPWM, &cpwm_orig);
-
-	if (rpwm & PS_ACK)
 		_set_timer(&pwrpriv->pwr_rpwm_timer, LPS_RPWM_WAIT_MS);
+	}
+
 	rtw_hal_set_hwreg(padapter, HW_VAR_SET_RPWM, (u8 *)(&rpwm));

 	pwrpriv->tog += 0x80;
--
2.32.0

