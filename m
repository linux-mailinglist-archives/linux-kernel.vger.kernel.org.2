Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55065455B7F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 13:26:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344665AbhKRM3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 07:29:54 -0500
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:35156 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344633AbhKRM3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 07:29:53 -0500
Received: from [79.2.93.196] (port=37114 helo=pc-ceresoli.dev.aim)
        by hostingweb31.netsons.net with esmtpa (Exim 4.94.2)
        (envelope-from <luca@lucaceresoli.net>)
        id 1mngVA-000AyO-7K; Thu, 18 Nov 2021 13:26:52 +0100
From:   Luca Ceresoli <luca@lucaceresoli.net>
To:     linux-kernel@vger.kernel.org
Cc:     Luca Ceresoli <luca@lucaceresoli.net>,
        Lee Jones <lee.jones@linaro.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] mfd: lp87565: fix error handling while getting reset GPIO
Date:   Thu, 18 Nov 2021 13:26:33 +0100
Message-Id: <20211118122633.6069-1-luca@lucaceresoli.net>
X-Mailer: git-send-email 2.34.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca+lucaceresoli.net/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If devm_gpiod_get_optional() returns an error the driver code just goes on,
soon using a pointer that holds an error. The only exception is
-EPROBE_DEFER which is correctly handled.

Fix and also simplify code by always calling dev_err_probe().

Fixes: 50e4d7a2a667 ("mfd: lp87565: Handle optional reset pin")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
---
 drivers/mfd/lp87565.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/mfd/lp87565.c b/drivers/mfd/lp87565.c
index a52ab76febb3..f5890ce9ac8f 100644
--- a/drivers/mfd/lp87565.c
+++ b/drivers/mfd/lp87565.c
@@ -67,11 +67,9 @@ static int lp87565_probe(struct i2c_client *client,
 
 	lp87565->reset_gpio = devm_gpiod_get_optional(lp87565->dev, "reset",
 						      GPIOD_OUT_LOW);
-	if (IS_ERR(lp87565->reset_gpio)) {
-		ret = PTR_ERR(lp87565->reset_gpio);
-		if (ret == -EPROBE_DEFER)
-			return ret;
-	}
+	if (IS_ERR(lp87565->reset_gpio))
+		return dev_err_probe(lp87565->dev, PTR_ERR(lp87565->reset_gpio),
+				     "Failed getting reset GPIO");
 
 	if (lp87565->reset_gpio) {
 		gpiod_set_value_cansleep(lp87565->reset_gpio, 1);
-- 
2.34.0

