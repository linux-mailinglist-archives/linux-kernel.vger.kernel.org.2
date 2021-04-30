Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3FC336FD0F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 17:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231996AbhD3O7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 10:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbhD3O6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 10:58:33 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B20EC06138B
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:57:45 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id u3so27006874eja.12
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ACO+R08CoyLCjvDMxXLNgD1Yym9DyLgjQx6IL72eiqo=;
        b=Cb58TPZTxpMHBf+GSxxia/jruA+b/5wNawtH2GaAKuZVf/nbkFrKRajNzxX9z5ke56
         hkEFXaH5HYJXsWUgeJaumUlHdkxHPj79dIXGzyPl107H7cgwy2ts8Vx32kJE8+69Wyi2
         LF+c3O8nBOXTMIfGzgPuDAQNPeZ8jqehJ1GoCUnRkpVlzFOMS85qkoP5u08Z7304pPP9
         UrbDnjC7VS+rsim7LqUdhvqc3YCZYFgEO1yflXHSL5S0S8xpcsqVaXZ27K9dfDj/r//E
         jGXbfNeiMpVfyXhuF2ya0pHOM9rog5YW+wbWvbjf139z8vgc5YnTfh6oKuHhGO/4eN1f
         jW3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ACO+R08CoyLCjvDMxXLNgD1Yym9DyLgjQx6IL72eiqo=;
        b=g6nKa+FoO6jnXDfQK2PWnov+hkyS2NfApLQL9TG6GehLS/5L+Utts55FG5pFNhvmaj
         HnnVmRzVs4nMxYRHekNV50xi3jxrQSSe8abj++SUtOhWq3asXoOzMPo5x9wC7+VAVNSb
         nzgODW4rh8DjWRUO58yRLFwxFjVHDqLNSlHILcCyj+9JxbP6twnkf8hV7MkWnpvfm1h7
         9mb4PqLw2DgYqgr8+VmnGlSincejNksoTE1GmFaOUu4vd1fKhILaONuqYZTFa0XFt5Kg
         PucjGtpWy6RwHBs1jBfkAYtqBotD8//DIhE6MwGov9ueVpmxthhEQy1cSxnUXOVUlw0l
         qHwA==
X-Gm-Message-State: AOAM530zYLkzMquDm5dIDBBvvZB3qgJ1M4EJc0aDmoZzjCclH+VA5Yow
        WZBJZMFCvr2VMgiPcL7Eb1hBrjbZRdI=
X-Google-Smtp-Source: ABdhPJxtb3RAkkTHuw4O1xODhTTPGZNzR2NjGgsRR3fsv7IdSEMwgamv0vI9kixWBImvq5KrBZTn8Q==
X-Received: by 2002:a17:906:b7d3:: with SMTP id fy19mr4789821ejb.269.1619794663526;
        Fri, 30 Apr 2021 07:57:43 -0700 (PDT)
Received: from agape ([109.52.244.36])
        by smtp.gmail.com with ESMTPSA id g11sm1452354edw.37.2021.04.30.07.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 07:57:43 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v3 22/43] staging: rtl8723bs: remove braces around single statement in if block
Date:   Fri, 30 Apr 2021 16:56:44 +0200
Message-Id: <1c95d3d0d4ccd74d4e97ee496f7a04eadd1f8ff0.1619794331.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619794331.git.fabioaiuto83@gmail.com>
References: <cover.1619794331.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix following post-commit hook checkatch issue:

WARNING: braces {} are not necessary for single statement blocks
21: FILE: drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c:609:
+				if (!bBtHsOn) {
 					algorithm =
		BT_8723B_1ANT_COEX_ALGO_PANEDR_HID;
 				}

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c b/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c
index 57579d7eab71..911d753e51f6 100644
--- a/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c
+++ b/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c
@@ -606,9 +606,9 @@ static u8 halbtc8723b1ant_ActionAlgorithm(struct btc_coexist *pBtCoexist)
 				pBtLinkInfo->bPanExist &&
 				pBtLinkInfo->bA2dpExist
 			) {
-				if (!bBtHsOn) {
+				if (!bBtHsOn)
 					algorithm = BT_8723B_1ANT_COEX_ALGO_PANEDR_HID;
-				}
+
 			}
 		}
 	}
-- 
2.20.1

