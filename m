Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3853A6A4F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 17:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233144AbhFNPa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 11:30:26 -0400
Received: from mail-ej1-f45.google.com ([209.85.218.45]:39499 "EHLO
        mail-ej1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233733AbhFNP3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 11:29:12 -0400
Received: by mail-ej1-f45.google.com with SMTP id l1so17270401ejb.6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 08:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gllPyzZeEX/vDyJ3iT0Ol5hJ7mGlkFSmcymYGuLNAuI=;
        b=1QJiidPhXWjW0PtK0xSmoO/ecIdUmyct1tJx1dAQlHPYvRrsgevszxF0GO6pXsw5Ky
         trMAinGt3QH52kPjU1fDwEj6EaqGA1TNTx4+pKhvUIGmNaPHAf4MvKllnVVIxl0EDiLP
         /Udnq0Aa4zQMtPIzlHgDQCHOr5ier5GGslQfRap2nJRdRWexlPaT/raeoWDevJEKv0aK
         oQijS9ZGBdzS0Qjq3ybHN+RzC+jLJ5ZRJ7McAcyLHy0LFV/TgHzp8YQ0mUxPn3F6vkA4
         t0Csfebtyisn8ei2o4rRbvIRvtM2ib3cdpMQEjBPmy1QbKZv4aGhbwrTDDARqhZjfkY2
         OPgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=gllPyzZeEX/vDyJ3iT0Ol5hJ7mGlkFSmcymYGuLNAuI=;
        b=BQtMPalX6xO9KnJHJrI2VGA5S3qgNgilOPKG0mTLZ6rI3C8VbYv3dYjYykU3xU5FfS
         9Z0InigutReSkK6jU0F2ZIBw/y1VUBNGxGtlER+6l00O707QVd+Mk+yJPECzSplDHFMg
         ytf0kFyfhQDsg2sQX2JQSrKCBDJ4YXgPN4Hn+22WG3EiUcIYli/vHZWXTIi9p6fhcZ8+
         2c8cxWiRXyr3Tc0cxRC4gibjDfDE76yYKd8vy6VVCewM6Dqb19eUiqnJg5iW5D1cULzP
         xIjelzW5SKWIrMqyHzYKkuUxrS8VlzNOPEt8uSvLCMGNGyDbycpz1WCe13m+T9zoBmTv
         /r7Q==
X-Gm-Message-State: AOAM530S1IMQbo4+McQhZBNBYism3cwWkUPYl24g0lqpCsXHp4xon44f
        j4GBL2NeUOOo0aqAtlcYG9pVOjeADaTu0cNw
X-Google-Smtp-Source: ABdhPJzE5n0YS5cnGm1aFvZPzqx+Hdoc8adk6XXIUGJ6Aa63Oa7GqiS5Ly5TcixBrmgLEP8YikPOOg==
X-Received: by 2002:a17:907:98ae:: with SMTP id ju14mr15738417ejc.173.1623684367284;
        Mon, 14 Jun 2021 08:26:07 -0700 (PDT)
Received: from localhost ([2a02:768:2307:40d6:f666:9af6:3fed:e53b])
        by smtp.gmail.com with ESMTPSA id y25sm9102666edt.17.2021.06.14.08.26.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jun 2021 08:26:06 -0700 (PDT)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 16/33] arm64: zynqmp: Move clock node to zynqmp-clk-ccf.dtsi
Date:   Mon, 14 Jun 2021 17:25:24 +0200
Message-Id: <48bfd8cf0de4d10b9c4d745218595f28954f70d5.1623684253.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1623684253.git.michal.simek@xilinx.com>
References: <cover.1623684253.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using clock firmware driver is not the only one option how to configure
clock. In past fixed clocks were also used and that configuration is still
valid that's why move clock firmware node to the same file where zynqmp_clk
references are used.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v2: None

 arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi | 13 ++++++++++++-
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi         | 15 ---------------
 2 files changed, 12 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
index cf5295224750..1e0b1bca7c94 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
@@ -2,7 +2,7 @@
 /*
  * Clock specification for Xilinx ZynqMP
  *
- * (C) Copyright 2017 - 2019, Xilinx, Inc.
+ * (C) Copyright 2017 - 2021, Xilinx, Inc.
  *
  * Michal Simek <michal.simek@xilinx.com>
  */
@@ -40,6 +40,17 @@ aux_ref_clk: aux_ref_clk {
 	};
 };
 
+&zynqmp_firmware {
+	zynqmp_clk: clock-controller {
+		#clock-cells = <1>;
+		compatible = "xlnx,zynqmp-clk";
+		clocks = <&pss_ref_clk>, <&video_clk>, <&pss_alt_ref_clk>,
+			 <&aux_ref_clk>, <&gt_crx_ref_clk>;
+		clock-names = "pss_ref_clk", "video_clk", "pss_alt_ref_clk",
+			      "aux_ref_clk", "gt_crx_ref_clk";
+	};
+};
+
 &can0 {
 	clocks = <&zynqmp_clk CAN0_REF>, <&zynqmp_clk LPD_LSBUS>;
 };
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index 3fa0517cfd98..bd3f0d456ca4 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -156,21 +156,6 @@ zynqmp_power: zynqmp-power {
 				mbox-names = "tx", "rx";
 			};
 
-			zynqmp_clk: clock-controller {
-				#clock-cells = <1>;
-				compatible = "xlnx,zynqmp-clk";
-				clocks = <&pss_ref_clk>,
-					 <&video_clk>,
-					 <&pss_alt_ref_clk>,
-					 <&aux_ref_clk>,
-					 <&gt_crx_ref_clk>;
-				clock-names = "pss_ref_clk",
-					      "video_clk",
-					      "pss_alt_ref_clk",
-					      "aux_ref_clk",
-					      "gt_crx_ref_clk";
-			};
-
 			nvmem_firmware {
 				compatible = "xlnx,zynqmp-nvmem-fw";
 				#address-cells = <1>;
-- 
2.32.0

