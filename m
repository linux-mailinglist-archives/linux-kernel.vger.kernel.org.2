Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9183039720D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 13:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233698AbhFALIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 07:08:17 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:37350 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231219AbhFALIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 07:08:11 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0Uav8Pdd_1622545585;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0Uav8Pdd_1622545585)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 01 Jun 2021 19:06:29 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     axboe@kernel.dk
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] ata: libata-pmp: Fix missing error code in sata_pmp_eh_recover()
Date:   Tue,  1 Jun 2021 19:06:19 +0800
Message-Id: <1622545579-19345-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The error code is missing in this code scenario, add the error code
'-EINVAL' to the return value 'rc'.

Eliminate the follow smatch warning:

drivers/ata/libata-pmp.c:980 sata_pmp_eh_recover() warn: missing error
code 'rc'.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/ata/libata-pmp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/libata-pmp.c b/drivers/ata/libata-pmp.c
index ba7be3f..66985af 100644
--- a/drivers/ata/libata-pmp.c
+++ b/drivers/ata/libata-pmp.c
@@ -977,6 +977,7 @@ static int sata_pmp_eh_recover(struct ata_port *ap)
 			ata_link_warn(pmp_link,
 				"failed to disable NOTIFY (err_mask=0x%x)\n",
 				err_mask);
+			rc = -EINVAL;
 			goto pmp_fail;
 		}
 	}
-- 
1.8.3.1

