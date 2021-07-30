Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 877673DB858
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 14:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238728AbhG3MJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 08:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238686AbhG3MJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 08:09:50 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7418C061765
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 05:09:45 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id k1so10807008plt.12
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 05:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9jhmmW00U1t6nu8Et2gPe9VWIRq7R6Jr8Ar5v9ZMFtg=;
        b=VgT+e2A0IF77HhCmq2v6gbviN4IFKA14+DyHg8G0xXNc0t531MsdMsNgKTJhiUViYc
         ggx33OQt6gRHAzv/ahTT5A6vhoFV36OjYD4WTGda6NKOqY8jeXrwa6D+n3QeM+2d9vxi
         aKgXY76W0OMXpUKyeu4ztuhnxxFUYijR1+F6g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9jhmmW00U1t6nu8Et2gPe9VWIRq7R6Jr8Ar5v9ZMFtg=;
        b=Dt86NKpjq23WFIr0/jnQwKCgxnz2H+S22lDgjqUVB3pnvpEQceX8XzmBzi7DOR19PJ
         /Ja5of3MliAv7/i0iAzF6pwqvoEWX509pxU6wMzDfzwGW27DzzWQvXBa0ffXa+bxlEUU
         uldSHPMul2kLLaN7IOesWKvWT+Kw5UP3rMCyje1k9uCv4lbkQlA/14386LVmwSTAolB/
         wl481YycfskBHAQiZGH4HFwf5PUdjY+Z9zsO/WZAnJlhP1/r77T/WL7FeSMavrzpde7C
         iycv5LBZDcTxPXIi/y9i4dxAPE1I7aPsRb+l46UW97+SrAKYktT4XG+06mr3bkRFGEmW
         Akww==
X-Gm-Message-State: AOAM531ZZxtLm8D+vN0HHUecCE2DWYtarvfw1gXyJiA0gX1/NEOG7Abi
        hONtu7h7HjxB5h7d+iWePhTAsQ==
X-Google-Smtp-Source: ABdhPJyUiLCxqCC6f1d5CYwKUP8Qk7BYcm75N+d9XbtZsZfdM08Fxck+IkBKHdeny9OLqapp+4YTTQ==
X-Received: by 2002:a62:8f0b:0:b029:356:ba53:a041 with SMTP id n11-20020a628f0b0000b0290356ba53a041mr2443083pfd.10.1627646985133;
        Fri, 30 Jul 2021 05:09:45 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:c144:3a3e:e06f:59])
        by smtp.gmail.com with ESMTPSA id a9sm2182071pjs.32.2021.07.30.05.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 05:09:44 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        Andy Teng <andy.teng@mediatek.com>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] arm: dts: mt8135: Move pinfunc to include/dt-bindings/pinctrl
Date:   Fri, 30 Jul 2021 20:09:35 +0800
Message-Id: <20210730120937.1435204-1-hsinyi@chromium.org>
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

