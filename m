Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0865234A26D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 08:18:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbhCZHRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 03:17:47 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14148 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbhCZHRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 03:17:14 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F6CsB5TWVznWlK;
        Fri, 26 Mar 2021 15:14:38 +0800 (CST)
Received: from huawei.com (10.67.174.156) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.498.0; Fri, 26 Mar 2021
 15:17:01 +0800
From:   Lin Ruizhe <linruizhe@huawei.com>
To:     <mporter@kernel.crashing.org>, <alex.bou9@gmail.com>
CC:     <heying24@huawei.com>, <johnny.chenyi@huawei.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] driver/rapidio: Remove unused variable
Date:   Fri, 26 Mar 2021 15:16:58 +0800
Message-ID: <20210326071658.50107-1-linruizhe@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.156]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In function rio_txcq_handler the rc set but not used.
So we can delete this variable.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Lin Ruizhe <linruizhe@huawei.com>
---
 drivers/rapidio/rio_cm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/rapidio/rio_cm.c b/drivers/rapidio/rio_cm.c
index 50ec53d67a4c..f5525786abe6 100644
--- a/drivers/rapidio/rio_cm.c
+++ b/drivers/rapidio/rio_cm.c
@@ -670,12 +670,11 @@ static void rio_txcq_handler(struct cm_dev *cm, int slot)
 	 */
 	if (!list_empty(&cm->tx_reqs) && (cm->tx_cnt < RIOCM_TX_RING_SIZE)) {
 		struct tx_req *req, *_req;
-		int rc;
 
 		list_for_each_entry_safe(req, _req, &cm->tx_reqs, node) {
 			list_del(&req->node);
 			cm->tx_buf[cm->tx_slot] = req->buffer;
-			rc = rio_add_outb_message(cm->mport, req->rdev, cmbox,
+			(void)rio_add_outb_message(cm->mport, req->rdev, cmbox,
 						  req->buffer, req->len);
 			kfree(req->buffer);
 			kfree(req);
-- 
2.22.0

