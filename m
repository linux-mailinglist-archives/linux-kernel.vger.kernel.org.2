Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6379410819
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 20:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240549AbhIRSVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 14:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240512AbhIRSU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 14:20:57 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C83C061764
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 11:19:32 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id g8so43057608edt.7
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 11:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I0jcC2Su8d4wIhHItiadcLqrply5RR3Vd1Gurt9GSRs=;
        b=VuQ9ik0YfttN4MhlPp9KVm09+HRaNOGBkFW2QVOtUZ7IwHHiPEVn0gGDM4siedp0QL
         Sv/oKfdNUDD2WEEjYkG3Ei1QI+S/Kl76l2FzkwmIS6VIbFwSHK0pNtFJedBWa+Gk+TIu
         kcDaZtMwtJjgNUhE1vhCTHQMV9ne5ew5YSTxM2Atq/rglDbRl21kwzgtDETNpyD1yPiO
         eapy4PaR5oAPi/R2+xLO1StvCu0qZjludQ+PlrLCPtPxq3mG3TwSomYRQmyUX8UoqAIn
         iERHYxPe3ai1EkcNTan8Cdu6hq80N1LieXk145lckLzlrGhpJctopgLA+exk24iPmPzp
         boUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I0jcC2Su8d4wIhHItiadcLqrply5RR3Vd1Gurt9GSRs=;
        b=sCwB7H+kxJdBf2VFCn10Dsat9uM12oj9QZNdoR/l+sd6rC/9ooVwQTAKccn98UXG+q
         O5JQC6r9q+/huE6aNQS1EP9ES3Xhbc+2xsdolNuxNZdzai/NfHvCTZDFoY70THBQacui
         IUJnKjmGYScEMRyBR8gPYrznFdxln7N0QDtx8zjqZVpE7H9mHqxY9EVzFIv9PtfcCC6l
         fffycWefB98O51JaCd21xzwURlFt1eeQgCBWJRXSFdfJDKyQLUz3eTCsgHDQKPirisUf
         edDg+9AZ5unJGyT432zRc1sOxDMv8CpLXQz4r7GRp6MjS4Ttnjddj0sLZfItQdfBo6/A
         Tljw==
X-Gm-Message-State: AOAM532XiX6goVcdZiN9jm5XOxDuIDW2gUi1SUNC7HcSO0NLf/2mhzt0
        bE1yQiGwwnHgChJeG/prh3g=
X-Google-Smtp-Source: ABdhPJy3zZm5udA6BjvdwroEGD/Mh2ihHH73KBqZpKJJWs0ODX9QXlXMlEAeUx2vfpuOgFdvV01UPw==
X-Received: by 2002:a17:906:584:: with SMTP id 4mr19281311ejn.56.1631989171583;
        Sat, 18 Sep 2021 11:19:31 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::cde])
        by smtp.gmail.com with ESMTPSA id t19sm3903673ejb.115.2021.09.18.11.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Sep 2021 11:19:31 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v3 14/14] staging: r8188eu: clean up indentation in odm_RegDefine11N.h
Date:   Sat, 18 Sep 2021 20:19:04 +0200
Message-Id: <20210918181904.12000-15-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210918181904.12000-1-straube.linux@gmail.com>
References: <20210918181904.12000-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up indentation in odm_RegDefine11N.h.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 .../staging/r8188eu/include/odm_RegDefine11N.h   | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/r8188eu/include/odm_RegDefine11N.h b/drivers/staging/r8188eu/include/odm_RegDefine11N.h
index 3e2fd6b1c793..82a602b39cc7 100644
--- a/drivers/staging/r8188eu/include/odm_RegDefine11N.h
+++ b/drivers/staging/r8188eu/include/odm_RegDefine11N.h
@@ -10,14 +10,14 @@
 #define	ODM_REG_RX_DEFUALT_A_11N		0x858
 #define	ODM_REG_ANTSEL_CTRL_11N			0x860
 #define	ODM_REG_RX_ANT_CTRL_11N			0x864
-#define	ODM_REG_PIN_CTRL_11N				0x870
-#define	ODM_REG_SC_CNT_11N				0x8C4
+#define	ODM_REG_PIN_CTRL_11N			0x870
+#define	ODM_REG_SC_CNT_11N			0x8C4
 /* PAGE 9 */
 #define	ODM_REG_ANT_MAPPING1_11N		0x914
 /* PAGE A */
-#define	ODM_REG_CCK_ANTDIV_PARA1_11N	0xA00
-#define	ODM_REG_CCK_CCA_11N				0xA0A
-#define	ODM_REG_CCK_ANTDIV_PARA2_11N	0xA0C
+#define	ODM_REG_CCK_ANTDIV_PARA1_11N		0xA00
+#define	ODM_REG_CCK_CCA_11N			0xA0A
+#define	ODM_REG_CCK_ANTDIV_PARA2_11N		0xA0C
 #define	ODM_REG_CCK_FA_RST_11N			0xA2C
 #define	ODM_REG_CCK_FA_MSB_11N			0xA58
 #define	ODM_REG_CCK_FA_LSB_11N			0xA5C
@@ -28,7 +28,7 @@
 /* PAGE C */
 #define	ODM_REG_OFDM_FA_HOLDC_11N		0xC00
 #define	ODM_REG_OFDM_FA_RSTC_11N		0xC0C
-#define	ODM_REG_IGI_A_11N				0xC50
+#define	ODM_REG_IGI_A_11N			0xC50
 #define	ODM_REG_ANTDIV_PARA1_11N		0xCA4
 #define	ODM_REG_OFDM_FA_TYPE1_11N		0xCF0
 /* PAGE D */
@@ -39,9 +39,9 @@
 
 /* 2 MAC REG LIST */
 #define	ODM_REG_ANTSEL_PIN_11N			0x4C
-#define	ODM_REG_RESP_TX_11N				0x6D8
+#define	ODM_REG_RESP_TX_11N			0x6D8
 
 /* DIG Related */
-#define	ODM_BIT_IGI_11N					0x0000007F
+#define	ODM_BIT_IGI_11N				0x0000007F
 
 #endif
-- 
2.33.0

