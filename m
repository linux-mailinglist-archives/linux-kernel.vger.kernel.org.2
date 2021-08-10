Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 066EE3DEE69
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 14:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236100AbhHCM6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 08:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236045AbhHCM6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 08:58:13 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 030CEC061757
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 05:58:02 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id n12-20020a05600c3b8cb029025a67bbd40aso1704731wms.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 05:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8NrcjQYzDtyHk8CMaCYs9E1o35W+Ea6RJXsjt6BmJ4c=;
        b=EMyERdbj67qsFCzFsfl8c22styN+s3EUwp477aKDZJkb3llMuiHyW3uGM2434EN/y1
         q4QbOTehO0cM7mUdwIO1a1fW4RZqGydPs5J5o42iYMNVG905A5+ne01eZAm91BxgjOuN
         fxjWmfOBS4lipVaQuUo/rsJRszaRrV4MeLjTy4EpIcwDLPWGT6g4J6D8teIHaGXh4SZ5
         qk69nYlBmu3xRRr0vad3PLRWTq8MDu0BOHbBCKpWhi4ZpFarn/L/wNt1GB3TqOjvlbCv
         7eEZwzEa66SGCNm3IyVuMKloHbbQ1Kx2ZIjfwA4rHQ4Y3Zwij3XQnZ6PdwmBF7BCFUMp
         pZqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8NrcjQYzDtyHk8CMaCYs9E1o35W+Ea6RJXsjt6BmJ4c=;
        b=hY9jbF14c1NRMREM3+7HvjxsLw+PYNsqwi1WJKBfNcMZrrThYq9v4HlCWYQg1Fy8rt
         4Y2gzgbWOmZxG0/VWmOjLocsxgqnfjL51Th4yFSRPPdB4wxV1ebUp2JkIAn41I3/VoDo
         zBsg4rqDMkGwIGqUQp+YQ2vAzfOrV0aRgwryzudWqsWCmBXHgJV/q8eAbzf0g4flCO4g
         RhX3JqwVttviqqlvFUj5Ju2GXZ4u1OK3onzK7TbP+rXkGKRC7ixKxPTOvTlrRpSpOfVR
         d+vfvyXThu2ET1NuPnT+6kkvFOIsL9+V0hYop8i5uoEh8koydLYV6LKuI/UXLPkB3kiZ
         nRKA==
X-Gm-Message-State: AOAM530tK6COo9TJNX4CitvQLyDxjK5ZOkyoAGi94/RmtTOpR161MAHi
        5bt3aIhvPhR9e1dVE7AuOl9QVA==
X-Google-Smtp-Source: ABdhPJxPCE7Nzbe1Cxjl5BS7XLK3SlOfpwUZ55tYysw8z2SFZHoqJQYXGFZDs8SUCEATyQysDW4B/Q==
X-Received: by 2002:a1c:1dcf:: with SMTP id d198mr4168314wmd.103.1627995480626;
        Tue, 03 Aug 2021 05:58:00 -0700 (PDT)
Received: from xps7590.fritz.box ([2a02:2454:3e5:b700:a460:c741:f49b:8c7f])
        by smtp.gmail.com with ESMTPSA id g12sm7598172wri.49.2021.08.03.05.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 05:58:00 -0700 (PDT)
From:   Robert Foss <robert.foss@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        vkoul@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Robert Foss <robert.foss@linaro.org>
Subject: [PATCH v1] arm64: dts: qcom: sm8350: Rename GENI serial engine DT node
Date:   Tue,  3 Aug 2021 14:57:56 +0200
Message-Id: <20210803125756.93824-1-robert.foss@linaro.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to conform with downstream and upstream for previous generations
of this hardware, rename dt-node 'qupv3_id_1' to 'qupv3_id_0'.

Fixes: b7e8f433a673 ("arm64: dts: qcom: Add basic devicetree support for SM8350 SoC")
Signed-off-by: Robert Foss <robert.foss@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8350-hdk.dts | 2 +-
 arch/arm64/boot/dts/qcom/sm8350-mtp.dts | 2 +-
 arch/arm64/boot/dts/qcom/sm8350.dtsi    | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8350-hdk.dts b/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
index f23a0cf3f7b7..56093e260ddf 100644
--- a/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
+++ b/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
@@ -219,7 +219,7 @@ &mpss {
 	firmware-name = "qcom/sm8350/modem.mbn";
 };
 
-&qupv3_id_1 {
+&qupv3_id_0 {
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/qcom/sm8350-mtp.dts b/arch/arm64/boot/dts/qcom/sm8350-mtp.dts
index 6ca638b4e321..806a26c8cf11 100644
--- a/arch/arm64/boot/dts/qcom/sm8350-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8350-mtp.dts
@@ -286,7 +286,7 @@ &mpss {
 	firmware-name = "qcom/sm8350/modem.mbn";
 };
 
-&qupv3_id_1 {
+&qupv3_id_0 {
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index 1066b55b43c9..bb673372c6e0 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -454,7 +454,7 @@ ipcc: mailbox@408000 {
 			#mbox-cells = <2>;
 		};
 
-		qupv3_id_1: geniqup@9c0000 {
+		qupv3_id_0: geniqup@9c0000 {
 			compatible = "qcom,geni-se-qup";
 			reg = <0x0 0x009c0000 0x0 0x6000>;
 			clock-names = "m-ahb", "s-ahb";
-- 
2.30.2

