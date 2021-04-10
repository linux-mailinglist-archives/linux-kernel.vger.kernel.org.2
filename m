Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB75135AE26
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 16:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234971AbhDJOV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 10:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234806AbhDJOVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 10:21:13 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD8EC06138D
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 07:20:57 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id s15so9784340edd.4
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 07:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bSqHGysbFGtJeoo67SKhp//nzHiiwWy4mkn3QI9McYI=;
        b=pGDYW7PYcfkcv/e1HkTCjjX12OJ7WlFt59kG3s/j9uzXcnt5vbDNG4rZCuGlwB2Jxq
         3Bm/9oOzsw4YOqMIYPKOrxsDnDrFdFK2vhQ2eSwD48vRFTLHpgxIhvi1Mtui33rxpKfU
         OM5Usjg3dOxoSEx2u+K3BpjR0/M4Zhrj0E1lfna/0tTd/u6LGe2KXADNDfrUOKoGuXYF
         vSiMpK7vLFafWQgCHzcz4ZC6l3EXUpwEc1gJpuimLGMW3SPlMYHV7O6IByiQTPAN/0qz
         YmG0y2S0SVuLbPM1yO9J2h5pRs0URvBYfPGLEPBJX/z4v/L08MFyYip8rSdVQRioSNJp
         ZwVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bSqHGysbFGtJeoo67SKhp//nzHiiwWy4mkn3QI9McYI=;
        b=KDsecplWUrgU7ICvm3WIvus6ij7NGoN81CZNEAEHyY8EOC51rxO60YWBxhjxvJpD9B
         iy2vAVelGBvisQcjwYPeqJNe+eqpEAeeJLyjuGerQ42oeNxNbT0jgPPxevRgXAFkY3W8
         DGAFLxi94CxJIbVIITLGHSmr5vrlvGGBOJv/aepewSjmDQoVKqVUZZy6VrF4Hwx6Sw3N
         5Ynqk+tGlYfUvH/OQ7X6NBOOlA0Rkyo7fXiOEhvi85HluW2AT+F8qnahmy0W3EPp+LTN
         0tHz/guVy86tzRL9fzcH/kfg0VOO00sRxp29h+n9SZz9Ar72o4Yh70LuaFTSy5Fz1ex+
         cNQQ==
X-Gm-Message-State: AOAM531I5S1BD6PgK7XB2896mCshKAxH7XO0dl5VtEa4RkQB+Q5lDHGJ
        +ssTMoBa4fSkJsQCiA4JHMr3Pqx59It23g==
X-Google-Smtp-Source: ABdhPJwdorvH5lggUl7lkAYFgUCoKj7hFGNoZu7juTAtOYr1FG2ui24WmajCz8FfUMsi13o08BvxNw==
X-Received: by 2002:a05:6402:2208:: with SMTP id cq8mr21971576edb.122.1618064456602;
        Sat, 10 Apr 2021 07:20:56 -0700 (PDT)
Received: from agape ([5.171.81.28])
        by smtp.gmail.com with ESMTPSA id l9sm148154ejz.96.2021.04.10.07.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Apr 2021 07:20:56 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 10/25] staging: rtl8723bs: remove code block guarded by undefined SDIO_DEBUG_IO
Date:   Sat, 10 Apr 2021 16:20:23 +0200
Message-Id: <ee77c4b4e6fbba8e0182e9558f793c88cf398cb5.1618064274.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1618064274.git.fabioaiuto83@gmail.com>
References: <cover.1618064274.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove code block guarded by SDIO_DEBUG_IO symbol.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/sdio_ops.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/sdio_ops.c b/drivers/staging/rtl8723bs/hal/sdio_ops.c
index 4403ccdaf2ee..24e45f734bdd 100644
--- a/drivers/staging/rtl8723bs/hal/sdio_ops.c
+++ b/drivers/staging/rtl8723bs/hal/sdio_ops.c
@@ -176,15 +176,7 @@ static u32 sdio_read32(struct intf_hdl *intfhdl, u32 addr)
 		(adapter_to_pwrctl(adapter)->bFwCurrentInPSMode)
 	) {
 		err = sd_cmd52_read(intfhdl, ftaddr, 4, (u8 *)&le_tmp);
-#ifdef SDIO_DEBUG_IO
-		if (!err) {
-#endif
-			return le32_to_cpu(le_tmp);
-#ifdef SDIO_DEBUG_IO
-		}
-
-		return SDIO_ERR_VAL32;
-#endif
+		return le32_to_cpu(le_tmp);
 	}
 
 	/*  4 bytes alignment */
-- 
2.20.1

