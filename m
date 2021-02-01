Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DED1130A9C3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 15:30:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbhBAO3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 09:29:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbhBAO3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 09:29:25 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DAD8C061756
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 06:28:42 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id d2so19104174edz.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 06:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mkMbMPOi+ltFdpiZMqswj7TMh1dG3VuQkTp2WqciDQ4=;
        b=e/biWOrDZ33cuquCTcj+8OhbvSWehxdbX0Xudvwy+HE5TINIEGlG5mF61KCN5+I3NN
         Mm8S9XzztbeNVi2QUrF7LikD3ID26QHGEydtIwoPoub1inETsvDyxDLqix6nxsNzY9g7
         PtMmSweSM5MU3n9UaEpoh4/4nHWcOlje0AJphUxVNfRhEBaJo25lr/DUuWtPaxu/1CLd
         430d8zsR7i66BhxEiPEd1foFyk8cQoJdxmGEKB9H36pD+3cvJ7OBWli6fZrQ/rmubnwG
         JCP2ZdCGUdclTomaJKTwAeVad/3SF+wULaBY9Mta5y7j/3XBLIzd+P4EliiG2Jg/oPPB
         BSNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=mkMbMPOi+ltFdpiZMqswj7TMh1dG3VuQkTp2WqciDQ4=;
        b=WMXSZ3Dk79Tcb0KqStw8Mcbqi7XnO49SZQVXvG2OGdAWaGXB14j9qZ/DhntTNW+lrv
         BOe9RTJFTcbNVxw0yldxKL9P35gdXUR0ALqQ4Kh5yldaOZOQyjEXWI4ILDyUD9wF3JCk
         XA/aGmYHqoUnP/sEbqO8GDYQWkjPDzKT3JdNICWchVblK3eOaJ0Gl/cUCXpA8aRpsy2K
         7y2ETvw8aEMknX4+FsMgAO7eWA2Yf0amPgDr5nc0JcehereNbXxVCbZsxWwJ4JGJ6Ca5
         o465zxkRMvYkqrmXjpZxu3afQ7wvp156KOrrhx1TqdzTTBkjYokF+T3vml74Zr741K+z
         E+0Q==
X-Gm-Message-State: AOAM530ROL8x3EmgXE6ppNSn7XcZKEeEn/44HO6l4ie6yemqH1us+y+e
        x7uf6kxNI3em6gN0MRxVWHEajQ/XhuKyOzc5
X-Google-Smtp-Source: ABdhPJz6wAMliiJASdppMl+jk0+nDN6Tu1XmgKaqPu/wcQGjz0Exa0CYsekW6aavvaMfgfM3VJI6Pg==
X-Received: by 2002:aa7:d5c5:: with SMTP id d5mr5886626eds.139.1612189720637;
        Mon, 01 Feb 2021 06:28:40 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id t19sm7994408ejc.62.2021.02.01.06.28.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Feb 2021 06:28:40 -0800 (PST)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] ARM: zynq: Update Copyright date in DTS
Date:   Mon,  1 Feb 2021 15:28:38 +0100
Message-Id: <ac55738da7710848ef4824d45bdac18fa1d11392.1612189714.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update years in header to be up2date.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/arm/boot/dts/zynq-7000.dtsi       | 2 +-
 arch/arm/boot/dts/zynq-cc108.dts       | 2 +-
 arch/arm/boot/dts/zynq-zc702.dts       | 2 +-
 arch/arm/boot/dts/zynq-zc706.dts       | 2 +-
 arch/arm/boot/dts/zynq-zc770-xm010.dts | 2 +-
 arch/arm/boot/dts/zynq-zc770-xm011.dts | 2 +-
 arch/arm/boot/dts/zynq-zc770-xm012.dts | 2 +-
 arch/arm/boot/dts/zynq-zc770-xm013.dts | 2 +-
 arch/arm/boot/dts/zynq-zed.dts         | 2 +-
 arch/arm/boot/dts/zynq-zybo.dts        | 2 +-
 10 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
