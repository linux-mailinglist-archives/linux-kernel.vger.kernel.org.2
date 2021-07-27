Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85FF63D6B39
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 02:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234624AbhG0ABP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 20:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234435AbhG0ABD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 20:01:03 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D664C061796
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 17:41:30 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id k4-20020a17090a5144b02901731c776526so1566684pjm.4
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 17:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LV9rtPWK29OIfdbRpaR0Bkv/9T56K116ORL6laCjuos=;
        b=fOOjB7pjyy3IYVzNWHFapyTYwg+vtSi9SqWw0wmJmG7BCTu+xVMULsY9kLLWPfehPw
         okr+aQNcjs2RSZEQFICxaXL1kT1T5i6Y+dRaeJDUFKgu3W3xAIg1+P3Rtjf+dOB+UCvG
         p482JeU6QN7TBDCQ5l9cpVR9b+2neEyngNb6I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LV9rtPWK29OIfdbRpaR0Bkv/9T56K116ORL6laCjuos=;
        b=IP8S0qlKiDVhXI6po42yqA2rsgYxIdeL9i66Tg76BSewER3WVsS6f0iSkyfMTfegXi
         abgUdCarsaGJ3WX/zwc+jby2+ZuV9+qpOjiwdD9+4dK4M0XsCi9NHk4g7zvvNCLp30Ri
         kMweqPHxaQ9k08U8wkjMV+WUvCVlFNMR1O8EhcqpcyP5Le8zvYm1GEeRpKNr42eRkm1z
         qLFVq0rhOj9A4EmrphD4CGlkfys1pmPoQiNMqeMYxcOGe0ECzi/IFmpSKT7NAAkm5f2c
         9D2lTtaoadFxL29D70QOSRY0sk6xUogZ/na1YLSzdhv0u2CQ0HSfzBcxKXff5NldrI9e
         hLLg==
X-Gm-Message-State: AOAM530LAPrGMgq3LHFn33q8I3cMRlsFDdo/56oFGxdFialYsr+ftGib
        EtbYcsoD3UgWcKmu79yRz8Re2w==
X-Google-Smtp-Source: ABdhPJxZSpTAOOhuOp8vxmmU8L/qIhcFqmNGr4eNN7LOyDZ0qgHEXhbBtszOyBpG58yMG6iL1Wtyag==
X-Received: by 2002:a63:5703:: with SMTP id l3mr20834837pgb.338.1627346489723;
        Mon, 26 Jul 2021 17:41:29 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:9c3d:270c:6be9:9c33])
        by smtp.gmail.com with UTF8SMTPSA id k8sm1116322pgr.91.2021.07.26.17.41.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jul 2021 17:41:29 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Felipe Balbi <balbi@kernel.org>
Cc:     Bastien Nocera <hadess@hadess.net>,
        Peter Chen <peter.chen@kernel.org>, devicetree@vger.kernel.org,
        Michal Simek <michal.simek@xilinx.com>,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-usb@vger.kernel.org,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Nishanth Menon <nm@ti.com>, Shawn Guo <shawnguo@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v15 3/6] arm64: defconfig: Explicitly enable USB_XHCI_PLATFORM
Date:   Mon, 26 Jul 2021 17:41:15 -0700
Message-Id: <20210726174048.v15.3.Id45138610b749ff775186ac10b3d01c504ddf4f3@changeid>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
In-Reply-To: <20210727004118.2583774-1-mka@chromium.org>
References: <20210727004118.2583774-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dependency of USB_DWC3 on USB_XHCI_PLATFORM is being changed
from 'select' to 'depends on' by another patch. The defconfig selects
USB_DWC3 and implicitly USB_DWC3_DUAL_ROLE, to keep this unchanged
USB_XHCI_PLATFORM now needs to be selected explicitly.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v15:
- none

Changes in v14:
- rebased on v5.14-rc1 (with the rest of the series)
- added 'Reviewed-by' tag from Doug

Changes in v13:
- patch added to the series

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index f423d08b9a71..b243bd11a4ed 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -802,6 +802,7 @@ CONFIG_USB_OTG=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_PCI=m
 CONFIG_USB_XHCI_PCI_RENESAS=m
+CONFIG_USB_XHCI_PLATFORM=y
 CONFIG_USB_XHCI_TEGRA=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_EXYNOS=y
-- 
2.32.0.432.gabb21c7263-goog

