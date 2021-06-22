Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BBDC3B057E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 15:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbhFVNLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 09:11:33 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:18576 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229786AbhFVNLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 09:11:32 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15MD7YWJ016699;
        Tue, 22 Jun 2021 13:09:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=nNGhc4wVJo2amK5VSNy7N7O6Kcp1UZjvj4FvRgNDlDU=;
 b=gVzJ8fnTUgU5WtWYj6Ff099RIDwila0KKyhfLqNc0q2DxEM5eXGFyfV01TY58zsX8C7N
 PLAV44lfsC2D7j5ODt1/pFd7vFDvl02RG7JAoi47mpP1jCmNbxgYTCVo+wVSkXev2+mX
 5AU2MZgPQNthPjnlISpg7QC/SKmohKsbZY2mGJ14mVw3EoiuCnK9KIUoP2MiLR66Mhxk
 s4IniOrM4ZiK3F9QB/XAManTAV6vs3m9U/EalzyCCjH4RtzZ2ZmH2W6rXPIDpyqHcUUo
 OgE2nyDXZY/jIvMA9aTLtW82nOtccJsOP3dtnA9gi8rt1EogPTNqehKZeqFRdlUY3mdy YQ== 
Received: from oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 39ap66k9va-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Jun 2021 13:09:02 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 15MD67RX147909;
        Tue, 22 Jun 2021 13:09:01 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 3998d7e3ax-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Jun 2021 13:09:01 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 15MD71pv151810;
        Tue, 22 Jun 2021 13:09:00 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 3998d7e3a8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Jun 2021 13:09:00 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 15MD8xKO009280;
        Tue, 22 Jun 2021 13:08:59 GMT
Received: from mwanda (/102.222.70.252)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 22 Jun 2021 06:08:59 -0700
Date:   Tue, 22 Jun 2021 16:08:52 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] mailbox: mtk-cmdq: Fix uninitialized variable in
 cmdq_mbox_flush()
Message-ID: <YNHg5NuJILrrBIZ/@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-ORIG-GUID: 8p3wwlkN12fs7dM7rr5b_8Wf51qeErBx
X-Proofpoint-GUID: 8p3wwlkN12fs7dM7rr5b_8Wf51qeErBx
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "cb" pointer needs to be initialized before can assign
"data.data = cb->data;".

Fixes: 4a3cb0303984 ("mailbox: mtk-cmdq: Use mailbox rx_callback")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/mailbox/mtk-cmdq-mailbox.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
index 301e65b9527a..67a42b514429 100644
--- a/drivers/mailbox/mtk-cmdq-mailbox.c
+++ b/drivers/mailbox/mtk-cmdq-mailbox.c
@@ -455,10 +455,10 @@ static int cmdq_mbox_flush(struct mbox_chan *chan, unsigned long timeout)
 
 	list_for_each_entry_safe(task, tmp, &thread->task_busy_list,
 				 list_entry) {
+		cb = &task->pkt->async_cb;
 		data.sta = -ECONNABORTED;
 		data.data = cb->data;
 		data.pkt = task->pkt;
-		cb = &task->pkt->async_cb;
 		if (cb->cb)
 			cb->cb(data);
 
-- 
2.30.2

