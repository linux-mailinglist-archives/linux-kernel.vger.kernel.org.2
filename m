Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F29203258CB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 22:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbhBYVh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 16:37:59 -0500
Received: from relay04.th.seeweb.it ([5.144.164.165]:50913 "EHLO
        relay04.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234109AbhBYVhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 16:37:03 -0500
Received: from localhost.localdomain (abab236.neoplus.adsl.tpnet.pl [83.6.165.236])
        by m-r1.th.seeweb.it (Postfix) with ESMTPA id B9DE8201A9;
        Thu, 25 Feb 2021 22:36:12 +0100 (CET)
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
To:     phone-devel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] iio: qcom-spmi-vadc: Add definitions for USB DP/DM VADCs
Date:   Thu, 25 Feb 2021 22:36:05 +0100
Message-Id: <20210225213605.117201-2-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210225213605.117201-1-konrad.dybcio@somainline.org>
References: <20210225213605.117201-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>

Some SoCs do have a USB DP/DM ADC at 0x43, 0x44.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 include/dt-bindings/iio/qcom,spmi-vadc.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/dt-bindings/iio/qcom,spmi-vadc.h b/include/dt-bindings/iio/qcom,spmi-vadc.h
index 08adfe25964c..c7bb9ef1f9ed 100644
--- a/include/dt-bindings/iio/qcom,spmi-vadc.h
+++ b/include/dt-bindings/iio/qcom,spmi-vadc.h
@@ -72,6 +72,9 @@
 #define VADC_AMUX_PU2				0x3b
 #define VADC_LR_MUX3_BUF_XO_THERM		0x3c
 
+#define VADC_USB_DP				0x43
+#define VADC_USB_DM				0x44
+
 #define VADC_LR_MUX1_PU1_BAT_THERM		0x70
 #define VADC_LR_MUX2_PU1_BAT_ID			0x71
 #define VADC_LR_MUX3_PU1_XO_THERM		0x72
-- 
2.30.1

