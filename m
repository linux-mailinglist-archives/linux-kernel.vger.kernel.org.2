Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D88823DA95D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 18:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232013AbhG2Qtb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 12:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbhG2QtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 12:49:15 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 169C5C061765
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 09:49:12 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id t128so9299085oig.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 09:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qOlOr6kILJ/7MMoW5OYVAA7e9hN2pA9o/I2ZjFUkeyo=;
        b=ZmFAteKUC7QkWAMhikfbSQmnmZKNsFJrXRMequz//tZMgkzpAa7K7aJUZS8/mpcgHU
         TRTCpxJA9IEQVFnfm2Hsu2bBu1HmDKuXprDUOprG9B2g3PbzEErVJjN2AZWnTW5cFju9
         WyyqgwHkrxsJ90b7YAXoW47xdQbskMa+zW8qfZsT+oNziR5fxYG/B4QVpAbj4HpwcF+I
         U9t8Sbx3S7MGTeHH/GO5SQ/7mZlRgvDXTATbdYlFiURBzQTVXf9sYCa7/frEKwTAwUuW
         cj8+mKipdad2VcQCReRfj3eF6jfO1ODygWvaBSGHR22g5h6E3BKOWiOPREck/KmdGeql
         pgjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=qOlOr6kILJ/7MMoW5OYVAA7e9hN2pA9o/I2ZjFUkeyo=;
        b=lqzMR8ISWhIU/uQCM11TH/PnZu2OF1GWbtOqOh9jMM6MFELMqQVLZoRcHDNx/KAAmx
         nWQ4are9uO+WvAohU0K+b/DDqpgVf3jKBf6TcQrDETczhFjnJPB5xKyEj9zze4yZpiZM
         uX5VFLyJgfoqVJtiBXCjtlrUYWebh4oansLpfcnOsttBVhYICtB/Tb5h9JH2b5PbKnHl
         807Qw9/iTEqMPzKPrH42YOScP+5K2T412hjP8L/mtRRbVDXhb5DBg/dujy74Pbiiu0Bk
         gvz2lMzruSwN6PVWziLk5ZNH+GpFuRYWSDvku2JMB6M57B7WMvXOuqz+cy+JM9jFWvG+
         6nag==
X-Gm-Message-State: AOAM532Rihr2qskLYllOTqZysfrsAtWVeOyMFeQznMjO7g4wgKP3DTfj
        zo9XK979pSHm/rwtXC9tOUk=
X-Google-Smtp-Source: ABdhPJymoXQQvHhiYLZCR+lxec48F7P/LFUI93EN70nCfKh/0x0qPYp1zL0cbkvTM5TdzGmzyZew0Q==
X-Received: by 2002:aca:dd85:: with SMTP id u127mr3630561oig.161.1627577349886;
        Thu, 29 Jul 2021 09:49:09 -0700 (PDT)
Received: from 2603-8090-2005-39b3-0000-0000-0000-100a.res6.spectrum.com.com (2603-8090-2005-39b3-0000-0000-0000-100a.res6.spectrum.com. [2603:8090:2005:39b3::100a])
        by smtp.gmail.com with ESMTPSA id n202sm694066oig.10.2021.07.29.09.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 09:49:09 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     gregkh@linuxfoundation.org
