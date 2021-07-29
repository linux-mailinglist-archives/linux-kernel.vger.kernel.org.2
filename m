Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45BA93DA957
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 18:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbhG2QtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 12:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbhG2QtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 12:49:05 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A1BC0613D5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 09:49:01 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id o2-20020a9d22020000b0290462f0ab0800so6484495ota.11
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 09:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JnKJ2XfGe3QxG1IAUIS9aqRbS0aNS+rSnmtcTIQc7o0=;
        b=fLf4F5IaPsXWpXUpf+5jzd2uZ1d9DwduNnR/XvxjUml2nU8ohD3/yrALKBPqFMCpYH
         5J/RwZpKuQUaYmaygbn4MODD26hwXAAhFEfABx3XOZIRnabtNYY3mJn+SxCZ2gQSqKlD
         SeEb61mcUhTimpGnORIG/GIIoPkzX+PEy36lKmomlSCy5AQ2I0dvhP+lpaiY1Q+O8v+/
         3i+hB+9tQtc/74JfJ1UKdxoC9T7rv38IPmPcAOfbSEJLJG7iwqyvJTB69HLtBmpHx/Py
         5+z2vj172vuCAHWJFJk0R3i4GiAwNGxRm5A0eMlJAQ9FZoHB5UhiM1U0shG/Ep/V+EaI
         +qdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=JnKJ2XfGe3QxG1IAUIS9aqRbS0aNS+rSnmtcTIQc7o0=;
        b=CqToD4dwNS2B7MkWfMVfQ/u1018RNreKeD5iakyET6s1lvtWaU9VrEqpb4bKUzxKJD
         u+hlVUWspEvsfteYJDN8IRGPoQmgm261jUd5OGdVC43kFVao6qb68JJE8x4ueRFvNoEf
         5zquTJVzJP6LC0cK51MN8Y5glo4rai6i0zL3aRHFbVkTFvaIXbvsOT9bfEwc/hSG+am3
         cNSkptbOGUGv9LYK382JYCecKg3muMZWu+TjuUyJMu/3wF0Br0M+oOhgmj2I4nUI9V1v
         iu9M5o/Ik5PxN5VseeKOix8N2FmDGLt3SMkleSj15IAKomDvXidAJ/LIRCwVF5TElYD1
         Vv2w==
X-Gm-Message-State: AOAM532srKomDIHXuTlPiopAUXCWhDzkw9JO57ew7l9QOiXE1Y35KHp0
        gSaINbGhibQY40IymAevub0=
X-Google-Smtp-Source: ABdhPJyrq3np3AGBDQnPWYAep4cUgu6eZRojPMuUb540gX5vzoSB+4MnM33qIIn/fmlNzF3f99e3uA==
X-Received: by 2002:a05:6830:25ce:: with SMTP id d14mr4179308otu.87.1627577340430;
        Thu, 29 Jul 2021 09:49:00 -0700 (PDT)
Received: from 2603-8090-2005-39b3-0000-0000-0000-100a.res6.spectrum.com.com (2603-8090-2005-39b3-0000-0000-0000-100a.res6.spectrum.com. [2603:8090:2005:39b3::100a])
        by smtp.gmail.com with ESMTPSA id n202sm694066oig.10.2021.07.29.09.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 09:48:59 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     gregkh@linuxfoundation.org
