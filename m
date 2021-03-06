Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7998532FB21
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 15:18:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbhCFORw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 09:17:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbhCFORX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 09:17:23 -0500
X-Greylist: delayed 185 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 06 Mar 2021 06:17:22 PST
Received: from mxe2.seznam.cz (mxe2.seznam.cz [IPv6:2a02:598:2::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E1BC06174A
        for <linux-kernel@vger.kernel.org>; Sat,  6 Mar 2021 06:17:22 -0800 (PST)
Received: from email.seznam.cz
        by email-smtpc22b.ng.seznam.cz (email-smtpc22b.ng.seznam.cz [10.23.18.29])
        id 27a239f60cab81f423fb2541;
        Sat, 06 Mar 2021 15:17:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seznam.cz; s=beta;
        t=1615040224; bh=6J8EgNHJnWziHVT9MNKzvy5L2WLLJqTPisB4qjoONwo=;
        h=Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
         Content-Transfer-Encoding;
        b=H6XmKMGcYckHAl257aQbrhf+yKNjP4st25FFg3d+7Zat83qAkz8so4txK/nzD+/nZ
         RcNpCCRlXt6XOsacQniY+1xuyxwB6keWr9Sk7LgsYLKLERIzmaIps0M35JJr+KfWDj
         KiygNIsUHTWqtijqSuUdZpOybP9hu3juGwnjFMvs=
Received: from linux.local (cst-prg-27-252.cust.vodafone.cz [46.135.27.252])
        by email-relay10.ng.seznam.cz (Seznam SMTPD 1.3.124) with ESMTP;
        Sat, 06 Mar 2021 15:13:35 +0100 (CET)  
From:   Giovanni Gherdovich <bobdc9664@seznam.cz>
To:     George Hilliard <thirtythreeforty@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Giovanni Gherdovich <bobdc9664@seznam.cz>,
        John Crispin <blogic@openwrt.org>,
        Neil Brown <neil@brown.name>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: ralink-gdma: Check return code of device_reset
Date:   Sat,  6 Mar 2021 15:13:22 +0100
Message-Id: <20210306141322.7516-1-bobdc9664@seznam.cz>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device_reset() function is marked as "__must_check", thus the static
analysis tool "sparse" complains that in ralink-gdma its return value is
ignored. Log a warning in case it returns an error.

Signed-off-by: Giovanni Gherdovich <bobdc9664@seznam.cz>
---
 drivers/staging/ralink-gdma/ralink-gdma.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/ralink-gdma/ralink-gdma.c b/drivers/staging/ralink-gdma/ralink-gdma.c
index 655df317d0ee..3c26b665ee7c 100644
--- a/drivers/staging/ralink-gdma/ralink-gdma.c
+++ b/drivers/staging/ralink-gdma/ralink-gdma.c
@@ -833,7 +833,9 @@ static int gdma_dma_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	device_reset(&pdev->dev);
+	ret = device_reset(&pdev->dev);
+	if (ret)
+		dev_err(&pdev->dev, "failed to reset: %d\n", ret);
 
 	dd = &dma_dev->ddev;
 	dma_cap_set(DMA_MEMCPY, dd->cap_mask);
-- 
2.26.2

