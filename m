Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D35C39D570
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 08:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbhFGG4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 02:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbhFGG4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 02:56:48 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E582AC061766
        for <linux-kernel@vger.kernel.org>; Sun,  6 Jun 2021 23:54:44 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id k5-20020a05600c1c85b02901affeec3ef8so1492007wms.0
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jun 2021 23:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Rkx1/XKlP8OpLSPbyBfhpFtPzmIt10Z4x0aGkniH3Kk=;
        b=r8PIC046W0acmJ5kc//XMyihu9X1f44q/bL1VDJGA4t3LuPH2drErHWjVocXAfCmQU
         DUShRkdBr597rrGYBu/4knQQ6WWiS33FEsRSLBZqwC3OM51Lp9yCUj7vfVJRYC92Fzx9
         mh2w4ONi5p2AxhWcmR8VfbAw4ZVlT0xb6IjA0fFlrcAMAIn743C7ICkG/macEtVtfyTZ
         l9OPtgrYJBQKJxbbL7BDLm+YOOv8vS9PT8U1Tbxgvjpg8SN6EfAyuyIBQuOWFzvECvoX
         bzJp1rF8QBsSSDuDY17SHCeWv1pTOHFhhGdb0jHB5D7kRWe7Mol6YuE7+mH9E99HR9xn
         +/Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Rkx1/XKlP8OpLSPbyBfhpFtPzmIt10Z4x0aGkniH3Kk=;
        b=lMjrXmWD8jJksrHInnKNcQ9H26hMT64u61WRg381+53NtTV/gBb1ANsApsNPZ5rz8D
         aFy7xWrrvQwhOaXzl1uplsr7FrEcbG1rG8zQDEzziAewUKzdPx5VT1uyoj7DI/diYI33
         SOcko95me1snh1XLFWdY4vRcVvWlqUx/PXTdmmNd7SwBWGgdINWDV4XAXeCj0bkecuYd
         67MT5LJ6Z48Sj91kWD0IGfpQJRJgW+87Xq1SJekCTEerDgzTzjCtfiQJCTyzpkVmTNq/
         WmNgeMDswtbRi2xNE8X849yR5KxGKE2SLA7saSYKrejCER4cYQ+Sl5Kx4AMVm1gxkRSa
         Y1EA==
X-Gm-Message-State: AOAM533q+Ccpy86ltt5h9B7FKd1QpopG/vUasuUD0t7FfUhkXMFXEVKz
        xOyHwom4UlZmLzL7DESnqaUexA==
X-Google-Smtp-Source: ABdhPJw5uYSIBsGWP25lkrYy3w6robKsJmc9LsAeF9HFjoqg492tVNgwYJnpaAwFo3FouASm8l78RA==
X-Received: by 2002:a05:600c:154f:: with SMTP id f15mr9574692wmg.116.1623048883504;
        Sun, 06 Jun 2021 23:54:43 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:90c:e290:7c1f:1c9f:555e:7398])
        by smtp.gmail.com with ESMTPSA id l5sm16145742wmi.46.2021.06.06.23.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jun 2021 23:54:43 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tobetter@gmail.com, Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v2 0/7] arm64: dts: meson-sm1-odroid: various fixes for C4/HC4
Date:   Mon,  7 Jun 2021 08:54:28 +0200
Message-Id: <20210607065435.577334-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1220; h=from:subject; bh=0eOtnh7RB4lBLG+mXsh+c2AQMdf7GQcwCtDgJ1wQ1e4=; b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBgvcI9qzof97GT2qkdxpNoLxy7UutAJW3fG/FkdHR1 Kk05oJmJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCYL3CPQAKCRB33NvayMhJ0Ts2EA CJWDyK5h3AGhrcSBXbLTL521NkWGIKCej31qDzRW8MGQp1tVayHIrkPhjOJeo5Ru7q9o5bmgXIEs13 /x7Rp+6qDxmMue19QPB5eujiQfczYxp6G73gRdSSNlatSbwCZYjVsjQsuZzcUjrgi0Mi69BdDmH8p0 dbDi2vgPLVgCQUFDKyCDG8RtVeP2nGsS9z7D3q1mS24TylAn11EufTBXcTk1Bx4DEjLxdpUr7ZApSb 3UHLMjAgp6dII1z0vjDe2DLhFjXQLlcXcE4K1rjtTllBQj3vjEetRfGEGd2yAisPBL4AfOZRtO/YqF GscgrrJZC03z/Iq2g1LinOCGrKC5Ku0m0W4I4iobAcno/URayuZF88oqByzm9sxaPV9Fo/u8VunqUo EN0H3IjTxiOvAGlfmt52JG+1unGlGmIRz89u7KrmDVpy3NZsGpUxh8qRGE/7rEUdt8sF9JhnnfEceh Ew+XBryecSsOzb1kD6vs5gDqaYVjMLiZH9nBy97mc281nOGXkdgMdw7LZGifF71UVJM4Px56KCBTgg yf6aF0vjylQ6hBImOLT3uxdKhXXtWlwzn9R/k8H38KW8PS3GhroBG5tlhh2iQuUUehDsu4ANuHIjER Kozpcp78GDDNNWvWgwxmY3B9Of/vhkUWURml5e6Op1zf3CWXsnZTxr1JBJ0g==
X-Developer-Key: i=narmstrong@baylibre.com; a=openpgp; fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a collection of fixes/small additions to Odroid-C4 & Odroid-HC4 concerning
regulators handling, USB and SPI NOR Flash of HC4.

Changes from v1 at [1]:
- added review tags from martin
- removed invalid patch about hub_5v
- added proper vcc_5v gpio control
- removed invalid hub_5v regulator already controlled by a gpio hog

[1] https://lore.kernel.org/r/20210601090140.261768-1-narmstrong@baylibre.com

Christian Hewitt (1):
  arm64: dts: meson-sm1-odroid-hc4: add spifc node to ODROID-HC4

Neil Armstrong (6):
  arm64: dts: meson-sm1-odroid: add missing enable gpio and supply for
    tf_io regulator
  arm64: dts: meson-sm1-odroid: set tf_io regulator gpio as open source
  arm64: dts: meson-sm1-odroid: add 5v regulator gpio
  arm64: dts: meson-sm1-odroid-hc4: disable unused USB PHY0
  arm64: dts: meson-sm1-odroid-hc4: add regulators controlled by GPIOH_8
  arm64: dts: meson-sm1-odroid-c4: remove invalid hub_5v regulator

 .../boot/dts/amlogic/meson-sm1-odroid-c4.dts  | 17 -------
 .../boot/dts/amlogic/meson-sm1-odroid-hc4.dts | 48 ++++++++++++++++++-
 .../boot/dts/amlogic/meson-sm1-odroid.dtsi    |  9 +++-
 3 files changed, 54 insertions(+), 20 deletions(-)

-- 
2.25.1

