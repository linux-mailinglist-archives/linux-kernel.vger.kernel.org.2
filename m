Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11B9332206C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 20:46:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233030AbhBVTpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 14:45:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:55070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233276AbhBVTnk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 14:43:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0AC7964ECB;
        Mon, 22 Feb 2021 19:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614022941;
        bh=kI6a5fpPOoHyR23MS8XsVVO3TkRdhqh+1vmUgjHNL+s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KqcPh3/hotXpXBp4eFJKe8i7oC2W5DaNqDNwc2vXheVsls88r8PCXCLS9sFLNHHT0
         3vxCehq8WEZ3OmTwQdhsIKEFmWNGnDWj3wKiMY8cH2AbSlRONIe6rJrnqn0JeDBu4K
         CtdVZ+5t+OR+Yhe1tTkws/WhGrC45/+JOTEykwYhcH/P3kXpasJpSdXHwxVN3+a+j8
         h4bquHP+X9COVFZHGaAfwricJLFzzJJw3v6fvc1a9bw5iFcWEUMuqzhD8SwV/6vQWb
         9RIJBfsai6z8/VIopg0qSIAeP89ExvxSpHLaW4jN7J3FQJjLAM7+34AxkLDcLd0wGk
         gFmnhGXwdyPEQ==
Received: by pali.im (Postfix)
        id AB17D111B; Mon, 22 Feb 2021 20:42:18 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Gregory Clement <gregory.clement@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Cc:     =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Andre Heider <a.heider@gmail.com>,
        Vladimir Vid <vladimir.vid@sartura.hr>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        =?UTF-8?q?G=C3=A9rald=20Kerma?= <gerald@gk2.net>,
        Konstantin Porotchkin <kostap@marvell.com>
Subject: [PATCH mvebu v3 10/10] cpufreq: armada-37xx: Fix module unloading
Date:   Mon, 22 Feb 2021 20:41:58 +0100
Message-Id: <20210222194158.12342-11-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210222194158.12342-1-pali@kernel.org>
References: <20210114124032.12765-1-pali@kernel.org>
 <20210222194158.12342-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver is missing module_exit hook. Add proper driver exit function
which unregisters the platform device and cleans up the data.

Signed-off-by: Pali Rohár <pali@kernel.org>
Tested-by: Tomasz Maciej Nowak <tmn505@gmail.com>
Tested-by: Anders Trier Olesen <anders.trier.olesen@gmail.com>
Tested-by: Philip Soares <philips@netisense.com>
---
 drivers/cpufreq/armada-37xx-cpufreq.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/cpufreq/armada-37xx-cpufreq.c b/drivers/cpufreq/armada-37xx-cpufreq.c
index 050abff18308..3fc98a3ffd91 100644
--- a/drivers/cpufreq/armada-37xx-cpufreq.c
+++ b/drivers/cpufreq/armada-37xx-cpufreq.c
@@ -86,6 +86,8 @@ static int avs_map[] = {
 };
 
 struct armada37xx_cpufreq_state {
+	struct platform_device *pdev;
+	struct device *cpu_dev;
 	struct regmap *regmap;
 	u32 nb_l0l1;
 	u32 nb_l2l3;
@@ -506,6 +508,9 @@ static int __init armada37xx_cpufreq_driver_init(void)
 	if (ret)
 		goto disable_dvfs;
 
+	armada37xx_cpufreq_state->cpu_dev = cpu_dev;
+	armada37xx_cpufreq_state->pdev = pdev;
+	platform_set_drvdata(pdev, dvfs);
 	return 0;
 
 disable_dvfs:
@@ -524,6 +529,26 @@ static int __init armada37xx_cpufreq_driver_init(void)
 /* late_initcall, to guarantee the driver is loaded after A37xx clock driver */
 late_initcall(armada37xx_cpufreq_driver_init);
 
+static void __exit armada37xx_cpufreq_driver_exit(void)
+{
+	struct platform_device *pdev = armada37xx_cpufreq_state->pdev;
+	struct armada_37xx_dvfs *dvfs = platform_get_drvdata(pdev);
+	unsigned long freq;
+	int load_lvl;
+
+	platform_device_unregister(pdev);
+
+	armada37xx_cpufreq_disable_dvfs(armada37xx_cpufreq_state->regmap);
+
+	for (load_lvl = ARMADA_37XX_DVFS_LOAD_0; load_lvl < LOAD_LEVEL_NR; load_lvl++) {
+		freq = dvfs->cpu_freq_max / dvfs->divider[load_lvl];
+		dev_pm_opp_remove(armada37xx_cpufreq_state->cpu_dev, freq);
+	}
+
+	kfree(armada37xx_cpufreq_state);
+}
+module_exit(armada37xx_cpufreq_driver_exit);
+
 static const struct of_device_id __maybe_unused armada37xx_cpufreq_of_match[] = {
 	{ .compatible = "marvell,armada-3700-nb-pm" },
 	{ },
-- 
2.20.1

