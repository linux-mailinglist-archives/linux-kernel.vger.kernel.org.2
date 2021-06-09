Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC243A1328
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 13:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234953AbhFILrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 07:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234742AbhFILrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 07:47:39 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34CE3C061760
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jun 2021 04:45:45 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id s70-20020a1ca9490000b02901a589651424so3074328wme.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 04:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=styvWJvIXEs6U8gd1fv+TlnpGj3ZJZxwZ7wSHylJeKo=;
        b=RX57wVm41b1Crmr0H5Ujqr2EdlVFoAvjZPCD3KEnYcEJ/+OlmIpyDb3LAwbiNkkmfy
         3sCQtbd+iMGAH9vOLRm0Sl6lSZvzPzEnvLOAGXVTkuyxfnLJl5L/LyL+JowLQcfk2iK2
         UrnZJGJVs7kAfsFN3XEZmn8GuayG++PC2jNArabOhXEOF5amlq7MZ/L41pq+yjzOCVhI
         hJhs9uyIAWe10deEo0k4sF5oDxCb0bktFYOSpWKv/KLb9DxxSc2yA4/oXHPaY6rb2cGV
         3iefErMI38OO270UEO6r9WTzfsIv8Q0QAKQ8pbEXpNBtlWP5nH6jctwpvBYjtZFs3bQk
         CZvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=styvWJvIXEs6U8gd1fv+TlnpGj3ZJZxwZ7wSHylJeKo=;
        b=bLAgsrPAK3Mnzja66AV3Hah8i3Q5vBQUwT0d3nfCueCw3KWt9Gw0b8jnf6TbK2BMsJ
         PAYQNTCBTiHAxqUwmsI8RczpPiyCrP7EmQEp7B3VSKHaePYsJQbp/4EQxappnZSf94Vp
         dozTJP/tK7Ru4EnWT3zjgMmTTVhQqBigHUEVWp0EpWab0E/V1qhTcBvBPnJ8XJqLWCTp
         JOR3k9XK4xe0NqjDCh4u2U6Cqg6ARtXEFDJWZc7mlQy7HnYpPTjobx25+0wMuETsErUG
         2u3Nt1E8SEKBZMhBuzw4iX6GLuB5xBJQ08b6YFccGhKfLSD9vDJlyK2bOZLEvaji6tBN
         6rUg==
X-Gm-Message-State: AOAM530EaLrwn2TPuv0iMUfiHxhDBsiABibsokltGyIME9gxlV/Kmqr7
        fcZzfdxpa7pdCdToH5CXCFsIY50KAJpEURRu
X-Google-Smtp-Source: ABdhPJztWMwskty+Zgx1ZKoAqoj/y4UU3LXJ2H2Rx0dZP8C55OIkUiMpdWyKFSzwbcPk9wEvTF/JXg==
X-Received: by 2002:a7b:c3da:: with SMTP id t26mr26717316wmj.63.1623239143605;
        Wed, 09 Jun 2021 04:45:43 -0700 (PDT)
Received: from localhost ([2a02:768:2307:40d6::45a])
        by smtp.gmail.com with ESMTPSA id n7sm5429414wmq.37.2021.06.09.04.45.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Jun 2021 04:45:43 -0700 (PDT)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 13/31] arm64: zynqmp: Wire DP and DPDMA for dc1/dc4
Date:   Wed,  9 Jun 2021 13:44:49 +0200
Message-Id: <dbbd212bcc587e835d6df2f91622f5baa124bff5.1623239033.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1623239033.git.michal.simek@xilinx.com>
References: <cover.1623239033.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable Display Port and Display Port DMA for zc1751 dc1 and dc4.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts |  8 ++++++++
 arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts | 10 +++++++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
index dd129347174a..460aba6e7990 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
@@ -391,3 +391,11 @@ &usb0 {
 	phys = <&psgtr 2 PHY_TYPE_USB3 0 2>;
 	maximum-speed = "super-speed";
 };
+
+&zynqmp_dpdma {
+	status = "okay";
+};
+
+&zynqmp_dpsub {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts
index 2366cd9f091a..8046f0df0f35 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts
@@ -2,7 +2,7 @@
 /*
  * dts file for Xilinx ZynqMP zc1751-xm018-dc4
  *
- * (C) Copyright 2015 - 2019, Xilinx, Inc.
+ * (C) Copyright 2015 - 2021, Xilinx, Inc.
  *
  * Michal Simek <michal.simek@xilinx.com>
  */
@@ -176,3 +176,11 @@ &uart1 {
 &watchdog0 {
 	status = "okay";
 };
+
+&zynqmp_dpdma {
+	status = "okay";
+};
+
+&zynqmp_dpsub {
+	status = "okay";
+};
-- 
2.31.1

