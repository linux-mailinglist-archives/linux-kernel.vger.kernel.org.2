Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7B23A6A2F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 17:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233686AbhFNP3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 11:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233580AbhFNP2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 11:28:23 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C11EC061280
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 08:26:05 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id ba2so45273293edb.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 08:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XnI5A9GyUFD9otKRwepb1rslDx5RUfQ5qLlRLVzPwBw=;
        b=0hM6kT7o+SO+ssGW1xOlD3jMzAbZ1I+pc1zzcxeu73jJBZ2kkqfxxckl/Bzn1iXHqC
         m2Mw+7EnFBlBqdb2QUHyj8zyo5esqnsX9BPQ5C7GRnG/Qh/appBNJyoBgUA/cMFx32o+
         7oHvJuT0ZLZnDIPIZKS9QWEwPpvfhlHRWdPbEewkT6N3nGgsKus9fqO3kuGXt/xeEugs
         3W4FRNFEldN9Xhk3XA/VlOaB7OEMaLNhbM+lea3NS2BF3fgyPletUiyqw6LaCeuqe6N9
         kdWV/eQHf6vMFfgfrVZtR3CbwPJMQk1ONpEQVqi+1DezZ6L3khfv6QYCsdMQhi9N0nLi
         VAUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=XnI5A9GyUFD9otKRwepb1rslDx5RUfQ5qLlRLVzPwBw=;
        b=iuZBScaQE7vqWidUoUdSQzVuQcusC1zqN9lF2/kjqKyBL1lpDu8a6x4dEuIkcSo1l3
         Qo4bhMVZ6JqTe4kOQ+0kdN1OtuZf9Fva9RtHwK9sOnMfyyoDLJrVmj7LP5bKF/OHDT7g
         gfc/VJTHi2X8cI41RmwJbSg9GZemA1rm7kiVnaU6B4QWPy7K7TPLggTOxP73X1kAlfLg
         4voRi9Ic87OPK/KXjhYqYgt5EQLinbaAxw1/tDmGxNz3EKtYa+CjievRRbDI1H3x7StM
         Qvwk7a9a68hlNvFD8iSKNEyq/hCT/ypBLW8zG+40tFfNaMYIdFAmRqxJTk5V01I50Fsw
         Fqww==
X-Gm-Message-State: AOAM5336tU623UXhOHaQ81qyMZYj1BJPyarQHnpqXEhDznXdYkNPQseG
        U/TItQnbd0YeZ/fR8A4ltj9Lfl7y2FNI0/rt
X-Google-Smtp-Source: ABdhPJxNRpTAKjuZVKnNUooU3IwKhhXvXyj+G2dUHKrVJ+GMlhx9Uk/ES2wPYpcV7teL4FmrPLKTDg==
X-Received: by 2002:a05:6402:40c3:: with SMTP id z3mr17493467edb.187.1623684363874;
        Mon, 14 Jun 2021 08:26:03 -0700 (PDT)
Received: from localhost ([2a02:768:2307:40d6:f666:9af6:3fed:e53b])
        by smtp.gmail.com with ESMTPSA id h6sm9498068edj.91.2021.06.14.08.26.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jun 2021 08:26:03 -0700 (PDT)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 14/33] arm64: zynqmp: Enable nand driver for dc2 and dc3
Date:   Mon, 14 Jun 2021 17:25:22 +0200
Message-Id: <e103821bdb717132559e780f1a4f4f6fefc95688.1623684253.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1623684253.git.michal.simek@xilinx.com>
References: <cover.1623684253.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add description for nand devices on zc1751 dc2 and dc3 boards.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v2: None

 .../dts/xilinx/zynqmp-zc1751-xm016-dc2.dts    | 26 +++++++++++++++++++
 .../dts/xilinx/zynqmp-zc1751-xm017-dc3.dts    |  9 ++++++-
 2 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts
index 1ac105a82e1b..4b4c19034fe1 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts
@@ -127,6 +127,32 @@ rtc@68 {
 	};
 };
 
+&nand0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_nand0_default>;
+	arasan,has-mdma;
+
+	nand@0 {
+		reg = <0x0>;
+		#address-cells = <0x2>;
+		#size-cells = <0x1>;
+		nand-ecc-mode = "soft";
+		nand-ecc-algo = "bch";
+		nand-rb = <0>;
+		label = "main-storage-0";
+	};
+	nand@1 {
+		reg = <0x1>;
+		#address-cells = <0x2>;
+		#size-cells = <0x1>;
+		nand-ecc-mode = "soft";
+		nand-ecc-algo = "bch";
+		nand-rb = <0>;
+		label = "main-storage-1";
+	};
+};
+
 &pinctrl0 {
 	status = "okay";
 	pinctrl_can0_default: can0-default {
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts
index 4ea6ef5a7f2b..ba7f1f21c579 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts
@@ -2,7 +2,7 @@
 /*
  * dts file for Xilinx ZynqMP zc1751-xm017-dc3
  *
- * (C) Copyright 2016 - 2019, Xilinx, Inc.
+ * (C) Copyright 2016 - 2021, Xilinx, Inc.
  *
  * Michal Simek <michal.simek@xilinx.com>
  */
@@ -107,6 +107,13 @@ &i2c1 {
 	clock-frequency = <400000>;
 };
 
+/* MT29F64G08AECDBJ4-6 */
+&nand0 {
+	status = "okay";
+	arasan,has-mdma;
+	num-cs = <2>;
+};
+
 &rtc {
 	status = "okay";
 };
-- 
2.32.0

