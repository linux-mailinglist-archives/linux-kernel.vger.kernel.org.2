Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC0DC3233A8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 23:20:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbhBWWTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 17:19:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbhBWWTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 17:19:15 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1760BC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 14:18:35 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id t15so24057555wrx.13
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 14:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UOWr9d9lq0sjyNqrHH38BMtESbANjRbnbDGooX/xjQ8=;
        b=MKwlftHyyZGE3othtgMueaRHkmaajvrUXsaVYoAx670mrzccorJhqLtyleUQAEYrCd
         suzFsQeHhogqSKhfzYnaXilqXRfFPxFKLzFcTH733uTZc3yK29Ukwsw6laE5AJWZTlQL
         UMyMB27jbFxhUDyJ6qor7SrKDMJXFhi2G7sTS+s6kcdUpWAbrbf5f7xF08IfVmBChJ1N
         4MX1tPr1/5ZbXUl407mcoItffg5bXvEFp7UeIGh+KRMFngmZGL5hxlWjmbBLw3nnhQ92
         UtTSais/T/XTcduQ/8HQur1E5xaNtKFgTsrXewtoN04/eaXGus6LK7aunjozLwx5c85p
         a6WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UOWr9d9lq0sjyNqrHH38BMtESbANjRbnbDGooX/xjQ8=;
        b=NNVw6J7Bx3pP1575rFWXCZfk9gNNX8Ub2i2VZqIh2Mrr2xNAPrqqNmEc6FQlta74J3
         LF66M0iyKSJnS3xEuqLMRTPJOQtrGRDkP412NKmGcHFHbWZJzbpo781Bk8E0rV/umNXL
         vNGzms+r71wDDCOfb0Jb9czNwNeF9qc4jgqRsTSioo+1iEiYEopoQoZOXxzevwo0KPnE
         z1Yl56jba23NLDFDmg4FrjU7136yxWbzOYWmA8/vlzcIjjxazwnduh78Wg8+1Db5vXWe
         5oWS9f6AhN6jTTpgGW6YpuZXpvsZyL3sQ7Qy3DWCzPmTbmMs5aZqSV3xuPNDVPVDj9Yh
         edHA==
X-Gm-Message-State: AOAM5316q4qb+qEXrLqJxZIvxYAGRYKi5MjtgcPNy/0Z/Jc2svhSDw+a
        utxYcqp+bQwIzXclDAEnaAYz/Q==
X-Google-Smtp-Source: ABdhPJyET+QxjGHr9GQWKV2tzcZtwrRpuGCUPQ0oFhxKbHTjMAg50XZI9bCQscPIpL6+/UkcI4ikHg==
X-Received: by 2002:a5d:6a0b:: with SMTP id m11mr28305380wru.414.1614118713821;
        Tue, 23 Feb 2021 14:18:33 -0800 (PST)
Received: from localhost.localdomain ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id o129sm4035934wme.21.2021.02.23.14.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 14:18:33 -0800 (PST)
From:   Fabien Parent <fparent@baylibre.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     mkorpershoek@baylibre.com, Fabien Parent <fparent@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: mediatek: fix reset GPIO level on pumpkin
Date:   Tue, 23 Feb 2021 23:18:26 +0100
Message-Id: <20210223221826.2063911-1-fparent@baylibre.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The tca6416 chip is active low. Fix the reset-gpios value.

Fixes: e2a8fa1e0faa ("arm64: dts: mediatek: fix tca6416 reset GPIOs in pumpkin")
Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi b/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi
index 63fd70086bb8..9f27e7ed5e22 100644
--- a/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi
+++ b/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi
@@ -56,7 +56,7 @@ &i2c0 {
 	tca6416: gpio@20 {
 		compatible = "ti,tca6416";
 		reg = <0x20>;
-		reset-gpios = <&pio 65 GPIO_ACTIVE_HIGH>;
+		reset-gpios = <&pio 65 GPIO_ACTIVE_LOW>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&tca6416_pins>;
 
-- 
2.30.1

