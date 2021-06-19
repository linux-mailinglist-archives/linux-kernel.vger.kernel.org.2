Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D54E3AD9F1
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jun 2021 14:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234045AbhFSMTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Jun 2021 08:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbhFSMS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jun 2021 08:18:59 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F40EC061574;
        Sat, 19 Jun 2021 05:16:48 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id e22so10331558wrc.1;
        Sat, 19 Jun 2021 05:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DQe8YQsStcqk1cD1S28+TTHEdxD2TLqNRW/Z4azWeuk=;
        b=YEGx+e6GRacfbyS8VMptMWtiVxrRFZhzyco6ZXWAMue5SOAHjKrRthBCCiJkdlGhmk
         9EpFsgPox075qb3KUMBAEgZV52akpFcqSpjIBvQN2LSy5b+Z6nh3/kwLzNvOL/qxrdFm
         lZaZzJt3NId8knxjman5t1NtXAMbMb+OeZ/tsyLgy/HKVFz9XvSWh4/0/4WcH+dmo3Rw
         wg0qdhvwn/b2xXyxjYGBzH91Br22PSCvqvTgW2rvQ+CfRvMK2vNCOLZ/1ELtUoQPZvls
         Er9zIctbuwgH2y9XWK0Dee/0z9wIwq5D5wxRTtPJw7/TW1WA2PO3w5ErtO7Rqcllw31V
         JC5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DQe8YQsStcqk1cD1S28+TTHEdxD2TLqNRW/Z4azWeuk=;
        b=LYyfQj7hwviDWOQPKUD+unMWI9oUHvqdYh4TIdDfqHalDmH7acUbZGJ9p+WmMjZPZS
         4pFOI6thS3x5wM9LA7gdvWeccvfw1gcrisMZorzS/WWNDM8ji3PF9RPQhM2RKYjqDQVw
         VHzVKMe7o9EiwRca5KojTkh+1sQc54dpl2Ru42iJ3EU7QRzUFLi1SJkoto7DK+gUTx9P
         qFLTs/o9KF8mPYDKpiQjEaqEJ/xrGLTjRN48njNbSGRErkzmyfQe3s8JK9bjGwZAEd3E
         +qu1raqHQOCSXnlRROKH6iQpGxV5CVqID8iZfwL5MSwHBTPARwXZhkP+Oe4kWYD7HhZv
         E3Dw==
X-Gm-Message-State: AOAM530WTtmU4WAd1x3otGhY9zq7UDuBhV5z4x2DamqVfKlPYhg86dW6
        AwWmn5CoSKs8wx4OXWzVeg==
X-Google-Smtp-Source: ABdhPJzKu0kW9K0mVhxN6vSOZcgtByR6/WHrgGG9wKhpU4Qv7ttMhuYoZL5xGpry0bRusw0fSaZHHQ==
X-Received: by 2002:adf:9bd0:: with SMTP id e16mr17497735wrc.392.1624105007127;
        Sat, 19 Jun 2021 05:16:47 -0700 (PDT)
Received: from localhost.localdomain (ip5b434b8b.dynamic.kabel-deutschland.de. [91.67.75.139])
        by smtp.googlemail.com with ESMTPSA id f19sm5249790wmc.16.2021.06.19.05.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jun 2021 05:16:46 -0700 (PDT)
From:   Alex Bee <knaerzche@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alex Bee <knaerzche@gmail.com>
Subject: [PATCH] arm64: dts: rockchip: add ir-receiver for rk3399-roc-pc
Date:   Sat, 19 Jun 2021 14:16:42 +0200
Message-Id: <20210619121642.7892-1-knaerzche@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like some other RK3399 boards RK3399-ROC-PC has an ir receiver
connected to pwm3 which can be used as gpio-ir-receiver.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
index 8b27ee4be755..d1aaf8e83391 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
@@ -63,6 +63,13 @@ power {
 		};
 	};
 
+	ir-receiver {
+		compatible = "gpio-ir-receiver";
+		gpios = <&gpio0 RK_PA6 GPIO_ACTIVE_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&ir_int>;
+	};
+
 	leds {
 		compatible = "gpio-leds";
 		pinctrl-names = "default";
@@ -604,6 +611,12 @@ pwr_key_l: pwr-key-l {
 		};
 	};
 
+	ir {
+		ir_int: ir-int {
+			rockchip,pins = <0 RK_PA6 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
 	lcd-panel {
 		lcd_panel_reset: lcd-panel-reset {
 			rockchip,pins = <4 RK_PD5 RK_FUNC_GPIO &pcfg_pull_up>;
-- 
2.27.0

