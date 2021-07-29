Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A72D3DA961
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 18:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232290AbhG2Qto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 12:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232171AbhG2Qte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 12:49:34 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91AADC06179F
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 09:49:23 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id z26so9224893oih.10
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 09:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BkKbLlTW54rOcB8hUmV0t+mcw1vDLvvekbWHEhMAiWU=;
        b=OYjTrm9L7FC5rCljWZB/Fq7mM6A2G9yUISW6Zh8AkyNbAMcODFob7zVJcAJELtiKbK
         nIBzEVamcVfyHvXl5PmvOMLpAnh9KYCkDw49dPsYMjuVsgwkLXCatdvBLkIHbh61bXGh
         6clChIRYI902lQLTjQaSwQ1Jv1Xkv3MhQWOm3nSXbu+F5p2uxoXXFev3x7a5G/d6uue9
         HewAWJCFvN3m0WT6pc/QaFsNpUMDeSOsU0Ev/sT2t13/GUiH/hkGF8nUgv4DBVw9tUof
         3kzJwR1x2hgFVnS/6zaQ79l2Wq7f78R3zfQi4YraBRgzmQtegbJNzm26P3fp+vOBjS8n
         ZM2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=BkKbLlTW54rOcB8hUmV0t+mcw1vDLvvekbWHEhMAiWU=;
        b=gmHsTOqlpHxi/DEIt2IZC2BflwKUTefIiNlL8BAH+TLExJKK4RHyTK8xqC8hU5/v25
         ZisuG+cBA6BcK74DaClDpFlAf+78mBf1clONx6hHz+27hAEKZD39uekcATQtl78os0cL
         1G0UZQqll8Kj556VUg4IPF/OJUV7+l8TcAivuCxSFAA8b9zWX322pA/4w++PrSt4d4aW
         SYGRa1P4yaYVuzlhz4v3O/Ec7CHKDWwgajW4uiAwl3mqS3VS7XCIv9npwatLwLClQtMg
         96NhRs5rfeFpBShiaQCrb7DVnqNA1blhIEoj5VEJhdBYTZktrdi3aII14X5lGP+Sh+Cq
         xSAg==
X-Gm-Message-State: AOAM532rpEHn0GB1sNWcvZfEHr5XYx9yLcR8rhn4yaw+7t4im2sQe7FD
        BpYR9R3A2GMsrjJYPQYbW8s=
X-Google-Smtp-Source: ABdhPJzF7BwKbon+57ikKthuSFbExsp9khzUQH1zSCSmFQhYhF52SAy6HfVbD+oBbmy8ahnKy2aqzA==
X-Received: by 2002:a05:6808:24d:: with SMTP id m13mr10831591oie.137.1627577362484;
        Thu, 29 Jul 2021 09:49:22 -0700 (PDT)
Received: from 2603-8090-2005-39b3-0000-0000-0000-100a.res6.spectrum.com.com (2603-8090-2005-39b3-0000-0000-0000-100a.res6.spectrum.com. [2603:8090:2005:39b3::100a])
        by smtp.gmail.com with ESMTPSA id n202sm694066oig.10.2021.07.29.09.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 09:49:22 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     gregkh@linuxfoundation.org