Cc:     phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH v2 3/6] staging: r8188eu: Convert header copyright info to SPDX format, part 3
Date:   Thu, 29 Jul 2021 11:48:11 -0500
Message-Id: <20210729164814.32097-4-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210729164814.32097-1-Larry.Finger@lwfinger.net>
References: <20210729164814.32097-1-Larry.Finger@lwfinger.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before this driver can be incorporated in the drivers/net/wireless tree,
the copyright info in all files must be converted to SPDX notation.
This patch converts the next 49 files.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
v2 - Added public mailing list
---
 drivers/staging/r8188eu/include/recv_osdep.h  | 22 +++---------------
 .../staging/r8188eu/include/rtl8188e_cmd.h    | 22 +++---------------
 drivers/staging/r8188eu/include/rtl8188e_dm.h | 23 ++++---------------
 .../staging/r8188eu/include/rtl8188e_hal.h    | 22 +++---------------
 .../staging/r8188eu/include/rtl8188e_led.h    | 22 +++---------------
 .../staging/r8188eu/include/rtl8188e_recv.h   | 22 +++---------------
 drivers/staging/r8188eu/include/rtl8188e_rf.h | 22 +++---------------
 .../staging/r8188eu/include/rtl8188e_spec.h   | 21 +++--------------
 .../staging/r8188eu/include/rtl8188e_sreset.h | 22 +++---------------
 .../staging/r8188eu/include/rtl8188e_xmit.h   | 22 +++---------------
 drivers/staging/r8188eu/include/rtw_android.h | 21 ++---------------
 drivers/staging/r8188eu/include/rtw_ap.h      | 22 +++---------------
 drivers/staging/r8188eu/include/rtw_br_ext.h  | 22 +++---------------
 drivers/staging/r8188eu/include/rtw_cmd.h     | 22 +++---------------
 drivers/staging/r8188eu/include/rtw_debug.h   | 22 +++---------------
 drivers/staging/r8188eu/include/rtw_eeprom.h  | 22 +++---------------
 drivers/staging/r8188eu/include/rtw_efuse.h   | 22 +++---------------
 drivers/staging/r8188eu/include/rtw_event.h   | 22 +++---------------
 drivers/staging/r8188eu/include/rtw_ht.h      | 22 +++---------------
 drivers/staging/r8188eu/include/rtw_io.h      | 21 ++---------------
 drivers/staging/r8188eu/include/rtw_ioctl.h   | 22 +++---------------
 .../staging/r8188eu/include/rtw_ioctl_rtl.h   | 22 +++---------------
 .../staging/r8188eu/include/rtw_ioctl_set.h   | 22 +++---------------
 drivers/staging/r8188eu/include/rtw_iol.h     | 22 +++---------------
 drivers/staging/r8188eu/include/rtw_led.h     | 22 +++---------------
 drivers/staging/r8188eu/include/rtw_mlme.h    | 22 +++---------------
 .../staging/r8188eu/include/rtw_mlme_ext.h    | 22 +++---------------
 drivers/staging/r8188eu/include/rtw_mp.h      | 22 +++---------------
 .../staging/r8188eu/include/rtw_mp_ioctl.h    | 22 +++---------------
 .../r8188eu/include/rtw_mp_phy_regdef.h       | 22 +++---------------
 drivers/staging/r8188eu/include/rtw_p2p.h     | 22 +++---------------
 drivers/staging/r8188eu/include/rtw_pwrctrl.h | 22 +++---------------
 drivers/staging/r8188eu/include/rtw_qos.h     | 22 +++---------------
 drivers/staging/r8188eu/include/rtw_recv.h    | 22 +++---------------
 drivers/staging/r8188eu/include/rtw_rf.h      | 22 +++---------------
 .../staging/r8188eu/include/rtw_security.h    | 22 +++---------------
 drivers/staging/r8188eu/include/rtw_sreset.h  | 22 +++---------------
 drivers/staging/r8188eu/include/rtw_version.h |  1 +
 drivers/staging/r8188eu/include/rtw_xmit.h    | 22 +++---------------
 drivers/staging/r8188eu/include/sta_info.h    | 22 +++---------------
 drivers/staging/r8188eu/include/usb_hal.h     | 22 +++---------------
 drivers/staging/r8188eu/include/usb_ops.h     | 22 +++---------------
 .../staging/r8188eu/include/usb_ops_linux.h   | 22 +++---------------
 drivers/staging/r8188eu/include/usb_osintf.h  | 22 +++---------------
 .../staging/r8188eu/include/usb_vendor_req.h  | 22 +++---------------
 drivers/staging/r8188eu/include/wifi.h        | 22 +++---------------
 drivers/staging/r8188eu/include/wlan_bssdef.h | 22 +++---------------
 drivers/staging/r8188eu/include/xmit_osdep.h  | 22 +++---------------
 48 files changed, 141 insertions(+), 892 deletions(-)

diff --git a/drivers/staging/r8188eu/include/recv_osdep.h b/drivers/staging/r8188eu/include/recv_osdep.h
index b6ddf0ba2dde..eebd06e6329e 100644
--- a/drivers/staging/r8188eu/include/recv_osdep.h
+++ b/drivers/staging/r8188eu/include/recv_osdep.h
@@ -1,22 +1,6 @@
-/******************************************************************************
- *
- * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
- *
- ******************************************************************************/
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/* Copyright(c) 2007 - 2011 Realtek Corporation. */
+
 #ifndef __RECV_OSDEP_H_
 #define __RECV_OSDEP_H_
 
diff --git a/drivers/staging/r8188eu/include/rtl8188e_cmd.h b/drivers/staging/r8188eu/include/rtl8188e_cmd.h
index b32bc28503d0..6fbf9a47430b 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_cmd.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_cmd.h
@@ -1,22 +1,6 @@
-/******************************************************************************
- *
- * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
- *
- ******************************************************************************/
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/* Copyright(c) 2007 - 2011 Realtek Corporation. */
+
 #ifndef __RTL8188E_CMD_H__
 #define __RTL8188E_CMD_H__
 