Cc:     phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH v2 1/6] staging: r8188eu: Convert header copyright info to SPDX format, part 1
Date:   Thu, 29 Jul 2021 11:48:09 -0500
Message-Id: <20210729164814.32097-2-Larry.Finger@lwfinger.net>
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
This patch converts the first 20 files.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
v2 - added public list
---
.../staging/r8188eu/include/Hal8188EPhyCfg.h  | 22 ++-----------
 .../staging/r8188eu/include/Hal8188EPhyReg.h  | 22 ++-----------
 .../staging/r8188eu/include/Hal8188EPwrSeq.h  | 22 ++-----------
 .../r8188eu/include/Hal8188ERateAdaptive.h    |  4 ++-
 drivers/staging/r8188eu/include/Hal8188EReg.h | 31 ++-----------------
 .../r8188eu/include/HalHWImg8188E_BB.h        | 21 ++-----------
 .../r8188eu/include/HalHWImg8188E_FW.h        | 21 ++-----------
 .../r8188eu/include/HalHWImg8188E_MAC.h       | 21 ++-----------
 .../r8188eu/include/HalHWImg8188E_RF.h        | 21 ++-----------
 drivers/staging/r8188eu/include/HalPhyRf.h    | 25 +++------------
 .../staging/r8188eu/include/HalPhyRf_8188e.h  | 21 ++-----------
 drivers/staging/r8188eu/include/autoconf.h    | 21 ++-----------
 drivers/staging/r8188eu/include/basic_types.h | 22 ++-----------
 drivers/staging/r8188eu/include/cmd_osdep.h   | 22 ++-----------
 drivers/staging/r8188eu/include/drv_types.h   | 22 ++-----------
 .../staging/r8188eu/include/drv_types_linux.h | 22 ++-----------
 drivers/staging/r8188eu/include/ethernet.h    | 23 ++------------
 drivers/staging/r8188eu/include/h2clbk.h      | 21 ++-----------
 drivers/staging/r8188eu/include/hal_com.h     | 22 ++-----------
 drivers/staging/r8188eu/include/hal_intf.h    | 22 ++-----------
 20 files changed, 53 insertions(+), 375 deletions(-)

diff --git a/drivers/staging/r8188eu/include/Hal8188EPhyCfg.h b/drivers/staging/r8188eu/include/Hal8188EPhyCfg.h
index 6fb059576a67..63b068fa9f4d 100644
--- a/drivers/staging/r8188eu/include/Hal8188EPhyCfg.h
+++ b/drivers/staging/r8188eu/include/Hal8188EPhyCfg.h
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
 #ifndef __INC_HAL8188EPHYCFG_H__
 #define __INC_HAL8188EPHYCFG_H__
 
diff --git a/drivers/staging/r8188eu/include/Hal8188EPhyReg.h b/drivers/staging/r8188eu/include/Hal8188EPhyReg.h
index c324970171cd..8b8c75a1f149 100644
--- a/drivers/staging/r8188eu/include/Hal8188EPhyReg.h
+++ b/drivers/staging/r8188eu/include/Hal8188EPhyReg.h
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
 #ifndef __INC_HAL8188EPHYREG_H__
 #define __INC_HAL8188EPHYREG_H__
 /*--------------------------Define Parameters-------------------------------*/
diff --git a/drivers/staging/r8188eu/include/Hal8188EPwrSeq.h b/drivers/staging/r8188eu/include/Hal8188EPwrSeq.h
index df151b76f302..43f41e77a939 100644
--- a/drivers/staging/r8188eu/include/Hal8188EPwrSeq.h
+++ b/drivers/staging/r8188eu/include/Hal8188EPwrSeq.h
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
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/* Copyright(c) 2007 - 2011 Realtek Corporation. */
 
 #ifndef __HAL8188EPWRSEQ_H__
 #define __HAL8188EPWRSEQ_H__
diff --git a/drivers/staging/r8188eu/include/Hal8188ERateAdaptive.h b/drivers/staging/r8188eu/include/Hal8188ERateAdaptive.h
index 21996a1173ef..ce4c96d4b84a 100644
--- a/drivers/staging/r8188eu/include/Hal8188ERateAdaptive.h
+++ b/drivers/staging/r8188eu/include/Hal8188ERateAdaptive.h
@@ -1,7 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/* Copyright (c) 2011 Realtek Semiconductor Corp. */
+
 #ifndef __INC_RA_H
 #define __INC_RA_H
 /*++
-Copyright (c) Realtek Semiconductor Corp. All rights reserved.
 
 Module Name:
 	RateAdaptive.h
diff --git a/drivers/staging/r8188eu/include/Hal8188EReg.h b/drivers/staging/r8188eu/include/Hal8188EReg.h
index 06818ac6c330..e04fae68fa4b 100644
--- a/drivers/staging/r8188eu/include/Hal8188EReg.h
+++ b/drivers/staging/r8188eu/include/Hal8188EReg.h
@@ -1,31 +1,6 @@
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
-/*  File Name: Hal8188EReg.h */
-/*  */
-/*  Description: */
-/*  */
-/*  This file is for RTL8188E register definition. */
-/*  */
-/*  */
-/*  */
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/* Copyright(c) 2007 - 2011 Realtek Corporation. */
+
 #ifndef	__HAL_8188E_REG_H__
 #define __HAL_8188E_REG_H__
 
