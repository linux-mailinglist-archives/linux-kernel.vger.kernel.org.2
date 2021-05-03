Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 149BB371758
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 16:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbhECPAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 11:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbhECPAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 11:00:46 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 330BEC06174A;
        Mon,  3 May 2021 07:59:53 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id fa21-20020a17090af0d5b0290157eb6b590fso2161453pjb.5;
        Mon, 03 May 2021 07:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=foGD+UCkz7Gx5A7kDlgCTKzfxYofNvrE9AjIykOb+dM=;
        b=gNB6h2Ap4hHvzBGd10AjeCOnogWQHcm3Aga62eNNzyajt/Gcf7MrukQXFhGU2SoDS3
         +1sDPlD+GKF/wC0a6UlAWGTytM270cBghOHzlvIKEUd7dzXcqO9Bp4iAfc2taG58R8Lk
         e2mYHg6qTdLGBu5kgfrXI2YDENFTOM7OaEmAeOJsieu4WtramW+a8XwdpsSroXDXv1PP
         KsWmDEr4FKwf1Kbb7duxeMaQEsHV+MXC4iKeZSdkymdWAAgL094T2aR6RGk8WWslC1Zh
         1r/iqOYr0KcxVozQTEihP7RlD88lksKzZbF6xbLpU7rL6oqnrBtlDV6R+PR0xNjdlujm
         K6+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=foGD+UCkz7Gx5A7kDlgCTKzfxYofNvrE9AjIykOb+dM=;
        b=VTRXwkFjVtljZ52Er8WXWcDvg4VNC2GFHhpHAzgBy0nJ5pBZok5Lz1/ixGsNzk+hLO
         pMsb+M54nO59BubIdWPzOrc7IaLGL84KK1SeVOvdjt+1vX5MItCzagneKOqkjp/vp3n2
         imhiECn1t/+Y1JD+sutV8Rw7TSD3hTa7F9nIR+n0ENa7m1HCQvHc43uPMZ9X1yZvflKz
         LVntm8vWdkPZw2BXAN1p18Mhezvlzc5yYGG74xHvIQgVOWpp2iUoMRLnIU63JWgs0Rq8
         DmbDs39mGRNlg7i8hbwk142fK1CM58ZubhVfQ/PFWgeJR3NHfUrFRrNlY1TFXStM3u5t
         8uzQ==
X-Gm-Message-State: AOAM530/Y52qclKetSBy+uLW8KoqzYNxxu+jDvhHZfQ7KWz7UYAvnwUr
        AVyx8hGAmT0z9tEc1JemiUfkIq2Usik=
X-Google-Smtp-Source: ABdhPJxzKb+8mI0OgGltd9yXCBGE6i4s0TGA3Z151qYG33TBAevm0epGCSA66NDgtau+fg7ikxMw6Q==
X-Received: by 2002:a17:902:eb14:b029:ed:6fc3:a42c with SMTP id l20-20020a170902eb14b02900ed6fc3a42cmr20569864plb.26.1620053992519;
        Mon, 03 May 2021 07:59:52 -0700 (PDT)
Received: from archl-on2.. ([103.51.75.154])
        by smtp.gmail.com with ESMTPSA id k38sm3593983pgi.73.2021.05.03.07.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 07:59:52 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Anand Moon <linux.amoon@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCHv1 6/9] arm64: dts: amlogic: Add audio power domain for sm1 SoC
Date:   Mon,  3 May 2021 14:54:39 +0000
Message-Id: <20210503145503.1477-7-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210503145503.1477-1-linux.amoon@gmail.com>
References: <20210503145503.1477-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add audio power domain id for hdmi on sm1 sbc to enable
audio power domain via "pwrc" controller.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi | 1 +
 arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi b/arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi
index d14716b3d0f1..b16a9a2b6cc4 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi
@@ -174,6 +174,7 @@ sound {
 		assigned-clock-rates = <294912000>,
 				       <270950400>,
 				       <393216000>;
+		power-domains = <&pwrc PWRC_SM1_AUDIO_ID>;
 		status = "okay";
 
 		dai-link-0 {
diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts
index 2194a778973f..0ca72b000105 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts
@@ -256,6 +256,7 @@ sound {
 		assigned-clock-rates = <294912000>,
 				       <270950400>,
 				       <393216000>;
+		power-domains = <&pwrc PWRC_SM1_AUDIO_ID>;
 		status = "okay";
 
 		dai-link-0 {
-- 
2.31.1

