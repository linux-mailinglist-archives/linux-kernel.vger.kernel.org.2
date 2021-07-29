Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAB6B3DA95C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 18:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232300AbhG2Qt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 12:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbhG2QtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 12:49:11 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D93C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 09:49:06 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id c2-20020a0568303482b029048bcf4c6bd9so6491328otu.8
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 09:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WrlcB3+4WNFz3Xjbx3Wxc+H0S41qUiMFy7lW1c6UWUE=;
        b=NjigzbSfrwJB+xc6oHONviMAWzce+hxApQGjnf5ugLAVmH4UaeC5DYrti9cYwiTn6H
         YAh1+kS9DtUAFNoFE2rLHNuUrmTgs7SfSquZ3GeFqz+kOwhpqgP2MatU4ZebLsJUNv3J
         VKthz43Xag8DW8ZGUz5Iflq2iMhMZ/uUi07Lbrx1w94GvzlQCbCf1oyP9ejygThEGykc
         bK+mnQkOV5SFz1E+Xm8zfgaz/mCsdccoiPbI8PDcnstcdOCpkYondtQOxQJzGH+bNcsb
         0f76Ska8Dejg376dbvvvsNDAu8vR4mGvOic7/D8y0GKaCGrr3CmrmZh1WbJ2mCwpXN+e
         h1gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=WrlcB3+4WNFz3Xjbx3Wxc+H0S41qUiMFy7lW1c6UWUE=;
        b=J3VWc8i172EGdbOxwi6BTcaYnCD7oGQmy6opdYKwBmp0FgbdF3zLQ5kup2aaPgbZ74
         I4eFrPaF6PuIYQt9/Vk+ynuOprTsk480aFw+CEc9xwM5O515KEi17IUGjXxuh4UnDIpN
         iPv9P5241BdxkSZuanMrES12jAmd3O3TjXrZpjHNzBxgUv6Nlg5fk1aR1h2rtyb8KVAC
         QwpYiFTcQmONALq8IuRLYMK/ijdhpsw15mQYvhJeQVnRmj5KnlQQUoB0whgTchrOgQKF
         8JDqq0MMDiaJ7i5nWNt9g4pSpjGjTVAkGcUx/Coalco6hixdUxDuehbSAXxo3elNBPfe
         u5bg==
X-Gm-Message-State: AOAM532VJMV9hi4Dli9PDvMm1z3O5HAFQTHibI6e4lx3Bh63R9kacwoQ
        zo47CVTJmR4H0c5Efnj15uU=
X-Google-Smtp-Source: ABdhPJwNoXTNF3htP/3Pi5OYoX/B2H2wyqAu6RRXyCQOcwOw6527M/2gcswLwHWO+D/sATuUcJLzSw==
X-Received: by 2002:a9d:7f94:: with SMTP id t20mr3978256otp.44.1627577345853;
        Thu, 29 Jul 2021 09:49:05 -0700 (PDT)
Received: from 2603-8090-2005-39b3-0000-0000-0000-100a.res6.spectrum.com.com (2603-8090-2005-39b3-0000-0000-0000-100a.res6.spectrum.com. [2603:8090:2005:39b3::100a])
        by smtp.gmail.com with ESMTPSA id n202sm694066oig.10.2021.07.29.09.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 09:49:05 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     gregkh@linuxfoundation.org
