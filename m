Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD7A35548B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 15:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239779AbhDFNGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 09:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232492AbhDFNGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 09:06:11 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE0CCC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 06:06:01 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id u21so21793848ejo.13
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 06:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GGmF2rdYBG/AzXYkXGuoMiHqRDGWNujv9sDGHDshI+4=;
        b=UvrRF0jRMWdyA5DUZeBThTmI4cjr5LtugXUAVt5KpC5Rvkz+dne/RZT6Zn1Z36EmNP
         D2VJMIUM1etZ0X4xqM1yaerIxfB0yxn5+jYDEihiHHH9w+BczKzHGWAMTqTepXP2RkRG
         s97EHzhXQvl5QpDiaFszmNGGhrFlgks8c0UkWNEbSGhmCVzC6RRT60F12xvTtoUkOdCO
         ORMhuLpJY56FdYrEX4CGIX+UBdxrcdUhfct8VmUWlsP2XQudzmOAYaM8WX4YbmJaGvxf
         fiHrFCnKt5ibFTBDCEwT0HZNXe8TKoXDh0YEUD9wy2JHr2GnJQn+Zw6k6RAwwtqaXD0P
         54dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GGmF2rdYBG/AzXYkXGuoMiHqRDGWNujv9sDGHDshI+4=;
        b=SC4aBrgsIZXS7FHiCyav6OLZ9GO9YJZ5zlnDHlivJH6jcGF7LemG/nPHardWHP4EJg
         hqhUF5WOhRwkls8CzaWWAiijM8DiWMFujASsuMi32wfzBND4oenCl8z0XSdNuJ65upa0
         KE3KUDhCNHdY98/JbGxlLqWHLxx78VAetvmSqwKzFfjed2TwjL0dvKFWTWCG+bRVFZJ1
         LYqPuQLf3mdka6AX4N4Y4KZAO0R/P35Cx7xKjdUcWPTkOvgb3Tbs5g5vlzFH/ey0mN1h
         LvRKv4Q9fQUHQ0yvY3u512xfJu5/xuBMIuh1XSfG5OjccWdljPeCO782tV81taQ+0nYD
         as7g==
X-Gm-Message-State: AOAM531i7wvT3kfDYtZM0UtizzEqGJ8clnsaBm8ti7rULS27gsCQcfjS
        9FYE+NNoVZWP/w3LeAODFwE=
X-Google-Smtp-Source: ABdhPJyDiLxHkbaP3sk3sljMSPq8gh5F6eiS3+6mRIt2nNBTNMbuQsixxnx4KtiQTg2977NTRT1YjQ==
X-Received: by 2002:a17:907:2bdd:: with SMTP id gv29mr33145501ejc.259.1617714360617;
        Tue, 06 Apr 2021 06:06:00 -0700 (PDT)
Received: from localhost.localdomain (host-79-42-91-147.retail.telecomitalia.it. [79.42.91.147])
        by smtp.gmail.com with ESMTPSA id t14sm10967241ejc.121.2021.04.06.06.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 06:06:00 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     gregkh@linuxfoundation.org, outreachy-kernel@googlegroups.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [Outreachy kernel] [PATCH v2] staging: rtl8723bs: hal: Remove camelcase in Hal8723BReg.h
Date:   Tue,  6 Apr 2021 15:05:56 +0200
Message-Id: <20210406130556.1417-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove camelcase in some symbols defined in Hal8723BReg.h. These symbols
are not used anywhere else, therefore this patch does not break the driver.

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/staging/rtl8723bs/hal/Hal8723BReg.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/Hal8723BReg.h b/drivers/staging/rtl8723bs/hal/Hal8723BReg.h
index cc249e15b4bd..60c1f966c5de 100644
--- a/drivers/staging/rtl8723bs/hal/Hal8723BReg.h
+++ b/drivers/staging/rtl8723bs/hal/Hal8723BReg.h
@@ -110,7 +110,7 @@
 #define REG_RSVD3_8723B				0x0168
 #define REG_C2HEVT_MSG_NORMAL_8723B		0x01A0
 #define REG_C2HEVT_CMD_SEQ_88XX			0x01A1
-#define REG_C2hEVT_CMD_CONTENT_88XX		0x01A2
+#define REG_C2HEVT_CMD_CONTENT_88XX		0x01A2
 #define REG_C2HEVT_CMD_LEN_88XX			0x01AE
 #define REG_C2HEVT_CLEAR_8723B			0x01AF
 #define REG_MCUTST_1_8723B			0x01C0
@@ -424,13 +424,13 @@
 #define	IMR_RXFOVW_8723B		BIT8	/* Receive FIFO Overflow */
 
 /* 2 ACMHWCTRL 0x05C0 */
-#define	AcmHw_HwEn_8723B		BIT(0)
-#define	AcmHw_VoqEn_8723B		BIT(1)
-#define	AcmHw_ViqEn_8723B		BIT(2)
-#define	AcmHw_BeqEn_8723B		BIT(3)
-#define	AcmHw_VoqStatus_8723B		BIT(5)
-#define	AcmHw_ViqStatus_8723B		BIT(6)
-#define	AcmHw_BeqStatus_8723B		BIT(7)
+#define	ACMHW_HWEN_8723B		BIT(0)
+#define	ACMHW_VOQEN_8723B		BIT(1)
+#define	ACMHW_VIQEN_8723B		BIT(2)
+#define	ACMHW_BEQEN_8723B		BIT(3)
+#define	ACMHW_VOQSTATUS_8723B		BIT(5)
+#define	ACMHW_VIQSTATUS_8723B		BIT(6)
+#define	ACMHW_BEQSTATUS_8723B		BIT(7)
 
 /* 8195 (RCR) Receive Configuration Register	(Offset 0x608, 32 bits) */
 #define	RCR_TCPOFLD_EN			BIT25	/* Enable TCP checksum offload */
-- 
2.30.2

