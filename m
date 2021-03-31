Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2A1F34FD34
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 11:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234988AbhCaJl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 05:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234849AbhCaJkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 05:40:46 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DCD3C061574
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 02:40:46 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id x21so21515502eds.4
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 02:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ptH+4/9uZVa+tAgJFkoaX1wokNsm+azooLW/83BNidI=;
        b=HqnWE2N+iGGexUeEWZPYPHR0qmKLzqE3WFzMOSaKawNhfxiON/V5s77phgspDAP+Jw
         wNV+90cw+Yivw5L33MzxTvEJR3Kyn4WnB1k1XCrny+KhFQExrQGgM1QDfQyzl8Kgcmv2
         8y/ECp2RZO1rDAuUBJC9Xj8FpjdSMmqgwnPc7gjwfO4JKTYKjl3oboBjWts8sFjeLsOk
         tK5cuKIHPMoBPWi7HadcWIRCwWEdsvnWpSSSRoeBX7wIJO6eKe+3mgLzvRBc9OQipECJ
         UmPP8Zr+0ud1LvehzzYE8GnQMcxa4to8s6cxUaXGKu+mVxNIyMw5dT6+ao52zVPzMCzO
         na2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ptH+4/9uZVa+tAgJFkoaX1wokNsm+azooLW/83BNidI=;
        b=JoFXGBlUOgTkL72FCYIN2+CiFB9W73LiRCg5hLm0wew5hiWSUkf29SQpOJEd42Tlf0
         SAU8NPq9+rRziSIClWO8AjsQ3FPlgaoi6nCEKkhQMuIFETVI+yvLBbiLiMOWc5/MLLgl
         3Vrx83a0hkbe/aaqk3EyrUB1674pZoPa2KK3Lb/UvHgzbKJlBGg7CgBeuyslwoBAKwi6
         J+iGANutSiwLBBsXyEtxieZJ1+FMvUvRN2wNi+J1l7BeV8BDYecQI1VJNpsqGlVyQRqf
         YPmzX50/HsT8bqGspdnzqG59WhNhj7WJBhvhIB0mSIpLxqkZNJO/o9W6Jz2wVNBGe0j5
         boDg==
X-Gm-Message-State: AOAM5338NWjemdTZXkW6lMOm2CTG9Qwlt4WGYfgc4hp0oSIsvrGbBzWK
        vWQJOzk9XRabDtQDPOVmJ9g=
X-Google-Smtp-Source: ABdhPJxEgfMqBOD5jNW4ZopGQXuh4GaIqe27cI8PZ3dgfa9vzGgv2YCQlv4lEyn/wlVyT4AJpNlhLQ==
X-Received: by 2002:aa7:d4cb:: with SMTP id t11mr2576937edr.202.1617183645135;
        Wed, 31 Mar 2021 02:40:45 -0700 (PDT)
Received: from agape ([5.171.73.44])
        by smtp.gmail.com with ESMTPSA id br13sm818951ejb.87.2021.03.31.02.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 02:40:44 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 17/40] staging: rtl8723bs: fix constant name in hal/rtl8723b_hal_init.c
Date:   Wed, 31 Mar 2021 11:39:45 +0200
Message-Id: <2a7ecc09626de4c409cd057492fac193c54d331c.1617183374.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617183374.git.fabioaiuto83@gmail.com>
References: <cover.1617183374.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix constant name in log message call

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index 0273118e70af..0f7da8dbd80c 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -412,7 +412,7 @@ s32 rtl8723b_FirmwareDownload(struct adapter *padapter, bool  bUsedWoWLANFw)
 		RT_TRACE(
 			_module_hal_init_c_,
 			_drv_err_,
-			("Firmware size exceed 0x%X. Check it.\n", FW_8188E_SIZE)
+			("Firmware size exceed 0x%X. Check it.\n", FW_8723B_SIZE)
 		);
 		goto exit;
 	}
-- 
2.20.1