Cc:     phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH v2 2/6] staging: r8188eu: Convert header copyright info to SPDX format, part 2
Date:   Thu, 29 Jul 2021 11:48:10 -0500
Message-Id: <20210729164814.32097-3-Larry.Finger@lwfinger.net>
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
This patch converts the next 23 files.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
v2 - Added public mailing list
---
 .../staging/r8188eu/include/HalPwrSeqCmd.h    | 22 ++-----------
 drivers/staging/r8188eu/include/HalVerDef.h   | 21 ++----------
 drivers/staging/r8188eu/include/ieee80211.h   | 22 ++-----------
 .../staging/r8188eu/include/ieee80211_ext.h   | 22 ++-----------
 drivers/staging/r8188eu/include/if_ether.h    | 21 ++----------
 .../staging/r8188eu/include/ioctl_cfg80211.h  | 22 ++-----------
 drivers/staging/r8188eu/include/ip.h          | 22 ++-----------
 drivers/staging/r8188eu/include/mlme_osdep.h  | 22 ++-----------
 .../staging/r8188eu/include/mp_custom_oid.h   | 22 ++-----------
 drivers/staging/r8188eu/include/nic_spec.h    | 21 ++----------
 drivers/staging/r8188eu/include/odm.h         | 21 ++----------
 .../staging/r8188eu/include/odm_HWConfig.h    | 21 ++----------
 .../staging/r8188eu/include/odm_RTL8188E.h    | 22 ++-----------
 .../r8188eu/include/odm_RegConfig8188E.h      | 22 ++-----------
 .../r8188eu/include/odm_RegDefine11AC.h       | 21 ++----------
 .../r8188eu/include/odm_RegDefine11N.h        | 21 ++----------
 drivers/staging/r8188eu/include/odm_debug.h   | 21 ++----------
 .../staging/r8188eu/include/odm_interface.h   | 21 ++----------
 drivers/staging/r8188eu/include/odm_precomp.h | 21 ++----------
 drivers/staging/r8188eu/include/odm_reg.h     | 33 ++-----------------
 drivers/staging/r8188eu/include/odm_types.h   | 22 ++-----------
 drivers/staging/r8188eu/include/osdep_intf.h  | 21 ++----------
 .../staging/r8188eu/include/osdep_service.h   | 22 ++-----------
 23 files changed, 58 insertions(+), 448 deletions(-)

diff --git a/drivers/staging/r8188eu/include/HalPwrSeqCmd.h b/drivers/staging/r8188eu/include/HalPwrSeqCmd.h
index c591e9d1c23b..3b8e263ea6e1 100644
--- a/drivers/staging/r8188eu/include/HalPwrSeqCmd.h
+++ b/drivers/staging/r8188eu/include/HalPwrSeqCmd.h
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
 #ifndef __HALPWRSEQCMD_H__
 #define __HALPWRSEQCMD_H__
 
diff --git a/drivers/staging/r8188eu/include/HalVerDef.h b/drivers/staging/r8188eu/include/HalVerDef.h
index 2a7dc28b8de7..a0f5bf52e75a 100644
--- a/drivers/staging/r8188eu/include/HalVerDef.h
+++ b/drivers/staging/r8188eu/include/HalVerDef.h
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
 #ifndef __HAL_VERSION_DEF_H__
 #define __HAL_VERSION_DEF_H__
 
diff --git a/drivers/staging/r8188eu/include/ieee80211.h b/drivers/staging/r8188eu/include/ieee80211.h
index 0e6beaebeb0f..bc9a875cdf35 100644
--- a/drivers/staging/r8188eu/include/ieee80211.h
+++ b/drivers/staging/r8188eu/include/ieee80211.h
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
 #ifndef __IEEE80211_H
 #define __IEEE80211_H
 
diff --git a/drivers/staging/r8188eu/include/ieee80211_ext.h b/drivers/staging/r8188eu/include/ieee80211_ext.h
index fa9e52572fe9..cc53c71d2d8b 100644
--- a/drivers/staging/r8188eu/include/ieee80211_ext.h
+++ b/drivers/staging/r8188eu/include/ieee80211_ext.h
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
 #ifndef __IEEE80211_EXT_H
 #define __IEEE80211_EXT_H
 
diff --git a/drivers/staging/r8188eu/include/if_ether.h b/drivers/staging/r8188eu/include/if_ether.h
index db157712a203..5bb79fddeec6 100644
--- a/drivers/staging/r8188eu/include/if_ether.h
+++ b/drivers/staging/r8188eu/include/if_ether.h
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
 
 #ifndef _LINUX_IF_ETHER_H
 #define _LINUX_IF_ETHER_H
diff --git a/drivers/staging/r8188eu/include/ioctl_cfg80211.h b/drivers/staging/r8188eu/include/ioctl_cfg80211.h
index 037e9a5e5af9..e22481050ef8 100644
--- a/drivers/staging/r8188eu/include/ioctl_cfg80211.h
+++ b/drivers/staging/r8188eu/include/ioctl_cfg80211.h
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
+/* Copyright(c) 2007 - 2011 Realtek Corporation. i*/
+
 #ifndef __IOCTL_CFG80211_H__
 #define __IOCTL_CFG80211_H__
 
