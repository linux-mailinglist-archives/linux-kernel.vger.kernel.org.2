Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB253499D7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 19:58:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbhCYS6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 14:58:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:38340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230106AbhCYS6G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 14:58:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4DFC3617ED;
        Thu, 25 Mar 2021 18:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616698686;
        bh=V8i1nTdRt1Uz7kSkKL6+utuHB72YqtcP7TDHOdswO9I=;
        h=From:To:Cc:Subject:Date:From;
        b=rIn+wgGdxVRjC8PgFaG04AFg8ZzorLICy8zOne7EqLGTHmrmW7vwlG4OO5az/Cthf
         uGy0dj6rvA0G2XX7tDgETsVbC3pAdBJHyozdf+FotjkTzaYXtcrclLI3hW+2tLI4x5
         ZCAx83ItgJ3wbidgmOQL6M6glxjUpxOyHqHMbGqDLoD2dWa7m85rfNmufV7iCmkw6S
         C6scREPJk8E1uIaFKSjFXcfjpIXZ96SvmpYC6iKMdk2ExYu/iDriN45mEDUnvjGuD7
         Qnnb0oqj5rTSDd7Yowd1sY5rRZ/Cnjyq8qff3z42j0L5NkAQ3uB3Kvr8gaI2gTc1Xm
         zW8mHDwDD3O8A==
From:   Nicolas Saenz Julienne <nsaenz@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>, Maxime Ripard <maxime@cerno.tech>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     linux-rpi-kernel@lists.infradead.org, geert@linux-m68k.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] clk: bcm: rpi: Don't register as OF provider if !dev->np
Date:   Thu, 25 Mar 2021 19:57:48 +0100
Message-Id: <20210325185749.27984-1-nsaenz@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two ways clk-raspberrypi might be registered: through
device-tree or through an explicit platform device registration. The
latter happens after firmware/raspberrypi's probe, and it's limited to
RPi3s, which solely use the ARM clock to scale CPU's frequency. That
clock is matched with cpu0's device thanks to the ARM clock being
registered as a clkdev.

In that scenario, don't register the device as an OF clock provider, as
it makes no sense and will cause trouble.

Fixes: d4b4f1b6b97e ("clk: bcm: rpi: Add DT provider for the clocks")
Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Nicolas Saenz Julienne <nsaenz@kernel.org>
---
 drivers/clk/bcm/clk-raspberrypi.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/bcm/clk-raspberrypi.c b/drivers/clk/bcm/clk-raspberrypi.c
index f89b9cfc4309..27e85687326f 100644
--- a/drivers/clk/bcm/clk-raspberrypi.c
+++ b/drivers/clk/bcm/clk-raspberrypi.c
@@ -337,10 +337,12 @@ static int raspberrypi_clk_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
-					  clk_data);
-	if (ret)
-		return ret;
+	if (dev->of_node) {
+		ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
+						  clk_data);
+		if (ret)
+			return ret;
+	}
 
 	rpi->cpufreq = platform_device_register_data(dev, "raspberrypi-cpufreq",
 						     -1, NULL, 0);
-- 
2.30.2

