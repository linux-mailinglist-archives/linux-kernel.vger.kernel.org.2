Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35835428D65
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 14:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236713AbhJKMzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 08:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236694AbhJKMzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 08:55:19 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9FD7C061570
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 05:53:19 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: aratiu)
        with ESMTPSA id BD6041F42DB2
From:   Adrian Ratiu <adrian.ratiu@collabora.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, "kernelci.org bot" <bot@kernelci.org>,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        Enric Balletbo Serra <eballetbo@gmail.com>
Subject: [PATCH] arm64: defconfig: enable regulator to fix mt8173 regression
Date:   Mon, 11 Oct 2021 15:53:01 +0300
Message-Id: <20211011125301.3440033-1-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A regression was introduced on some mediatek boards starting with
v5.15-rc1 in commit 109fd20601e2b ("arm64: dts: mediatek: mt8173:
Add domain supply for mfg_async") which effectively changed the
regulator from the always-on dummy to DA9211 without explicitely
enabling it, causing failures like the these caught by KernelCI
on Hana Chromebooks [1]:

mtk-power-controller 10006000.syscon:power-controller: supply domain not found, using dummy regulator
mtu3 11271000.usb: supply vbus not found, using dummy regulator
xhci-mtk 11270000.usb: supply vbus not found, using dummy regulator

There might be another bug linking these power domains in the
mediatek PM driver, but that is a separate issue wich needs
addressing, for now just fix the obvious regression due to the
new regulator requirement.

[1] https://github.com/kernelci/kernelci-project/issues/66
Reported-by: "kernelci.org bot" <bot@kernelci.org>
Cc: Guillaume Tucker <guillaume.tucker@collabora.com>
Suggested-by: Enric Balletbo Serra <eballetbo@gmail.com>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 156d96afbbfc..4901cc1213bb 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -616,6 +616,7 @@ CONFIG_REGULATOR_FIXED_VOLTAGE=y
 CONFIG_REGULATOR_AXP20X=y
 CONFIG_REGULATOR_BD718XX=y
 CONFIG_REGULATOR_BD9571MWV=y
+CONFIG_REGULATOR_DA9211=y
 CONFIG_REGULATOR_FAN53555=y
 CONFIG_REGULATOR_GPIO=y
 CONFIG_REGULATOR_HI6421V530=y
-- 
2.33.0