diff --git a/drivers/staging/r8188eu/include/ip.h b/drivers/staging/r8188eu/include/ip.h
index 0107ac15c6ed..b7388c8c1b8a 100644
--- a/drivers/staging/r8188eu/include/ip.h
+++ b/drivers/staging/r8188eu/include/ip.h
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
 #ifndef _LINUX_IP_H
 #define _LINUX_IP_H
 
diff --git a/drivers/staging/r8188eu/include/mlme_osdep.h b/drivers/staging/r8188eu/include/mlme_osdep.h
index ae1722c67032..096232b0f95b 100644
--- a/drivers/staging/r8188eu/include/mlme_osdep.h
+++ b/drivers/staging/r8188eu/include/mlme_osdep.h
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
 #ifndef	__MLME_OSDEP_H_
 #define __MLME_OSDEP_H_
 
diff --git a/drivers/staging/r8188eu/include/mp_custom_oid.h b/drivers/staging/r8188eu/include/mp_custom_oid.h
index be4f11864f63..7bcb857c795d 100644
--- a/drivers/staging/r8188eu/include/mp_custom_oid.h
+++ b/drivers/staging/r8188eu/include/mp_custom_oid.h
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
 #ifndef	__CUSTOM_OID_H
 #define __CUSTOM_OID_H
 
diff --git a/drivers/staging/r8188eu/include/nic_spec.h b/drivers/staging/r8188eu/include/nic_spec.h
index cee6f06a4570..77e865398fd1 100644
--- a/drivers/staging/r8188eu/include/nic_spec.h
+++ b/drivers/staging/r8188eu/include/nic_spec.h
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
 
 #ifndef __NIC_SPEC_H__
 #define __NIC_SPEC_H__
diff --git a/drivers/staging/r8188eu/include/odm.h b/drivers/staging/r8188eu/include/odm.h
index 61836c32123f..9bbc3578b459 100644
--- a/drivers/staging/r8188eu/include/odm.h
+++ b/drivers/staging/r8188eu/include/odm.h
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
 
 #ifndef	__HALDMOUTSRC_H__
 #define __HALDMOUTSRC_H__
diff --git a/drivers/staging/r8188eu/include/odm_HWConfig.h b/drivers/staging/r8188eu/include/odm_HWConfig.h
index 80f549f196e2..9b2ab3bcf992 100644
--- a/drivers/staging/r8188eu/include/odm_HWConfig.h
+++ b/drivers/staging/r8188eu/include/odm_HWConfig.h
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
 
 #ifndef	__HALHWOUTSRC_H__
 #define __HALHWOUTSRC_H__
diff --git a/drivers/staging/r8188eu/include/odm_RTL8188E.h b/drivers/staging/r8188eu/include/odm_RTL8188E.h
index f96ad5af4bd5..d6718186f2d6 100644
--- a/drivers/staging/r8188eu/include/odm_RTL8188E.h
+++ b/drivers/staging/r8188eu/include/odm_RTL8188E.h
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
 #ifndef	__ODM_RTL8188E_H__
 #define __ODM_RTL8188E_H__
 
diff --git a/drivers/staging/r8188eu/include/odm_RegConfig8188E.h b/drivers/staging/r8188eu/include/odm_RegConfig8188E.h
index f2bf7a0d9867..86b5b2d24210 100644
--- a/drivers/staging/r8188eu/include/odm_RegConfig8188E.h
+++ b/drivers/staging/r8188eu/include/odm_RegConfig8188E.h
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
 #ifndef __INC_ODM_REGCONFIG_H_8188E
 #define __INC_ODM_REGCONFIG_H_8188E
 
diff --git a/drivers/staging/r8188eu/include/odm_RegDefine11AC.h b/drivers/staging/r8188eu/include/odm_RegDefine11AC.h
index 01425f36634c..bba7511cf244 100644
--- a/drivers/staging/r8188eu/include/odm_RegDefine11AC.h
+++ b/drivers/staging/r8188eu/include/odm_RegDefine11AC.h
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
 
 #ifndef	__ODM_REGDEFINE11AC_H__
 #define __ODM_REGDEFINE11AC_H__
