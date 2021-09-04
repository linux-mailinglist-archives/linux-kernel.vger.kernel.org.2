Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84802400B60
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 14:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236478AbhIDMmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 08:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236417AbhIDMl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 08:41:56 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E66CC061575
        for <linux-kernel@vger.kernel.org>; Sat,  4 Sep 2021 05:40:55 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id x2-20020a1c7c02000000b002e6f1f69a1eso1369066wmc.5
        for <linux-kernel@vger.kernel.org>; Sat, 04 Sep 2021 05:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R5159h8xhj2/nW87jp6v3z6F6XpTjvXokOan4r18tqw=;
        b=f9ksiBoaKyLPAauvzJzMGfCjUgFxu6AYOWcyulWbnR5KWXdHrc5ELkj7fu6CeMOhjG
         9J0fAdBGVbfeFKOMJj/ZU6alvMu356tfSyA5hCSNZwxklnmC4d9fjNNSMwVs3GK+rr+K
         vbPy3lwPvuasa8PzYKLrqUTVF1YqrsaB7vRK0CBdzBjBKPJ8KJQGk2Y1nMDm3+WnHux9
         Xalp7IOSpS4c91N5qRVFZflpjSz3QoAV1re0vtmuNguIeiy1EJqlFDBZetJHtJgkKUg9
         QrOGcfxGYBiCfFI5QHS+GnKy/N40Wp9YxTBQbHsilhpJg48DbgyNj4N/zYOOHJ/Y9oK9
         sa8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R5159h8xhj2/nW87jp6v3z6F6XpTjvXokOan4r18tqw=;
        b=MnXPkOyEcHwvj9wBjWXaa0+yKVZ7oSTCFVRIppkr4gF90wxjKrJr7EWRFNiit2bTDI
         XaZcUWUq4gNxoJjXZ/5V4m6ohA3TQvOfie1RSNTqao/PDGPPkccJMJH0f2oNZR+X12JE
         zyFOJeK070Co2AJLnYsmP6HxzUa3WOkEJfmvNHecoQlTLqr9bKkMXJ9ZsZ94So8ZFKgC
         x1gdW6XvkmHzup45jZ3DkfepIpB/ybLVceV/teqtGjmPONRZXF4qolkrbLpIwYupxF4X
         O1M2jflj1khzqn++EXF8LgmJTfxNcDpZSgQnGs5av8ORw0NUnnCKHhUDabWLfiE48B8s
         v1CQ==
X-Gm-Message-State: AOAM533y39eVmUpDppCsrMndV6+Wk0DVNgloZtcLJMNGk7+9Vsbt7whY
        DJ3lO7X58YZNxvq2tC4Fo2Q=
X-Google-Smtp-Source: ABdhPJyrXi3xR1K1vXRbhjo4gjktIdd7K4XY198Ai1x+osHda5e9z1oOmmFGzPCf3O/dG/axzgXVug==
X-Received: by 2002:a7b:c405:: with SMTP id k5mr3012831wmi.87.1630759253739;
        Sat, 04 Sep 2021 05:40:53 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::8fe1])
        by smtp.gmail.com with ESMTPSA id j207sm2094071wmj.40.2021.09.04.05.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Sep 2021 05:40:53 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 3/6] staging: r8188eu: remove read_chip_version from hal_ops
Date:   Sat,  4 Sep 2021 14:40:30 +0200
Message-Id: <20210904124033.14244-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210904124033.14244-1-straube.linux@gmail.com>
References: <20210904124033.14244-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove read_chip_version from hal_ops and remove its wrapper
rtw_hal_read_chip_version(). Call rtl8188e_read_chip_version()
directly instead

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/hal_intf.c          | 6 ------
 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c | 4 +---
 drivers/staging/r8188eu/include/hal_intf.h      | 3 ---
 drivers/staging/r8188eu/include/rtl8188e_hal.h  | 2 ++
 drivers/staging/r8188eu/os_dep/usb_intf.c       | 3 ++-
 5 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/hal_intf.c b/drivers/staging/r8188eu/hal/hal_intf.c
index f58dd3da6c13..1a59644679f1 100644
--- a/drivers/staging/r8188eu/hal/hal_intf.c
+++ b/drivers/staging/r8188eu/hal/hal_intf.c
@@ -6,12 +6,6 @@
 #include "../include/drv_types.h"
 #include "../include/hal_intf.h"
 
