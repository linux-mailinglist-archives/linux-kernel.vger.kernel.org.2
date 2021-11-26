Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F21745EEE1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 14:10:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245649AbhKZNNn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 08:13:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240054AbhKZNLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 08:11:31 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAD02C0613B1;
        Fri, 26 Nov 2021 04:27:45 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id c4so18279557wrd.9;
        Fri, 26 Nov 2021 04:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sonVc1z4s9yp3qxr+30Ehdj21m5HXG+GbXci1EkRyd0=;
        b=Uqz80p3L8NEW/rbj1SDrZzbA7hcMP2L9VMWdr3x9ZaTGxvm6/h532VejkDZJPlaAno
         f9MgLrnbbyUWAylerTMM7saV6+1chfNDltqsTZWL0wyXH7YX6Uj+onUEQVG7+hYQNTPb
         GZUgCt+lH7MbDmm7GAYW8QvcNI44kCvdKG+Rw7dOOvGi3BDUV10pCr/3Z4/6f7i0uuh1
         oV7aAfO1MgsgoS+G00jeqDCKGb87JUqRvZNLMzj46ISLjjZWjP13qlsS9RB0TDuPamlS
         GBjCYtoP2HyAbfkEbxF3oO2wn42N5FMqsv61cQMyTzluZwrOdmnZDmYb7XW1YXeJaTOh
         KKGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sonVc1z4s9yp3qxr+30Ehdj21m5HXG+GbXci1EkRyd0=;
        b=S46x9msqtFNqqmTODkjhVjMStXLTrx8EOTLsbMcvgzh7a+qKO652Z27NRqi3yoe6/n
         0TFAt1ey8/CrrV8nbObWfFBUuE2LrxQZNu0/RILkPbrTHuAV0Q+G2WI1ed451UnEN+1a
         FcjMVzBOwnmUkQaaPzCwdgNMv4OprevIMBDgJnlB7DR6PK+HBpPMNFT22EHXh5NfY+eQ
         BZe7njUplIavvnwhR4HqQJo3TdaQc1OdDleC2d2BFE2fnJTNOg9HtmgFYgA2UgxHYmYW
         D2Aa1MSLJ91JKOp+clyVNeGtIaEaWLN1P7l90H6MPCrsI0sK/JG0gLaXYuoFgICpIShR
         885Q==
X-Gm-Message-State: AOAM531jhKqUF5vt373syE4hx1+LNje+Xw7Wylif2tlzRvllocTDFxQX
        NGt0SsFCHpUZ33AtAb0WG3tHGPn17fg=
X-Google-Smtp-Source: ABdhPJxLoAiEsj9xkUs1FxX2QVzAhJB9SOnP8TF2FqFWAPqf9XSvRl5JWt+sb6SxrSPe1b7EK/4RNA==
X-Received: by 2002:adf:e391:: with SMTP id e17mr13589765wrm.613.1637929664475;
        Fri, 26 Nov 2021 04:27:44 -0800 (PST)
Received: from localhost.localdomain (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id l7sm6821130wry.86.2021.11.26.04.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Nov 2021 04:27:44 -0800 (PST)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] arm64: dts: rockchip: Enable HDMI audio on Quartz64 A
Date:   Fri, 26 Nov 2021 13:27:18 +0100
Message-Id: <20211126122718.631506-3-frattaroli.nicolas@gmail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211126122718.631506-1-frattaroli.nicolas@gmail.com>
References: <20211126122718.631506-1-frattaroli.nicolas@gmail.com>
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

