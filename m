Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9322A3EBCCD
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 21:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234268AbhHMTxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 15:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234225AbhHMTxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 15:53:18 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21A55C0612A9
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 12:52:47 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id qe12-20020a17090b4f8c00b00179321cbae7so6911221pjb.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 12:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p7nbDLVfQ70VzAap47W+E/velrGufmq2Nrz0ruFPQRA=;
        b=bf/UkzAwyO9u8j3Qj4YzHAdfek0+BFIdzVeUPZRNY2/VQxBbTGD4reSnz3RVnwzGVq
         1GLu1adNaQxByDBJvEFVaRyi/puOHKmTBGFAu5j/s4UR2XJXF2/xaBQLrf/STOO67UXo
         e5/1IDTNMn3VHkyhxKV9spwx7Tv+KWwR4r1jI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p7nbDLVfQ70VzAap47W+E/velrGufmq2Nrz0ruFPQRA=;
        b=YvZW7As5SNSpbn4Nq3gGvNWO1Jsq0hNG+EvF9o6++xVu7emOXyzF1H66GfcOHoOcM5
         ktELbXa5d9ul8675Bxv1+XnGLn/42vXswMqmqXXQojwaK2J6XiG2TzNqMS+uPhhSscWE
         m5slGIBXIQ7iEX4uvTV0dn9gdXjarPKGsIsT6GoInkBaJenTxvWL2d+MIcCinYEIz5sD
         eRlDU9yWenod4dv4Mogh/dOI9S5hVt5w07S6km5RBPwxyQ6iWW2ZDScLZc6pzctmvglf
         JA2M1bFCbJBFMI2T7fpwQkpCyT7uNDTadT9/3MkZUt6UIJCpLdwezh4dyxYK/eInKtcg
         fgdQ==
X-Gm-Message-State: AOAM533+xhjDfKREg7YcDNpKWXnPhCH83bK1WmRR2LrdMqSxWIFfObKX
        i55nwLgYBh7JFxhbu2GPvIuNjw==
X-Google-Smtp-Source: ABdhPJy6BBJUXlsE6Y5wt5qaIYD4FIi0ZQdDXV9XbRXGZDlatMa5OD0adSJ0EPqCYPkA28YpbkeMQg==
X-Received: by 2002:a63:a54f:: with SMTP id r15mr3746124pgu.212.1628884366441;
        Fri, 13 Aug 2021 12:52:46 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:450d:9788:a70e:42d6])
        by smtp.gmail.com with UTF8SMTPSA id n22sm3158768pff.57.2021.08.13.12.52.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Aug 2021 12:52:46 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Felipe Balbi <balbi@kernel.org>
Cc:     devicetree@vger.kernel.org, Peter Chen <peter.chen@kernel.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Bastien Nocera <hadess@hadess.net>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Douglas Anderson <dianders@chromium.org>,
        Roger Quadros <rogerq@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Fabio Estevam <festevam@gmail.com>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Nishanth Menon <nm@ti.com>, Shawn Guo <shawnguo@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v16 4/7] arm64: defconfig: Explicitly enable USB_XHCI_PLATFORM
Date:   Fri, 13 Aug 2021 12:52:25 -0700
Message-Id: <20210813125146.v16.4.Id45138610b749ff775186ac10b3d01c504ddf4f3@changeid>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
In-Reply-To: <20210813195228.2003500-1-mka@chromium.org>
References: <20210813195228.2003500-1-mka@chromium.org>
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

Changes in v16:
- none

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
2.33.0.rc1.237.g0d66db33f3-goog

