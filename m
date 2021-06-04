Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3569139B6F5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 12:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbhFDK0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 06:26:16 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:50221 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229625AbhFDK0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 06:26:15 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UbFNo8T_1622802255;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UbFNo8T_1622802255)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 04 Jun 2021 18:24:27 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     dan.j.williams@intel.com
Cc:     vishal.l.verma@intel.com, dave.jiang@intel.com,
        ira.weiny@intel.com, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] nvdimm: Fix missing error code in btt_read_pg()
Date:   Fri,  4 Jun 2021 18:24:09 +0800
Message-Id: <1622802249-45353-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we failed to get e_flag, the return value of btt_read_pg() is -EIO,
but when we failed to get t_flag, the return value of the btt_read_pg()
is '0' above. So We set ret to -EIO in this case.

Eliminate the follow smatch warning:

drivers/nvdimm/btt.c:1234 btt_read_pg() warn: missing error code 'ret'.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/nvdimm/btt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvdimm/btt.c b/drivers/nvdimm/btt.c
index 92dec49..44f5b666 100644
--- a/drivers/nvdimm/btt.c
+++ b/drivers/nvdimm/btt.c
@@ -1231,6 +1231,7 @@ static int btt_read_pg(struct btt *btt, struct bio_integrity_payload *bip,
 
 			if (t_flag) {
 				zero_fill_data(page, off, cur_len);
+				ret = -EIO;
 				goto out_lane;
 			}
 
-- 
1.8.3.1

