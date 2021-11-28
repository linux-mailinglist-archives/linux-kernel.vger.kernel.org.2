Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29B28460698
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 14:56:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357712AbhK1N7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 08:59:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346127AbhK1N5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 08:57:36 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB99C06175D
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 05:53:39 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id q3so7726869wru.5
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 05:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FmYuAwim11Nia8KJQLIM3VlP7cUwEH2KKK7OvongJCM=;
        b=k9osS6Jd5ZoRlp7CfgGijfgaFCGWGUeBMDCGDM//1Rb/MBmWjE5JAFgreTL1hvI6Ku
         VpTtbTQfqz/2X1BMZBsFLj6J/7JuVW3mnkKShNW5X852HT24kJCoInxpM0ylhTs2YEKF
         wOk91VsCO6S3BjgtWNuW0ezItAnOE4Fg/mPIgpRkBO1nWdQqIFHcjB7xXcjaaLirGCGk
         nXtEfx8NO/dQGYvlAAIW6UWuVqna7zXoWUFlU/hZ+JRs4+ctWGBZe6Y8aCfBbBsvddyD
         yyUIp30EKT4hsso3zhyukiVXr8F3YO6UGP+6HLyIsMnB5cLKgTukAJQmy+1/95KD7hf8
         05TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FmYuAwim11Nia8KJQLIM3VlP7cUwEH2KKK7OvongJCM=;
        b=KtRfxgsn+1YgpnTgtz+TdFUkPtNobF4O/gGW7OKkeb03kHtLrpeFQugmq/D6/LGD97
         dZElaPJYmMDI6xyEPY2/20PHrFSbgxHycIOOy3+Gzwm+JpYo5VgzLEvkqNGerNKZlKyj
         qb0XI+iG3z+ktvJLzoFmcXuQRT5x1khWO6+B9eQD7HrTzyjSmJNrIID8S/TaMVqVQtM5
         I9apBlDTuX9dtucONzOTCkUyt4XOCC+4zN/5uszc8pquj48zy4+Mg/abhu2vUsl+gfdS
         Tqycx6TL+Rfo2b+tK4WYn5oN63ywoyF6GfpyuubQyZGblGYB0hXeN7OwKu+X4BdSm57J
         qgOQ==
X-Gm-Message-State: AOAM5334OSFGQW/mRzAN+NgNxYc3M1A1nXp66szR6Un1Ae4pWaoLOCVo
        tPHyDFSyfanNymyKbp9kyR4=
X-Google-Smtp-Source: ABdhPJyStiv6FbVEIAcuNumxX3tLv3evCt9WSTpbvttvyaBJatp6BBevWOTl/G38am8q7VlYncQ3CA==
X-Received: by 2002:a5d:5651:: with SMTP id j17mr27132516wrw.166.1638107618395;
        Sun, 28 Nov 2021 05:53:38 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::ac86])
        by smtp.gmail.com with ESMTPSA id l26sm13598510wms.15.2021.11.28.05.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Nov 2021 05:53:38 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 3/5] staging: r8188eu: remove unused HW_VAR_RF_TYPE
Date:   Sun, 28 Nov 2021 14:53:24 +0100
Message-Id: <20211128135326.9838-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211128135326.9838-1-straube.linux@gmail.com>
References: <20211128135326.9838-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After previous cleanups HW_VAR_RF_TYPE is unused now.
Remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/usb_halinit.c  | 3 ---
 drivers/staging/r8188eu/include/hal_intf.h | 1 -
 2 files changed, 4 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 04518e9838ea..9d6ce74d7c31 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -1685,9 +1685,6 @@ void GetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 	case HW_VAR_DM_FLAG:
 		val[0] = podmpriv->SupportAbility;
 		break;
-	case HW_VAR_RF_TYPE:
-		val[0] = haldata->rf_type;
-		break;
 	case HW_VAR_FWLPS_RF_ON:
 		{
 			/* When we halt NIC, we should check if FW LPS is leave. */
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index 693eb32fe1a9..7385ebaaba5c 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -29,7 +29,6 @@ enum hw_variables {
 	HW_VAR_ACK_PREAMBLE,
 	HW_VAR_SEC_CFG,
 	HW_VAR_BCN_VALID,
-	HW_VAR_RF_TYPE,
 	HW_VAR_DM_FLAG,
 	HW_VAR_DM_FUNC_OP,
 	HW_VAR_DM_FUNC_SET,
-- 
2.34.0

