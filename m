Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E808D34A738
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 13:30:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbhCZM3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 08:29:41 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:37024 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbhCZM3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 08:29:02 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12QCDuq3054633;
        Fri, 26 Mar 2021 12:28:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=L34Rx1F6HLO9QBVu5OH6foragy9rRs6PFAH5WpxP7ZU=;
 b=INd21cbVmhTYjj5b28Wh2iEIT8Uw7FaWd1vNhJiPTfjcoH/Hsg5R23lSvdpm6/e3fzMV
 Z0orEPlguTAOBpdYqRPnQGtuZwwCKPeSS2I/GPIXFF9EIBj91F2w6WsmCi9bPtlvrOxV
 qU7aBFiwP8XTTJWhDReNpifHo6jHW8dTjmr4HmfBB/nm/GT4mKp7hgZZ7zK62Kz7hlXC
 lKN5OjwFZimUkcfms4tnHoEjJlYW9Gen1A4q8YrloNdsLhicvm6WKTLg0rdQm1WbaK96
 qbZCoyNwWu+SjGN8CcS6ZSjTrcA3Glr8w0ytVjMP6c6zde5a891MvYJPFFu7FRX6wQTy Qg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 37h1421w9f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Mar 2021 12:28:58 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12QCAYOh189373;
        Fri, 26 Mar 2021 12:28:56 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 37h14n3dsp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Mar 2021 12:28:56 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 12QCSt2v003719;
        Fri, 26 Mar 2021 12:28:55 GMT
Received: from mwanda (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 26 Mar 2021 05:28:55 -0700
Date:   Fri, 26 Mar 2021 15:28:48 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] platform/surface: clean up a variable in surface_dtx_read()
Message-ID: <YF3TgCcpcCYl3a//@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9934 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 malwarescore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103250000 definitions=main-2103260093
X-Proofpoint-GUID: mD1bNPFzzB62i_GSnsDbqxl32biRC8Zq
X-Proofpoint-ORIG-GUID: mD1bNPFzzB62i_GSnsDbqxl32biRC8Zq
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9934 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 mlxscore=0
 clxscore=1011 impostorscore=0 spamscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 lowpriorityscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103250000
 definitions=main-2103260093
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "&client->ddev->lock" and "&ddev->lock" are the same thing.  Let's
use "&ddev->lock" consistently.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/platform/surface/surface_dtx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/surface/surface_dtx.c b/drivers/platform/surface/surface_dtx.c
index 1fedacf74050..63ce587e79e3 100644
--- a/drivers/platform/surface/surface_dtx.c
+++ b/drivers/platform/surface/surface_dtx.c
@@ -487,7 +487,7 @@ static ssize_t surface_dtx_read(struct file *file, char __user *buf, size_t coun
 			if (status < 0)
 				return status;
 
-			if (down_read_killable(&client->ddev->lock))
+			if (down_read_killable(&ddev->lock))
 				return -ERESTARTSYS;
 
 			/* Need to check that we're not shut down again. */
-- 
2.30.2