Cc:     phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH v2 6/6] staging: r8188eu: Convert copyright header info to SPDX format, part 6
Date:   Thu, 29 Jul 2021 11:48:14 -0500
Message-Id: <20210729164814.32097-7-Larry.Finger@lwfinger.net>
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
This patch converts the C source files in hal/.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
v2 - Added public mailing list
---
 drivers/staging/r8188eu/hal/Hal8188EPwrSeq.c  | 21 ++------------
 .../r8188eu/hal/Hal8188ERateAdaptive.c        |  5 ++--
 .../staging/r8188eu/hal/HalHWImg8188E_BB.c    | 21 ++------------
 .../staging/r8188eu/hal/HalHWImg8188E_MAC.c   | 21 ++------------
 .../staging/r8188eu/hal/HalHWImg8188E_RF.c    | 21 ++------------
 drivers/staging/r8188eu/hal/HalPhyRf.c        | 21 ++------------
 drivers/staging/r8188eu/hal/HalPhyRf_8188e.c  | 22 ++-------------
 drivers/staging/r8188eu/hal/HalPwrSeqCmd.c    | 23 ++-------------
 drivers/staging/r8188eu/hal/hal_com.c         | 22 ++-------------
 drivers/staging/r8188eu/hal/hal_intf.c        | 21 ++------------
 drivers/staging/r8188eu/hal/odm.c             | 21 ++------------
 drivers/staging/r8188eu/hal/odm_HWConfig.c    | 23 ++-------------
 drivers/staging/r8188eu/hal/odm_RTL8188E.c    | 21 ++------------
 .../staging/r8188eu/hal/odm_RegConfig8188E.c  | 21 ++------------
 drivers/staging/r8188eu/hal/odm_debug.c       | 23 ++-------------
 drivers/staging/r8188eu/hal/odm_interface.c   | 21 ++------------
 drivers/staging/r8188eu/hal/rtl8188e_cmd.c    | 22 ++-------------
 drivers/staging/r8188eu/hal/rtl8188e_dm.c     | 28 ++-----------------
 .../staging/r8188eu/hal/rtl8188e_hal_init.c   | 22 ++-------------
 drivers/staging/r8188eu/hal/rtl8188e_mp.c     | 22 ++-------------
 drivers/staging/r8188eu/hal/rtl8188e_phycfg.c | 22 ++-------------
 drivers/staging/r8188eu/hal/rtl8188e_rf6052.c | 22 ++-------------
 drivers/staging/r8188eu/hal/rtl8188e_rxdesc.c | 22 ++-------------
 drivers/staging/r8188eu/hal/rtl8188e_sreset.c | 22 ++-------------
 drivers/staging/r8188eu/hal/rtl8188e_xmit.c   | 22 ++-------------
 drivers/staging/r8188eu/hal/rtl8188eu_led.c   | 21 ++------------
 drivers/staging/r8188eu/hal/rtl8188eu_recv.c  | 22 ++-------------
 drivers/staging/r8188eu/hal/rtl8188eu_xmit.c  | 22 ++-------------
 drivers/staging/r8188eu/hal/usb_halinit.c     | 22 ++-------------
 drivers/staging/r8188eu/hal/usb_ops_linux.c   | 22 ++-------------
 30 files changed, 75 insertions(+), 566 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/Hal8188EPwrSeq.c b/drivers/staging/r8188eu/hal/Hal8188EPwrSeq.c
index fc23bf159345..7df715ab2f6e 100644
--- a/drivers/staging/r8188eu/hal/Hal8188EPwrSeq.c
+++ b/drivers/staging/r8188eu/hal/Hal8188EPwrSeq.c
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
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2007 - 2011 Realtek Corporation. */
 
 #include "Hal8188EPwrSeq.h"
 #include <rtl8188e_hal.h>
diff --git a/drivers/staging/r8188eu/hal/Hal8188ERateAdaptive.c b/drivers/staging/r8188eu/hal/Hal8188ERateAdaptive.c
index e9b12128b6b1..8db90778ab6c 100644
--- a/drivers/staging/r8188eu/hal/Hal8188ERateAdaptive.c
+++ b/drivers/staging/r8188eu/hal/Hal8188ERateAdaptive.c
@@ -1,6 +1,5 @@
-/*++
-Copyright (c) Realtek Semiconductor Corp. All rights reserved.
-
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) Realtek Semiconductor Corp.
 Module Name:
 	RateAdaptive.c
 
diff --git a/drivers/staging/r8188eu/hal/HalHWImg8188E_BB.c b/drivers/staging/r8188eu/hal/HalHWImg8188E_BB.c
index f06c14cd4e04..5eaf79ae6c93 100644
--- a/drivers/staging/r8188eu/hal/HalHWImg8188E_BB.c
+++ b/drivers/staging/r8188eu/hal/HalHWImg8188E_BB.c
@@ -1,22 +1,5 @@
-/******************************************************************************
-*
-* Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
-*
-* This program is free software; you can redistribute it and/or modify it
-* under the terms of version 2 of the GNU General Public License as
-* published by the Free Software Foundation.
-*
-* This program is distributed in the hope that it will be useful, but WITHOUT
-* ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
-* FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
-* more details.
-*
-* You should have received a copy of the GNU General Public License along with
-* this program; if not, write to the Free Software Foundation, Inc.,
-* 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
-*
-*
-******************************************************************************/
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2007 - 2011 Realtek Corporation. */
 
 #include "odm_precomp.h"
 
