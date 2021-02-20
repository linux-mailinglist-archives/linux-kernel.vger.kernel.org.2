Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 336EF3205B5
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Feb 2021 15:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbhBTObl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Feb 2021 09:31:41 -0500
Received: from smtp03.smtpout.orange.fr ([80.12.242.125]:45899 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbhBTObj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Feb 2021 09:31:39 -0500
Received: from localhost.localdomain ([90.126.17.6])
        by mwinf5d57 with ME
        id XSVv2400407rLVE03SVwi6; Sat, 20 Feb 2021 15:29:57 +0100
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 20 Feb 2021 15:29:57 +0100
X-ME-IP: 90.126.17.6
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     ulf.hansson@linaro.org, wsa+renesas@sang-engineering.com,
        yoshihiro.shimoda.uh@renesas.com, kernel@esmil.dk,
        dianders@chromium.org, yamada.masahiro@socionext.com,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 2/2] mmc: uniphier-sd: Fix a resource leak in the remove function
Date:   Sat, 20 Feb 2021 15:29:53 +0100
Message-Id: <20210220142953.918608-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A 'tmio_mmc_host_free()' call is missing in the remove function, in order
to balance a 'tmio_mmc_host_alloc()' call in the probe.
This is done in the error handling path of the probe, but not in the remove
function.

Add the missing call.

Fixes: 3fd784f745dd ("mmc: uniphier-sd: add UniPhier SD/eMMC controller driver")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/mmc/host/uniphier-sd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/uniphier-sd.c b/drivers/mmc/host/uniphier-sd.c
index 6f0f05466917..ccbf9885a52b 100644
--- a/drivers/mmc/host/uniphier-sd.c
+++ b/drivers/mmc/host/uniphier-sd.c
@@ -660,6 +660,7 @@ static int uniphier_sd_remove(struct platform_device *pdev)
 
 	tmio_mmc_host_remove(host);
 	uniphier_sd_clk_disable(host);
+	tmio_mmc_host_free(host);
 
 	return 0;
 }
-- 
2.27.0

