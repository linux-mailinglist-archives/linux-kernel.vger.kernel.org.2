Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B26E365470
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 10:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbhDTIqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 04:46:09 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:33530 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbhDTIqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 04:46:07 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13K8j6lp025053;
        Tue, 20 Apr 2021 08:45:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=lRi5+pXSkvGHuYVuTVlpgKCbheDLoFERK+hwvLGTTm4=;
 b=rPGDywR2n/XgUYKjKiZzArVQCXQq7aQte3E1qE3AiRrvViVCuX/9lJ7ApStjxoQWtK3X
 fAaxJEriwG9CBx99zm1I3agaBwpAS1BPkaiDkuTNyXOxjX7bqSkrOn8Z0/J1Z99rE9Or
 5rg8u49KnQkJmyyK1GVvlimhCFldSi+3Ek8GcynT+L50vQ+RkyyCRMgpisU6bT8AUnz6
 r5jN+lIdohK8WdXh/kHV4QyOASbvjYXTnVa2byr2LleY7UUUsvJXcPi8qt6sLjSwWlQI
 sqHHH8mb/lZgT4OVgDL0W5XPcnl/pe+iXZDu/Asmr06GLM2WS73j5+LXDm2G3y9/ei5O KQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 37yqmnebth-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Apr 2021 08:45:06 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13K8bScF008096;
        Tue, 20 Apr 2021 08:45:05 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 3809es9jrn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Apr 2021 08:45:05 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 13K8fX8q021403;
        Tue, 20 Apr 2021 08:45:05 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 3809es9jq5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Apr 2021 08:45:05 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 13K8ixFD000725;
        Tue, 20 Apr 2021 08:45:00 GMT
Received: from mwanda (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 20 Apr 2021 01:44:59 -0700
Date:   Tue, 20 Apr 2021 11:44:51 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] mtd: rawnand: silence static checker warning in
 nand_setup_interface()
Message-ID: <YH6Ugwz3gcga+q8X@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-ORIG-GUID: FWLbufaOYH_RWGtVqbl2ylxaOcmejjKG
X-Proofpoint-GUID: FWLbufaOYH_RWGtVqbl2ylxaOcmejjKG
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9959 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 impostorscore=0 spamscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104200065
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Smatch complains that the error code is not set on this error path:

    drivers/mtd/nand/raw/nand_base.c:842 nand_setup_interface()
    warn: missing error code 'ret'

But actually returning success is intentional because the NAND chip will
still work in mode 0.  This patch adds a "ret = 0;" assignment to make
the intent more clear and to silence the static checker warning.  It
doesn't affect the compiled code because GCC optimises the assignment
away.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/mtd/nand/raw/nand_base.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index fb072c444495..e29e5b3d31bf 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -880,6 +880,7 @@ static int nand_setup_interface(struct nand_chip *chip, int chipnr)
 	if (tmode_param[0] != chip->best_interface_config->timings.mode) {
 		pr_warn("timing mode %d not acknowledged by the NAND chip\n",
 			chip->best_interface_config->timings.mode);
+		ret = 0;
 		goto err_reset_chip;
 	}
 
-- 
2.30.2

