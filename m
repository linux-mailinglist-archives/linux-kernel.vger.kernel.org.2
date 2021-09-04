Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E517D400B5E
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 14:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236425AbhIDMl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 08:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236237AbhIDMly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 08:41:54 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D968C061575
        for <linux-kernel@vger.kernel.org>; Sat,  4 Sep 2021 05:40:53 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id u15so1137438wmj.1
        for <linux-kernel@vger.kernel.org>; Sat, 04 Sep 2021 05:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y9NOLVNCg5vyFaFZcP/LgsBaZ+PUGsqLHHY87rmIV10=;
        b=K8GRDebkz9ObEz33QLQH3DA0mEsuyqgTTO+Fg7Ec080oQCrncq+XL7qB/4zLyzEcJn
         MwgjOwFj2P9fU835mdGDt8pvBPIIprkrWyCsDrSxSrlsEEtZTwro3d/7+DPP6vki8BiE
         CklaCGm4vdgGOyz7bctcMZ1Cbe52LG3c/VHNeWZPwxEW0z9VGe4HHlk3eRfH2m4qRUWz
         JConsI1LcSqvjtFGGxavDoO6/r2vmSvQADlalMNCAZrMFqt9w22im3Bdk9oGeJdWiFsi
         QtuLMhdHhM5/JK2osZDJc5pEq02XxeyTHVOhiDDk6XpNqOX4NruKIRWFyf5KWBFxi+y3
         EcbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y9NOLVNCg5vyFaFZcP/LgsBaZ+PUGsqLHHY87rmIV10=;
        b=JPQSqI8gghpdDt7yAwKKKOSffYHS5ZUdMnbvvywQwUoErmZvHQe9enuMSohvLCA201
         wMfhyYL9j7EIhrIo1QeCjXYHdcBIhJDh9BWCD4pNQWPRaGF22KzHwXoNdHW2taU1C3f1
         co/yR8nNU0gYIU/01aQJR29Zsn0Hvz4DLnLizfVxkSvr1/Xk4H7VWDOjS7wFubjbYFrE
         issNfn2jsv4nftjLFr9PcxxLZIBsdWNS+2aPQbLzzEjFPjqINLzxtADCrfwy0mA9nupo
         +cJx6TPKe5kmBqtStyEeqsHx5WjeT2mnhKjUgz4fhuZqwuJrlZcyUG/EzlaYtf6vky/W
         l9Zg==
X-Gm-Message-State: AOAM533PHmALd5ulzpvItiwkE3yZ/SerFT78d75lce9CtwIxYfY1MYHc
        kLiYAURl5EJ6ocRfnpCMz0U=
X-Google-Smtp-Source: ABdhPJwt0vAGEDj3gBn7GJguPN7RbIKUbXuJvobhfWqJmYZmFZUjV77I1dSu55qspq8DRDvTLRfUNQ==
X-Received: by 2002:a05:600c:19ca:: with SMTP id u10mr3023465wmq.178.1630759252067;
        Sat, 04 Sep 2021 05:40:52 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::8fe1])
        by smtp.gmail.com with ESMTPSA id j207sm2094071wmj.40.2021.09.04.05.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Sep 2021 05:40:51 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/6] staging: r8188eu: remove intf_chip_configure from hal_ops
Date:   Sat,  4 Sep 2021 14:40:28 +0200
Message-Id: <20210904124033.14244-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210904124033.14244-1-straube.linux@gmail.com>
References: <20210904124033.14244-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove intf_chip_configure from hal_ops and remove its wrapper
rtw_hal_chip_configure(). Call rtl8188eu_interface_configure()
directly instead.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/hal_intf.c     | 6 ------
 drivers/staging/r8188eu/hal/usb_halinit.c  | 3 +--
 drivers/staging/r8188eu/include/hal_intf.h | 6 +++---
 drivers/staging/r8188eu/os_dep/usb_intf.c  | 2 +-
 4 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/hal_intf.c b/drivers/staging/r8188eu/hal/hal_intf.c
