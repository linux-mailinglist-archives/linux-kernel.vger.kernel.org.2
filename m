Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5157A3AD1EC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 20:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236247AbhFRSPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 14:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235139AbhFRSPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 14:15:40 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D1F5C06175F;
        Fri, 18 Jun 2021 11:13:29 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id y7so11641680wrh.7;
        Fri, 18 Jun 2021 11:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FRadAAJthazKXCs3EEyrRLqIIy1SFHZ81iHPWgmnJRI=;
        b=ny3LB6aXzm8w8C3+A9jf74tf+BJ986neHs79X76TCRusy5yLSp0LO3EWdBMg0srLNh
         KIeluN/0svlz2LiKKVdBMwWQ2tyMAriywQiW9cqmW/LaGjqjtfbb5d9ECq2MWH2UpXmA
         mE6DQTzTQIrkOc82FAufn5lZ0UHmzBzzD1yoHZVQcKa45Wx/8lkFLyAy0o/QBW0MQVj0
         myGns/y4E4h/zzLtvcglLgvzg/Hz2drPsNPJpYYhgYi86j3gEAvx12/a7cnDoZUI+2bT
         n013PLal7MkOMd3BP6gE7OervN1873OvazXnpI1urafITd3UmANw62uMjEBfKxdlGmwt
         jWSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FRadAAJthazKXCs3EEyrRLqIIy1SFHZ81iHPWgmnJRI=;
        b=I0gg4u+OrJkXftvpua79qkrNud/zEy75k5H5/H+YgH1C9Kun11Ra0OgCOaJok8EuQa
         1UlzA1ywR1r4WfI8+qauAeWfLvQfOdhQiZF3QlYeX9aiDjDEwkGlM7geu2kk20dTD6Zr
         fZfrgoZEbEbQSV8qAqrJp9aKw6PTCPBMKMs+c9mxx7Hxq61us72rqlERftok1cDgefEs
         cXZED29NNs9RnmdFiLMIIthYn5gHD1+Q0I7LaxdShNzuIVr+AvkxxwV2Kgws8e/B3XZ2
         wLvSoQZKAlre8SVxKLhWzf38r4+WniDxmxmvac+mYzFxzxJPqPw5jyeRkNstXSoF7H05
         T0Cw==
X-Gm-Message-State: AOAM533HlWtET3mE5LsljYWpGJAnWVNoYwP6oYZw+5piCkIltGN35XMz
        ROk8O5x4t4MHzsvD7YybmA==
X-Google-Smtp-Source: ABdhPJxwYQRQMqECTGWplAPGQubZuPc+DAoMbIBgAWiqVlg7kAw1Gi3FbNatZS9UZrU2FM6mBdz28w==
X-Received: by 2002:adf:d4cc:: with SMTP id w12mr13871170wrk.216.1624040007816;
        Fri, 18 Jun 2021 11:13:27 -0700 (PDT)
Received: from localhost.localdomain (ip5b434b8b.dynamic.kabel-deutschland.de. [91.67.75.139])
        by smtp.googlemail.com with ESMTPSA id l10sm9306782wrv.82.2021.06.18.11.13.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 11:13:27 -0700 (PDT)
From:   Alex Bee <knaerzche@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>
Cc:     Johan Jonker <jbx6244@gmail.com>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alex Bee <knaerzche@gmail.com>
Subject: [PATCH v2 5/5] arm64: dts: rockchip: add SPDIF node for ROCK Pi 4
Date:   Fri, 18 Jun 2021 20:12:56 +0200
Message-Id: <20210618181256.27992-6-knaerzche@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210618181256.27992-1-knaerzche@gmail.com>
References: <20210618181256.27992-1-knaerzche@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a SPDIF audio-graph-card to ROCK Pi 4 device tree.

It's not enabled by default since all dma channels are used by
the (already) enabled i2s0/1/2 and the pin is muxed with GPIO4_C5
which might be in use already.
If enabled SPDIF_TX will be available at pin #15.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
 .../boot/dts/rockchip/rk3399-rock-pi-4.dtsi   | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
index 80925a58e470..b5b8a79116fd 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
@@ -42,6 +42,23 @@ sound {
 		dais = <&i2s0_p0>;
 	};
 
+	sound-dit {
+		compatible = "audio-graph-card";
+		label = "SPDIF";
+		dais = <&spdif_p0>;
+	};
+
+	spdif-dit {
+		compatible = "linux,spdif-dit";
+		#sound-dai-cells = <0>;
+
+		port {
+			dit_p0_0: endpoint {
+				remote-endpoint = <&spdif_p0_0>;
+			};
+		};
+	};
+
 	vcc12v_dcin: dc-12v {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc12v_dcin";
@@ -632,6 +649,15 @@ &sdhci {
 	status = "okay";
 };
 
+&spdif {
+
+	spdif_p0: port {
+		spdif_p0_0: endpoint {
+			remote-endpoint = <&dit_p0_0>;
+		};
+	};
+};
+
 &tcphy0 {
 	status = "okay";
 };
-- 
2.27.0

