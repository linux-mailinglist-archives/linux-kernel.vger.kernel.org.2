Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A79C53D0FAB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 15:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238257AbhGUM65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 08:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238367AbhGUM5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 08:57:07 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75CB7C061766
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 06:37:29 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id oz7so3316884ejc.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 06:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yrXsTHWY2k3HUSMD6kvKz+z4pqHJHinlSSpdLkyTkq0=;
        b=O1XFBqfkaxlzRl/tSU33Bap4Te5QArd4J57GfqmJACO9REMDI0I89pUbIlMwXvHBpV
         ALZ601U/qK5FVGJxQoSvEHGhifUts31fg82jE7uq5SLb/4HG03XXOviOcF99zEIfozD8
         qje79UHTbYRIaY8jzG8kqg1KeUOixP9nI9WGjIyCmErwX5xthHPOGZHZqntBBhM68SdV
         CcSK47RtIz5+U0r9p6ZjfwSw++ITyy9dJTB78TU6/JTI1HlQzlg4PNpcrrnO+Y1Qfe6W
         GQJ1hJ/F8nD0CjDQE1AwCelD/UuvAesLSLt+3k3yGJpLMnijNxB7mpzWgp6H0U78Q2NK
         DThw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yrXsTHWY2k3HUSMD6kvKz+z4pqHJHinlSSpdLkyTkq0=;
        b=CRhED6buwk6828tqEBndDXoiQM3dSwUxVYTkqPdpPeZIksu3jnJBSBFWx9rtuJOzYE
         TCL3bFM4oxraOp3gEK5N4mB4ij+ttKo2aQN09otcZvquJzRXV00obnVNSEPvbU9boEC2
         g2oVsXYKXisJjqTBahWzNA1A+cndMDb0n9iTDYtfKQIvmTsQ57YmiUasLNLWk/+hRLCy
         /DZw7S/KoCRemlYyEy2VuicCZO49dz+L/4+YVyNu3gTmUuS1fq/vEEFV9qYQzqmy7On1
         iH+Kyjd8Q8By+y2K46LlI8iok1Hvv/HdcGPcCFe6bT48Ppz/QbSMXEbEOtJqiDnTGxUP
         n4Hg==
X-Gm-Message-State: AOAM530BZbiufyqjVG8ZElMaGG9qqXpY277p/sDVh0i1YOi2fuGwXR3M
        yMomeGCDEscX9DMu6upH3kSZOfIDyIQ=
X-Google-Smtp-Source: ABdhPJxiNiX6JSyw4QaJCVJBFrcXgOOakeMZYCxIOAdfBEzedsTfqKGa/xoyn/ypN/P2eBKM090X/g==
X-Received: by 2002:a17:907:2ce8:: with SMTP id hz8mr38372921ejc.88.1626874647270;
        Wed, 21 Jul 2021 06:37:27 -0700 (PDT)
Received: from agape ([5.171.73.45])
        by smtp.gmail.com with ESMTPSA id kj26sm8516587ejc.24.2021.07.21.06.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 06:37:26 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 01/16] staging: rtl8723bs: simplify function selecting channel group
Date:   Wed, 21 Jul 2021 15:37:08 +0200
Message-Id: <a5536788004c44fe819c0eab0d19504824af46cd.1626874164.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1626874164.git.fabioaiuto83@gmail.com>
References: <cover.1626874164.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

simplify function Hal_GetChnlGroup8723B(). It returns
an unused and unnecessary bool value telling which
band the device works on. Since we work only on
2.4Ghz band and the useful return value is the
second function argument we convert the return type to
void.

remove 5Ghz dead code either (for channel > 14).

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 .../staging/rtl8723bs/hal/rtl8723b_hal_init.c | 62 ++++---------------
 1 file changed, 12 insertions(+), 50 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index 059d3050acc6..bd0e9f05eb5c 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -2061,56 +2061,18 @@ s32 rtl8723b_InitLLTTable(struct adapter *padapter)
 	return ret;
 }
 
-static bool Hal_GetChnlGroup8723B(u8 Channel, u8 *pGroup)
-{
-	bool bIn24G = true;
-
-	if (Channel <= 14) {
-		bIn24G = true;
-
-		if (1  <= Channel && Channel <= 2)
-			*pGroup = 0;
-		else if (3  <= Channel && Channel <= 5)
-			*pGroup = 1;
-		else if (6  <= Channel && Channel <= 8)
-			*pGroup = 2;
-		else if (9  <= Channel && Channel <= 11)
-			*pGroup = 3;
-		else if (12 <= Channel && Channel <= 14)
-			*pGroup = 4;
-	} else {
-		bIn24G = false;
-
-		if (36   <= Channel && Channel <=  42)
-			*pGroup = 0;
-		else if (44   <= Channel && Channel <=  48)
-			*pGroup = 1;
-		else if (50   <= Channel && Channel <=  58)
-			*pGroup = 2;
-		else if (60   <= Channel && Channel <=  64)
-			*pGroup = 3;
-		else if (100  <= Channel && Channel <= 106)
-			*pGroup = 4;
-		else if (108  <= Channel && Channel <= 114)
-			*pGroup = 5;
-		else if (116  <= Channel && Channel <= 122)
-			*pGroup = 6;
-		else if (124  <= Channel && Channel <= 130)
-			*pGroup = 7;
-		else if (132  <= Channel && Channel <= 138)
-			*pGroup = 8;
-		else if (140  <= Channel && Channel <= 144)
-			*pGroup = 9;
-		else if (149  <= Channel && Channel <= 155)
-			*pGroup = 10;
-		else if (157  <= Channel && Channel <= 161)
-			*pGroup = 11;
-		else if (165  <= Channel && Channel <= 171)
-			*pGroup = 12;
-		else if (173  <= Channel && Channel <= 177)
-			*pGroup = 13;
-	}
-	return bIn24G;
+static void Hal_GetChnlGroup8723B(u8 Channel, u8 *pGroup)
+{
+	if (1  <= Channel && Channel <= 2)
+		*pGroup = 0;
+	else if (3  <= Channel && Channel <= 5)
+		*pGroup = 1;
+	else if (6  <= Channel && Channel <= 8)
+		*pGroup = 2;
+	else if (9  <= Channel && Channel <= 11)
+		*pGroup = 3;
+	else if (12 <= Channel && Channel <= 14)
+		*pGroup = 4;
 }
 
 void Hal_InitPGData(struct adapter *padapter, u8 *PROMContent)
-- 
2.20.1