diff --git a/drivers/staging/r8188eu/hal/HalHWImg8188E_MAC.c b/drivers/staging/r8188eu/hal/HalHWImg8188E_MAC.c
index bac0238e314c..dc9ef87af99a 100644
--- a/drivers/staging/r8188eu/hal/HalHWImg8188E_MAC.c
+++ b/drivers/staging/r8188eu/hal/HalHWImg8188E_MAC.c
@@ -1,22 +1,5 @@
-/******************************************************************************
-*
-* Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
-*
-* This program is free software; you can redistribute it and/or modify it
-* under the terms of version 2 of the GNU General Public License as
-* published by the Free Software Foundation.
-*
-* This program is distributed in the hope that it will be useful, but WITHOUT
-* ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
-* FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
-* more details.
-*
-* You should have received a copy of the GNU General Public License along with
-* this program; if not, write to the Free Software Foundation, Inc.,
-* 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
-*
-*
-******************************************************************************/
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2007 - 2011 Realtek Corporation. */
 
 #include "odm_precomp.h"
 #include <rtw_iol.h>
diff --git a/drivers/staging/r8188eu/hal/HalHWImg8188E_RF.c b/drivers/staging/r8188eu/hal/HalHWImg8188E_RF.c
index b5d5050c0a17..b0df4eb8413d 100644
--- a/drivers/staging/r8188eu/hal/HalHWImg8188E_RF.c
+++ b/drivers/staging/r8188eu/hal/HalHWImg8188E_RF.c
@@ -1,22 +1,5 @@
-/******************************************************************************
-*
-* Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
-*
-* This program is free software; you can redistribute it and/or modify it
-* under the terms of version 2 of the GNU General Public License as
-* published by the Free Software Foundation.
-*
-* This program is distributed in the hope that it will be useful, but WITHOUT
-* ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
-* FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
-* more details.
-*
-* You should have received a copy of the GNU General Public License along with
-* this program; if not, write to the Free Software Foundation, Inc.,
-* 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
-*
-*
-******************************************************************************/
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2007 - 2011 Realtek Corporation. */
 
 #include "odm_precomp.h"
 
diff --git a/drivers/staging/r8188eu/hal/HalPhyRf.c b/drivers/staging/r8188eu/hal/HalPhyRf.c
index 980f7da8ab3b..257940202f13 100644
--- a/drivers/staging/r8188eu/hal/HalPhyRf.c
+++ b/drivers/staging/r8188eu/hal/HalPhyRf.c
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
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2007 - 2011 Realtek Corporation. */
 
  #include "odm_precomp.h"
 
diff --git a/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c b/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
index 8a7947d8de7f..af32210bf359 100644
--- a/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
+++ b/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
@@ -1,23 +1,5 @@
-
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
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2007 - 2011 Realtek Corporation. */
 
 #include "odm_precomp.h"
 
diff --git a/drivers/staging/r8188eu/hal/HalPwrSeqCmd.c b/drivers/staging/r8188eu/hal/HalPwrSeqCmd.c
index 5700dbce5b8c..77bb61ab9789 100644
--- a/drivers/staging/r8188eu/hal/HalPwrSeqCmd.c
+++ b/drivers/staging/r8188eu/hal/HalPwrSeqCmd.c
@@ -1,24 +1,7 @@
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
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2007 - 2011 Realtek Corporation. */
+
 /*++
-Copyright (c) Realtek Semiconductor Corp. All rights reserved.
 
 Module Name:
 	HalPwrSeqCmd.c
diff --git a/drivers/staging/r8188eu/hal/hal_com.c b/drivers/staging/r8188eu/hal/hal_com.c
index 60ff30f1c3ac..9094aba21379 100644
--- a/drivers/staging/r8188eu/hal/hal_com.c
+++ b/drivers/staging/r8188eu/hal/hal_com.c
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
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2007 - 2011 Realtek Corporation. */
+
 #include <osdep_service.h>
 #include <drv_types.h>
 
