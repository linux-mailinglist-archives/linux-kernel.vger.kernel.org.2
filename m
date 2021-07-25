Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE5873D4B7D
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jul 2021 06:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbhGYDos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jul 2021 23:44:48 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:51058 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229665AbhGYDor (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jul 2021 23:44:47 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4GXVMw2gk7zQ4;
        Sun, 25 Jul 2021 06:25:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1627187116; bh=n4tm9awV3n8UWCA4HHMvEDV8yXB7gzSUySmWHxD0+vs=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=DX3eQvrVT8ICox9QlqW7PUFy/rzo0ebRf53PlNHU6soL7KwQresQvwAGU27L/gHsj
         0G+nBF1seKdAXZJpcE1uKgjals/C3tK6IRWp6SZyjcvxTu2FXjLfUmjfJBsj3J6v2K
         KYRVf2h+rssZI4wGr3VSP03OUzOaQ5CPM/EOLNRr+xcy5Hpi/zUp6q4KMVqCN+B8V7
         xWly68niUwUnd4sybkhgONKpCaocVuxDpE9lqFoe/I6Q9V1f3nfOSlyGtvTex2beto
         wbOtg2gn8HfdgxpxbYoT7hEqICih/sTV6qy+F4C8hgVTdF5Y2lc+6oLZBfRa3HuyGi
         EsHK+QR9bHzTw==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.2 at mail
Date:   Sun, 25 Jul 2021 06:25:16 +0200
Message-Id: <2fea541c7e679dcda64b5a128bf8ff301fdf1af7.1627186831.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1627186831.git.mirq-linux@rere.qmqm.pl>
References: <cover.1627186831.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v3 1/5] mmc: sdhci: fix base clock usage in preset value
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Liu <kliu5@marvell.com>,
        Suneel Garapati <suneel.garapati@xilinx.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Michal Simek <michal.simek@xilinx.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed commit added an unnecessary read of CLOCK_CONTROL. The value read
is overwritten for programmable clock preset, but is carried over for
divided clock preset. This can confuse sdhci_enable_clk() if the register
has enable bits set for some reason at time time of clock calculation.
Remove the read.

Quoting Al Cooper:

sdhci_brcmstb_set_clock() assumed that sdhci_calc_clk() would always
return the divider value without the enable set, so this fixes a case
for DDR52 where the enable was not being cleared when the divider
value was changed.

Cc: stable@kernel.vger.org
Fixes: 52983382c74f ("mmc: sdhci: enhance preset value function")
Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Acked-by: Al Cooper <alcooperx@gmail.com>

---
v3: updated commit message
v2: removed truncated sentence from commitmsg

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/mmc/host/sdhci.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index aba6e10b8605..c7438dd13e3e 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1857,7 +1857,6 @@ u16 sdhci_calc_clk(struct sdhci_host *host, unsigned int clock,
 		if (host->preset_enabled) {
 			u16 pre_val;
 
-			clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
 			pre_val = sdhci_get_preset_value(host);
 			div = FIELD_GET(SDHCI_PRESET_SDCLK_FREQ_MASK, pre_val);
 			if (host->clk_mul &&
-- 
2.30.2

