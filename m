Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 041B63780B2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 11:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbhEJJ7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 05:59:32 -0400
Received: from fgw23-7.mail.saunalahti.fi ([62.142.5.84]:21837 "EHLO
        fgw23-7.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230495AbhEJJ7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 05:59:25 -0400
Received: from localhost (88-115-248-186.elisa-laajakaista.fi [88.115.248.186])
        by fgw23.mail.saunalahti.fi (Halon) with ESMTP
        id 3c67ef0b-b176-11eb-8ccd-005056bdfda7;
        Mon, 10 May 2021 12:58:14 +0300 (EEST)
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcin Wojtas <mw@semihalf.com>,
        Russell King <linux@armlinux.org.uk>,
        Jakub Kicinski <kuba@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH net-next v1 4/4] net: mvpp2: Unshadow error code of device_property_read_u32()
Date:   Mon, 10 May 2021 12:58:08 +0300
Message-Id: <20210510095808.3302997-4-andy.shevchenko@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210510095808.3302997-1-andy.shevchenko@gmail.com>
References: <20210510095808.3302997-1-andy.shevchenko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

device_property_read_u32() may return different error codes.
Propagate it to the caller.

Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index b6b7ba891e71..9f464e44ae1b 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -7458,10 +7458,12 @@ static int mvpp2_probe(struct platform_device *pdev)
 
 		/* Get system's tclk rate */
 		priv->tclk = clk_get_rate(priv->pp_clk);
-	} else if (device_property_read_u32(&pdev->dev, "clock-frequency",
-					    &priv->tclk)) {
-		dev_err(&pdev->dev, "missing clock-frequency value\n");
-		return -EINVAL;
+	} else {
+		err = device_property_read_u32(&pdev->dev, "clock-frequency", &priv->tclk);
+		if (err) {
+			dev_err(&pdev->dev, "missing clock-frequency value\n");
+			return err;
+		}
 	}
 
 	if (priv->hw_version >= MVPP22) {
-- 
2.31.1

