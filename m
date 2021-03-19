Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA8C2342015
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 15:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbhCSOrn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 10:47:43 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:43710 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbhCSOrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 10:47:18 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12JEaOTx135621;
        Fri, 19 Mar 2021 14:46:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=XNO61FOtBVkhZAr4aIEkfaV06YebUAqWlN4HB4v3cPQ=;
 b=dSr4+HP/s7HaUjw6k9kW0TrCt73vSpsQqvNjPKKwVjvDNfY3m6TyLuHaLkNcYv+/viLo
 CXhpDuwnhg9HhSPT553+MULe9Dz9xtX+DH6xxnBAr0AHjXs4j07eSDuVZQaUK3kyddgD
 dr2m0/RTz/AyByniU1w99zpavm3GKNh4x0wm0DLet9GO/5rXI2oC6OaznlRdcqDnLprv
 /juzqmepU/8j/hTBrxawvN3OKA2c7Io38vPOiEOL9H+/fMAO9/JCzKrRlx82Q8CSHVth
 UQe9bfAINdCuVOvbIUqWJh8uqNFlQ+0J7klb2d73QMufkf6dkK47eDJBDHeVd5nB3EOZ nw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 378p1p376a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Mar 2021 14:46:55 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12JEa6hS137011;
        Fri, 19 Mar 2021 14:46:53 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 37cf2vj35h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Mar 2021 14:46:53 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 12JEklC5009955;
        Fri, 19 Mar 2021 14:46:51 GMT
Received: from mwanda (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 19 Mar 2021 07:46:47 -0700
Date:   Fri, 19 Mar 2021 17:46:37 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] stm: class: dummy_stm: fix an error code in dummy_stm_init()
Message-ID: <YFS5TWHDqL7nIBEv@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9928 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 malwarescore=0
 spamscore=0 phishscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103190106
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9928 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 adultscore=0
 spamscore=0 clxscore=1011 phishscore=0 malwarescore=0 priorityscore=1501
 bulkscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103190106
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the kasprintf() allocation fails after the first iteration through
the loop then it returns success instead of -ENOMEM as intended.

Fixes: bcfdf8afdebe ("stm class: dummy_stm: Create multiple devices")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/hwtracing/stm/dummy_stm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/stm/dummy_stm.c b/drivers/hwtracing/stm/dummy_stm.c
index 38528ffdc0b3..36d32e7afb35 100644
--- a/drivers/hwtracing/stm/dummy_stm.c
+++ b/drivers/hwtracing/stm/dummy_stm.c
@@ -68,7 +68,7 @@ static int dummy_stm_link(struct stm_data *data, unsigned int master,
 
 static int dummy_stm_init(void)
 {
-	int i, ret = -ENOMEM;
+	int i, ret;
 
 	if (nr_dummies < 0 || nr_dummies > DUMMY_STM_MAX)
 		return -EINVAL;
@@ -80,8 +80,10 @@ static int dummy_stm_init(void)
 
 	for (i = 0; i < nr_dummies; i++) {
 		dummy_stm[i].name = kasprintf(GFP_KERNEL, "dummy_stm.%d", i);
-		if (!dummy_stm[i].name)
+		if (!dummy_stm[i].name) {
+			ret = -ENOMEM;
 			goto fail_unregister;
+		}
 
 		dummy_stm[i].sw_start		= master_min;
 		dummy_stm[i].sw_end		= master_max;
-- 
2.30.1

