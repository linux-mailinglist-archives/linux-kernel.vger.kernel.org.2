Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1AFF42D63C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 11:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbhJNJk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 05:40:27 -0400
Received: from mo-csw-fb1514.securemx.jp ([210.130.202.170]:59444 "EHLO
        mo-csw-fb.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbhJNJk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 05:40:26 -0400
X-Greylist: delayed 349 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Oct 2021 05:40:25 EDT
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1514) id 19E9WWoK005626; Thu, 14 Oct 2021 18:32:33 +0900
Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 19E9WNMT009064; Thu, 14 Oct 2021 18:32:23 +0900
X-Iguazu-Qid: 34tMdwO14c3dprnV7m
X-Iguazu-QSIG: v=2; s=0; t=1634203942; q=34tMdwO14c3dprnV7m; m=sNy+yJgzDWYfVLPQCwTNyi1CpDAX/3yAv0cGj2bA9uk=
Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
        by relay.securemx.jp (mx-mr1512) id 19E9WMis001423
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 14 Oct 2021 18:32:22 +0900
Received: from enc02.toshiba.co.jp (enc02.toshiba.co.jp [61.202.160.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by imx12-a.toshiba.co.jp (Postfix) with ESMTPS id 3825D10013A;
        Thu, 14 Oct 2021 18:32:22 +0900 (JST)
Received: from enc02.toshiba.co.jp (localhost.localdomain [127.0.0.1])
        by enc02.toshiba.co.jp  with ESMTP id 19E9WLDA007778;
        Thu, 14 Oct 2021 18:32:22 +0900
Received: from enc02.toshiba.co.jp.mid_26071066 (localhost.localdomain [127.0.0.1])
        by enc02.toshiba.co.jp  with ESMTP id 19E9RJqc004244;
        Thu, 14 Oct 2021 18:27:19 +0900
X-SA-MID: 26071066
From:   Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
To:     Rob Herring <robh+dt@kernel.org>, nobuhiro1.iwamatsu@toshiba.co.jp
Cc:     punit1.agrawal@toshiba.co.jp, yuji2.ishikawa@toshiba.co.jp,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] arm64: dts: visconti: Add 150MHz fixed clock to TMPV7708 SoC
Date:   Thu, 14 Oct 2021 18:27:01 +0900
X-TSB-HOP: ON
Message-Id: <20211014092703.15251-2-yuji2.ishikawa@toshiba.co.jp>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211014092703.15251-1-yuji2.ishikawa@toshiba.co.jp>
References: <20211014092703.15251-1-yuji2.ishikawa@toshiba.co.jp>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This clock source is referred by baudrate generators of
SPI and I2C devices.

Signed-off-by: Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
---
 arch/arm64/boot/dts/toshiba/tmpv7708.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/toshiba/tmpv7708.dtsi b/arch/arm64/boot/dts/toshiba/tmpv7708.dtsi
index 5db9a012d6fc..01d7ee61ad25 100644
--- a/arch/arm64/boot/dts/toshiba/tmpv7708.dtsi
+++ b/arch/arm64/boot/dts/toshiba/tmpv7708.dtsi
@@ -148,6 +148,13 @@
 		clock-output-names = "clk125mhz";
 	};
 
+	clk150mhz: clk150mhz {
+		compatible = "fixed-clock";
+		clock-frequency = <150000000>;
+		#clock-cells = <0>;
+		clock-output-names = "clk150mhz";
+	};
+
 	clk300mhz: clk300mhz {
 		compatible = "fixed-clock";
 		clock-frequency = <300000000>;
-- 
2.17.1


