Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE9E834D1D6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 15:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbhC2Nvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 09:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231734AbhC2NvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 09:51:21 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA0FC061574;
        Mon, 29 Mar 2021 06:51:20 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id e14so4421775plj.2;
        Mon, 29 Mar 2021 06:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=g6MGypQezVtHLiXCLKeIkg+BTfToRXpmNx+Fhvih524=;
        b=RmZVrOs/Xv6ZMvjON31XrBzpiNonLabyrdWo/pSVmegntHjtDII1lrl3jhlny0jSfe
         Yw7ih/0CCagLRHylRs4mEsI2QDpW68bDZXQ75S4u2VzCdI+hzkamqFcvcMj5B5otf8YI
         MmRTxtANSQoN+iy0EUJqvCAQjHFgiLyXtOCQgtSHH0jZxfZ6WZLz2brskEo3vZrm12yZ
         d0ANtskJRkXCR/GL1QI/zUup/m/0//seluOxapFIVFqCmNcwcdo0jzO9+atMN1t/QTnP
         LMCrxHAeGZLib9SjD9IVj1W+GN3ulHLiD0qBp/0Hits1Hl3ZrO4UuYWJpAlpf9w9S5y8
         KkhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=g6MGypQezVtHLiXCLKeIkg+BTfToRXpmNx+Fhvih524=;
        b=CRuAB41SWTDJI25XxR5Agnbm2VJBCMVghpjKC3LrGIbclsqqVdEUCbLq1828chC7+o
         4WbtdbUlEV7thltjBzyHWX+1TVqsmaHmpYtomtytWtLOKwXepNDe6dZ1pRkl9xOsSXdD
         L6GBBz9Df0Aene6iZV6roJt3JleN11suBUynVcIhHilQR4KU64ZeZJVtB4mRZjP16T65
         QiqdiML62XHTMeCBKvt1IOjdadbf1GXrr/gxBRcLONp3o12ybuqcFqtLxjZzA4xp/fMf
         tEXwOjPScPveGCjhVYM6SIgTTtcOS3ajP/ckUyHQTLT7Cl5B7qs1IvFU5ELtAmx6XeWN
         iFog==
X-Gm-Message-State: AOAM532ubgFdKiCh3hR1A9aNKUvCeeZPv0kwASLzvYrcQzBboQWuL/fN
        ULJNbNG+A7axNxKok9udF9CXT8MjhnAyQl00
X-Google-Smtp-Source: ABdhPJwOf99fPjyShSZ07RL9cICcdUqyhTG71ttWjJnb7jcJExZZeM7z9zMCbhmt2Dw5Q2iN/dvltg==
X-Received: by 2002:a17:902:d202:b029:e4:55cd:dde8 with SMTP id t2-20020a170902d202b02900e455cddde8mr28519192ply.51.1617025880092;
        Mon, 29 Mar 2021 06:51:20 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:600d:a089:4ed:8f53:adc7:b574])
        by smtp.googlemail.com with ESMTPSA id w84sm17429226pfc.142.2021.03.29.06.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 06:51:19 -0700 (PDT)
From:   Aditya Srivastava <yashsri421@gmail.com>
To:     balbi@kernel.org
Cc:     yashsri421@gmail.com, lukas.bulwahn@gmail.com,
        gregkh@linuxfoundation.org, rdunlap@infradead.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] usb: dwc3: fix incorrect kernel-doc comment syntax in files
Date:   Mon, 29 Mar 2021 19:21:08 +0530
Message-Id: <20210329135108.27128-1-yashsri421@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The opening comment mark '/**' is used for highlighting the beginning of
kernel-doc comments.
There are certain files in drivers/usb/dwc3, which follow this syntax,
but the content inside does not comply with kernel-doc.
Such lines were probably not meant for kernel-doc parsing, but are parsed
due to the presence of kernel-doc like comment syntax(i.e, '/**'), which
causes unexpected warnings from kernel-doc.