diff --git a/drivers/staging/r8188eu/include/HalHWImg8188E_BB.h b/drivers/staging/r8188eu/include/HalHWImg8188E_BB.h
index e57452104bfb..8270fdbc2844 100644
--- a/drivers/staging/r8188eu/include/HalHWImg8188E_BB.h
+++ b/drivers/staging/r8188eu/include/HalHWImg8188E_BB.h
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
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/* Copyright(c) 2007 - 2011 Realtek Corporation. */
 
 #ifndef __INC_BB_8188E_HW_IMG_H
 #define __INC_BB_8188E_HW_IMG_H
diff --git a/drivers/staging/r8188eu/include/HalHWImg8188E_FW.h b/drivers/staging/r8188eu/include/HalHWImg8188E_FW.h
index ce81fea401a1..5ddcd283097b 100644
--- a/drivers/staging/r8188eu/include/HalHWImg8188E_FW.h
+++ b/drivers/staging/r8188eu/include/HalHWImg8188E_FW.h
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
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/* Copyright(c) 2007 - 2011 Realtek Corporation. */
 
 #ifndef __INC_FW_8188E_HW_IMG_H
 #define __INC_FW_8188E_HW_IMG_H
diff --git a/drivers/staging/r8188eu/include/HalHWImg8188E_MAC.h b/drivers/staging/r8188eu/include/HalHWImg8188E_MAC.h
index acf78b94fddb..391c1754b0b6 100644
--- a/drivers/staging/r8188eu/include/HalHWImg8188E_MAC.h
+++ b/drivers/staging/r8188eu/include/HalHWImg8188E_MAC.h
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
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/* Copyright(c) 2007 - 2011 Realtek Corporation. */
 
 #ifndef __INC_MAC_8188E_HW_IMG_H
 #define __INC_MAC_8188E_HW_IMG_H
diff --git a/drivers/staging/r8188eu/include/HalHWImg8188E_RF.h b/drivers/staging/r8188eu/include/HalHWImg8188E_RF.h
index 8ecb40d26c70..0c67c3df20b9 100644
--- a/drivers/staging/r8188eu/include/HalHWImg8188E_RF.h
+++ b/drivers/staging/r8188eu/include/HalHWImg8188E_RF.h
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
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/* Copyright(c) 2007 - 2011 Realtek Corporation. */
 
 #ifndef __INC_RF_8188E_HW_IMG_H
 #define __INC_RF_8188E_HW_IMG_H
diff --git a/drivers/staging/r8188eu/include/HalPhyRf.h b/drivers/staging/r8188eu/include/HalPhyRf.h
index 1ec497100da1..ba3b6133fc13 100644
--- a/drivers/staging/r8188eu/include/HalPhyRf.h
+++ b/drivers/staging/r8188eu/include/HalPhyRf.h
@@ -1,25 +1,8 @@
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
 
- #ifndef __HAL_PHY_RF_H__
- #define __HAL_PHY_RF_H__
+#ifndef __HAL_PHY_RF_H__
+#define __HAL_PHY_RF_H__
 
 #define ODM_TARGET_CHNL_NUM_2G_5G	59
 
