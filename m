Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FDB33DB724
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 12:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238478AbhG3K2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 06:28:20 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:33818 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238274AbhG3K2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 06:28:16 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UhR-lKM_1627640887;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UhR-lKM_1627640887)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 30 Jul 2021 18:28:10 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     stuyoder@gmail.com
Cc:     laurentiu.tudor@nxp.com, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] bus: fsl-mc: make fsl_mc_bus_dpdbg_type static
Date:   Fri, 30 Jul 2021 18:28:01 +0800
Message-Id: <1627640881-16239-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This symbol is not used outside of fsl-mc-bus.c, so marks it static.

Fix the following sparse warning:

drivers/bus/fsl-mc/fsl-mc-bus.c:395:20: warning: symbol
'fsl_mc_bus_dpdbg_type' was not declared. Should it be static?

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/bus/fsl-mc/fsl-mc-bus.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index 6273f78..1fcc759 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -392,10 +392,9 @@ struct device_type fsl_mc_bus_dpdmai_type = {
 };
 EXPORT_SYMBOL_GPL(fsl_mc_bus_dpdmai_type);
 
-struct device_type fsl_mc_bus_dpdbg_type = {
+static struct device_type fsl_mc_bus_dpdbg_type = {
 	.name = "fsl_mc_bus_dpdbg"
 };
-EXPORT_SYMBOL_GPL(fsl_mc_bus_dpdbg_type);
 
 static struct device_type *fsl_mc_get_device_type(const char *type)
 {
-- 
1.8.3.1

