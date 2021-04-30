Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B366136F695
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 09:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbhD3HqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 03:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbhD3Hpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 03:45:32 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C14C061342
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 00:44:42 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id gx5so11748299ejb.11
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 00:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ACO+R08CoyLCjvDMxXLNgD1Yym9DyLgjQx6IL72eiqo=;
        b=tWiDGuDbhFAKUMoViFJxdR5bHQffLCvchSsSHNdwinlbPbpv9GxoGJKcPFMqTDfuiN
         iB8y1T57/tbWrteViDc6MYKrD77tA+dKr4rAOQN1QuoeiIH0NzI1UJVmL7gi92cUGlRz
         HZmAL0DFW2KHhDThPUwMdfg1tkiapNSBceUePvo95QnF/fZQiYIKzVOq3Uj7EwaXuZct
         u4Z2JDg0Oji7l6MRNpmPUUX7OxGQUUEhnWktJPp4foew83aTLOi6zSy5SoCi5eKyla9l
         AsBw3fIUa/73FX7zMrXCZh8vRexkIPIzHnMqwgjOzwUOI/ouAV5LmtukHdiyMPmzgoXm
         TmCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ACO+R08CoyLCjvDMxXLNgD1Yym9DyLgjQx6IL72eiqo=;
        b=dEGGU7N9M9Aa80t9TN8eZLO5zym1hpnyL6oL4KNOqoJhVcwpwfh/VLqRfAsiwvRh83
         M9X0KLtbQNRiikfG6Jybk1tprvmny8SuCMm4UEOOAkVDzSLgcOXlS4Xrp8G73zfQ9QFB
         yBGDck6HxfDHhbBnOMYWRXlQJ9IY4Sj+S7g9RAttlfJSYZY9vNpE4xYTfH9ZKibr1gM6
         4gpWvL7gYd6cpHu58Ukcz/Rw61CKoWn4eLcWXwZTpRxmhoqpUVnxUPy6ol6Ll6kp8GFK
         sJ4V8GwY9U8L2VfNSA8A6hqRatvbmHuL5MXUKaRc3ZQkYTYmCpEbFQCL5seq23hwNM4F
         CXDA==
X-Gm-Message-State: AOAM532ARZ7op8bdOSv0xl9VGxZs77zZw+mnamTOdpMCYzPKhMOMRx+J
        s5us/W6jcendB2M5qmkf/hwFoXoR1Wop3w==
X-Google-Smtp-Source: ABdhPJx0sQJ7Fi3DypK72XiEF+xCUqJp/gpWoghAFIaK+MCDOWzImNhgI2uMxiejinoIFsS7X9rA3A==
X-Received: by 2002:a17:906:4119:: with SMTP id j25mr2776538ejk.459.1619768681466;
        Fri, 30 Apr 2021 00:44:41 -0700 (PDT)
Received: from agape ([5.171.81.86])
        by smtp.gmail.com with ESMTPSA id p4sm1449886ejr.81.2021.04.30.00.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 00:44:41 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 22/43] staging: rtl8723bs: remove braces around single statement in if block
Date:   Fri, 30 Apr 2021 09:43:40 +0200
Message-Id: <67181871aa04d5aba0ec93ce4247bb181be51fd0.1619768150.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619768150.git.fabioaiuto83@gmail.com>
References: <cover.1619768150.git.fabioaiuto83@gmail.com>
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