diff --git a/drivers/staging/r8188eu/include/HalPhyRf_8188e.h b/drivers/staging/r8188eu/include/HalPhyRf_8188e.h
index 807c301a86e4..d4a27662309f 100644
--- a/drivers/staging/r8188eu/include/HalPhyRf_8188e.h
+++ b/drivers/staging/r8188eu/include/HalPhyRf_8188e.h
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
 
 #ifndef __HAL_PHY_RF_8188E_H__
 #define __HAL_PHY_RF_8188E_H__
diff --git a/drivers/staging/r8188eu/include/autoconf.h b/drivers/staging/r8188eu/include/autoconf.h
index cfa790794fd3..fcbfc60fad5a 100644
--- a/drivers/staging/r8188eu/include/autoconf.h
+++ b/drivers/staging/r8188eu/include/autoconf.h
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
+/* Copyright(c) 2007 - 2011 Realtek Corporation.*/
 
 /*  temporarily flag ******* */
 /*
diff --git a/drivers/staging/r8188eu/include/basic_types.h b/drivers/staging/r8188eu/include/basic_types.h
index 8a7ca992674a..9c34e2dad6bb 100644
--- a/drivers/staging/r8188eu/include/basic_types.h
+++ b/drivers/staging/r8188eu/include/basic_types.h
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
 #ifndef __BASIC_TYPES_H__
 #define __BASIC_TYPES_H__
 
diff --git a/drivers/staging/r8188eu/include/cmd_osdep.h b/drivers/staging/r8188eu/include/cmd_osdep.h
index 5a8465e147b3..75ba595f2301 100644
--- a/drivers/staging/r8188eu/include/cmd_osdep.h
+++ b/drivers/staging/r8188eu/include/cmd_osdep.h
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
 #ifndef __CMD_OSDEP_H_
 #define __CMD_OSDEP_H_
 
diff --git a/drivers/staging/r8188eu/include/drv_types.h b/drivers/staging/r8188eu/include/drv_types.h
index 9aa72a91d467..dce4c602ffe6 100644
--- a/drivers/staging/r8188eu/include/drv_types.h
+++ b/drivers/staging/r8188eu/include/drv_types.h
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
 /*-----------------------------------------------------------------------------
 
 	For type defines and data structure defines
diff --git a/drivers/staging/r8188eu/include/drv_types_linux.h b/drivers/staging/r8188eu/include/drv_types_linux.h
index f5db1dd14317..068a7bcee82f 100644
--- a/drivers/staging/r8188eu/include/drv_types_linux.h
+++ b/drivers/staging/r8188eu/include/drv_types_linux.h
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
 #ifndef __DRV_TYPES_LINUX_H__
 #define __DRV_TYPES_LINUX_H__
 
diff --git a/drivers/staging/r8188eu/include/ethernet.h b/drivers/staging/r8188eu/include/ethernet.h
index 5b17dcf143a4..898eb296013c 100644
--- a/drivers/staging/r8188eu/include/ethernet.h
+++ b/drivers/staging/r8188eu/include/ethernet.h
@@ -1,23 +1,6 @@
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
-/*! \file */
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/* Copyright(c) 2007 - 2011 Realtek Corporation. */
+
 #ifndef __INC_ETHERNET_H
 #define __INC_ETHERNET_H
 
diff --git a/drivers/staging/r8188eu/include/h2clbk.h b/drivers/staging/r8188eu/include/h2clbk.h
index 72b67827bc6e..412b611760b3 100644
--- a/drivers/staging/r8188eu/include/h2clbk.h
+++ b/drivers/staging/r8188eu/include/h2clbk.h
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
 
 #define _H2CLBK_H_
 
diff --git a/drivers/staging/r8188eu/include/hal_com.h b/drivers/staging/r8188eu/include/hal_com.h
index 652f645d54ff..95167f0b327f 100644
--- a/drivers/staging/r8188eu/include/hal_com.h
+++ b/drivers/staging/r8188eu/include/hal_com.h
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
 #ifndef __HAL_COMMON_H__
 #define __HAL_COMMON_H__
 
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index 49539b862863..c829aee518dd 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
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
 #ifndef __HAL_INTF_H__
 #define __HAL_INTF_H__
 
-- 
2.32.0