index c4810d58540b..d46c1e2652e7 100644
--- a/arch/arm/boot/dts/zynq-7000.dtsi
+++ b/arch/arm/boot/dts/zynq-7000.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright (C) 2011 - 2014 Xilinx
+ * Copyright (C) 2011 - 2021 Xilinx
  */
 
 / {
diff --git a/arch/arm/boot/dts/zynq-cc108.dts b/arch/arm/boot/dts/zynq-cc108.dts
index 8b9ab9bba23b..33546e13bb46 100644
--- a/arch/arm/boot/dts/zynq-cc108.dts
+++ b/arch/arm/boot/dts/zynq-cc108.dts
@@ -2,7 +2,7 @@
 /*
  * Xilinx CC108 board DTS
  *
- * (C) Copyright 2007-2018 Xilinx, Inc.
+ * (C) Copyright 2007-2021 Xilinx, Inc.
  * (C) Copyright 2007-2013 Michal Simek
  * (C) Copyright 2007-2012 PetaLogix Qld Pty Ltd
  *
diff --git a/arch/arm/boot/dts/zynq-zc702.dts b/arch/arm/boot/dts/zynq-zc702.dts
index cf70aff26c66..a226498364af 100644
--- a/arch/arm/boot/dts/zynq-zc702.dts
+++ b/arch/arm/boot/dts/zynq-zc702.dts
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- *  Copyright (C) 2011 - 2014 Xilinx
+ *  Copyright (C) 2011 - 2021 Xilinx
  *  Copyright (C) 2012 National Instruments Corp.
  */
 /dts-v1/;
diff --git a/arch/arm/boot/dts/zynq-zc706.dts b/arch/arm/boot/dts/zynq-zc706.dts
index 77943c16d33f..73d8b7a78415 100644
--- a/arch/arm/boot/dts/zynq-zc706.dts
+++ b/arch/arm/boot/dts/zynq-zc706.dts
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- *  Copyright (C) 2011 - 2014 Xilinx
+ *  Copyright (C) 2011 - 2021 Xilinx
  *  Copyright (C) 2012 National Instruments Corp.
  */
 /dts-v1/;
diff --git a/arch/arm/boot/dts/zynq-zc770-xm010.dts b/arch/arm/boot/dts/zynq-zc770-xm010.dts
index 0dd352289a45..e54a229b1f78 100644
--- a/arch/arm/boot/dts/zynq-zc770-xm010.dts
+++ b/arch/arm/boot/dts/zynq-zc770-xm010.dts
@@ -2,7 +2,7 @@
 /*
  * Xilinx ZC770 XM010 board DTS
  *
- * Copyright (C) 2013-2018 Xilinx, Inc.
+ * Copyright (C) 2013-2021 Xilinx, Inc.
  */
 /dts-v1/;
 #include "zynq-7000.dtsi"
diff --git a/arch/arm/boot/dts/zynq-zc770-xm011.dts b/arch/arm/boot/dts/zynq-zc770-xm011.dts
index 56732e8f6ca1..a4ce58e1e648 100644
--- a/arch/arm/boot/dts/zynq-zc770-xm011.dts
+++ b/arch/arm/boot/dts/zynq-zc770-xm011.dts
@@ -2,7 +2,7 @@
 /*
  * Xilinx ZC770 XM011 board DTS
  *
- * Copyright (C) 2013-2018 Xilinx, Inc.
+ * Copyright (C) 2013-2021 Xilinx, Inc.
  */
 /dts-v1/;
 #include "zynq-7000.dtsi"
diff --git a/arch/arm/boot/dts/zynq-zc770-xm012.dts b/arch/arm/boot/dts/zynq-zc770-xm012.dts
index d2359b789eb8..f842e7ad4f9d 100644
--- a/arch/arm/boot/dts/zynq-zc770-xm012.dts
+++ b/arch/arm/boot/dts/zynq-zc770-xm012.dts
@@ -2,7 +2,7 @@
 /*
  * Xilinx ZC770 XM012 board DTS
  *
- * Copyright (C) 2013-2018 Xilinx, Inc.
+ * Copyright (C) 2013-2021 Xilinx, Inc.
  */
 /dts-v1/;
 #include "zynq-7000.dtsi"
diff --git a/arch/arm/boot/dts/zynq-zc770-xm013.dts b/arch/arm/boot/dts/zynq-zc770-xm013.dts
index 38d96adc870c..fe4cd75bc9db 100644
--- a/arch/arm/boot/dts/zynq-zc770-xm013.dts
+++ b/arch/arm/boot/dts/zynq-zc770-xm013.dts
@@ -2,7 +2,7 @@
 /*
  * Xilinx ZC770 XM013 board DTS
  *
- * Copyright (C) 2013 Xilinx, Inc.
+ * Copyright (C) 2013-2021 Xilinx, Inc.
  */
 /dts-v1/;
 #include "zynq-7000.dtsi"
diff --git a/arch/arm/boot/dts/zynq-zed.dts b/arch/arm/boot/dts/zynq-zed.dts
index 6a5a93aa6552..fd2b562d374d 100644
--- a/arch/arm/boot/dts/zynq-zed.dts
+++ b/arch/arm/boot/dts/zynq-zed.dts
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- *  Copyright (C) 2011 - 2014 Xilinx
+ *  Copyright (C) 2011 - 2021 Xilinx
  *  Copyright (C) 2012 National Instruments Corp.
  */
 /dts-v1/;
diff --git a/arch/arm/boot/dts/zynq-zybo.dts b/arch/arm/boot/dts/zynq-zybo.dts
index 755f6f109d5a..f163f9d69f80 100644
--- a/arch/arm/boot/dts/zynq-zybo.dts
+++ b/arch/arm/boot/dts/zynq-zybo.dts
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- *  Copyright (C) 2011 - 2014 Xilinx
+ *  Copyright (C) 2011 - 2021 Xilinx
  *  Copyright (C) 2012 National Instruments Corp.
  */
 /dts-v1/;
-- 
2.30.0

