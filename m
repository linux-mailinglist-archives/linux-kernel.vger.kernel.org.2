Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1DA3362210
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 16:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244626AbhDPOVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 10:21:13 -0400
Received: from mga05.intel.com ([192.55.52.43]:58573 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244572AbhDPOVG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 10:21:06 -0400
IronPort-SDR: cFbW7orWKL2rW5S2l9NzG+cukxfC0p9/gjPDXiKPx/txQ7AbrThf5lv4Zf3OJ42t3vCl1cYH3o
 G4myVGGOgBSg==
X-IronPort-AV: E=McAfee;i="6200,9189,9956"; a="280364116"
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="280364116"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2021 07:20:41 -0700
IronPort-SDR: B7Ib3nZkSHvV9A+S3y+55TbrrjAUe0wBDXBvsv5N1anIo+a7dYHaSg6HUm7bj65D/3U4205g+5
 DemFaL/Q9pbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="522722964"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 16 Apr 2021 07:20:30 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 14D9D12A; Fri, 16 Apr 2021 17:20:46 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 1/4] fbtft: Replace custom ->reset() with generic one
Date:   Fri, 16 Apr 2021 17:20:41 +0300
Message-Id: <20210416142044.17766-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The custom ->reset() repeats the generic one, replace it.

Note, in newer kernels the context of the function is a sleeping one,
it's fine to switch over to the sleeping functions. Keeping the reset
line asserted longer than 20 microseconds is also okay, it's an idling
state of the hardware.

Fixes: b2ebd4be6fa1 ("staging: fbtft: add fb_agm1264k-fl driver")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: new patch split from the bigger fix (Greg)
 drivers/staging/fbtft/fb_agm1264k-fl.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/staging/fbtft/fb_agm1264k-fl.c b/drivers/staging/fbtft/fb_agm1264k-fl.c
index eeeeec97ad27..4dfc22d05a40 100644
--- a/drivers/staging/fbtft/fb_agm1264k-fl.c
+++ b/drivers/staging/fbtft/fb_agm1264k-fl.c
@@ -77,19 +77,6 @@ static int init_display(struct fbtft_par *par)
 	return 0;
 }
 
-static void reset(struct fbtft_par *par)
-{
-	if (!par->gpio.reset)
-		return;
-
-	dev_dbg(par->info->device, "%s()\n", __func__);
-
-	gpiod_set_value(par->gpio.reset, 0);
-	udelay(20);
-	gpiod_set_value(par->gpio.reset, 1);
-	mdelay(120);
-}
-
 /* Check if all necessary GPIOS defined */
 static int verify_gpios(struct fbtft_par *par)
 {
@@ -439,7 +426,6 @@ static struct fbtft_display display = {
 		.set_addr_win = set_addr_win,
 		.verify_gpios = verify_gpios,
 		.request_gpios_match = request_gpios_match,
-		.reset = reset,
 		.write = write,
 		.write_register = write_reg8_bus8,
 		.write_vmem = write_vmem,
-- 
2.30.2

