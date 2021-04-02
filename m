Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D999B3529C0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 12:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234963AbhDBK3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 06:29:21 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:57586 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234687AbhDBK3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 06:29:19 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R591e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UUET0lV_1617359346;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UUET0lV_1617359346)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 02 Apr 2021 18:29:07 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     mporter@kernel.crashing.org
Cc:     alex.bou9@gmail.com, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] rapidio/rio_cm: Remove an unused variable 'rc'
Date:   Fri,  2 Apr 2021 18:29:05 +0800
Message-Id: <1617359345-2404-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=n
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):
drivers/rapidio/rio_cm.c:673:7: warning: variable ‘rc’ set but not used

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/rapidio/rio_cm.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/rapidio/rio_cm.c b/drivers/rapidio/rio_cm.c
index 50ec53d..c6fd181 100644
--- a/drivers/rapidio/rio_cm.c
+++ b/drivers/rapidio/rio_cm.c
@@ -670,13 +670,12 @@ static void rio_txcq_handler(struct cm_dev *cm, int slot)
 	 */
 	if (!list_empty(&cm->tx_reqs) && (cm->tx_cnt < RIOCM_TX_RING_SIZE)) {
 		struct tx_req *req, *_req;
-		int rc;
 
 		list_for_each_entry_safe(req, _req, &cm->tx_reqs, node) {
 			list_del(&req->node);
 			cm->tx_buf[cm->tx_slot] = req->buffer;
-			rc = rio_add_outb_message(cm->mport, req->rdev, cmbox,
-						  req->buffer, req->len);
+			rio_add_outb_message(cm->mport, req->rdev, cmbox,
+					     req->buffer, req->len);
 			kfree(req->buffer);
 			kfree(req);
 
-- 
1.8.3.1

