Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3B923DA9BD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 19:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232296AbhG2RKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 13:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbhG2RJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 13:09:52 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81501C061765
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 10:09:48 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 48-20020a9d0bb30000b02904cd671b911bso6589844oth.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 10:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RicV499WZNq7QZbO+9Y5GGhbIPo1CGCHmOmkOGx7UNw=;
        b=i3SvBHm5SPIrtiAaCEphHFlTcSXChyk/iW276Xt/YnhddQFl6SEkPl/m7G02v0mmQm
         eY9R4KCwT7FsRaRQxNdlkF6+nk3nYyQEwsuS75YnMx3t91l3hQqRaWFVtpvjcIwnYLKr
         XvgHHZFBgn2zsMvyJygu0Pcxht/vrRnXAS9SVG9D9S0JG03Qg8GG0Jt0f5cqKLZIYPfD
         NfKfAcIeBicFE8Gus3KC6hkaQQ+cJscMf+imitVjWlcc3u9R6wZFshWOkggyOxdet+5o
         SREu2lIbGsaHo0BooLkl3i+q8g9zYlRkQqNp6+P4b3qx/UpB6xpZexHX3+9J3ZUw5PgV
         2gfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=RicV499WZNq7QZbO+9Y5GGhbIPo1CGCHmOmkOGx7UNw=;
        b=UD3b5vfnXkjQC9d9XbD5wfvSaWzQBX7VwWK/nl2IEPTZMTQCVTw5pBLlvsIN9xKbuq
         6Vso9gtkF8WaWQN1bL0fDxdKU2N/JXt7TiOuHcTlpNbz4QM/gnVRRFvPfn6nTuSVFIty
         rxZ3H0mki0TW2/ThvIRdzr5XNjR+i8eUA91EQgeJH4L+fms0Dx9RD7gXZaf1b5Zm+NFo
         EJrjZ/T0SYuOFDO98RW+bGTzWc3qOZ3XQlMoI6GKLvbar/2V7JdOkIQSp0tooGHTm/Xm
         rc2U4h4ds3jK6tZuuhV9jAMoiDOqyiRYV6FK8nVUow1Bw0An3wpZ+s7CHEsEQeuPx7cy
         rNWg==
X-Gm-Message-State: AOAM533xK+tNOXgDuP2dk/N2T1qU9lRtHcnIeYV5Aa6VutEEraF+nGPo
        XKbw0XTaV5Mq9CWpWuj4qYw=
X-Google-Smtp-Source: ABdhPJxHfQzhwoC+z4R/qNmK1tyK0AvQiaae9pe8CDbqbYzsQWRp5Q3vkremarDKZ8RV0IOO27nX0A==
X-Received: by 2002:a05:6830:1290:: with SMTP id z16mr4084701otp.28.1627578587949;
        Thu, 29 Jul 2021 10:09:47 -0700 (PDT)
Received: from 2603-8090-2005-39b3-0000-0000-0000-100a.res6.spectrum.com.com (2603-8090-2005-39b3-0000-0000-0000-100a.res6.spectrum.com. [2603:8090:2005:39b3::100a])
        by smtp.gmail.com with ESMTPSA id a23sm614358otv.79.2021.07.29.10.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 10:09:47 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     gregkh@linuxfoundation.org
Cc:     phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH 4/6] staging: r8188eu: Remove header file include/usb_hal.h
Date:   Thu, 29 Jul 2021 12:09:28 -0500
Message-Id: <20210729170930.23171-5-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210729170930.23171-1-Larry.Finger@lwfinger.net>
References: <20210729170930.23171-1-Larry.Finger@lwfinger.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This header only includes one prototype and one define statement. The
new definition is used once, thus it can be removed. The prototype is
moved to a header that is already called by the supplier and the user
of that routine, thus the small header is removed.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
 drivers/staging/r8188eu/hal/hal_intf.c     |  1 -
 drivers/staging/r8188eu/hal/usb_halinit.c  |  1 -
 drivers/staging/r8188eu/include/hal_intf.h |  1 +
 drivers/staging/r8188eu/include/usb_hal.h  | 10 ----------
 drivers/staging/r8188eu/os_dep/os_intfs.c  |  1 -
 drivers/staging/r8188eu/os_dep/usb_intf.c  |  3 +--
 6 files changed, 2 insertions(+), 15 deletions(-)
 delete mode 100644 drivers/staging/r8188eu/include/usb_hal.h