E.g., presence of kernel-doc like comment in drivers/usb/dwc3/io.h at
header causes this warnings by kernel-doc:
"warning: expecting prototype for h(). Prototype was for __DRIVERS_USB_DWC3_IO_H() instead"

Similarly for other files too.

Provide a simple fix by replacing such occurrences with general comment
format, i.e. '/*', to prevent kernel-doc from parsing it.

Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
---
* Applies perfectly on next-20210326

 drivers/usb/dwc3/debug.h         | 2 +-
 drivers/usb/dwc3/debugfs.c       | 2 +-
 drivers/usb/dwc3/dwc3-keystone.c | 2 +-
 drivers/usb/dwc3/dwc3-pci.c      | 2 +-
 drivers/usb/dwc3/io.h            | 2 +-
 drivers/usb/dwc3/trace.c         | 2 +-
 drivers/usb/dwc3/trace.h         | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/dwc3/debug.h b/drivers/usb/dwc3/debug.h
index 8ab394942360..db231de46bb3 100644
--- a/drivers/usb/dwc3/debug.h
+++ b/drivers/usb/dwc3/debug.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/**
+/*
  * debug.h - DesignWare USB3 DRD Controller Debug Header
  *
  * Copyright (C) 2010-2011 Texas Instruments Incorporated - https://www.ti.com
diff --git a/drivers/usb/dwc3/debugfs.c b/drivers/usb/dwc3/debugfs.c
index 5da4f6082d93..b0e3f434d219 100644
--- a/drivers/usb/dwc3/debugfs.c
+++ b/drivers/usb/dwc3/debugfs.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/**
+/*
  * debugfs.c - DesignWare USB3 DRD Controller DebugFS file
  *
  * Copyright (C) 2010-2011 Texas Instruments Incorporated - https://www.ti.com
diff --git a/drivers/usb/dwc3/dwc3-keystone.c b/drivers/usb/dwc3/dwc3-keystone.c
index 057056c0975e..1317959294e6 100644
--- a/drivers/usb/dwc3/dwc3-keystone.c
+++ b/drivers/usb/dwc3/dwc3-keystone.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/**
+/*
  * dwc3-keystone.c - Keystone Specific Glue layer
  *
  * Copyright (C) 2010-2013 Texas Instruments Incorporated - https://www.ti.com
diff --git a/drivers/usb/dwc3/dwc3-pci.c b/drivers/usb/dwc3/dwc3-pci.c
index 4c5c6972124a..4698c43af5ae 100644
--- a/drivers/usb/dwc3/dwc3-pci.c
+++ b/drivers/usb/dwc3/dwc3-pci.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/**
+/*
  * dwc3-pci.c - PCI Specific glue layer
  *
  * Copyright (C) 2010-2011 Texas Instruments Incorporated - https://www.ti.com
diff --git a/drivers/usb/dwc3/io.h b/drivers/usb/dwc3/io.h
index 76b73b116862..1e96ea339d48 100644
--- a/drivers/usb/dwc3/io.h
+++ b/drivers/usb/dwc3/io.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/**
+/*
  * io.h - DesignWare USB3 DRD IO Header
  *
  * Copyright (C) 2010-2011 Texas Instruments Incorporated - https://www.ti.com
diff --git a/drivers/usb/dwc3/trace.c b/drivers/usb/dwc3/trace.c
index 1b45a9723eeb..088995885678 100644
--- a/drivers/usb/dwc3/trace.c
+++ b/drivers/usb/dwc3/trace.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/**
+/*
  * trace.c - DesignWare USB3 DRD Controller Trace Support
  *
  * Copyright (C) 2014 Texas Instruments Incorporated - https://www.ti.com
diff --git a/drivers/usb/dwc3/trace.h b/drivers/usb/dwc3/trace.h
index 97f4f1125a41..60883268adfc 100644
--- a/drivers/usb/dwc3/trace.h
+++ b/drivers/usb/dwc3/trace.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/**
+/*
  * trace.h - DesignWare USB3 DRD Controller Trace Support
  *
  * Copyright (C) 2014 Texas Instruments Incorporated - https://www.ti.com
-- 
2.17.1

