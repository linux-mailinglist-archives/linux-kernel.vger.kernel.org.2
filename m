Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 485E33A1334
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 13:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239332AbhFILsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 07:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239268AbhFILsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 07:48:03 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB67C061789
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jun 2021 04:45:58 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id a20so25193155wrc.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 04:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z0cFsHWQuOk9G5jkREqSCN4u8xY+Z74kdKMqaqt4F9c=;
        b=GvmwQD/kVLwJG8MdRtkEKzfGwg4M/mxylb+khtTOyeA3+SLGx2OUbQFFTTt9wyBwkD
         Mi7bmH/2zVcvBMNBHjfMtoKpayYcLp+HU920cKoCMxygc2eatLFmyHEPd7Lhl4y95qMT
         eiSIqRE2H+CH4nGNFNJqZiJ9t2XCm/H4EJhGu9/shfFYYvwoM2gHLPXJa1baZmcqqbw+
         cMb66j98hZklxUcZftjivNEJxwfZLt5iSDH6GpXW+F8/N8WxGEvA4FUaqMo6VOWQy7UY
         pyA88f4dqOg08wA4ewBLliDAuWlnA1rg/PZ7WMlxLcMZqM2IHTwrMn/Z3Jy/MDfxlrbE
         ovNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=z0cFsHWQuOk9G5jkREqSCN4u8xY+Z74kdKMqaqt4F9c=;
        b=SvGJMvxc0mksgiwBbS4EXsfL90ueS8ISlDKW+endcjO+e1ibznTAXPBj23gm13oie4
         ss8xJLyb+My5yz1AqG4hl3o2yacsPS767V65f2VwwRPvpYH5sFnfp7SM7HFSmvXptRYz
         d1B+SYpAQHnIdbI6u22qVFdsCJaobIxFN88g4ib2TIgCFgRYXpyFCuTdUbzw7Ue2waZB
         IeuwyUHLFuQ0IS8YSUe3WVY09tnCaSLPengCCwC7lNeFtAnKEkghpnJfXrIS2VWInwoz
         sGc6n0HFDOYEiXtndxgGfiJocQvsA8b3tUWF8XB5nGtZOVeG0Px1VrLiI5Ubcw7oWfBQ
         3Tqg==
X-Gm-Message-State: AOAM530jqQpcpmPwwkJkHCtd2kR0zes08b1GAl6wsurUcgoubaqJYBi6
        Jtkv5OYkgYVtAJZ9+OyPQYfliOVARv36O5H5
X-Google-Smtp-Source: ABdhPJzamxlVbLxHizavnn9Xv6irhxfglkP3D6Bxq6qyeu1A2aPWPNdor17d4qPb3u0HWsmS+HU1BA==
X-Received: by 2002:a05:6000:18f:: with SMTP id p15mr22537019wrx.102.1623239157104;
        Wed, 09 Jun 2021 04:45:57 -0700 (PDT)
Received: from localhost ([2a02:768:2307:40d6::45a])
        by smtp.gmail.com with ESMTPSA id k36sm11937395wms.30.2021.06.09.04.45.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Jun 2021 04:45:56 -0700 (PDT)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Quanyang Wang <quanyang.wang@windriver.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 21/31] arm64: zynqmp: Move DP nodes to the end of file on zcu106
Date:   Wed,  9 Jun 2021 13:44:57 +0200
Message-Id: <4d1c79f6f184367687f61608bb8e0f18d9121802.1623239033.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1623239033.git.michal.simek@xilinx.com>
References: <cover.1623239033.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This location is used by others DTs files that's why this move.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 .../boot/dts/xilinx/zynqmp-zcu106-revA.dts    | 22 +++++++++----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
index dbb8bfbb5c7f..4a0f3370bf7f 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
@@ -160,17 +160,6 @@ &dcc {
 	status = "okay";
 };
 
-&zynqmp_dpdma {
-	status = "okay";
-};
-
-&zynqmp_dpsub {
-	status = "okay";
-	phy-names = "dp-phy0", "dp-phy1";
-	phys = <&psgtr 1 PHY_TYPE_DP 0 3>,
-	       <&psgtr 0 PHY_TYPE_DP 1 3>;
-};
-
 /* fpd_dma clk 667MHz, lpd_dma 500MHz */
 &fpd_dma_chan1 {
 	status = "okay";
@@ -994,3 +983,14 @@ &usb0 {
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
+	phy-names = "dp-phy0", "dp-phy1";
+	phys = <&psgtr 1 PHY_TYPE_DP 0 3>,
+	       <&psgtr 0 PHY_TYPE_DP 1 3>;
+};
-- 
2.31.1

