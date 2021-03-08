Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0DC3308BC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 08:19:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235179AbhCHHTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 02:19:21 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:53770 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229704AbhCHHS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 02:18:58 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R841e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0UQr502d_1615187936;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UQr502d_1615187936)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 08 Mar 2021 15:18:56 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     perex@perex.cz
Cc:     tiwai@suse.com, rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com, Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] ASoC: bcm: add missing call to of_node_put()
Date:   Mon,  8 Mar 2021 15:18:54 +0800
Message-Id: <1615187934-39505-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In one of the error paths of the for_each_child_of_node() loop,
add missing call to of_node_put().

Fix the following coccicheck warning:
./sound/soc/bcm/cygnus-ssp.c:1346:1-33: WARNING: Function
"for_each_available_child_of_node" should have of_node_put() before
return around line 1352.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 sound/soc/bcm/cygnus-ssp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/bcm/cygnus-ssp.c b/sound/soc/bcm/cygnus-ssp.c
index 6e634b4..aa16a23 100644
--- a/sound/soc/bcm/cygnus-ssp.c
+++ b/sound/soc/bcm/cygnus-ssp.c
@@ -1348,8 +1348,10 @@ static int cygnus_ssp_probe(struct platform_device *pdev)
 					&cygnus_ssp_dai[active_port_count]);
 
 		/* negative is err, 0 is active and good, 1 is disabled */
-		if (err < 0)
+		if (err < 0) {
+			of_node_put(child_node);
 			return err;
+		}
 		else if (!err) {
 			dev_dbg(dev, "Activating DAI: %s\n",
 				cygnus_ssp_dai[active_port_count].name);
-- 
1.8.3.1