diff --git a/drivers/staging/r8188eu/hal/hal_intf.c b/drivers/staging/r8188eu/hal/hal_intf.c
index ce37c7594f2d..4dda247e386a 100644
--- a/drivers/staging/r8188eu/hal/hal_intf.c
+++ b/drivers/staging/r8188eu/hal/hal_intf.c
@@ -1,22 +1,5 @@
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
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2007 - 2012 Realtek Corporation. */
 
 #define _HAL_INTF_C_
 #include <osdep_service.h>
diff --git a/drivers/staging/r8188eu/hal/odm.c b/drivers/staging/r8188eu/hal/odm.c
index 8b8754c42bc1..81fe727115d9 100644
--- a/drivers/staging/r8188eu/hal/odm.c
+++ b/drivers/staging/r8188eu/hal/odm.c
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
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2007 - 2011 Realtek Corporation. */
 
 /*  include files */
 
diff --git a/drivers/staging/r8188eu/hal/odm_HWConfig.c b/drivers/staging/r8188eu/hal/odm_HWConfig.c
index 523801cabb43..4c9317833fbc 100644
--- a/drivers/staging/r8188eu/hal/odm_HWConfig.c
+++ b/drivers/staging/r8188eu/hal/odm_HWConfig.c
@@ -1,24 +1,5 @@
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
-
-/*  include files */
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2007 - 2011 Realtek Corporation. */
 
 #include "odm_precomp.h"
 
diff --git a/drivers/staging/r8188eu/hal/odm_RTL8188E.c b/drivers/staging/r8188eu/hal/odm_RTL8188E.c
index 858fc39de6aa..17dca886b17c 100644
--- a/drivers/staging/r8188eu/hal/odm_RTL8188E.c
+++ b/drivers/staging/r8188eu/hal/odm_RTL8188E.c
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
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2007 - 2011 Realtek Corporation. */
 
 #include "odm_precomp.h"
 
diff --git a/drivers/staging/r8188eu/hal/odm_RegConfig8188E.c b/drivers/staging/r8188eu/hal/odm_RegConfig8188E.c
index 0ff31370fb98..132f5cbd0697 100644
--- a/drivers/staging/r8188eu/hal/odm_RegConfig8188E.c
+++ b/drivers/staging/r8188eu/hal/odm_RegConfig8188E.c
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
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2007 - 2011 Realtek Corporation. */
 
 #include "odm_precomp.h"
 
diff --git a/drivers/staging/r8188eu/hal/odm_debug.c b/drivers/staging/r8188eu/hal/odm_debug.c
index 84caadd6c8e5..a969ba48ddb9 100644
--- a/drivers/staging/r8188eu/hal/odm_debug.c
+++ b/drivers/staging/r8188eu/hal/odm_debug.c
@@ -1,24 +1,5 @@
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
-
-/*  include files */
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2007 - 2011 Realtek Corporation. */
 
 #include "odm_precomp.h"
 
diff --git a/drivers/staging/r8188eu/hal/odm_interface.c b/drivers/staging/r8188eu/hal/odm_interface.c
index 3be5a5f8d873..8875a9954981 100644
--- a/drivers/staging/r8188eu/hal/odm_interface.c
+++ b/drivers/staging/r8188eu/hal/odm_interface.c
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
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2007 - 2011 Realtek Corporation. */
 
 #include "odm_precomp.h"
 /*  ODM IO Relative API. */
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_cmd.c b/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
index d60db45a6f0b..dc4d790837ce 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
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
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2007 - 2011 Realtek Corporation. */
+
 #define _RTL8188E_CMD_C_
 
 #include <osdep_service.h>
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_dm.c b/drivers/staging/r8188eu/hal/rtl8188e_dm.c
index 2590277b95ba..88ae9c5a8507 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_dm.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_dm.c
@@ -1,29 +1,7 @@
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
-/*  */
-/*  Description: */
-/*  */
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2007 - 2011 Realtek Corporation. */
+
 /*  This file is for 92CE/92CU dynamic mechanism only */
