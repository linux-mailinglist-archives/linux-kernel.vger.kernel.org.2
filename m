Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91DDA3A0517
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 22:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235031AbhFHUXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 16:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234251AbhFHUXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 16:23:45 -0400
Received: from m-r2.th.seeweb.it (m-r2.th.seeweb.it [IPv6:2001:4b7a:2000:18::171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6771DC061787
        for <linux-kernel@vger.kernel.org>; Tue,  8 Jun 2021 13:21:52 -0700 (PDT)
Received: from localhost.localdomain (83.6.168.161.neoplus.adsl.tpnet.pl [83.6.168.161])
        by m-r2.th.seeweb.it (Postfix) with ESMTPA id 1FC3A3F3F8;
        Tue,  8 Jun 2021 22:21:48 +0200 (CEST)
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
To:     ~postmarketos/upstreaming@lists.sr.ht
Cc:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/4] arm64: dts: qcom: Add PMI8996 DTSI file
Date:   Tue,  8 Jun 2021 22:21:39 +0200
Message-Id: <20210608202143.247427-1-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PMI8996 is *almost* the same hardware as PMI8994, say for some annoyances:

- Boards equipped with PMI8996 now have to include pmic-id (which wasn't the
case before)

- Different qpnp-ibb-discharge-resistor value (will be addressed after LABIBB
is introduced)

- Different inhibit-derating-ua value (will be addressed after BCL is
introduced)

- Different ramp_up_step value (will be addressed after [if?] QPNP Flash LED
is introduced)

This DTSI is supposed to be included >>ON TOP OF<< pmi8994.dtsi, like this:

-- msm8996-nice-device.dts --
\#include "pmi8994.dtsi"
\#include "pmi8996.dtsi"

or more likely like this:

-- msm8996-some-phone.dts --
\#include "msm8996.dtsi"
...
\#include "pmi8994.dtsi"

-- msm8996-pmi8996-some-phone.dts --
\#include "msm8996-some-phone.dts"
\#include "pmi8996.dtsi"

So that we only have to keep 2 DTs for devices that were shipped with both
ones, instead of what would be three (device base + pmi8994 + pmi8996)

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 arch/arm64/boot/dts/qcom/pmi8996.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/pmi8996.dtsi

diff --git a/arch/arm64/boot/dts/qcom/pmi8996.dtsi b/arch/arm64/boot/dts/qcom/pmi8996.dtsi
new file mode 100644
index 000000000000..31b47209e261
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/pmi8996.dtsi
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2021, Konrad Dybcio <konrad.dybcio@somainline.org>
+ */
+
+ /*
+  * PMI8996 is a slight modification of PMI8994 with
+  * some notable changes, like being the first PMIC
+  * whose the bootloader has to check to continue booting
+  * and a change to a LABIBB parameter.
+  */
+
+/ {
+	qcom,pmic-id = <0x20009 0x10013 0 0>;
+};
-- 
2.31.1

