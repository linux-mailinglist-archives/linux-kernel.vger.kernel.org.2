Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A55B3D73F5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 13:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236374AbhG0LCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 07:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236227AbhG0LCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 07:02:43 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55DC9C061757
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 04:02:43 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id m2-20020a17090a71c2b0290175cf22899cso4310656pjs.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 04:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=62cZorY/aqW6/nmoaXLGfSvBqflphL+XPQS97Zl3weY=;
        b=MilN6BFgMUc1fMRsL+GBnviiIuEZq41bfDVDgnvImZKTDMjr+zw0G+VGHf1XFX08nn
         TT3D8wraoknyERJ3meYs2GBWmJ/Q2RrEd4V06SMX1L35VPKo3Qz6+BodoZoirVyjPaJS
         lWLw0puHNt3DSLcI/H3lXrvY6Jx04cvy3+Guk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=62cZorY/aqW6/nmoaXLGfSvBqflphL+XPQS97Zl3weY=;
        b=b9GAp+pFJUu+L1ctNTGocy0DVGliAeAtMsYxF+zd2h5XP8eDXGg/gVNK44250NwjGq
         F89Wbta2+CYPp7lzJSs42Clex18VvgoPO/Faa9FiH0GlM5qaVVUH/xH6lkqgMNu3asW+
         jenhHKqGX4g7zj+m83CqOsbfUtL9ysRk6l9E8AJvKopJpX6JPuLDEli/gfvBsD3msMZs
         qNO+RbKwMfMt6EUjSWhtXlVl+mBD/3Xd13T40rDPODs1p/etQ2VItDsISkc3XN3xsAu0
         ANPH4G8+b6mhgjwrnqHUdm9QRjG5LVTx/PJjz63dYRTlR4h5S9nJEiXajPLGitiAKUt4
         puIA==
X-Gm-Message-State: AOAM531q1kCMf50bVgd/fFfiBV2uPv6J/C8mlRiFq0tpvelBZDLlCeTT
        T/+kOZKrARvUOC+3RFrpurq1xg==
X-Google-Smtp-Source: ABdhPJxnSDI/sZWXmp6xkjw+XlVjQ4cwPwMrjvLXbVayACXXDVyNSipETcDQM0Ui9jBlYDCJBXsBag==
X-Received: by 2002:a17:90b:1195:: with SMTP id gk21mr21705514pjb.150.1627383762744;
        Tue, 27 Jul 2021 04:02:42 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:5176:76cc:2193:9b8f])
        by smtp.gmail.com with ESMTPSA id 33sm3553683pgs.59.2021.07.27.04.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 04:02:42 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        Andy Teng <andy.teng@mediatek.com>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] arm: dts: mt8135: Move pinfunc to include/dt-bindings/pinctrl
Date:   Tue, 27 Jul 2021 19:02:30 +0800
Message-Id: <20210727110232.2503763-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
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
2.32.0.432.gabb21c7263-goog

