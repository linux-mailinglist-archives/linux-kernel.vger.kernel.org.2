Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8543DE60A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 07:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233710AbhHCFNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 01:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbhHCFNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 01:13:41 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D3BCC06175F
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 22:13:31 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id k4-20020a17090a5144b02901731c776526so2211772pjm.4
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 22:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9jhmmW00U1t6nu8Et2gPe9VWIRq7R6Jr8Ar5v9ZMFtg=;
        b=RoS1gW+/fNn3RB/dhB7nzScfvJQQsbjLIhYDsYTl4X0jCg/h6AdY/6PJ2cal4rof+Q
         97up+1FPQ2T64Co6AQXQiG1sD2aLoBpYSklNlcXon3aybN5XRHDKLLLG/mVlgPkBLdmy
         9OU0BiUeS5WVY1Zr85FSYBPV0B/PsMOTUCUFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9jhmmW00U1t6nu8Et2gPe9VWIRq7R6Jr8Ar5v9ZMFtg=;
        b=o1/SL6t45rZ92rs8dk9ZbY90PgD7TgBg+lIoJ85AJ0a5BFnbqgwLi2iE8DC27Teab3
         zWowJ/ZQjIQHvE7o+KDBPKpB7ghiTkj2WpTiIRd5OtN6ggDIrIgK0C5YzmR4YumGfBcb
         yuBUcCzjrgBVDsFSzVfS1zRY2B2ydIowW5WBsC0gYqH+oqiXAVv/420Pv8jkfydaFMo7
         5zGICVXElfyPRnR4zDfo8d6aNcTkyIh2ntgRym9wrGG5UtHvQGskWbHSCTFQGiXzB/q4
         i59E7c8MvS/Z6jGD1Vh8STY/dzymdaCqSYDDXPhexg9qlAT9DBmriCme4+rzRomk5val
         LedA==
X-Gm-Message-State: AOAM530g0jxxFK8BtkK+cJV+js0e5sZgRqlnPzeBx12rPC0rBVJ4msDy
        S0AyxRzRprNPuEaQk8qIJqdHBg==
X-Google-Smtp-Source: ABdhPJwXpzsjl4OXSLsWVSfF8lTblrp6AM92riWciamL69PeJ7AqgmVERsB7T488R7e4C4w22/Mp9A==
X-Received: by 2002:a17:90b:1d8c:: with SMTP id pf12mr2499451pjb.130.1627967610468;
        Mon, 02 Aug 2021 22:13:30 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:c800:1b1d:5677:31a7])
        by smtp.gmail.com with ESMTPSA id x25sm115732pfq.28.2021.08.02.22.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 22:13:30 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        Andy Teng <andy.teng@mediatek.com>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] arm: dts: mt8135: Move pinfunc to include/dt-bindings/pinctrl
Date:   Tue,  3 Aug 2021 13:13:16 +0800
Message-Id: <20210803051318.2570994-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move mt8135-pinfunc.h into include/dt-bindings/pinctrl so that we can
include it in yaml examples.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 arch/arm/boot/dts/mt8135.dtsi                                   | 2 +-
 .../boot/dts => include/dt-bindings/pinctrl}/mt8135-pinfunc.h   | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename {arch/arm/boot/dts => include/dt-bindings/pinctrl}/mt8135-pinfunc.h (100%)

diff --git a/arch/arm/boot/dts/mt8135.dtsi b/arch/arm/boot/dts/mt8135.dtsi
index 0e4e835026db0..a031b36363187 100644
--- a/arch/arm/boot/dts/mt8135.dtsi
+++ b/arch/arm/boot/dts/mt8135.dtsi
@@ -9,7 +9,7 @@
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/reset/mt8135-resets.h>
-#include "mt8135-pinfunc.h"
+#include <dt-bindings/pinctrl/mt8135-pinfunc.h>
 
 / {
 	#address-cells = <2>;
diff --git a/arch/arm/boot/dts/mt8135-pinfunc.h b/include/dt-bindings/pinctrl/mt8135-pinfunc.h
similarity index 100%
rename from arch/arm/boot/dts/mt8135-pinfunc.h
rename to include/dt-bindings/pinctrl/mt8135-pinfunc.h
-- 
2.32.0.554.ge1b32706d8-goog

