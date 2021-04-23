Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C561368E24
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 09:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241139AbhDWHwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 03:52:46 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:33882 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbhDWHwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 03:52:45 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 547BB1F4387B
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>,
        linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com,
        drinkcat@chromium.org, hsinyi@chromium.org,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Max Krummenacher <max.oss.09@gmail.com>,
        Michael Walle <michael@walle.cc>, Nishanth Menon <nm@ti.com>,
        Shawn Guo <shawnguo@kernel.org>, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] arm64: defconfig: Do not override the MTK_PMIC_WRAP symbol
Date:   Fri, 23 Apr 2021 09:52:01 +0200
Message-Id: <20210423075201.2616023-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 'fbbe38309d56 ("arm64: defconfig: Allow mt8173-based boards to boot
from usb")' added the MTK_PMIC_WRAP config built-in. It needs to be
built-in in order to be able to boot from USB or the MMC without needing
a ramdisk, but that symbol was already defined as a module so now we are
getting the following warning:

  arch/arm64/configs/defconfig:996:warning: override: reassigning to symbol MTK_PMIC_WRAP

Remove the MTK_PMIC_WRAP=m from the defconfig to remove the error.

Fixes: fbbe38309d56 ("arm64: defconfig: Allow mt8173-based boards to boot from usb")
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 arch/arm64/configs/defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 08c6f769df9a..9907a431db0d 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -491,7 +491,6 @@ CONFIG_SPI_S3C64XX=y
 CONFIG_SPI_SH_MSIOF=m
 CONFIG_SPI_SUN6I=y
 CONFIG_SPI_SPIDEV=m
-CONFIG_MTK_PMIC_WRAP=m
 CONFIG_SPMI=y
 CONFIG_PINCTRL_SINGLE=y
 CONFIG_PINCTRL_MAX77620=y
-- 
2.30.2

