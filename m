Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2E48400E8C
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Sep 2021 09:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235764AbhIEHPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Sep 2021 03:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235533AbhIEHPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Sep 2021 03:15:46 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C7DC061575
        for <linux-kernel@vger.kernel.org>; Sun,  5 Sep 2021 00:14:43 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id s29so3024582pfw.5
        for <linux-kernel@vger.kernel.org>; Sun, 05 Sep 2021 00:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=JD7XuQoJwbDIBnTsN7e/h+gdvbJc7z6zSyfwmCSLaaU=;
        b=Qi2XyvK0QRV/0wfAw+i08Dga6Rp7YNx0Xoej4S6BXSAJ9gCby7u0FxGTn2CmCybJ73
         3tjDcowZnubLHBzPiPsUYcE9UI/JFWtuy2z0f1koL1A2wGXkLByAwozGBdQlcQj/z1ES
         oDTu7JFA/l6ZFiZ/GSR2PU4B16veknO0xua1l/qmrNDkyHPalQO2R+QDjrPqqG2GubOr
         GNttWa/fYUnxal8R5A48F6xYZzNTDwvzjF/w/XMF0822TCu1LldIxETogyv20lpmxs7R
         UZ+AqxvuIIBsAZk7N7phy+hWpT1ZVLvwM3TcJRr+JbKwLRI4R8R4U3rzWa4Z2Ehjk65W
         Nq6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=JD7XuQoJwbDIBnTsN7e/h+gdvbJc7z6zSyfwmCSLaaU=;
        b=NzGjtoiqny8uwfT9zkwqqjRNDY+MMa+nboBOkuvmYorD8XKjtTfIaHCxk6JSQfNwPh
         yQbaACa9LcAaPb0b5Lu3OLf387vHxk4V0dNw71p8QLf2jvYYBE3QOYUaVOzoxWeANL/m
         KPg9kR4re7OZJB9SDV9oCe9YXm06px62HdGXbPcV/OUfY9pKWwQOVunbPsHyJirk2RqP
         4R06tgPCfJw68baScjsiRRSEOhqaWGVovDEs8qjgx9czcJwn/3GJF2RfGpXgT60O46Xw
         BhSAEIJ/kNmVhG1hLRw4sIApXDKI+JsiiLUdrSSvC66ZRNHMMQu5+7K+l0f7tXUhjL5F
         grsQ==
X-Gm-Message-State: AOAM532Wm0i1LtgcpGAW8U41d8EICVdbGDVqyT3vi/W2FM2oZ7cHsnJO
        w/Z68ggC/mokRBP7yID4FHc=
X-Google-Smtp-Source: ABdhPJxQCQTRC9O2BYe9/50jO0glFBM11aqXDdFcSqoc0VJYoxCelGSk5tyNILIssAFs9OEEp0T2gA==
X-Received: by 2002:a05:6a00:1245:b029:30f:2098:fcf4 with SMTP id u5-20020a056a001245b029030f2098fcf4mr6491672pfi.66.1630826083095;
        Sun, 05 Sep 2021 00:14:43 -0700 (PDT)
Received: from user ([117.98.200.228])
        by smtp.gmail.com with ESMTPSA id o6sm4083555pjk.4.2021.09.05.00.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Sep 2021 00:14:42 -0700 (PDT)
Date:   Sun, 5 Sep 2021 12:44:37 +0530
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
To:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, saurav.girepunje@gmail.com,
        linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
Subject: [PATCH] staging: r8188eu: include: remove duplicate declaration.
Message-ID: <YTRuXTu/kePBDwAF@user>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove below duplicate declaration from rtl8188e_led.h file

void SwLedOn(struct adapter *padapter, struct LED_871x *pLed);
void SwLedOff(struct adapter *padapter, struct LED_871x *pLed);

Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
---
 drivers/staging/r8188eu/include/rtl8188e_led.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/r8188eu/include/rtl8188e_led.h b/drivers/staging/r8188eu/include/rtl8188e_led.h
index b00954198764..02cdc970bb17 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_led.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_led.h
@@ -12,7 +12,5 @@
 /*  */
 void rtl8188eu_InitSwLeds(struct adapter *padapter);
 void rtl8188eu_DeInitSwLeds(struct adapter *padapter);
-void SwLedOn(struct adapter *padapter, struct LED_871x *pLed);
-void SwLedOff(struct adapter *padapter, struct LED_871x *pLed);

 #endif
--
2.32.0

