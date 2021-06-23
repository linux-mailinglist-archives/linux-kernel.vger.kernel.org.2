Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC4033B2073
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 20:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbhFWSoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 14:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbhFWSn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 14:43:58 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9242C0617A6
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 11:41:39 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id m17so1630812plx.7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 11:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6I46EDeVvue/JEcRkc+UqOHLZNFVFF0xm4B6v9zE/2M=;
        b=Akrau+NHCquNoq1Vp2lXasY9+NQSczk0x8X/rw5MYm2rt5jOCCj5P88AnCuM+jVld/
         zGmlL+SnO4cLkP/M4lM/0zAHOQIZ9+ug1X8PDIfL1j8GFOhREfV5tJ2nT3qpcfOmza80
         zQWV9eEEmO8aQGy8WpOfsJDrWoj/mvk8Fa9SY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6I46EDeVvue/JEcRkc+UqOHLZNFVFF0xm4B6v9zE/2M=;
        b=K50odg4lzYh1aB/wGyt8H3wARm4iUGbQgAFKEM4qPKwSv0lGS04XOn0dBsk7UlDp9E
         f5uzLp3cLeIczO5+TuhmHW7hEMTHnSdYoejGFSDvjQ9G+NxIX3Hkp87T48bLRbSgS6xi
         sUMVN73urCAeFbzcgyt+Dz8n1J35tm/HBh7JUCSeEAv1KMdW9zs2O3f0fMAyIcSUwOeP
         FiAvSlh8JWe9OXVf4PIz6v7WhieGvZuXL3mXQ25sMvVlpHieo8DjXyLqI8h9qeMoK4Wf
         aGcKLhi2bWXUs5eeLnx5rhWNoRpocnCVFAa/QzC3EdWHlDKRW+AqYMEjY8QWmSMAduSL
         6/tA==
X-Gm-Message-State: AOAM531vOPfjFwwCYkslqwn2XbrbtzC8RX32cCMMVgPVZail04At24KM
        crAYGLJ3wfmBNN3gKd178L08Og==
X-Google-Smtp-Source: ABdhPJyqb+UXhYwjp56/GfRbVv/GGu7TeKF0/RSUSFPyiyQZFi19dmK+OYEMksymMens0VE/+BnJ8w==
X-Received: by 2002:a17:90a:ba91:: with SMTP id t17mr11340609pjr.89.1624473699308;
        Wed, 23 Jun 2021 11:41:39 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:d440:232:5e25:41f4])
        by smtp.gmail.com with UTF8SMTPSA id p4sm552290pff.148.2021.06.23.11.41.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jun 2021 11:41:39 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Felipe Balbi <balbi@kernel.org>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Michal Simek <michal.simek@xilinx.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Peter Chen <peter.chen@kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Anson Huang <Anson.Huang@nxp.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Michael Walle <michael@walle.cc>, Nishanth Menon <nm@ti.com>,
        Shawn Guo <shawnguo@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v13 4/7] arm64: defconfig: Explicitly enable USB_XHCI_PLATFORM
Date:   Wed, 23 Jun 2021 11:41:20 -0700
Message-Id: <20210623114025.v13.4.Id45138610b749ff775186ac10b3d01c504ddf4f3@changeid>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
In-Reply-To: <20210623184124.3504047-1-mka@chromium.org>
References: <20210623184124.3504047-1-mka@chromium.org>
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
---

Changes in v13:
- patch added to the series

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 08c6f769df9a..d7f22b18e37a 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -795,6 +795,7 @@ CONFIG_USB_CONN_GPIO=m
 CONFIG_USB=y
 CONFIG_USB_OTG=y
 CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_XHCI_PLATFORM=y
 CONFIG_USB_XHCI_TEGRA=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_EXYNOS=y
-- 
2.32.0.288.g62a8d224e6-goog

