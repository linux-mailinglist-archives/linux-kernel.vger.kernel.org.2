Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 158DA329A16
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 11:32:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348329AbhCBAoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 19:44:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:51242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240356AbhCASit (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 13:38:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1EEF3652F3;
        Mon,  1 Mar 2021 17:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1614620447;
        bh=g4NYwllxORSZLXi/icYWHkk91JyUS9XwgY8U0GnD5AI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s11f7Gv31GYbWTP8rV1zc+aLvfiSFovK9oBXCOBXv4NVRtZdY9y2cPmK+Hu+gcaKk
         oZIQyRU0EQ7qYVA1geyU1d5RxHD1uzX+OCxOdrzm4mv34viR1D1zkRfvqBWii0dzwq
         bJDooh8mPR1tbvTz2brDj5AOt6oGhYTE8qge4gtY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matt Merhar <mattmerhar@protonmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Thierry Reding <treding@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.11 156/775] ARM: tegra: ouya: Fix eMMC on specific bootloaders
Date:   Mon,  1 Mar 2021 17:05:24 +0100
Message-Id: <20210301161209.362842844@linuxfoundation.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210301161201.679371205@linuxfoundation.org>
References: <20210301161201.679371205@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Geis <pgwipeout@gmail.com>

[ Upstream commit 3029a563ac0ccd39b9dc53eadfb9c0e3fb57a449 ]

Ouya fails to detect the eMMC module when booted via certain bootloaders.
Fastboot and hard-kexec bootloaders fail while u-boot does not. It was
discovered that the issue manifests if the sdmmc4 alternate configuration
clock pin is input disabled.

Ouya uses sdmmc4 in the primary pin configuration. It is unknown why this
occurs, though it is likely related to other eMMC limitations experienced
on Ouya.

For now, fix it by enabling input on cam_mclk_pcc0.

Fixes: d7195ac5c9c5 ("ARM: tegra: Add device-tree for Ouya")
Reported-by: Matt Merhar <mattmerhar@protonmail.com>
Tested-by: Matt Merhar <mattmerhar@protonmail.com>
Signed-off-by: Peter Geis <pgwipeout@gmail.com>
Acked-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/tegra30-ouya.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30-ouya.dts b/arch/arm/boot/dts/tegra30-ouya.dts
index 74da1360d297c..0368b3b816ef2 100644
--- a/arch/arm/boot/dts/tegra30-ouya.dts
+++ b/arch/arm/boot/dts/tegra30-ouya.dts
@@ -4352,8 +4352,8 @@
 		nvidia,pins = "cam_mclk_pcc0";
 		nvidia,function = "vi_alt3";
 		nvidia,pull = <TEGRA_PIN_PULL_NONE>;
-		nvidia,tristate = <TEGRA_PIN_ENABLE>;
-		nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+		nvidia,tristate = <TEGRA_PIN_DISABLE>;
+		nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 	};
 	pcc1 {
 		nvidia,pins = "pcc1";
-- 
2.27.0



