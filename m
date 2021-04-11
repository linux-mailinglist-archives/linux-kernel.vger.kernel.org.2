Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B71C235B46A
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 15:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235600AbhDKM6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 08:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235095AbhDKM6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 08:58:15 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F227BC06138B
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 05:57:58 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id n2so15749584ejy.7
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 05:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1V6bt6ii/+fH+5qFSivHmRuCKe8rO4Zp96j2XhZr1Zs=;
        b=jzRa/ORu8ehfU2ir2c0v5CtHEeZ1VLsbqq6DY6rxloMYXr+w4toI88Mwn2zg9YTf17
         psNYfCiTVy32xKtAf8SHQWvzBdX3Dd8DkbRhbRygXrh90bGPYfnZ6W7BJ2nUw5Sa1wLy
         NIFIXNgT3EQ5kcf3DfwV6tS97nU1u4iyl0UYS0eI3N1HGvv0AP+6IOa8Ki7Be1D82tvv
         Iv87+OiuQYbksvLAd0jX0dKYjV7WqTWMs56nBqOQtp71apt1CdzHj+saJRW1C7GOHczQ
         lAlqeWNd9/YI+XShm05Nw/nR5rTGqU3Qderdp81BAxkX8e9T5Zapv+PVlUg7L9J2MfpM
         f2nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1V6bt6ii/+fH+5qFSivHmRuCKe8rO4Zp96j2XhZr1Zs=;
        b=DTaLBIuTqCHOKM+/44mVNZgJPnFjSzn9miKOhII5C/r3nNm/zxRzP9MsjZspRuOs79
         rGESwnV0VAoGyqbG78n8oEQLG5oMFbDZPZg4W5J5nTTn41zy/CdJFQxj5Ha4lCuMI4Ib
         r/XW1FOl8BjdAsspHCS9aOvn4E3q1YvKE6RMGG3CRBLoqd+S0vIYyfscQaHArzkVUCQM
         2CrP5WQgLhjwslB1ZiymyC5yq0Uo9tpz0arpzqkNg3fGe57T7SYmMtYTeYkMDXcFXQCI
         9j+NPxnpfplHQio6jJq2PCUDBATyDTfJUF/CnyBVNOA2EcMA8gburtL8ZWAyh0rFyAna
         m0Eg==
X-Gm-Message-State: AOAM5315L+X4pfAP81uxIpmR4C2c6sk6io1EzTczgDWtp7/CdbDlLATv
        jIt5DNoUxy4V2b0K5/vDX51o9lOUITU=
X-Google-Smtp-Source: ABdhPJze4UlHVgAlMlb6Mx4tmS5Y8Q5rbO8EQKZG/NHaZjTszCHSp+geh37ZXQf85ITGK6O4oY50WQ==
X-Received: by 2002:a17:906:a44b:: with SMTP id cb11mr5342997ejb.518.1618145877615;
        Sun, 11 Apr 2021 05:57:57 -0700 (PDT)
Received: from agape ([5.171.72.218])
        by smtp.gmail.com with ESMTPSA id h20sm4019793ejk.110.2021.04.11.05.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Apr 2021 05:57:57 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] staging rtl8723bs: split long lines
Date:   Sun, 11 Apr 2021 14:57:36 +0200
Message-Id: <014291a522569d0450bf9ba6452497d812b4caab.1618145345.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1618145345.git.fabioaiuto83@gmail.com>
References: <cover.1618145345.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix following post-commit hook checkpatch issues:

WARNING: line length of 116 exceeds 100 columns
30: FILE: drivers/staging/rtl8723bs/hal/sdio_halinit.c:883:
+	HalPwrSeqCmdParsing(padapter, PWR_CUT_ALL_MSK,
PWR_FAB_ALL_MSK, PWR_INTF_SDIO_MSK, rtl8723B_enter_lps_flow);

WARNING: line length of 119 exceeds 100 columns
41: FILE: drivers/staging/rtl8723bs/hal/sdio_halinit.c:912:
+	HalPwrSeqCmdParsing(padapter, PWR_CUT_ALL_MSK,
PWR_FAB_ALL_MSK, PWR_INTF_SDIO_MSK, rtl8723B_card_disable_flow);

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/sdio_halinit.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/sdio_halinit.c b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
index 936181a73d73..552afbaff081 100644
--- a/drivers/staging/rtl8723bs/hal/sdio_halinit.c
+++ b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
@@ -880,7 +880,8 @@ static void CardDisableRTL8723BSdio(struct adapter *padapter)
 	u8 bMacPwrCtrlOn;
 
 	/*  Run LPS WL RFOFF flow */
-	HalPwrSeqCmdParsing(padapter, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_SDIO_MSK, rtl8723B_enter_lps_flow);
+	HalPwrSeqCmdParsing(padapter, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK,
+			    PWR_INTF_SDIO_MSK, rtl8723B_enter_lps_flow);
 
 	/* 	==== Reset digital sequence   ====== */
 
@@ -909,7 +910,8 @@ static void CardDisableRTL8723BSdio(struct adapter *padapter)
 
 	bMacPwrCtrlOn = false;	/*  Disable CMD53 R/W */
 	rtw_hal_set_hwreg(padapter, HW_VAR_APFM_ON_MAC, &bMacPwrCtrlOn);
-	HalPwrSeqCmdParsing(padapter, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_SDIO_MSK, rtl8723B_card_disable_flow);
+	HalPwrSeqCmdParsing(padapter, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK,
+			    PWR_INTF_SDIO_MSK, rtl8723B_card_disable_flow);
 }
 
 static u32 rtl8723bs_hal_deinit(struct adapter *padapter)
-- 
2.20.1

