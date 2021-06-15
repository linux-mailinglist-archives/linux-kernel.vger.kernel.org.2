Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 932B43A8C78
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 01:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbhFOXa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 19:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbhFOXaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 19:30:24 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9F9C06175F
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 16:28:18 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id q20-20020a4a6c140000b029024915d1bd7cso204283ooc.12
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 16:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tzSchQZe56MMqq1z2RSbotrCopwwSz+YGTJ5s6h3T1w=;
        b=P7gJ+yJcok8zyjrDvS5CFSBSmeNfbSk1IpzfHrvvdoRYYTLGsUuELq6pCHSTzt+Ygk
         mmuKyJ8j2tSDgud2KnpeCcRjTLPRMALdTwtodETeGdylwmZ8uBmA8TlnNJJZdeyeOMqD
         SZojpi4ngEdVFybx1dZvnZLyQi1WV1HQD56GCkfLxSy/lUbje43nY7u0WwZSd9j5GZDj
         lOv/M+XJPYFdqmTLnnRDEbHLZx+1tFO/gbS6Ziieqo0yKGmkUiGOabUD2vv65+Jv+cLD
         d/OL41uF0Z6GOMpbNfelqVGKwo2sWATapabrYLtzMxfjGUoxYvwiMkKycb76Gd4YP3wS
         qKhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tzSchQZe56MMqq1z2RSbotrCopwwSz+YGTJ5s6h3T1w=;
        b=db2hsYMXLnvm6crDXidQLwwHVwxG95EY5FtZ2k9UcGtqPPG2PZuQN7ueqTvwxJ2vKS
         DUSOQEWCOn7eNgGnfWNFA71pxOUPnwph4ULXvSBgp2HqOuzi6PqDVV+uRwxmBYCrkxCA
         Ilyr3EHwB3zW4F4h2KnDF6VRpOch2MQi10diY8rWPgHzU1Xu06ElxQUApBgENNR2UIk8
         tBVLzub5bHUBtYpctQHgPNHfvFgFzg23IDRya+8LbYRBqMLIW6N2+3ZJY9ntK/+70OnT
         fAVjr2ppGQWdTdpRvKhKEOLQIefyFU+ShzPW/SYzPKfNzTtvRvAOuSIvmAymnwD1X0sd
         rARA==
X-Gm-Message-State: AOAM531cCNSDHnViTjXEED9MR89ohQVRox9bb8WQMyBubCHmKDcpNCo4
        Jvb9QEgMl1XSRmVZfKi4a2oGsQ==
X-Google-Smtp-Source: ABdhPJykHIn7Udmj5j6l9ma1FDlBT7jKA40R6uo3S1ZfKJmsKdglv5gl2ebMdgL/RTatJSre1WOgZg==
X-Received: by 2002:a4a:ea2b:: with SMTP id y11mr1311357ood.77.1623799697973;
        Tue, 15 Jun 2021 16:28:17 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id u1sm89926ooo.18.2021.06.15.16.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 16:28:17 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Alex Elder <elder@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: sdm850-yoga: Enable IPA
Date:   Tue, 15 Jun 2021 18:28:16 -0500
Message-Id: <20210615232816.835325-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shuffle memory regions to make firmware loading succeed and then enable
the ipa device.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi          | 21 +++++++------------
 .../boot/dts/qcom/sdm850-lenovo-yoga-c630.dts |  5 +++++
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 1796ae8372be..49624eadce84 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -128,28 +128,23 @@ camera_mem: memory@8bf00000 {
 			no-map;
 		};
 
-		ipa_fw_mem: memory@8c400000 {
-			reg = <0 0x8c400000 0 0x10000>;
+		wlan_msa_mem: memory@8c400000 {
+			reg = <0 0x8c400000 0 0x100000>;
 			no-map;
 		};
 
-		ipa_gsi_mem: memory@8c410000 {
-			reg = <0 0x8c410000 0 0x5000>;
+		gpu_mem: memory@8c515000 {
+			reg = <0 0x8c515000 0 0x2000>;
 			no-map;
 		};
 
-		gpu_mem: memory@8c415000 {
-			reg = <0 0x8c415000 0 0x2000>;
+		ipa_fw_mem: memory@8c517000 {
+			reg = <0 0x8c517000 0 0x5a000>;
 			no-map;
 		};
 
-		adsp_mem: memory@8c500000 {
-			reg = <0 0x8c500000 0 0x1a00000>;
-			no-map;
-		};
-
-		wlan_msa_mem: memory@8df00000 {
-			reg = <0 0x8df00000 0 0x100000>;
+		adsp_mem: memory@8c600000 {
+			reg = <0 0x8c600000 0 0x1a00000>;
 			no-map;
 		};
 
diff --git a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
index c2a709a384e9..3eaa42dc3794 100644
--- a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
+++ b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
@@ -415,6 +415,11 @@ ecsh: hid@5c {
 	};
 };
 
+&ipa {
+	status = "okay";
+	memory-region = <&ipa_fw_mem>;
+};
+
 &mdss {
 	status = "okay";
 };
-- 
2.31.0

