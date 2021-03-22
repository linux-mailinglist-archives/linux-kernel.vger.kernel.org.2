Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 205CA343A83
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 08:24:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbhCVHY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 03:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbhCVHX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 03:23:58 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42C1CC061574;
        Mon, 22 Mar 2021 00:23:57 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id x16so15491313wrn.4;
        Mon, 22 Mar 2021 00:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=HlKn4dGfq7EGRrc/VNPdo+z1r+GB1vodbHKH3VbdTc0=;
        b=Rkv1qAqalFOK1BUrAKOnyJShC4/WWZPoxaXhF1SqBTmUcVCBCxNQd9b7MY9YYVpEhx
         CZ5sYIiTKjQhnHqoG7g3y96tQCj7VJ1ViFTrM3aM5ZJAvhTnzHhzbfMttLNg+MeS3Nsa
         RUWjSG5H0lEhDEGu7VdgmXfbDNdefIp0m9PXvBIUxAR3mlW2eFTr2ReMin6ptWVKNBnf
         8juW/VCHpqOjZkh8Jo2XhPEWZPkzLVnlHvvE/TbtNAPsGOYd1Xnw4OeVxk4nGb8Guf4A
         QiYrunjv4Aikt6GG5LvAR++YquVH2z6J8OQBuw4uxCd3I/ZrYHej7DDAoKscff4v8KqU
         H9ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HlKn4dGfq7EGRrc/VNPdo+z1r+GB1vodbHKH3VbdTc0=;
        b=QHv9J8UY8ftB40A9L8KsPMv/27OzWuu7DApGVZPlhwBHntaWoM84Kg6lTVsQfJK/JG
         FIw1cfFC2Sf1LHQPwZ0vpOEjvQePCRy2m0dyxEDBgkmkEGXNFghW5PJdq/ZmjXuc58Er
         hrV+r8XEh+rmK9uW9ZtI0Df8UfSldF5JJMWyZdmhR4AfXrWPMPAqAV6YY8f9Uy5U+UnA
         5f5B3txin0n1485Gu6i/cvvn3Q7QzDtVgZ5AjRogEWS8qGQEExjas/ArpI/R/yXGfkeJ
         uu/VEUS1k6oviaxOM/kKhboSpcLmndR/XUAaBQz3sVa6qSFaKLbBswu9CVL7UuWIL6+Q
         KVrg==
X-Gm-Message-State: AOAM532opvgO5Y2zuz79ptEnc8M5PKIaS7NJfEwqkjEC5+t+ugYycvP6
        bLwQbBEvAUDBnzcsfXJPTnA=
X-Google-Smtp-Source: ABdhPJy/ZukVjppUeIZkDMajZGUbgqLJ7V86peDRPgwwIroxU7jfRTTmLSz3UEvWf4SkbaEv09JU9g==
X-Received: by 2002:adf:fb87:: with SMTP id a7mr16878004wrr.58.1616397833622;
        Mon, 22 Mar 2021 00:23:53 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2d8a:8e00:f0d7:9c83:eaad:b065])
        by smtp.gmail.com with ESMTPSA id i8sm15698129wmi.6.2021.03.22.00.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 00:23:53 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc:     Aditya Srivastava <yashsri421@gmail.com>,
        Wei Xu <xuwei5@hisilicon.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] devicetree: replace invalid kernel-doc comment headers
Date:   Mon, 22 Mar 2021 08:23:43 +0100
Message-Id: <20210322072343.19993-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The opening comment mark '/**' is used for indicating the beginning of
kernel-doc comments.

Replace uses of '/**' for invalid cases in dt-binding headers and dts.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Rob, please pick this quick kernel-doc cleanup patch.

 arch/arm64/boot/dts/hisilicon/hip05-d02.dts    | 2 +-
 arch/arm64/boot/dts/hisilicon/hip05.dtsi       | 2 +-
 arch/arm64/boot/dts/hisilicon/hip06-d03.dts    | 2 +-
 arch/arm64/boot/dts/hisilicon/hip06.dtsi       | 4 ++--
 arch/arm64/boot/dts/hisilicon/hip07-d05.dts    | 2 +-
 arch/arm64/boot/dts/hisilicon/hip07.dtsi       | 2 +-
 include/dt-bindings/reset/hisi,hi6220-resets.h | 2 +-
 include/dt-bindings/reset/snps,hsdk-reset.h    | 2 +-
 8 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hip05-d02.dts b/arch/arm64/boot/dts/hisilicon/hip05-d02.dts
