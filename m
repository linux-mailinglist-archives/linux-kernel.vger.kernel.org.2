Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB42A30A796
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 13:28:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbhBAM1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 07:27:10 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:39792 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbhBAM1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 07:27:07 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 111CDSfV167612;
        Mon, 1 Feb 2021 12:26:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=aAmjmImhCIpBX3POrMnvrFA6jSIgT7kpj8DSiYY51Fc=;
 b=U78qmZBE7UsuLvLuJD8ykiPWRFzEV1g6BWUmnuVtp4Eof5B4drJOZCUzUtkG7prN2ftt
 oGq1aa23Wquu59k5cOwWB65eQgx2V5R56ReDc3KLzjAOHTIZ0pwwobmD+DOiGax+NVN7
 +Qvg1R8SrUKFaARYYiZarP7FlObjjD/YmGEWuTBS+TSAChkM+TukngdDCk+r1zxoObn0
 zuszXMaOgc86dBjR+O9MP89HBIKSlTNXuCrTsG4Catss+G7p8oM8osjqUcUxivdfkze/
 uV7ePQMVQcHp5J1ir/oU3ho04lRwbg77G1yViAqfW63p2vTxmTeBbfAGzam+vjZGrQNv 3w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 36cvyan4x3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Feb 2021 12:25:59 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 111CA7QM146822;
        Mon, 1 Feb 2021 12:25:57 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 36dh7pn4su-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Feb 2021 12:25:57 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 111CPuXb003418;
        Mon, 1 Feb 2021 12:25:56 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 36dh7pn4s8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Feb 2021 12:25:56 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 111CPq9q007836;
        Mon, 1 Feb 2021 12:25:52 GMT
Received: from mwanda (/10.175.186.133)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 01 Feb 2021 04:25:51 -0800
Date:   Mon, 1 Feb 2021 15:25:43 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Mark Fasheh <mark@fasheh.com>, Jiri Slaby <jirislaby@kernel.org>
Cc:     Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Jens Axboe <axboe@kernel.dk>, ocfs2-devel@oss.oracle.com,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] ocfs2: Fix a use after free on error
Message-ID: <YBfzR7AbZZ4Pp6sq@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9881 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011 impostorscore=0
 mlxscore=0 spamscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102010064
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The error handling in this function frees "reg" but it is still on the
"o2hb_all_regions" list so it will lead to a use after free.  The fix
for this is to only add it to the list after everything has succeeded.

Fixes: 1cf257f51191 ("ocfs2: fix memory leak")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
This is from static analysis and hasn't been tested.

 fs/ocfs2/cluster/heartbeat.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/ocfs2/cluster/heartbeat.c b/fs/ocfs2/cluster/heartbeat.c
index 0179a73a3fa2..92af4dc813e7 100644
--- a/fs/ocfs2/cluster/heartbeat.c
+++ b/fs/ocfs2/cluster/heartbeat.c
@@ -2025,7 +2025,6 @@ static struct config_item *o2hb_heartbeat_group_make_item(struct config_group *g
 		}
 		set_bit(reg->hr_region_num, o2hb_region_bitmap);
 	}
-	list_add_tail(&reg->hr_all_item, &o2hb_all_regions);
 	spin_unlock(&o2hb_live_lock);
 
 	config_item_init_type_name(&reg->hr_item, name, &o2hb_region_type);
@@ -2053,6 +2052,10 @@ static struct config_item *o2hb_heartbeat_group_make_item(struct config_group *g
 
 	o2hb_debug_region_init(reg, o2hb_debug_dir);
 
+	spin_lock(&o2hb_live_lock);
+	list_add_tail(&reg->hr_all_item, &o2hb_all_regions);
+	spin_unlock(&o2hb_live_lock);
+
 	return &reg->hr_item;
 
 unregister_handler:
-- 
2.29.2

