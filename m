Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94DE6375C51
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 22:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbhEFUkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 16:40:20 -0400
Received: from smtp01.smtpout.orange.fr ([80.12.242.123]:48248 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbhEFUkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 16:40:17 -0400
Received: from localhost.localdomain ([86.243.172.93])
        by mwinf5d54 with ME
        id 1YfB2500N21Fzsu03YfCdl; Thu, 06 May 2021 22:39:16 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 06 May 2021 22:39:16 +0200
X-ME-IP: 86.243.172.93
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     gregkh@linuxfoundation.org, shubhankarvk@gmail.com,
        lee.jones@linaro.org, gustavoars@kernel.org, vulab@iscas.ac.cn,
        chunfeng.yun@mediatek.com, john453@faraday-tech.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] usb: fotg210-hcd: Fix an error message
Date:   Thu,  6 May 2021 22:39:10 +0200
Message-Id: <94531bcff98e46d4f9c20183a90b7f47f699126c.1620333419.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'retval' is known to be -ENODEV here.
This is a hard-coded default error code which is not useful in the error
message. Moreover, another error message is printed at the end of the
error handling path. The corresponding error code (-ENOMEM) is more
informative.

So remove simplify the first error message.

While at it, also remove the useless initialization of 'retval'.

Fixes: 7d50195f6c50 ("usb: host: Faraday fotg210-hcd driver")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/usb/host/fotg210-hcd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/fotg210-hcd.c b/drivers/usb/host/fotg210-hcd.c
index 6cac642520fc..9c2eda0918e1 100644
--- a/drivers/usb/host/fotg210-hcd.c
+++ b/drivers/usb/host/fotg210-hcd.c
@@ -5568,7 +5568,7 @@ static int fotg210_hcd_probe(struct platform_device *pdev)
 	struct usb_hcd *hcd;
 	struct resource *res;
 	int irq;
-	int retval = -ENODEV;
+	int retval;
 	struct fotg210_hcd *fotg210;
 
 	if (usb_disabled())
@@ -5588,7 +5588,7 @@ static int fotg210_hcd_probe(struct platform_device *pdev)
 	hcd = usb_create_hcd(&fotg210_fotg210_hc_driver, dev,
 			dev_name(dev));
 	if (!hcd) {
-		dev_err(dev, "failed to create hcd with err %d\n", retval);
+		dev_err(dev, "failed to create hcd\n");
 		retval = -ENOMEM;
 		goto fail_create_hcd;
 	}
-- 
2.30.2