diff --git a/drivers/staging/r8188eu/include/rtl8188e_dm.h b/drivers/staging/r8188eu/include/rtl8188e_dm.h
index 97a3175250ef..3ead20b321a9 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_dm.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_dm.h
@@ -1,24 +1,9 @@
-/******************************************************************************
- *
- * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
- *
- ******************************************************************************/
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/* Copyright(c) 2007 - 2011 Realtek Corporation. */
+
 #ifndef __RTL8188E_DM_H__
 #define __RTL8188E_DM_H__
+
 enum{
 	UP_LINK,
 	DOWN_LINK,
diff --git a/drivers/staging/r8188eu/include/rtl8188e_hal.h b/drivers/staging/r8188eu/include/rtl8188e_hal.h
index 09368a5cd6e8..ea879572d6e1 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_hal.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_hal.h
@@ -1,22 +1,6 @@
-/******************************************************************************
- *
- * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
- *
- ******************************************************************************/
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/* Copyright(c) 2007 - 2011 Realtek Corporation. */
+
 #ifndef __RTL8188E_HAL_H__
 #define __RTL8188E_HAL_H__
 
diff --git a/drivers/staging/r8188eu/include/rtl8188e_led.h b/drivers/staging/r8188eu/include/rtl8188e_led.h
index 9cb03d6565d3..e1b4e078fd8b 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_led.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_led.h
@@ -1,22 +1,6 @@
-/******************************************************************************
- *
- * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
- *
- ******************************************************************************/
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/* Copyright(c) 2007 - 2011 Realtek Corporation. */
+
 #ifndef __RTL8188E_LED_H__
 #define __RTL8188E_LED_H__
 
diff --git a/drivers/staging/r8188eu/include/rtl8188e_recv.h b/drivers/staging/r8188eu/include/rtl8188e_recv.h
index e2ef281c2c44..bc1d532592b9 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_recv.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_recv.h
@@ -1,22 +1,6 @@
-/******************************************************************************
- *
- * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
- *
- ******************************************************************************/
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/* Copyright(c) 2007 - 2011 Realtek Corporation. */
+
 #ifndef __RTL8188E_RECV_H__
 #define __RTL8188E_RECV_H__
 
diff --git a/drivers/staging/r8188eu/include/rtl8188e_rf.h b/drivers/staging/r8188eu/include/rtl8188e_rf.h
index 0ebdc369b542..da6b7f8212a3 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_rf.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_rf.h
@@ -1,22 +1,6 @@
-/******************************************************************************
- *
- * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
- *
- ******************************************************************************/
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/* Copyright(c) 2007 - 2011 Realtek Corporation. */
+
 #ifndef __RTL8188E_RF_H__
 #define __RTL8188E_RF_H__
 
diff --git a/drivers/staging/r8188eu/include/rtl8188e_spec.h b/drivers/staging/r8188eu/include/rtl8188e_spec.h
index 3956f770a951..85e66d6ca2ba 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_spec.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_spec.h
@@ -1,21 +1,6 @@
-/******************************************************************************
- *
- * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
- *******************************************************************************/
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/* Copyright(c) 2007 - 2011 Realtek Corporation. */
+
 #ifndef __RTL8188E_SPEC_H__
 #define __RTL8188E_SPEC_H__
 
diff --git a/drivers/staging/r8188eu/include/rtl8188e_sreset.h b/drivers/staging/r8188eu/include/rtl8188e_sreset.h
index a29e69519794..6158ba19a920 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_sreset.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_sreset.h
@@ -1,22 +1,6 @@
-/******************************************************************************
- *
- * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
- *
- ******************************************************************************/
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/* Copyright(c) 2007 - 2011 Realtek Corporation. */
+
 #ifndef _RTL8188E_SRESET_H_
 #define _RTL8188E_SRESET_H_
 
diff --git a/drivers/staging/r8188eu/include/rtl8188e_xmit.h b/drivers/staging/r8188eu/include/rtl8188e_xmit.h
index 5e586058826d..e9b71de0d165 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_xmit.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_xmit.h
@@ -1,22 +1,6 @@
-/******************************************************************************
- *
- * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
- *
- ******************************************************************************/
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/* Copyright(c) 2007 - 2011 Realtek Corporation. */
+
 #ifndef __RTL8188E_XMIT_H__
 #define __RTL8188E_XMIT_H__
 
diff --git a/drivers/staging/r8188eu/include/rtw_android.h b/drivers/staging/r8188eu/include/rtw_android.h
index e85bf1ff01f8..f60cf1c82984 100644
--- a/drivers/staging/r8188eu/include/rtw_android.h
+++ b/drivers/staging/r8188eu/include/rtw_android.h
@@ -1,22 +1,5 @@
-/******************************************************************************
- *
- * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
- *
- ******************************************************************************/
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/* Copyright(c) 2007 - 2011 Realtek Corporation. */
 
 #ifndef __RTW_ANDROID_H__
 #define __RTW_ANDROID_H__
diff --git a/drivers/staging/r8188eu/include/rtw_ap.h b/drivers/staging/r8188eu/include/rtw_ap.h
index bf3c9fb60153..3662941ce9a8 100644
--- a/drivers/staging/r8188eu/include/rtw_ap.h
+++ b/drivers/staging/r8188eu/include/rtw_ap.h
@@ -1,22 +1,6 @@
-/******************************************************************************
- *
- * Copyright(c) 2007 - 2012 Realtek Corporation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
- *
- ******************************************************************************/
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/* Copyright(c) 2007 - 2012 Realtek Corporation. */
+
 #ifndef __RTW_AP_H_
 #define __RTW_AP_H_
 
diff --git a/drivers/staging/r8188eu/include/rtw_br_ext.h b/drivers/staging/r8188eu/include/rtw_br_ext.h
index f21e7a4515d0..00d461c4c6fa 100644
--- a/drivers/staging/r8188eu/include/rtw_br_ext.h
+++ b/drivers/staging/r8188eu/include/rtw_br_ext.h
@@ -1,22 +1,6 @@
-/******************************************************************************
- *
- * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
- *
- ******************************************************************************/
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/* Copyright(c) 2007 - 2011 Realtek Corporation. */
+
 #ifndef _RTW_BR_EXT_H_
 #define _RTW_BR_EXT_H_
 
diff --git a/drivers/staging/r8188eu/include/rtw_cmd.h b/drivers/staging/r8188eu/include/rtw_cmd.h
index 357e732ac046..9eefafd7ad7d 100644
--- a/drivers/staging/r8188eu/include/rtw_cmd.h
+++ b/drivers/staging/r8188eu/include/rtw_cmd.h
@@ -1,22 +1,6 @@
-/******************************************************************************
- *
- * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
- *
- ******************************************************************************/
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/* Copyright(c) 2007 - 2011 Realtek Corporation. */
+
 #ifndef __RTW_CMD_H_
 #define __RTW_CMD_H_
 
diff --git a/drivers/staging/r8188eu/include/rtw_debug.h b/drivers/staging/r8188eu/include/rtw_debug.h
index d94639a8dc63..f8a969e339b1 100644
--- a/drivers/staging/r8188eu/include/rtw_debug.h
+++ b/drivers/staging/r8188eu/include/rtw_debug.h
@@ -1,22 +1,6 @@
-/******************************************************************************
- *
- * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
- *
- ******************************************************************************/
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/* Copyright(c) 2007 - 2011 Realtek Corporation. */
+
 #ifndef __RTW_DEBUG_H__
 #define __RTW_DEBUG_H__
 
diff --git a/drivers/staging/r8188eu/include/rtw_eeprom.h b/drivers/staging/r8188eu/include/rtw_eeprom.h
index 0b27eb7325c5..dcd6b8523865 100644
--- a/drivers/staging/r8188eu/include/rtw_eeprom.h
+++ b/drivers/staging/r8188eu/include/rtw_eeprom.h
@@ -1,22 +1,6 @@
-/******************************************************************************
- *
- * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
- *
- ******************************************************************************/
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/* Copyright(c) 2007 - 2011 Realtek Corporation. */
+
 #ifndef __RTW_EEPROM_H__
 #define __RTW_EEPROM_H__
 
diff --git a/drivers/staging/r8188eu/include/rtw_efuse.h b/drivers/staging/r8188eu/include/rtw_efuse.h
index cee6b5e8b070..60f9f59d1efd 100644
--- a/drivers/staging/r8188eu/include/rtw_efuse.h
+++ b/drivers/staging/r8188eu/include/rtw_efuse.h
@@ -1,22 +1,6 @@
-/******************************************************************************
- *
- * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
- *
- ******************************************************************************/
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/* Copyright(c) 2007 - 2011 Realtek Corporation. */
+
 #ifndef __RTW_EFUSE_H__
 #define __RTW_EFUSE_H__
 
diff --git a/drivers/staging/r8188eu/include/rtw_event.h b/drivers/staging/r8188eu/include/rtw_event.h
index f7004d6a3bbb..c0fa91591b9e 100644
--- a/drivers/staging/r8188eu/include/rtw_event.h
+++ b/drivers/staging/r8188eu/include/rtw_event.h
@@ -1,22 +1,6 @@
-/******************************************************************************
- *
- * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
- *
- ******************************************************************************/
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/* Copyright(c) 2007 - 2011 Realtek Corporation. */
+
 #ifndef _RTW_EVENT_H_
 #define _RTW_EVENT_H_
 
diff --git a/drivers/staging/r8188eu/include/rtw_ht.h b/drivers/staging/r8188eu/include/rtw_ht.h
index 80154224af92..b3a978e905d0 100644
--- a/drivers/staging/r8188eu/include/rtw_ht.h
+++ b/drivers/staging/r8188eu/include/rtw_ht.h
@@ -1,22 +1,6 @@
-/******************************************************************************
- *
- * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
- *
- ******************************************************************************/
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/* Copyright(c) 2007 - 2011 Realtek Corporation. */
+
 #ifndef _RTW_HT_H_
 #define _RTW_HT_H_
 
diff --git a/drivers/staging/r8188eu/include/rtw_io.h b/drivers/staging/r8188eu/include/rtw_io.h
index d7dee537c252..e2aae349d8fd 100644
--- a/drivers/staging/r8188eu/include/rtw_io.h
+++ b/drivers/staging/r8188eu/include/rtw_io.h
@@ -1,22 +1,5 @@
-/******************************************************************************
- *
- * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
- *
- ******************************************************************************/
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/* Copyright(c) 2007 - 2011 Realtek Corporation. */
 
 #ifndef _RTW_IO_H_
 #define _RTW_IO_H_
diff --git a/drivers/staging/r8188eu/include/rtw_ioctl.h b/drivers/staging/r8188eu/include/rtw_ioctl.h
index 8ffa73239819..2cdeb244d23e 100644
--- a/drivers/staging/r8188eu/include/rtw_ioctl.h
+++ b/drivers/staging/r8188eu/include/rtw_ioctl.h
@@ -1,22 +1,6 @@
-/******************************************************************************
- *
- * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
- *
- ******************************************************************************/
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/* Copyright(c) 2007 - 2011 Realtek Corporation. */
+
 #ifndef _RTW_IOCTL_H_
 #define _RTW_IOCTL_H_
 
diff --git a/drivers/staging/r8188eu/include/rtw_ioctl_rtl.h b/drivers/staging/r8188eu/include/rtw_ioctl_rtl.h
index 8fa3858cb776..18014dd8476f 100644
--- a/drivers/staging/r8188eu/include/rtw_ioctl_rtl.h
+++ b/drivers/staging/r8188eu/include/rtw_ioctl_rtl.h
@@ -1,22 +1,6 @@
-/******************************************************************************
- *
- * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
- *
- ******************************************************************************/
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/* Copyright(c) 2007 - 2011 Realtek Corporation. */
+
 #ifndef _RTW_IOCTL_RTL_H_
 #define _RTW_IOCTL_RTL_H_
 
diff --git a/drivers/staging/r8188eu/include/rtw_ioctl_set.h b/drivers/staging/r8188eu/include/rtw_ioctl_set.h
index 794f98167c3c..2214cee35ae7 100644
--- a/drivers/staging/r8188eu/include/rtw_ioctl_set.h
+++ b/drivers/staging/r8188eu/include/rtw_ioctl_set.h
@@ -1,22 +1,6 @@
-/******************************************************************************
- *
- * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
- *
- ******************************************************************************/
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/* Copyright(c) 2007 - 2011 Realtek Corporation. */
+
 #ifndef __RTW_IOCTL_SET_H_
 #define __RTW_IOCTL_SET_H_
 
diff --git a/drivers/staging/r8188eu/include/rtw_iol.h b/drivers/staging/r8188eu/include/rtw_iol.h
index 6949922baa65..89668122a876 100644
--- a/drivers/staging/r8188eu/include/rtw_iol.h
+++ b/drivers/staging/r8188eu/include/rtw_iol.h
@@ -1,22 +1,6 @@
-/******************************************************************************
- *
- * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
- *
- ******************************************************************************/
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/* Copyright(c) 2007 - 2011 Realtek Corporation. */
+
 #ifndef __RTW_IOL_H_
 #define __RTW_IOL_H_
 
diff --git a/drivers/staging/r8188eu/include/rtw_led.h b/drivers/staging/r8188eu/include/rtw_led.h
index 1e6a8090a753..128cdc10b9b5 100644
--- a/drivers/staging/r8188eu/include/rtw_led.h
+++ b/drivers/staging/r8188eu/include/rtw_led.h
@@ -1,22 +1,6 @@
-/******************************************************************************
- *
- * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
- *
- ******************************************************************************/
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/* Copyright(c) 2007 - 2011 Realtek Corporation. */
+
 #ifndef __RTW_LED_H_
 #define __RTW_LED_H_
 
diff --git a/drivers/staging/r8188eu/include/rtw_mlme.h b/drivers/staging/r8188eu/include/rtw_mlme.h
index a53a567b2960..7cab18047cef 100644
--- a/drivers/staging/r8188eu/include/rtw_mlme.h
+++ b/drivers/staging/r8188eu/include/rtw_mlme.h
@@ -1,22 +1,6 @@
-/******************************************************************************
- *
- * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
- *
- ******************************************************************************/
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/* Copyright(c) 2007 - 2011 Realtek Corporation. */
+
 #ifndef __RTW_MLME_H_
 #define __RTW_MLME_H_
 
diff --git a/drivers/staging/r8188eu/include/rtw_mlme_ext.h b/drivers/staging/r8188eu/include/rtw_mlme_ext.h
index fdb79587762e..eaaedf7d7305 100644
--- a/drivers/staging/r8188eu/include/rtw_mlme_ext.h
+++ b/drivers/staging/r8188eu/include/rtw_mlme_ext.h
@@ -1,22 +1,6 @@
-/******************************************************************************
- *
- * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
- *
- ******************************************************************************/
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/* Copyright(c) 2007 - 2011 Realtek Corporation. */
+
 #ifndef __RTW_MLME_EXT_H_
 #define __RTW_MLME_EXT_H_
 
diff --git a/drivers/staging/r8188eu/include/rtw_mp.h b/drivers/staging/r8188eu/include/rtw_mp.h
index 9111e58e0598..c0974189e92d 100644
--- a/drivers/staging/r8188eu/include/rtw_mp.h
+++ b/drivers/staging/r8188eu/include/rtw_mp.h
@@ -1,22 +1,6 @@
-/******************************************************************************
- *
- * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
- *
- ******************************************************************************/
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/* Copyright(c) 2007 - 2011 Realtek Corporation. */
+
 #ifndef _RTW_MP_H_
 #define _RTW_MP_H_
 
diff --git a/drivers/staging/r8188eu/include/rtw_mp_ioctl.h b/drivers/staging/r8188eu/include/rtw_mp_ioctl.h
index 12835e448d80..b23ca88ceb9e 100644
--- a/drivers/staging/r8188eu/include/rtw_mp_ioctl.h
+++ b/drivers/staging/r8188eu/include/rtw_mp_ioctl.h
@@ -1,22 +1,6 @@
-/******************************************************************************
- *
- * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
- *
- ******************************************************************************/
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/* Copyright(c) 2007 - 2011 Realtek Corporation. */
+
 #ifndef _RTW_MP_IOCTL_H_
 #define _RTW_MP_IOCTL_H_
 
diff --git a/drivers/staging/r8188eu/include/rtw_mp_phy_regdef.h b/drivers/staging/r8188eu/include/rtw_mp_phy_regdef.h
index ae4c9df7f42a..c2be770a5f5d 100644
--- a/drivers/staging/r8188eu/include/rtw_mp_phy_regdef.h
+++ b/drivers/staging/r8188eu/include/rtw_mp_phy_regdef.h
@@ -1,22 +1,6 @@
-/******************************************************************************
- *
- * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
- *
- ******************************************************************************/
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/* Copyright(c) 2007 - 2011 Realtek Corporation. */
+
 /*****************************************************************************
  *
  * Module:	__RTW_MP_PHY_REGDEF_H_
diff --git a/drivers/staging/r8188eu/include/rtw_p2p.h b/drivers/staging/r8188eu/include/rtw_p2p.h
index a3e3adc92b99..29f908f36598 100644
--- a/drivers/staging/r8188eu/include/rtw_p2p.h
+++ b/drivers/staging/r8188eu/include/rtw_p2p.h
@@ -1,22 +1,6 @@
-/******************************************************************************
- *
- * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
- *
- ******************************************************************************/
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/* Copyright(c) 2007 - 2011 Realtek Corporation. */
+
 #ifndef __RTW_P2P_H_
 #define __RTW_P2P_H_
 
diff --git a/drivers/staging/r8188eu/include/rtw_pwrctrl.h b/drivers/staging/r8188eu/include/rtw_pwrctrl.h
index 3db33cd9fee7..bd86666d0f66 100644
--- a/drivers/staging/r8188eu/include/rtw_pwrctrl.h
+++ b/drivers/staging/r8188eu/include/rtw_pwrctrl.h
@@ -1,22 +1,6 @@
-/******************************************************************************
- *
- * Copyright(c) 2007 - 2012 Realtek Corporation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
- *
- ******************************************************************************/
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/* Copyright(c) 2007 - 2012 Realtek Corporation. */
+
 #ifndef __RTW_PWRCTRL_H_
 #define __RTW_PWRCTRL_H_
 
diff --git a/drivers/staging/r8188eu/include/rtw_qos.h b/drivers/staging/r8188eu/include/rtw_qos.h
index bbee1ddc00bb..3150e00b8d3a 100644
--- a/drivers/staging/r8188eu/include/rtw_qos.h
+++ b/drivers/staging/r8188eu/include/rtw_qos.h
@@ -1,22 +1,6 @@
-/******************************************************************************
- *
- * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
- *
- ******************************************************************************/
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/* Copyright(c) 2007 - 2011 Realtek Corporation. */
+
 #ifndef _RTW_QOS_H_
 #define _RTW_QOS_H_
 
diff --git a/drivers/staging/r8188eu/include/rtw_recv.h b/drivers/staging/r8188eu/include/rtw_recv.h
index bc097ed7f966..9a81e66d93fd 100644
--- a/drivers/staging/r8188eu/include/rtw_recv.h
+++ b/drivers/staging/r8188eu/include/rtw_recv.h
@@ -1,22 +1,6 @@
-/******************************************************************************
- *
- * Copyright(c) 2007 - 2012 Realtek Corporation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
- *
- ******************************************************************************/
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/* Copyright(c) 2007 - 2012 Realtek Corporation. */
+
 #ifndef _RTW_RECV_H_
 #define _RTW_RECV_H_
 
diff --git a/drivers/staging/r8188eu/include/rtw_rf.h b/drivers/staging/r8188eu/include/rtw_rf.h
index d4415e8115b2..17d34dead8e0 100644
--- a/drivers/staging/r8188eu/include/rtw_rf.h
+++ b/drivers/staging/r8188eu/include/rtw_rf.h
@@ -1,22 +1,6 @@
-/******************************************************************************
- *
- * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
- *
- ******************************************************************************/
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/* Copyright(c) 2007 - 2011 Realtek Corporation. */
+
 #ifndef	__RTW_RF_H_
 #define __RTW_RF_H_
 
diff --git a/drivers/staging/r8188eu/include/rtw_security.h b/drivers/staging/r8188eu/include/rtw_security.h
index c720ed1117db..6e039e87b04d 100644
--- a/drivers/staging/r8188eu/include/rtw_security.h
+++ b/drivers/staging/r8188eu/include/rtw_security.h
@@ -1,22 +1,6 @@
-/******************************************************************************
- *
- * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
- *
- ******************************************************************************/
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/* Copyright(c) 2007 - 2011 Realtek Corporation. */
+
 #ifndef __RTW_SECURITY_H_
 #define __RTW_SECURITY_H_
 
diff --git a/drivers/staging/r8188eu/include/rtw_sreset.h b/drivers/staging/r8188eu/include/rtw_sreset.h
index 2a1244f75790..1ac7d566362a 100644
--- a/drivers/staging/r8188eu/include/rtw_sreset.h
+++ b/drivers/staging/r8188eu/include/rtw_sreset.h
@@ -1,22 +1,6 @@
-/******************************************************************************
- *
- * Copyright(c) 2007 - 2012 Realtek Corporation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
- *
- ******************************************************************************/
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/* Copyright(c) 2007 - 2012 Realtek Corporation. */
+
 #ifndef _RTW_SRESET_C_
 #define _RTW_SRESET_C_
 
diff --git a/drivers/staging/r8188eu/include/rtw_version.h b/drivers/staging/r8188eu/include/rtw_version.h
index 6d2d52cbb3d3..4ca74a9465fe 100644
--- a/drivers/staging/r8188eu/include/rtw_version.h
+++ b/drivers/staging/r8188eu/include/rtw_version.h
@@ -1 +1,2 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 #define DRIVERVERSION	"v4.1.4_6773.20130222"
diff --git a/drivers/staging/r8188eu/include/rtw_xmit.h b/drivers/staging/r8188eu/include/rtw_xmit.h
index 5253dd0affd7..7155d3fa4bb5 100644
--- a/drivers/staging/r8188eu/include/rtw_xmit.h
+++ b/drivers/staging/r8188eu/include/rtw_xmit.h
@@ -1,22 +1,6 @@
-/******************************************************************************
- *
- * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
- *
- ******************************************************************************/
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/* Copyright(c) 2007 - 2011 Realtek Corporation. */
+
 #ifndef _RTW_XMIT_H_
 #define _RTW_XMIT_H_
 
diff --git a/drivers/staging/r8188eu/include/sta_info.h b/drivers/staging/r8188eu/include/sta_info.h
index 3e909db1d41a..97233f85c4bd 100644
--- a/drivers/staging/r8188eu/include/sta_info.h
+++ b/drivers/staging/r8188eu/include/sta_info.h
@@ -1,22 +1,6 @@
-/******************************************************************************
- *
- * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
- *
- ******************************************************************************/
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/* Copyright(c) 2007 - 2011 Realtek Corporation. */
+
 #ifndef __STA_INFO_H_
 #define __STA_INFO_H_
 
diff --git a/drivers/staging/r8188eu/include/usb_hal.h b/drivers/staging/r8188eu/include/usb_hal.h
index 8a65995d5e48..584602c40cca 100644
--- a/drivers/staging/r8188eu/include/usb_hal.h
+++ b/drivers/staging/r8188eu/include/usb_hal.h
@@ -1,22 +1,6 @@
-/******************************************************************************
- *
- * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
- *
- ******************************************************************************/
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/* Copyright(c) 2007 - 2011 Realtek Corporation. */
+
 #ifndef __USB_HAL_H__
 #define __USB_HAL_H__
 
diff --git a/drivers/staging/r8188eu/include/usb_ops.h b/drivers/staging/r8188eu/include/usb_ops.h
index 6562082beb7a..40e834390a10 100644
--- a/drivers/staging/r8188eu/include/usb_ops.h
+++ b/drivers/staging/r8188eu/include/usb_ops.h
@@ -1,22 +1,6 @@
-/******************************************************************************
- *
- * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
- *
- ******************************************************************************/
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/* Copyright(c) 2007 - 2011 Realtek Corporation. */
+
 #ifndef __USB_OPS_H_
 #define __USB_OPS_H_
 
diff --git a/drivers/staging/r8188eu/include/usb_ops_linux.h b/drivers/staging/r8188eu/include/usb_ops_linux.h
index e5b758a81a5c..c357a3b1560e 100644
--- a/drivers/staging/r8188eu/include/usb_ops_linux.h
+++ b/drivers/staging/r8188eu/include/usb_ops_linux.h
@@ -1,22 +1,6 @@
-/******************************************************************************
- *
- * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
- *
- ******************************************************************************/
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/* Copyright(c) 2007 - 2011 Realtek Corporation. */
+
 #ifndef __USB_OPS_LINUX_H__
 #define __USB_OPS_LINUX_H__
 
diff --git a/drivers/staging/r8188eu/include/usb_osintf.h b/drivers/staging/r8188eu/include/usb_osintf.h
index 9de99ca9799a..71f6273e69c5 100644
--- a/drivers/staging/r8188eu/include/usb_osintf.h
+++ b/drivers/staging/r8188eu/include/usb_osintf.h
@@ -1,22 +1,6 @@
-/******************************************************************************
- *
- * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
- *
- ******************************************************************************/
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/* Copyright(c) 2007 - 2011 Realtek Corporation. */
+
 #ifndef __USB_OSINTF_H
 #define __USB_OSINTF_H
 
diff --git a/drivers/staging/r8188eu/include/usb_vendor_req.h b/drivers/staging/r8188eu/include/usb_vendor_req.h
index 04f1b9e267e1..7337b1b7419f 100644
--- a/drivers/staging/r8188eu/include/usb_vendor_req.h
+++ b/drivers/staging/r8188eu/include/usb_vendor_req.h
@@ -1,22 +1,6 @@
-/******************************************************************************
- *
- * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
- *
- ******************************************************************************/
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/* Copyright(c) 2007 - 2011 Realtek Corporation. */
+
 #ifndef _USB_VENDOR_REQUEST_H_
 #define _USB_VENDOR_REQUEST_H_
 
diff --git a/drivers/staging/r8188eu/include/wifi.h b/drivers/staging/r8188eu/include/wifi.h
index 33a7e6c19d04..9760989ffc4c 100644
--- a/drivers/staging/r8188eu/include/wifi.h
+++ b/drivers/staging/r8188eu/include/wifi.h
@@ -1,22 +1,6 @@
-/******************************************************************************
- *
- * Copyright(c) 2007 - 2012 Realtek Corporation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
- *
- ******************************************************************************/
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/* Copyright(c) 2007 - 2012 Realtek Corporation. */
+
 #ifndef _WIFI_H_
 #define _WIFI_H_
 
diff --git a/drivers/staging/r8188eu/include/wlan_bssdef.h b/drivers/staging/r8188eu/include/wlan_bssdef.h
index eae8bac175b2..bada3e168c42 100644
--- a/drivers/staging/r8188eu/include/wlan_bssdef.h
+++ b/drivers/staging/r8188eu/include/wlan_bssdef.h
@@ -1,22 +1,6 @@
-/******************************************************************************
- *
- * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
- *
- ******************************************************************************/
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/* Copyright(c) 2007 - 2011 Realtek Corporation. */
+
 #ifndef __WLAN_BSSDEF_H__
 #define __WLAN_BSSDEF_H__
 
diff --git a/drivers/staging/r8188eu/include/xmit_osdep.h b/drivers/staging/r8188eu/include/xmit_osdep.h
index 2ff622ba24f0..4a6685d93582 100644
--- a/drivers/staging/r8188eu/include/xmit_osdep.h
+++ b/drivers/staging/r8188eu/include/xmit_osdep.h
@@ -1,22 +1,6 @@
-/******************************************************************************
- *
- * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
- *
- ******************************************************************************/
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/* Copyright(c) 2007 - 2011 Realtek Corporation. */
+
 #ifndef __XMIT_OSDEP_H_
 #define __XMIT_OSDEP_H_
 
-- 
2.32.0

