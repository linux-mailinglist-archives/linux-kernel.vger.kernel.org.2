Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5943F375C5C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 22:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbhEFUrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 16:47:04 -0400
Received: from smtp01.smtpout.orange.fr ([80.12.242.123]:53589 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbhEFUrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 16:47:03 -0400
Received: from localhost.localdomain ([86.243.172.93])
        by mwinf5d54 with ME
        id 1Ym32500121Fzsu03Ym3uY; Thu, 06 May 2021 22:46:04 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 06 May 2021 22:46:04 +0200
X-ME-IP: 86.243.172.93
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     ohad@wizery.com, bjorn.andersson@linaro.org,
        mathieu.poirier@linaro.org, s-anna@ti.com
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] remoteproc: k3-r5: Fix an error message
Date:   Thu,  6 May 2021 22:46:01 +0200
Message-Id: <d6e29d903b48957bf59c67229d54b0fc215e31ae.1620333870.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'ret' is known to be 0 here.
Reorder the code so that the expected error code is printed.

Fixes: 6dedbd1d5443 ("remoteproc: k3-r5: Add a remoteproc driver for R5F subsystem")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/remoteproc/ti_k3_r5_remoteproc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/remoteproc/ti_k3_r5_remoteproc.c b/drivers/remoteproc/ti_k3_r5_remoteproc.c
index 5cf8d030a1f0..4104e4846dbf 100644
--- a/drivers/remoteproc/ti_k3_r5_remoteproc.c
+++ b/drivers/remoteproc/ti_k3_r5_remoteproc.c
@@ -1272,9 +1272,9 @@ static int k3_r5_core_of_init(struct platform_device *pdev)
 
 	core->tsp = k3_r5_core_of_get_tsp(dev, core->ti_sci);
 	if (IS_ERR(core->tsp)) {
+		ret = PTR_ERR(core->tsp);
 		dev_err(dev, "failed to construct ti-sci proc control, ret = %d\n",
 			ret);
-		ret = PTR_ERR(core->tsp);
 		goto err;
 	}
 
-- 
2.30.2

