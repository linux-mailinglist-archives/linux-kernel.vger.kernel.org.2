Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF7C40124D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 03:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238496AbhIFBCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Sep 2021 21:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234182AbhIFBCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Sep 2021 21:02:17 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AFEAC0613C1
        for <linux-kernel@vger.kernel.org>; Sun,  5 Sep 2021 18:01:13 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id k5-20020a05600c1c8500b002f76c42214bso3762383wms.3
        for <linux-kernel@vger.kernel.org>; Sun, 05 Sep 2021 18:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QRPu7/9Qd3PbniV4TOPudxpciFxl4VNYSDgMlaMBEQU=;
        b=BAu2vjVpl9dl72jIJlwdcU62DtB15Kkbn0isQimDy/KQNHbPnb0f6LnqitPubEWBD8
         IfF1Lci2sHDUQIYINsufjDnOREIkBFEelEsAFLLUZ5qoD1nl+JbAGebhTdMes4EUTsvZ
         g2deuJIuPD5xaLGPaciBiy+agXJ0zZ0WjthiV+TbIR1j3AWJZ2S0oOlYB4zBQcG78d0X
         QbDkLlcshkj57ysmQdm9E6q1vc896fAaJIg3CXkyTE85n3J7PRkJ/Q+zBL9rM+q7tAqO
         1VfXnoNSUEgqFmisybdHyb+Ufie6g61hJTTgn4zyIvc8lDvPUR4yZi/LmCT2pK+6DvjN
         fwjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QRPu7/9Qd3PbniV4TOPudxpciFxl4VNYSDgMlaMBEQU=;
        b=rUpy7vNLvhvZ43QJVTSi7UZay5vMCe//PD7QLMvRDfIP+yZ0nFtWUDfcohVLzOSWN4
         AuohpKZ0A9uEEf6LSqlpZr8jC7q6/6Lk9X2nHvI6QIdA3a6q5F8245stLUNWwjrlgsmF
         CoeoEHDIbe74/II2ui91C2+V0uz8s3Pl5JHzLhBsMcH4DJdrPtzyMrPbeBGpF9bkWbew
         ufeBioH1VpQ7Mm8MO8N9zr4nloVM0GyIVAxFX5v8HVYC8fB6oZyXcDX8UiJ17jdjHgdi
         prZxc6mrgLD8GRPLal2e1WK8BLuss7SNHIAHo5iryvYWqQYV1VOV0GH8Ra1vZ0QdWNoz
         iOfg==
X-Gm-Message-State: AOAM533AjA/HnbYDwOQO8UVd6Vkg7vR8WtgGuOp2M0MOGidPxsD1qEdD
        0STpCLNQUcqj2BBSx4faTBROkg==
X-Google-Smtp-Source: ABdhPJxo8VsrWI8mDweMn8+gETAkdAcgMKHcUkizSfEKGCsB+hg8Pn5WnnMDSe7tlTeFmhZRbpeH/w==
X-Received: by 2002:a1c:7417:: with SMTP id p23mr8925636wmc.144.1630890071939;
        Sun, 05 Sep 2021 18:01:11 -0700 (PDT)
Received: from localhost.localdomain (d.f.5.e.6.6.b.1.e.6.2.7.e.5.c.8.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0:8c5e:726e:1b66:e5fd])
        by smtp.gmail.com with ESMTPSA id r25sm5151232wrc.26.2021.09.05.18.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Sep 2021 18:01:11 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, straube.linux@gmail.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH 03/14] staging: r8188eu: remove rtw_hal_enable_interrupt function
Date:   Mon,  6 Sep 2021 02:00:55 +0100
Message-Id: <20210906010106.898-4-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210906010106.898-1-phil@philpotter.co.uk>
References: <20210906010106.898-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove rtw_hal_enable_interrupt from hal/hal_intf.c, and remove its
declaration from include/hal_intf.h as well. This is just a wrapper
function that calls the function pointer enable_interrupt in struct
hal_ops if it is set, which it never is. In addition, this wrapper
function is unused anyway.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/hal/hal_intf.c     | 8 --------
 drivers/staging/r8188eu/include/hal_intf.h | 1 -
 2 files changed, 9 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/hal_intf.c b/drivers/staging/r8188eu/hal/hal_intf.c
index 06ee8ef69ce8..3eb05863856d 100644
--- a/drivers/staging/r8188eu/hal/hal_intf.c
+++ b/drivers/staging/r8188eu/hal/hal_intf.c
@@ -149,14 +149,6 @@ void rtw_hal_get_odm_var(struct adapter *adapt,
 						      val1, set);
 }
 
-void rtw_hal_enable_interrupt(struct adapter *adapt)
-{
-	if (adapt->HalFunc.enable_interrupt)
-		adapt->HalFunc.enable_interrupt(adapt);
-	else
-		DBG_88E("%s: HalFunc.enable_interrupt is NULL!\n", __func__);
-}
-
 void rtw_hal_disable_interrupt(struct adapter *adapt)
 {
 	if (adapt->HalFunc.disable_interrupt)
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index 3cbe6c277677..e59a482cc139 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -298,7 +298,6 @@ void rtw_hal_get_odm_var(struct adapter *padapter,
 			 enum hal_odm_variable eVariable,
 			 void *pValue1, bool bSet);
 
-void rtw_hal_enable_interrupt(struct adapter *padapter);
 void rtw_hal_disable_interrupt(struct adapter *padapter);
 
 u32	rtw_hal_inirp_init(struct adapter *padapter);
-- 
2.31.1

