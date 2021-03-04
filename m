Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7668632D943
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 19:07:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233293AbhCDSGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 13:06:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232910AbhCDSFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 13:05:42 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E844C0613D7
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 10:04:30 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id jx13so7088623pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 10:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7NL7Y/1snwKGBiV/s0r4gaXgxf3olaiDdxdhFVYX9Hk=;
        b=MMCreVH+kcPeiQC0v5Sf+NUgzZepGQS7mPYJpHPOYsWFNrtE7WTBQhwLBcab5Hf8Tg
         H5Oh0LJgY6fz7wkAJN9eIaLer8U7WXkersF8uATP+NNv8ZS86QRSLTyoOzAaJqYSjvmx
         6tj3WMonYL4QDtlwU9+rCEzd+wM3pCgQXaDMo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7NL7Y/1snwKGBiV/s0r4gaXgxf3olaiDdxdhFVYX9Hk=;
        b=XujyZwnblJsAnp7fK1jLE8TzIJLreLhHHxbBmHO4S4wqVEcdJG7RbUJi5RZ7nk+68H
         T2faairWwlD1q+w0KzXGpBYK4pkelKXiD6g4Xla37Idw8QE3N4iZv5zsKgW9jJ3ttXkO
         RJ6W5ykIc3fygf94cV5fVHCLKIVPaQLWat/C9K9drvzUs1+0v3d1T9rwgjwfxbBUlFPd
         bSBcoJ3HAlNDbt/2P0N7AKXd1OSi+SwqMd+JhEv+Q2WCjqDVsNdhZlbK1tu2LOCblIRi
         ZERKnjsWKe4+HuIAkkUfwax5iWGYNqRWK2Xzkc6li5vxQ0WvFSsYBT/ysZ0RzRsiyWEI
         /r/A==
X-Gm-Message-State: AOAM531JzmreudvRRHeUYAVsCuaKc1u6aNzJGlizDkonnyNMz29Z7iEJ
        OmX6xYfODFFakue9iLu/9sCv2w==
X-Google-Smtp-Source: ABdhPJzM9tJ/NPdmkUEQUMkwwpvYOohTbrotYFCkxpiThMe4UHc4EGDnYHfMaZE0tABhBYhN+XxhMA==
X-Received: by 2002:a17:90a:bc06:: with SMTP id w6mr5648346pjr.44.1614881069998;
        Thu, 04 Mar 2021 10:04:29 -0800 (PST)
Received: from localhost ([2620:15c:202:1:69fe:a9f8:ca53:af2b])
        by smtp.gmail.com with UTF8SMTPSA id b22sm89045pfo.23.2021.03.04.10.04.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Mar 2021 10:04:29 -0800 (PST)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH 3/4] arm64: dts: qcom: sc7180: pompom: Disable charger thermal zone for rev1 and rev2
Date:   Thu,  4 Mar 2021 10:04:14 -0800
Message-Id: <20210304100341.3.I4138c3edee23d1efa637eef51e841d9d2e266659@changeid>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
In-Reply-To: <20210304180415.1531430-1-mka@chromium.org>
References: <20210304180415.1531430-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pompom rev1 and rev2 are stuffed with a 47k NTC as thermistor for the
charger temperature which currently isn't supported by the PM6150 ADC
driver. Disable the charger thermal zone to avoid the use of bogus
temperature values.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---

 arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r1.dts | 9 +++++++++
 arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r2.dts | 9 +++++++++
 2 files changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r1.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r1.dts
index e720e7bd0d70..bc6574e446a9 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r1.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r1.dts
@@ -14,6 +14,15 @@ / {
 	compatible = "google,pompom-rev1", "qcom,sc7180";
 };
 
+/*
+ * Pompom rev1 is stuffed with a 47k NTC as charger thermistor which currently
+ * is not supported by the PM6150 ADC driver. Disable the charger thermal zone
+ * to avoid using bogus temperature values.
+ */
+&charger_thermal {
+	status = "disabled";
+};
+
 &pp3300_hub {
 	/* pp3300_l7c is used to power the USB hub */
 	/delete-property/regulator-always-on;
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r2.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r2.dts
index 2b2bd906321d..779c90ed35e4 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r2.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r2.dts
@@ -14,6 +14,15 @@ / {
 	compatible = "google,pompom-rev2", "qcom,sc7180";
 };
 
+/*
+ * Pompom rev2 is stuffed with a 47k NTC as charger thermistor which currently
+ * is not supported by the PM6150 ADC driver. Disable the charger thermal zone
+ * to avoid using bogus temperature values.
+ */
+&charger_thermal {
+	status = "disabled";
+};
+
 &keyboard_controller {
 	function-row-physmap = <
 		MATRIX_KEY(0x00, 0x02, 0)	/* T1 */
-- 
2.30.1.766.gb4fecdf3b7-goog

