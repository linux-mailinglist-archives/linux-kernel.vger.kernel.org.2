Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B39373A132F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 13:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239227AbhFILsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 07:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235021AbhFILr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 07:47:56 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75479C061760
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jun 2021 04:45:55 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 3-20020a05600c0243b029019f2f9b2b8aso3998804wmj.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 04:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ws5KFSDcy0/GzNRUs6Wg3uxHuwHpItMQoMPWkBxL9Uc=;
        b=Oy7U7Zvp7YmAmR4vLC9d/ys3RwZvv/RGbSF7AJ/n+fU+tHr1rccDo0NggpbFnk82S3
         fzd8od6yNFwyTOnRi6jqi6zT1GfoT/3n566Urmlx6vC8QZWwbdTcBDsLHHyd9qKzL8YQ
         /XkvkChf3gFJiTojhqYvyRr3lxSqMUf8r+wrqxs9I33f/cFb+CZwo2gwxP0U1XTI4tCi
         AXe03oUieAPB00K/N8i3Vx7Am8OURJYPPfX2BscuF7F/sV1JMXLwgFVqtDmTXSs0peDF
         9qPuTJs/xPOD1NG+VqgpOgUooC/oNaBgweGbVyUcIy1X6QPRKnf6q3bQJWElOOVyeotn
         n7Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Ws5KFSDcy0/GzNRUs6Wg3uxHuwHpItMQoMPWkBxL9Uc=;
        b=cM6UroTthstA2c6qBN2pMe2xNkMMr6j3xA3WFBAFKqzMi1DYIeBsHoA2sr7VNYrUby
         WW0eL2R343AC5Mn55uSNJQ8lVE1QLxof/Dlb23TxKPTHMBRRgtFNSXC4fCHtnIEFggdk
         YnrCKBTQqtxeSJFwn2W4LXX1LgpTnugV88mQecM7dvOwN5D9OpxcpBVOauQmDEy7ybRe
         uoCNwTLIdwlvDb7aT2DAHNA8Pc3/CT2R36ZDzJrjH6n7q7vTcdIpnw97aXB6PsgVKT25
         9evCSdBF8//VzCyWvjcc6NVWi1eUn9d+Bco8YbYJIxfCBwcWfxP3PFAO6Zh8Ip4qDn2B
         hrUg==
X-Gm-Message-State: AOAM532o+wguNieGSrbCzCUdc+qOP34wBBVojcmNqMCa6hHH25AO5LyP
        QS5itHkCqCT/mwVlSsY91emyHxh/rcUNpaEh
X-Google-Smtp-Source: ABdhPJwPkVRd86Kf3QXTQ/Dm+lvBT829pSO/dYETHf6tfBEI/MgZlRu78M/MbhBQvFS3yhJpIAnJAQ==
X-Received: by 2002:a05:600c:4ec8:: with SMTP id g8mr9257644wmq.62.1623239153922;
        Wed, 09 Jun 2021 04:45:53 -0700 (PDT)
Received: from localhost ([2a02:768:2307:40d6::45a])
        by smtp.gmail.com with ESMTPSA id p16sm24172961wrs.52.2021.06.09.04.45.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Jun 2021 04:45:53 -0700 (PDT)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Mounika Grace Akula <mounika.grace.akula@xilinx.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 19/31] arm64: zynqmp: Add reset-on-timeout to all boards and modify default timeout value
Date:   Wed,  9 Jun 2021 13:44:55 +0200
Message-Id: <5848a81447921240fddfe2f5749ae0746fcbbdbd.1623239033.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1623239033.git.michal.simek@xilinx.com>
References: <cover.1623239033.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mounika Grace Akula <mounika.grace.akula@xilinx.com>

This patch adds reset-on-timeout to FPD WDT which will trigger an
interrupt to PMU when watchdog expiry happens and PMU takes the
necessary action. If this property is not enabled, reason will not be
known when watchdog expiry happens.
This patch also modifies the default timeout to 60 seconds. Reason is
that if u-boot enables WDT, it will set the timeout to 10 seconds and
this is not enough to boot till Linux and start the WDT application in
Linux. 60 seconds is the maximum safest value to boot till Linux and
start the WDT application.

Users need to change this timeout value to fit their needs.

Signed-off-by: Mounika Grace Akula <mounika.grace.akula@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index bd3f0d456ca4..80332e3b4d6a 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -830,7 +830,8 @@ watchdog0: watchdog@fd4d0000 {
 			interrupt-parent = <&gic>;
 			interrupts = <0 113 1>;
 			reg = <0x0 0xfd4d0000 0x0 0x1000>;
-			timeout-sec = <10>;
+			timeout-sec = <60>;
+			reset-on-timeout;
 		};
 
 		lpd_watchdog: watchdog@ff150000 {
-- 
2.31.1

