Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B95E53A6A2A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 17:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233772AbhFNP25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 11:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233569AbhFNP2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 11:28:19 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A15EC06124A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 08:26:04 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id t3so47083773edc.7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 08:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1PJmBZf2G/3VuzRVB8MuhLk6fPYGXd52C/maYloIeUA=;
        b=fKQ/35piKP8FwlgqjdA28gAS7WG1+WW8KfL5wxq293ZVo8oK6jg5OLs2TXdV57B36F
         px6yUUMwPsm0eL8EVdLN4wDARQhkUFDaXX4lLWnv3IUSIpL3gy8myXWrGGZNri1N0oZO
         dgONx9JxkSEClcPR8sGCZ2ZMgmf0OJjw6OLd4GGk5eVSFgqIWMXLdDdN+nNcFIMT2bdo
         Mk95Vd5RetifJmy4o0FUh9lyRfuMh9CixZKVjjUf251AO3HfDASFh/sB8Se4Vcpx99B3
         9GcO5K6X/XHKO2avrfOfEiZwccgiD2BjvPzL/ZrkF4RLxCF61IgB5Tcl76bRn+EAk+bB
         PBbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=1PJmBZf2G/3VuzRVB8MuhLk6fPYGXd52C/maYloIeUA=;
        b=BTyfKAHMeJ96wj02BwsH4dleyo/TL/+6I+Q0fhxB+WQLVYftZxSvgPC91o9kSiJx3c
         kkK9kuo9D8fZ41pGuNzP4/IM50atGsfLE4AP1bPwEpAvankTR0c2mCztW5/s/y+wi8Cq
         UAbaqUxgS2FLlBhdQraFLsovhNJg8MZzwAU7wljk4by+s+F/YgpXERR1/vxGOh/KwN3B
         2pvNL72mMu7VmOnxZQcJHo4Cej5og9axHJZMsulwXJWAZhEDpHQRUtpGAB0oClMObwDl
         9rXYHUMqVxvURZ4gkl3Zi+Ni7Rk6o0eNkTtHFf1X2ULHPiToT6VU3goJC8ntEX/p6lNL
         gzIw==
X-Gm-Message-State: AOAM531bEjM8CZBOaev8Zf+78dxYl0cETDe7cHulaD/bqJy5w7bL5791
        eaa+sDCf2OnrjylYkjp6hYj+qX1HMOqpYC7R
X-Google-Smtp-Source: ABdhPJzkwewvDWdyQwvMoAGW7UYt0cSYOWDv+AsxY7k56dVo9nzTd3UgPQupKpyketYASP9JGP8YHg==
X-Received: by 2002:a05:6402:487:: with SMTP id k7mr17432002edv.315.1623684362472;
        Mon, 14 Jun 2021 08:26:02 -0700 (PDT)
Received: from localhost ([2a02:768:2307:40d6:f666:9af6:3fed:e53b])
        by smtp.gmail.com with ESMTPSA id u21sm7444151ejm.89.2021.06.14.08.26.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jun 2021 08:26:02 -0700 (PDT)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 13/33] arm64: zynqmp: Wire DP and DPDMA for dc1/dc4
Date:   Mon, 14 Jun 2021 17:25:21 +0200
Message-Id: <dbbd212bcc587e835d6df2f91622f5baa124bff5.1623684253.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1623684253.git.michal.simek@xilinx.com>
References: <cover.1623684253.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable Display Port and Display Port DMA for zc1751 dc1 and dc4.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v2: None

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
2.32.0