-/*  */
-/*  */
-/*  */
 #define _RTL8188E_DM_C_
 
 #include <osdep_service.h>
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index d9f115d187c9..af7977165c3c 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
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
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2007 - 2011 Realtek Corporation. */
+
 #define _HAL_INIT_C_
 
 #include <linux/firmware.h>
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_mp.c b/drivers/staging/r8188eu/hal/rtl8188e_mp.c
index 66388902ab94..3937c1f5d588 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_mp.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_mp.c
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
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2007 - 2011 Realtek Corporation. */
+
 #define _RTL8188E_MP_C_
 
 #include <drv_types.h>
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
index 36ad9dbbd8b0..f23e69ebee35 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
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
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2007 - 2011 Realtek Corporation. */
+
 #define _RTL8188E_PHYCFG_C_
 
 #include <osdep_service.h>
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c b/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c
index 0ed6ff67ad57..0bba0130cfa6 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c
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
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2007 - 2011 Realtek Corporation. */
+
 /******************************************************************************
  *
  *
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_rxdesc.c b/drivers/staging/r8188eu/hal/rtl8188e_rxdesc.c
index a07ad95ad84b..9ce6527cb75a 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_rxdesc.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_rxdesc.c
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
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2007 - 2011 Realtek Corporation. */
+
 #define _RTL8188E_REDESC_C_
 
 #include <osdep_service.h>
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_sreset.c b/drivers/staging/r8188eu/hal/rtl8188e_sreset.c
index 047b53482e67..88bc607b3698 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_sreset.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_sreset.c
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
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2007 - 2011 Realtek Corporation. */
+
 #define _RTL8188E_SRESET_C_
 
 #include <rtl8188e_sreset.h>
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_xmit.c b/drivers/staging/r8188eu/hal/rtl8188e_xmit.c
index 7ecbcf731ea9..fe32ba366338 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_xmit.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_xmit.c
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
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2007 - 2011 Realtek Corporation. */
+
 #define _RTL8188E_XMIT_C_
 
 #include <osdep_service.h>
diff --git a/drivers/staging/r8188eu/hal/rtl8188eu_led.c b/drivers/staging/r8188eu/hal/rtl8188eu_led.c
index 08dfd94163e6..29aee1345577 100644
--- a/drivers/staging/r8188eu/hal/rtl8188eu_led.c
+++ b/drivers/staging/r8188eu/hal/rtl8188eu_led.c
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
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2007 - 2011 Realtek Corporation. */
 
 #include <osdep_service.h>
 #include <drv_types.h>
diff --git a/drivers/staging/r8188eu/hal/rtl8188eu_recv.c b/drivers/staging/r8188eu/hal/rtl8188eu_recv.c
index ab0853ceeb61..7ca1a101e100 100644
--- a/drivers/staging/r8188eu/hal/rtl8188eu_recv.c
+++ b/drivers/staging/r8188eu/hal/rtl8188eu_recv.c
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
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2007 - 2011 Realtek Corporation. */
+
 #define _RTL8188EU_RECV_C_
 #include <osdep_service.h>
 #include <drv_types.h>
diff --git a/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c b/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c
index 7f5d677b1d6f..ca543bdc119d 100644
--- a/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c
+++ b/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c
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
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2007 - 2011 Realtek Corporation. */
+
 #define _RTL8188E_XMIT_C_
 #include <osdep_service.h>
 #include <drv_types.h>
diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 144cc5f6787d..8ecb94728462 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
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
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2007 - 2011 Realtek Corporation. */
+
 #define _HCI_HAL_INIT_C_
 
 #include <osdep_service.h>
diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
index d31f0be4c8a6..dd6138dfebb6 100644
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
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
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2007 - 2011 Realtek Corporation. */
+
 #define _HCI_OPS_OS_C_
 
 #include <osdep_service.h>
-- 
2.32.0