diff --git a/drivers/staging/r8188eu/include/odm_RegDefine11N.h b/drivers/staging/r8188eu/include/odm_RegDefine11N.h
index 2b888dee3dd5..5d1d73490c1c 100644
--- a/drivers/staging/r8188eu/include/odm_RegDefine11N.h
+++ b/drivers/staging/r8188eu/include/odm_RegDefine11N.h
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
 
 #ifndef	__ODM_REGDEFINE11N_H__
 #define __ODM_REGDEFINE11N_H__
diff --git a/drivers/staging/r8188eu/include/odm_debug.h b/drivers/staging/r8188eu/include/odm_debug.h
index 5e58b603d6ac..171fc5cbf27c 100644
--- a/drivers/staging/r8188eu/include/odm_debug.h
+++ b/drivers/staging/r8188eu/include/odm_debug.h
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
 
 #ifndef	__ODM_DBG_H__
 #define __ODM_DBG_H__
diff --git a/drivers/staging/r8188eu/include/odm_interface.h b/drivers/staging/r8188eu/include/odm_interface.h
index 0abfa6febb7e..6b589413d56c 100644
--- a/drivers/staging/r8188eu/include/odm_interface.h
+++ b/drivers/staging/r8188eu/include/odm_interface.h
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
 
 #ifndef	__ODM_INTERFACE_H__
 #define __ODM_INTERFACE_H__
diff --git a/drivers/staging/r8188eu/include/odm_precomp.h b/drivers/staging/r8188eu/include/odm_precomp.h
index b2fbb5d5ea77..ff2dae597d5b 100644
--- a/drivers/staging/r8188eu/include/odm_precomp.h
+++ b/drivers/staging/r8188eu/include/odm_precomp.h
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
+/* Copyright(c) 2007 - 2011 Realtek Corporation. i*/
 
 #ifndef	__ODM_PRECOMP_H__
 #define __ODM_PRECOMP_H__
diff --git a/drivers/staging/r8188eu/include/odm_reg.h b/drivers/staging/r8188eu/include/odm_reg.h
index 4221855e333c..81e633fcc0ac 100644
--- a/drivers/staging/r8188eu/include/odm_reg.h
+++ b/drivers/staging/r8188eu/include/odm_reg.h
@@ -1,37 +1,10 @@
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
-/*  File Name: odm_reg.h */
-/*  */
-/*  Description: */
-/*  */
-/*  This file is for general register definition. */
-/*  */
-/*  */
-/*  */
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/* Copyright(c) 2007 - 2011 Realtek Corporation. i*/
+
 #ifndef	__HAL_ODM_REG_H__
 #define __HAL_ODM_REG_H__
 
-/*  */
 /*  Register Definition */
-/*  */
 
 /* MAC REG */
 #define	ODM_BB_RESET					0x002
diff --git a/drivers/staging/r8188eu/include/odm_types.h b/drivers/staging/r8188eu/include/odm_types.h
index f62d8b486a28..4a6c4d33e20e 100644
--- a/drivers/staging/r8188eu/include/odm_types.h
+++ b/drivers/staging/r8188eu/include/odm_types.h
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
 #ifndef __ODM_TYPES_H__
 #define __ODM_TYPES_H__
 
diff --git a/drivers/staging/r8188eu/include/osdep_intf.h b/drivers/staging/r8188eu/include/osdep_intf.h
index c4599c583b59..b585c239c64e 100644
--- a/drivers/staging/r8188eu/include/osdep_intf.h
+++ b/drivers/staging/r8188eu/include/osdep_intf.h
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
 
 #ifndef __OSDEP_INTF_H_
 #define __OSDEP_INTF_H_
diff --git a/drivers/staging/r8188eu/include/osdep_service.h b/drivers/staging/r8188eu/include/osdep_service.h
index ce76a2c99bbd..5b08e985257a 100644
--- a/drivers/staging/r8188eu/include/osdep_service.h
+++ b/drivers/staging/r8188eu/include/osdep_service.h
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
 #ifndef __OSDEP_SERVICE_H_
 #define __OSDEP_SERVICE_H_
 
-- 
2.32.0

