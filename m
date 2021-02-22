Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83C1E322069
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 20:45:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233353AbhBVTo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 14:44:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:55064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233269AbhBVTnk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 14:43:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DA23664E6B;
        Mon, 22 Feb 2021 19:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614022941;
        bh=oWt7ErhnmfnnXaBPbupsHdZENFTiCLpTVx1ck7Qsfpw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gPMLgU/nLUABrP69uQotuxSpiaaahvz5H9FohqsR0NYr+7/wJ6s+BMEjLXLpU5eB9
         E4VDt+V6G9yBgqC96/f0IWcDiHe74FeIV7+0n/lJuS88DhFi+Pa4FsvFlKjNU1Nlm0
         U9clGFkod049ji/fmSpp82MYExRWbrnJct9tNtPMb31uQB2gkB6o6k//XksimwDUUI
         6UaSPqgp1q2B1lcDMGgqX5MlfR/iCTqRuO1WFwWbQah8YY0KSqClZFfRlWetIdAKIq
         yNdOua3MKl7bCmCAT+9uqxFrOJK/DrE+0VsKj5MwYUf1FVT1dxCepo1Xn+VmPNK7Hl
         S0hiPUKZN+bCA==
Received: by pali.im (Postfix)
        id 24DAD1034; Mon, 22 Feb 2021 20:42:18 +0100 (CET)
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
Subject: [PATCH mvebu v3 07/10] cpufreq: armada-37xx: Fix driver cleanup when registration failed
Date:   Mon, 22 Feb 2021 20:41:55 +0100
Message-Id: <20210222194158.12342-8-pali@kernel.org>
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

Commit 8db82563451f ("cpufreq: armada-37xx: fix frequency calculation for
opp") changed calculation of frequency passed to the dev_pm_opp_add()
function call. But the code for dev_pm_opp_remove() function call was not
updated, so the driver cleanup phase does not work when registration fails.

This fixes the issue by using the same frequency in both calls.

Signed-off-by: Pali Rohár <pali@kernel.org>
Tested-by: Tomasz Maciej Nowak <tmn505@gmail.com>
Tested-by: Anders Trier Olesen <anders.trier.olesen@gmail.com>
Tested-by: Philip Soares <philips@netisense.com>
Fixes: 8db82563451f ("cpufreq: armada-37xx: fix frequency calculation for opp")
Cc: stable@vger.kernel.org
---
 drivers/cpufreq/armada-37xx-cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/armada-37xx-cpufreq.c b/drivers/cpufreq/armada-37xx-cpufreq.c
index c7683d447b11..1ab2113daef5 100644
--- a/drivers/cpufreq/armada-37xx-cpufreq.c
+++ b/drivers/cpufreq/armada-37xx-cpufreq.c
@@ -521,7 +521,7 @@ static int __init armada37xx_cpufreq_driver_init(void)
 remove_opp:
 	/* clean-up the already added opp before leaving */
 	while (load_lvl-- > ARMADA_37XX_DVFS_LOAD_0) {
-		freq = cur_frequency / dvfs->divider[load_lvl];
+		freq = base_frequency / dvfs->divider[load_lvl];
 		dev_pm_opp_remove(cpu_dev, freq);
 	}
 
-- 
2.20.1

