Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96AB236FD14
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 17:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232272AbhD3O7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 10:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbhD3O6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 10:58:43 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3321BC06134D
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:57:55 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id d14so19167712edc.12
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vvsMkKSxObWfrYf5zpIINvfbNjNueuFKMoVjdC9Jfxw=;
        b=PP757Ux6hmGGJohllcmZV4WIU8qD7TKi9Egr1sGgp2BLiArIqqogjnquAP4vbZLqzp
         lSJ1OqulIT7kcvftM+b2aXd4kr7XPiSjyWlUpgn7rkvpDQJWtllgwroyRydxHaMkGImR
         1Y8efocIPjqHq0pMMhhhLBCOZ3K4bz5Wh4dronavRqpONC204b4CDBv5tXckm8QIa8nq
         UBM3HQt2O51EUn8M1vZcw/GRVHN85lEMid5OcZBuM0FriYXMqSUC6oYKIhgjhfGjd2WI
         7CFwf9PaCXJH0lH9oMgF5Nup76XvB+yzZOTWZZd1xtx16nkyLku35blfOE3Tx8bCTY8Y
         1zvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vvsMkKSxObWfrYf5zpIINvfbNjNueuFKMoVjdC9Jfxw=;
        b=hiRL45VmHoUeNwVNWjhkJ1Bumv5Sy8LpsE03eh6TSTcG3ryfxixh2EobfaQhrwFsJO
         G3teMaaspfnUlPHF81CazSV90B5Ahshcas76tg30IiiLaW5qIRdPhjxlrUyBud0QK+Tz
         MzsaNAhWlLuW52PlNyiZDaag1c6TY6Mlg6gCVlB1VIsS851dNVJNi+MuK1wWfWODviAH
         mgfHymJcuJRDH3XAj3l1iRqk05TWSYzKGo/TLKMKt6o0CJln6QKkT1HCuHB3bSnDhKbP
         MAQD+SVEmGOCF5jodMo5eYB5tlFUGM/dlY9/IsBzueFMShej72k3UznbXRo/laEVfqzc
         kxbA==
X-Gm-Message-State: AOAM532fWAJaVk9L+YkjglI3JNadZmIAewM3g1s71Yrkehb82GPy5Vzk
        PhRTEwz79CGdrXK0DF17gog2cbtKXl0=
X-Google-Smtp-Source: ABdhPJz493glCKuv5PW8ESieEabKcY+eaWmMcAxo6rX6MzcgNPQ0URu4SFiId55oynIvUaERYfPfPA==
X-Received: by 2002:a05:6402:1516:: with SMTP id f22mr6451941edw.33.1619794673377;
        Fri, 30 Apr 2021 07:57:53 -0700 (PDT)
Received: from agape ([109.52.244.36])
        by smtp.gmail.com with ESMTPSA id g11sm1494983edt.35.2021.04.30.07.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 07:57:53 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v3 28/43] staging: rtl8723bs: remove empty #ifdef block
Date:   Fri, 30 Apr 2021 16:56:50 +0200
Message-Id: <9a2095cfd69647dd304eb9e059a6aa9aa00694e6.1619794331.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619794331.git.fabioaiuto83@gmail.com>
References: <cover.1619794331.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove empty #ifdef block.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h b/drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h
index 9c9ad29870e2..f2793d5d9a30 100644
--- a/drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h
+++ b/drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h
@@ -112,11 +112,6 @@ extern u32 		GLBtcDbgType[];
 #define CL_SPRINTF	snprintf
 #define CL_PRINTF	DCMD_Printf
 
-/*  The following is for dbgview print */
-#if DBG
-#else
-#endif
-
 struct btc_board_info {
 	/*  The following is some board information */
 	u8 btChipType;
-- 
2.20.1

