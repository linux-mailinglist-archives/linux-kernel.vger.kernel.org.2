Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B75C933CEF6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 08:56:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233530AbhCPH4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 03:56:32 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37564 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233361AbhCPHz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 03:55:57 -0400
Received: from mail-ej1-f69.google.com ([209.85.218.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lM4YV-0006Ql-QJ
        for linux-kernel@vger.kernel.org; Tue, 16 Mar 2021 07:55:55 +0000
Received: by mail-ej1-f69.google.com with SMTP id gn30so13136429ejc.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 00:55:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c3zCpcnTqD9R3iuzYicbz3BgU7Gti7/fMZiuJzomxfc=;
        b=N4ytDlWU5PzXA/zTA5r2AXyZ81ZtQuzXhWEBVhjKG5G3KOWAMTNxCzZv6QOMRBM7u2
         Lq2kL9Q9OMw4Bwi1EHHdrj6/ZhWK09pdEcnTmKSbyztgKc1j8dNj7JFBrri8bJsiN9xE
         Gn7pjbWwfsil6XnhkM3J4tCdZQF5EU5xL08pkgqBj2effncG71oih07Kcs9/S9iU06Vj
         pGzrMm4eaw+tBHGME3mOqEYQzR8ektpkTZ3vbGYze+69iJd3n5s72CLgCxDCNqWlw+Xx
         0+EooeO/hDl1YTXW9ZhS1GQ6A/QJ0rtXDOlNTNV+Sebx1AhxDu3kpjKUU6BjtZOS7AIH
         ibTQ==
X-Gm-Message-State: AOAM532qJTgcUIDUA16LRPR/Zglok0UfdXXM7FdjjlkflYxzgB61qpJO
        geU9O/kRwUGcGXUagtQd6zgdHgDXvM7+F81IDhWZOs9L9gtXRLhmMpRC4GvWDi60p6OBd0WAQFU
        DzMjug1wKsf7Ap3QRjLjoh6k+2hGLqVGEqm3ddO2t7A==
X-Received: by 2002:a17:906:565a:: with SMTP id v26mr28672223ejr.516.1615881355579;
        Tue, 16 Mar 2021 00:55:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzy4DMknl54WTpt12UYudRp+llCrhUI3pa8l/ZF2galgznYCyWIDeErXWmVeS6SdiN0DMpEXA==
X-Received: by 2002:a17:906:565a:: with SMTP id v26mr28672210ejr.516.1615881355445;
        Tue, 16 Mar 2021 00:55:55 -0700 (PDT)
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.gmail.com with ESMTPSA id gj13sm9023904ejb.118.2021.03.16.00.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 00:55:53 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v2] phy: tegra: depend on COMMON_CLK to fix compile tests
Date:   Tue, 16 Mar 2021 08:55:51 +0100
Message-Id: <20210316075551.10259-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Krzysztof Kozlowski <krzk@kernel.org>

The Tegra USB PHY driver uses Common Clock Framework thus it cannot be
built on platforms without it (e.g. compile test on MIPS with RALINK and
SOC_RT305X):

    /usr/bin/mips-linux-gnu-ld: drivers/usb/phy/phy-tegra-usb.o: in function `tegra_usb_phy_init':
    phy-tegra-usb.c:(.text+0x1dd4): undefined reference to `clk_get_parent'

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. Depend on COMMON_CLK always, not only for compile test.
---
 drivers/usb/phy/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/phy/Kconfig b/drivers/usb/phy/Kconfig
index 52eebcb88c1f..7500e77a7d01 100644
--- a/drivers/usb/phy/Kconfig
+++ b/drivers/usb/phy/Kconfig
@@ -163,6 +163,7 @@ config USB_MXS_PHY
 config USB_TEGRA_PHY
 	tristate "NVIDIA Tegra USB PHY Driver"
 	depends on ARCH_TEGRA || COMPILE_TEST
+	depends on COMMON_CLK
 	select USB_COMMON
 	select USB_PHY
 	select USB_ULPI
-- 
2.25.1

