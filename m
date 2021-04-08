Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF7235818D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 13:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbhDHLT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 07:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbhDHLT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 07:19:59 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08263C061760
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 04:19:48 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id l4so2352856ejc.10
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 04:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hkn4MUpfGU3cF0CCSTZFoBdiPCp83n9PcmuKuUkPS9E=;
        b=N2M6nv2wl/Zxo7trE9VjGl86Q5S1Qz0c65tLoTF9ngg7tstK8l4dfxeMrWZHuKMDIi
         RBCb4ygKaWK58WwNLqmIkt7HuzYgL4jRKSk6FTN1vO/9hcsH3NX64bq/jIjJXa1CuU+L
         DxnFTfD1WYpo1KuFYYcM4aLjfwtd750YkhdEOyw99iR/w8tGzECVGiCru88ahAhyoefv
         9FbJkwpvk34XG44I8L+N117ffcLzMSpbEMh7CGYybP2LIy5NkuqIuCLUAxTsWZx8fuJW
         z5w/Ic5+y+4UtaOcimag2O/1iQU7uSLTRjjJIiiPTb1Q7oWa0Z+c71wWxTOoeciW533w
         4vzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hkn4MUpfGU3cF0CCSTZFoBdiPCp83n9PcmuKuUkPS9E=;
        b=gEWFduDzZJ2JrNtxoNYxw+HobwwqGhxCmnth44QUS/6Fc7YDnKxILFaUwwFeelaUo1
         EgmLnxmSaKKy669Y9tcU9j7aP4z2byRjtK/mAIjVwgUj9q4thYG2QLmk4GWJssMkDhCa
         NLWqkSXsK6vMe7m3UN/KFm3LSwvFE53aDMCnaSJ1F2p/q/iN3id708yTFOfu1mIyZn73
         vuDwdLvcSogiEaPTWDpwD7dGzAHsPbBOYXJmMfNaNsu32c9fivvllge+nYUyHA8QxleI
         afxiRpss2fYJVZjMReyWoIrOjxFUk6ywUHHtp0Rpe82Q6rzivfis7E+HjWY8Y9nuTOx2
         0XCw==
X-Gm-Message-State: AOAM531gakfyu0+6Yo5Yg9AHmp22TecflmbQktcIramdwnPIJzl8xQ81
        iISYnYViJOnnQcbPtIxRcLA=
X-Google-Smtp-Source: ABdhPJyKNTdVnQGLD5UaHKbRwNSmIcRB16mT6OSXj+hV67PW7iYmxnu9n4d9S54MxgishpADiY5axg==
X-Received: by 2002:a17:906:7194:: with SMTP id h20mr8808463ejk.432.1617880786798;
        Thu, 08 Apr 2021 04:19:46 -0700 (PDT)
Received: from localhost.localdomain (host-79-42-91-147.retail.telecomitalia.it. [79.42.91.147])
        by smtp.gmail.com with ESMTPSA id bf14sm8678588edb.67.2021.04.08.04.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 04:19:46 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        outreachy-kernel@googlegroups.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [Outreachy kernel] [PATCH] staging: rtl8723bs: Change the type and use of a variable
Date:   Thu,  8 Apr 2021 13:19:42 +0200
Message-Id: <20210408111942.19411-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the type of fw_current_in_ps_mode from u8 to bool, because
it is used everywhere as a bool and, accordingly, it should be
declared as a bool. Shorten the controlling
expression of an 'if' statement.

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/staging/rtl8723bs/hal/hal_intf.c        | 2 +-
 drivers/staging/rtl8723bs/include/rtw_pwrctrl.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_intf.c b/drivers/staging/rtl8723bs/hal/hal_intf.c
index 96fe172ced8d..8dc4dd8c6d4c 100644
--- a/drivers/staging/rtl8723bs/hal/hal_intf.c
+++ b/drivers/staging/rtl8723bs/hal/hal_intf.c
@@ -348,7 +348,7 @@ void rtw_hal_dm_watchdog(struct adapter *padapter)
 
 void rtw_hal_dm_watchdog_in_lps(struct adapter *padapter)
 {
-	if (adapter_to_pwrctl(padapter)->fw_current_in_ps_mode == true) {
+	if (adapter_to_pwrctl(padapter)->fw_current_in_ps_mode) {
 		if (padapter->HalFunc.hal_dm_watchdog_in_lps)
 			padapter->HalFunc.hal_dm_watchdog_in_lps(padapter); /* this function caller is in interrupt context */
 	}
diff --git a/drivers/staging/rtl8723bs/include/rtw_pwrctrl.h b/drivers/staging/rtl8723bs/include/rtw_pwrctrl.h
index 5450d20b44a6..c03ae33b0aa6 100644
--- a/drivers/staging/rtl8723bs/include/rtw_pwrctrl.h
+++ b/drivers/staging/rtl8723bs/include/rtw_pwrctrl.h
@@ -203,7 +203,7 @@ struct pwrctrl_priv {
 	u8 LpsIdleCount;
 	u8 power_mgnt;
 	u8 org_power_mgnt;
-	u8 fw_current_in_ps_mode;
+	bool fw_current_in_ps_mode;
 	unsigned long	DelayLPSLastTimeStamp;
 	s32		pnp_current_pwr_state;
 	u8 pnp_bstop_trx;
-- 
2.30.2

