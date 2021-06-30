Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8BF3B7C4F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 05:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233386AbhF3D5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 23:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233135AbhF3D5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 23:57:38 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8456AC061760
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 20:55:03 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id z3-20020a17090a3983b029016bc232e40bso460875pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 20:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XTRseahQAn7N0oXgs/qWK7jL4rGQhAjklYtYGhb1AyQ=;
        b=NO5OEIQsKYNpdr2LWayi7XLdIScBEOu4kjYg+ef74vvy8kzigpTWON3vmLPFeT5gTC
         f87p9QJk5st+s2ZG5dWu1HKfyRwJbDsbsauCW4e3auXjUhUmMsP3IxAZj9MRj9fiKDGL
         Zug8Ck07asx4KGT0rcv05OFwQUGLRNCCTVgOM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XTRseahQAn7N0oXgs/qWK7jL4rGQhAjklYtYGhb1AyQ=;
        b=BR0oAQOusVOq16r4/vpyhYd1d3465ZAsfkR7FAMCe3tW9AcipBFCjnzS+q2cuGrJbt
         WBkVLsdrEKQSGzCO9ED242NkOvsw3ijkwTq8rhpwlcPGPhwJLMTySMEgsVXV65StT9aX
         llIKKuUykFXh14K8pe2eM5Zb8pUpwf0jDVP5Ot9mmqQi9SNoC1E9OBnDuZLz8Wb4y9q3
         PXo9JGG3xqDrilPfspM5JWMnRWGyPBI09Xy+6duKUrQXX54g1mgjRbNM4wlT5KLiGsxl
         FEorxNfiRkUI+KmvLfefxmIfpAbsbkrH6H8oXjHGwjQ4PrUxkws9alDLXxe2uwrQ16V+
         PfsA==
X-Gm-Message-State: AOAM5305PayBOH6/q1lAOzzjag8hZQ7p7RygojOweKy6Wv63d1HWP2+R
        aKX83I2yUXWk7rWrSK4ZwfK4kw==
X-Google-Smtp-Source: ABdhPJxpm0eVuqMaGGYVUYcbD+lr8qVwBZYtjBw5loLKQrjnuA9sFFcXJwaQZLigcKOJJXKjl8OsjA==
X-Received: by 2002:a17:902:b193:b029:11a:a179:453a with SMTP id s19-20020a170902b193b029011aa179453amr30293113plr.69.1625025303074;
        Tue, 29 Jun 2021 20:55:03 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:2f49:a14d:fd5:cbd3])
        by smtp.gmail.com with ESMTPSA id f6sm13264333pfj.28.2021.06.29.20.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 20:55:02 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>, zhiyong.tao@mediatek.com
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: mt8183: kukui: use generic pin configs for i2c pins
Date:   Wed, 30 Jun 2021 11:54:44 +0800
Message-Id: <20210630035443.2144958-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mt8183 i2c pins don't support PUPD register, so change to use generic
pin configs instead of let it fail and fallback.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
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

