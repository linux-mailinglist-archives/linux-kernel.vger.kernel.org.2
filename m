Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E06E3D0FAA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 15:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238265AbhGUM6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 08:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238369AbhGUM5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 08:57:07 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38EDCC061767
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 06:37:30 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id hd33so3272474ejc.9
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 06:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vpBo6pS+05Q4WF57DinU840cssZYXHgBom0RqSKX0GE=;
        b=Wilmb2bP/BOc3I9eKR0qxPe0iFuQPb6e7gqLR/pce8zTDhslo0b8sJHP3+V5Jvv0tx
         Mxb54BeNw8i3ZtZ4C3FvOLLRy/PZ18piKWCoHFT9gnnFrDEOkaT2BF13YOYkP3Kch4uZ
         uyK7Pr348LffMjJn6vFNzWNZfAJqCG+nV7AQ2E9gMj9kIgqwviYFll139BgNYmA598aH
         eMYKr143soS5gHZbp6+MisZRlWc42dYNT7U8jhnXuDdSYxSj723+RZ4aYK6v/jf+gHCk
         qjy7DLGym4BXkRNBexKOTGKXgkF2lrQCMDfptJJ5DQkx81Ip+Zkd0vWfjXLIhQ6h/JG9
         TpmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vpBo6pS+05Q4WF57DinU840cssZYXHgBom0RqSKX0GE=;
        b=tsPDgmZ+NeU33UxMgfE42z37vPR/DfH4xK9yOfdq8OkbRbxM6dRuxDI3X1ar3xqwuX
         LNKvzFYBo2c9KzPfOPXBqlHjo6+Ckj43TVS6+fRzFzvuamxYpmlHWVyUSFt2/sg+8Zqe
         1X4Ug4JkXLE3seX631qqUQIMpEoZNPdvdEQzH9GP3ijzS3wUSreYsosbLgutunxFq6xa
         XvSZ0+BYV2BMaVAl4XoWo2l4ehuklYGHGZJp61SugpcnBfGj5NNOXqsdGTy6s8+wTTjE
         Gdp2ULhuJziUR4ZUWgpG+4OuXopqfxzZ3YgnJYLJHa3jNYM+oWdZXbPKhKcCjOiQCn1U
         YEcA==
X-Gm-Message-State: AOAM530W9IhaklXEgkoZQ80FGsTNgaIw/65BwbxBl4k/qTWSKpA6vBBo
        X+jRzIeevyJP06HK9U5Bj3XnOXyBdbI=
X-Google-Smtp-Source: ABdhPJyYpdVIZ6TT0O4QzNZpFrQLwZzBqAAvW4Mu6Md7E4IVrf9AKbW2WfU9FAIKN8RkFrr9zG9nwQ==
X-Received: by 2002:a17:906:eb99:: with SMTP id mh25mr38244801ejb.330.1626874648655;
        Wed, 21 Jul 2021 06:37:28 -0700 (PDT)
Received: from agape ([5.171.73.45])
        by smtp.gmail.com with ESMTPSA id k21sm8320045ejj.55.2021.07.21.06.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 06:37:28 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 02/16] staging: rtl8723bs: fix camel case inside function
Date:   Wed, 21 Jul 2021 15:37:09 +0200
Message-Id: <831b5f56cc6df8885ac61837fe53f63e021b289b.1626874164.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1626874164.git.fabioaiuto83@gmail.com>
References: <cover.1626874164.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix camel case inside function Hal_GetChnlGroup8723B()

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 .../staging/rtl8723bs/hal/rtl8723b_hal_init.c | 24 +++++++++----------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index bd0e9f05eb5c..246a5362a54f 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -2061,18 +2061,18 @@ s32 rtl8723b_InitLLTTable(struct adapter *padapter)
 	return ret;
 }
 
-static void Hal_GetChnlGroup8723B(u8 Channel, u8 *pGroup)
-{
-	if (1  <= Channel && Channel <= 2)
-		*pGroup = 0;
-	else if (3  <= Channel && Channel <= 5)
-		*pGroup = 1;
-	else if (6  <= Channel && Channel <= 8)
-		*pGroup = 2;
-	else if (9  <= Channel && Channel <= 11)
-		*pGroup = 3;
-	else if (12 <= Channel && Channel <= 14)
-		*pGroup = 4;
+static void Hal_GetChnlGroup8723B(u8 channel, u8 *group)
+{
+	if (1  <= channel && channel <= 2)
+		*group = 0;
+	else if (3  <= channel && channel <= 5)
+		*group = 1;
+	else if (6  <= channel && channel <= 8)
+		*group = 2;
+	else if (9  <= channel && channel <= 11)
+		*group = 3;
+	else if (12 <= channel && channel <= 14)
+		*group = 4;
 }
 
 void Hal_InitPGData(struct adapter *padapter, u8 *PROMContent)
-- 
2.20.1