-void rtw_hal_read_chip_version(struct adapter *adapt)
-{
-	if (adapt->HalFunc.read_chip_version)
-		adapt->HalFunc.read_chip_version(adapt);
-}
-
 void rtw_hal_def_value_init(struct adapter *adapt)
 {
 	if (adapt->HalFunc.init_default_value)
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index 1adaf472a116..24bc8ba8726e 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -1730,7 +1730,7 @@ static struct HAL_VERSION ReadChipVersion8188E(struct adapter *padapter)
 	return ChipVersion;
 }
 
-static void rtl8188e_read_chip_version(struct adapter *padapter)
+void rtl8188e_read_chip_version(struct adapter *padapter)
 {
 	ReadChipVersion8188E(padapter);
 }
@@ -1798,8 +1798,6 @@ void rtl8188e_set_hal_ops(struct hal_ops *pHalFunc)
 	pHalFunc->dm_init = &rtl8188e_init_dm_priv;
 	pHalFunc->dm_deinit = &rtl8188e_deinit_dm_priv;
 
-	pHalFunc->read_chip_version = &rtl8188e_read_chip_version;
-
 	pHalFunc->set_bwmode_handler = &PHY_SetBWMode8188E;
 	pHalFunc->set_channel_handler = &PHY_SwChnl8188E;
 
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index 9845b6f7378e..7046f4b222b6 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -148,7 +148,6 @@ struct hal_ops {
 
 	void	(*dm_init)(struct adapter *padapter);
 	void	(*dm_deinit)(struct adapter *padapter);
-	void	(*read_chip_version)(struct adapter *padapter);
 
 	void	(*init_default_value)(struct adapter *padapter);
 
@@ -283,8 +282,6 @@ void rtw_hal_stop(struct adapter *padapter);
 void rtw_hal_set_hwreg(struct adapter *padapter, u8 variable, u8 *val);
 void rtw_hal_get_hwreg(struct adapter *padapter, u8 variable, u8 *val);
 
-void rtw_hal_read_chip_version(struct adapter *padapter);
-
 u8 rtw_hal_set_def_var(struct adapter *padapter,
 		       enum hal_def_variable eVariable, void *pValue);
 u8 rtw_hal_get_def_var(struct adapter *padapter,
diff --git a/drivers/staging/r8188eu/include/rtl8188e_hal.h b/drivers/staging/r8188eu/include/rtl8188e_hal.h
index 103991b6ec82..5cd441e8e16b 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_hal.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_hal.h
@@ -437,6 +437,8 @@ bool HalDetectPwrDownMode88E(struct adapter *Adapter);
 void Hal_InitChannelPlan(struct adapter *padapter);
 void rtl8188e_set_hal_ops(struct hal_ops *pHalFunc);
 
+void rtl8188e_read_chip_version(struct adapter *padapter);
+
 void rtl8188e_clone_haldata(struct adapter *dst, struct adapter *src);
 void rtl8188e_start_thread(struct adapter *padapter);
 void rtl8188e_stop_thread(struct adapter *padapter);
diff --git a/drivers/staging/r8188eu/os_dep/usb_intf.c b/drivers/staging/r8188eu/os_dep/usb_intf.c
index bf7ef56d12e3..b7129e8b9924 100644
--- a/drivers/staging/r8188eu/os_dep/usb_intf.c
+++ b/drivers/staging/r8188eu/os_dep/usb_intf.c
@@ -14,6 +14,7 @@
 #include "../include/usb_ops.h"
 #include "../include/usb_osintf.h"
 #include "../include/rtw_ioctl.h"
+#include "../include/rtl8188e_hal.h"
 
 int ui_pid[3] = {0, 0, 0};
 
@@ -599,7 +600,7 @@ static struct adapter *rtw_usb_if1_init(struct dvobj_priv *dvobj,
 	rtw_init_io_priv(padapter, usb_set_intf_ops);
 
 	/* step read_chip_version */
-	rtw_hal_read_chip_version(padapter);
+	rtl8188e_read_chip_version(padapter);
 
 	/* step usb endpoint mapping */
 	rtl8188eu_interface_configure(padapter);
-- 
2.33.0

