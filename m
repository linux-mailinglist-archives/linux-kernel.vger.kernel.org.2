Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7BC5460697
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 14:56:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357682AbhK1N7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 08:59:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345486AbhK1N5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 08:57:36 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12205C06175B
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 05:53:39 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id n33-20020a05600c502100b0032fb900951eso14651861wmr.4
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 05:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lgDZB4IOfVNqZTR87ZkJaDoJSzG0JEfpGt4NxaNH5O8=;
        b=GGa2behho5PoCHdivh5qgXgY+0TuDyylj1Lsvs5zHgsQXm2ic+HbCEcSukyZaRJ24q
         5hpvddRfrGtZ3uAq2GOsqagELqNftUuwNaQQy7UsNKM0dowkZS9FH/rW1Sh82U/BAMgH
         Wj6M045AoYsU4a4JbgI/SDoEy/TD+rxel8lXs9ozVKKwzkqxkDH5/Hj/71TRWOorq3QG
         tNmBwb5O72xGZltf8wYWvlaX3EdTKFEAjFWhBtgoQ455gH88BcJ/JKlY9XqYJ7gRKjkt
         7uLgdmkrmPvGK/4Rx90lpefZE+f6UENe/Whr4UMSjAivdmO/LdBVWceFQBWwlNTqP2Kw
         GPwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lgDZB4IOfVNqZTR87ZkJaDoJSzG0JEfpGt4NxaNH5O8=;
        b=w9dsLnAWgmfQ/Esp1DgFZumi8LE9FUdmqbiTo3HhZRybFPNlt+u8exv/3evRdJeHAU
         Jtr8Xhl4NlxuApWyLviEISH49JUOufsksqv8zZL2yWYRrB1b1EwZfOX0uzd0PrNnDXDv
         XPJIV1OAFQQUp3JuLBb1EDHPBHQEOgH4jspuI8mADFbRVjG9d3Ti8w49hI+afxZNnTVt
         tLIsg9aSPrsum7atWcaCfl1VDSVbc6AHd+u/s7WidqXAHsA07hv4FUaxmdEFFGBVu/km
         TtmQQiCSTj7CU/GU2ueJcAgEduzhVttN0cz9Qk4b5OgLRRxVnJX4W78Mbatk81lCT6i4
         nKbQ==
X-Gm-Message-State: AOAM532rW+ad4X0H9clYu8So3RwLJz8kRn4WqFVwiWObtj9n+qEGdN9E
        wkDsemRadCkc7Gsbr26IjOI=
X-Google-Smtp-Source: ABdhPJzaWI12BcW5S1Ml2cGKAoFgQolrORnAG2Y/a8E9/w9Ym1LLeOkZZ6s3OV7IGzML+cpRxbXCjw==
X-Received: by 2002:a1c:f018:: with SMTP id a24mr30154463wmb.51.1638107617694;
        Sun, 28 Nov 2021 05:53:37 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::ac86])
        by smtp.gmail.com with ESMTPSA id l26sm13598510wms.15.2021.11.28.05.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Nov 2021 05:53:37 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/5] staging: r8188eu: remove rf_type from bb_reg_dump()
Date:   Sun, 28 Nov 2021 14:53:23 +0100
Message-Id: <20211128135326.9838-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211128135326.9838-1-straube.linux@gmail.com>
References: <20211128135326.9838-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rf_type is always RF_1T1R. Remove it from bb_reg_dump() and remove
resulting dead code.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/os_dep/ioctl_linux.c | 27 +++++++-------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index 52d42e576443..0d8b0b9a9851 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -3611,27 +3611,18 @@ static void bb_reg_dump(struct adapter *padapter)
 
 static void rf_reg_dump(struct adapter *padapter)
 {
-	int i, j = 1, path;
+	int i, j = 1, path = 0;
 	u32 value;
-	u8 rf_type, path_nums = 0;
-	GetHwReg8188EU(padapter, HW_VAR_RF_TYPE, (u8 *)(&rf_type));
 
 	pr_info("\n ======= RF REG =======\n");
-	if ((RF_1T2R == rf_type) || (RF_1T1R == rf_type))
-		path_nums = 1;
-	else
-		path_nums = 2;
-
-	for (path = 0; path < path_nums; path++) {
-		pr_info("\nRF_Path(%x)\n", path);
-		for (i = 0; i < 0x100; i++) {
-			value = rtl8188e_PHY_QueryRFReg(padapter, path, i, 0xffffffff);
-			if (j % 4 == 1)
-				pr_info("0x%02x ", i);
-			pr_info(" 0x%08x ", value);
-			if ((j++) % 4 == 0)
-				pr_info("\n");
-		}
+	pr_info("\nRF_Path(%x)\n", path);
+	for (i = 0; i < 0x100; i++) {
+		value = rtl8188e_PHY_QueryRFReg(padapter, path, i, 0xffffffff);
+		if (j % 4 == 1)
+			pr_info("0x%02x ", i);
+		pr_info(" 0x%08x ", value);
+		if ((j++) % 4 == 0)
+			pr_info("\n");
 	}
 }
 
-- 
2.34.0

