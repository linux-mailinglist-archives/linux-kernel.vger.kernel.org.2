Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F06AF3D1217
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 17:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239729AbhGUOdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 10:33:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:60420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239627AbhGUOda (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 10:33:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F2EF6606A5;
        Wed, 21 Jul 2021 15:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626880447;
        bh=NrwxCLoURd1LdJnNYb7I+1LjEmcgSb+64PHqxxsUM4I=;
        h=From:To:Cc:Subject:Date:From;
        b=Ai94YkINIWn0q5DQOaZUuANgc0RtwanZUvEZVehbnCvj68tqPtZ723F0AqhaD39jr
         xLzgo/uUlrqeeq54MLgAgVaphpG+59NLHEoereK2n52MgBmstdnapJtWI97Pv/ShqF
         g3NkWIjvQztfURWxz3y7DCJSnjn4TTC9QEwiijo3lWwRBNCCoKuFlH65wHf39fFkwb
         6EDEwL81L3DyzCwaZe3/H9gd3hfSrKvSPf7wHb8PgnKYEBHB2YvnQWmP3eve1UQsj4
         wK5K0ssSd+R9edohGM9K2yc582prjkJPZd4fSr3ME6PzaBPe5bZifawkVBRZ3lBMO6
         EigtS73S9OqgQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: tegra: add regulator dependency
Date:   Wed, 21 Jul 2021 17:13:57 +0200
Message-Id: <20210721151403.2218211-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The two regulator drivers in the drivers/soc/ directory fail to build
when regulator support is disabled:

aarch64-linux-ld: drivers/soc/tegra/regulators-tegra20.o: in function `tegra20_regulator_reboot':
regulators-tegra20.c:(.text.tegra20_regulator_reboot+0x4c): undefined reference to `regulator_sync_voltage_rdev'
aarch64-linux-ld: regulators-tegra20.c:(.text.tegra20_regulator_reboot+0x58): undefined reference to `regulator_sync_voltage_rdev'
aarch64-linux-ld: drivers/soc/tegra/regulators-tegra30.o: in function `tegra30_regulator_reboot':
regulators-tegra30.c:(.text.tegra30_regulator_reboot+0x44): undefined reference to `regulator_sync_voltage_rdev'
aarch64-linux-ld: regulators-tegra30.c:(.text.tegra30_regulator_reboot+0x50): undefined reference to `regulator_sync_voltage_rdev'

Add a Kconfig dependency to avoid this configuration.

Fixes: 496747e7d907 ("soc/tegra: regulators: Add regulators coupler for Tegra20")
Fixes: 783807436f36 ("soc/tegra: regulators: Add regulators coupler for Tegra30")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/soc/tegra/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/soc/tegra/Kconfig b/drivers/soc/tegra/Kconfig
index db49075b1946..c56122be27a9 100644
--- a/drivers/soc/tegra/Kconfig
+++ b/drivers/soc/tegra/Kconfig
@@ -153,8 +153,10 @@ config SOC_TEGRA_POWERGATE_BPMP
 
 config SOC_TEGRA20_VOLTAGE_COUPLER
 	bool "Voltage scaling support for Tegra20 SoCs"
+	depends on REGULATOR
 	depends on ARCH_TEGRA_2x_SOC || COMPILE_TEST
 
 config SOC_TEGRA30_VOLTAGE_COUPLER
 	bool "Voltage scaling support for Tegra30 SoCs"
+	depends on REGULATOR
 	depends on ARCH_TEGRA_3x_SOC || COMPILE_TEST
-- 
2.29.2

