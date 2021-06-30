Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E20B3B8475
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 15:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236126AbhF3N41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 09:56:27 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:59022 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236109AbhF3Nwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 09:52:51 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15UDfXDh020892;
        Wed, 30 Jun 2021 13:50:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=gxvmoy9Dm0QHZAcllLD8c4qXIakvoZbI9zBILnD+bQ8=;
 b=dnZqc6Id2cZlUwwfSn8igWkZqYpITmLpvZWecXdIueSN+yvdN5z/Jf29+Bx/LIhvz3VM
 13hHTJvn7+O1K48sLkYzTnm26BByhLl21fRwF7OAFt2KnWqvLSlPUNfF1e0cByAQjEWz
 N40lZW03bOdyUQgvnsy5OlxzuL9/mylThedWF4KVE79r6saMBkwPqpIgF1Tu24lIHSJl
 xqWAoPyGqwsxs6n2IogRcQs5gHik7wX+2vlKGsPurdngHM+BZfAAsiprcebDI0qZUniM
 8m8ZdFCbDpr1ze9IncrPY97NiG8+Xiy0M/tQuM6jINLrLbsD7b49TBh498r8Q/ehFBo/ rw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 39gha4924c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Jun 2021 13:50:15 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15UDo4K8008838;
        Wed, 30 Jun 2021 13:50:13 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 39ee0x9ygt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Jun 2021 13:50:13 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 15UDo7Pk009175;
        Wed, 30 Jun 2021 13:50:07 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 39ee0x9y42-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Jun 2021 13:50:06 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0121.oracle.com (8.14.4/8.14.4) with ESMTP id 15UDnph9006288;
        Wed, 30 Jun 2021 13:49:52 GMT
Received: from mwanda (/102.222.70.252)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 30 Jun 2021 06:49:51 -0700
Date:   Wed, 30 Jun 2021 16:49:43 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Liam Beguin <lvb@xiphos.com>
Cc:     Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] clk: lmk04832: fix checks for allocation failure
Message-ID: <YNx2dyvB6MkVlsrl@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-ORIG-GUID: 7J7-hZDfLzB_7yS3cx_hlf0_RpupVvCF
X-Proofpoint-GUID: 7J7-hZDfLzB_7yS3cx_hlf0_RpupVvCF
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The devm_kcalloc() function returns NULL on error, it never returns
error pointers so these conditions need to be fixed.

Fixes: 3bc61cfd6f4a ("clk: add support for the lmk04832")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/clk/clk-lmk04832.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/clk-lmk04832.c b/drivers/clk/clk-lmk04832.c
index 0cd76e626c3d..66ad5cbe7029 100644
--- a/drivers/clk/clk-lmk04832.c
+++ b/drivers/clk/clk-lmk04832.c
@@ -1425,23 +1425,23 @@ static int lmk04832_probe(struct spi_device *spi)
 
 	lmk->dclk = devm_kcalloc(lmk->dev, info->num_channels >> 1,
 				 sizeof(struct lmk_dclk), GFP_KERNEL);
-	if (IS_ERR(lmk->dclk)) {
-		ret = PTR_ERR(lmk->dclk);
+	if (!lmk->dclk) {
+		ret = -ENOMEM;
 		goto err_disable_oscin;
 	}
 
 	lmk->clkout = devm_kcalloc(lmk->dev, info->num_channels,
 				   sizeof(*lmk->clkout), GFP_KERNEL);
-	if (IS_ERR(lmk->clkout)) {
-		ret = PTR_ERR(lmk->clkout);
+	if (!lmk->clkout) {
+		ret = -ENOMEM;
 		goto err_disable_oscin;
 	}
 
 	lmk->clk_data = devm_kzalloc(lmk->dev, struct_size(lmk->clk_data, hws,
 							   info->num_channels),
 				     GFP_KERNEL);
-	if (IS_ERR(lmk->clk_data)) {
-		ret = PTR_ERR(lmk->clk_data);
+	if (!lmk->clk_data) {
+		ret = -ENOMEM;
 		goto err_disable_oscin;
 	}
 
-- 
2.30.2