index bcc77da06c08..f52c77279f3d 100644
--- a/drivers/staging/r8188eu/hal/hal_intf.c
+++ b/drivers/staging/r8188eu/hal/hal_intf.c
@@ -6,12 +6,6 @@
 #include "../include/drv_types.h"
 #include "../include/hal_intf.h"
 
-void rtw_hal_chip_configure(struct adapter *adapt)
-{
-	if (adapt->HalFunc.intf_chip_configure)
-		adapt->HalFunc.intf_chip_configure(adapt);
-}
-
 void rtw_hal_read_chip_info(struct adapter *adapt)
 {
 	if (adapt->HalFunc.read_adapter_info)
diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 147c51255878..df1887bf29eb 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -60,7 +60,7 @@ static bool HalUsbSetQueuePipeMapping8188EUsb(struct adapter *adapt, u8 NumInPip
 	return result;
 }
 
-static void rtl8188eu_interface_configure(struct adapter *adapt)
+void rtl8188eu_interface_configure(struct adapter *adapt)
 {
 	struct hal_data_8188e	*haldata	= GET_HAL_DATA(adapt);
 	struct dvobj_priv	*pdvobjpriv = adapter_to_dvobj(adapt);
@@ -2250,7 +2250,6 @@ void rtl8188eu_set_hal_ops(struct adapter *adapt)
 	halfunc->DeInitSwLeds = &rtl8188eu_DeInitSwLeds;
 
 	halfunc->init_default_value = &rtl8188eu_init_default_value;
-	halfunc->intf_chip_configure = &rtl8188eu_interface_configure;
 	halfunc->read_adapter_info = &ReadAdapterInfo8188EU;
 
 	halfunc->SetHwRegHandler = &SetHwReg8188EU;
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index 5f6ef4d6333a..6740a6570e6a 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -152,8 +152,6 @@ struct hal_ops {
 
 	void	(*init_default_value)(struct adapter *padapter);
 
-	void	(*intf_chip_configure)(struct adapter *padapter);
-
 	void	(*read_adapter_info)(struct adapter *padapter);
 
 	void	(*enable_interrupt)(struct adapter *padapter);
@@ -267,6 +265,9 @@ struct hal_ops {
 #define is_boot_from_eeprom(adapter) (adapter->eeprompriv.EepromOrEfuse)
 
 void rtl8188eu_set_hal_ops(struct adapter *padapter);
+
+void rtl8188eu_interface_configure(struct adapter *adapt);
+
 void rtw_hal_def_value_init(struct adapter *padapter);
 
 void	rtw_hal_free_data(struct adapter *padapter);
@@ -283,7 +284,6 @@ void rtw_hal_stop(struct adapter *padapter);
 void rtw_hal_set_hwreg(struct adapter *padapter, u8 variable, u8 *val);
 void rtw_hal_get_hwreg(struct adapter *padapter, u8 variable, u8 *val);
 
-void rtw_hal_chip_configure(struct adapter *padapter);
 void rtw_hal_read_chip_info(struct adapter *padapter);
 void rtw_hal_read_chip_version(struct adapter *padapter);
 
diff --git a/drivers/staging/r8188eu/os_dep/usb_intf.c b/drivers/staging/r8188eu/os_dep/usb_intf.c
index bb85ab77fd26..d4765205ae26 100644
--- a/drivers/staging/r8188eu/os_dep/usb_intf.c
+++ b/drivers/staging/r8188eu/os_dep/usb_intf.c
@@ -602,7 +602,7 @@ static struct adapter *rtw_usb_if1_init(struct dvobj_priv *dvobj,
 	rtw_hal_read_chip_version(padapter);
 
 	/* step usb endpoint mapping */
-	rtw_hal_chip_configure(padapter);
+	rtl8188eu_interface_configure(padapter);
 
 	/* step read efuse/eeprom data and get mac_addr */
 	rtw_hal_read_chip_info(padapter);
-- 
2.33.0

