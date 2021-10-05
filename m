Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D72E421FCF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 09:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232884AbhJEH5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 03:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232866AbhJEH5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 03:57:03 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD9EDC061745;
        Tue,  5 Oct 2021 00:55:12 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id r10so19246113wra.12;
        Tue, 05 Oct 2021 00:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jYgx3udHfzPehpWqU0/YSG3YZlHkzavvjpxyA5BS7XM=;
        b=fbjASsA3DGJ71865lWBZ9xSdZMesWqr28KbtZnlA5msr0AIGqERDXmoPDCoYj5TRd7
         49fGlGiVPqXZQiS8Pux1y/vhFE2HI93lq/hpH1X8ms/4DIS4x8pZlLjXt834uT6zSCpC
         874wElQSHI5Z93NVBgF9bwm8rHp7U4Proh8JCyUuxtmsdlz0X8mFwOw7A0dp39VAcian
         YPHssiPdsoHmrG6DOs5KTB5epJOg3f8f0DBrrMFp74TJ1mRZIdYmj9ROzlxz9Mc/k2nS
         XQPrfXMNp+U8S1cabY2rfxgtmgSiwt/NpfW2IsV6sRmT48dCcg+jDW1DP9esc7hogcxr
         N1Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jYgx3udHfzPehpWqU0/YSG3YZlHkzavvjpxyA5BS7XM=;
        b=emJ8U5r0nQ6KkF8Lyvprg5y5s7nLL5A1Od5Kn4eUX9GLnW99zVGhTVhl9N2GpVt8gJ
         ENIjQeU2e5qY8E+7ut8oskcsB2nlds9k0ySt+RUaX0utrOh5pdZRR1D+HMyDlYYJO/36
         EBe7CQsNHufTyhBS+QsO0Wp2TM2eIyF+zNtyU2DcVCZx/EHqZIIVzlEtEgFvehZL90xE
         7xYPTQb7F23XOY3gaJxpx4ramwgb5JoTi6+uKi8/iNU2aEjsjduD7M8AP1RmYlOAS1uR
         vnwGsT7E860PAOD5dDWE6prNKnLxNAXJbgXVd4DgEn9XkGLZLpB8PHKhTSQ3dh7C/PC6
         c/8g==
X-Gm-Message-State: AOAM5312dKoUnWQkWGB2B2h72y53tDWj3vIyLb/LYAxGVjEwK971PeBB
        SJrc7+j/D4Dh0yJsKWgmG+Q=
X-Google-Smtp-Source: ABdhPJzoKzXqhAdKizQcVi24z8GRCruLLcueSh2LjcwFbgN4lmnfwFHrQKkA3kNlly/idLRQhlzXMw==
X-Received: by 2002:adf:8bcf:: with SMTP id w15mr20505384wra.144.1633420511433;
        Tue, 05 Oct 2021 00:55:11 -0700 (PDT)
Received: from localhost.localdomain (i59F67A83.versanet.de. [89.246.122.131])
        by smtp.gmail.com with ESMTPSA id o1sm1176984wmq.26.2021.10.05.00.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 00:55:11 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc:     Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Yu Chen <chenyu56@huawei.com>,
        Anitha Chrisanthus <anitha.chrisanthus@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Naga Sureshkumar Relli <nagasure@xilinx.com>,
        Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        Deepak Saxena <dsaxena@plexity.net>,
        Mirela Rabulea <mirela.rabulea@nxp.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Wilken Gottwalt <wilken.gottwalt@posteo.net>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Mark Brown <broonie@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH v4 01/11] MAINTAINERS: rectify entry for ARM/TOSHIBA VISCONTI ARCHITECTURE
Date:   Tue,  5 Oct 2021 09:54:41 +0200
Message-Id: <20211005075451.29691-2-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211005075451.29691-1-lukas.bulwahn@gmail.com>
References: <20211005075451.29691-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 836863a08c99 ("MAINTAINERS: Add information for Toshiba Visconti ARM
SoCs") refers to the non-existing file toshiba,tmpv7700-pinctrl.yaml in
./Documentation/devicetree/bindings/pinctrl/. Commit 1825c1fe0057
("pinctrl: Add DT bindings for Toshiba Visconti TMPV7700 SoC") originating
from the same patch series however adds the file
toshiba,visconti-pinctrl.yaml in that directory instead.

So, refer to toshiba,visconti-pinctrl.yaml in the ARM/TOSHIBA VISCONTI
ARCHITECTURE section instead.

Fixes: 836863a08c99 ("MAINTAINERS: Add information for Toshiba Visconti ARM SoCs")
Acked-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 369a00af62c7..2543b6344949 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2758,7 +2758,7 @@ F:	Documentation/devicetree/bindings/arm/toshiba.yaml
 F:	Documentation/devicetree/bindings/net/toshiba,visconti-dwmac.yaml
 F:	Documentation/devicetree/bindings/gpio/toshiba,gpio-visconti.yaml
 F:	Documentation/devicetree/bindings/pci/toshiba,visconti-pcie.yaml
-F:	Documentation/devicetree/bindings/pinctrl/toshiba,tmpv7700-pinctrl.yaml
+F:	Documentation/devicetree/bindings/pinctrl/toshiba,visconti-pinctrl.yaml
 F:	Documentation/devicetree/bindings/watchdog/toshiba,visconti-wdt.yaml
 F:	arch/arm64/boot/dts/toshiba/
 F:	drivers/net/ethernet/stmicro/stmmac/dwmac-visconti.c
-- 
2.26.2