diff --git a/drivers/staging/r8188eu/hal/hal_intf.c b/drivers/staging/r8188eu/hal/hal_intf.c
index 4dda247e386a..02d76ac782d8 100644
--- a/drivers/staging/r8188eu/hal/hal_intf.c
+++ b/drivers/staging/r8188eu/hal/hal_intf.c
@@ -5,7 +5,6 @@
 #include <osdep_service.h>
 #include <drv_types.h>
 #include <hal_intf.h>
-#include <usb_hal.h>
 
 void rtw_hal_chip_configure(struct adapter *adapt)
 {
diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 8ecb94728462..f784d8dcdd34 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -11,7 +11,6 @@
 #include <rtl8188e_led.h>
 #include <rtw_iol.h>
 #include <usb_ops.h>
-#include <usb_hal.h>
 #include <usb_osintf.h>
 
 #define		HAL_MAC_ENABLE	1
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index c829aee518dd..d64fcda37100 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -309,6 +309,7 @@ enum hardware_type {
 
 #define is_boot_from_eeprom(adapter) (adapter->eeprompriv.EepromOrEfuse)
 
+void rtl8188eu_set_hal_ops(struct adapter *padapter);
 void rtw_hal_def_value_init(struct adapter *padapter);
 
 void	rtw_hal_free_data(struct adapter *padapter);
diff --git a/drivers/staging/r8188eu/include/usb_hal.h b/drivers/staging/r8188eu/include/usb_hal.h
deleted file mode 100644
index 584602c40cca..000000000000
--- a/drivers/staging/r8188eu/include/usb_hal.h
+++ /dev/null
@@ -1,10 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
-/* Copyright(c) 2007 - 2011 Realtek Corporation. */
-
-#ifndef __USB_HAL_H__
-#define __USB_HAL_H__
-
-void rtl8188eu_set_hal_ops(struct adapter *padapter);
-#define hal_set_hal_ops	rtl8188eu_set_hal_ops
-
-#endif /* __USB_HAL_H__ */
diff --git a/drivers/staging/r8188eu/os_dep/os_intfs.c b/drivers/staging/r8188eu/os_dep/os_intfs.c
index 454b94b037f3..34af5237d9e6 100644
--- a/drivers/staging/r8188eu/os_dep/os_intfs.c
+++ b/drivers/staging/r8188eu/os_dep/os_intfs.c
@@ -12,7 +12,6 @@
 #include <rtw_version.h>
 
 #include <usb_osintf.h>
-#include <usb_hal.h>
 #include <rtw_br_ext.h>
 #include <linux/version.h>
 
diff --git a/drivers/staging/r8188eu/os_dep/usb_intf.c b/drivers/staging/r8188eu/os_dep/usb_intf.c
index 9be70ed65072..905a08ebd80d 100644
--- a/drivers/staging/r8188eu/os_dep/usb_intf.c
+++ b/drivers/staging/r8188eu/os_dep/usb_intf.c
@@ -15,7 +15,6 @@
 #include <usb_vendor_req.h>
 #include <usb_ops.h>
 #include <usb_osintf.h>
-#include <usb_hal.h>
 #include <rtw_ioctl.h>
 
 int ui_pid[3] = {0, 0, 0};
@@ -628,7 +627,7 @@ static struct adapter *rtw_usb_if1_init(struct dvobj_priv *dvobj,
 	padapter = rtw_netdev_priv(pnetdev);
 
 	/* step 2. hook HalFunc, allocate HalData */
-	hal_set_hal_ops(padapter);
+	rtl8188eu_set_hal_ops(padapter);
 
 	padapter->intf_start = &usb_intf_start;
 	padapter->intf_stop = &usb_intf_stop;
-- 
2.32.0

