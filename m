Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6297840EB57
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 22:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237030AbhIPUHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 16:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236946AbhIPUHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 16:07:21 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54622C061756
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 13:06:00 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id g184so7258650pgc.6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 13:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C825OJtm+GsMiw0RkquyzXjumHiD8fMhLXCP+cnD56A=;
        b=x12uH75PWv2yZJlJ1u7RjEbR2L7wCjfESWLWNzOFEvBDLAfT3rb9fr70Z6A6Z6Tx5Q
         5e51a7LLT0SCHChzUHm8OhpH7TMT/L/tRBadrT+4phG2S4ZlbqMZQFq+BBhMqFZD1B52
         LNzKRkGyjVKIGQTacRagcrYX9r99ZjYEGexp8hYp+2TOEE3I0Is/W+ql13idrY5kP392
         WJDwfEbrc48LFQbtmucPb9XYNHtl9WeYQGO95FS7EGIOXQIAJfk/Hze8lmzMvovzHpzZ
         C6ibLTDnpZXRDeo1qdeMxThJF336v8VuWY4HvesOhzBpV2LNaTmlZgj/fQWSppksg/e7
         KN2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C825OJtm+GsMiw0RkquyzXjumHiD8fMhLXCP+cnD56A=;
        b=QGDZCPUIl0nHXe0piBvs9waDUUyQpj6dRR8/ib+trFBW3wk9RyhhOMsXwFWnddMVvn
         QvCpWax8UlEXSjat7FKzZUf0YpbNSQ6XRevMxIRhAHlouWEPZwgU3bXxvHBgIyXLpA/A
         VTqjqYwJfJnW9CbHdSReRYjWbCu+HR4cuqfCk1n+HVCtbMQTGrS21B1/YS+lL/dzouX5
         kmY4T9lUkbPtsiQ36KNCXN1v6Awpg3k9a+w26R6L/5e3T8TzOWdpRNwBNdI1PmD4mxRh
         WIhipWjUyZR4FRWOcZjSwIncNegTPPf3PBYzBxsgIuucCSnvxYZQUpyP18nYiIrVFUmJ
         /Qzg==
X-Gm-Message-State: AOAM5332wAFbRm9dfugL43D7zynfy7xijGUstgKhe6hAtfff+l+xHC5r
        QPAuYeMv9ABCRNjN3Alxk5bDTg==
X-Google-Smtp-Source: ABdhPJzJXNLpWvp/YAi+c/sg/mnucACdcnd/GWm+TJH6cXdxMA2wtm3fWmCFcSek7ktIo3cduNaZ/Q==
X-Received: by 2002:a62:2f47:0:b0:43c:11:69ce with SMTP id v68-20020a622f47000000b0043c001169cemr6974646pfv.24.1631822759785;
        Thu, 16 Sep 2021 13:05:59 -0700 (PDT)
Received: from localhost.localdomain ([122.171.196.148])
        by smtp.gmail.com with ESMTPSA id c133sm3800045pfb.39.2021.09.16.13.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 13:05:59 -0700 (PDT)
From:   Amit Pundir <amit.pundir@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>, Alex Elder <elder@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        dt <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] arm64: dts: qcom: sdm850-yoga: Reshuffle IPA memory mappings
Date:   Fri, 17 Sep 2021 01:35:54 +0530
Message-Id: <20210916200554.2434439-1-amit.pundir@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Upstream commit 2e01e0c21459 ("arm64: dts: qcom: sdm850-yoga:
Enable IPA") shuffled reserved memory regions in sdm845.dtsi
to make firmware loading succeed and enable the ipa device on
sdm845-yoga but it broke the other common users of those
memory regions like Xiaomi Pocophone F1.

So this patch effectively revert those upstream commit changes
and move all the relevant changes to sdm850-lenovo-yoga-c630.dts
instead.

Fixes: 2e01e0c21459 ("arm64: dts: qcom: sdm850-yoga: Enable IPA")
Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
---
Smoke tested on PocoF1 and not on Yoga-C630.

 arch/arm64/boot/dts/qcom/sdm845.dtsi          | 21 +++++++-----
 .../boot/dts/qcom/sdm850-lenovo-yoga-c630.dts | 34 +++++++++++++++++++
 2 files changed, 47 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 6d7172e6f4c3..b3b911926184 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -128,23 +128,28 @@ camera_mem: memory@8bf00000 {
 			no-map;
 		};
 
-		wlan_msa_mem: memory@8c400000 {
-			reg = <0 0x8c400000 0 0x100000>;
+		ipa_fw_mem: memory@8c400000 {
+			reg = <0 0x8c400000 0 0x10000>;
 			no-map;
 		};
 
-		gpu_mem: memory@8c515000 {
-			reg = <0 0x8c515000 0 0x2000>;
+		ipa_gsi_mem: memory@8c410000 {
+			reg = <0 0x8c410000 0 0x5000>;
 			no-map;
 		};
 
-		ipa_fw_mem: memory@8c517000 {
-			reg = <0 0x8c517000 0 0x5a000>;
+		gpu_mem: memory@8c415000 {
+			reg = <0 0x8c415000 0 0x2000>;
 			no-map;
 		};
 
-		adsp_mem: memory@8c600000 {
-			reg = <0 0x8c600000 0 0x1a00000>;
+		adsp_mem: memory@8c500000 {
+			reg = <0 0x8c500000 0 0x1a00000>;
+			no-map;
+		};
+
+		wlan_msa_mem: memory@8df00000 {
+			reg = <0 0x8df00000 0 0x100000>;
 			no-map;
 		};
 
diff --git a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
index 385e5029437d..2ba23aa582a1 100644
--- a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
+++ b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
@@ -16,6 +16,17 @@
 #include "sdm850.dtsi"
 #include "pm8998.dtsi"
 
+/*
+ * Update following upstream (sdm845.dtsi) reserved
+ * memory mappings for firmware loading to succeed
+ * and enable the IPA device.
+ */
+/delete-node/ &ipa_fw_mem;
+/delete-node/ &ipa_gsi_mem;
+/delete-node/ &gpu_mem;
+/delete-node/ &adsp_mem;
+/delete-node/ &wlan_msa_mem;
+
 / {
 	model = "Lenovo Yoga C630";
 	compatible = "lenovo,yoga-c630", "qcom,sdm845";
@@ -58,6 +69,29 @@ panel_in_edp: endpoint {
 		};
 	};
 
+	/* Reserved memory changes for IPA */
+	reserved-memory {
+		wlan_msa_mem: memory@8c400000 {
+			reg = <0 0x8c400000 0 0x100000>;
+			no-map;
+		};
+
+		gpu_mem: memory@8c515000 {
+			reg = <0 0x8c515000 0 0x2000>;
+			no-map;
+		};
+
+		ipa_fw_mem: memory@8c517000 {
+			reg = <0 0x8c517000 0 0x5a000>;
+			no-map;
+		};
+
+		adsp_mem: memory@8c600000 {
+			reg = <0 0x8c600000 0 0x1a00000>;
+			no-map;
+		};
+	};
+
 	sn65dsi86_refclk: sn65dsi86-refclk {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
-- 
2.25.1