index 369b69b17b91..3d3d52bf41f5 100644
--- a/arch/arm64/boot/dts/hisilicon/hip05-d02.dts
+++ b/arch/arm64/boot/dts/hisilicon/hip05-d02.dts
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/**
+/*
  * dts file for Hisilicon D02 Development Board
  *
  * Copyright (C) 2014,2015 Hisilicon Ltd.
diff --git a/arch/arm64/boot/dts/hisilicon/hip05.dtsi b/arch/arm64/boot/dts/hisilicon/hip05.dtsi
index 4aed8d440b3a..5161e3476531 100644
--- a/arch/arm64/boot/dts/hisilicon/hip05.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hip05.dtsi
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/**
+/*
  * dts file for Hisilicon D02 Development Board
  *
  * Copyright (C) 2014,2015 Hisilicon Ltd.
diff --git a/arch/arm64/boot/dts/hisilicon/hip06-d03.dts b/arch/arm64/boot/dts/hisilicon/hip06-d03.dts
index 9f4a930e734d..97aa42a86fd9 100644
--- a/arch/arm64/boot/dts/hisilicon/hip06-d03.dts
+++ b/arch/arm64/boot/dts/hisilicon/hip06-d03.dts
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/**
+/*
  * dts file for Hisilicon D03 Development Board
  *
  * Copyright (C) 2016 Hisilicon Ltd.
diff --git a/arch/arm64/boot/dts/hisilicon/hip06.dtsi b/arch/arm64/boot/dts/hisilicon/hip06.dtsi
index 7deca5f763d5..d86ee1d25ab8 100644
--- a/arch/arm64/boot/dts/hisilicon/hip06.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hip06.dtsi
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/**
+/*
  * dts file for Hisilicon D03 Development Board
  *
  * Copyright (C) 2016 Hisilicon Ltd.
@@ -315,7 +315,7 @@
 		};
 	};
 
-	/**
+	/*
 	 *  HiSilicon erratum 161010801: This describes the limitation
 	 *  of HiSilicon platforms hip06/hip07 to support the SMMUv3
 	 *  mappings for PCIe MSI transactions.
diff --git a/arch/arm64/boot/dts/hisilicon/hip07-d05.dts b/arch/arm64/boot/dts/hisilicon/hip07-d05.dts
index 81a2312c8a26..57debca7b1ac 100644
--- a/arch/arm64/boot/dts/hisilicon/hip07-d05.dts
+++ b/arch/arm64/boot/dts/hisilicon/hip07-d05.dts
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/**
+/*
  * dts file for Hisilicon D05 Development Board
  *
  * Copyright (C) 2016 Hisilicon Ltd.
diff --git a/arch/arm64/boot/dts/hisilicon/hip07.dtsi b/arch/arm64/boot/dts/hisilicon/hip07.dtsi
index 2172d8071181..553f7c5209ad 100644
--- a/arch/arm64/boot/dts/hisilicon/hip07.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hip07.dtsi
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/**
+/*
  * dts file for Hisilicon D05 Development Board
  *
  * Copyright (C) 2016 Hisilicon Ltd.
diff --git a/include/dt-bindings/reset/hisi,hi6220-resets.h b/include/dt-bindings/reset/hisi,hi6220-resets.h
index 63aff7d8aa45..c67f479eede7 100644
--- a/include/dt-bindings/reset/hisi,hi6220-resets.h
+++ b/include/dt-bindings/reset/hisi,hi6220-resets.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/**
+/*
  * This header provides index for the reset controller
  * based on hi6220 SoC.
  */
diff --git a/include/dt-bindings/reset/snps,hsdk-reset.h b/include/dt-bindings/reset/snps,hsdk-reset.h
index e1a643e4bc91..6a331c8d834d 100644
--- a/include/dt-bindings/reset/snps,hsdk-reset.h
+++ b/include/dt-bindings/reset/snps,hsdk-reset.h
@@ -1,4 +1,4 @@
-/**
+/*
  * This header provides index for the HSDK reset controller.
  */
 #ifndef _DT_BINDINGS_RESET_CONTROLLER_SNPS_HSDK
-- 
2.17.1

