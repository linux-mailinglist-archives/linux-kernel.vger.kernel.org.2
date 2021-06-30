Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71D423B7E35
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 09:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233213AbhF3Hfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 03:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233172AbhF3Hfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 03:35:50 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F57C061767
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 00:33:21 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id x21-20020a17090aa395b029016e25313bfcso783450pjp.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 00:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S23gVGVcqD7f0fwhKzKVAxR8rv5+89obRLf4D+hN+hE=;
        b=JsQOWA1IUjLa3FWO6Hy/j9CL5yHybWgR/t+DuEdTAQn6HFyHEKwWKQsJ1fRUF1aKhi
         //wQexGMhTMFys9IslVkV+px4sY/hcxKmFNUZeJZ9kqMh/81cqDuFnMjIt+kqVlyIJR1
         j2QvXnO1mtbDkSdQa9Txfnwc9cjr85VjCwU6o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S23gVGVcqD7f0fwhKzKVAxR8rv5+89obRLf4D+hN+hE=;
        b=TH1juyBqeaIRT+Geg15dmz/d6v3ZwhmTpjlzqCbSH/BoRBl3DFCkgRg0rYTX3xIam6
         h58ZvVm+3MZ7y80MmvZ1X3za46esNqeo1M1P3vFbEsSoLeR9/6ACpDWt4gcnJED0qiDD
         +q/0+cmuk7ztx9WxZ4nG54XF1/A0gcBBqhXRhI1x7d0q/En2hXN8/FW1BuCCwSHv1YYI
         twQ8rTDgD44F2EViZS9eFvrwAVoCQIfMiYbUXU3SXFYvlL8cCTthO4WyYl6u/zRJKpuE
         ujNkZI7x5BeL/FBBlcS/yFrfYxGE6gzE//OXfyhjenQkZ9zkgpz2AicQBvNYjzr2rIMG
         YgFQ==
X-Gm-Message-State: AOAM533O6i/h32El49V07Rrli207EQWW6wuVYVyKIvkuwBMYXjPiP+43
        dtgCTMZBlkFzqqODkZhzLfrgPA==
X-Google-Smtp-Source: ABdhPJyMt1I0HHKMGn1W7t71MGIp14zkTdXt0kIvh9nOUAWZINKJW4akDkCQEjnawxoDuWVC/fxxeQ==
X-Received: by 2002:a17:90a:7641:: with SMTP id s1mr38258826pjl.84.1625038401283;
        Wed, 30 Jun 2021 00:33:21 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:2f49:a14d:fd5:cbd3])
        by smtp.gmail.com with ESMTPSA id v1sm20724909pjg.19.2021.06.30.00.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 00:33:20 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>, zhiyong.tao@mediatek.com
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm64: dts: mt8183: kukui: use generic pin configs for i2c pins
Date:   Wed, 30 Jun 2021 15:33:12 +0800
Message-Id: <20210630073311.2177374-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mt8183 i2c pins don't support PUPD register, so change to use generic
pin configs instead of let it fail and fallback.

Fixes: cd894e274b74 ("arm64: dts: mt8183: Add krane-sku176 board")
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
---
 arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
index ae549d55a94fc..69dc04c3f7fff 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
@@ -426,7 +426,7 @@ i2c0_pins: i2c0 {
 		pins_bus {
 			pinmux = <PINMUX_GPIO82__FUNC_SDA0>,
 				 <PINMUX_GPIO83__FUNC_SCL0>;
-			mediatek,pull-up-adv = <3>;
+			bias-pull-up;
 			mediatek,drive-strength-adv = <00>;
 		};
 	};
@@ -435,7 +435,7 @@ i2c1_pins: i2c1 {
 		pins_bus {
 			pinmux = <PINMUX_GPIO81__FUNC_SDA1>,
 				 <PINMUX_GPIO84__FUNC_SCL1>;
-			mediatek,pull-up-adv = <3>;
+			bias-pull-up;
 			mediatek,drive-strength-adv = <00>;
 		};
 	};
@@ -453,7 +453,7 @@ i2c3_pins: i2c3 {
 		pins_bus {
 			pinmux = <PINMUX_GPIO50__FUNC_SCL3>,
 				 <PINMUX_GPIO51__FUNC_SDA3>;
-			mediatek,pull-up-adv = <3>;
+			bias-pull-up;
 			mediatek,drive-strength-adv = <00>;
 		};
 	};
@@ -471,7 +471,7 @@ i2c5_pins: i2c5 {
 		pins_bus {
 			pinmux = <PINMUX_GPIO48__FUNC_SCL5>,
 				 <PINMUX_GPIO49__FUNC_SDA5>;
-			mediatek,pull-up-adv = <3>;
+			bias-pull-up;
 			mediatek,drive-strength-adv = <00>;
 		};
 	};
-- 
2.32.0.93.g670b81a890-goog

