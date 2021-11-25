Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D988B45D805
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 11:12:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354605AbhKYKPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 05:15:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbhKYKNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 05:13:19 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 728DAC0613F4;
        Thu, 25 Nov 2021 02:09:32 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id r8so10382786wra.7;
        Thu, 25 Nov 2021 02:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sonVc1z4s9yp3qxr+30Ehdj21m5HXG+GbXci1EkRyd0=;
        b=hwSRl65sCjY5p6Ah68cgEhOn5lyv3p5q0Ihu2PGJCQ8QQLD1TREGoM9k4Vod5IpK4+
         v4UurAfVX/1ESHnGkeiZ0juIiGePZJD0cUCRHOCsVlDJOwGnJNyVA7yc9MX/MFE0vf+d
         1Z+n8TCef3/M2CVpLTqQEK5gz+0sfaB2/sFq/vmu8aOK+k+FKP++udq/wgg11dbe1N7J
         kzPOkbaRuOdBTYvNtgqT2Q1kdWArEUSZWbPyjpd9WScUz6nNRypAmeoy2CmzT0WBj2gG
         FvqwmSWeFqLiOtIdCCfPBZ+IXz9eHUGR9bkJarMRJInpsA1Wf43QZ28Rh1y6D74gEkio
         BWdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sonVc1z4s9yp3qxr+30Ehdj21m5HXG+GbXci1EkRyd0=;
        b=JBbnFY4AcS4mGwAO93V5txT6lzCVHZ9E2PlGyy7jTWGArWrq0R05bvcwERXSXRPafk
         i0Ij+ynVapP37qE+UWpzOM0lUQoSXKWjDpi5JgtqBkdBvwmc6MTuXUT1Q9Btzeks+P2S
         8wnSq67CJJ0VVl0LsJIo8CWz95oA+LPMUzpGQGBrHxKerDIThcpPb30+Oao3oOawtK+o
         b+L5lT8SgJD5DRFCMoMEc6Y0KJartghZBvcf7FJ4BuY3BIOkxMrsjGsM3sFgcONHa3Xr
         /r6CXB+mWjEldMkV5+6rPyfCBVsO3eHVFlVRN/z65dB4KijxSIoqVbcizXSUevCc8V1O
         fMJw==
X-Gm-Message-State: AOAM533HLfLH2UzEXKBaWB6XR3xT0fw0fFnPcIEHpsxkgQLrmmleUoU6
        dZRvFPMZQahp/RJAqebj+vA=
X-Google-Smtp-Source: ABdhPJz7Sq1cO0e4VX/vnA//UUtpVjsWfZx/+npu6v564qfgpY05nOs4hhGcU62Dfts5NH7unWsh+Q==
X-Received: by 2002:adf:ee0c:: with SMTP id y12mr5105453wrn.82.1637834971101;
        Thu, 25 Nov 2021 02:09:31 -0800 (PST)
Received: from localhost.localdomain (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id l7sm2903533wry.86.2021.11.25.02.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 02:09:30 -0800 (PST)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm64: dts: rockchip: Enable HDMI audio on Quartz64 A
Date:   Thu, 25 Nov 2021 11:08:35 +0100
Message-Id: <20211125100836.423808-3-frattaroli.nicolas@gmail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211125100836.423808-1-frattaroli.nicolas@gmail.com>
References: <20211125100836.423808-1-frattaroli.nicolas@gmail.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This enables the i2s0 controller and the hdmi-sound node on
the PINE64 Quartz64 Model A single-board computer.

Signed-off-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
index a4453c82b03d..0598510dce58 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
@@ -215,6 +215,10 @@ &hdmi_in_vp0 {
 	status = "okay";
 };
 
+&hdmi_sound {
+	status = "okay";
+};
+
 &gpu {
 	mali-supply = <&vdd_gpu>;
 	status = "okay";
@@ -444,6 +448,10 @@ regulator-state-mem {
 	};
 };
 
+&i2s0_8ch {
+	status = "okay";
+};
+
 &i2s1_8ch {
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2s1m0_sclktx
-- 
2.34.0

