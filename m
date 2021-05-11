Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2241137A071
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 09:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbhEKHN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 03:13:56 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:33798 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbhEKHNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 03:13:52 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14B7CFOq074110;
        Tue, 11 May 2021 07:12:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=bOp/npdKBNjrpeNmwbAIxmkWgoyso0P/KtdS+cREOds=;
 b=NR72fIGab4jbE8+60ycDseDoxrEQLY91fjbrKHZGxfi8TGPo4i2RK1W+hGU03PX9Ckir
 S5WAMulPHNcmxWfk/chwLu+1GevlyoLYfS2QMUQ3fl34wjrEn07JpN8y4SonxV/J7IRc
 wqjWZ70fJimeS9ATznQiO021EHnUvgoGQ1+rTzc4/amQKAMfkrFuLZtRh62UCt18PNE0
 Lcz2PIXNQ2XDe1DvaFka3Z6Yka6LqRDzJaq74KNS2teZyYGa6GTiEK3hGuSwORexrxzp
 xMe8jzSxWJMTk4SStQ9bweaUK0dS1lzrnzLamdDRa/mbHu/P05q8i9dcpEQO8lAzx0tU 7Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 38dg5bdrfm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 May 2021 07:12:15 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14B79nvX051622;
        Tue, 11 May 2021 07:12:15 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3030.oracle.com with ESMTP id 38e5pwqmp5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 May 2021 07:12:15 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 14B7CE11060528;
        Tue, 11 May 2021 07:12:14 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 38e5pwqmnk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 May 2021 07:12:14 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 14B7C7Cj021104;
        Tue, 11 May 2021 07:12:12 GMT
Received: from mwanda (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 11 May 2021 00:12:07 -0700
Date:   Tue, 11 May 2021 10:12:00 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Richard Weinberger <richard@nod.at>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Artem Bityutskiy <Artem.Bityutskiy@nokia.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] ubifs: fix snprintf() checking
Message-ID: <YJouQKMQZe1I2kkg@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-GUID: 3wvVLYegYHyQAbTUgjskSeriImquWwta
X-Proofpoint-ORIG-GUID: 3wvVLYegYHyQAbTUgjskSeriImquWwta
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9980 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 malwarescore=0
 bulkscore=0 spamscore=0 clxscore=1011 priorityscore=1501 adultscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 impostorscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105110054
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The snprintf() function returns the number of characters (not
counting the NUL terminator) that it would have printed if we
had space.

This buffer has UBIFS_DFS_DIR_LEN characters plus one extra for
the terminator.  Printing UBIFS_DFS_DIR_LEN is okay but anything
higher will result in truncation.  Thus the comparison needs to be
change from == to >.

These strings are compile time constants so this patch doesn't
affect runtime.

Fixes: ae380ce04731 ("UBIFS: lessen the size of debugging info data structure")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/mtd/ubi/debug.c | 2 +-
 fs/ubifs/debug.c        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/ubi/debug.c b/drivers/mtd/ubi/debug.c
index ac2bdba8bb1a..3c0c8eca4d51 100644
--- a/drivers/mtd/ubi/debug.c
+++ b/drivers/mtd/ubi/debug.c
@@ -511,7 +511,7 @@ int ubi_debugfs_init_dev(struct ubi_device *ubi)
 
 	n = snprintf(d->dfs_dir_name, UBI_DFS_DIR_LEN + 1, UBI_DFS_DIR_NAME,
 		     ubi->ubi_num);
-	if (n == UBI_DFS_DIR_LEN) {
+	if (n > UBI_DFS_DIR_LEN) {
 		/* The array size is too small */
 		return -EINVAL;
 	}
diff --git a/fs/ubifs/debug.c b/fs/ubifs/debug.c
index 1bbb9fe661b1..fc718f6178f2 100644
--- a/fs/ubifs/debug.c
+++ b/fs/ubifs/debug.c
@@ -2824,7 +2824,7 @@ void dbg_debugfs_init_fs(struct ubifs_info *c)
 
 	n = snprintf(d->dfs_dir_name, UBIFS_DFS_DIR_LEN + 1, UBIFS_DFS_DIR_NAME,
 		     c->vi.ubi_num, c->vi.vol_id);
-	if (n == UBIFS_DFS_DIR_LEN) {
+	if (n > UBIFS_DFS_DIR_LEN) {
 		/* The array size is too small */
 		return;
 	}
-- 
2.30.2

